require 'faraday_middleware'

module Congress
  module Connection
    ENDPOINT = 'https://sunlight.countable.us'.freeze

  private

    def connection
      @connection ||= create_connection
    end

    def create_connection
      Faraday.new(:url => ENDPOINT) do |connection|
        middlewares.each { |middleware| connection.use(middleware) }
        connection.adapter(Faraday.default_adapter)
      end
    end

    def middlewares
      [Faraday::Request::UrlEncoded,
       Faraday::Response::RaiseError,
       Faraday::Response::Rashify,
       Faraday::Response::ParseJson]
    end
  end
end
