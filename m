Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9C81F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936038AbeCST1y (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:27:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55944 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936035AbeCST1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:27:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id t7so4449560wmh.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8hvcAroZ3DCDygciAskqq1ZiJnLt5/JNh/mjBTaYM6M=;
        b=orKQPrL9WjlHdBGm4Tc8XPDL253v/35T21QTRgE/3zjSuUY0f3tutesHG0uqGEiuc7
         9cY28ml0b/S86Psg+Zzy3+r9qj00Rce0Dy4HYlPAGSPp/BCjCQ8rWSj+i8hQGCXKxWZF
         p/G/lV4WtKREAqOZrF7G93VAdAOZ0+E0W8GIGhzjNMSKWcFi5zkr5camxcV0pyW0vodn
         Gwa+KZoxVOzrqAujIV89vw8aPbPKgCF8ymaC4q1guVf55G9EppFAH8KAtVaTiRHqlZ04
         TtEPqCVsZsOjGuX5kC98eVjTj7x9/ZbtMDRuiQVz79rybaxl9zLv2ZlqDbpOSCmOQLMp
         tscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8hvcAroZ3DCDygciAskqq1ZiJnLt5/JNh/mjBTaYM6M=;
        b=jAN5oiloDMJA07Os8jEaT35AAltBXKdcFd1QiggvBifQmjqjdmyVLzTPnLgZYiZIJL
         JYTdzhB3Oun21MCg3qptWzXg11T8WX4atGek8bMaCSUMcMJs6HTUjHcYqz2GY71Z5au2
         zGSAu0Fbz/bZrxXWF+dHmug5zgH19APppDdsGKx2R7BiBxAUab8eEwJafArmdPrmhXum
         5XP1yHIy1iDnL/+qLfmlFTjNVUAcNJWMjxfDk7WUfLt5RhE9dRaSHfdE54NdvKmkXeW2
         xMzOD1u2WxH7kxdAK1kQndETtrI4ihE7wk7veN0T5x0jJyZ+mKU+s1GOwiN+fV1JZram
         Gyag==
X-Gm-Message-State: AElRT7F5ujRQHPQ/2GKM8zWfGxiQJhSIZHG2mIdOgzw7akjg3ubl+kal
        FRk7yMn8/ik7koqxRaI6cMc=
X-Google-Smtp-Source: AG47ELtTgHVfZVlhpKjTmyD5shB18hGyIinrK54OJTD13agOXDf2VMKXQbpVjbi9RGacA36+Gd0L2Q==
X-Received: by 10.28.149.71 with SMTP id x68mr10371724wmd.78.1521487667589;
        Mon, 19 Mar 2018 12:27:47 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 21sm1033460wrt.82.2018.03.19.12.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:27:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 3/3] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-4-dnj@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180319025046.58052-4-dnj@google.com>
Date:   Mon, 19 Mar 2018 20:27:44 +0100
Message-ID: <87woy7c1cf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Dan Jacques jotted:

>  #
>  # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
>  #
> +# Define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the KERN_PROC BSD
> +# sysctl function.
> +#
> +# Define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs" filesystem
> +# capable of resolving the path of the current executable. If defined, this
> +# must be the canonical path for the "procfs" current executable path.
> +#
> +# Define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports calling
> +# _NSGetExecutablePath to retrieve the path of the running executable.
> +#
>  # Define HAVE_GETDELIM if your system has the getdelim() function.
>  #
>  # Define PAGER_ENV to a SP separated VAR=VAL pairs to define

This is fine in isolation, but the sum total of the series ends up
being:

    diff --git a/Makefile b/Makefile
    index 96f6138f63..c23d4d10f0 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -425,6 +425,16 @@ all::
     #
     # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
     #
    +# Define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the KERN_PROC BSD
    +# sysctl function.
    +#
    +# Define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs" filesystem
    +# capable of resolving the path of the current executable. If defined, this
    +# must be the canonical path for the "procfs" current executable path.
    +#
    +# Define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports calling
    +# _NSGetExecutablePath to retrieve the path of the running executable.
    +#
     # Define HAVE_GETDELIM if your system has the getdelim() function.
     #
     # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
    @@ -441,6 +451,13 @@ all::
     #
     # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
     # which the built Git will run (for instance "x86_64").
    +#
    +# Define RUNTIME_PREFIX to configure Git to resolve its ancillary tooling and
    +# support files relative to the location of the runtime binary, rather than
    +# hard-coding them into the binary. Git installations built with RUNTIME_PREFIX
    +# can be moved to arbitrary filesystem locations. RUNTIME_PREFIX also causes
    +# Perl scripts to use a modified entry point header allowing them to resolve
    +# support files at runtime.

I wonder if it wouldn't be a lot more understandable if these were noted
together, i.e. let's first document RUNTIME_PREFIX, then for all the
other ones say below that:

   # When using RUNTIME_PREFIX, define HAVE_BSD[...]

Or something like that. We can always drop the "When using
RUNTIME_PREFIX, " bit later if it ends up benig used for other stuff,
but for now it's helpful to note that you don't need to care about these
if you're not using RUNTIME_PREFIX.

> -				"but prefix computation failed.  "
> -				"Using static fallback '%s'.\n", prefix);
> +			     "but prefix computation failed.  "
> +			     "Using static fallback '%s'.\n",
> +			     prefix);

Whitespace changed mixed in with the actual change.
