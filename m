Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B3B1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbdDKKLC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:11:02 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34775 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbdDKKKI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:10:08 -0400
Received: by mail-io0-f180.google.com with SMTP id a103so64753775ioj.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IUSrfqNLCEHaWmSHesm+dTvp9Sz32VDF+XT3VzOarYI=;
        b=c/f0RxuPLaDJhQr9epcZSWpqgIh8HBTmY96dsfjNFuK2RfdhKNK1sqNuCEKKex/L0y
         2XeKD8nUENfi7CIji+PC37jH0R6Fznz8w3I526a9/8rSNbAetwRhOliOKeCbF+rEAK5q
         XsmQP5T/i+e5zkiql4tnbwfpzI6xPOHzUtBuVN3o8pVaB5zAZJ/NjoToMTgR5xWBFIll
         mDXBlZe7v0YvRdg0I2qY9NirCiH+HV8OfpJOiDPWsMOF8M1V3thrcNRgnC9D4iZ2LmKG
         Cvr/ixf+NBxqtzsWZA9oPwVnk2cjT73KyfaglWQ+j1eV0edFCbZrUHW/EXtc/OGsuZJu
         mcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IUSrfqNLCEHaWmSHesm+dTvp9Sz32VDF+XT3VzOarYI=;
        b=ioNec3QxXnmhFvQGPy3l+ETBTAA6oBirFSmP1XBZ5KuFLi0lZmDmpXwCzA9tONyTCt
         NPOA+q70LEOEla2bfzRBL/YU1gnpYSkFivHhIj2ya1BPIGLYytC1FWuM73Fq0Gg2VcP+
         Yrg9kJSaP4XRqipz6rg8BYrP7HJWH7wYrFPCbG8iDw12VwWt1i2x+s1douoLsq5Ri1XH
         n0ZxLsPgH7mGhrjXD89i/SCqHoQbn0vMwEs5wjTOMszH4ekXjQ0aWVjk92MzVL0tEzqR
         2HxLmGnSI/vPuMhxIbhqErzdwAfefgOhIjZz5pnaCztjMd0Mp1BhmyxBX4l8GQilRFfU
         vuwA==
X-Gm-Message-State: AFeK/H1zVvQDe6pfYbJwkKagd4tBaCrF3eZdf7vJR8rhLDnEoIWf1tg2XZ1rRC+yyzfgid6cYS8MyJmWU4Ac8g==
X-Received: by 10.107.150.201 with SMTP id y192mr62008081iod.33.1491905407639;
 Tue, 11 Apr 2017 03:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 03:09:46 -0700 (PDT)
In-Reply-To: <20170411092050.15867-1-ryazanov.s.a@gmail.com>
References: <20170411092050.15867-1-ryazanov.s.a@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 12:09:46 +0200
Message-ID: <CACBZZX4QfeiL7kB2+3pPbKjPGnQRXrGooQ-QrpgUtPnZRF=o8A@mail.gmail.com>
Subject: Re: [PATCH v2] http: honnor empty http.proxy option to bypass proxy
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since nobody pointed this out already, some grammar/spelling fixes.
Also CC-ing Knut who wrote the commit you're referencing.

- http: honnor empty http.proxy option to bypass proxy
+ http: honor empty http.proxy option to bypass proxy

On Tue, Apr 11, 2017 at 11:20 AM, Sergey Ryazanov
<ryazanov.s.a@gmail.com> wrote:
> Curl distinguish between empty proxy address and NULL proxy address. In


...distinguishes between an empty proxy address and a NULL proxy address...

> the first case it completly disable proxy usage, but if proxy address

it completely disables ... but if the proxy ....

> option is NULL then curl attempt to determine proxy address from

...attempts to determine the proxy ...

> http_proxy environment variable.

... the http_....


> According to documentation, if http.proxy configured to empty string
> then git should bypass proxy and connects to the server directly:

...to the documentation, if http_proxy is set to an empty string, git
should bypass the proxy and connect to the server directly.


>
>     export http_proxy=http://network-proxy/
>     cd ~/foobar-project
>     git config remote.origin.proxy ""
>     git fetch
>
> Previously, proxy host was configured by one line:
>
>     curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>
> Commit 372370f (http: use credential API to handle proxy auth...) parses
> proxy option, extracts proxy host address and additionaly updates curl
> configuration, which makes previous call a noop:

[Using the format we usually cite commits with, see SubmittingPatches]

Commit 372370f167 ("http: use credential API to handle proxy
authentication", 2016-01-26) parses the proxy option, then extracts
the proxy host address and updates the curl configuration, making the
previous call a noop.

>
>     credential_from_url(&proxy_auth, curl_http_proxy);
>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>
> But if proxy option is empty then proxy host field become NULL this
> force curl to fallback to proxy configuration detection from
> environment. This caused empty http.proxy option not working any more.

But if the proxy option is empty then the proxy host field becomes
NULL. This forces curl to fall back to detecting the proxy
configuration from the environment, causing the http.rpoxy option to
not work anymore.

>
> Fix this issue by explicitly handling empty http.proxy option. This also
> makes code a bit more clear and should help us avoid such regressions in
> the future.

Fix this issue by explicitly handling http.proxy being set to the
empty string. This also makes the code a ....

>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>
> Changes since v1:
>  - explicitly handle this case instead of mangling the common code
>
>  http.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index 96d84bb..8be75b2 100644
> --- a/http.c
> +++ b/http.c
> @@ -836,8 +836,14 @@ static CURL *get_curl_handle(void)
>                 }
>         }
>
> -       if (curl_http_proxy) {
> -               curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +       if (curl_http_proxy && curl_http_proxy[0] == '\0') {
> +               /*
> +                * Handle case with the empty http.proxy value here to keep
> +                * common code clean.
> +                * NB: empty option disables proxying at all.
> +                */
> +               curl_easy_setopt(result, CURLOPT_PROXY, "");
> +       } else if (curl_http_proxy) {
>  #if LIBCURL_VERSION_NUM >= 0x071800
>                 if (starts_with(curl_http_proxy, "socks5h"))
>                         curl_easy_setopt(result,
> --
> 2.10.2
>
