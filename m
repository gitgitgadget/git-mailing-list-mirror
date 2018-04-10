Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8051F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeDJVoo (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:44:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38176 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeDJVon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:44:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id i3so159691wmf.3
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VjRt94HF/Fr+nABCZcHpf5R2/4OAzDVetr1HjUi038k=;
        b=B3LN95P9PdPdyvPKGVTLaOZnGWgYdVtWU7wNoI0/PXarGDKGDBixm4pNAJVoBiYsgH
         F9hld2cq/idu8B+CKSyp87P2NyWPdqR/WSyzn3uMUCBqrjK13W55qzg0Kt+Zndnx2Zkq
         a8BNZb34LvQhGVUNFtjT1hxHZouhcmjgnac2RDCqzJjxrw6Ft+rXOx5VEzOkHZRBIM7y
         BWEoxtVlKU5AInkVhR8ODWyihhQD2S2eXwhLlXxKVw3jVxrKcnD9NuUJlx5pVHO/OJHG
         NpWNi1YhGYLCkvKUCWFxOAYaY4JJh61jBfvWuuvKQSYByuOZd8JScw3gYxVdi6ZafK9m
         ierA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VjRt94HF/Fr+nABCZcHpf5R2/4OAzDVetr1HjUi038k=;
        b=NrfoS96U0wHV7pu2hPiyn6MBnDnBn3sNHmdY/4M5fSIVEchemmd6jqtiI0Hou8HD11
         o36QUmBv0QYuIatQuEKzuWXO9ZyY2A9PoJ2hzMRicu5BtTWR4UPiJk3GUxSBvo3+7JeT
         v404HPxJ1RjuwJQPx4MHLEc4mNZGCYS9v5yDTXlyAjEB/5Rm3EXO7pUKLlUKvvQ+Befq
         eW9ZUBjMnSy80b7Fb42cGfBngGvBEJag7OubnNxTfC3UcsqqOMJ61aJILrKwQ535fp9S
         Tcjv4X3cODEyulXouvifLU5Ib/Hhwlz/23I4im33w0mlp5bNKkB5kXu1KdNUyq1QdGxq
         4vDA==
X-Gm-Message-State: ALQs6tCxkaHvx2Tc7+V3JK+LGabTB7zlcKmepru20R7Tz3SolkWqQBGf
        ae+Lb3Q1aB8WLI5DrmG6EnQ=
X-Google-Smtp-Source: AIpwx4/9VV0rRO9rGBsdkE2CK0HzqKDzWRo3p5LTbhVnpRlboOscutRtlzt9IY0O9sajY6s36Aq4+g==
X-Received: by 10.28.159.140 with SMTP id i134mr787310wme.96.1523396681946;
        Tue, 10 Apr 2018 14:44:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m62sm4458136wmc.25.2018.04.10.14.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:44:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <mail@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Dan Jacques <dnj@chromium.org>
Subject: Re: [PATCH v2 1/1] perl: fix installing modules from contrib
References: <xmqqpo39569k.fsf@gitster-ct.c.googlers.com>
        <20180410133641.18861-1-mail@eworm.de>
Date:   Wed, 11 Apr 2018 06:44:40 +0900
In-Reply-To: <20180410133641.18861-1-mail@eworm.de> (Christian Hesse's message
        of "Tue, 10 Apr 2018 15:36:41 +0200")
Message-ID: <xmqqpo3620tz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <mail@eworm.de> writes:

> Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make rules)
> removed a target that allowed Makefiles from contrib/ to get the correct
> install path. This introduces a new target for main Makefile and fixes
> installation for Mediawiki module.
>
> v2: Pass prefix as that can have influence as well, add single quotes
>     for _SQ variant.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  Makefile                   | 2 ++
>  contrib/mw-to-git/Makefile | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 96f6138f6..19ca5e8de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2011,6 +2011,8 @@ GIT-PERL-DEFINES: FORCE
>  		echo "$$FLAGS" >$@; \
>  	    fi
>  
> +perllibdir:
> +	@echo '$(perllibdir_SQ)'

Sorry for not noticing it before, but as this rule will not create
and update timestamp of a filesystem entity 'perllibdir', shouldn't
we mark it with .PHONY?  I'd call the target 'say-perllibdir' if I
were doing this patch but that is merely a personal preference.

>  .PHONY: gitweb
>  gitweb:
> diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
> index a4b6f7a2c..4e603512a 100644
> --- a/contrib/mw-to-git/Makefile
> +++ b/contrib/mw-to-git/Makefile
> @@ -21,8 +21,9 @@ HERE=contrib/mw-to-git/
>  INSTALL = install
>  
>  SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
> -INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
> -                -s --no-print-directory instlibdir)
> +INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/ \
> +                -s --no-print-directory prefix=$(prefix) \
> +                perllibdir=$(perllibdir) perllibdir)
>  DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
>  INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))
>  
