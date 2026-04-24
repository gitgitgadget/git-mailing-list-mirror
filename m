Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD0288AD
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052570; cv=none; b=I/1W8mL53POQhiKOloLLQzfomN7SR215Rf7KiLwsnXnmkf1Y1vnngfF1weNwRInjZUNkzFFOQjdzKn4fjATRKRkCQp9YSDEH4bCyDC7F1glxIScfrWbF+h0dmL8JEvQhip9EEnYa07SlbTuu0kF5zVjo9xjUCo8SjDg96Xklk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052570; c=relaxed/simple;
	bh=uEplL1yvIFJ4nsS5PI61R6XTRU2N4gmYcsd1hTZ2Coo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPJfhmiYQ2WgoSMtPKlyM4lm8IFuObwWVZuXraOBRx3LNHAKX8+WxY2ETcRBmzaFXEXLoyHbzzTktAfULm6ja6QRkgU3oGKBbdh7sQ1kvPgCjCSu/PnhDAyhQZq58Hw5Ypu4xPCwoYnLa0vwdJaclNjYqK5d5kosb3UIiA8WZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJHcqW2d; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJHcqW2d"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-362e30526f8so758377a91.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777052569; x=1777657369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYb/0R9KG7ikfhm0wR7P2wk7VvJCf9igLwL/tiQFdg8=;
        b=pJHcqW2dctNLMGAovzDI9o60ZuBMUFAzY2NhU+IibcPZ0cEbALGoQMxHfQ3ulKF2RH
         Es0xRDPcDEnW4EmT3QEpnPVP1FxWjnIzHC8JN/WM2N/r0Aru0wGMg7r5wN7jD+IyAPR6
         s0b0TnTk2dAFiRqrrwjby3wnH9Fp1fj3Ue7CMFf/cYOaWHI04YbhqGqbww7E35yVIcJJ
         BERL4z/CKT+3GncbUsgz1fRWoCeuJ/n9hHd9k+cDfyN9nEh5vOwSxzYZTCaxNSJ4YGEf
         ShfLxHc/MAwqB0vpsaDLWyQXyt6f3vUtB1aqD+7Wo/UVcLQ8KpyRyEFZrDeXkrLUwB16
         y4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777052569; x=1777657369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYb/0R9KG7ikfhm0wR7P2wk7VvJCf9igLwL/tiQFdg8=;
        b=Mg0/VWWDgduSjb/fE5AxmPvlcFbbmW16fggnHbc+RB24WjT3wldDTanL6jT8j7PhXO
         F25wMDPj6h8wKOxPSK+ZNapXdXFCDBQ9FX4rljYpgYxDxZe92Bpd6JkzwNU2zq8tET0k
         HWHlZLZMf5CZRSC5ebkMjqGjEaz9BBfQOr4i+aXsKgMooiSRVCQQcGc0gswWQnaJ2aRi
         T7DRc4WZOh7xOaM/VDVtnt9E424TSBJ6DyZ0UXV2oJSOq6UBFQxw5loAQQWOIVWVPkw+
         yeRCJ1t+2g1f2HHVVuwyLLK7csktv6c6pSsqOAFhFLckTRFV/Yj26cEGx/0e4q9uUmsZ
         FrKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ik2Dkra8b+IHgUicPp6bfTLkiU6bIFrR47hmE6GQioYptgZBYh1Q3lGfAFvZ0sg/fku0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmsZ86kGBKNgEjMdt7Hb6KRK95EbLF5HH8+84Qc4CqKm3goXa
	Qq9NzBZa8UCzExW2+BvL98veoOK17tiSpkz53jq7xsO7JilwPH2U6JxA
X-Gm-Gg: AeBDiet2gPQ47pGaH5ZJ7eoksI090t0gLJjF+UFIzIrjxnYXjq0rT9HRNDE+KkdqUds
	HRh/V9yTRJcCMFytHLEt1xapuZMaM7GnE0SPgeZN6V9kEtSLKwodwjwSYsmAdaOW5YqQ0LKo5V9
	WjZgtjfaUDTPHk5LRofjiGX4UfgfVgJPwkH27cMQPOFiUFcw9BHlIjqqg3od5qosSsBWq7UlSMJ
	Tu/FKxVYygTWDxMRCaojCuIXdVlclIBOGEyQQ5B59mRJzuezbomnVDYKeLtP6gB773sO0F/pt1N
	ZTKI0xN0v7+Cz1mwxJWspwlKKD6e0o6dymc7QuhWGd1n8KFKFz86vnfyTG5JWTs3jEM5/Jri9Mo
	aZyTYBrog/AYCbFMdOOIZWdTcmnnDDuZovZEG1g/zrSPH8WgHWGTyJJFvqFXrQJc7K6V/3uv7Lh
	Ii3aev+bGWQtmklLwmf8DnbrXpApFiSD2/SA==
X-Received: by 2002:a17:90b:4ecc:b0:35b:e553:9cc2 with SMTP id 98e67ed59e1d1-361404b9802mr32331490a91.26.1777052568371;
        Fri, 24 Apr 2026 10:42:48 -0700 (PDT)
Received: from [192.168.4.37] ([38.30.145.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fb4b4b5sm12991924a91.3.2026.04.24.10.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 10:42:47 -0700 (PDT)
Message-ID: <42a620db-6110-4894-97fb-8e49ec577817@gmail.com>
Date: Fri, 24 Apr 2026 11:42:46 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving
 start-point
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@gmail.com>
In-Reply-To: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-04-24 04:03, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a --fetch option to git checkout and git switch, plus a
> checkout.autoFetch config to enable it by default. When set and the
> start-point argument names a configured remote (either bare, like
> "origin", or prefixed, like "origin/foo"), fetch that remote before
> resolving the ref. Aborts the checkout if the fetch fails.

Why tie the behaviour to the nature of the start-point?  That seems 
over-designed and prone to tripping people up.  Are you trying to cater 
to users who have multiple remotes?

I can imagine people who just want to do a checkout of anything after 
fetching -- maybe they want to checkout a new tag, or some other 
detached HEAD, or just an already-existing local branch.  They see that 
checkout has this nifty --fetch option so they think they can combine
	git fetch; git checkout
into a single command ... but no, only if they checkout something in a 
remote's namespace.

I don't personally feel the need for this new option, but I think you'll 
have a much easier time implementing and maintaining it if you just make 
--fetch do a plain fetch without caring about what the starting-point is.

		M.


> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      checkout: add --fetch to fetch remote before resolving start-point
>      
>      A workflow I run several times a day looks like:
>      
>      git fetch origin
>      git checkout -b new_branch origin/some-branch
>      
>      
>      The first command exists purely to make the second one see an up-to-date
>      view of the remote. If I forget it, origin/some-branch points at a stale
>      commit, and I end up creating a local branch from the wrong starting
>      point.
>      
>      This series teaches git checkout (and git switch) a new --fetch flag
>      that folds the two steps into one:
>      
>      git checkout --fetch -b new_branch origin/some-branch
>      
>      
>      When the start-point argument names a configured remote — either bare
>      (origin, which resolves to the remote's default branch) or in / form —
>      git fetch is run before the start-point is resolved. If the fetch fails,
>      the checkout aborts and no local branch is created.
>      
>      A new checkout.autoFetch config option enables the same behavior by
>      default, for users who always want it.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v1
> Pull-Request: https://github.com/git/git/pull/2281
> 
>   builtin/checkout.c    | 48 ++++++++++++++++++++++++++++++++++++++--
>   t/t7201-co.sh         | 51 +++++++++++++++++++++++++++++++++++++++++++
>   t/t9902-completion.sh |  1 +
>   3 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e031e61886..c8fbc4923b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -30,7 +30,9 @@
>   #include "repo-settings.h"
>   #include "resolve-undo.h"
>   #include "revision.h"
> +#include "run-command.h"
>   #include "setup.h"
> +#include "strvec.h"
>   #include "submodule.h"
>   #include "symlinks.h"
>   #include "trace2.h"
> @@ -61,6 +63,7 @@ struct checkout_opts {
>   	int count_checkout_paths;
>   	int overlay_mode;
>   	int dwim_new_local_branch;
> +	int auto_fetch;
>   	int discard_changes;
>   	int accept_ref;
>   	int accept_pathspec;
> @@ -112,6 +115,34 @@ struct branch_info {
>   	char *checkout;
>   };
>   
> +static void fetch_remote_for_start_point(const char *arg)
> +{
> +	const char *slash;
> +	char *remote_name;
> +	struct remote *remote;
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +	if (!arg || !*arg)
> +		return;
> +
> +	slash = strchr(arg, '/');
> +	if (slash == arg)
> +		return;
> +	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
> +
> +	remote = remote_get(remote_name);
> +	if (!remote || !remote_is_configured(remote, 1)) {
> +		free(remote_name);
> +		return;
> +	}
> +
> +	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
> +	cmd.git_cmd = 1;
> +	free(remote_name);
> +	if (run_command(&cmd))
> +		die(_("failed to fetch start-point '%s'"), arg);
> +}
> +
>   static void branch_info_release(struct branch_info *info)
>   {
>   	free(info->name);
> @@ -1237,6 +1268,10 @@ static int git_checkout_config(const char *var, const char *value,
>   		opts->dwim_new_local_branch = git_config_bool(var, value);
>   		return 0;
>   	}
> +	if (!strcmp(var, "checkout.autofetch")) {
> +		opts->auto_fetch = git_config_bool(var, value);
> +		return 0;
> +	}
>   
>   	if (starts_with(var, "submodule."))
>   		return git_default_submodule_config(var, value, NULL);
> @@ -1942,8 +1977,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   			opts->dwim_new_local_branch &&
>   			opts->track == BRANCH_TRACK_UNSPECIFIED &&
>   			!opts->new_branch;
> -		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
> -					     &new_branch_info, opts, &rev);
> +		int n;
> +
> +		if (opts->auto_fetch)
> +			fetch_remote_for_start_point(argv[0]);
> +
> +		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
> +					 &new_branch_info, opts, &rev);
>   		argv += n;
>   		argc -= n;
>   	} else if (!opts->accept_ref && opts->from_treeish) {
> @@ -2052,6 +2092,8 @@ int cmd_checkout(int argc,
>   		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
>   		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
>   			 N_("auto advance to the next file when selecting hunks interactively")),
> +		OPT_BOOL(0, "fetch", &opts.auto_fetch,
> +			 N_("fetch from the remote first if <start-point> is a remote-tracking ref")),
>   		OPT_END()
>   	};
>   
> @@ -2102,6 +2144,8 @@ int cmd_switch(int argc,
>   			 N_("second guess 'git switch <no-such-branch>'")),
>   		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
>   			 N_("throw away local modifications")),
> +		OPT_BOOL(0, "fetch", &opts.auto_fetch,
> +			 N_("fetch from the remote first if <start-point> is a remote-tracking ref")),
>   		OPT_END()
>   	};
>   
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..60ddebd9c3 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -801,4 +801,55 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
>   	test_cmp_config "" --default "" branch.main2.merge
>   '
>   
> +test_expect_success 'setup upstream for --fetch tests' '
> +	git checkout main &&
> +	git init fetch_upstream &&
> +	test_commit -C fetch_upstream u_main &&
> +	git remote add fetch_upstream fetch_upstream &&
> +	git fetch fetch_upstream &&
> +	git -C fetch_upstream checkout -b fetch_new &&
> +	test_commit -C fetch_upstream u_new
> +'
> +
> +test_expect_success 'checkout --fetch -b picks up branch created upstream after clone' '
> +	git checkout main &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
> +	git checkout --fetch -b local_new fetch_upstream/fetch_new &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD
> +'
> +
> +test_expect_success 'checkout --fetch with bare remote name fetches the remote' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_new2 &&
> +	test_commit -C fetch_upstream u_new2 &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
> +	git checkout --fetch -b local_from_remote fetch_upstream &&
> +	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
> +'
> +
> +test_expect_success 'checkout --fetch aborts and does not create branch on fetch failure' '
> +	git checkout main &&
> +	test_might_fail git branch -D bogus &&
> +	test_must_fail git checkout --fetch -b bogus fetch_upstream/does_not_exist &&
> +	test_must_fail git rev-parse --verify refs/heads/bogus
> +'
> +
> +test_expect_success 'checkout.autoFetch=true enables fetching without --fetch' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_cfg &&
> +	test_commit -C fetch_upstream u_cfg &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
> +	git -c checkout.autoFetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
> +'
> +
> +test_expect_success 'switch --fetch -c picks up branch created upstream after clone' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_switch &&
> +	test_commit -C fetch_upstream u_switch &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
> +	git switch --fetch -c local_switch fetch_upstream/fetch_switch &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
> +'
> +
>   test_done
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 2f9a597ec7..dc1d63669f 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2602,6 +2602,7 @@ test_expect_success 'double dash "git checkout"' '
>   	--ignore-other-worktrees Z
>   	--recurse-submodules Z
>   	--auto-advance Z
> +	--fetch Z
>   	--progress Z
>   	--guess Z
>   	--no-guess Z
> 
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0

