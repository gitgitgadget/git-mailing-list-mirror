Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A63E959C
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177605; cv=none; b=tOp9I9IyEHQQj6EpPNrCeVh+DlFh8Qlc2gJ9D3fSB/Z8ByCA3zQPrVVOyc6Vy6NAKZQHprKrWig+lP4uheL4SN5y2P0XtkksJ23E1iFiB5lojptHDf39PYDk+t5A07rGG0lI571Asl5ztNBK4IixLzLNyVHNHrklfLkh3+aI+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177605; c=relaxed/simple;
	bh=BgXj1csMmBSIMYiex2UELlo/4oDdk3aSyGxCOw15L10=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fOvKKefnTL1q2R6TqCYTeYZoRX3mRVjDZBkg+j0srG6OmeSyzuZPrx+AGW8PT0FOlh3cM/rJnrH9ruxDnDR3qlyn/6+M/RFztJ2VgPTtEHXFKh/C9Xj89DUSx2ZME7hnoyh2x2Rga5TR1G3zyQgmqm5vmyTauaub7oOk5obk+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW2tPnoW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW2tPnoW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93906e8a5feso355551185a.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788177603; x=1788782403; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+x0KgbMa5qWrpt8bNvggqEuMOdX1EBlLKQfpez1yWYA=;
        b=NW2tPnoWl3xEhofvN6yinO7NMSMWif1v7EToP/fX7qGhqIrZr4Ub9HzRuCIi1Xgdks
         p/aw6aO7K1vaLYQNYOfvkJlwR49zHxF5xmxFXvDe1ryIaHBRzr++Lur9O/NGXOyAsX1t
         YqIJ6GOGJxx1MGnyM31Ngm9MzNDXejqXsPaka5aaK44FSyYPro8zNBwh00mxnqNKYWsz
         +ypTuGTRhutKuGbUFo+hRv0bTr+v89XrpoLl6uDt4u1MGmrPd+LqXB1DhQ87cxvYB6cM
         oD5rJIaJ/6E6cyT8gtq+EIo3P8+tdqsfXUAfyLoA2N+vh7cMT3WMmLRM/dhE6TZQzxGV
         AH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788177603; x=1788782403;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+x0KgbMa5qWrpt8bNvggqEuMOdX1EBlLKQfpez1yWYA=;
        b=au2fEURAaSYw/eUPd4iwiix3CjSB6NTVDy416m5dFre4o7Gemx1/d1FZ0xmuScl6D7
         8KvobK/M/NLb1y47K40BuhU0oh1bUatpvPWFElPlTqWlIdxPQjHaCyD3TrhryRNiCupT
         JXgI4O7B4glusJYMoI7oEvIfrY6LlIGe58diVn+sbUTW8wIMlSJNwT2KqXY4dtDxdUK0
         G6queC7A+YDwX3ljOyutsQZM9PMhGE9gvWrYiCTwpMve5/0U/QTnzoGDWjI2okL9Hf7t
         j4xPUhQJPBYrSYbYsXGi0QaUGXRM6aFB34fVqi1pV86tnhP0ExgUluLTUyGkDIVYFoaW
         jfOg==
X-Gm-Message-State: AFuF++nVz0dI1htHeeSUqe/x8251LOPn6RxD5+Jo5EF66ip0sK716dp8
	KJwwxm1NvX1UDzJb65pYuOn8Re8wFmpAn21cyXNA3WDe8/qUl20EgR7BGjTtGg==
X-Gm-Gg: AR+sD10sGRL2V6R82wduJmDAENZCgnSm+dcll0xY+1tgjWR7+nxtrzUaYXFJMf3Ksop
	ZlDwve9X+cIAK8DkPazCv7mOuA8J5IZraFpfeHhH4laOCZEymcwJk9fGJ0XkGX2Nq36pffaRPh2
	3SRHyn/LvqylkmDBBobfPgnMrDPuamJlkbmz1sOuA6chn6RcYssLZEZfQFaG4yrktI5bn9bcOys
	xC1sBNZoKtda6Hoflmb/ukSVEd1JrELB2xIB5Yp5nbXEwZY/jLk2oJ90gtU3IQz0cPt+15toSf2
	5yelpDtn45eO0b+dqe6XR81mGpu4VhZWJqaoogq05h/1OxkDUoqhvT0nT0IGD6LGh4NxOWCG9I3
	f3OG8lcKrUoysW/H+vwv1BS+sicuBSUGxF4/w7DdQ2i+kerxdt0j0tzAEvbPDoosDOEf3e6MJVY
	888JEBdFknrMM3XOHPVOPkIGLjuJXiQFiJ09nmYfO/c83x0vEqHh2Ki5ph20K5ba+zeDuk1TW+q
	Jc=
X-Received: by 2002:ae9:f007:0:b0:939:869:a8bb with SMTP id af79cd13be357-939137d1e5cmr2342600385a.14.1788177602639;
        Mon, 31 Aug 2026 05:00:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.203.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917426e18sm768905885a.46.2026.08.31.05.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:00:02 -0700 (PDT)
Message-Id: <pull.2364.v2.git.git.1788177601572.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 12:00:01 +0000
Subject: [PATCH v2] checkout: print blank line after autostash conflict advice
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When "git checkout -m" stashes the user's local changes and then fails
to re-apply them because of conflicts, the conflict advice is printed
directly on top of the branch-switch message ("Switched to branch ..."),
making the two messages hard to tell apart.  Print a blank line in
between when the stash apply conflicted, so that the advice and the
branch-switch message are visually distinct.

To learn whether the stash apply resulted in conflicts, make the
autostash apply functions return 1 when the stash could not be applied
due to conflicts (and was stored back), while success and error remain
0 and -1 respectively.  Checkout can then use the return value to decide
whether to print the blank line.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout -m: refine autostash fallback
    
    Avoiding checkout -m autostash retries when no tracked local changes
    exist and visually separating autostash conflict advice from the
    subsequent branch-switch message. Addresses #leftoverbits from here:
    https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/
    
    Changes in v2:
    
     * Simplify logic and combine to one commit.
     * Test full output with test_cmp.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2364%2FHaraldNordgren%2Fhn%2Fgit-checkout-m-leftoverbits-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2364/HaraldNordgren/hn/git-checkout-m-leftoverbits-v2
Pull-Request: https://github.com/git/git/pull/2364

Range-diff vs v1:

 1:  b501b5fcd0 < -:  ---------- sequencer: teach autostash apply to report conflicts
 2:  37becf38c2 ! 1:  b44c53fcf2 checkout -m: refine autostash fallback
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    checkout -m: refine autostash fallback
     +    checkout: print blank line after autostash conflict advice
      
     -    When unpack_trees() fails under "git checkout -m", only create an
     -    autostash and retry if there are tracked local changes.  Without such
     -    changes, the fallback cannot help and merely repeats the same failure.
     +    When "git checkout -m" stashes the user's local changes and then fails
     +    to re-apply them because of conflicts, the conflict advice is printed
     +    directly on top of the branch-switch message ("Switched to branch ..."),
     +    making the two messages hard to tell apart.  Print a blank line in
     +    between when the stash apply conflicted, so that the advice and the
     +    branch-switch message are visually distinct.
      
     -    Use the conflict result from apply_autostash_ref() to print a blank line
     -    before the branch-switch message, visually separating it from the
     -    conflict advice.
     +    To learn whether the stash apply resulted in conflicts, make the
     +    autostash apply functions return 1 when the stash could not be applied
     +    due to conflicts (and was stored back), while success and error remain
     +    0 and -1 respectively.  Checkout can then use the return value to decide
     +    whether to print the blank line.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## builtin/checkout.c ##
     -@@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts,
     - static int merge_working_tree(const struct checkout_opts *opts,
     - 			      struct branch_info *old_branch_info,
     - 			      struct branch_info *new_branch_info,
     --			      bool quiet,
     -+			      bool allow_autostash,
     - 			      int *writeout_error)
     - {
     - 	int ret;
     -+	bool can_autostash = false;
     - 	struct lock_file lock_file = LOCK_INIT;
     - 	struct tree *new_tree;
     - 
     -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     - 			return 1;
     - 		}
     - 
     -+		if (allow_autostash)
     -+			can_autostash = has_unstaged_changes(the_repository, 1) ||
     -+				has_uncommitted_changes(the_repository, 1);
     -+
     - 		/* 2-way merge to the new branch */
     - 		init_topts(&topts, opts->show_progress,
     --			   opts->overwrite_ignore, quiet);
     -+			   opts->overwrite_ignore, can_autostash);
     - 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
     - 				       new_branch_info->commit ?
     - 				       &new_branch_info->commit->object.oid :
     -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     - 		clear_unpack_trees_porcelain(&topts);
     - 		if (ret == -1) {
     - 			rollback_lock_file(&lock_file);
     --			return MERGE_WORKING_TREE_UNPACK_FAILED;
     -+			return can_autostash ?
     -+				MERGE_WORKING_TREE_UNPACK_FAILED : 1;
     - 		}
     - 	}
     - 
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	int flag, writeout_error = 0;
       	int do_merge = 1;
       	int created_autostash = 0;
     -+	bool autostash_conflicted = false;
     ++	int autostash_res = 0;
       	struct strbuf old_commit_shortname = STRBUF_INIT;
       	struct strbuf autostash_msg = STRBUF_INIT;
       	const char *stash_label_base = NULL;
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
     - 					    "local",
     - 					    stash_label_base,
     - 					    autostash_msg.buf,
     --					    NULL);
     -+					    &autostash_conflicted);
     + 				git_config_push_parameter(cfg.buf);
     + 				strbuf_release(&cfg);
     + 			}
     +-			apply_autostash_ref(the_repository,
     +-					    "CHECKOUT_AUTOSTASH_HEAD",
     +-					    new_branch_info->name,
     +-					    "local",
     +-					    stash_label_base,
     +-					    autostash_msg.buf);
     ++			autostash_res = apply_autostash_ref(the_repository,
     ++				    "CHECKOUT_AUTOSTASH_HEAD",
     ++				    new_branch_info->name,
     ++				    "local",
     ++				    stash_label_base,
     ++				    autostash_msg.buf);
       		}
       		if (ret) {
       			branch_info_release(&old_branch_info);
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
       		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
       
     -+	if (autostash_conflicted && !opts->quiet)
     ++	if (autostash_res == 1 && !opts->quiet)
      +		fputc('\n', stderr);
       	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
       
       	if (created_autostash) {
      
     + ## sequencer.c ##
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     + 		if (label_base)
     + 			strvec_pushf(&child.args, "--label-base=%s", label_base);
     + 		strvec_push(&child.args, stash_oid);
     +-		ret = run_command(&child);
     ++		if (run_command(&child))
     ++			ret = 1;
     + 	}
     + 
     + 	if (attempt_apply && !ret)
     +
       ## t/t7201-co.sh ##
      @@ t/t7201-co.sh: test_expect_success 'checkout -m creates a recoverable stash on conflict' '
     - 	test_grep "git stash drop" actual &&
     - 	test_grep "git stash pop" actual &&
     - 	test_grep "The following paths have local changes" actual &&
     -+	sed -n "/apply the local changes later/,/Switched to branch/p" \
     -+		actual >separator.actual &&
     -+	cat >separator.expect <<-EOF &&
     + 	test_must_fail git checkout side 2>stderr &&
     + 	test_grep "Your local changes" stderr &&
     + 	git checkout -m side >actual 2>&1 &&
     +-	test_grep "resulted in conflicts" actual &&
     +-	test_grep "git stash drop" actual &&
     +-	test_grep "git stash pop" actual &&
     +-	test_grep "The following paths have local changes" actual &&
     ++	cat >expect <<-EOF &&
     ++	Your local changes are stashed, however applying them
     ++	resulted in conflicts.  You can either resolve the conflicts
     ++	and then discard the stash with "git stash drop", or, if you
     ++	do not want to resolve them now, run "git reset --hard" and
      +	apply the local changes later by running "git stash pop".
      +
      +	Switched to branch ${SQ}side${SQ}
     ++	The following paths have local changes:
     ++	M	one
      +	EOF
     -+	test_cmp separator.expect separator.actual &&
     ++	test_cmp expect actual &&
       	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
       	sed /^index/d actual >actual.trimmed &&
       	cat >expect <<-EOF &&
     -@@ t/t7201-co.sh: test_expect_success 'checkout -m creates a recoverable stash on conflict' '
     - 	git reset --hard
     - '
     - 
     --test_expect_success 'checkout -m which would overwrite untracked file' '
     -+test_expect_success 'checkout -m only retries untracked-file failure with local changes' '
     - 	git checkout -f --detach main &&
     - 	test_commit another-file &&
     - 	git checkout HEAD^ &&
     - 	>another-file.t &&
     -+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/trace" \
     -+		git checkout -m @{-1} 2>err &&
     -+	test_grep "untracked working tree files" err &&
     -+	grep "\"region_enter\".*\"category\":\"index\",\"label\":\"refresh\"" \
     -+		trace >refresh.events &&
     -+	test_line_count = 1 refresh.events &&
     -+
     - 	fill 1 2 3 4 5 >one &&
     - 	test_must_fail git checkout -m @{-1} 2>err &&
     - 	q_to_tab >expect <<-\EOF &&


 builtin/checkout.c | 15 +++++++++------
 sequencer.c        |  3 ++-
 t/t7201-co.sh      | 16 ++++++++++++----
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..e4b7383f10 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1166,6 +1166,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	int flag, writeout_error = 0;
 	int do_merge = 1;
 	int created_autostash = 0;
+	int autostash_res = 0;
 	struct strbuf old_commit_shortname = STRBUF_INIT;
 	struct strbuf autostash_msg = STRBUF_INIT;
 	const char *stash_label_base = NULL;
@@ -1237,12 +1238,12 @@ static int switch_branches(const struct checkout_opts *opts,
 				git_config_push_parameter(cfg.buf);
 				strbuf_release(&cfg);
 			}
-			apply_autostash_ref(the_repository,
-					    "CHECKOUT_AUTOSTASH_HEAD",
-					    new_branch_info->name,
-					    "local",
-					    stash_label_base,
-					    autostash_msg.buf);
+			autostash_res = apply_autostash_ref(the_repository,
+				    "CHECKOUT_AUTOSTASH_HEAD",
+				    new_branch_info->name,
+				    "local",
+				    stash_label_base,
+				    autostash_msg.buf);
 		}
 		if (ret) {
 			branch_info_release(&old_branch_info);
@@ -1255,6 +1256,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
 		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
 
+	if (autostash_res == 1 && !opts->quiet)
+		fputc('\n', stderr);
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	if (created_autostash) {
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..5ed9ae86c4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4815,7 +4815,8 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		if (label_base)
 			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
-		ret = run_command(&child);
+		if (run_command(&child))
+			ret = 1;
 	}
 
 	if (attempt_apply && !ret)
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0ddd1ad7aa..9ea9462914 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -236,10 +236,18 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
 	test_must_fail git checkout side 2>stderr &&
 	test_grep "Your local changes" stderr &&
 	git checkout -m side >actual 2>&1 &&
-	test_grep "resulted in conflicts" actual &&
-	test_grep "git stash drop" actual &&
-	test_grep "git stash pop" actual &&
-	test_grep "The following paths have local changes" actual &&
+	cat >expect <<-EOF &&
+	Your local changes are stashed, however applying them
+	resulted in conflicts.  You can either resolve the conflicts
+	and then discard the stash with "git stash drop", or, if you
+	do not want to resolve them now, run "git reset --hard" and
+	apply the local changes later by running "git stash pop".
+
+	Switched to branch ${SQ}side${SQ}
+	The following paths have local changes:
+	M	one
+	EOF
+	test_cmp expect actual &&
 	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
 	sed /^index/d actual >actual.trimmed &&
 	cat >expect <<-EOF &&

base-commit: c73e85354c275c9d409b26445089bc16940fc527
-- 
gitgitgadget
