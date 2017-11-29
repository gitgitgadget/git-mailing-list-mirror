Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F7520A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbdK2UEw (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:04:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33052 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdK2UEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:04:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id g130so37861657wme.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3XElnJeHvpMRBZ4uh9sVkKaIIGigtO/Cy/Mn1/dRM2s=;
        b=FlS4BdhYigpgjNFQzV9CFeSsOLbh10qwa8zw7kripvIs6LBCji5WnQ1AD3q/G3N5db
         GRtjrxEugJNxbqzOZd8gUtfbsRxAkKUdlbuepxm5WKSyjfM5xKyNCS+gyR+VxfGS6ykM
         Zqo82IH7UZzsLxcAsYY5rpu1u5lMfMU4BUwA9VscU69AExEI8fSreGaCd2UgAOta8FJW
         MTWK0MSBpNr3ZKIcloQM8A1eO4/+c/LAp95C34WnxVpZ5mj+/cyksvD4EtwWllyREWvD
         tNI3pWbFhlNB9ShH4yQUTY3VVotYm4D/D3FDOX383rvw7jTBt519atJqBP2ds/G3KPhJ
         lgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3XElnJeHvpMRBZ4uh9sVkKaIIGigtO/Cy/Mn1/dRM2s=;
        b=JfEjeT4cDq5Sw/dD2+/GRkoWXx1QaW4PRVoWCr/Jiv6KyDvp3/QGjdwmpBrPh+A41z
         BJw7WMzJf7zHw3SEv5ioGg8Yu1e1Tk2Yjy/OYNVNct67tEhspsMp9XPEeBFGW3w2RqHR
         xnVYUMiXRvrLDLMa0TlM60xi4703z/AvuIZEAe/7a7KoA/vpcM38F8hUNycOuhqns8YJ
         gc9eALRdqVd2MDA0gtBEfcj8xX6IRNzirg5698P1enlBSPCIMzvYlw5NKFKlhj7mcqmW
         XjmUQCtXqTfQL93KIl77bQ2uRRP3Fih/eZCZ4o1Gv7Im1rQHcpcHNCk6ke9Yg6rQH066
         bdFw==
X-Gm-Message-State: AJaThX5wReQE4X7UNZDn2xodR7eA6Glu4kEQzlb/LSjLNN/E08Z3WdcH
        HH0SGrit7rbyS1kGTCC1C00=
X-Google-Smtp-Source: AGs4zMYAvvxT1vjZhqfBgbisfbHaVa4wmO1zPDkNRNbXY6S5lBmTgtF+kmiRU/88QjUPjU4n+jopfg==
X-Received: by 10.80.193.9 with SMTP id l9mr4417887edf.176.1511985889572;
        Wed, 29 Nov 2017 12:04:49 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id k5sm1926793edc.61.2017.11.29.12.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:04:48 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eK8b9-0007ny-9B; Wed, 29 Nov 2017 21:04:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 2/4] Makefile: add support for "perllibdir"
References: <20171129155637.89075-1-dnj@google.com> <20171129155637.89075-3-dnj@google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171129155637.89075-3-dnj@google.com>
Date:   Wed, 29 Nov 2017 21:04:47 +0100
Message-ID: <87lgiovokg.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 29 2017, Dan Jacques jotted:

> Add the "perllibdir" Makefile variable, which allows the customization
> of the Perl library installation path.
>
> The Perl library installation path is currently left entirely to the
> Perl Makefile implementation, either MakeMaker (default) or a fixed path
> when NO_PERL_MAKEMAKER is enabled. This patch introduces "perllibdir", a
> Makefile variable that can override that Perl module installation path.
>
> As with some other Makefile variables, "perllibdir" may be either
> absolute or relative. In the latter case, it is treated as relative to
> "$(prefix)".
>
> Add some incidental documentation to perl/Makefile.
>
> Explicitly specifying an installation path is necessary for Perl runtime
> prefix support, as runtime prefix resolution code must know in advance
> where the Perl support modules are installed.
>
> Signed-off-by: Dan Jacques <dnj@google.com>
> ---
>  Makefile      | 18 +++++++++++++-----
>  perl/Makefile | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 59 insertions(+), 11 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f7c4ac207..80904f8b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -462,6 +462,7 @@ ARFLAGS = rcs
>  #   mandir
>  #   infodir
>  #   htmldir
> +#   perllibdir
>  # This can help installing the suite in a relocatable way.
>
>  prefix = $(HOME)
> @@ -1721,6 +1722,7 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
>  template_dir_SQ = $(subst ','\'',$(template_dir))
>  htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
>  prefix_SQ = $(subst ','\'',$(prefix))
> +perllibdir_SQ = $(subst ','\'',$(perllibdir))
>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
>
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> @@ -1955,17 +1957,22 @@ $(SCRIPT_PERL_GEN): perl/perl.mak
>
>  perl/perl.mak: perl/PM.stamp
>
> -perl/PM.stamp: FORCE
> +perl/PM.stamp: GIT-PERL-DEFINES FORCE
>  	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
> +	cat GIT-PERL-DEFINES >>$@+ && \
>  	$(PERL_PATH) -V >>$@+ && \
>  	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
>  	$(RM) $@+
>
> -perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
> -	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
> -
>  PERL_HEADER_TEMPLATE = perl/header_fixed_prefix.pl.template
> -PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
> +
> +PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ)
> +PERL_DEFINES += $(NO_PERL_MAKEMAKER)
> +PERL_DEFINES += $(perllibdir)
> +
> +perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
> +	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' \
> +	  prefix='$(prefix_SQ)' perllibdir='$(perllibdir_SQ)' $(@F)
>
>  $(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> @@ -1979,6 +1986,7 @@ $(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GI
>  	chmod +x $@+ && \
>  	mv $@+ $@
>
> +PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
>  GIT-PERL-DEFINES: FORCE
>  	@FLAGS='$(PERL_DEFINES)'; \
>  	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
> diff --git a/perl/Makefile b/perl/Makefile
> index f657de20e..b2aeeb0d8 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -1,6 +1,22 @@
>  #
>  # Makefile for perl support modules and routine
>  #
> +# This Makefile generates "perl.mak", which contains the actual build and
> +# installation directions.
> +#
> +# PERL_PATH must be defined to be the path of the Perl interpreter to use.
> +#
> +# prefix must be defined as the Git installation prefix.
> +#
> +# localedir must be defined as the path to the locale data.
> +#
> +# perllibdir may be optionally defined to override the default Perl module
> +# installation directory, which is relative to prefix. If perllibdir is not
> +# absolute, it will be treated as relative to prefix.
> +#
> +# NO_PERL_MAKEMAKER may be defined to use a built-in Makefile generation method
> +# instead of Perl MakeMaker.
> +
>  makfile:=perl.mak
>  modules =
>
> @@ -12,6 +28,16 @@ ifndef V
>  	QUIET = @
>  endif
>
> +# If a library directory is provided, and it is not an absolute path, resolve
> +# it relative to prefix.
> +ifneq ($(perllibdir),)
> +ifneq ($(filter /%,$(firstword $(perllibdir))),)
> +perllib_instdir = $(perllibdir)
> +else
> +perllib_instdir = $(prefix)/$(perllibdir)
> +endif
> +endif

Maybe I'm missing something, but isn't this "perllibdir can be relative"
aim orthagonal to what this patch series is about? I.e. we could just
avoid this work by saying you must say "prefix=/usr
perllibdir=/usr/perl" instead of "prefix=/usr perllibdir=perl" as this
allows.

I started going down this route with my own patch and just threw it
away.

>  all install instlibdir: $(makfile)
>  	$(QUIET)$(MAKE) -f $(makfile) $@
>
> @@ -25,7 +51,12 @@ clean:
>  $(makfile): PM.stamp
>
>  ifdef NO_PERL_MAKEMAKER
> -instdir_SQ = $(subst ','\'',$(prefix)/lib)
> +
> +ifeq ($(perllib_instdir),)
> +perllib_instdir = $(prefix)/lib
> +endif
> +
> +instdir_SQ = $(subst ','\'',$(perllib_instdir))
>
>  modules += Git
>  modules += Git/I18N
> @@ -42,7 +73,7 @@ modules += Git/SVN/Prompt
>  modules += Git/SVN/Ra
>  modules += Git/SVN/Utils
>
> -$(makfile): ../GIT-CFLAGS Makefile
> +$(makfile): ../GIT-CFLAGS ../GIT-PERL-DEFINES Makefile
>  	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
>  	set -e; \
>  	for i in $(modules); \
> @@ -79,12 +110,21 @@ $(makfile): ../GIT-CFLAGS Makefile
>  	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>  	echo instlibdir: >> $@
>  	echo '	echo $(instdir_SQ)' >> $@
> +
>  else
> -$(makfile): Makefile.PL ../GIT-CFLAGS
> -	$(PERL_PATH) $< PREFIX='$(prefix_SQ)' INSTALL_BASE='' --localedir='$(localedir_SQ)'
> +
> +# This may be empty if perllibdir was empty.
> +instdir_SQ = $(subst ','\'',$(perllib_instdir))
> +
> +$(makfile): Makefile.PL ../GIT-CFLAGS ../GIT-PERL-DEFINES
> +	$(PERL_PATH) $< \
> +	  PREFIX='$(prefix_SQ)' INSTALL_BASE='' \
> +	  LIB='$(instdir_SQ)' \
> +	  --localedir='$(localedir_SQ)'
> +
>  endif
>
>  # this is just added comfort for calling make directly in perl dir
>  # (even though GIT-CFLAGS aren't used yet. If ever)
> -../GIT-CFLAGS:
> -	$(MAKE) -C .. GIT-CFLAGS
> +../GIT-CFLAGS ../GIT-PERL-DEFINES:
> +	$(MAKE) -C .. $(@F)
