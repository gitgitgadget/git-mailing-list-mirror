Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4351F406
	for <e@80x24.org>; Fri, 22 Dec 2017 17:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756131AbdLVRQk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 12:16:40 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:42971 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755826AbdLVRQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 12:16:38 -0500
Received: by mail-it0-f68.google.com with SMTP id p139so15057864itb.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/40wIyNqWZNq8Lm/6sRHolpQAEdgrWHt1OFBVs1MHg=;
        b=eQgYir2CMSfrNKDX6Ghd5CIpRhetezF85/tyJ6isrSe4PjGKMyHEzz4qnZKHF/1K13
         MuT0KHZlRRm7Mtrrn5WQc1mY0RV3idzdPUHJ3hYDTYHjIxrJbPepF6zAVD5y0C71GmgY
         sNWWSaRG5zb4tp9aOa58jcvOtnqx+OtFO/5867j9Jetv93lnLwboB3fE3wAN3q2D8I6/
         ga4h+ZejtZh3lxhEAMAHze1byG5Bh9X2jduNmuPHf7OxLtM+3VoD81cAp1XEYXbjvSvB
         9CsMAMMqmtK4f0GTTl5gN/2PKCba0cDbqFqeU/83Ek4ofM8kGqzxXuAp3rXGDWpzp4E3
         L3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/40wIyNqWZNq8Lm/6sRHolpQAEdgrWHt1OFBVs1MHg=;
        b=kVb/gw/j6M61Vq/2inD5IU4Zf6RVjWge2tnk+7d7QuwSScDuKoAmhkkn2TkYlhUw+Z
         F9kRsN1aXZusfI5hLiLnpQWq2JtBvrXZu8wB9FTi0AibWDhRbf71UHuEpxFGJXN055eq
         MY2jyyZYFpBWhjG6E7EDNnd5nOEeCpygwmceH4lIwMEXFcWhXcvHgD2S6piyBIcuJ2oH
         /gN51oWj7L16nWYnrfHoaDF8cD3gLIY0jeG4jCDUymlb87Hg1hgfyuYjytgoXiHJ+O2f
         XcFjS8/b0xnaZQfEY3PZrqoPP2ncyqwVDWBhFtpGdk0kf9tLwugpRvbitVWMXi6nfboy
         YikQ==
X-Gm-Message-State: AKGB3mLsMTbr0lJsHJF+/1nHs1v6VP3sfDtQdyMcmpcy/r/Pv9ezgWqn
        3hvFhrEYaFhPujOqCZ1C3XxLGON1zQ4=
X-Google-Smtp-Source: ACJfBouTMU83gkrBlpG2ogf00HkJJyMqGj43MV9VYP2WQKd9a9KaZNVLmsnkBuaUnyqJUd9+AAZepQ==
X-Received: by 10.36.29.72 with SMTP id 69mr19181818itj.147.1513962997804;
        Fri, 22 Dec 2017 09:16:37 -0800 (PST)
Received: from google.com ([2620:0:100e:422:9fe:f4ff:a657:1ce])
        by smtp.gmail.com with ESMTPSA id 137sm5830175itl.14.2017.12.22.09.16.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Dec 2017 09:16:36 -0800 (PST)
Date:   Fri, 22 Dec 2017 09:16:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] oidmap.h: strongly discourage using OIDMAP_INIT directly
Message-ID: <20171222171635.GA230194@google.com>
References: <940d8daa8eb8d42b9f0a3ebf4c25fb6417e71bc8.1513940345.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <940d8daa8eb8d42b9f0a3ebf4c25fb6417e71bc8.1513940345.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22, Johannes Schindelin wrote:
> In Git's source code, we have this convention that quite a few data
> structures can be initialized using a macro *_INIT while defining an
> instance (instead of having to call a function to initialize the data
> structure). You will see that idiom quite a bit, e.g. `struct strbuf buf
> = STRBUF_INIT;`
> 
> This works for oidsets, too: `struct oidset oids = OIDSET_INIT;` is
> perfectly legal and you can use that data structure right away, without
> having to call `oidset_init()` first.
> 
> That pattern is violated by OIDMAP_INIT, though. The first call to
> oidmap_put() or oidmap_get() will succeed, but by mistake rather than by
> design: The underlying hashmap is not initialized correctly, as the
> cmpfn function pointer still points to NULL, but since there are no
> entries to be compared, cmpfn will not be called. Things break down,
> though, as soon as there is even one entry.
> 
> Rather than causing confusion, frustration and needless loss of time due
> to pointless debugging, let's *rename* OIDMAP_INIT so that developers
> who have gotten used to the pattern `struct xyz a = XYZ_INIT;` won't do
> that with oidmaps.
> 
> An alternative would be to introduce a HASHMAP_INIT(cmp_fn) and use that
> in oidmap.h. However, there are *no* call sites in Git's source code
> that would benefit from that macro, i.e. this would be premature
> optimization (and cost a lot more time than this here trivial patch).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/discourage-OIDMAP_INIT-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git discourage-OIDMAP_INIT-v1
>  oidmap.h | 6 +++++-
>  oidset.h | 7 ++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/oidmap.h b/oidmap.h
> index 18f54cde143..1a73c392b79 100644
> --- a/oidmap.h
> +++ b/oidmap.h
> @@ -21,7 +21,11 @@ struct oidmap {
>  	struct hashmap map;
>  };
>  
> -#define OIDMAP_INIT { { NULL } }
> +/*
> + * This macro initializes the data structure only incompletely, just enough
> + * to call oidmap_get() on an empty map. Use oidmap_init() instead.
> + */
> +#define OIDMAP_INIT_INCOMPLETELY { { NULL } }

This is one way of approaching the problem.  Couldn't we also take the
approach like we have with oidset and ensure that when oidmap_get() or
_put() are called that if the oidmap isn't initialized, we simply do
that then?

>  
>  /*
>   * Initializes an oidmap structure.
> diff --git a/oidset.h b/oidset.h
> index f4c9e0f9c04..a11d88edc1d 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -22,7 +22,12 @@ struct oidset {
>  	struct oidmap map;
>  };
>  
> -#define OIDSET_INIT { OIDMAP_INIT }
> +/*
> + * It is okay to initialize the map incompletely here because oidset_insert()
> + * will call oidset_init() (which will call oidmap_init()), and
> + * oidset_contains() works as intended even before oidset_init() was called.
> + */
> +#define OIDSET_INIT { OIDMAP_INIT_INCOMPLETELY }
>  
>  /**
>   * Returns true iff `set` contains `oid`.
> 
> base-commit: 936d1b989416a95f593bf81ccae8ac62cd83f279
> -- 
> 2.15.1.windows.2

-- 
Brandon Williams
