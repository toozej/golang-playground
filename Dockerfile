# builder image
FROM golang:buster AS build

WORKDIR /go/golang-playground/

COPY README.md go.mod* go.sum* ./

# uncomment next line when there are Go Modules present
# RUN go get -d -v

COPY . ./
RUN go test math/
RUN go build

# runtime image
FROM scratch
# Copy our static executable.
COPY --from=build /go/golang-playground/golang-playground /go/bin/golang-playground
# Run the binary.
ENTRYPOINT ["/go/bin/golang-playground"]


