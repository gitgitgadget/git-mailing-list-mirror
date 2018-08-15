Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A101F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeHOTtj (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:49:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46088 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbeHOTtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:49:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so1677930wrw.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z85mf/acUE4JehYBbp8YBIDLnwqKr9D0z1Ozhz2BhiI=;
        b=Jt7v+NuLgUBtd+bGMUtpsBZRVYZ6xRgKse1hNE3B5i+3IBKiS5S7rKK5eoO6N76FM0
         LlENlnBxZEYARsV346zpErYjMr//FCogmUEgkzY30lv5qMBOXPd24skMvYhBGgbWjTXr
         zUeVbQlbpVlxVjX0uCNLGJAtKYotYjtc3fr1bX4GzPzC9XkbHtg5oqyQygtQipfakBwX
         SOpfbR2wzR5hkt2dgRIUnU+oO0yXRkIdrrH9O9rqUA4rXnKQhAJy0iChGREZZaJuvWa8
         Q5O9t+c8JDygJ2IwezzrxsffIIZyRaowfwQwmzt11xC+7GgUm0uXHlGSJytX4LE5TuRF
         j4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Z85mf/acUE4JehYBbp8YBIDLnwqKr9D0z1Ozhz2BhiI=;
        b=Y++cdvODnS0lhbPy/D2OlknKCgMeFeN2VJru8r9KvqbwY4XYzhSZFXABieWW8go4Om
         VLVBtUb+aCEoTQo3urB7rHoZ9kvBlT1fEFws6SkyYrbUwyEmcXmWKIS6uhrbPdYFzdzb
         1N9OL+W9XOca0YuFVPRz6iSIqxu0tzVBjorFX8TXSVI+dBdB7QEYZBWETSOplJl+ry/R
         1iCsIwieY78EGOrDe9UelnatQe0HLkDO4YuUsVYmRpKAb8CdNH+p3hDXl09ohAAIxDM5
         UEOEaF2FPkcllJqVu+qeA1wdteW0k6H+NXRcSlUrJat4qFEE/0wcg3AD4pO498Zo9gOU
         I7Xw==
X-Gm-Message-State: AOUpUlEM7cUwFIt8uLMx08zfKtKYlUewCb9xBxCB5IpPozt7zeLswGoO
        JLn6zBkpVQbKG+oWssVNYEc=
X-Google-Smtp-Source: AA+uWPyyPTBQfRjgihhaJ0PAzjhPss5/mUthywIG/YoAUWB96MWphBLXRQxeEqjoNhsL6/WiYMHE6Q==
X-Received: by 2002:adf:e841:: with SMTP id d1-v6mr11138554wrn.269.1534352200976;
        Wed, 15 Aug 2018 09:56:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a6-v6sm2667134wmf.22.2018.08.15.09.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:56:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] Makefile: extend NO_TCLTK=NoThanks to cover docs
References: <20180815151505.12011-1-avarab@gmail.com>
Date:   Wed, 15 Aug 2018 09:56:39 -0700
In-Reply-To: <20180815151505.12011-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 15 Aug 2018 15:15:05 +0000")
Message-ID: <xmqq7ekrk1q0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Extend the NO_TCLTK=NoThanks flag to be understood by the
> Documentation Makefile.
>
> Before this change compiling and installing with NO_TCLTK would result
> in no git-gui, gitk or git-citool being installed, but their
> respective manual pages would still be installed.

Thanks, but I personally do not perceive it to be a problem.

It is perfectly OK to install programs without installing docs, and
also it is OK to install docs without programs.  I do not see why
gitk.html and the reference to it from the main ToC in git.html must
be removed when you are not installing gitk.

Lack of an option to skip them from the documentation is something
we might want to improve, but you should be able to install the docs
for programs you do not happen to have, and I think it should be the
default.

By the way, to be more explicit than merely to hint, I think this
patch needs to also update Documentation/cmd-list.perl so that under
NO_TCLTK, the entry for gitk is omitted from cmds-mainporcelain.txt,
etc. to be a complete solution to your original problem.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/Makefile | 23 ++++++++++++++++++-----
>  Makefile               | 39 +++++++++++++++++++++------------------
>  2 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d079d7c73a..d53979939e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,5 +1,7 @@
>  # Guard against environment variables
>  MAN1_TXT =
> +MAN1_TXT_WIP =
> +TCLTK_FILES =

The latter name loses the fact that it is to hold candidates to be
on MAN1_TXT that happen to be conditionally included; calling it
MAN1_TXT_TCLTK or something, perhaps, may be an improvement.

The former name makes it look it is work-in-progress, but in fact
they are definite and unconditional part of MAN1_TXT.  Perhaps
MAN1_TXT_CORE or something?

> ...
> +MAN1_TXT_WIP += git.txt
> +MAN1_TXT_WIP += gitremote-helpers.txt
> +MAN1_TXT_WIP += gitweb.txt
> +
> +ifndef NO_TCLTK
> +MAN1_TXT_WIP += gitk.txt
> +MAN1_TXT = $(MAN1_TXT_WIP)
> +else
> +TCLTK_FILES += git-gui.txt
> +TCLTK_FILES += gitk.txt
> +TCLTK_FILES += git-citool.txt
> +MAN1_TXT = $(filter-out \
> +		$(TCLTK_FILES), \
> +		$(MAN1_TXT_WIP))
> +endif
>  
>  MAN5_TXT += gitattributes.txt
>  MAN5_TXT += githooks.txt
> diff --git a/Makefile b/Makefile
> index bc4fc8eeab..8abb23f6ce 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2372,21 +2372,21 @@ export DEFAULT_EDITOR DEFAULT_PAGER
>  
>  .PHONY: doc man man-perl html info pdf
>  doc: man-perl
> -	$(MAKE) -C Documentation all
> +	$(MAKE) -C Documentation all NO_TCLTK='$(NO_TCLTK)'
> ...
>  pdf:
> -	$(MAKE) -C Documentation pdf
> +	$(MAKE) -C Documentation pdf NO_TCLTK='$(NO_TCLTK)'

Since we are assuming GNU make anyway, can we just say "export
NO_TCLTK" just once, or would it be too magical and create
maintenance burden?
