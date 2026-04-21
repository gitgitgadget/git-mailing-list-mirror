Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A23D8906
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785303; cv=none; b=ZNjzx01Y7wVxhKs5gtWfLgcFTNLnG6T7/rNtBzMujvbHhMAdXCUTugHvUJTjUiQBCuWiJHw9USvy3cT0em3jd5ewvpilg3Z2KeJ//qG4NSgApbpuWdR+ERzqp/1mDiz2HrkCWn+TaSrpplzeuokKCvIu81FcjlUCQS+lIyy4pR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785303; c=relaxed/simple;
	bh=yT9bnnBLc5RImHOWe5uNvwJjdibGYZDIUZXHtMi0Mdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsyhS9cDH6r2DYUu5cJdu455fmVNhXjUmWD+CnuJ/8JLevyTROGQHTzglyvm56vu0jhXIP2k8VIEoAvb0ZMtfjKNbqfp5LfPt80q4OHMEU5mIWf0hVZ/68UtrclcUUfM+agdjBvHp8ozOqqzEPY6j6kKbIhF5dkoP1rGJkNjCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So5JdEdp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So5JdEdp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso40550175e9.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776785300; x=1777390100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LoqOM49sKuZdDx/CFN5JZG7ukXOpVEOxo5/OLP+vP10=;
        b=So5JdEdpAoicNvh3DAGDSd7rhcjBmIcA25XcoU+R/0khdO4aHgV6+mXn5j6qdFL0Xm
         GRZrfSV0Rz0MVc+vZrTppXTSRbprC5tMjO32Rt8MNM/7nOpQNp3ADB4yclUR9AweTo/N
         H6o0Z6sY2yhjxP83TX6xvl1t1hl7u2BYsLmhE2uyGIwO1p9wKfEKkh5t+7InRFl6fm7W
         eTxt6w3ysGCDFqlzZHh42ibzjvujtFjmkcmsCddei5xAjd8+RQMgMHDbgyYKXF2R5pcO
         1O3R9YtjFZu1YrVysNoSoAXnTo2q6RzoFZnxZuYeR3iLpiOAPZ7KCJczj1CSExBkAQBU
         1RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785300; x=1777390100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoqOM49sKuZdDx/CFN5JZG7ukXOpVEOxo5/OLP+vP10=;
        b=CThi++HQjJ8L8Dl/0F5asuf8Aq2jHGlLDCGc13I3O1sKSjy7urO/qfZeUSLknb61S3
         Zl8G3I2DEA/oQO3il1TYviKvdPu5K6GY1UN+pBK+epLz2pkNd5x2HZ80/dMC4YPat/WZ
         qC+NzQRNIM8UOkooh/oBqEbht9HcTw2mjiAftUMhdqnTity3EjiyMMsvkVOUy+x+pI4B
         hNnXGz/AhzEBpAkSnXVwNiVjd9WkYCCm0e+bJwxa2B7h5ovSs3fYB85gm+hIxERrLTwp
         +6gZFkDHwNFngC9zJKxfCGwmvFO4j3Ki6UxtH2iVHXmrbkQBfich36cKE68RciDwsT07
         gtmg==
X-Forwarded-Encrypted: i=1; AFNElJ8Mdh9T21o53t8/xzOib7w+qFBtBNyfH4py3JE2spuVZUDM4UNISfOErEjRjsbmMh4W/ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEgWtSll+Tpr89nV72u24s9pnCdSC6qtwt2tVCP4EkebX3vbn
	xBymBKgTKx314SdDhQJMn004Fh/dq9FvZEDnlZZbfsIgr/bnLNrrxbf8
X-Gm-Gg: AeBDiesdPQO+SLC0zdQkT5nXhb6os2Y6s9kxdpXlZ4ml6dAsXA7BF/G41lbEEOIOD0P
	xRwlbGperUNAMTESZW+7ZkbdWxdQZ3YAztXRxVnPIiKYXZwtDfysl4zInjpyDev8HcdNA33Toa0
	eEmiImEgR/o7Q7q9pQLsGg435OSdYF4bXxlODbo7Zd43jf3rS0PRkIHVDJdi21iLAmuPogDC2Z/
	n1n16ZlVQtRBnUGRKThG6wZf36hQMbPPilZacrcQHFTpsjBB/p6IGfjaNVallzZb9UfPz0JPXsT
	76u+esZp25xJuHEtRJOv0nC08iWxNsHrZymg3ztQq1qWyupG/JfIL0AaA4TWc74jPoOnjVlP9Sk
	Dr7IRn/pNdWxCDWd3tM3RWBzGfxnYY8JMifymEVs3XknhZbJi+FK0xEWuA5xe2RcjVQ6DG3XuYx
	XICwrkvdk91v0s/qWCsHhcVWF/q97zDc+nD2EJiDowANvCxKOSA1eDCKKaN+cgrJlbp22N0rzPs
	KIXOClcSBvpbQ==
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-48a58ae9f69mr22225645e9.19.1776785300120;
        Tue, 21 Apr 2026 08:28:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cdfcd50sm61945175e9.9.2026.04.21.08.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 08:28:18 -0700 (PDT)
Message-ID: <980af898-5a56-4bc1-9222-74ceb9de9fac@gmail.com>
Date: Tue, 21 Apr 2026 16:28:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] stash: assume "push" when command line starts with an
 option
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>, git@vger.kernel.org
Cc: ben.knoble@gmail.com, mroik@delayed.space, quentin.bernet@bluewin.ch,
 gitster@pobox.com
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260419165453.32593-1-deveshigurgaon@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260419165453.32593-1-deveshigurgaon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/04/2026 17:54, Deveshi Dwivedi wrote:

This has changed more than I was expecting it to, but I think the 
approach of checking if argv[0] starts with '-' in cmd_stash() makes 
sense. I've left a few comments below.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 95c5005b0b..bf04cf58a6 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1831,9 +1831,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   }
>   
>   static int push_stash(int argc, const char **argv, const char *prefix,
> -		      int push_assumed)
> +		      const char * const usage[])
>   {
> -	int force_assume = 0;
>   	int keep_index = -1;
>   	int only_staged = 0;
>   	int patch_mode = 0;
> @@ -1868,26 +1867,14 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>   	};
>   	int ret;
>   
> -	if (argc) {
> -		int flags = PARSE_OPT_KEEP_DASHDASH;
> -
> -		if (push_assumed)
> -			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
> -
> +	if (argc)
>   		argc = parse_options(argc, argv, prefix, options,
> -				     push_assumed ? git_stash_usage :
> -				     git_stash_push_usage, flags);
> -		force_assume |= patch_mode;
> -	}
> +				     usage,
> +				     PARSE_OPT_KEEP_DASHDASH);

As all we do with '--' is remove it now that we don't need to check if 
it was passed, there is not much point in asking parse_options() to keep 
it for us. You can just pass '0' here and drop the if statement below.

>   
> -	if (argc) {
> -		if (!strcmp(argv[0], "--")) {
> -			argc--;
> -			argv++;
> -		} else if (push_assumed && !force_assume) {
> -			die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
> -			    argv[0]);
> -		}
> +	if (argc && !strcmp(argv[0], "--")) {
> +		argc--;
> +		argv++;
>   	}
>   
>   	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
> @@ -1935,7 +1922,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>   static int push_stash_unassumed(int argc, const char **argv, const char *prefix,
>   				struct repository *repo UNUSED)
>   {
> -	return push_stash(argc, argv, prefix, 0);
> +	return push_stash(argc, argv, prefix, git_stash_push_usage);
>   }
>   
>   static int save_stash(int argc, const char **argv, const char *prefix,
> @@ -2387,7 +2374,6 @@ int cmd_stash(int argc,
>   {
>   	pid_t pid = getpid();
>   	const char *index_file;
> -	struct strvec args = STRVEC_INIT;
>   	parse_opt_subcommand_fn *fn = NULL;
>   	struct option options[] = {
>   		OPT_SUBCOMMAND("apply", &fn, apply_stash),
> @@ -2427,19 +2413,22 @@ int cmd_stash(int argc,
>   	else if (!argc)
>   		return !!push_stash_unassumed(0, NULL, prefix, repo);
>   
> -	/* Assume 'stash push' */
> -	strvec_push(&args, "push");
> -	strvec_pushv(&args, argv);> +	if (argv[0][0] != '-')
> +		die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
> +		    argv[0]);

If there's no option then we die straight away which makes sense. Part 
of me wonders if we should also show the usage for "git stash" in case 
the user misspelled a subcommand name. The other part of me finds the 
way git is so keen to print reams of usage at the slightest provocation 
quite annoying, but at least the "git stash" usage is fairly small. 
Looking at the history we used to complain about an unknown subcommand 
but that was changed without any explanation in 8c3713cede (stash: 
eliminate crude option parsing, 2020-02-17)

>   	/*
> -	 * `push_stash()` ends up modifying the array, which causes memory
> -	 * leaks if we didn't copy the array here.
> +	 * When the command line starts with an option, assume 'push'.
> +	 * Unshift "push" into argv so that parse_options() skips it
> +	 * as the subcommand name.  Use git_stash_usage so that invalid
> +	 * options show the general stash usage rather than the
> +	 * push-specific usage.
>   	 */

I'm not really sure if this change to the usage is an improvement or 
not. If we document that an option without a subcommand means "push" 
then isn't it confusing to show the usage for "git stash" rather than 
"git stash push"?

> -	DUP_ARRAY(args_copy, args.v, args.nr);
> -
> -	ret = !!push_stash(args.nr, args_copy, prefix, 1);
> -
> -	strvec_clear(&args);
> +	ALLOC_ARRAY(args_copy, argc + 1);
> +	args_copy[0] = "push";
> +	memcpy(&args_copy[1], argv, argc * sizeof(const char *));
> +	argc++;

Taking a shallow copy avoids the memory leak mentioned in the comment 
you edited above. That might be worth doing but it should be done as a 
separate preparatory step because it is orthogonal to the other changes 
here. We should use COPY_ARRAY() rather than memcpy() and we should also 
allocate 'argc + 2' and copy 'argc + 1' elements to keep the array NULL 
terminated as it was prior to 2e875b6cb4 (builtin/stash: fix various 
trivial memory leaks, 2024-08-01).

Thanks

Phillip


> +	ret = !!push_stash(argc, args_copy, prefix, git_stash_usage);
>   	free(args_copy);
>   	return ret;
>   }
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..836cc29a6b 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -410,8 +410,34 @@ test_expect_success 'stash --staged with binary file' '
>   '
>   
>   test_expect_success 'dont assume push with non-option args' '
> -	test_must_fail git stash -q drop 2>err &&
> -	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
> +	test_must_fail git stash someunknown 2>err &&
> +	test_grep "subcommand wasn${SQ}t specified; ${SQ}push${SQ} can${SQ}t be assumed due to unexpected token ${SQ}someunknown${SQ}" err
> +'
> +
> +test_expect_success 'assume push when command line starts with option' '
> +	test_when_finished "git reset --hard" &&
> +	test_when_finished "rm -f untracked-file" &&
> +	echo changed >file &&
> +	git add file &&
> +	git stash -m "implied push" file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --staged file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --keep-index file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --no-keep-index file &&
> +	git stash pop &&
> +
> +	echo untracked >untracked-file &&
> +	git stash --include-untracked untracked-file &&
> +	test_path_is_missing untracked-file &&
> +	git stash pop
>   '
>   
>   test_expect_success 'stash --invalid-option' '
> 
> base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0

