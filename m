Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB6375F82
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456980; cv=none; b=MIBViZESqa+16eLMnbHniH3VAAHPkJG3aKu6BuSLqgqrbbTfi5J/DGHKBjeB09ufLu/BxQkfAd5uJyC7Vk77ftpjmMc0iFpl4TWBeLzW3IFaYQ80hOeCLR2bINW+25L88pgMIIgnXzK/dvniBAVbLs47WpKjHVQ7mU8q59OM8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456980; c=relaxed/simple;
	bh=YDcfDr1WUWHlJHCH6LVTh8ZZ7z3pVOA9WNiR1y/RwXo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NF2Qpld3HluMqHOBSLn2rr2hNEZ4GLAirdbjPKV3q+gAy0in4fvM32p6nk6+nwa3ScsHmML8Htj09XFg6QlcDwJSOdD8/i4zVpNAcuZHh3TQognK3ryD2svfZpWWFpyfV//BEFzdeVjhxZkHUQF2gyUKdxe8pyZUkBSSF4+8iUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9xl9133; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9xl9133"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso85659015e9.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777456976; x=1778061776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlwVTGWfREubh0Jn1kTReUDcWrz1BbLT4lXzQRgWPMY=;
        b=e9xl9133fg/cZqIFNHHIFnEOFDpXWAzk2MSmzI5aEwuqMpVy8mKgKBCcbapABUvtla
         vdbRjKbxO4LCdVeD50xDm6FjrsIqZwBCQJZehjKgX2u8jgBSoMeX1WZRGE2tzoXnx7Uo
         qCJyZ6qC28YKY+dBQ2TlrmTIt+R1o5+l3O4GLwWiwseoUjQjWvlVqADYp7EFWABb93Vd
         Sj+h+Ns6W/tgI+bbFplqVcO6XeXNBWc+dK+G0To577U6Iem+rh6Q3hpXHdccPYXzAQbI
         YIgw1I4Bt1qlGRLumurZAYGaD/5xNBwaEECPuC1RxKHsMR/iIhaGIbImqA8zhhfaOZ+q
         nPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777456976; x=1778061776;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlwVTGWfREubh0Jn1kTReUDcWrz1BbLT4lXzQRgWPMY=;
        b=VELFtU/btIouiawyXH4pPL8CqEznnDsrRVJ0nVLNRJXE1HP9n3BBNLEA1xxtsJNqG8
         H7fQ0V9hW+SI6gtuwKlOIQeDrEAbNShrrIGsE+VtI22dlKm7R/Vz6Dm7h2F2kaiQgMTv
         IKGZMs6h5LExEX6OPVWV4SEHPZIiufPp150DKZgjYlV0pyEKSCM7BB+nXfxkLPQO9tnG
         Oggch0SmDTk6qTGy+vvYWW6jVvAMrDuB7mlXLZfxkk7cIXylE9ReCh2V8fUp+SBpcvK1
         zrsjRVqqRD/D2GDrWrvCDYxvkjd/ySc8tVnj/2IdxlJ/RowHnN/nWDmxZzIp931SY95g
         hT0g==
X-Forwarded-Encrypted: i=1; AFNElJ8LS2kihzd2uy6mzotl+CGxf4Luah/p5dU7qQtWbYraslQonD2//HwYuWkHlKUWaDWw+5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE24f+9HHCnoOJ3mCtPQ5PKF88Uv9/unT0s+BjNCLc8LZQJmPZ
	M8fAjXn+1IEFA5XBaDicUPFzKxeBFnehdcW02LzKJqpcjmzfppbbcGe0cmGBVw==
X-Gm-Gg: AeBDievEO41Ja9IQTepeKjl4rVpHxlWg48WB8Ck8QRdAyN/zJIeBfXpCDa/1Gz5l0UZ
	GZiABF3BeBJWWjFG9qfcKAaEfW+9C+tta2fSPWbbwSGPTR9uXnP/+GyYp4f9RWoI0rMMVPhkYK5
	gZdyaJ7AMeVorgesv5Th5zi49bnn6dVS4eZ20QxURM1QKAxeQppPBuHGNz2GjTSdEFYToan3DuE
	MAWc3rSpXkKatb4nmyyDB9zSOBgPGwVEWvReI7HbIySU+bUZBz1d6Xbo0uR5sGvKH2N6QFcwwGz
	3LMlu9Pyc5muCkCXlYuKk/Zjl+k7tOOS2yA06MwWJyDIi5aKn9ARCg+KtogcPMpqmf7yV9M0KBF
	0H8EktrUm9Ouz/jlLZZUcaAw2kerb5RJ3utiQRC1FgYu5N+v8r7PpE6hyrcGWQPDyv+0/LnpWSx
	gy8tJJylQPo1mXz9fHGsrPVcly3nfJS4mRXNvnZfJamXP9KP5p6pVYRsGbHLYhW9pE9y2rTjOEb
	TFg4495D1Q6ew==
X-Received: by 2002:a05:600c:a405:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48a77ae0456mr87415215e9.5.1777456976188;
        Wed, 29 Apr 2026 03:02:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c3161a6sm14106045e9.23.2026.04.29.03.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:02:55 -0700 (PDT)
Message-ID: <3170928a-e05e-42cc-b15e-56e0fa479066@gmail.com>
Date: Wed, 29 Apr 2026 11:02:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v16 0/5] checkout: 'autostash' for branch switching
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 28/04/2026 19:39, Harald Nordgren via GitGitGadget wrote:
>   * Updated the git checkout and git switch docs to show the actual output
>     when using -m to carry local changes across a branch switch, and changed
>     "would carry" to "will carry".
>   * Rewrote the merge-conflict example in both docs to match the new, more
>     concise message printed on autostash conflicts.
>   * Replaced the show_unpack_errors flag and old_commit parameter in
>     merge_working_tree()/init_topts() with a plain quiet boolean, so the
>     caller decides directly whether to suppress unpack errors.
>   * Tightened the 'checkout -m with dirty tree' test by replacing a printf
>     with a heredoc.
>   * Made the 'checkout -m creates a recoverable stash on conflict' test also
>     assert the reflog subject of the new stash entry.
>   * Replaced two test_grep calls in the 'checkout -m which would overwrite
>     untracked file' test with a single test_cmp, which also catches a
>     regression where the "would be overwritten" message could end up printed
>     twice.

That all sounds good and the range-diff below looks as I would expect it 
to. I've left some suggestions for possible future work on patch 5 but I 
think this is ready to be merged as-is.

Thanks for working on it

Phillip

> Harald Nordgren (5):
>    stash: add --label-ours, --label-theirs, --label-base for apply
>    sequencer: allow create_autostash to run silently
>    sequencer: teach autostash apply to take optional conflict marker
>      labels
>    checkout: rollback lock on early returns in merge_working_tree
>    checkout -m: autostash when switching branches
> 
>   Documentation/git-checkout.adoc |  55 +++++------
>   Documentation/git-stash.adoc    |  11 ++-
>   Documentation/git-switch.adoc   |  36 ++++---
>   builtin/checkout.c              | 166 +++++++++++++++-----------------
>   builtin/commit.c                |   3 +-
>   builtin/merge.c                 |  15 ++-
>   builtin/stash.c                 |  28 ++++--
>   sequencer.c                     |  69 +++++++++----
>   sequencer.h                     |   7 +-
>   t/t3420-rebase-autostash.sh     |  16 +--
>   t/t3903-stash.sh                |  24 +++++
>   t/t7201-co.sh                   |  71 +++++++++++++-
>   t/t7600-merge.sh                |   3 +-
>   xdiff-interface.c               |  12 +++
>   xdiff-interface.h               |   1 +
>   xdiff/xmerge.c                  |   6 +-
>   16 files changed, 343 insertions(+), 180 deletions(-)
> 
> 
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v16
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v16
> Pull-Request: https://github.com/git/git/pull/2234
> 
> Range-diff vs v15:
> 
>   1:  aba8e6a9dc = 1:  aba8e6a9dc stash: add --label-ours, --label-theirs, --label-base for apply
>   2:  89e0bfa803 = 2:  89e0bfa803 sequencer: allow create_autostash to run silently
>   3:  a428ce7328 = 3:  a428ce7328 sequencer: teach autostash apply to take optional conflict marker labels
>   4:  f358424085 = 4:  f358424085 checkout: rollback lock on early returns in merge_working_tree
>   5:  96b14db827 ! 5:  07d25fda91 checkout -m: autostash when switching branches
>       @@ Documentation/git-checkout.adoc: $ git checkout mytopic
>         
>        -You can give the `-m` flag to the command, which would try a
>        -three-way merge:
>       -+You can give the `-m` flag to the command, which would carry your local
>       ++You can give the `-m` flag to the command, which will carry your local
>        +changes to the new branch:
>         
>         ------------
>         $ git checkout -m mytopic
>        -Auto-merging frotz
>       ++Applied autostash.
>        +Switched to branch 'mytopic'
>       ++The following paths have local changes:
>       ++M	frotz
>         ------------
>         
>        -After this three-way merge, the local modifications are _not_
>       @@ Documentation/git-checkout.adoc: $ git checkout mytopic
>         
>        -When a merge conflict happens during switching branches with
>        -the `-m` option, you would see something like this:
>       -+When the `--merge` (`-m`) option is in effect and the locally
>       -+modified files overlap with files that need to be updated by the
>       -+branch switch, the changes are stashed and reapplied after the
>       -+switch.  If this process results in conflicts, a stash entry is saved
>       -+and made available in `git stash list`:
>       ++When the `--merge` (`-m`) option is given and the local changes
>       ++overlap with the changes in the branch we're switching to, the
>       ++changes are stashed and reapplied after the switch.  If this
>       ++process results in conflicts, the stash entry is saved and a
>       ++message is printed:
>         
>         ------------
>         $ git checkout -m mytopic
>       @@ Documentation/git-checkout.adoc: $ git checkout mytopic
>        -ERROR: Merge conflict in frotz
>        -fatal: merge program failed
>        -------------
>       -+Your local changes are stashed, however, applying it to carry
>       -+forward your local changes resulted in conflicts:
>       -
>       +-
>        -At this point, `git diff` shows the changes cleanly merged as in
>        -the previous example, as well as the changes in the conflicted
>        -files.  Edit and resolve the conflict and mark it resolved with
>        -`git add` as usual:
>       -+ - You can try resolving them now.  If you resolved them
>       -+   successfully, discard the stash entry with "git stash drop".
>       -
>       -+ - Alternatively you can "git reset --hard" if you do not want
>       -+   to deal with them right now, and later "git stash pop" to
>       -+   recover your local changes.
>       - ------------
>       +-
>       +-------------
>        -$ edit frotz
>        -$ git add frotz
>       --------------
>       -+
>       -+You can try resolving the conflicts now.  Edit the conflicting files
>       -+and mark them resolved with `git add` as usual, then run `git stash
>       -+drop` to discard the stash entry.  Alternatively, you can clear the
>       -+working tree with `git reset --hard` and recover your local changes
>       -+later with `git stash pop`.
>       ++Your local changes are stashed, however applying them
>       ++resulted in conflicts.  You can either resolve the conflicts
>       ++and then discard the stash with "git stash drop", or, if you
>       ++do not want to resolve them now, run "git reset --hard" and
>       ++apply the local changes later by running "git stash pop".
>       + ------------
>         
>         CONFIGURATION
>       - -------------
>        
>         ## Documentation/git-switch.adoc ##
>        @@ Documentation/git-switch.adoc: variable.
>       @@ Documentation/git-switch.adoc: $ git switch mytopic
>         
>        -You can give the `-m` flag to the command, which would try a three-way
>        -merge:
>       -+You can give the `-m` flag to the command, which would carry your local
>       ++You can give the `-m` flag to the command, which will carry your local
>        +changes to the new branch:
>         
>         ------------
>         $ git switch -m mytopic
>        -Auto-merging frotz
>       ++Applied autostash.
>        +Switched to branch 'mytopic'
>       ++The following paths have local changes:
>       ++M	frotz
>         ------------
>         
>        -After this three-way merge, the local modifications are _not_
>       @@ builtin/checkout.c: struct checkout_opts {
>         	char *name; /* The short name used */
>         	char *path; /* The full name of a real branch */
>        @@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
>       + 	branch->path = strbuf_detach(&buf, NULL);
>       + }
>         
>       - static void init_topts(struct unpack_trees_options *topts, int merge,
>       +-static void init_topts(struct unpack_trees_options *topts, int merge,
>       ++static void init_topts(struct unpack_trees_options *topts,
>         		       int show_progress, int overwrite_ignore,
>        -		       struct commit *old_commit)
>       -+		       struct commit *old_commit, bool show_unpack_errors)
>       ++		       bool quiet)
>         {
>         	memset(topts, 0, sizeof(*topts));
>         	topts->head_idx = -1;
>       @@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts, i
>         	topts->update = 1;
>         	topts->merge = 1;
>        -	topts->quiet = merge && old_commit;
>       -+	topts->quiet = merge && old_commit && !show_unpack_errors;
>       ++	topts->quiet = quiet;
>         	topts->verbose_update = show_progress;
>         	topts->fn = twoway_merge;
>         	topts->preserve_ignored = !overwrite_ignore;
>       @@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts, i
>         static int merge_working_tree(const struct checkout_opts *opts,
>         			      struct branch_info *old_branch_info,
>         			      struct branch_info *new_branch_info,
>       --			      int *writeout_error)
>       -+			      int *writeout_error,
>       -+			      bool show_unpack_errors)
>       ++			      bool quiet,
>       + 			      int *writeout_error)
>         {
>         	int ret;
>       - 	struct lock_file lock_file = LOCK_INIT;
>        @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
>       + 		}
>         
>         		/* 2-way merge to the new branch */
>       - 		init_topts(&topts, opts->merge, opts->show_progress,
>       +-		init_topts(&topts, opts->merge, opts->show_progress,
>        -			   opts->overwrite_ignore, old_branch_info->commit);
>       -+			   opts->overwrite_ignore, old_branch_info->commit,
>       -+			   show_unpack_errors);
>       ++		init_topts(&topts, opts->show_progress,
>       ++			   opts->overwrite_ignore, quiet);
>         		init_checkout_metadata(&topts.meta, new_branch_info->refname,
>         				       new_branch_info->commit ?
>         				       &new_branch_info->commit->object.oid :
>       @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>         	if (do_merge) {
>        -		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>        +		ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
>       -+					 &writeout_error, false);
>       ++					 opts->merge, &writeout_error);
>        +		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
>        +			strbuf_addf(&autostash_msg,
>        +				    "autostash while switching to '%s'",
>       @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>        +					     autostash_msg.buf, true);
>        +			created_autostash = 1;
>        +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
>       -+						 &writeout_error, true);
>       ++						 false, &writeout_error);
>        +		}
>        +		if (created_autostash) {
>        +			if (opts->conflict_style >= 0) {
>       @@ t/t7201-co.sh: test_expect_success 'checkout -m with dirty tree' '
>         	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
>         
>        -	printf "M\t%s\n" one >expect.messages &&
>       -+	printf "The following paths have local changes:\nM\t%s\n" one >expect.messages &&
>       ++	cat >expect.messages <<-\EOF &&
>       ++	The following paths have local changes:
>       ++	M	one
>       ++	EOF
>         	test_cmp expect.messages messages &&
>         
>         	fill "M	one" "A	three" "D	two" >expect.main &&
>       @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
>        +	test_grep "git stash drop" actual &&
>        +	test_grep "git stash pop" actual &&
>        +	test_grep "The following paths have local changes" actual &&
>       -+	git show --format=%B --diff-merges=1 refs/stash >actual &&
>       ++	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
>        +	sed /^index/d actual >actual.trimmed &&
>        +	cat >expect <<-EOF &&
>       ++	autostash while switching to ${SQ}side${SQ}
>        +	On main: autostash while switching to ${SQ}side${SQ}
>        +
>        +	diff --git a/one b/one
>       @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
>        +	>another-file.t &&
>        +	fill 1 2 3 4 5 >one &&
>        +	test_must_fail git checkout -m @{-1} 2>err &&
>       -+	test_grep "would be overwritten by checkout" err &&
>       -+	test_grep "another-file.t" err
>       ++	q_to_tab >expect <<-\EOF &&
>       ++	error: The following untracked working tree files would be overwritten by checkout:
>       ++	Qanother-file.t
>       ++	Please move or remove them before you switch branches.
>       ++	Aborting
>       ++	Applied autostash.
>       ++	EOF
>       ++	test_cmp expect err
>        +'
>        +
>         test_expect_success 'switch to another branch while carrying a deletion' '
> 

