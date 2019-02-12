Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D631F453
	for <e@80x24.org>; Tue, 12 Feb 2019 16:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfBLQ4Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 11:56:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39579 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfBLQ4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 11:56:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so3779871wmh.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9ZkiUrY+8Pf/WB7ijRXFvJKEASnbeU7syb0448aAQVA=;
        b=G3hy6LsiIrTXbaIb1eeC7DW50N4IG/aiwEwgtqWJHFfAj1ty9v/oXFb+cUP5eq4Ca0
         1LcnxCMHmZBBtmvXhDwkchr4geYUMH5337+JG5yIcfhp2Jt76nfNClquz3HZS6cDah4k
         JBSB7WtQKB1V9IFHV4hhQxonDWoMRgCtSBUL/VjJFfTyHZeUlTK3ZqLWkwDGLwU2y8UL
         9nfh/i8dzPTJj1omwhcmLYl11VBAaA4+9Aj5tlUTMeVRGK+E4kKQ7q/oA86MXOwVLyBx
         Kkktk6kmeOcCUkvVWq/epjWy+6SJeoe2tuGWu3PLuTi+2GwqDuPR4PEgx3Jb8jkQJsJ+
         p3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9ZkiUrY+8Pf/WB7ijRXFvJKEASnbeU7syb0448aAQVA=;
        b=tNm1KlUbQ5lOV7bom8xrfSQ+sZwrIKY/VakHjwsIB2pgeT0/NMkDesnoKPXam2RUpO
         mNHavX8iTueNZNXFoyFFyMkGq5iFmofEFMyAJ9JOW3G6oNQRvY9rVcmM6wzn2b10Y03S
         Q4YGFYanslPN93500iQbDh8kpysANsNo82RE/CBKJzjxF8GYgCwIHHqoODNf0ocpJxxV
         KfKlp+ejGP7OUUBTfhSVxPB7iE8bRHCEUaWi8/SO/JGFIDRRjPf3hsEymmkD7uM2zLJt
         wtrXD32KKsGMqWcGUN0bWh5t4ywg+9VmP/Vqd2iYMLlr+KO5U7xduVj4cnxpPsK4eGpW
         cdFw==
X-Gm-Message-State: AHQUAubxTmVTTQn2R9ByLf6qjGxpDY/Eh/1Yb58OWcusw9NEkv9OAMel
        MQPUeLjrvpE27FxMFxnUGyQ=
X-Google-Smtp-Source: AHgI3IZV3McCQHVQTeHPa+iq28/VGu1sby4paszeKrNGe1c41FQDiaMNDbC27Q/l3vmkwa/g+paLmA==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr3794762wmj.1.1549990581173;
        Tue, 12 Feb 2019 08:56:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x3sm19580402wrd.19.2019.02.12.08.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:56:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dan McGregor <dan.mcgregor@usask.ca>, git@vger.kernel.org
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
        <20190209023621.75255-1-dan.mcgregor@usask.ca>
        <20190212134537.GA26137@ash>
Date:   Tue, 12 Feb 2019 08:56:19 -0800
In-Reply-To: <20190212134537.GA26137@ash> (Duy Nguyen's message of "Tue, 12
        Feb 2019 20:45:37 +0700")
Message-ID: <xmqqwom5djyk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> So, how about something like this? A teeny bit longer than your
> version, but I think it's easier to control long term.
>
> -- 8< --
> diff --git a/Makefile b/Makefile
> index 0e13a5b469..44cfc63fc4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -433,6 +433,8 @@ all::
>  #
>  # Define HAVE_GETDELIM if your system has the getdelim() function.
>  #
> +# Define FILENO_IS_A_MACRO is fileno() is a macro, not a real function.

s/is fileno() is/if filno() is/;

I agree with the direction of this patch takes us.

I have a mixed feeling about the COMPAT_CODE macro trick (presumably
you did not want to include stdio.h directly for "FILE *" and
instead follow the usual "the first header included is the
compat-util" pattern; I was imagining that we'd liberally include
system headers inside compat/ directory.  If we can agree on reusing
this single macro to control conditional in git-compat-util.h when a
similar need arises in the future, this may be a good solution.

> +#
>  # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
>  # default environment variables to be passed when a pager is spawned, e.g.
>  #
> @@ -1800,6 +1802,11 @@ ifdef HAVE_WPGMPTR
>  	BASIC_CFLAGS += -DHAVE_WPGMPTR
>  endif
>  
> +ifdef FILENO_IS_A_MACRO
> +	COMPAT_CFLAGS += -DFILENO_IS_A_MACRO
> +	COMPAT_OBJS += compat/fileno.o
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
>  endif
> diff --git a/compat/fileno.c b/compat/fileno.c
> new file mode 100644
> index 0000000000..7b105f4cd7
> --- /dev/null
> +++ b/compat/fileno.c
> @@ -0,0 +1,7 @@
> +#define COMPAT_CODE
> +#include "../git-compat-util.h"
> +
> +int git_fileno(FILE *stream)
> +{
> +	return fileno(stream);
> +}
> diff --git a/config.mak.uname b/config.mak.uname
> index 786bb2f913..01f62674a4 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -221,6 +221,7 @@ ifeq ($(uname_S),FreeBSD)
>  	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
>  	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
> +	FILENO_IS_A_MACRO = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),OpenBSD)
>  	NO_STRCASESTR = YesPlease
> @@ -234,6 +235,7 @@ ifeq ($(uname_S),OpenBSD)
>  	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
>  	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
> +	FILENO_IS_A_MACRO = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),MirBSD)
>  	NO_STRCASESTR = YesPlease
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 29a19902aa..6573808ebd 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1234,6 +1234,14 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>  
> +#ifdef FILENO_IS_A_MACRO
> +int git_fileno(FILE *stream);
> +# ifndef COMPAT_CODE
> +#  undef fileno
> +#  define fileno(p) git_fileno(p)
> +# endif
> +#endif
> +
>  /*
>   * Our code often opens a path to an optional file, to work on its
>   * contents when we can successfully open it.  We can ignore a failure
> -- 8< --
>
> --
> Duy
