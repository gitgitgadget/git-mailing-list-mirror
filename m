Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE1D1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbeDCKtz (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 06:49:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37117 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbeDCKtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id r131so34214378wmb.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mNaS68FOqkOjhGPBbNO9ln/8DKx8OhO7yTn+cJstsHY=;
        b=vS3wUhY9Mj5L5g5FEXDS0IPtvTXHY+qvwEe8NH++vV4OsnFVsTSkXu+suTapQX4Ox7
         FLzx2IIL+KSZ6Xq8t7QWQ2LixAaB/3BPKwnPH+ubDdjKiZsHOc/URqNrdKny/4cO7I4Y
         fCJ+QuNmRX0pg6AjOJ3qoeumAqfJKHVtEMXl5IYR+J32mlV3Icq5biNQFfLUVfZHsSAb
         HnJ/ZawN/ONs+fGpKveu9kJh29kdNIhNcrhQMGtjD9Fu788+BoZOapUV9hW3q8kFCY5n
         QEhgIKMBkHtOHkKZlb93gFxs21zwrNzlz5F5fXVq2eQ1FhZQZjues7fpp5qcG33oy5Aj
         qKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mNaS68FOqkOjhGPBbNO9ln/8DKx8OhO7yTn+cJstsHY=;
        b=XI8Yi8nfZOrwLG1xEjo6fpS9HCm8DvJ42spjld27SGr3S0gI7qj+YbevJ6pcZg4C4b
         FFmM+Uzf+zQv6nFzyDO+aVG8yicAYAsqh4dlHmYOvoy5NC8x4VKL3xel264vTZytiVpZ
         mZFgSmf3twJS2vrjr5/3inTVmPr2ikKTEF2pTLL2GwTLsYJmm/xtkhnFCMB9nbmqi8MZ
         KD0yKlV1v23GmY0vOpHaAe02HjHkoeJv47G63odQY+RHR7L17PZECP5hjnprR1eoB4VP
         6Xdb9dN9dTZnHwBjrVPcHkc3cXuCDfeLpzRM1PCC1Pn/7wnbHlQDOIn0UAoJkcpOwdjt
         jLOw==
X-Gm-Message-State: AElRT7GvV3qhUC0XtZaXAwj3yswY5hG3Xi1YUVA+3ZdJkJeen98FE3FV
        UwV2abiIVNm7AnNrAtRmH0g=
X-Google-Smtp-Source: AIpwx49wiD1iie6BS0rpT8k59dt+fhefUeWOJ2DBDpzg0aPwk2ZlqfXmzT4vK6UEpAQ3TkioaekFJg==
X-Received: by 10.80.133.205 with SMTP id q13mr16175520edh.123.1522752590784;
        Tue, 03 Apr 2018 03:49:50 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id p18sm1544167edm.57.2018.04.03.03.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 03:49:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Hesse <mail@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@chromium.org>
Subject: Re: [PATCH 1/1] perl: fix installing modules from contrib
References: <20180403092008.26892-1-mail@eworm.de>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180403092008.26892-1-mail@eworm.de>
Date:   Tue, 03 Apr 2018 12:49:47 +0200
Message-ID: <87tvssva2c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 03 2018, Christian Hesse wrote:

> Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make rules)
> removed a target that allowed Makefiles from contrib/ to get the correct
> install path. This introduces a new target for main Makefile and fixes
> installation for Mediawiki module.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  Makefile                   | 2 ++
>  contrib/mw-to-git/Makefile | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a1d8775ad..bcaf50495 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2002,6 +2002,8 @@ GIT-PERL-DEFINES: FORCE
>  		echo "$$FLAGS" >$@; \
>  	    fi
>
> +perllibdir:
> +	@echo $(perllibdir_SQ)
>
>  .PHONY: gitweb
>  gitweb:
> diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
> index a4b6f7a2c..0a6e59579 100644
> --- a/contrib/mw-to-git/Makefile
> +++ b/contrib/mw-to-git/Makefile
> @@ -21,8 +21,8 @@ HERE=contrib/mw-to-git/
>  INSTALL = install
>
>  SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
> -INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
> -                -s --no-print-directory instlibdir)
> +INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/ \
> +                -s --no-print-directory perllibdir=$(perllibdir) perllibdir)
>  DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
>  INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))

Thanks, I (obviously) missed that when getting rid of the perl/Makefile.

This fixes it up for now, but it seems we're going to need some solution
to make this work with the in-flight RUNTIME_PREFIX Dan's been working
on.

I think the best solution for that, not just for this but for most of
contrib/ in general, is to simply move it into our main tree out of
contrib/, and introduce some Makefile flags for whether or not you'd
want to install such-and-such from contrib.

That would probably be easier than the current arrangement, and we could
do things like say we always want to run tests for contrib/ stuff, even
though we're not installing it.
