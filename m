Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99E61F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966405AbeCSRY1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:24:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52759 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966421AbeCSRYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:24:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id l9so7536366wmh.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RcwlnrEH+hp5mUvzT14PEgc9QVLCKzOoM3z4wqa6svs=;
        b=JxJbCc3Gh0HymHpMT9UyH1eYjzNQhdsdHPQ5ylbMroH69mwxVSaJR3m/avUrXraNq4
         QaKBrZf1AbqLJq4FTtca59g8dC51+gBkQ7/Mwcullxxc+vWEdvnVwkFFSgfJcmhMNBMy
         l3B+u+Iya4dQ1zAHbF8VFAOoa0Uej5prvXFQ0OegWIb8pB4A+5RO8JEbmOD/a7zVftxv
         yy2WRifJfUf1zcDDf8+XalTN4bBm4HvAsfP1JpkbL8ALBClya3lY6WR3j9sVTMSfVwcy
         mXpnZ3ngCar4Z2ubOSz6LtLH5Q3hVdIcRTVjz/cJkmtBZbYOk9R002OdgQ3hGQnIwJ+m
         P7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RcwlnrEH+hp5mUvzT14PEgc9QVLCKzOoM3z4wqa6svs=;
        b=oPF2swUMO03zWewau1c2oexU7bIeWGtQ/qljSBAZPZx7tG1MpxjackE/pMJiUl7SSU
         4tP6Wm8eedGuLev1dvAFhRon+8nRIqUcGL4KR7FLAKe74i2QzGYcVES/LVy6qDMHhpue
         jd52WlG25x/yubqijgMa2DlEzZ8tZTw0hJbgEFkC0FejxQLaiRiKA9CBhOaoMdlulrNj
         puaqTqKoX71F42e1Pj6A+cNWdx2hBHyBE3H9Haw95NZIcPzP7c93saxpgrhKM+fW4/r4
         gBReGmQq7mmno5SyyJ2PsTl1cbgLsCOxIAXhXz+RYhrCcU+4aJPTxdNiUM4rUmu1baiP
         eJ3Q==
X-Gm-Message-State: AElRT7FLVqOMXKhlHCCvN7BIpukIxdm6uYFBUGrFxYhqUFkKpvZbSNLG
        DOMGXmHYe/ABFMp9bYR+7P4qqcHr
X-Google-Smtp-Source: AG47ELtvx05CtJSltX7S/YID6EBZvzJPprJcoLKFm04V6DF+5eeriQGXaMVt4PsHIhpaqPaCoC7QwA==
X-Received: by 10.28.164.1 with SMTP id n1mr6961421wme.75.1521480263159;
        Mon, 19 Mar 2018 10:24:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 39sm686306wry.89.2018.03.19.10.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 10:24:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 3/3] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <20180319025046.58052-1-dnj@google.com>
        <20180319025046.58052-4-dnj@google.com>
Date:   Mon, 19 Mar 2018 10:24:22 -0700
In-Reply-To: <20180319025046.58052-4-dnj@google.com> (Dan Jacques's message of
        "Sun, 18 Mar 2018 22:50:46 -0400")
Message-ID: <xmqq7eq8vv09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> Enable Git to resolve its own binary location using a variety of
> OS-specific and generic methods, including:
>
> - procfs via "/proc/self/exe" (Linux)
> - _NSGetExecutablePath (Darwin)
> - KERN_PROC_PATHNAME sysctl on BSDs.
> - argv0, if absolute (all, including Windows).
>
> This is used to enable RUNTIME_PREFIX support for non-Windows systems,
> notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
> do a best-effort resolution of its executable path and automatically use
> this as its "exec_path" for relative helper and data lookups, unless
> explicitly overridden.
>
> Small incidental formatting cleanup of "exec_cmd.c".
>
> Signed-off-by: Dan Jacques <dnj@google.com>
> Thanks-to: Robbie Iannucci <iannucci@google.com>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> ---

Look for these misspelled words:

    sysetems
    applicaton
    authoratative

> diff --git a/Makefile b/Makefile
> index 101a98a78..df17a62a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -418,6 +418,16 @@ all::
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

Sounds sensible.

> +/**
> + * Path to the current Git executable. Resolved on startup by
> + * 'git_resolve_executable_dir'.
> + */
> +static const char *executable_dirname;
>  
>  static const char *system_prefix(void)
>  {
>  	static const char *prefix;
>  
> -	assert(argv0_path);
> -	assert(is_absolute_path(argv0_path));
> +	assert(executable_dirname);
> +	assert(is_absolute_path(executable_dirname));
>  
>  	if (!prefix &&
> -	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> -	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
> -	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
> +	    !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
> +	    !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
> +	    !(prefix = strip_path_suffix(executable_dirname, "git"))) {
>  		prefix = PREFIX;
>  		trace_printf("RUNTIME_PREFIX requested, "
> -				"but prefix computation failed.  "
> -				"Using static fallback '%s'.\n", prefix);
> +			     "but prefix computation failed.  "
> +			     "Using static fallback '%s'.\n",
> +			     prefix);
>  	}
>  	return prefix;
>  }

OK.  An essentially no-op change but with the name better suited in
the extended context---we used to only care about argv0 but that was
an implementation detail of "where did our binary come from".  Nice.
