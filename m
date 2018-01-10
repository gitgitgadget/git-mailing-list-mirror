Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5ABB1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 18:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeAJSJt (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 13:09:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45451 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeAJSJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 13:09:48 -0500
Received: by mail-pg0-f67.google.com with SMTP id c194so10450943pga.12
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7FhW9ldpBqH7DRIBvjPXbUpVLCbjgcbv47mLloBnH28=;
        b=VibtfSw9q0dr4EnQTmTNN1s/z7hfxI4Qg0nnWyArcxvy0vZpz23fY3NQEbCuFKLvYM
         Uw4XdUTRqI01tcRJcJpQAbqqZtDtVB3NfJ28+zDq6JrVwJnL9RjxmAoHDfUYDuepDOpw
         8PwdO5fxETTIUT3tJDaCJfx2iux853EiLuNzyatTfITbnGxBjnelkM9E/BMKWKbleQGh
         IsyDM5LaSgzbC/o2lrZb+auOnFPmdZinD68NS4BQUjgqsge8UbWu6MGEa/d1HyVfBn4D
         mIqWy+icMkoz3NEqkGivHNjqFX7QTnGZvICqhhcndDZYJMdUA4VM+raf3zVwsqXkKCCT
         PqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7FhW9ldpBqH7DRIBvjPXbUpVLCbjgcbv47mLloBnH28=;
        b=jK6nUmancnNsSYMzsXwKm2vUwpCPvK3ObuJcoqIc6DPta4g6g/Cy2ZQlGE9075nQUo
         YFI3JFc+JY8DHhJjERiPyuWvLwDFBeRrAc2CzkaKFti0uQ4gRzO/8162Qa2z3GjVwf4q
         0ywqGeXKRuQKqJJ+rrOx4rLU+k0T7BflMY59OkGPUK6qgoh2DA9CDM6qfWmGpG8OtIuv
         c0OUUQEYdLAvpKvSvrSsR09NcunNbiN9YHMN2TQVXPyrULCL7q/dahgIqH+Ro5ECXHnM
         jR4IBinya/hISquEGWjAQfhAU5g9pGRxpqpKFH7b4nGKMmTRVa70b0uwNUZlnuGAIB3Z
         KFtA==
X-Gm-Message-State: AKGB3mK1KdKm9OwURP7fidoY+a3flJYQ31nXsZ+kDeXzyTLwBQZzbQD8
        Ct7/A7nQATkdkeXipGX72cOpY/YZLX4=
X-Google-Smtp-Source: ACJfBovgbksDyW2B7ykn3lgZ/d+OG1qbibLUxUvR1/j9pffFWJ/M9ZJFrU08WNGAtI1ZzppkL61wUQ==
X-Received: by 10.99.112.25 with SMTP id l25mr8461251pgc.154.1515607787577;
        Wed, 10 Jan 2018 10:09:47 -0800 (PST)
Received: from google.com ([2620:0:100e:422:d157:f909:10c:5e57])
        by smtp.gmail.com with ESMTPSA id b8sm30613557pff.26.2018.01.10.10.09.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Jan 2018 10:09:46 -0800 (PST)
Date:   Wed, 10 Jan 2018 10:09:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
Message-ID: <20180110180945.GA53941@google.com>
References: <20180110104835.22905-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180110104835.22905-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10, Nguyễn Thái Ngọc Duy wrote:
> Occasionally submodule code could execute new commands with GIT_DIR set
> to some submodule. GIT_TRACE prints just the command line which makes it
> hard to tell that it's not really executed on this repository.
> 
> Print env variables in this case. Note that the code deliberately ignore
> variables unsetting because there are so many of them (to keep git
> environment clean for the next process) and really hard to read.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  A minor thing that I ignored in this patch is quoting the environment
>  variables. For me it's meh. Perhaps I should just dumb the env
>  without quoting at all.

A patch like this would have been very helpful to me on some previous
occasions, so thanks for writing it up.

> 
>  run-command.c |  3 ++-
>  trace.c       | 38 +++++++++++++++++++++++++++++++++++---
>  trace.h       | 18 +++++++++++++++---
>  3 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 31fc5ea86e..235367087d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -624,7 +624,8 @@ int start_command(struct child_process *cmd)
>  		cmd->err = fderr[0];
>  	}
>  
> -	trace_argv_printf(cmd->argv, "trace: run_command:");
> +	trace_env_argv_printf(cmd->env, cmd->argv, "trace: run_command:");
> +
>  	fflush(NULL);
>  
>  #ifndef GIT_WINDOWS_NATIVE
> diff --git a/trace.c b/trace.c
> index b7530b51a9..d8967b66e8 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -146,7 +146,26 @@ static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
>  	print_trace_line(key, &buf);
>  }
>  
> +static void concatenate_env(struct strbuf *dst, const char *const *env)
> +{
> +	int i;
> +
> +	/* Copy into destination buffer. */
> +	strbuf_grow(dst, 255);
> +	for (i = 0; env[i]; ++i) {
> +		/*
> +		 * the main interesting is setting new vars
> +		 * e.g. GIT_DIR, ignore the unsetting to reduce noise.
> +		 */

I think you're missing a word, maybe:
  'The main interesting part is setting new vars'

> +		if (!strchr(env[i], '='))
> +			continue;
> +		strbuf_addch(dst, ' ');
> +		sq_quote_buf(dst, env[i]);
> +	}

At first when i read this I was under the impression that the whole
environment was going to be printed out...but i now realize that this
tracing  will only print out the delta's or the additions to the
environment that the child will see.  Maybe this should be called out
more clearly in the commit message?

> +}
> +
>  static void trace_argv_vprintf_fl(const char *file, int line,
> +				  const char *const *env,
>  				  const char **argv, const char *format,
>  				  va_list ap)
>  {
> @@ -157,6 +176,9 @@ static void trace_argv_vprintf_fl(const char *file, int line,
>  
>  	strbuf_vaddf(&buf, format, ap);
>  
> +	if (env)
> +		concatenate_env(&buf, env);
> +
>  	sq_quote_argv(&buf, argv, 0);
>  	print_trace_line(&trace_default_key, &buf);
>  }
> @@ -214,7 +236,16 @@ void trace_argv_printf(const char **argv, const char *format, ...)
>  {
>  	va_list ap;
>  	va_start(ap, format);
> -	trace_argv_vprintf_fl(NULL, 0, argv, format, ap);
> +	trace_argv_vprintf_fl(NULL, 0, NULL, argv, format, ap);
> +	va_end(ap);
> +}
> +
> +void trace_env_argv_printf(const char *const *env, const char **argv,
> +			   const char *format, ...)
> +{
> +	va_list ap;
> +	va_start(ap, format);
> +	trace_argv_vprintf_fl(NULL, 0, env, argv, format, ap);
>  	va_end(ap);
>  }
>  
> @@ -251,12 +282,13 @@ void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
>  	va_end(ap);
>  }
>  
> -void trace_argv_printf_fl(const char *file, int line, const char **argv,
> +void trace_argv_printf_fl(const char *file, int line,
> +			  const char *const *env, const char **argv,
>  			  const char *format, ...)
>  {
>  	va_list ap;
>  	va_start(ap, format);
> -	trace_argv_vprintf_fl(file, line, argv, format, ap);
> +	trace_argv_vprintf_fl(file, line, env, argv, format, ap);
>  	va_end(ap);
>  }
>  
> diff --git a/trace.h b/trace.h
> index 88055abef7..830d9dcd19 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -34,6 +34,10 @@ extern void trace_printf_key(struct trace_key *key, const char *format, ...);
>  __attribute__((format (printf, 2, 3)))
>  extern void trace_argv_printf(const char **argv, const char *format, ...);
>  
> +__attribute__((format (printf, 3, 4)))
> +extern void trace_env_argv_printf(const char * const*env, const char **argv,
> +				  const char *format, ...);
> +
>  extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
>  
>  /* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
> @@ -93,7 +97,14 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
>  	do {								    \
>  		if (trace_pass_fl(&trace_default_key))			    \
>  			trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
> -					    argv, __VA_ARGS__);		    \
> +					     NULL, argv, __VA_ARGS__);	    \
> +	} while (0)
> +
> +#define trace_env_argv_printf(env, argv, ...)				    \
> +	do {								    \
> +		if (trace_pass_fl(&trace_default_key))			    \
> +			trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, 	    \
> +					     env, argv, __VA_ARGS__); 	    \
>  	} while (0)
>  
>  #define trace_strbuf(key, data)						    \
> @@ -121,8 +132,9 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
>  __attribute__((format (printf, 4, 5)))
>  extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
>  				const char *format, ...);
> -__attribute__((format (printf, 4, 5)))
> -extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
> +__attribute__((format (printf, 5, 6)))
> +extern void trace_argv_printf_fl(const char *file, int line,
> +				 const char *const *env, const char **argv,
>  				 const char *format, ...);
>  extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
>  			    const struct strbuf *data);
> -- 
> 2.15.1.600.g899a5f85c6
> 

-- 
Brandon Williams
