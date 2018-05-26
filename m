Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4ADD1F51C
	for <e@80x24.org>; Sat, 26 May 2018 11:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031682AbeEZLIf (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 07:08:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34692 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031606AbeEZLId (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 07:08:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id q4-v6so17051823wmq.1
        for <git@vger.kernel.org>; Sat, 26 May 2018 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=CBg+a3OtTCkG3XwUEmcYH8oePEX/HfLPDS40+3tvqXM=;
        b=RQR3jcPqkANl8pSKKt0QYrBx7c5L+GWIDBoDcqs58qlmYGWRT8M2kmI7SDi+y9CcJ6
         psu/4zF/7gC9DqFxW7ILHenZLbdjxyXOdAuR6LoBrLFdCsHAcVY62iV1xAQCGBnQcflX
         Wg2AZwxmPBFUEk3nVHn1GS8zYv1UXpRzgpH5InLPHAvhx2GxZKKCDjSxqH6EEefsTcfU
         UTDbxSt8M2N4CoqO/D5YJEiQlo6ub6CoZo+aOuJ66uya7dYoB1uvCAjZVhuNb1JDng8L
         st7rcmC5GyONq15mrq7rdk5NlRl0/CCFTKn4otOylMB1YZw9wxn3WNG/CPzCgDwOySGx
         X5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=CBg+a3OtTCkG3XwUEmcYH8oePEX/HfLPDS40+3tvqXM=;
        b=ovqhIea4XEQJnFUVaThSe0DSkd5d0T1RWXEwHK83lsB4u6NU5Vfg4LupSL6V4FBcmj
         wN55JePR+y/NQ62nrEJQUEeklhFVAF97VplSDpsiOwXM7xcibG0OQqUM1+xUPe0S8wbF
         XS5F42+StACRJVTynMtlZbllyd3oTAAbWStt5yiHF9fsqtlrZSeQZaVkVW8xztID9XZL
         GasZkZm6wZoLFNXpQsTPdhh7I5ruO+asn8yogBj9oZ176cFFdBoOpDQc637qjjiqJKKh
         nIqBcQuF7POk0QNlFc/HDkkhJUqOYwGK+SVEju76/07YkttH09PJ14lcrj16+hqb0mew
         5m3Q==
X-Gm-Message-State: ALKqPwf1AJ7Q5OVmxmeRtpbmNcWZrgIixq4uFZLiud2Dd5znC+DKP4Zf
        IRsn6zs4GPtNo1Po3Vq9eSk=
X-Google-Smtp-Source: AB8JxZoT7qTaDYU2epVJxixCGuG6I5HtadsXOJ/OzX7gztpHI6m4xMMWyFEciqiodp4sZNu9jfmWnw==
X-Received: by 2002:a1c:b943:: with SMTP id j64-v6mr3758702wmf.30.1527332911386;
        Sat, 26 May 2018 04:08:31 -0700 (PDT)
Received: from Shuttle (HSI-KBW-078-042-095-098.hsi3.kabel-badenwuerttemberg.de. [78.42.95.98])
        by smtp.gmail.com with ESMTPSA id z2-v6sm9144478wmg.46.2018.05.26.04.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 04:08:30 -0700 (PDT)
From:   <anton.golubev@gmail.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>, "'Brandon Williams'" <bmwill@google.com>
References: <20180521234004.142548-1-bmwill@google.com> <20180522000129.GG10623@aiede.svl.corp.google.com>
In-Reply-To: <20180522000129.GG10623@aiede.svl.corp.google.com>
Subject: RE: [PATCH 1/2] remote-curl: accept all encoding supported by curl
Date:   Sat, 26 May 2018 13:08:29 +0200
Message-ID: <015501d3f4e1$e0b47c60$a21d7520$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIqYz3cefDSv3YjkzDKxQzMMC81UQEsK67Po4ubK7A=
Content-Language: de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

I'd like to confirm, that your patch fixes my problem: I can sync with
google repository now using git and curl version without gzip support. 
Do you know how this patch is going to be released? Just HEAD now and GA in
the next planned release?

Communication looks like follow now:

root@bsb:~# GIT_TRACE_PACKET=1 GIT_CURL_VERBOSE=1 git ls-remote
https://source.developers.google.co m/p/wired-balm-187912/r/dotfiles 2>&1 |
sed -e 's/\(git-[^=]*\)=.*/\1=REDACTED/' -e 's/Authorizatio n:
.*/Authorization: REDACTED/'
> GET /p/wired-balm-187912/r/dotfiles/info/refs?service=git-upload-pack
HTTP/1.1
Host: source.developers.google.com
User-Agent: git/2.17.0
Accept: */*
Accept-Encoding: identity
Cookie: o=git-anton.golubev.gmail.com=REDACTED
Pragma: no-cache

< HTTP/1.1 200 OK
< Cache-Control: no-cache, max-age=0, must-revalidate
< Content-Length: 374
< Content-Type: application/x-git-upload-pack-advertisement
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< X-Content-Type-Options: nosniff
< X-Frame-Options: SAMEORIGIN
< X-Xss-Protection: 1; mode=block
< Date: Sat, 26 May 2018 11:04:41 GMT
< Alt-Svc: hq=":443"; ma=2592000; quic=51303433; quic=51303432;
quic=51303431; quic=51303339; quic=51303335,quic=":443"; ma=2592000;
v="43,42,41,39,35"
<
13:04:41.274561 pkt-line.c:80           packet:          git< #
service=git-upload-pack
13:04:41.274634 pkt-line.c:80           packet:          git< 0000
13:04:41.274693 pkt-line.c:80           packet:          git<
45e2c99dd1790529cc4b7e029b1e9dfcc817d18e HEAD\0 include-tag
multi_ack_detailed multi_ack ofs-delta side-band side-band-64k thin-pack
no-progress shallow no-done allow-tip-sha1-in-want
allow-reachable-sha1-in-want agent=JGit/4-google filter
symref=HEAD:refs/heads/master
13:04:41.274739 pkt-line.c:80           packet:          git<
45e2c99dd1790529cc4b7e029b1e9dfcc817d18e refs/heads/master
13:04:41.274777 pkt-line.c:80           packet:          git< 0000
45e2c99dd1790529cc4b7e029b1e9dfcc817d18e        HEAD
45e2c99dd1790529cc4b7e029b1e9dfcc817d18e        refs/heads/master

Kind regards,
Anton Golubev



-----Original Message-----
From: Jonathan Nieder [mailto:jrnieder@gmail.com] 
Sent: Dienstag, 22. Mai 2018 02:01
To: Brandon Williams <bmwill@google.com>
Cc: git@vger.kernel.org; Anton Golubev <anton.golubev@gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: accept all encoding supported by curl

Hi,

Brandon Williams wrote:

> Subject: remote-curl: accept all encoding supported by curl

nit: s/encoding/encodings

> Configure curl to accept all encoding which curl supports instead of 
> only accepting gzip responses.

Likewise.

> This is necessary to fix a bug when using an installation of curl 
> which doesn't support gzip.  Since curl doesn't do any checking to 
> verify that it supports the encoding set when calling 
> 'curl_easy_setopt()', curl can end up sending an "Accept-Encoding" 
> header indicating that it supports a particular encoding when in fact 
> it doesn't.  Instead when the empty string "" is used when setting 
> `CURLOPT_ENCODING`, curl will send an "Accept-Encoding" header 
> containing only the encoding methods curl supports.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Thanks for the analysis and fix.

Reported-by: Anton Golubev <anton.golubev@gmail.com>

Also ccing the reporter so we can hopefully get a tested-by.  Anton, can you
test this patch and let us know how it goes?  You can apply it as follows:

  curl \
 
https://public-inbox.org/git/20180521234004.142548-1-bmwill@google.com/raw \
    >patch.txt
  git am -3 patch.txt

Brandon, can the commit message also say a little more about the motivating
context and symptoms?

  $ curl --version
  curl 7.52.1 (arm-openwrt-linux-gnu) libcurl/7.52.1 mbedTLS/2.6.0
  Protocols: file ftp ftps http https
  Features: IPv6 Largefile SSL

The issue is that when curl is built without the "zlib" feature, since
v1.8.0-rc0~14^2 (Enable info/refs gzip decompression in HTTP client,
2012-09-19) we end up requesting "gzip" encoding anyway despite libcurl not
being able to decode it.  Worse, instead of getting a clear error message
indicating so, we end up falling back to "dumb"
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
> diff --git a/remote-curl.c b/remote-curl.c index ceb05347b..565bba104 
> 100644
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
>  		/* The request body is large and the size cannot be
predicted.

Makes sense.

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh 
> index f5721b4a5..39c65482c 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -26,14 +26,14 @@ setup_askpass_helper  cat >exp <<EOF  > GET 
> /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1  > Accept: 
> */*
> -> Accept-Encoding: gzip
> +> Accept-Encoding: deflate, gzip
>  > Pragma: no-cache
>  < HTTP/1.1 200 OK
>  < Pragma: no-cache
>  < Cache-Control: no-cache, max-age=0, must-revalidate  < 
> Content-Type: application/x-git-upload-pack-advertisement
>  > POST /smart/repo.git/git-upload-pack HTTP/1.1
> -> Accept-Encoding: gzip
> +> Accept-Encoding: deflate, gzip
>  > Content-Type: application/x-git-upload-pack-request
>  > Accept: application/x-git-upload-pack-result
>  > Content-Length: xxx

If libcurl gains support for another encoding in the future, this test would
start failing.  Can we make the matching less strict?  For example, how
about something like the following for squashing in?

Thanks,
Jonathan

diff --git i/t/t5551-http-fetch-smart.sh w/t/t5551-http-fetch-smart.sh index
39c65482ce..913089b144 100755
--- i/t/t5551-http-fetch-smart.sh
+++ w/t/t5551-http-fetch-smart.sh
@@ -26,14 +26,14 @@ setup_askpass_helper  cat >exp <<EOF  > GET
/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1  > Accept: */*
-> Accept-Encoding: deflate, gzip
+> Accept-Encoding: ENCODINGS
 > Pragma: no-cache
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate  < Content-Type:
application/x-git-upload-pack-advertisement
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

