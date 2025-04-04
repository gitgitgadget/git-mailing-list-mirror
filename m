Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9B1DB154
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776128; cv=none; b=fldk6Kw+eEjvSTDNkKrbOxN2jW5m6A1kaHZmxh9heUGNH8wavMiCRK5u5yAgPBwCHmkWAiyM4x+m7Vl5M1ZSzeWip7NA6IKE5vg3KsMQbnuZQa1rY/lHA9a8A5WOq5d3POqYcBITWn5ac4/DhNK3XVaeatnSFhU5XGnh9i7Mh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776128; c=relaxed/simple;
	bh=cp70cdFq94SmOPTZE38r+082bH/Td67w2TNxgkR1z/k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kfxd3VfYSwlC9X6KWR88shHWN+x7LHiI+TjDGuWPwqMNwk5hHNVqAg158CiV4mdguX5ABGXrLz7ZnM0ZYUXWQe+BFlQgiNtQimRUyeGx4ioJk2U3xIMFD0hc6+hg1MkAEsxRTRJADzEaA+xoBMMvO2Pj23kaqoRqydhhjNwdIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR9m7PDb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR9m7PDb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso11990205e9.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776124; x=1744380924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6UAfH5q4ILuzlBiQCFk2ctnUg0ZgPoBDtajzuSC1s2U=;
        b=cR9m7PDbhhWN6Dp1VMZKCNJYWGU/4IhAYdNC/zuDm+0kYauJiv7JJ5NPbl7YQDGT7K
         ZbnH1+MmO4dSLm0+vEtYow6LWO6dH4ycbgWL+oY/P6pGqzF/a8f5rFDNSbJb2LIX9VK4
         8p3vDOVYujLFf/qTzk212tcbfG3oHUCQM/xMHLGooTleBPJvH7nnKnD1PCyuIL3yAjMJ
         ovWWOWMJAXjJIOV0ggpCDUsVCt6CXOJeZwyRZ0qh4oRDVo/8t3JDY5ABI8tWclBHJEwp
         t8u7C6hM9y5ZRE8qUvjYw/e7S7l3F7uv42laRoPKgXu13fsW0ewLTTBrvFMThdB2IjGx
         cwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776124; x=1744380924;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UAfH5q4ILuzlBiQCFk2ctnUg0ZgPoBDtajzuSC1s2U=;
        b=rfWF0LzY92swqvmLETAACWLuV6Id61aAl03EimLwTO+FOcAjAYYb5peOw13lECqNL0
         EXhH4CSZBoO9zNy+o89ffHZHt3wE4F+Rr9sOWByt3nQrBXPzXhjflvXf4M+6j/8Kxcpn
         Sg/KkGHIUMH2sI4LnE6M4tcdqusWbR2nQSPHJo3p4LH3lqxIwrgh05+xusVV6dIddgf0
         fvWe6n3X1l+bLxFyllwFPDeTG6H3znc2xWBaSm7pKvPO6r3F0yJSwe0XodUNVm1MBEFt
         CiQ+zz23sFa+28jf2dhD8fmp1Pb99BnYotaP/em/HMDzFsLMhP1sdgv2YmEDSeTEFiB9
         PpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXipSXEjIqrEzTvOmerMB5YBXmdZZ/jt0/NTo8edvhum/je+vyQLvzScvINQiPokopQNnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytad5D4CbeB+Ha3m9g5NXUAoN6JA7KoH2OCpK9IlpvtxzcoCZ8
	Y3yEJJpG9WQsUePS4YsXlVmB2EbHg15mv0nGdmzHuD3IDugCC9zI
X-Gm-Gg: ASbGnctlAnIPhzLpJHDstsQYSoSP2nGu1IMMnPgcGCLsJe8doJYtwkeAkmn9LfQk2cL
	vVhmLRZHCKBkn8UTeVcSrfrGKoLtuPnxsF1RxLGtIdP0R94GIL5KMKJ/xE6NrPTVoVFoM0fan1A
	Oc+eUo80tO1bfjikdPwZV1rk2lqOWI0eihucKEXHGSa9tS3JvazZ4MnCmuwR/lP8b9avGaXAKo2
	kLJ8zLylOH3SBvyHCT7Gur1Z4jzi6y0HwNLfDdTHAbFxRZt6aIk2cmmWf82RrnCnWCPdxf7H9Tr
	d5c/j/FoYbeMDcwnee4g0T7TcbjPKaI8HP6wFYwzcPkxUV8fArCJMEP1pB9Q10R0NH74qQ+H/Nh
	mkAkqqgKAKa5ddWDEV+DP
X-Google-Smtp-Source: AGHT+IGAPCbip5A94aspG1W86VF77o56aFeSLvSgRbXNiWRxzP6O5EHMQjf9962eLKwQptR57xRhPw==
X-Received: by 2002:a05:600c:524f:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-43ecf57e6admr28461085e9.0.1743776124102;
        Fri, 04 Apr 2025 07:15:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16313edsm50458735e9.6.2025.04.04.07.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:15:23 -0700 (PDT)
Message-ID: <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
Date: Fri, 4 Apr 2025 15:15:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] git: add --no-hooks global option
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, james@jamesliu.io, Derrick Stolee <stolee@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stolee

On 03/04/2025 23:38, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> In some situations, these hooks have poor performance and expert users
> may want to skip the hooks as they don't seem to affect the current
> situation. One example is a pre-commit hook that checks for certain
> structures in the local changes, but expert users are likely to have
> done the right thing in advance.

Next they'll be saying that they never make a mistake when writing a one 
line patch! More seriously I agree there are times when one may want to 
bypass the pre-commit hook but we already have "git commit --no-verify" 
to do that. In general hooks that are so slow that the user wants to 
bypass them are self-defeating and I'd argue that the solution is to fix 
the performance of the hook rather than make it easier to skip it. One 
solution for speeding up pre-commit hooks is to process files in 
parallel. Unfortunately git does not provide support for that but there 
are hook frameworks that do.

> I have come across users who have disabled hooks themselves either by
> deleting hooks (supported, safe) or setting 'core.hooksPath' to some
> bogus path (seems unsafe).

I thought "git -c core.hooksPath=/dev/null" was a fairly standard way of 
disabling hooks on a one-off basis - what makes it unsafe?

> The supported process is painful to swap
> between the hook-enabled scenario and the hook-disabled scenario.
> 
> To that end, add a new --no-hooks global option to allow users to
> disable hooks quickly. This option is modeled similarly to the
> --no-advice option in b79deeb554 (advice: add --no-advice global option,
> 2024-05-03). This uses a GIT_HOOKS environment variable to communicate
> to subprocesses as well as making this a backwards-compatible way for
> tools to signal that they want to disable hooks.
> 
> The critical piece is that all hooks pass through run_hooks_opt() where
> a static int will evaluate the environment variable and store that the
> variable is initialized for faster repeated runs.

That certainly makes the implementation much more viable. However I'm 
not really convinced this is a good idea.

Best Wishes

Phillip

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>      git: add --no-hooks global option
>      
>      This is hopefully a helpful feature to more than just the experts I've
>      been hearing from.
>      
>      Thanks,
>      
>       * Stolee
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1899%2Fderrickstolee%2Fno-hooks-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1899/derrickstolee/no-hooks-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1899
> 
>   Documentation/git.adoc       | 13 ++++++++++++-
>   environment.h                |  6 ++++++
>   git.c                        |  6 +++++-
>   hook.c                       |  7 +++++++
>   t/t1350-config-hooks-path.sh | 34 ++++++++++++++++++++++++++++++++++
>   5 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index 743b7b00e4d..a34c8cfbe78 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -14,7 +14,7 @@ SYNOPSIS
>       [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
>       [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
>       [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
> -    <command> [<args>]
> +    [--no-hooks] <command> [<args>]
>   
>   DESCRIPTION
>   -----------
> @@ -230,6 +230,12 @@ If you just want to run git as if it was started in `<path>` then use
>   	linkgit:gitattributes[5]. This is equivalent to setting the
>   	`GIT_ATTR_SOURCE` environment variable.
>   
> +--no-hooks::
> +	Skip running local Git hooks, even if configured locally. Hooks
> +	are an opt-in feature, so be sure that you know the impact of
> +	ignoring hooks when running with this option. This is equivalent
> +	to setting `GIT_HOOKS=0` environment variable.
> +
>   GIT COMMANDS
>   ------------
>   
> @@ -771,6 +777,11 @@ for further details.
>   	not set, Git will choose buffered or record-oriented flushing
>   	based on whether stdout appears to be redirected to a file or not.
>   
> +`GIT_HOOKS`::
> +	If this Boolean environment variable is set to false, then commands
> +	will ignore any configured hooks as if the `--no-hooks` option was
> +	provided.
> +
>   `GIT_TRACE`::
>   	Enables general trace messages, e.g. alias expansion, built-in
>   	command execution and external command execution.
> diff --git a/environment.h b/environment.h
> index 45e690f203f..22ddf201144 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -50,6 +50,12 @@
>    */
>   #define GIT_ADVICE_ENVIRONMENT "GIT_ADVICE"
>   
> +/*
> + * Environment variable used to propagate the --no-hooks global option to
> + * the hooks layer and to any child processes.
> + */
> +#define GIT_HOOKS "GIT_HOOKS"
> +
>   /*
>    * Environment variable used in handshaking the wire protocol.
>    * Contains a colon ':' separated list of keys with optional values
> diff --git a/git.c b/git.c
> index 77c43595223..d7ebcf60947 100644
> --- a/git.c
> +++ b/git.c
> @@ -41,7 +41,7 @@ const char git_usage_string[] =
>   	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
>   	   "           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]\n"
>   	   "           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]\n"
> -	   "           <command> [<args>]");
> +	   "           [--no-hooks] <command> [<args>]");
>   
>   const char git_more_info_string[] =
>   	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
> @@ -349,6 +349,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   			setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
>   			if (envchanged)
>   				*envchanged = 1;
> +		} else if (!strcmp(cmd, "--no-hooks")) {
> +			setenv(GIT_HOOKS, "0", 1);
> +			if (envchanged)
> +				*envchanged = 1;
>   		} else {
>   			fprintf(stderr, _("unknown option: %s\n"), cmd);
>   			usage(git_usage_string);
> diff --git a/hook.c b/hook.c
> index b3de1048bf4..b209553d7a8 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -144,6 +144,13 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>   
>   		.data = &cb_data,
>   	};
> +	static int do_run_hooks = -1;
> +
> +	if (do_run_hooks < 0)
> +		do_run_hooks = git_env_bool(GIT_HOOKS, 1);
> +
> +	if (!do_run_hooks)
> +		goto cleanup;
>   
>   	if (!options)
>   		BUG("a struct run_hooks_opt must be provided to run_hooks");
> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
> index 45a04929170..4c6a0eafe4e 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -48,4 +48,38 @@ test_expect_success 'core.hooksPath=/dev/null' '
>   	{ test /dev/null = "$value" || test nul = "$value"; }
>   '
>   
> +test_expect_success '--no-hooks' '
> +	rm -f actual &&
> +	test_might_fail git config --unset core.hooksPath &&
> +
> +	write_script .git/hooks/pre-commit <<-\EOF &&
> +	echo HOOK >>actual
> +	EOF
> +
> +	echo HOOK >expect &&
> +
> +	git commit --allow-empty -m "A" &&
> +	test_cmp expect actual &&
> +
> +	git --no-hooks commit --allow-empty -m "B" &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'GIT_HOOKS' '
> +	rm -f actual &&
> +	test_might_fail git config --unset core.hooksPath &&
> +
> +	write_script .git/hooks/pre-commit <<-\EOF &&
> +	echo HOOK >>actual
> +	EOF
> +
> +	echo HOOK >expect &&
> +
> +	GIT_HOOKS=1 git commit --allow-empty -m "A" &&
> +	test_cmp expect actual &&
> +
> +	GIT_HOOKS=0 git commit --allow-empty -m "B" &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
> base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff

