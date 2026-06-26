Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43E2EB859
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463985; cv=none; b=iqL5Z4bG3EGer+yexdS2ambd08axkw9CHxf8QATuc9B3sN5Kv3gHE0BsNa0n/1Uiz0sl3PuJq09SdEPXeQvoYnQx31nSitmSLbixmwZWYusp/KXswxu636+l/7UDFvS0LAN5aQ84KjBMm7fsFJO4sl7TbxkfRiWXh8irs3MJXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463985; c=relaxed/simple;
	bh=3hkGWR6Sv8P/myH8lJ24DP3PFRbS6KV9/eOS0jz08yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1Dv7sEdC+fGbOXC68CsYleF8KZ/LXV/nQqTGCK4RrIPxP7Rkr7U4uMteGA5aIgfWn7aS3duHfbDQ1adZkG20l6fIgWPWVAknyxoVfuW2P8pIByhKb9sfeq+m5quokPcvYJUmHxXkmP3PYWfjYv8T6Em6YJMrt3fbxZv8j2mL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duja3c/h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duja3c/h"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49222fb062bso7380445e9.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782463982; x=1783068782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8t8bv3fmyXyAveFtqfLkeqqlSvZKZnmvsl28/2xiZjU=;
        b=Duja3c/hs8yNOs77z+p6XHVe1ehysk1fSnLB7RyLNd64sMhtW3nfdCA/0otu0ICvSI
         8lreOcsBRl5chXaN2VMig/3eoeUBU7c4uw2UOmI8Pp8xtPwaQ1WEzXQR98C6XMWORuO9
         MaLkLofTrL+ZqRcMla75wXVTN+SPmRNjzid5V5nhM284+TU9CSQMNxCWWbCLu//LvG+G
         Is/VVTZfudIkTLdssVRGW4W/3plwr0oPNr2FjvA/M25rDGCH0wmzp2loG8ET+gCk9Zya
         Ut3c2lvAK5OvFBkRQkhKCjWtw9bvHHMgjkIR0AKL3G99gFP80bN/K89tcqjU9Ns0+o3A
         YG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463982; x=1783068782;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t8bv3fmyXyAveFtqfLkeqqlSvZKZnmvsl28/2xiZjU=;
        b=lB5JrsPr0B/ngjPeRJJNX2MFJ72DXAZ/i/OtT/8ItjI2tb3veuqjhHxiQOQhoMShOr
         xlBhjYRXRUsDva2iQ0aqdyl9T0hooBUKaFdYH9/4PPfhmW6FyPsavnEhj6ntC0Cweqt+
         vsMkpMMOxlg5oc7FtgB3hGw1uMkJ8yuQKXG0UI0tsQshgdT+nIpdXY6f1E4ik21sNBVV
         DYhwV874Ax/B/Y3HZ4se3yFyVoyWPXzNrm/VhIPqjTTxrEscr/QziKiU5R9CmFN/GG08
         jMEEYXSlLO9pzu2SY50lSeeLtAo5NCv1HLkMzbBD8fgxaEKVQDgSvDgjKJ4WghSX+N6e
         ysBA==
X-Forwarded-Encrypted: i=1; AFNElJ+hMQg2sN86JSXXHD8T7i6Yz27i9+Fh7N2pG+fgFczgl81j7Etjjb2Wu0pV+dZQmE4fnwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2e0IVB2VWcKF5oB9oG8Lvze/hRlc6b8tw3ZoNwUnqP+f1EEv
	hg1cWoN6hwuZ3iwD8mNA/Vl2LjkPNwbotQhyfPFTbbhDIwX9Gqle6UBS
X-Gm-Gg: AfdE7cmSOmuWJoVkHWREvJJ1mpftXjDRjP84V4o9nqZ1OIoEh6HL0XPIXWtGLEWU7Ww
	T6xKlrkVkmQZavCNImI1cVyuXWR6m22ZW/eG0Ol7IhU8R6WdWnMuJhfQUwzGuhC2F3hms2TsAIk
	EeeV16EDLaQdwQrYTXa5WbopSLUYX8nakypPE7h3pbqC2GuhzPPzbdmHdLz0NcgOY4ce+UHIiEq
	dpsa1ZPGy85Qn610+d1cSfJcDk0yWWYS1UQrZz3FP2KYbOt3do4ULpF70fsBtGTJxWFAxlyL/vs
	WEOpYnWrxHN/7YjgDwUUbaG3tRxXM1h8khbbmXcyUMdLG3LYD2VPTCqN7arcnHOkdUue8U9sYNP
	wn4ZoF9G/RQ6GdudZH3Cy2pUKy37jTUL8JR1PX3ZpSt4ldGXRO0fuhgGrIqVztAY5oOl7uFplm4
	EEuoV1w3FObUEqvxIYvZTydPi5l8n7/uxLe8qoG18gUmA4I+v2QYengQ6tTWxpPjozYdc=
X-Received: by 2002:a05:600c:6748:b0:490:c024:2eba with SMTP id 5b1f17b1804b1-4926688598fmr82567945e9.22.1782463981807;
        Fri, 26 Jun 2026 01:53:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fc0d36sm104173785e9.2.2026.06.26.01.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 01:53:01 -0700 (PDT)
Message-ID: <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
Date: Fri, 26 Jun 2026 09:52:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:54, Harald Nordgren via GitGitGadget wrote:
> Adds git history squash <revision-range> to fold a range of commits.

It would be helpful to give a bit more detail here about the command so 
that the reader has an overview of what is actually being implemented.

  - what does it do with fixup!, squash! and amend! commits? Can it use
    the message from amend! commits to reword the commit?
  - can the user reword the commit message?
  - what happens if a merge commit inside the range has a parent outside
    the range?
  - what happens to branches that point to commits inside the range?

I had a quick play and found that it accepts ranges that containing a 
single commit (e.g. @^!) where there is nothing to squash. It also 
accepts ranges that are not ancestors of HEAD (e.g. checkout master and 
run "git history squash --dry-run origin/seen^2^!") without printing an 
error message. Only accepting a single argument is quite limiting as one 
cannot say

	git history squash ^:/base :/tip

Thanks

Phillip


> Changes in v5:
> 
>   * The range walk now uses --ancestry-path, so only commits descended from
>     the base are folded; a single revision such as HEAD or HEAD~1 is now
>     rejected as "not a <base>..<tip> range" rather than treated as a squash
>     down to the root.
>   * This adopts the --ancestry-path suggestion; the multi-base rejection is
>     unchanged, so a side branch that forked before the base and merged in is
>     still refused.
>   * Added tests covering more merge topologies: two interior merges, a nested
>     merge, an octopus merge, an octopus arm forked before the base, a merge
>     among the descendants replayed above the range, and a ref pointing at an
>     interior merge commit.
> 
> Changes in v4:
> 
>   * git history squash now detects when another ref points at a commit inside
>     the range being folded and refuses, with an advice.historyUpdateRefs hint
>     to use --update-refs=head.
>   * A merge inside the range is folded fine as long as the range has a single
>     base; a range with merge commit at the tip or base also folds correctly.
>     Only a range with more than one base is rejected.
> 
> Changes in v3:
> 
>   * Moved the feature out of git rebase and into a new git history squash
>     <revision-range> subcommand, per the list discussion. git rebase --squash
>     is dropped.
>   * Takes an arbitrary range (git history squash @~3.., git history squash
>     @~5..@~2), folding it into the oldest commit and replaying any
>     descendants on top.
>   * Implemented as a single tree operation rather than picking each commit,
>     so there are no repeated conflict stops (addresses Phillip's efficiency
>     point).
>   * A merge inside the range is folded fine, only a range with more than one
>     base is rejected.
>   * --reedit-message seeds the editor with every folded-in message, not just
>     the oldest.
> 
> Harald Nordgren (4):
>    history: extract helper for a commit's parent tree
>    history: give commit_tree_ext a message template
>    history: add squash subcommand to fold a range
>    history: re-edit a squash with every message
> 
>   Documentation/config/advice.adoc |   4 +
>   Documentation/git-history.adoc   |  26 ++
>   advice.c                         |   1 +
>   advice.h                         |   1 +
>   builtin/history.c                | 341 ++++++++++++++++++---
>   t/meson.build                    |   1 +
>   t/t3455-history-squash.sh        | 497 +++++++++++++++++++++++++++++++
>   7 files changed, 833 insertions(+), 38 deletions(-)
>   create mode 100755 t/t3455-history-squash.sh
> 
> 
> base-commit: 26d8d94e94df5535eecd036f16627493506a0614
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v5
> Pull-Request: https://github.com/git/git/pull/2337
> 
> Range-diff vs v4:
> 
>   1:  fc2801c0b1 = 1:  0f1ae9b05a history: extract helper for a commit's parent tree
>   2:  ee591e83b4 = 2:  a97ffab1e6 history: give commit_tree_ext a message template
>   3:  80bfea642e ! 3:  04e18ef979 history: add squash subcommand to fold a range
>       @@ builtin/history.c: out:
>        +	struct rev_info revs;
>        +	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
>        +	struct strvec args = STRVEC_INIT;
>       ++	size_t i;
>        +	int ret;
>        +
>        +	repo_init_revisions(repo, &revs, NULL);
>       @@ builtin/history.c: out:
>        +	strvec_push(&args, "--reverse");
>        +	strvec_push(&args, "--topo-order");
>        +	strvec_push(&args, "--boundary");
>       ++	strvec_push(&args, "--ancestry-path");
>        +	strvec_push(&args, range);
>        +	setup_revisions_from_strvec(&args, &revs, NULL);
>        +	if (args.nr != 1) {
>       @@ builtin/history.c: out:
>        +		goto out;
>        +	}
>        +
>       ++	/*
>       ++	 * A squash needs a base to reparent onto, so the argument has to
>       ++	 * exclude something, as in "<base>..<tip>". A single revision has no
>       ++	 * such bottom commit and cannot be squashed.
>       ++	 */
>       ++	for (i = 0; i < revs.cmdline.nr; i++)
>       ++		if (revs.cmdline.rev[i].flags & UNINTERESTING)
>       ++			break;
>       ++	if (i == revs.cmdline.nr) {
>       ++		ret = error(_("'%s' is not a '<base>..<tip>' range"), range);
>       ++		goto out;
>       ++	}
>       ++
>        +	if (prepare_revision_walk(&revs) < 0) {
>        +		ret = error(_("error preparing revisions"));
>        +		goto out;
>       @@ builtin/history.c: out:
>        +		goto out;
>        +	}
>        +
>       -+	if (!base) {
>       -+		ret = error(_("cannot squash the root commit"));
>       -+		goto out;
>       -+	}
>       ++	if (!base)
>       ++		BUG("a non-empty range must have a boundary commit");
>        +
>        +	*base_out = base;
>        +	*oldest_out = oldest;
>       @@ t/t3455-history-squash.sh (new)
>        +	test_grep "the range .* is empty" err
>        +'
>        +
>       -+test_expect_success 'errors when the range includes the root commit' '
>       ++test_expect_success 'errors on a single revision that is not a range' '
>        +	test_must_fail git history squash HEAD 2>err &&
>       -+	test_grep "cannot squash the root commit" err
>       ++	test_grep "is not a .*range" err &&
>       ++	test_must_fail git history squash HEAD~1 2>err &&
>       ++	test_grep "is not a .*range" err
>        +'
>        +
>        +test_expect_success 'squashes a range into a single commit without changing the tree' '
>       @@ t/t3455-history-squash.sh (new)
>        +	test_path_is_file inner
>        +'
>        +
>       ++test_expect_success 'folds a merge of a branch that forked at the base' '
>       ++	git reset --hard start &&
>       ++	git checkout -b base-fork-side &&
>       ++	test_commit --no-tag base-fork-side side x &&
>       ++	git checkout - &&
>       ++	test_commit --no-tag base-fork-main file b &&
>       ++	git merge --no-ff -m "merge base-fork-side" base-fork-side &&
>       ++	git branch -D base-fork-side &&
>       ++	test_commit --no-tag base-fork-tail file c &&
>       ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
>       ++
>       ++	git history squash start.. &&
>       ++
>       ++	git rev-list --count start..HEAD >count &&
>       ++	echo 1 >expect &&
>       ++	test_cmp expect count &&
>       ++	test_cmp_rev start HEAD^ &&
>       ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
>       ++	test_path_is_file side
>       ++'
>       ++
>        +test_expect_success 'folds a range whose tip is a merge commit' '
>        +	git reset --hard start &&
>        +	test_commit --no-tag tipmerge-base file b &&
>       @@ t/t3455-history-squash.sh (new)
>        +	test_cmp_rev "$merged" HEAD
>        +'
>        +
>       ++test_expect_success 'folds a range with two interior merges' '
>       ++	git reset --hard start &&
>       ++	test_commit --no-tag two-merge-a file a1 &&
>       ++	git checkout -b two-merge-s1 &&
>       ++	test_commit --no-tag two-merge-s1 s1 x &&
>       ++	git checkout - &&
>       ++	git merge --no-ff -m "merge s1" two-merge-s1 &&
>       ++	test_commit --no-tag two-merge-b file b1 &&
>       ++	git checkout -b two-merge-s2 &&
>       ++	test_commit --no-tag two-merge-s2 s2 y &&
>       ++	git checkout - &&
>       ++	git merge --no-ff -m "merge s2" two-merge-s2 &&
>       ++	git branch -D two-merge-s1 two-merge-s2 &&
>       ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
>       ++
>       ++	git history squash start.. &&
>       ++
>       ++	git rev-list --count start..HEAD >count &&
>       ++	echo 1 >expect &&
>       ++	test_cmp expect count &&
>       ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
>       ++	test_path_is_file s1 &&
>       ++	test_path_is_file s2
>       ++'
>       ++
>       ++test_expect_success 'folds a range with a nested merge' '
>       ++	git reset --hard start &&
>       ++	main=$(git symbolic-ref --short HEAD) &&
>       ++	git checkout -b nested-outer &&
>       ++	test_commit --no-tag nested-outer outer x &&
>       ++	git checkout -b nested-inner &&
>       ++	test_commit --no-tag nested-inner inner y &&
>       ++	git checkout nested-outer &&
>       ++	git merge --no-ff -m "merge inner" nested-inner &&
>       ++	git checkout "$main" &&
>       ++	test_commit --no-tag nested-main file b1 &&
>       ++	git merge --no-ff -m "merge outer" nested-outer &&
>       ++	git branch -D nested-outer nested-inner &&
>       ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
>       ++
>       ++	git history squash start.. &&
>       ++
>       ++	git rev-list --count start..HEAD >count &&
>       ++	echo 1 >expect &&
>       ++	test_cmp expect count &&
>       ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
>       ++	test_path_is_file outer &&
>       ++	test_path_is_file inner
>       ++'
>       ++
>       ++test_expect_success 'folds a range with an octopus merge' '
>       ++	git reset --hard start &&
>       ++	main=$(git symbolic-ref --short HEAD) &&
>       ++	test_commit --no-tag octo-base file a1 &&
>       ++	git checkout -b octo-1 &&
>       ++	test_commit --no-tag octo-1 o1 x &&
>       ++	git checkout "$main" &&
>       ++	git checkout -b octo-2 &&
>       ++	test_commit --no-tag octo-2 o2 y &&
>       ++	git checkout "$main" &&
>       ++	git merge --no-ff -m octopus octo-1 octo-2 &&
>       ++	git branch -D octo-1 octo-2 &&
>       ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
>       ++
>       ++	git history squash start.. &&
>       ++
>       ++	git rev-list --count start..HEAD >count &&
>       ++	echo 1 >expect &&
>       ++	test_cmp expect count &&
>       ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
>       ++	test_path_is_file o1 &&
>       ++	test_path_is_file o2
>       ++'
>       ++
>       ++test_expect_success 'refuses an octopus merge with an arm forked before the base' '
>       ++	git reset --hard start &&
>       ++	main=$(git symbolic-ref --short HEAD) &&
>       ++	git checkout -b octo-pre &&
>       ++	test_commit octo-pre-side pside x &&
>       ++	git checkout "$main" &&
>       ++	test_commit octo-pre-main file b1 &&
>       ++	octo_base=$(git rev-parse HEAD) &&
>       ++	git checkout -b octo-within &&
>       ++	test_commit --no-tag octo-within wside y &&
>       ++	git checkout "$main" &&
>       ++	git merge --no-ff -m octopus octo-pre octo-within &&
>       ++	merged=$(git rev-parse HEAD) &&
>       ++	git branch -D octo-pre octo-within &&
>       ++
>       ++	test_must_fail git history squash "$octo_base.." 2>err &&
>       ++	test_grep "more than one base" err &&
>       ++	test_cmp_rev "$merged" HEAD
>       ++'
>       ++
>       ++test_expect_success 'refuses when a descendant above the range is a merge' '
>       ++	git reset --hard start &&
>       ++	main=$(git symbolic-ref --short HEAD) &&
>       ++	test_commit --no-tag desc-base file b &&
>       ++	git tag desc-tip &&
>       ++	git checkout -b desc-above &&
>       ++	test_commit --no-tag desc-above above x &&
>       ++	git checkout "$main" &&
>       ++	test_commit --no-tag desc-main file c &&
>       ++	git merge --no-ff -m "merge desc-above" desc-above &&
>       ++	git branch -D desc-above &&
>       ++	head_before=$(git rev-parse HEAD) &&
>       ++
>       ++	test_must_fail git history squash start..desc-tip 2>err &&
>       ++	test_grep "merge commits is not supported" err &&
>       ++	test_cmp_rev "$head_before" HEAD
>       ++'
>       ++
>       ++test_expect_success 'refuses to fold a range a ref points into at a merge' '
>       ++	git reset --hard start &&
>       ++	main=$(git symbolic-ref --short HEAD) &&
>       ++	test_commit --no-tag refmerge-base file b &&
>       ++	git checkout -b refmerge-side &&
>       ++	test_commit --no-tag refmerge-side side x &&
>       ++	git checkout "$main" &&
>       ++	test_commit --no-tag refmerge-main file c &&
>       ++	git merge --no-ff -m "interior merge" refmerge-side &&
>       ++	git branch -D refmerge-side &&
>       ++	git branch at-merge HEAD &&
>       ++	test_commit --no-tag refmerge-tail file d &&
>       ++	head_before=$(git rev-parse HEAD) &&
>       ++
>       ++	test_must_fail git history squash start.. 2>err &&
>       ++	test_grep "at-merge" err &&
>       ++	test_grep "points into the squashed range" err &&
>       ++	test_cmp_rev "$head_before" HEAD &&
>       ++
>       ++	git branch -D at-merge
>       ++'
>       ++
>        +test_done
>   4:  85c7817d7e = 4:  a758e1f084 history: re-edit a squash with every message
> 

