Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7281F45F
	for <e@80x24.org>; Fri, 10 May 2019 17:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfEJR2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 13:28:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35285 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 13:28:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so8799984wrp.2
        for <git@vger.kernel.org>; Fri, 10 May 2019 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SkF/2pGvsN40K7FAwwi02iAkzo2OU0PS104f2oAeJ6c=;
        b=q7ps32fF2n4VStVrl2ZIk1ubmYLsjpKDLTIM91pXK4fc90e/EeJC8EN/xdvL5gZz9E
         dglN81QWDvZF//O13y/iI1ykuFHIMXk1KZUf7+1HCMiejWzZrc99cYgQsBYJfDxZ3OMw
         ELqU/nCKXs9UzKt5n/QF20Irpvrrg5BqrqHqbO4ImjeI9dFBuW9cav4t1EFT/ISUSOY3
         CszhjNweGxZEwpxCx6jAlDtFDMX1LP7keTNtl8NUV9NFtPOSCQpripnHJt2P0AEOiqMo
         hOyi0qzKxz32725ioUwxMA1BQUZ/Cq1FGPkJPfUJq9n0Hw4xMnH8LS/+ZmLt3qQ4uXFc
         9NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SkF/2pGvsN40K7FAwwi02iAkzo2OU0PS104f2oAeJ6c=;
        b=dJ3koFWlok/cvlQtzJUlD6QZLPpLx7Raw3gDBqHO7vdw2O6Bt3vJ9YYQEq/rzMl2KI
         IulrHpvNa/eDnGWzkdUQwmIiVtuIgk8CUph7g8FsLjnxPVqOvDiwY0OugFH9oCkCPT9r
         h+wr0f1JLO07Lccps8Lov1TXNpoJ4SaTzoDHaH+Ug1ZsWJzyIpwiliZ/Glm+Lz34HSW6
         MizdVbCUq1qssOgiWVDX643dFLmxNEfuoc4PudSVDPO34m2Xm70ZlG957U/MpO1b7zrr
         N80TA4C1JVZa/KiW5wciLbnOsvMSW2b2bgcoXtw2zJKGZlWmpyqeNqCugqRORcw51v2F
         BC0w==
X-Gm-Message-State: APjAAAUEjioOxMtZRTzjo2+FMjvxn9sY3qMa4N/+PVGX8I3STqHe9iL+
        E60eEHs4beH1pSzY3whMYGA=
X-Google-Smtp-Source: APXvYqxI8LMV62nele0Zl0S2L0DfMmBeKvJVvbaPCzddRwvC8/R2m1jhviFo+eYcqOW32P2KMyLTxQ==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr1423884wrm.217.1557509308069;
        Fri, 10 May 2019 10:28:28 -0700 (PDT)
Received: from szeder.dev (x4d0c00f2.dyn.telefonica.de. [77.12.0.242])
        by smtp.gmail.com with ESMTPSA id q13sm24958wrn.27.2019.05.10.10.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 10:28:27 -0700 (PDT)
Date:   Fri, 10 May 2019 19:28:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/15] trace2: create new combined trace facility
Message-ID: <20190510172824.GR14763@szeder.dev>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
 <pull.108.v7.git.gitgitgadget@gmail.com>
 <90e4e6af9300751fd2e7e98601ed0e60ca048e05.1550874298.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90e4e6af9300751fd2e7e98601ed0e60ca048e05.1550874298.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 02:25:01PM -0800, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create a new unified tracing facility for git.  The eventual intent is to
> replace the current trace_printf* and trace_performance* routines with a
> unified set of git_trace2* routines.
> 
> In addition to the usual printf-style API, trace2 provides higer-level
> event verbs with fixed-fields allowing structured data to be written.
> This makes post-processing and analysis easier for external tools.
> 
> Trace2 defines 3 output targets.  These are set using the environment
> variables "GIT_TR2", "GIT_TR2_PERF", and "GIT_TR2_EVENT".  These may be
> set to "1" or to an absolute pathname (just like the current GIT_TRACE).
> 
> * GIT_TR2 is intended to be a replacement for GIT_TRACE and logs command
>   summary data.
> 
> * GIT_TR2_PERF is intended as a replacement for GIT_TRACE_PERFORMANCE.
>   It extends the output with columns for the command process, thread,
>   repo, absolute and relative elapsed times.  It reports events for
>   child process start/stop, thread start/stop, and per-thread function
>   nesting.
> 
> * GIT_TR2_EVENT is a new structured format. It writes event data as a
>   series of JSON records.

Please document these new environment variables in
'Documentation/git.txt', where the other environment variables,
including GIT_TRACE_*, are already documented.

While doing so, please note that the description about the possible
values of these variables and of GIT_TRACE above is incomplete,
because it's not just "1" or an absolute pathname.  Quoting the
description of GIT_TRACE:

  If this variable is set to "1", "2" or "true" (comparison is case
  insensitive), trace messages will be printed to stderr.
  
  If the variable is set to an integer value greater than 2 and lower
  than 10 (strictly) then Git will interpret this value as an open
  file descriptor and will try to write the trace messages into this
  file descriptor.

The way I see it in tr2_dst_get_trace_fd() below, this applies to
GIT_TRACE2* as well, and it even offers the possibility to specify a
Unix Domain Socket, too.


And sorry for barging in with a big bucket of paint this late, but,
really...  why GIT_TR2 instead of GIT_TRACE2?


> +int tr2_dst_get_trace_fd(struct tr2_dst *dst)
> +{
> +	const char *tgt_value;
> +
> +	/* don't open twice */
> +	if (dst->initialized)
> +		return dst->fd;
> +
> +	dst->initialized = 1;
> +
> +	tgt_value = getenv(dst->env_var_name);
> +
> +	if (!tgt_value || !strcmp(tgt_value, "") || !strcmp(tgt_value, "0") ||
> +	    !strcasecmp(tgt_value, "false")) {
> +		dst->fd = 0;
> +		return dst->fd;
> +	}
> +
> +	if (!strcmp(tgt_value, "1") || !strcasecmp(tgt_value, "true")) {
> +		dst->fd = STDERR_FILENO;
> +		return dst->fd;
> +	}
> +
> +	if (strlen(tgt_value) == 1 && isdigit(*tgt_value)) {
> +		dst->fd = atoi(tgt_value);
> +		return dst->fd;
> +	}
> +
> +	if (is_absolute_path(tgt_value))
> +		return tr2_dst_try_path(dst, tgt_value);
> +
> +#ifndef NO_UNIX_SOCKETS
> +	if (starts_with(tgt_value, PREFIX_AF_UNIX))
> +		return tr2_dst_try_unix_domain_socket(dst, tgt_value);
> +#endif
> +
> +	/* Always warn about malformed values. */
> +	tr2_dst_malformed_warning(dst, tgt_value);
> +	tr2_dst_trace_disable(dst);
> +	return 0;
> +}
