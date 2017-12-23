Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A1E1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756982AbdLWRsw (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 12:48:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39435 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdLWRsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 12:48:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id i11so26562336wmf.4
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 09:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2znR8di1KnwL+jPbAm46Sgh9wOWGgHRnfVe5R0iuUHg=;
        b=AaEqjqgzHzIhXrPACJHe9ZkWJR07rm9ubxZ/t1Xuqm0fPHqKMSjf8rickX6+G4ETJ6
         ZuWcLmnvtFKk8CfNhYTBFRJNEqzWvNGC7w9hotJtveS2ZA4oq4MLvaE+I5lh9ZguLtGM
         FDOceCEPOOHX8ZrCAA76MWGpTIESpklTkbWFtjn6U4FQbAbk1MGUlY7UNAG51whf0Mwk
         nAcgGMPRsqLMYwMUfm9dgC0C6Ui/kIw+RdHayRwDJ3ikMJQAUXGaOg/JlO3KmvsmBIgU
         oI3PynV2Ep2ZIh0bF3F08cnciMFIRgiBj4fpodQisHbxZruRPMJ/U/SYHs4w3hyX35nz
         hY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2znR8di1KnwL+jPbAm46Sgh9wOWGgHRnfVe5R0iuUHg=;
        b=JPae5R+Kyjs/BF+xlsw2fFeljqdlY4n6B/59Qn/JN2jUBi/9kNpf46he65jGPgxgVf
         E6bWShivaTCWduDx6OefYJ8ksj6aeV3Lzgo5rXpfgl7igDkEutkjVYzdL9A1T4tvAgTV
         AQ+n0GpjaCv9LAuGbKFcflDSQ/K4KQa7WjB6m5XcqSN/eexFIuouN+TXXd1heGvsYw4n
         smtf6M8csubCrEUpZ2YmEvpKiUZDIIz9/wAKHJ9JXvx+ZkoQ/6ZZqv/XxJUrvrkOJmiY
         wYIG0COFL1BEdPErUjvKIllgO3Lu3yNtDyoL3QmdkOcFczo9AHjqOklFFRlXzWlFCwjH
         rK4A==
X-Gm-Message-State: AKGB3mJN6OgCOx52f50S7WtE7bVEyRdauTUxUWQ85haWMAHZ3xB1GS58
        byt0raj/Ei8OTzVxmdec1yGak/8z
X-Google-Smtp-Source: ACJfBosUmbxwS9mZ+NZW49efms843qzvlw8LtJ6bvLr9DDlUqC32pm1NC6JylrVRAuIJvZjWXLOfjA==
X-Received: by 10.80.149.94 with SMTP id v30mr20116336eda.284.1514051329193;
        Sat, 23 Dec 2017 09:48:49 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id l50sm20504678eda.85.2017.12.23.09.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Dec 2017 09:48:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Wei Shuyu <wsy@dogben.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [RFC PATCH v2] http: support CURLPROXY_HTTPS
References: <20171223150215.8615-1-wsy@dogben.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171223150215.8615-1-wsy@dogben.com>
Date:   Sat, 23 Dec 2017 18:48:47 +0100
Message-ID: <878tdts5c0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 23 2017, Wei Shuyu jotted:

> Git has been taught to support an https:// used for http.proxy when
> using recent versions of libcurl.
>
> To use https proxy with self-signed certs, we need a way to
> unset CURLOPT_PROXY_SSL_VERIFYPEER and CURLOPT_PROXY_SSL_VERIFYHOST
> just like direct SSL connection. This is required if we want
> use t/lib-httpd to test proxy.
>
> In this patch I reuse http.sslverify to do this, do we need an
> independent option like http.sslproxyverify?
>
> To fully support https proxy, we also need ways to set more options
> such as CURLOPT_PROXY_SSLCERT. However, I'm not sure if we need to
> support them.

It would be good to add a link to
https://daniel.haxx.se/blog/2016/11/26/https-proxy-with-curl/ to the
commit message, since it explains in great detail what this is for and
how it compares to what we were doing before.

> Signed-off-by: Wei Shuyu <wsy@dogben.com>
> ---
>  http.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/http.c b/http.c
> index 215bebef1..d8a5e48f0 100644
> --- a/http.c
> +++ b/http.c
> @@ -708,6 +708,10 @@ static CURL *get_curl_handle(void)
>  	if (!curl_ssl_verify) {
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
> +#if LIBCURL_VERSION_NUM >= 0x073400
> +		curl_easy_setopt(result, CURLOPT_PROXY_SSL_VERIFYPEER, 0);
> +		curl_easy_setopt(result, CURLOPT_PROXY_SSL_VERIFYHOST, 0);
> +#endif
>  	} else {
>  		/* Verify authenticity of the peer's certificate */
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
> @@ -865,6 +869,11 @@ static CURL *get_curl_handle(void)
>  		else if (starts_with(curl_http_proxy, "socks"))
>  			curl_easy_setopt(result,
>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x073400
> +		else if (starts_with(curl_http_proxy, "https"))
> +			curl_easy_setopt(result,
> +				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
>  #endif
>  		if (strstr(curl_http_proxy, "://"))
>  			credential_from_url(&proxy_auth, curl_http_proxy);
