Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7511F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeEVSs0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:48:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43796 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeEVSsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:48:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id j20-v6so9202484pff.10
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dr+FelI/TzpKlD++ptGio3D6hxLzBIjo2AbYChxnCL8=;
        b=KRasFwmXi5kPINOKvFXiqVvzqUOHBkfUiHMOTX6RQx3sUJEEIzizVHHDMsvUUzV5bu
         hNdif+HJwnUTVf4khefEPtsfoPEPujZY8dtr5nAhthAa8L6HBgA+1qhmz+W1+f9hPYJV
         E07T1uBG1iy82IWFzIKQ9WhE1RMhFOMvoEoqN05BymIAUSilmmkRi7pAwm+TlJPThlB0
         gev20UcBjhGgvqcS4qkOXKwxua9OyChS0WPV4X+L8S0CbhSIwMpdazmfEABOtgV4/e18
         fzCROyhDRn/U576UZXE65AJFc+fEkmDck4oiRsOMTHXRzvgD+zfA0XTGx11wDrFHXOk+
         QglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dr+FelI/TzpKlD++ptGio3D6hxLzBIjo2AbYChxnCL8=;
        b=n2AMCSyielUmo1YVJJcX5wxl104CojmRz+6odgoVY3Ykvl3tJQi5mJN/mqAHw1gfLV
         0e79IYOj8SatdigbgMOstcOR8wSeMsVgjqPz+unwXB24UGuRP4ujbGMH1Sc5wyWSGBJu
         X/MOtIabRF1pa+eCd1ydC4poTh9K4lFHeYMscBx2hdqT3VojU/bDfyGljFSnYHUBe1ff
         n9jXY1XczAiYod41dMXn948xvS7gaTqwDTEdkI1gmM1aLhoDLbmpRYYYbrZxEfrLg8k/
         6X75cuuv5YyN+qsOB85tHeQVWzIAKglat6NkKaJ/nQ2E+Ijs8PhtYOnFCtQ+ZHTJEqSm
         I3+w==
X-Gm-Message-State: ALKqPwfPhBcFKFvw5hk/HOhPCohIeAB4M/tosjkvKDuz8EzMyfR75RZ3
        9fz5ToAuM/lTVrVMhf1xrZ0=
X-Google-Smtp-Source: AB8JxZpHejKBh1cXtUTuL8sJ9jwnppCocNWM0QI0yxaonF1Hpr/0+58zFWTC8PJzYiE+3ZMnOTqMmA==
X-Received: by 2002:a65:4dca:: with SMTP id q10-v6mr20051273pgt.22.1527014903956;
        Tue, 22 May 2018 11:48:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e12-v6sm3583779pgs.42.2018.05.22.11.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 11:48:23 -0700 (PDT)
Date:   Tue, 22 May 2018 11:48:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Anton Golubev <anton.golubev@gmail.com>
Subject: Re: [PATCH v2 1/2] remote-curl: accept all encodings supported by
 curl
Message-ID: <20180522184821.GL10623@aiede.svl.corp.google.com>
References: <20180521234004.142548-1-bmwill@google.com>
 <20180522184204.47332-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522184204.47332-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Configure curl to accept all encodings which curl supports instead of
> only accepting gzip responses.
>
> This fixes an issue when using an installation of curl which is built
> without the "zlib" feature. Since aa90b9697 (Enable info/refs gzip
> decompression in HTTP client, 2012-09-19) we end up requesting "gzip"
> encoding anyway despite libcurl not being able to decode it.  Worse,
> instead of getting a clear error message indicating so, we end up
> falling back to "dumb" http, producing a confusing and difficult to
> debug result.
>
> Since curl doesn't do any checking to verify that it supports the a
> requested encoding, instead set the curl option `CURLOPT_ENCODING` with
> an empty string indicating that curl should send an "Accept-Encoding"
> header containing only the encodings supported by curl.

Even better, this means we get the benefit of future of even better
compression algorithms once libcurl learns them.

> Reported-by: Anton Golubev <anton.golubev@gmail.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> Version 2 of this series just tweaks the commit message and the test per
> Jonathan's suggestion.
>
>  http.c                      |  2 +-
>  remote-curl.c               |  2 +-
>  t/t5551-http-fetch-smart.sh | 13 +++++++++----
>  3 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for fixing it.

Patch left unsnipped for reference.

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
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f5721b4a5..913089b14 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -26,14 +26,14 @@ setup_askpass_helper
>  cat >exp <<EOF
>  > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
>  > Accept: */*
> -> Accept-Encoding: gzip
> +> Accept-Encoding: ENCODINGS
>  > Pragma: no-cache
>  < HTTP/1.1 200 OK
>  < Pragma: no-cache
>  < Cache-Control: no-cache, max-age=0, must-revalidate
>  < Content-Type: application/x-git-upload-pack-advertisement
>  > POST /smart/repo.git/git-upload-pack HTTP/1.1
> -> Accept-Encoding: gzip
> +> Accept-Encoding: ENCODINGS
>  > Content-Type: application/x-git-upload-pack-request
>  > Accept: application/x-git-upload-pack-result
>  > Content-Length: xxx
> @@ -79,8 +79,13 @@ test_expect_success 'clone http repository' '
>  		/^< Date: /d
>  		/^< Content-Length: /d
>  		/^< Transfer-Encoding: /d
> -	" >act &&
> -	test_cmp exp act
> +	" >actual &&
> +	sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
> +			actual >actual.smudged &&
> +	test_cmp exp actual.smudged &&
> +
> +	grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
> +	test_line_count = 2 actual.gzip
>  '
>  
>  test_expect_success 'fetch changes via http' '
