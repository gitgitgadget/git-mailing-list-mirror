Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49411F51C
	for <e@80x24.org>; Tue, 22 May 2018 00:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeEVACQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 20:02:16 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33180 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeEVACP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 20:02:15 -0400
Received: by mail-yb0-f193.google.com with SMTP id t8-v6so4774070ybi.0
        for <git@vger.kernel.org>; Mon, 21 May 2018 17:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+m70aYdduPbgQEFAzumoq5w+UbHN/d0/pOGk2iEkUsc=;
        b=NRGi+Ok8wAlnbXncZkk12hyTbZEVyzv5jjZa5/S/F3pUqMNlr8ndEXc3WLHnO93P52
         AGz5O3MIoNYKHSl58LfhnPIEOxlqB4taKXl3Y1YDN2qYDAAULCvE7lK3iRdjw6vCSQo2
         /Ls2DJZXD3lUq5KjsGBAnoZ/86w6jeiud8DiDSXSKMkkh/QgojNElfWNtdwZl0ABfaQJ
         K+qq20b/OZadfhvR8exPqeFcehR2TBxQYpdv615u+yq6cRcUDgFPc/n0n2Ln5uNte6d7
         DOakSDjUgmVkfHbUbS9YYjXdHfeWctO0vgU5F14wEDjLIwnCCoFLgnhia/iclOlAb39P
         tnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+m70aYdduPbgQEFAzumoq5w+UbHN/d0/pOGk2iEkUsc=;
        b=KE0RaFb6HmxTKJPbt5655BvsPRLAaQ98Dj+G3xQabwOlQmaK5+5gopaxxUEUX1AaFh
         J3d1sO1SAJxDw2LtldDjkxpHoYL1/F1l2Kd4xYQFiGaquAeFmkLoNUiPURSHk9ThRTlq
         OkrvoBN3BYBIutVO8i08/hvtE/133Aj6WEx96CbGLyZBxbvqmnwE5xL6waRyeYzLTSRz
         CmICFYFRwVlccmh6aXFN1HRI3zwNadXpp1hTWY6sbslO50+TPaD3TlbmpiZS8GcB1Ti4
         lJdwTZrzYk5XQe81aMsvFd8fSlE5AQVX8msp81cpaNCvj4VqGCQD+9IqUgod4pBk2Wqy
         06Pg==
X-Gm-Message-State: ALKqPwfT4BEFE5rAVkHnjh/misPSur/H7czJ5VnX7IsbhJf7blpDVZGk
        8t7Qvead8CWcaN3cSU6O0k0QNr5FFqjwRGs93kYqxg==
X-Google-Smtp-Source: AB8JxZrkKobmQliCnheIqK20oPlm9eV42ep2Yrw7KjfW9lb7T0iotGF3aQ4WlcS1CfC/1XKYV4Dk1u4EeTs04bQcq+0=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr12772780ybc.307.1526947334131;
 Mon, 21 May 2018 17:02:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 17:02:13 -0700 (PDT)
In-Reply-To: <20180521234004.142548-1-bmwill@google.com>
References: <20180521234004.142548-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 17:02:13 -0700
Message-ID: <CAGZ79kZiyi_1nxvfLttD6HPyV66Wz3pLnuAe=L7FB9ak05dGAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: accept all encoding supported by curl
To:     Brandon Williams <bmwill@google.com>, daniel@haxx.se
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 4:40 PM, Brandon Williams <bmwill@google.com> wrote:
> Configure curl to accept all encoding which curl supports instead of
> only accepting gzip responses.

This partially reverts aa90b9697f9 (Enable info/refs gzip decompression
in HTTP client, 2012-09-19), as that specifically called out deflate not being
a good option. Is that worth mentioning in the commit message?

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
>         curl_easy_setopt(slot->curl, CURLOPT_URL, url);
>         curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
> -       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
> +       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>
>         ret = run_one_slot(slot, &results);
>
> diff --git a/remote-curl.c b/remote-curl.c
> index ceb05347b..565bba104 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -684,7 +684,7 @@ static int post_rpc(struct rpc_state *rpc)
>         curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
>         curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
>         curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
> -       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
> +       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");

Looking at the code here, this succeeds if enough memory is available.
There is no check if the given parameter is part of
Curl_all_content_encodings();
https://github.com/curl/curl/blob/e66cca046cef20d00fba89260dfa6b4a3997233d/lib/setopt.c#L429
https://github.com/curl/curl/blob/c675c40295045d4988eeb6291c54eb48f138822f/lib/content_encoding.c#L686

which may be worth checking first?

>
>         if (large_request) {
>                 /* The request body is large and the size cannot be predicted.
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
> --
> 2.17.0.441.gb46fe60e1d-goog
>
