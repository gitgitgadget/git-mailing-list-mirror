Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900B41F463
	for <e@80x24.org>; Tue, 10 Sep 2019 14:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfIJOSd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 10:18:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42596 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJOSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 10:18:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id q14so20614554wrm.9
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fP967KRD/aKtdS8MeL+V8+MOK7Jo2pXuQW+lNDG75PA=;
        b=CcJo5HGQDBtjLrupQrPNTMAo0WlfG6OANmdpl8X0dyNwqCJOkUgFTSqChI9YAdnFQ8
         +Y4Ap+LgdM+Dj8w7dl832iR7gyk4kxqPYekl0E6aTrF+SS9aEvCbr3CzC0a2SUSI354m
         Y8+lLWo7qK9IJvLnKO18pxMYuZC0NEwhNjzI1kqPokKtYVBs0wyb77+wn2cK8FItwbp4
         bhlSxBGJbxI019jGGTW2SysOGqgRpqcUgk1Zq0GG0PCoFLkV2QdLhXXZ/HOrQBdpV4UG
         xxUGsJkAOqW4TpjuNVwIImFrM0ZgDUCVb5DMhp4psdeGWOIEcxpt0vXVdPbvpWua1C3T
         sc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fP967KRD/aKtdS8MeL+V8+MOK7Jo2pXuQW+lNDG75PA=;
        b=cm0nAfE+mGTSKkckxtB9zCQuzhu6pa+PUmj16GVJPLmSjJGkPIj50fXm5AAvnGGA22
         hdZsLEsudR00y9K0ettAkJ526bhFffyGLqla9XEIgca4BpV57nV/1MjC5jmNaVQCMZcE
         YqafVoas1LCVeP5VdI+A6djaF0PeZQsLh4W1HE91aDrmvea6S0Qukj/GIJyAquWGMKXy
         0RI0FZcQ+HYFx7m/qtXX/IJzCy+5ZMl32naM65gGotmvME56G3xZw3XFaBTy+w4KtEyk
         pPGB3lItodeeHtReruqLvNuVHQ2xLRUdXJG4hwk5Hl1LykSiWw0U4cVTqg5NQNYLsHNU
         tmuA==
X-Gm-Message-State: APjAAAWgwf5gF8MeD+OuotEPaqVqhJOiBbg2S2ANojuRGP0e7kzbS9e4
        iXm/ZT8pTFmfPZtHam9Rvmo=
X-Google-Smtp-Source: APXvYqysWyVC87rrKO/Ibf1t78g5qftbzI9txWxH+Kv1t7mMNn91CEmc1nqlB8SC/Jnm8ZwpVFqQ4g==
X-Received: by 2002:adf:e612:: with SMTP id p18mr7093842wrm.218.1568125111914;
        Tue, 10 Sep 2019 07:18:31 -0700 (PDT)
Received: from szeder.dev (x4dbe1e6e.dyn.telefonica.de. [77.190.30.110])
        by smtp.gmail.com with ESMTPSA id a6sm9366646wrr.85.2019.09.10.07.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 07:18:30 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:18:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: run coccicheck on more source files
Message-ID: <20190910141828.GK32087@szeder.dev>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <f62b0c7d1774cefc66e519430515eeb64acad1e0.1568101393.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f62b0c7d1774cefc66e519430515eeb64acad1e0.1568101393.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 12:44:31AM -0700, Denton Liu wrote:
> Make the "coccicheck" target run on all C sources except for those that
> are taken from some upstream. We don't want to patch these files since
> we want them to be as close to upstream as possible so that it'll be
> easier to pull in upstream updates.

> diff --git a/Makefile b/Makefile
> index 708df2c289..d468b7c9c4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2802,12 +2802,8 @@ check: command-list.h
>  		exit 1; \
>  	fi
>  
> -C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
> -ifdef DC_SHA1_SUBMODULE
> -COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> -else
> -COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> -endif
> +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))

Hrm, so this uses FIND_SOURCE_FILES, which first attempts to run 'git
ls-files' and if that fails it falls back to run 'find'.

Unfortunately, the output of the two slightly differ: 'git ls-files'
prints 'abspath.c advice.c alias.c ...' why 'find' prints
'./upload-pack.c ./unpack-trees.c ./gpg-interface.c ...'.  Now, while
the order of files doesn't matter, the './' prefix does, because:

> +COCCI_SOURCES = $(filter-out $(UPSTREAM_SOURCES),$(FIND_C_SOURCES))

Here the paths/patterns in UPSTREAM_SOURCES don't have that './'
prefix, and thus won't match and won't filter out any of the upstream
files that they are supposed to.  IOW, if someone runs 'make
coccicheck' on a system without Git installed, then Coccinelle will
check all upstream sources as well, and will e.g. suggest using
COPY_ARRAY in 'compat/regex/regexec.c'.

Now, running 'make coccicheck' on a git.git clone without Git
installed might look like quite a pathological case on the first
sight, but I would argue that it is not that pathological: e.g.
consider someone running the recent Coccinelle version in a small-ish
Docker image containing just enough to run 'make coccicheck', but not
Git.  (yeah, you guessed right, I am that someone ;)

I don't know how to convince 'find' to omit that './' prefix from each
listed file, and in a portable way at that.  Piping its output through
'sed' or even 'cut' easily takes care of it, though.

>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	@echo '    ' SPATCH $<; \
> -- 
> 2.23.0.248.g3a9dd8fb08
> 
