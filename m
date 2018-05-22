Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536651F51C
	for <e@80x24.org>; Tue, 22 May 2018 00:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeEVABe (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 20:01:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42351 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeEVABc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 20:01:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id p14-v6so7836117pfh.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJNf3EOCw5C3iQd4I97vLPgkhHv5wA344JNsX/udW3I=;
        b=illUDtMtf+fvFF/7jHe89dkDBGoa0+jFr+hVjdujN70bqDcXfMvBwaR0jtQryo0MY7
         xW6BvRZkOK55WxqO+qIqzzopN0tleEghULUWFi0pDBOUm83XhOWCca7EYLMci9MbreaU
         RaGTZCaWOcgQNrkJULWPSjveyFHjAuApwGzj1VGD/WG8S0hfNVtc3N7y5JtKG8trWF0A
         vx0YgDmhoUa+h2w1erxKE6qCtHF1t577yger64lBzi9Jx3GJD+4LNokIav4ZOxZu62Z/
         rPN6u2S+d9sx+PrNkiP4nj0xeLe7WT8T4LwEt0xW1uAQcxLbnOAGpKrlj8fXbMSi4ocT
         otRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJNf3EOCw5C3iQd4I97vLPgkhHv5wA344JNsX/udW3I=;
        b=qjLo4bEmbfdLxvd5RKMXQ0kHy6VzLEfpiFNIKrBmndLaw+4HPPD9mbo4gOf7zoBXQI
         XLYoTe431BkXo/oIGf0pLhmh29p/5IeOwa4MvBh5qj02k6ceqZTfgdoo23MgS1+TF+/p
         LuKreEI1QA4AUSuf+vy+MdGw/+MDhyEaeFE2Hg3rVplZhg2i+7vtxq51D9gizdTCk8cD
         BYR5m+hgECJSnHGuoNcTTfRvIaOGz1JXkR8uu/juGOsqKwgnM5yXpdaPb8fZessx524e
         gLhIEwVVuKP2V3lMa9KK53XaNKnBng/nuxXMMLRXVrSG4UUafJVREvHLBKAsH+OO7UuL
         IrEQ==
X-Gm-Message-State: ALKqPwfR5y6L5eoP0L93Dg5kZ878JVa7ZMlB+Shf9pt8VDynbC7FH7GK
        T7+SqfRF4gS0QHEBckxAIYB6/MUV
X-Google-Smtp-Source: AB8JxZr7l8tYCGG7x7b7O4718bsYhYmpNQInEMILJhBe8F+aZCZyHi9tWvCybCMPU3cPNdJIiHolTw==
X-Received: by 2002:a62:98cb:: with SMTP id d72-v6mr21788671pfk.98.1526947291935;
        Mon, 21 May 2018 17:01:31 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a11-v6sm21654025pgn.64.2018.05.21.17.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 17:01:31 -0700 (PDT)
Date:   Mon, 21 May 2018 17:01:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Anton Golubev <anton.golubev@gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: accept all encoding supported by curl
Message-ID: <20180522000129.GG10623@aiede.svl.corp.google.com>
References: <20180521234004.142548-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521234004.142548-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Subject: remote-curl: accept all encoding supported by curl

nit: s/encoding/encodings

> Configure curl to accept all encoding which curl supports instead of
> only accepting gzip responses.

Likewise.

> This is necessary to fix a bug when using an installation of curl which
> doesn't support gzip.  Since curl doesn't do any checking to verify that
> it supports the encoding set when calling 'curl_easy_setopt()', curl can
> end up sending an "Accept-Encoding" header indicating that it supports
> a particular encoding when in fact it doesn't.  Instead when the empty
> string "" is used when setting `CURLOPT_ENCODING`, curl will send an
> "Accept-Encoding" header containing only the encoding methods curl
> supports.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Thanks for the analysis and fix.

Reported-by: Anton Golubev <anton.golubev@gmail.com>

Also ccing the reporter so we can hopefully get a tested-by.  Anton,
can you test this patch and let us know how it goes?  You can apply it
as follows:

  curl \
    https://public-inbox.org/git/20180521234004.142548-1-bmwill@google.com/raw \
    >patch.txt
  git am -3 patch.txt

Brandon, can the commit message also say a little more about the
motivating context and symptoms?

  $ curl --version
  curl 7.52.1 (arm-openwrt-linux-gnu) libcurl/7.52.1 mbedTLS/2.6.0
  Protocols: file ftp ftps http https
  Features: IPv6 Largefile SSL

The issue is that when curl is built without the "zlib" feature, since
v1.8.0-rc0~14^2 (Enable info/refs gzip decompression in HTTP client,
2012-09-19) we end up requesting "gzip" encoding anyway despite
libcurl not being able to decode it.  Worse, instead of getting a
clear error message indicating so, we end up falling back to "dumb"
http, producing a confusing and difficult to debug result.

> ---
>  http.c                      | 2 +-
>  remote-curl.c               | 2 +-
>  t/t5551-http-fetch-smart.sh | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/http.c b/http.c
> index fed13b216..709150fc7 100644
> --- a/http.c
> +++ b/http.c
> @@ -1788,7 +1788,7 @@ static int http_request(const char *url,
>  
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
> -	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
> +	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>  
>  	ret = run_one_slot(slot, &results);
>  
> diff --git a/remote-curl.c b/remote-curl.c
> index ceb05347b..565bba104 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -684,7 +684,7 @@ static int post_rpc(struct rpc_state *rpc)
>  	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
>  	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
> -	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
> +	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>  
>  	if (large_request) {
>  		/* The request body is large and the size cannot be predicted.

Makes sense.

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f5721b4a5..39c65482c 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -26,14 +26,14 @@ setup_askpass_helper
>  cat >exp <<EOF
>  > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
>  > Accept: */*
> -> Accept-Encoding: gzip
> +> Accept-Encoding: deflate, gzip
>  > Pragma: no-cache
>  < HTTP/1.1 200 OK
>  < Pragma: no-cache
>  < Cache-Control: no-cache, max-age=0, must-revalidate
>  < Content-Type: application/x-git-upload-pack-advertisement
>  > POST /smart/repo.git/git-upload-pack HTTP/1.1
> -> Accept-Encoding: gzip
> +> Accept-Encoding: deflate, gzip
>  > Content-Type: application/x-git-upload-pack-request
>  > Accept: application/x-git-upload-pack-result
>  > Content-Length: xxx

If libcurl gains support for another encoding in the future, this test
would start failing.  Can we make the matching less strict?  For
example, how about something like the following for squashing in?

Thanks,
Jonathan

diff --git i/t/t5551-http-fetch-smart.sh w/t/t5551-http-fetch-smart.sh
index 39c65482ce..913089b144 100755
--- i/t/t5551-http-fetch-smart.sh
+++ w/t/t5551-http-fetch-smart.sh
@@ -26,14 +26,14 @@ setup_askpass_helper
 cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
-> Accept-Encoding: deflate, gzip
+> Accept-Encoding: ENCODINGS
 > Pragma: no-cache
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
-> Accept-Encoding: deflate, gzip
+> Accept-Encoding: ENCODINGS
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-result
 > Content-Length: xxx
@@ -79,8 +79,13 @@ test_expect_success 'clone http repository' '
 		/^< Date: /d
 		/^< Content-Length: /d
 		/^< Transfer-Encoding: /d
-	" >act &&
-	test_cmp exp act
+	" >actual &&
+	sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
+			actual >actual.smudged &&
+	test_cmp exp actual.smudged &&
+
+	grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
+	test_line_count = 2 actual.gzip
 '
 
 test_expect_success 'fetch changes via http' '
