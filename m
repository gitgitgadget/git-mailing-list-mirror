Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6959C1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbdDLTWQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 15:22:16 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34534 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbdDLTWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 15:22:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id c198so18029306pfc.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vkmjY8CaJhF8/hJe0MgTpimAeEZhqRKevWpB9nWuOA=;
        b=d1rTxOFDY70ITmvrZOPbkUVeH+GL88m/MlBEQu0w2EsS4Q8DYUUgrkDRBR/2MUsMqr
         6pcKotvZEUm6bGkkp/84BhuB1kboHWS95h7cVIyvsxlJzFnbccJm1l1Sc1rzDOJ6VxO7
         0nc1/zAeQUza+J8jyfSP2Ol7q3fYegk6GTEQEU4sBcJwp6vT75qAKMN6syIdY5PWDgGg
         rDaF2lVbcNGsnM07WXm8wVjAVEEQFf6k5xlsN73W4tSNWWGjSinPYm9IMa0Z/yJGiRqE
         mBSwtG6Bg9awdXQ+qsClOnjJ0B8zLrkUngjHMpIHxVrzFVLpTATuvSot5rem+oc5PyIv
         2mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vkmjY8CaJhF8/hJe0MgTpimAeEZhqRKevWpB9nWuOA=;
        b=G4POHVCmyDLb4sEzI0U707mh1RmMNN3d9elU4X07T+GqSWPAAUa6p5W3zrn5ZrwXlm
         zS+lMdSfw3LM8U6nbrk7otj3dLJgL/fYX9OyuAO+XMmQQ4/98Rqo7XjaghvvsMzaLjNi
         S0YHsBEkonzr25sq9gHIWHHApSrlyEgl8dy/BDYHuh0m4+rlCh5YxGeSbbGU0K9wxLAU
         o2GIzuCiu/Y4eIiQILSHxQscNZUcH2PaMiKDTHsG0T53O3onzoIBuE9unhPE4ZaWzj+A
         fSol0QCDuql2NunqLxrJo9EoZ0krEQOxuLlNL7XrIhTHqgZmH7ojIt9rqzOKIfdQgMhD
         di0Q==
X-Gm-Message-State: AN3rC/6CSqtrcoW7K9rRinmuY6y1a90t3QEryI9GuiFfSNChhPX4XcxL/T51i6wr/Yna0yFi
X-Received: by 10.84.222.134 with SMTP id x6mr37709073pls.52.1492024933211;
        Wed, 12 Apr 2017 12:22:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:ec58:2634:958b:ef])
        by smtp.gmail.com with ESMTPSA id a77sm11276794pfj.1.2017.04.12.12.22.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Apr 2017 12:22:12 -0700 (PDT)
Date:   Wed, 12 Apr 2017 12:22:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] run-command: convert sane_execvp to sane_execvpe
Message-ID: <20170412192210.GB79499@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410234919.34586-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10, Brandon Williams wrote:
> Convert 'sane_execvp()' to 'sane_execvpe()' which optionally takes a
> pointer to an array of 'char *' which should be used as the environment
> for the process being exec'd.  If no environment is provided (by passing
> NULL instead) then the already existing environment, as stored in
> 'environ', will be used.

Turns out we probably can't use execvpe since it isn't portable.  From
some of the other discussion it makes more sense to just move to using
execve instead.

> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  cache.h       |  3 +--
>  exec_cmd.c    |  2 +-
>  run-command.c | 15 ++++++++++-----
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 5c8078291..10d40ecae 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -2185,8 +2185,7 @@ int checkout_fast_forward(const unsigned char *from,
>  			  const unsigned char *to,
>  			  int overwrite_ignore);
>  
> -
> -int sane_execvp(const char *file, char *const argv[]);
> +int sane_execvpe(const char *file, char *const argv[], char *const envp[]);
>  
>  /*
>   * A struct to encapsulate the concept of whether a file has changed
> diff --git a/exec_cmd.c b/exec_cmd.c
> index fb94aeba9..c375f354d 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -118,7 +118,7 @@ int execv_git_cmd(const char **argv) {
>  	trace_argv_printf(nargv.argv, "trace: exec:");
>  
>  	/* execvp() can only ever return if it fails */
> -	sane_execvp("git", (char **)nargv.argv);
> +	sane_execvpe("git", (char **)nargv.argv, NULL);
>  
>  	trace_printf("trace: exec failed: %s\n", strerror(errno));
>  
> diff --git a/run-command.c b/run-command.c
> index 574b81d3e..682bc3ca5 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -168,10 +168,15 @@ static int exists_in_PATH(const char *file)
>  	return r != NULL;
>  }
>  
> -int sane_execvp(const char *file, char * const argv[])
> +int sane_execvpe(const char *file, char * const argv[], char *const envp[])
>  {
> -	if (!execvp(file, argv))
> -		return 0; /* cannot happen ;-) */
> +	if (envp) {
> +		if (!execvpe(file, argv, envp))
> +			return 0; /* cannot happen ;-) */
> +	} else {
> +		if (!execvp(file, argv))
> +			return 0; /* cannot happen ;-) */
> +	}
>  
>  	/*
>  	 * When a command can't be found because one of the directories
> @@ -226,7 +231,7 @@ static int execv_shell_cmd(const char **argv)
>  	struct argv_array nargv = ARGV_ARRAY_INIT;
>  	prepare_shell_cmd(&nargv, argv);
>  	trace_argv_printf(nargv.argv, "trace: exec:");
> -	sane_execvp(nargv.argv[0], (char **)nargv.argv);
> +	sane_execvpe(nargv.argv[0], (char **)nargv.argv, NULL);
>  	argv_array_clear(&nargv);
>  	return -1;
>  }
> @@ -442,7 +447,7 @@ int start_command(struct child_process *cmd)
>  		else if (cmd->use_shell)
>  			execv_shell_cmd(cmd->argv);
>  		else
> -			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
> +			sane_execvpe(cmd->argv[0], (char *const*) cmd->argv, NULL);
>  		if (errno == ENOENT) {
>  			if (!cmd->silent_exec_failure)
>  				error("cannot run %s: %s", cmd->argv[0],
> -- 
> 2.12.2.715.g7642488e1d-goog
> 

-- 
Brandon Williams
