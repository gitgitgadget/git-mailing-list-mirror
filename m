Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3501F406
	for <e@80x24.org>; Tue, 19 Dec 2017 20:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbdLSU7m (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 15:59:42 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:47072 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdLSU7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 15:59:41 -0500
Received: by mail-pl0-f66.google.com with SMTP id i6so7716142plt.13
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 12:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RHurwBHg4CNqFpbJH1oVA4pQWBnmraSdhHa/PyO7B3w=;
        b=YplZAK/F5jzNXozFJ3kPFfEyopZ2z8oibzPnIuRiDMPFKn6oJrCWb+Xx6kkR11u7I+
         en4Fuyro2NJQVyt4MwXKLZJUXi4Z8H5n0dluqnnGKdOYV9RUyBtSUZtNxPuEm083M1wu
         RvWmoqMKxCit4BAwMqngBLt499cREu050aJ64TBKaFozXsJLxO8CpM25pumbaJvVmbWo
         uZB27t4zEMK10ImSessPPOvtyvbrECK3XwhQrwg8YaEl4aulzRqEsaG+bPfjF9BkgI5T
         YRrLkP7MEum7UH1dysERqrgdCAudk8yjh74IvusF6PLmFjIgJ3Ze1mbIFMpwlJGhLFZh
         bZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RHurwBHg4CNqFpbJH1oVA4pQWBnmraSdhHa/PyO7B3w=;
        b=IxY3rDs+xUGsXxj1cbYevpdLTUkEdAu5ujU56yL6oD1dTxfMbVknlDPcU00wy6gvLh
         PHNn1fVlckZ8whneZGONE1vOVlhRTUZ19op31BIKJc8vsgborB1TgyzBBdv28Mc0YHAj
         q/aFl6DfRxO4M/ggffIAU0aIn6S37n8PdHiVFxjb7DOKSYAehgJjKZXkPQljmDYT2Os9
         /BwRf99KlD4h12mKO9t76Iry0hmqnpoJAUSIIE6XwnHPOYtZtS0W1b35qz14yEunspdf
         GAHCsUHjMgpsmUDI5geZ5ao2+7EXdyzmOKbWB3sXfqwPQoK3PDWl1dQbidND/qW51bRI
         01kw==
X-Gm-Message-State: AKGB3mJKdh1F1ywLh5EOi6Wzp4Icxi7YKaU6GhA/UCWYbgiLwonJj+GE
        PmXOPueQRiaPdgDPMkocbxlINRI+
X-Google-Smtp-Source: ACJfBos5BdQHS9YFvmT24WryAIbb6MHfLIhGN2krDYdCOIzY+8hFIcu1gaSBKieTBQiUZh2uq3pdGw==
X-Received: by 10.159.195.69 with SMTP id z5mr4545746pln.180.1513717180723;
        Tue, 19 Dec 2017 12:59:40 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y7sm30905220pfy.96.2017.12.19.12.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 12:59:40 -0800 (PST)
Date:   Tue, 19 Dec 2017 12:59:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Wei Shuyu <wsy@dogben.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: support CURLPROXY_HTTPS
Message-ID: <20171219205807.GC240141@aiede.mtv.corp.google.com>
References: <20171219172401.5263-1-wsy@dogben.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219172401.5263-1-wsy@dogben.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Wei Shuyu wrote:

> HTTP proxy over SSL is supported by curl since 7.52.0.
> This is very useful for networks with protocol whitelist.
>
> Signed-off-by: Wei Shuyu <wsy@dogben.com>
> ---
>  http.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks for writing this.  Can you give an example of how I'd use it
(ideally in the form of a test in t/ so we avoid this functionality
regressing, but if that's not straightforward then an example for the
commit message is fine as well)?

> diff --git a/http.c b/http.c
> index 215bebef1..32d33261c 100644
> --- a/http.c
> +++ b/http.c
> @@ -865,6 +865,11 @@ static CURL *get_curl_handle(void)
>  		else if (starts_with(curl_http_proxy, "socks"))
>  			curl_easy_setopt(result,
>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x073400

Can this use #ifdef CURLPROXY_HTTPS instead?  That way, if someone's
copy of curl has backported support then they get the benefit of this
change as well.

> +		else if (starts_with(curl_http_proxy, "https"))
> +			curl_easy_setopt(result,
> +				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
>  #endif
>  		if (strstr(curl_http_proxy, "://"))
>  			credential_from_url(&proxy_auth, curl_http_proxy);

Thanks and hope that helps,
Jonathan
