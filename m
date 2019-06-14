Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB7A1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 09:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfFNJxO (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 05:53:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53257 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNJxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 05:53:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so1670711wmj.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 02:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z99ki0oSgtyITW/ExU72YlOqNquiuRj8hchA9YpXtlU=;
        b=qThEhNlZuEOYKSu+iY/uXS2Ls40LutEBW+IucxRgfKc6+RuFNLphLV7cr9GrO7UmiQ
         FHZ+7AOa2KCC8wz/ZZ5a49fdlQAVglhWh1Mo8QOfK9M39naeUoLdB3Ca9J0GNURkxSCx
         tHNsA775CPzHXXX+DKKcJqrcX2kO2BMEC11eNzg162Xk82JLdJQ6y+PO+ueYdhiHi3wB
         v2XI5K0xN8i+oDjlOxrA61/CqEuorBgbo/HmTy7hs4TGvGfjOu7e745utE1H4o7o0ql+
         DtHroWsJiVinUYoeq6eVmf4Zk9F/8E3u7HjKt6dQJJTRbz1rqRx1pGCE8XVGPJw6A6WI
         VB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z99ki0oSgtyITW/ExU72YlOqNquiuRj8hchA9YpXtlU=;
        b=DWnpIfkgsyTLt06l5rGtJvgjRbMWD0KM8vkH/xbLs/506cGVCbtsYRRRM7LMPM6L5w
         rhgrf0reDsFFW+wDc/KEgQrd+HiZqBkwuDfsQe3yd8qtJaXi30L4exJGCOXWPfHFfs7W
         pS9PQCUS8V8EvITSZGpgAVi0iR+R0J3ZB//pHD+Mw8iGmuHF/fM4n/0VdTt/txRVkJfI
         OgmMiwNOmUZ0vrF6PBOEa8PNzDG+Yk/rWKy1+ukXLT18zijpHv0kqiuRaotUZLuqeY0R
         uSt1c+lgBu0kuF4HnQwo74mG5/17DaYOO0wJoGKfbo9MfrWj2YK/UOYjZ38hEh7fwvXm
         8a3g==
X-Gm-Message-State: APjAAAWWZ6blhDJuA10lFjqzS4bbEqLOO8/ViMOCzOEMNr4S3IIwl9bF
        vqWRsmfs88DjFdTKWgcK9zo=
X-Google-Smtp-Source: APXvYqzz2ishDoRZTaScSAfAxM2p06SiA3QvaWxeMB0oA9EEzZ9lIUWLeh6W/QwUse69lzErv6UFQg==
X-Received: by 2002:a1c:99c6:: with SMTP id b189mr7425939wme.57.1560505991671;
        Fri, 14 Jun 2019 02:53:11 -0700 (PDT)
Received: from szeder.dev (x4db35d93.dyn.telefonica.de. [77.179.93.147])
        by smtp.gmail.com with ESMTPSA id a10sm1934696wrx.17.2019.06.14.02.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 02:53:10 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:53:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] kwset: allow building with GCC 8
Message-ID: <20190614095308.GG31952@szeder.dev>
References: <pull.265.git.gitgitgadget@gmail.com>
 <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: Re: [PATCH 2/4] kwset: allow building with GCC 8

The subject could benefit from a "on Windows" at the end; 'kwset' and
compat/obstack can be build with GCC 8 and 9 just fine on some other
platforms.

On Thu, Jun 13, 2019 at 04:49:45AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The kwset functionality makes use of the obstack code, which expects to
> be handed a function that can allocate large chunks of data. It expects
> that function to accept a `size` parameter of type `long`.
> 
> This upsets GCC 8 on Windows, because `long` does not have the same
> bit size as `size_t` there.
> 
> Now, the proper thing to do would be to switch to `size_t`. But this
> would make us deviate from the "upstream" code even further,

This is not entirely true: upstream already uses 'size_t', so the
switch would actually bring our copy closer to upstream.

But look out for the patches that I'll send out in a minute...

> making it
> hard to synchronize with newer versions, and also it would be quite
> involved because that `long` type is so invasive in that code.
> 
> Let's punt, and instead provide a super small wrapper around
> `xmalloc()`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  kwset.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kwset.c b/kwset.c
> index 4fb6455aca..efc2ff41bc 100644
> --- a/kwset.c
> +++ b/kwset.c
> @@ -38,7 +38,13 @@
>  #include "compat/obstack.h"
>  
>  #define NCHAR (UCHAR_MAX + 1)
> -#define obstack_chunk_alloc xmalloc
> +/* adapter for `xmalloc()`, which takes `size_t`, not `long` */
> +static void *obstack_chunk_alloc(long size)
> +{
> +	if (size < 0)
> +		BUG("Cannot allocate a negative amount: %ld", size);
> +	return xmalloc(size);
> +}
>  #define obstack_chunk_free free
>  
>  #define U(c) ((unsigned char) (c))
> -- 
> gitgitgadget
> 
