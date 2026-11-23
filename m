Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439458;
	b=KhEVBvWlJ788OtJvm8UjZeWPtpTgt7YeOgi+2lJpZEinjmO61mGnJNy3IPk+5gIu1k42
	 76s9IOBgj4IJdq7CHmB2eEWnSw6Ti3UMkugqYyPPXovzdQWanNSR/d5S1xX0EF9JV9m0B
	 f1Hr0lD6dixH0JtXoO/LG2qPRzooFiYLe98witl/jD7Mjk8rhShLjT9ofJRDP5hCQMAgB
	 5zGNcBkXFmGRG72IFsFQF5bvzJnk+owdvmqntsX6vyhNC3BfZycw8yRGAf7vcsbuwQ6Kk
	 hvOqSe0VBWHVilNyQLwHWigG2n7AwLE2aMYGQyGpZY7EX8NU8mGG0ym8sU+zgskHIBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+27CmHF0CrYoGdKtbSBEbFHI6grpiC2bwT9Szuj3XFM=;
	b=IBm3r1maIlettNClQ/1WEMn4rHtOwSIK4dl5S6aup0axc3s5log1epm9lnxT6yKubaYK
	 2nCve5JF/HwU69Hq90vI1+lm5hmKebtBEXFBRt5s82l3RTKRcfs4/wcEiA4/an/SB0ti+
	 nd8J6saZS87XkbknEC/wLwKqwoVT2dGk90VL+mXzo8DAKOdh8ZJSLo2o+3bfBRRYYz1RU
	 aNMbS0tVWsm6fwRNWu+Q/m36nZJKqBs+speN9eRcQnKMaTAGDfQIiZD4aEuwLWauc+TO0
	 1VAswkl9ljrXb0eOg+Ms63CCbRbpklFf795OmEFluqQkiFpiW0kV5JDOEM2Xng70a2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCC3ysp3;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D606A33A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 13:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF7D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCC3ysp3
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so20665915e9.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439457; x=1796044257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+27CmHF0CrYoGdKtbSBEbFHI6grpiC2bwT9Szuj3XFM=;
        b=hCC3ysp34jshTWRynd7riOUEuWqLs3/wDOwnUJNk2PoqsdAKL2glUqfpN86qlNbQnV
         WKrrj/MqfZ042Al3kgp20wAG4l+OAEid+ITPmlK80dCVuwqbf64r6N376RieLbo6P+f/
         6b5EY72omKxmSvE3kGQzAI9NhNgC9Cx6YOLA76a4bRhNOD0hJiqYxLcNtAekzwoDjrQw
         gVnyK5VrPh5ngm8L1JrrxETSRYlerNcZyBzTBpLQYpaE6k+qnM5YhH5H9Bei+jN72hDc
         /vfOYcquMutMPY0rnaiO3UEdQmY4O+ExgCFbsFBPqUfFRzDcULK27J65S3LJ44yI5zBJ
         9QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439457; x=1796044257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+27CmHF0CrYoGdKtbSBEbFHI6grpiC2bwT9Szuj3XFM=;
        b=XYgCsBj1L1Q3dyqSabbw98uzvCkZK9p7i3RuCWH9hSGTW/Ccb9ypmgR04JcTv39BAN
         lolSlNCUd4eKWIEBwuoqki9f/doft8oB3Do+npK9bgREZAX1B1/x+p5oSNGt/+1G5zGB
         O5XC22smWP5yhBkAhjG0849fFsIh0HZ3W6oaDY+7HbxB//h/VbQlqDPsXMere61v9CjD
         f03q0hrX/EphqngjPELhaFf5vrL8vZ0fCc/0fUhB8VIdypqdkzGVwWriDLXE1pKdMvjI
         TkF3QYuLdwqENl43bV/ohi81LYksMA9j9efXUdGUnhVuQ0504UOS1gWmgUw6WivPL4jc
         RYCA==
X-Forwarded-Encrypted: i=1; AL+hErF9pwIa553276M89wgzyzQBQEGoUyj24BLwYudfSd7cP9Ui7divT1RnKzfDb6UyykPRYo8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9l8LXClzybOZDTgzUjH95EWiMj8W9dL+kYQ9J0ntqtMnVHwPr6
	i+PVbM4NXXigp7eEbsPLmYEkycDYtfSIGEcL+KyE86dhZMJ6W6QE1Z2Q
X-Gm-Gg: AZFdTZernoWr1k58yGD60AlkejMhPfuT1AkuxwTm+RDPqHc8J5mvMsziKD3fRdhHvnQ
	8Mt82y3O2HsSv6qR3/qj4bLP9YFRM6rt1g96V/RanN8KBlnwHajRv4m33/Y3bFGclrlvVo9gKW+
	DfRhu21Dkznv2cFdHnQYuBqVFQMnoqFK8SYdl8of3c6vvk+X2Y+BjnDMuzvGpIq4nyggrMykXwP
	nokwYtHJLKmdJEVm/p8t+ICgAFM+Vu/uxJ5WypuHtbJz6L1qlpPf4J3mVyeQskc6L3GjSp7q8bO
	ukT/20O5uXyOQk6LOaauTsCAnxb14PBvBKnsab9+v3p4s/a/ZxhZIgF/jBEATJmW+p4sZ6jTnJP
	gLrrGdLDVaxSayIPFmnNxxa5+Og2nh11j4dHOWPtUhIZPFYkFF06HoJAP8uEMw4c8F9JyV6avWQ
	3HEHC5FNPbB+Nk9SBy3aa3Tl6ZPe47o8YZvWDn7dNJTDJZF/6e9w1edWEr9JcXMyClbehri5k1g
	4aidLSKok1Kskd8M2eTHxrBOwcyCriaUSBpwtZQvpi4VbutL9bm9h0rNrCQQgoA7++Fqse9/s+D
	lAYvAuNPRE0JDK/CxNlMCvLuVlPY2trMVHs9FKyrJseCZBhtHUTcLr808D0e8E8E2n793V7gv+P
	HBjI8qyY=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr233091615e9.16.1795439456394;
        Mon, 23 Nov 2026 05:10:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm348597665e9.7.2026.11.23.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 05:10:55 -0800 (PST)
Message-ID: <a0ebd98f-669e-4ff2-bca2-cfd5da5a7316@gmail.com>
Date: Mon, 23 Nov 2026 13:10:50 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] history: refuse to rewrite branches used by other
 worktrees
To: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Nikita Bobko <nikita@nbobko.com>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261123103911.98860-1-aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aniket

Thanks for working on this, it is a useful improvement.

On 23/11/2026 10:39, Aniket Gupta wrote:
> By default "git history" also rewrites every local branch that descends

"also" is unnecessary here

> from the commit it changes. If another worktree has such a branch
> checked out, the branch moves but the index and working tree of that
> worktree stay behind. So it shows staged changes that nobody made.

The staged changes it shows were made by "git history" - they did not 
appear from nowhere. An alternative to refusing to run would be to 
update those worktrees if they are clean, but failing is the simpler 
option to implement.

> If
> the current worktree is in the middle of rebasing the branch, "git
> rebase --continue" later fails because the branch is not where the
> rebase expects it.
> 
> "git branch -f" refuses to move such branches and "git rebase
> --update-refs" skips them. Do the same here: before replaying anything
> look for local branches that contain the commit and are used by a
> worktree and refuse to go on if there is one. Use branch_checked_out()
> so that a branch that is being rebased or bisected counts as used.

Good. One thing to note is that I was recently looking at 
branch_checked_out() and it only stores a single worktree per ref, so I 
think if there are multiple checkouts of the same branch and we happen 
to record the current worktree as the one where it is checked out we'll 
fail to notice it is checked out elsewhere. That's not a problem that 
needs solving here though.

> Skip
> the branch that the current worktree has checked out, since the command
> already takes care of the index and working tree of that worktree.

What happens if a rebase is running in the same worktree as the user 
tries to run "git history"?

> Refuse with --dry-run as well because it will show what a real run will
> do.

Good

> Mention --update-refs=head, which leaves the other branches alone, with
> the existing advice.historyUpdateRefs hint.

Does --update-refs=head try to update the current branch? If so we 
should check that is not being written somewhere else.

> 
> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
> index 3d91c90eda..bb0e24b745 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -60,9 +60,10 @@ all advice messages.
>   		Shown when the user tries to delete a not fully merged
>   		branch without the force option set.
>   	historyUpdateRefs::
> -		Shown when `git history squash` refuses because a local branch
> -		cannot be rewritten as a descendant of the squashed commit, to
> -		tell the user about `--update-refs=head`.
> +		Shown when `git history` refuses because a local branch is used

This is copied from the existing wording, so it is not a new problem but 
we should say what "git history" refuses to do. e.g.

	Shown when 'git history' refuses to run because ...

> +		by another worktree, or, for `squash`, because it cannot be
> +		rewritten as a descendant of the squashed commit, to tell the
> +		user about `--update-refs=head`.
>   	ignoredHook::
>   		Shown when a hook is ignored because the hook is not
>   		set as executable.
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 1fcc30150a..ce7c0a88c8 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -215,6 +215,12 @@ empty.
>   	`branches`, all local branches that point to commits which are
>   	descendants of the original commit will be rewritten. With `head`, only
>   	the current `HEAD` reference will be rewritten. Defaults to `branches`.
> ++
> +A branch that is used by another worktree, or that the current worktree is
> +in the middle of rebasing or bisecting, cannot be rewritten, as the index and
> +working tree of that worktree would not match the rewritten branch. With> +`branches` the command refuses in that case, so use `head` to 
rewrite only
> +the current branch.

We should also prevent rebase from rewriting a branch that is being 
rewritten by "git history" but that can come later.

> +/*
> + * Rewriting a branch that is used by another worktree moves the branch
> + * without updating the index and working tree of that worktree. The same
> + * goes for the branch that the current worktree is rebasing. Refuse to
> + * rewrite such branches, but not the branch that the current worktree has
> + * checked out, as we update that one ourselves.
> + */
> +static int reject_checked_out_branches(struct repository *repo,
> +				       struct commit *original)
> +{
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct ref_array refs = { 0 };
> +	char *head_target;
> +	int ret = 0;
> +
> +	head_target = refs_resolve_refdup(get_main_ref_store(repo), "HEAD",
> +					  RESOLVE_REF_NO_RECURSE, NULL, NULL);
> +
> +	commit_list_insert(original, &filter.with_commit);
> +	filter.kind = FILTER_REFS_BRANCHES;
> +	if (filter_refs(&refs, &filter, filter.kind)) {

This is correct, but it duplicates the revision walk we're already doing 
when looking for merge commits. It would be more efficient to

(1) modify setup_revwalk() to load decorations (we already load them
     when replaying the commits so there is no extra work, we're just
     loading them earlier)
(2) modify and rename revwalk_contains_merges() to
   (a) drop"--min-parents" and check for merges by looking at
       commit->parents->next.
   (b) check DECORATION_REF_LOCAL decorations are not checked out
       elsewhere.

For an existing example of using decorations, look at 
replay.c:replay_revisions().

Thanks

Phillip

> +		ret = error(_("could not filter refs"));
> +		goto out;
> +	}
> +
> +	for (int i = 0; i < refs.nr; i++) {
> +		const char *refname = refs.items[i]->refname;
> +		const char *branch, *path;
> +
> +		if (head_target && !strcmp(refname, head_target))
> +			continue;
> +
> +		path = branch_checked_out(refname);
> +		if (!path)
> +			continue;
> +
> +		if (!skip_prefix(refname, "refs/heads/", &branch))
> +			BUG("branch filter returned '%s'", refname);
> +		error(_("cannot rewrite branch '%s' used by worktree at '%s'"),
> +		      branch, path);
> +		ret = -1;
> +	}
> +
> +	if (ret)
> +		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
> +				  _("Use --update-refs=head to rewrite only "
> +				    "the current branch and leave such branches "
> +				    "untouched."));
> +
> +out:
> +	free(head_target);
> +	ref_filter_clear(&filter);
> +	ref_array_clear(&refs);
> +	return ret;
> +}
> +
>   static int setup_revwalk(struct repository *repo,
>   			 enum ref_action action,
>   			 struct commit *original,
> @@ -350,6 +407,10 @@ static int setup_revwalk(struct repository *repo,
>   
>   		strvec_push(&args, "HEAD");
>   	} else {
> +		ret = reject_checked_out_branches(repo, original);
> +		if (ret < 0)
> +			goto out;
> +
>   		strvec_push(&args, "--branches");
>   		strvec_push(&args, "HEAD");
>   	}
> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> index f513463b92..f7ca66edc6 100755
> --- a/t/t3450-history.sh
> +++ b/t/t3450-history.sh
> @@ -14,4 +14,132 @@ test_expect_success 'raises an error with unknown argument' '
>   	test_grep "unknown subcommand: .garbage." err
>   '
>   
> +test_expect_success 'refuses to rewrite a branch checked out in another worktree' '
> +	test_when_finished "rm -rf repo wt" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git worktree add ../wt -b other &&
> +
> +		git refs list >refs-expect &&
> +		test_must_fail git history drop second 2>err &&
> +		test_grep "^error: cannot rewrite branch .other. used by worktree at .*wt" err &&
> +		test_grep "^hint: .* --update-refs=head" err &&
> +		test_grep ! "branch .main." err &&
> +		git refs list >refs-actual &&
> +		test_cmp refs-expect refs-actual
> +	)
> +'
> +
> +test_expect_success 'refusing to rewrite checked out branches honors --dry-run' '
> +	test_when_finished "rm -rf repo wt" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git worktree add ../wt -b other &&
> +
> +		test_must_fail git history drop --dry-run second >out 2>err &&
> +		test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
> +		test_must_be_empty out
> +	)
> +'
> +
> +test_expect_success 'advice.historyUpdateRefs silences the hint for checked out branches' '
> +	test_when_finished "rm -rf repo wt" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git worktree add ../wt -b other &&
> +
> +		test_must_fail git -c advice.historyUpdateRefs=false \
> +			history drop second 2>err &&
> +		test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
> +		test_grep ! "hint:" err
> +	)
> +'
> +
> +test_expect_success '--update-refs=head leaves branches of other worktrees alone' '
> +	test_when_finished "rm -rf repo wt" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git worktree add ../wt -b other &&
> +		git rev-parse other >other-expect &&
> +
> +		git history drop --update-refs=head second &&
> +
> +		git rev-parse other >other-actual &&
> +		test_cmp other-expect other-actual &&
> +		git log --format=%s main >actual &&
> +		test_write_lines third first >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'rewrites the branch of the current worktree' '
> +	test_when_finished "rm -rf repo wt" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		git worktree add ../wt -b other &&
> +		test_commit -C ../wt second &&
> +		test_commit -C ../wt third &&
> +
> +		git -C ../wt history drop second &&
> +
> +		git log --format=%s other >actual &&
> +		test_write_lines third first >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'refuses to rewrite a branch that is being rebased' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		test_must_fail git rebase -x false first &&
> +
> +		git refs list >refs-expect &&
> +		test_must_fail git history drop second 2>err &&
> +		test_grep "^error: cannot rewrite branch .main. used by worktree at" err &&
> +		git refs list >refs-actual &&
> +		test_cmp refs-expect refs-actual &&
> +
> +		git rebase --abort
> +	)
> +'
> +
> +test_expect_success 'refuses to rewrite a branch that is being bisected' '
> +	test_when_finished "rm -rf repo wt" &&
> +	git init repo --initial-branch=main &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git worktree add ../wt -b other &&
> +		git -C ../wt bisect start HEAD first &&
> +
> +		test_must_fail git history drop second 2>err &&
> +		test_grep "^error: cannot rewrite branch .other. used by worktree at" err
> +	)
> +'
> +
>   test_done
> 
> base-commit: f7de81456940dd6f3274e461149bba12965de609

