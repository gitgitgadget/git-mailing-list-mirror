Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E672F7F0F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516781; cv=none; b=Vj4cmJ7Dj70G2uSvYrUe0hEE0/sZu+K4YEo9OqHxwpvweplj9touFEaUtjyxLdBJr9+1pNzyldMHCy65fULEQv2JWBaMEX7pX0i53GZcoxNgmDkdmDR+9+b6BJ6N/38pOy0QhwoEvlCzZqlNzZjJoaBO1YZFL7WULr2epT+YgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516781; c=relaxed/simple;
	bh=KS24NzYc5EqmgT+r4bcZ4NFikhXUd7jxt1XeWQiNrdA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NmAA9nTJNW2SGvh+/Znr39hR1QD8k/qghLl0EE1t9utVaVFYJq9j1YYD6hleUHTO5uZ9TAOUtSv+H8rjpoFCF8VjQv5RfuC0cEculI3QXAKaVntGpatJpOdVGDMTxdEzC8AR3CqZIxZiwrAb6kHXExKA+Cz4QHVW7G30us1ICog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sq5upz5i; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq5upz5i"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec3f69d343so444543366b.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516778; x=1782121578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZbrhEEn3fWw4pvhzgU/7/uCcmRISNyZFfF/t3iVL5g=;
        b=sq5upz5iMViLunOJwpNXcjQVscYkjLwBzi2lQ8YogB0kJbZc6YO0zxdzThdDagbcf5
         Jnhp9/CD5mU/m5IbzsLcwOlJJDP2gtlgpBSXF25W/3B26+5fr0MzzES2QjiDJTPgnZEB
         eDogXqPK3R93SL7kGUCYrmQEIp+7wUE3ukCvgU8RU9yVGnaDbniRElUz346Beg3lISsy
         v+tPQXi948OTlCNTqz7Rm+vKGCTnTs9+/+IDEuZod9onOxzGVuV5dR3RmJOOaz6jCrmy
         RdjKJvU/euIIKLiMwM+ob8sBEZV/uzzi/hc9njImNdBmrfvUszvM3q+/QyMCyWfX+PSd
         k8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516778; x=1782121578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZbrhEEn3fWw4pvhzgU/7/uCcmRISNyZFfF/t3iVL5g=;
        b=WgUPtUc9RSNYS6OHZG7ZztmwG64wvXZKEnncb8Du8KqN0VeDMQm3iKSrnTyI+eqVHe
         1rYakcpg45tqldz4loZT7YE4YphAMwxLafYG3yr2xuTRnYXJBR53D5FUiQlJd/KMFRzF
         aGdmw9TLUT0kE6PQ/8Jb/pvfx6OUgU+0f13h9FgATTkUExIjXfiscnVcSs3St6vLHLjb
         cnV1iko5x3n4Piutmlc3dM1SctTwSXnQeA8gFrEhKZJGUZI07Y9zG7zen3SCA1t81f2L
         Xk3ihSn0nbG6t7ZGN1UUdGchkpOyheC7Pzs1W05Dt/934wxcC/o5qNKpG9WVXXDUyKpo
         Cysg==
X-Forwarded-Encrypted: i=1; AFNElJ/bpDz1+xYFROps54YrzMoIkCroB313rnSV+LI38+BNyIBwR22TBV/3FVAqBRlWB4iCdhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O7k/kqQOi6ZjHrtJ3BB8wWnO4QinLow270nIAe11JUO1GfBj
	/Bs3k4AiYDZqoE1OBh2BxqsxsElactISDWhDWUpn0+X6yE9tZykHdF9a7QTsJQ==
X-Gm-Gg: Acq92OHfGHFtlQRyRpWBOCU/JJqCxf9d06JxBhEI8Fwk62Uve/2Uh9fS7bUkvOFYJdO
	7baIPLpeI/Vbm91XCNunJSjKIC6PtmQUELMq+Xxw+OoIejD/nQi1FJiYjzuzL2y+Iw/bap0hPGs
	rmSo6syjUtfsXmLuGYJQKY7JZ+C01XZdyHDCwMnGqbA+84dqgNF0zfWIug3L6Mh8jCAHwKFm9OO
	uooOuVRMBnobYdoUlXCVRVXKo6QcjO0zPjoz21tnE5m8C72df50oT2UNPzZuWNsr9I0DaKNJUT3
	wPrdY1LS662J9Q7GugJu/sg3dtTC6LRz+J7gxg0KbdUfX3k9Fn0EtM5GBQRyw4+zzseDTlQiv0d
	vHTvrv2s+Hs1Hh4kQC3XrhsnKUnLrlqg90A6zBjZ5UpbSi3+ADP+lOVToLBhKq3kPTwNNNe7Wn1
	wYJq9puSponTShJFOFP7GFHshlcq+9UaD4C+Hy6/k9nN2ciYD1ho6ld1P5gTQOHeB0kdnbviHed
	DmZPnv5l9Gp0qWxvH01Cw==
X-Received: by 2002:a17:906:c14f:b0:bfa:320c:b93b with SMTP id a640c23a62f3a-bff4bdfcac6mr460978166b.25.1781516777626;
        Mon, 15 Jun 2026 02:46:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:786c:b99d:5866:4e92? ([2a0a:ef40:69a:b801:786c:b99d:5866:4e92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4420966sm440115566b.9.2026.06.15.02.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:46:16 -0700 (PDT)
Message-ID: <7e4d97d9-e21a-4f13-ab2c-ac1eb125271c@gmail.com>
Date: Mon, 15 Jun 2026 10:46:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> 	git branch --prune-merged <branch>...

Please see my comments on the previous version about the naming of this 
option. I really think we need to start a discussion to find a better 
name for this option as the other options to delete a branch are named 
"delete" rather than "prune" and this does not remove the branches 
listed by "--merge"

> deletes the local branches that "--forked <branch>" would list,
> keeping only those whose tip is reachable from their configured
> upstream: the work has already landed on the upstream they track,
> so the local copy is no longer needed.
> 
> Reachability is read from local refs; nothing is fetched. Run
> "git fetch" first if you want fresh upstream refs.

I don't  think this sentence adds anything - git never fetches unless 
the user explicitly asks it to.

> 
> Three kinds of branches are spared:
> 
>    * any branch checked out in any worktree;
>    * any branch whose upstream no longer resolves locally, since a
>      missing upstream is not by itself a sign of integration;
>    * any branch whose push destination equals its upstream
>      (<branch>@{push} is the same as <branch>@{upstream}), such as
>      a local "main" that tracks and pushes to "origin/main". Right
>      after a pull it just looks "fully merged", so it is left
>      alone. Only branches that push somewhere other than their
>      upstream, typically topics in a fork workflow, are candidates.
> 
> Branches that are not yet merged into their upstream are reported
> as a short warning and skipped, so one unmerged topic does not
> abort the whole sweep.

I'm not sure about this warning - the user has asked us to delete the 
branches whose upstreams match those passed on the commandline and that 
have been merged so do they really want to hear about the ones that have 
not been merged? It might be useful to have a way to list those that 
have not been merged in the future.

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-branch.adoc |  24 ++++
>   builtin/branch.c              |  67 +++++++++++-
>   t/t3200-branch.sh             | 201 ++++++++++++++++++++++++++++++++++
>   3 files changed, 290 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index 62ebab6051..fdaccc9662 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
>   git branch (-c|-C) [<old-branch>] <new-branch>
>   git branch (-d|-D) [-r] <branch-name>...
>   git branch --edit-description [<branch-name>]
> +git branch --prune-merged <branch>...
>   
>   DESCRIPTION
>   -----------
> @@ -201,6 +202,29 @@ This option is only applicable in non-verbose mode.
>   	Print the name of the current branch. In detached `HEAD` state,
>   	nothing is printed.
>   
> +`--prune-merged <branch>...`::
> +	Delete the local branches that `--forked` would list for the
> +	given _<branch>_ arguments, but only those whose tip is
> +	reachable from their configured upstream. In other words, the
> +	work on the branch has already landed on the upstream it
> +	tracks, so the local copy is no longer needed. Several
> +	_<branch>_ patterns may be given, e.g. `git branch
> +	--prune-merged origin/main 'feature*'`.
> ++
> +Reachability is checked against whatever the upstream refs say
> +locally; nothing is fetched. Run `git fetch` first if you want
> +the upstream refs refreshed.
Maybe

Reachability is checked against the remote-tracking branch. Run `git 
fetch` first if you want update the remote-tracking branch.

> ++
> +A branch is left alone if any of the following holds:

s/left alone/not deleted/

> +its upstream no longer resolves locally; it is checked out in any

s/upstream no longer resolves locally/upstream remote-tracking branch no 
longer exists/

> +worktree; or its push destination (`<branch>@{push}`) equals its
> +upstream (`<branch>@{upstream}`), so it cannot be distinguished
> +from a freshly pulled trunk that just looks "fully merged".

What's a "freshly pulled trunk"? "trunk" does not appear in gitglossary(7)

> ++
> +Branches refused by the "fully merged" safety check are listed as
> +warnings and skipped; pass them to `git branch -D` explicitly if
> +you want them gone.

s/them gone/to delete them/

> +
>   `-v`::
>   `-vv`::
>   `--verbose`::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2cc5a8cde0..af37a0ceb7 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -38,6 +38,7 @@ static const char * const builtin_branch_usage[] = {
>   	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>   	N_("git branch [<options>] [-r | -a] [--points-at]"),
>   	N_("git branch [<options>] [-r | -a] [--format]"),
> +	N_("git branch [<options>] --prune-merged <branch>..."),
>   	NULL
>   };
>   
> @@ -715,6 +716,61 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
>   	return 0;
>   }
>   
> +static int prune_merged_branches(int argc, const char **argv,
> +				 int quiet)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct ref_array candidates;
> +	struct strvec deletable = STRVEC_INIT;
> +	int i, ret = 0;
> +
> +	if (!argc)
> +		die(_("--prune-merged requires at least one <branch>"));
> +
> +	for (i = 0; i < argc; i++)
> +		if (ref_filter_forked_add(&filter, argv[i]) < 0)
> +			die(_("'%s' is not a valid branch or pattern"), argv[i]);
> +
> +	filter.kind = FILTER_REFS_BRANCHES;
> +	memset(&candidates, 0, sizeof(candidates));

It would be nicer to add "= { 0 }" to the declaration of candidates above.

> +	filter_refs(&candidates, &filter, filter.kind);
> +
> +	for (i = 0; i < candidates.nr; i++) {
> +		const char *full_name = candidates.items[i]->refname;
> +		const char *short_name;
> +		struct branch *branch;
> +		const char *upstream, *push;
> +
> +		if (!skip_prefix(full_name, "refs/heads/", &short_name))
> +			continue;

If we've set filter.kind = FILTER_REFS_BRANCHS how can this condition fail?

> +		if (branch_checked_out(full_name))
> +			continue;
> +
> +		branch = branch_get(short_name);
> +		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;

How can branch be NULL? Don't we require branch_get() to succeed in 
order to filter it?

> +		if (!upstream || !refs_ref_exists(refs, upstream))
> +			continue;
> +		push = branch ? branch_get_push(branch, NULL) : NULL;
> +		if (!push || !strcmp(push, upstream))
> +			continue;

By the time we've reached this point we know that 
branch@{upstream}exists and does not match branch@{push} - good

> +		strvec_push(&deletable, short_name);
> +	}
> +
> +	if (deletable.nr)
> +		ret = delete_branches(deletable.nr, deletable.v,
> +				      FILTER_REFS_BRANCHES,
> +				      DELETE_BRANCH_WARN_ONLY |
> +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
> +				      (quiet ? DELETE_BRANCH_QUIET : 0));

Here we delete the branches - good.
> +		OPT_BOOL(0, "prune-merged", &prune_merged,
> +			N_("delete local branches whose upstream matches <branch> and is merged")),

s/is/are/

Sorry I didn't get round to reviewing these last week, I'll try and take 
a look at the tests and the other patches tomorrow

Thanks

Phillip

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 4e7deddc04..27ea1319bb 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1809,4 +1809,205 @@ test_expect_success '--forked requires a value' '
>   	test_grep "requires a value" err
>   '
>   
> +test_expect_success '--prune-merged: setup' '
> +	test_create_repo pm-upstream &&
> +	test_commit -C pm-upstream base &&
> +	git -C pm-upstream checkout -b next &&
> +	test_commit -C pm-upstream one-commit &&
> +	test_commit -C pm-upstream two-commit &&
> +	git -C pm-upstream branch one HEAD~ &&
> +	git -C pm-upstream branch two HEAD &&
> +	git -C pm-upstream branch wip main &&
> +	git -C pm-upstream checkout main &&
> +	test_create_repo pm-fork
> +'
> +
> +test_expect_success '--prune-merged deletes branches integrated into upstream' '
> +	test_when_finished "rm -rf pm-merged" &&
> +	git clone pm-upstream pm-merged &&
> +	git -C pm-merged remote add fork ../pm-fork &&
> +	test_config -C pm-merged remote.pushDefault fork &&
> +	test_config -C pm-merged push.default current &&
> +	git -C pm-merged branch one one-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next one &&
> +	git -C pm-merged branch two two-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next two &&
> +
> +	git -C pm-merged branch --prune-merged "origin/*" &&
> +
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged accepts a literal upstream' '
> +	test_when_finished "rm -rf pm-literal" &&
> +	git clone pm-upstream pm-literal &&
> +	git -C pm-literal remote add fork ../pm-fork &&
> +	test_config -C pm-literal remote.pushDefault fork &&
> +	test_config -C pm-literal push.default current &&
> +	git -C pm-literal branch one one-commit &&
> +	git -C pm-literal branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-literal branch --prune-merged origin/next &&
> +
> +	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged unions multiple <branch> arguments' '
> +	test_when_finished "rm -rf pm-union" &&
> +	git clone pm-upstream pm-union &&
> +	git -C pm-union remote add fork ../pm-fork &&
> +	test_config -C pm-union remote.pushDefault fork &&
> +	test_config -C pm-union push.default current &&
> +	git -C pm-union branch one one-commit &&
> +	git -C pm-union branch --set-upstream-to=origin/next one &&
> +	git -C pm-union branch two base &&
> +	git -C pm-union branch --set-upstream-to=origin/main two &&
> +	git -C pm-union checkout --detach &&
> +
> +	git -C pm-union branch --prune-merged origin/next origin/main &&
> +
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged accepts a local upstream' '
> +	test_when_finished "rm -rf pm-local" &&
> +	git clone pm-upstream pm-local &&
> +	git -C pm-local remote add fork ../pm-fork &&
> +	test_config -C pm-local remote.pushDefault fork &&
> +	test_config -C pm-local push.default current &&
> +	git -C pm-local checkout -b trunk &&
> +	git -C pm-local branch one one-commit &&
> +	git -C pm-local branch --set-upstream-to=trunk one &&
> +	git -C pm-local merge --ff-only one-commit &&
> +
> +	git -C pm-local branch --prune-merged trunk &&
> +
> +	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
> +	test_when_finished "rm -rf pm-unmerged" &&
> +	git clone pm-upstream pm-unmerged &&
> +	git -C pm-unmerged remote add fork ../pm-fork &&
> +	test_config -C pm-unmerged remote.pushDefault fork &&
> +	test_config -C pm-unmerged push.default current &&
> +	git -C pm-unmerged checkout -b wip origin/wip &&
> +	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
> +	test_commit -C pm-unmerged local-only &&
> +	git -C pm-unmerged checkout - &&
> +
> +	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
> +	test_grep "not fully merged" err &&
> +	test_grep ! "If you are sure you want to delete it" err &&
> +	git -C pm-unmerged rev-parse --verify refs/heads/wip
> +'
> +
> +test_expect_success '--prune-merged is silent about not-merged-to-HEAD' '
> +	test_when_finished "rm -rf pm-nohead" &&
> +	git clone pm-upstream pm-nohead &&
> +	git -C pm-nohead remote add fork ../pm-fork &&
> +	test_config -C pm-nohead remote.pushDefault fork &&
> +	test_config -C pm-nohead push.default current &&
> +	git -C pm-nohead branch topic one-commit &&
> +	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
> +
> +	git -C pm-nohead branch --prune-merged "origin/*" 2>err &&
> +
> +	test_grep ! "not yet merged to HEAD" err &&
> +	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--prune-merged skips branches whose upstream is gone' '
> +	test_when_finished "rm -rf pm-upstream-gone" &&
> +	git clone pm-upstream pm-upstream-gone &&
> +	git -C pm-upstream-gone remote add fork ../pm-fork &&
> +	test_config -C pm-upstream-gone remote.pushDefault fork &&
> +	test_config -C pm-upstream-gone push.default current &&
> +	git -C pm-upstream-gone branch one one-commit &&
> +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
> +	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
> +
> +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged never deletes the checked-out branch' '
> +	test_when_finished "rm -rf pm-head" &&
> +	git clone pm-upstream pm-head &&
> +	git -C pm-head remote add fork ../pm-fork &&
> +	test_config -C pm-head remote.pushDefault fork &&
> +	test_config -C pm-head push.default current &&
> +	git -C pm-head checkout -b one one-commit &&
> +	git -C pm-head branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-head branch --prune-merged "origin/*" &&
> +
> +	git -C pm-head rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged spares branches that push back to their upstream' '
> +	test_when_finished "rm -rf pm-push-eq" &&
> +	git clone pm-upstream pm-push-eq &&
> +	git -C pm-push-eq checkout --detach &&
> +
> +	git -C pm-push-eq branch --prune-merged "origin/*" &&
> +
> +	git -C pm-push-eq rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged spares a per-branch pushRemote==upstream remote' '
> +	test_when_finished "rm -rf pm-push-branch" &&
> +	git clone pm-upstream pm-push-branch &&
> +	git -C pm-push-branch remote add fork ../pm-fork &&
> +	test_config -C pm-push-branch remote.pushDefault fork &&
> +	test_config -C pm-push-branch push.default current &&
> +	test_config -C pm-push-branch branch.main.pushRemote origin &&
> +	git -C pm-push-branch checkout --detach &&
> +
> +	git -C pm-push-branch branch --prune-merged "origin/*" &&
> +
> +	git -C pm-push-branch rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged prunes when @{push} differs from @{upstream}' '
> +	test_when_finished "rm -rf pm-push-diff" &&
> +	git clone pm-upstream pm-push-diff &&
> +	git -C pm-push-diff remote add fork ../pm-fork &&
> +	test_config -C pm-push-diff remote.pushDefault fork &&
> +	test_config -C pm-push-diff push.default current &&
> +	git -C pm-push-diff branch topic one-commit &&
> +	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
> +	git -C pm-push-diff checkout --detach &&
> +
> +	git -C pm-push-diff branch --prune-merged "origin/*" &&
> +
> +	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--prune-merged requires at least one <branch>' '
> +	test_must_fail git -C forked branch --prune-merged 2>err &&
> +	test_grep "requires at least one <branch>" err
> +'
> +
> +test_expect_success '--prune-merged takes positional <branch> arguments' '
> +	test_when_finished "rm -rf pm-positional" &&
> +	git clone pm-upstream pm-positional &&
> +	git -C pm-positional remote add fork ../pm-fork &&
> +	test_config -C pm-positional remote.pushDefault fork &&
> +	test_config -C pm-positional push.default current &&
> +	git -C pm-positional branch one one-commit &&
> +	git -C pm-positional branch --set-upstream-to=origin/next one &&
> +	git -C pm-positional branch two base &&
> +	git -C pm-positional branch --set-upstream-to=origin/main two &&
> +	git -C pm-positional checkout --detach &&
> +
> +	git -C pm-positional branch --prune-merged origin/next origin/main &&
> +
> +	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
> +'
> +
>   test_done

