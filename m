Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53731F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeAXVTd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:19:33 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43973 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:19:31 -0500
Received: by mail-pg0-f68.google.com with SMTP id n17so3591571pgf.10
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/sJDI8QZwpMHv8q2z2OqK/+WXX68m30LvTBUeEdm6Rc=;
        b=iX+5i7UoV6pSK0aQqbowoPw5pw5uuCH6sKGoJyRZ7L1MmbKS/GKMKissurolJhe3Ne
         MlgUGyaL3z7DiUssgTNW7O7gblLNhe/uEa6dG4PDWz5G34u6P2MBQ9Qn/M/VhXdo/jlJ
         NZ1mVzn7YI6WqxgZMB2n24X8XIK5bkep5l0186q/gH99wOwX3Jb0us3n5jy1vELrXUtN
         jnG8EzrnneugpheaIhYDkXeuAexYD1yjxIAU+kOp7mHRj2J0+Sk7ncDInqxjD/pSFLW7
         bmmEQ4UsQj8C56TLYHbjrfQNhJrLB1UQfi97UISeIDJlEAL3yytf42v+omOPR6R1af7P
         lj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/sJDI8QZwpMHv8q2z2OqK/+WXX68m30LvTBUeEdm6Rc=;
        b=TnTjNuc9u8DdJK776yaIxFGNuud/TiTFD5yRNYP4cJb8NfY+PlVmCvMi8RlrowcySl
         cAnkKccxieKDXhKqfmG2rDdDPkcwXkzlIcqcdA8G5I+ZOTS15R3Tb4wrJAGR6xfx3YR8
         i5NCARG9zzkts9ipLJvYe91Q6axX1V/8yFQfPtxz8dn8orK6pfOKjiBC5LxqWNkMcx2k
         SOSaW7ZWt2BPfHbLYOxlAvSU+AY96lqYwDfD72K4VBSjspPHNGQ4WURq+QLMWufLJl9h
         LojBC6fcncud1zt1v1Hv8KrDbAHZyCFT4wBy+4b0AVQL7J9tpCBx9g/257++qHxeyDRX
         bziQ==
X-Gm-Message-State: AKwxytcfZ5veAgAoW5wMGBBwXJxjnI515bZH6XQq0TeIzOlOt6bf4g6A
        InsXUdUKfizuwOii7XUpfq4=
X-Google-Smtp-Source: AH8x226Rrjf8jkrb0KfFTQnkD2lKZiJHXahi328qdKRbIbUeDbQDLwWpo6u3wu4nJ9ZQDmO6raV78w==
X-Received: by 10.98.236.93 with SMTP id k90mr14203673pfh.35.1516828771134;
        Wed, 24 Jan 2018 13:19:31 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id i128sm11218097pfg.83.2018.01.24.13.19.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:19:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 2/4] Define config options required for the HPE NonStop NSX and NSE platforms
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
        <20180121234203.13764-3-randall.s.becker@rogers.com>
Date:   Wed, 24 Jan 2018 13:19:29 -0800
In-Reply-To: <20180121234203.13764-3-randall.s.becker@rogers.com> (randall
        s. becker's message of "Sun, 21 Jan 2018 18:42:01 -0500")
Message-ID: <xmqqvafrara6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> Upgrade old options in config.mak.uname to currently supported
> NonStop operating system versions (J06.21 and L17.xx).
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  config.mak.uname | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)

The "tar extraction option" thing in 1/4 is not something you use
here?  Not complaining---I am merely trying to use this as one data
point to help me assess/guess what 1/4 is about ;-)

>
> diff --git a/config.mak.uname b/config.mak.uname
> index 685a80d13..d9f8d57e3 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -428,27 +428,37 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	# INLINE='' would just replace one set of warnings with another and
>  	# still not compile in c89 mode, due to non-const array initializations.
>  	CC = cc -c99
> +	# Build down-rev compatible objects that don't use our new getopt_long.
> +	ifeq ($(uname_R).$(uname_V),J06.21)
> +		CC += -WRVU=J06.20
> +	endif
> +	ifeq ($(uname_R).$(uname_V),L17.02)
> +		CC += -WRVU=L16.05
> +	endif
>  	# Disable all optimization, seems to result in bad code, with -O or -O2
>  	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
>  	# abends on "git push". Needs more investigation.
> -	CFLAGS = -g -O0
> +	CFLAGS = -g -O0 -Winline
>  	# We'd want it to be here.
>  	prefix = /usr/local
>  	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
> -	PERL_PATH = ${prefix}/bin/perl
> -	PYTHON_PATH = ${prefix}/bin/python
> -
> +	PERL_PATH = /usr/bin/perl
> +	PYTHON_PATH = /usr/bin/python
> +	RM = /bin/rm -f
>  	# As detected by './configure'.
>  	# Missdetected, hence commented out, see below.
>  	#NO_CURL = YesPlease
>  	# Added manually, see above.
>  	NEEDS_SSL_WITH_CURL = YesPlease
> +	NEEDS_CRYPTO_WITH_SSL = YesPlease
> +	HAVE_DEV_TTY = YesPlease
>  	HAVE_LIBCHARSET_H = YesPlease
>  	HAVE_STRINGS_H = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
>  	NO_SYS_SELECT_H = UnfortunatelyYes
>  	NO_D_TYPE_IN_DIRENT = YesPlease
> +	NO_GETTEXT = YesPlease
>  	NO_HSTRERROR = YesPlease
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
> @@ -458,8 +468,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	NO_MKDTEMP = YesPlease
>  	# Currently libiconv-1.9.1.
>  	OLD_ICONV = UnfortunatelyYes
> -	NO_REGEX = YesPlease
> +	NO_REGEX=NeedsStartEnd
>  	NO_PTHREADS = UnfortunatelyYes
> +	ifdef NO_PTHREADS
> +	else # WIP, use Posix User Threads
> +		PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
> +		PTHREAD_LIBS = -lput
> +	endif
>  
>  	# Not detected (nor checked for) by './configure'.
>  	# We don't have SA_RESTART on NonStop, unfortunalety.
> @@ -477,9 +492,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	# RFE 10-120912-4693 submitted to HP NonStop development.
>  	NO_SETITIMER = UnfortunatelyYes
>  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
> -	SHELL_PATH = /usr/local/bin/bash
> -	# as of H06.25/J06.14, we might better use this
> -	#SHELL_PATH = /usr/coreutils/bin/bash
> +	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
>  	pathsep = ;
