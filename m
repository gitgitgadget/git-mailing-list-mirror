Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E340F8EA
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542048; cv=none; b=rPvsGwY83ZdY9p4rfx/DfCVF2wtYhlF0ojaHRv9EJnq6IaD6b+z2VCgXNf4KY7bnrucSjq8jkwIQb7r4euaaeKi1cBqoh8sosuQjoyfuQPVlhk2epVikdx8ULGyeQCk8tOk3XNgD+yH/jjch4Rqr7gUdq/wcn6vqxDKFasBtRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542048; c=relaxed/simple;
	bh=zwrgCtYgBGIA8IE7ELceZjxEBc81iqRrxYhpG2kTrYI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gOjsFE5zdOu40LGSlP9l7cc4zr8yNF9oWlB1QFFJjFSPcc/WXY1QItb749TpKAsRNysx7+PlyYTLcn6zpmyLlFGh/x+8s2AYUUfBWXYRwSC/t/nKI+DCUU4bQSgOjg9sNyClaHN4E7ACr9iOmy/GD/J1bHc9x5J9RhlQTG9jzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9p1AYCR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9p1AYCR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3075ce9c05aso8991470eec.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542045; x=1782146845; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mjt3rU1ZaG46vgXGzj1qmcKjLObTFzu2yIAhL9ELKg=;
        b=e9p1AYCRoiZ8Np3jL5ealdmbBy+XWn7QTdKKqaNcEVuEUUEN+WjqzBCZYpGd5L4jsp
         t61gBRfw1C5vNscZIycaSBYqYvmV8LRycjpGtk6g4z2k9oLZuCRoKEGPa+kCLxZDuJVq
         6SwbvOHAZeYddCHy+2xwdyfDvskdOebUzJwzMpB3ZCtNE17s3+5UPjTJPhEI435WhCqv
         SANYhJamcOn7VGH8SCb5licZtO3ESxPOpuiTLH1NRLGM3DkdqMcHlGDezs+7S0OM2lR8
         /voz8ssHlWn8JUzuPS/+EevEWGc2BuVMyxSnfmyjv7zxJyBWfyg2XLAEOrUweJXvM7xI
         emBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542045; x=1782146845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Mjt3rU1ZaG46vgXGzj1qmcKjLObTFzu2yIAhL9ELKg=;
        b=H7MnaC4k6fgZakz2j6ksWCyd41fdOgXU2tShmVjpYkKJd0Wjh/m0Vjc4oEClsAQWog
         ccgQ0WqdMqyvNH1ShSRpcvClnm62Ys3svOH+rvZVl6hxhimIivoc8CHm3eo1Peks2t5G
         4kMbeVCOwULTclF5ahDVZtpoirMw8PahNseqXpwc6u4007yNiyat/1djN1ycSOjgMqJh
         42HG8KVd7AbI/k0bT0xfzPbvHAl/fw+jmg6pXeDCKJTb7JeebXKMnVA7nlapBD7avKhJ
         jNZO5eulCHfT4o7vHUs5vVMnq2wnmnPggFBhn6XjkpdSQ56T7u3qMKBiarjU2xgzqBHo
         +HiA==
X-Gm-Message-State: AOJu0YyrqMvXco43aNCVvnIiCvxn76dQOmQXSxS33twfeW4ihuTiC8If
	QzaeoHpluQWMm2M9BCbfIr2pr5xNmtalbRmXzIbnJ+Xm9ODTOx3Yu7TJpr4Q7g==
X-Gm-Gg: Acq92OE8q/OE6DDI4mHsch/UWgDLO3A87h6yT/8/NwX1CjMrWtzXviFhg5hYASMht33
	4dXu2ANduOBUsC8Wo/QfxKIT+8L8pVHL9SxYXeLHIGQfnUr4JhXj3pfLKZTxgB+0bZD0sFodMPE
	sEYNqV7rFNXZorb1NlXC1ewrTbG5JYxQTcuje5/3LhkM3JTEWkkdyF7FGabZ/9WNa6NO8Qo8Lrq
	PPBFgVFuC8zX2PW44cev737lV2PgffV30hVbvMDpo32PEmq4ibc0kN9YzsXHu4fAAckzax+EoVD
	ZS066zKV1jNIt3Maor6Cbl+7Mrl33MIyLoTDB5+cAeW+z36dmGMXuHS3Kl24vRjRm54qKfpEUIU
	0j6gFYz4jGZkEQkLmc3TaWvsc2Ggn56rcIRHdjNyAhhQ017Aou+Z7sHX0lCjoHI2TdKl3CPeR8Z
	6jTiOOmgf4cV4qKZk2s8/WrNZT
X-Received: by 2002:a05:7300:8b84:b0:304:819f:502b with SMTP id 5a478bee46e88-3081ff82037mr8986467eec.9.1781542044435;
        Mon, 15 Jun 2026 09:47:24 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95342sm15619366eec.29.2026.06.15.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:23 -0700 (PDT)
Message-Id: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:15 +0000
Subject: [PATCH v15 0/7] branch: delete-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * Renamed --prune-merged to --delete-merged throughout. Not necessarily
   final, but something to advance the discussion.
 * --delete-merged now silently skips not-yet-merged branches instead of
   warning.
 * --forked now accepts a bare remote name (e.g. origin) for the branch
   origin/HEAD points at using DWIM.
 * Initialized the delete_branches() flag locals where declared. Only force
   stays deferred.
 * delete_branches()/check_branch_commit() doc and code cleanups: redundant
   branch NULL checks dropped, ref_array candidates = { 0 }, a BUG() for the
   unreachable non-branch ref, and reworked --delete-merged doc wording.
 * Broadened the --forked tests (local commits for realism, remote add -f,
   --forked <pattern> <branch> coverage), renamed the misleading trunk
   fixture, and replaced the misnamed detached branch with git checkout
   --detach.

Harald Nordgren (7):
  branch: add --forked filter for --list mode
  branch: convert delete_branches() to a flags argument
  branch: let delete_branches skip unmerged branches on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --delete-merged <branch>
  branch: add branch.<name>.deleteMerged opt-out
  branch: add --dry-run for --delete-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  43 +++-
 builtin/branch.c                 | 184 ++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 387 +++++++++++++++++++++++++++++++
 6 files changed, 673 insertions(+), 28 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v15
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v14:

 1:  7383872f4b ! 1:  da741b5ea7 branch: add --forked filter for --list mode
     @@ Commit message
      
          Add a --forked option to "git branch" list mode that lists only
          branches whose configured upstream matches <branch>. The argument
     -    can be a ref (e.g. "origin/main", "master") or a shell glob
     +    can be a ref (e.g. "origin/main", "master"), a remote name like
     +    "origin" for the branch its origin/HEAD points at, or a shell glob
          (e.g. "origin/*"), and may be repeated to widen the filter.
      
          It is an ordinary list filter, so it combines with the others:
     @@ Commit message
          lists branches forked from origin that are already merged into
          origin/main, and --no-merged inverts the question.
      
     -    This is the building block for --prune-merged, which deletes the
     +    This is the building block for --delete-merged, which deletes the
          listed branches once they have landed on their upstream.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     @@ Documentation/git-branch.adoc: superproject's "origin/main", but tracks the subm
      +`--forked <branch>`::
      +	Only list branches whose configured upstream matches
      +	_<branch>_. The argument can be a ref (e.g. `origin/main`,
     -+	`master`) or a shell-style glob (e.g. `'origin/*'`). The
     -+	option can be repeated to widen the filter. Implies `--list`.
     ++	`master`), a remote name like `origin` for the branch its
     ++	`origin/HEAD` points at, or a shell-style glob (e.g.
     ++	`'origin/*'`). The option can be repeated to widen the
     ++	filter. Implies `--list`.
      +
       `--points-at <object>`::
       	Only list branches of _<object>_.
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	git -C forked-other branch foreign other-base &&
      +
      +	git clone forked-upstream forked &&
     -+	git -C forked remote add other ../forked-other &&
     -+	git -C forked fetch other &&
     ++	git -C forked remote add -f other ../forked-other &&
     ++	git -C forked remote set-head origin one &&
      +	git -C forked branch local-base &&
      +	git -C forked branch --track local-one origin/one &&
      +	git -C forked branch --track local-two origin/two &&
      +	git -C forked branch --track local-foreign other/foreign &&
     -+	git -C forked branch detached &&
     -+	git -C forked branch --track local-trunk local-base
     ++	git -C forked branch --track local-onbase local-base &&
     ++
     ++	git -C forked checkout local-one &&
     ++	test_commit -C forked --no-tag local-one-work local-one.t &&
     ++	git -C forked checkout local-foreign &&
     ++	test_commit -C forked --no-tag local-foreign-work local-foreign.t &&
     ++	git -C forked checkout --detach
      +'
      +
      +test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +
      +test_expect_success '--forked <local-branch> matches branches with local upstream' '
      +	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
     -+	echo local-trunk >expect &&
     ++	echo local-onbase >expect &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
     -+	local-trunk
     ++	local-onbase
      +	EOF
      +	test_cmp expect actual
      +'
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked composes with --no-merged' '
     -+	test_when_finished "git -C forked checkout detached" &&
     ++	test_when_finished "git -C forked checkout --detach" &&
      +	git -C forked checkout local-one &&
      +	test_commit -C forked local-only &&
      +	git -C forked branch --forked "origin/*" --no-merged origin/one \
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	test_must_fail git -C forked branch --forked 2>err &&
      +	test_grep "requires a value" err
      +'
     ++
     ++test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
     ++	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
     ++	echo local-one >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success '--forked narrows a <pattern> argument' '
     ++	git -C forked branch --forked "origin/*" "local-*" \
     ++		--format="%(refname:short)" >actual &&
     ++	cat >expect <<-\EOF &&
     ++	local-one
     ++	local-two
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
       test_done
 2:  7ef9502e01 ! 2:  91c35f10cc branch: let delete_branches warn instead of error on bulk refusal
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: let delete_branches warn instead of error on bulk refusal
     +    branch: convert delete_branches() to a flags argument
      
     -    Add a warn-only mode to delete_branches() and check_branch_commit()
     -    so a bulk caller can report branches that are not fully merged as a
     -    short warning and carry on, rather than erroring with the longer
     -    "use 'git branch -D'" advice that the plain "git branch -d" path
     -    emits. Existing callers are unaffected.
     +    delete_branches() and check_branch_commit() take a pair of int
     +    booleans (force and quiet) that the next commits would grow further.
     +    Replace them with a single "unsigned int flags" argument and an
     +    enum, splitting the bits back into named bool locals so the body
     +    keeps reading the same named values.
     +
     +    No change in behavior.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
      +enum delete_branch_flags {
      +	DELETE_BRANCH_FORCE = (1 << 0),
      +	DELETE_BRANCH_QUIET = (1 << 1),
     -+	DELETE_BRANCH_WARN_ONLY = (1 << 2),
      +};
      +
       static int check_branch_commit(const char *branchname, const char *refname,
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
      -			       int kinds, int force)
      +			       int kinds, unsigned int flags)
       {
     -+	int force = flags & DELETE_BRANCH_FORCE;
     ++	bool force = flags & DELETE_BRANCH_FORCE;
       	struct commit *rev = lookup_commit_reference(the_repository, oid);
       	if (!force && !rev) {
       		error(_("couldn't look up commit object for '%s'"), refname);
     - 		return -1;
     - 	}
     - 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     --		error(_("the branch '%s' is not fully merged"), branchname);
     --		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
     --				  _("If you are sure you want to delete it, "
     --				  "run 'git branch -D %s'"), branchname);
     -+		if (flags & DELETE_BRANCH_WARN_ONLY) {
     -+			warning(_("the branch '%s' is not fully merged"),
     -+				branchname);
     -+		} else {
     -+			error(_("the branch '%s' is not fully merged"),
     -+			      branchname);
     -+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
     -+					  _("If you are sure you want to delete it, "
     -+					  "run 'git branch -D %s'"), branchname);
     -+		}
     - 		return -1;
     - 	}
     - 	return 0;
      @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       	strbuf_release(&buf);
       }
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       	int i;
       	int ret = 0;
       	int remote_branch = 0;
     -+	int force, quiet;
     ++	bool force;
     ++	bool quiet = flags & DELETE_BRANCH_QUIET;
       	struct strbuf bname = STRBUF_INIT;
       	enum interpret_branch_kind allowed_interpret;
       	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       	branch_name_pos = strcspn(fmt, "%");
       
      +	force = flags & DELETE_BRANCH_FORCE;
     -+	quiet = flags & DELETE_BRANCH_QUIET;
      +
       	if (!force)
       		head_rev = lookup_commit_reference(the_repository, &head_oid);
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      +		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
       		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
      -					force)) {
     --			ret = 1;
      +					flags)) {
     -+			if (!(flags & DELETE_BRANCH_WARN_ONLY))
     -+				ret = 1;
     + 			ret = 1;
       			goto next;
       		}
       
 -:  ---------- > 3:  e101dd2886 branch: let delete_branches skip unmerged branches on bulk refusal
 3:  259113e304 ! 4:  6c3534901a branch: prepare delete_branches for a bulk caller
     @@ Commit message
          branch: prepare delete_branches for a bulk caller
      
          Teach delete_branches() two new modes for the upcoming
     -    --prune-merged: one that asks only whether a branch is merged into
     +    --delete-merged: one that asks only whether a branch is merged into
          its upstream, without falling back to HEAD when there is no
          upstream, and one that rehearses the deletions without removing any
          ref. Existing callers keep their current behavior.
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
      @@ builtin/branch.c: enum delete_branch_flags {
       	DELETE_BRANCH_FORCE = (1 << 0),
       	DELETE_BRANCH_QUIET = (1 << 1),
     - 	DELETE_BRANCH_WARN_ONLY = (1 << 2),
     + 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
      +	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
      +	DELETE_BRANCH_DRY_RUN = (1 << 4),
       };
       
       static int check_branch_commit(const char *branchname, const char *refname,
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 	int i;
     - 	int ret = 0;
     - 	int remote_branch = 0;
     --	int force, quiet;
     -+	int force, quiet, dry_run, no_head_fallback;
     + 	bool force;
     + 	bool quiet = flags & DELETE_BRANCH_QUIET;
     + 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     ++	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
     ++	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
       	struct strbuf bname = STRBUF_INIT;
       	enum interpret_branch_kind allowed_interpret;
       	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
       
       	force = flags & DELETE_BRANCH_FORCE;
     - 	quiet = flags & DELETE_BRANCH_QUIET;
     -+	dry_run = flags & DELETE_BRANCH_DRY_RUN;
     -+	no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
       
      -	if (!force)
      +	if (!force && !no_head_fallback)
 4:  9924373da0 ! 5:  5899013b8f branch: add --prune-merged <branch>
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --prune-merged <branch>
     +    branch: add --delete-merged <branch>
      
     -            git branch --prune-merged <branch>...
     +            git branch --delete-merged <branch>...
      
          deletes the local branches that "--forked <branch>" would list,
          keeping only those whose tip is reachable from their configured
     -    upstream: the work has already landed on the upstream they track,
     +    upstream. The work has already landed on the upstream they track,
          so the local copy is no longer needed.
      
     -    Reachability is read from local refs; nothing is fetched. Run
     -    "git fetch" first if you want fresh upstream refs.
     +    Three kinds of branches are not deleted:
      
     -    Three kinds of branches are spared:
     -
     -      * any branch checked out in any worktree;
     -      * any branch whose upstream no longer resolves locally, since a
     -        missing upstream is not by itself a sign of integration;
     +      * any branch checked out in any worktree
     +      * any branch whose upstream remote-tracking branch no longer
     +        exists, since a missing upstream is not by itself a sign of
     +        integration
            * any branch whose push destination equals its upstream
              (<branch>@{push} is the same as <branch>@{upstream}), such as
              a local "main" that tracks and pushes to "origin/main". Right
     -        after a pull it just looks "fully merged", so it is left
     -        alone. Only branches that push somewhere other than their
     -        upstream, typically topics in a fork workflow, are candidates.
     +        after a pull it just looks "fully merged", so it is kept. Only
     +        branches that push somewhere other than their upstream,
     +        typically topics in a fork workflow, are candidates.
      
     -    Branches that are not yet merged into their upstream are reported
     -    as a short warning and skipped, so one unmerged topic does not
     -    abort the whole sweep.
     +    A branch whose work is not yet merged into its upstream is silently
     +    skipped, so one unmerged topic does not abort the whole sweep.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     -+git branch --prune-merged <branch>...
     ++git branch --delete-merged <branch>...
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
       	Print the name of the current branch. In detached `HEAD` state,
       	nothing is printed.
       
     -+`--prune-merged <branch>...`::
     ++`--delete-merged <branch>...`::
      +	Delete the local branches that `--forked` would list for the
      +	given _<branch>_ arguments, but only those whose tip is
      +	reachable from their configured upstream. In other words, the
      +	work on the branch has already landed on the upstream it
      +	tracks, so the local copy is no longer needed. Several
      +	_<branch>_ patterns may be given, e.g. `git branch
     -+	--prune-merged origin/main 'feature*'`.
     ++	--delete-merged origin/main 'feature*'`.
      ++
     -+Reachability is checked against whatever the upstream refs say
     -+locally; nothing is fetched. Run `git fetch` first if you want
     -+the upstream refs refreshed.
     ++A branch is not deleted when:
      ++
     -+A branch is left alone if any of the following holds:
     -+its upstream no longer resolves locally; it is checked out in any
     -+worktree; or its push destination (`<branch>@{push}`) equals its
     -+upstream (`<branch>@{upstream}`), so it cannot be distinguished
     -+from a freshly pulled trunk that just looks "fully merged".
     ++--
     ++* its upstream remote-tracking branch no longer exists,
     ++* it is checked out in any worktree, or
     ++* its push destination (`<branch>@{push}`) equals its upstream
     ++  (`<branch>@{upstream}`), so it cannot be distinguished from a
     ++  branch that just looks "fully merged" right after a pull.
     ++--
      ++
     -+Branches refused by the "fully merged" safety check are listed as
     -+warnings and skipped; pass them to `git branch -D` explicitly if
     -+you want them gone.
     ++A branch whose work has not yet been merged into its upstream is
     ++silently skipped. Delete it with `git branch -D` if you want to
     ++remove it anyway.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
       	N_("git branch [<options>] [-r | -a] [--points-at]"),
       	N_("git branch [<options>] [-r | -a] [--format]"),
     -+	N_("git branch [<options>] --prune-merged <branch>..."),
     ++	N_("git branch [<options>] --delete-merged <branch>..."),
       	NULL
       };
       
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
       	return 0;
       }
       
     -+static int prune_merged_branches(int argc, const char **argv,
     ++static int delete_merged_branches(int argc, const char **argv,
      +				 int quiet)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct ref_filter filter = REF_FILTER_INIT;
     -+	struct ref_array candidates;
     ++	struct ref_array candidates = { 0 };
      +	struct strvec deletable = STRVEC_INIT;
      +	int i, ret = 0;
      +
      +	if (!argc)
     -+		die(_("--prune-merged requires at least one <branch>"));
     ++		die(_("--delete-merged requires at least one <branch>"));
      +
      +	for (i = 0; i < argc; i++)
      +		if (ref_filter_forked_add(&filter, argv[i]) < 0)
      +			die(_("'%s' is not a valid branch or pattern"), argv[i]);
      +
      +	filter.kind = FILTER_REFS_BRANCHES;
     -+	memset(&candidates, 0, sizeof(candidates));
      +	filter_refs(&candidates, &filter, filter.kind);
      +
      +	for (i = 0; i < candidates.nr; i++) {
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +		const char *upstream, *push;
      +
      +		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     -+			continue;
     ++			BUG("filter returned non-branch ref '%s'", full_name);
      +		if (branch_checked_out(full_name))
      +			continue;
      +
      +		branch = branch_get(short_name);
     -+		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
     ++		upstream = branch_get_upstream(branch, NULL);
      +		if (!upstream || !refs_ref_exists(refs, upstream))
      +			continue;
     -+		push = branch ? branch_get_push(branch, NULL) : NULL;
     ++		push = branch_get_push(branch, NULL);
      +		if (!push || !strcmp(push, upstream))
      +			continue;
      +
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	if (deletable.nr)
      +		ret = delete_branches(deletable.nr, deletable.v,
      +				      FILTER_REFS_BRANCHES,
     -+				      DELETE_BRANCH_WARN_ONLY |
     ++				      DELETE_BRANCH_SKIP_UNMERGED |
      +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
      +				      (quiet ? DELETE_BRANCH_QUIET : 0));
      +
     @@ builtin/branch.c: int cmd_branch(int argc,
       	/* possible actions */
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     -+	int prune_merged = 0;
     ++	int delete_merged = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
     @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
       		OPT_BOOL(0, "edit-description", &edit_description,
       			 N_("edit the description for the branch")),
     -+		OPT_BOOL(0, "prune-merged", &prune_merged,
     -+			N_("delete local branches whose upstream matches <branch> and is merged")),
     ++		OPT_BOOL(0, "delete-merged", &delete_merged,
     ++			N_("delete local branches whose upstream matches <branch> and are merged")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
      -	    !show_current && !unset_upstream && argc == 0)
     -+	    !show_current && !unset_upstream && !prune_merged &&
     ++	    !show_current && !unset_upstream && !delete_merged &&
      +	    argc == 0)
       		list = 1;
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
       			    !!show_current + !!list + !!edit_description +
      -			    !!unset_upstream;
     -+			    !!unset_upstream + !!prune_merged;
     ++			    !!unset_upstream + !!delete_merged;
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
       				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
     -+	} else if (prune_merged) {
     -+		ret = prune_merged_branches(argc, argv, quiet);
     ++	} else if (delete_merged) {
     ++		ret = delete_merged_branches(argc, argv, quiet);
      +		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
       		ret = 0;
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
     - 	test_grep "requires a value" err
     +@@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
     + 	test_cmp expect actual
       '
       
     -+test_expect_success '--prune-merged: setup' '
     ++test_expect_success '--delete-merged: setup' '
      +	test_create_repo pm-upstream &&
      +	test_commit -C pm-upstream base &&
      +	git -C pm-upstream checkout -b next &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	test_create_repo pm-fork
      +'
      +
     -+test_expect_success '--prune-merged deletes branches integrated into upstream' '
     ++test_expect_success '--delete-merged deletes branches integrated into upstream' '
      +	test_when_finished "rm -rf pm-merged" &&
      +	git clone pm-upstream pm-merged &&
      +	git -C pm-merged remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-merged branch two two-commit &&
      +	git -C pm-merged branch --set-upstream-to=origin/next two &&
      +
     -+	git -C pm-merged branch --prune-merged "origin/*" &&
     ++	git -C pm-merged branch --delete-merged "origin/*" &&
      +
      +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
      +'
      +
     -+test_expect_success '--prune-merged accepts a literal upstream' '
     ++test_expect_success '--delete-merged accepts a literal upstream' '
      +	test_when_finished "rm -rf pm-literal" &&
      +	git clone pm-upstream pm-literal &&
      +	git -C pm-literal remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-literal branch one one-commit &&
      +	git -C pm-literal branch --set-upstream-to=origin/next one &&
      +
     -+	git -C pm-literal branch --prune-merged origin/next &&
     ++	git -C pm-literal branch --delete-merged origin/next &&
      +
      +	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged unions multiple <branch> arguments' '
     ++test_expect_success '--delete-merged unions multiple <branch> arguments' '
      +	test_when_finished "rm -rf pm-union" &&
      +	git clone pm-upstream pm-union &&
      +	git -C pm-union remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-union branch --set-upstream-to=origin/main two &&
      +	git -C pm-union checkout --detach &&
      +
     -+	git -C pm-union branch --prune-merged origin/next origin/main &&
     ++	git -C pm-union branch --delete-merged origin/next origin/main &&
      +
      +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
      +'
      +
     -+test_expect_success '--prune-merged accepts a local upstream' '
     ++test_expect_success '--delete-merged accepts a local upstream' '
      +	test_when_finished "rm -rf pm-local" &&
      +	git clone pm-upstream pm-local &&
      +	git -C pm-local remote add fork ../pm-fork &&
      +	test_config -C pm-local remote.pushDefault fork &&
      +	test_config -C pm-local push.default current &&
     -+	git -C pm-local checkout -b trunk &&
     ++	git -C pm-local checkout -b mainline &&
      +	git -C pm-local branch one one-commit &&
     -+	git -C pm-local branch --set-upstream-to=trunk one &&
     ++	git -C pm-local branch --set-upstream-to=mainline one &&
      +	git -C pm-local merge --ff-only one-commit &&
      +
     -+	git -C pm-local branch --prune-merged trunk &&
     ++	git -C pm-local branch --delete-merged mainline &&
      +
      +	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
     ++test_expect_success '--delete-merged silently skips un-integrated commits' '
      +	test_when_finished "rm -rf pm-unmerged" &&
      +	git clone pm-upstream pm-unmerged &&
      +	git -C pm-unmerged remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	test_commit -C pm-unmerged local-only &&
      +	git -C pm-unmerged checkout - &&
      +
     -+	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
     -+	test_grep "not fully merged" err &&
     -+	test_grep ! "If you are sure you want to delete it" err &&
     ++	git -C pm-unmerged branch --delete-merged "origin/*" 2>err &&
     ++	test_grep ! "not fully merged" err &&
      +	git -C pm-unmerged rev-parse --verify refs/heads/wip
      +'
      +
     -+test_expect_success '--prune-merged is silent about not-merged-to-HEAD' '
     ++test_expect_success '--delete-merged is silent about not-merged-to-HEAD' '
      +	test_when_finished "rm -rf pm-nohead" &&
      +	git clone pm-upstream pm-nohead &&
      +	git -C pm-nohead remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-nohead branch topic one-commit &&
      +	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
      +
     -+	git -C pm-nohead branch --prune-merged "origin/*" 2>err &&
     ++	git -C pm-nohead branch --delete-merged "origin/*" 2>err &&
      +
      +	test_grep ! "not yet merged to HEAD" err &&
      +	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
      +'
      +
     -+test_expect_success '--prune-merged skips branches whose upstream is gone' '
     ++test_expect_success '--delete-merged skips branches whose upstream is gone' '
      +	test_when_finished "rm -rf pm-upstream-gone" &&
      +	git clone pm-upstream pm-upstream-gone &&
      +	git -C pm-upstream-gone remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
      +
      +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
     -+	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
     ++	git -C pm-upstream-gone branch --delete-merged "origin/*" &&
      +
      +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged never deletes the checked-out branch' '
     ++test_expect_success '--delete-merged never deletes the checked-out branch' '
      +	test_when_finished "rm -rf pm-head" &&
      +	git clone pm-upstream pm-head &&
      +	git -C pm-head remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-head checkout -b one one-commit &&
      +	git -C pm-head branch --set-upstream-to=origin/next one &&
      +
     -+	git -C pm-head branch --prune-merged "origin/*" &&
     ++	git -C pm-head branch --delete-merged "origin/*" &&
      +
      +	git -C pm-head rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged spares branches that push back to their upstream' '
     ++test_expect_success '--delete-merged spares branches that push back to their upstream' '
      +	test_when_finished "rm -rf pm-push-eq" &&
      +	git clone pm-upstream pm-push-eq &&
      +	git -C pm-push-eq checkout --detach &&
      +
     -+	git -C pm-push-eq branch --prune-merged "origin/*" &&
     ++	git -C pm-push-eq branch --delete-merged "origin/*" &&
      +
      +	git -C pm-push-eq rev-parse --verify refs/heads/main
      +'
      +
     -+test_expect_success '--prune-merged spares a per-branch pushRemote==upstream remote' '
     ++test_expect_success '--delete-merged spares a per-branch pushRemote==upstream remote' '
      +	test_when_finished "rm -rf pm-push-branch" &&
      +	git clone pm-upstream pm-push-branch &&
      +	git -C pm-push-branch remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	test_config -C pm-push-branch branch.main.pushRemote origin &&
      +	git -C pm-push-branch checkout --detach &&
      +
     -+	git -C pm-push-branch branch --prune-merged "origin/*" &&
     ++	git -C pm-push-branch branch --delete-merged "origin/*" &&
      +
      +	git -C pm-push-branch rev-parse --verify refs/heads/main
      +'
      +
     -+test_expect_success '--prune-merged prunes when @{push} differs from @{upstream}' '
     ++test_expect_success '--delete-merged prunes when @{push} differs from @{upstream}' '
      +	test_when_finished "rm -rf pm-push-diff" &&
      +	git clone pm-upstream pm-push-diff &&
      +	git -C pm-push-diff remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
      +	git -C pm-push-diff checkout --detach &&
      +
     -+	git -C pm-push-diff branch --prune-merged "origin/*" &&
     ++	git -C pm-push-diff branch --delete-merged "origin/*" &&
      +
      +	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
      +'
      +
     -+test_expect_success '--prune-merged requires at least one <branch>' '
     -+	test_must_fail git -C forked branch --prune-merged 2>err &&
     ++test_expect_success '--delete-merged requires at least one <branch>' '
     ++	test_must_fail git -C forked branch --delete-merged 2>err &&
      +	test_grep "requires at least one <branch>" err
      +'
      +
     -+test_expect_success '--prune-merged takes positional <branch> arguments' '
     ++test_expect_success '--delete-merged takes positional <branch> arguments' '
      +	test_when_finished "rm -rf pm-positional" &&
      +	git clone pm-upstream pm-positional &&
      +	git -C pm-positional remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-positional branch --set-upstream-to=origin/main two &&
      +	git -C pm-positional checkout --detach &&
      +
     -+	git -C pm-positional branch --prune-merged origin/next origin/main &&
     ++	git -C pm-positional branch --delete-merged origin/next origin/main &&
      +
      +	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
 5:  d691d5051b ! 6:  72aaca0666 branch: add branch.<name>.pruneMerged opt-out
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add branch.<name>.pruneMerged opt-out
     +    branch: add branch.<name>.deleteMerged opt-out
      
     -    Setting branch.<name>.pruneMerged=false exempts that branch from
     -    "git branch --prune-merged", which is useful for a topic you want
     +    Setting branch.<name>.deleteMerged=false exempts that branch from
     +    "git branch --delete-merged", which is useful for a topic you want
          to keep developing after an early round of it has been merged
          upstream. Unless --quiet is given, each skip is reported so the
          user knows why their topic was kept.
     @@ Documentation/config/branch.adoc: for details).
       	automatically added to the `format-patch` cover letter or
       	`request-pull` summary.
      +
     -+`branch.<name>.pruneMerged`::
     ++`branch.<name>.deleteMerged`::
      +	If set to `false`, branch _<name>_ is exempt from
     -+	`git branch --prune-merged`.  Useful for a topic branch you
     ++	`git branch --delete-merged`.  Useful for a topic branch you
      +	intend to develop further after an initial round has been
      +	merged upstream.  Defaults to true.  Explicit deletion via
      +	`git branch -d` is unaffected.
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: the upstream refs refreshed.
     +@@ Documentation/git-branch.adoc: A branch is not deleted when:
       +
     - A branch is left alone if any of the following holds:
     - its upstream no longer resolves locally; it is checked out in any
     --worktree; or its push destination (`<branch>@{push}`) equals its
     -+worktree; its push destination (`<branch>@{push}`) equals its
     - upstream (`<branch>@{upstream}`), so it cannot be distinguished
     --from a freshly pulled trunk that just looks "fully merged".
     -+from a freshly pulled trunk that just looks "fully merged"; or
     -+`branch.<name>.pruneMerged` is set to `false`.
     + --
     + * its upstream remote-tracking branch no longer exists,
     +-* it is checked out in any worktree, or
     ++* it is checked out in any worktree,
     + * its push destination (`<branch>@{push}`) equals its upstream
     +   (`<branch>@{upstream}`), so it cannot be distinguished from a
     +-  branch that just looks "fully merged" right after a pull.
     ++  branch that just looks "fully merged" right after a pull, or
     ++* `branch.<name>.deleteMerged` is set to `false`.
     + --
       +
     - Branches refused by the "fully merged" safety check are listed as
     - warnings and skipped; pass them to `git branch -D` explicitly if
     + A branch whose work has not yet been merged into its upstream is
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
     +@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       		const char *short_name;
       		struct branch *branch;
       		const char *upstream, *push;
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +		int opt_out;
       
       		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     - 			continue;
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
     + 			BUG("filter returned non-branch ref '%s'", full_name);
     +@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       		if (!push || !strcmp(push, upstream))
       			continue;
       
     -+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
     ++		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
      +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
      +		    !opt_out) {
      +			if (!quiet)
      +				fprintf(stderr,
     -+					_("Skipping '%s' (branch.%s.pruneMerged is false)\n"),
     ++					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
      +					short_name, short_name);
      +			strbuf_release(&key);
      +			continue;
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--prune-merged takes positional <branch> arguments' '
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged takes positional <branch> arguments' '
       	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
       '
       
     -+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
     ++test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
      +	test_when_finished "rm -rf pm-optout" &&
      +	git clone pm-upstream pm-optout &&
      +	git -C pm-optout remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success '--prune-merged takes positional <branch>
      +	git -C pm-optout branch --set-upstream-to=origin/next one &&
      +	git -C pm-optout branch two two-commit &&
      +	git -C pm-optout branch --set-upstream-to=origin/next two &&
     -+	test_config -C pm-optout branch.one.pruneMerged false &&
     ++	test_config -C pm-optout branch.one.deleteMerged false &&
      +
     -+	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
     ++	git -C pm-optout branch --delete-merged "origin/*" 2>err &&
      +
      +	git -C pm-optout rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
      +	test_grep "Skipping .one." err
      +'
      +
     -+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
     ++test_expect_success 'branch -d still deletes a deleteMerged=false branch' '
      +	test_when_finished "rm -rf pm-optout-d" &&
      +	git clone pm-upstream pm-optout-d &&
      +	git -C pm-optout-d branch one one-commit &&
      +	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
     -+	test_config -C pm-optout-d branch.one.pruneMerged false &&
     ++	test_config -C pm-optout-d branch.one.deleteMerged false &&
      +
      +	git -C pm-optout-d branch -d one &&
      +	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 6:  ede8c61729 ! 7:  7b2b01b988 branch: add --dry-run for --prune-merged
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --dry-run for --prune-merged
     +    branch: add --dry-run for --delete-merged
      
     -    With --dry-run, --prune-merged prints the local branches it would
     +    With --dry-run, --delete-merged prints the local branches it would
          delete, one "Would delete branch <name>" line each, and exits
          without touching any ref. The same filtering applies, so the output
          is exactly the set that the real run would delete.
      
     -    --dry-run is only meaningful together with --prune-merged and is
     +    --dry-run is only meaningful together with --delete-merged and is
          rejected otherwise.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     --git branch --prune-merged <branch>...
     -+git branch [--dry-run] --prune-merged <branch>...
     +-git branch --delete-merged <branch>...
     ++git branch [--dry-run] --delete-merged <branch>...
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: Branches refused by the "fully merged" safety check are listed as
     - warnings and skipped; pass them to `git branch -D` explicitly if
     - you want them gone.
     +@@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into its upstream is
     + silently skipped. Delete it with `git branch -D` if you want to
     + remove it anyway.
       
      +`--dry-run`::
     -+	With `--prune-merged`, print which branches would be
     ++	With `--delete-merged`, print which branches would be
      +	deleted and exit without touching any ref.  Useful for
      +	sanity-checking a wide pattern like `'origin/*'` before
      +	committing to the deletion.
     @@ builtin/branch.c
      @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const char *arg, int unset
       }
       
     - static int prune_merged_branches(int argc, const char **argv,
     + static int delete_merged_branches(int argc, const char **argv,
      -				 int quiet)
      +				 int quiet, int dry_run)
       {
       	struct ref_store *refs = get_main_ref_store(the_repository);
       	struct ref_filter filter = REF_FILTER_INIT;
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
     +@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       				      FILTER_REFS_BRANCHES,
     - 				      DELETE_BRANCH_WARN_ONLY |
     + 				      DELETE_BRANCH_SKIP_UNMERGED |
       				      DELETE_BRANCH_NO_HEAD_FALLBACK |
      -				      (quiet ? DELETE_BRANCH_QUIET : 0));
      +				      (quiet ? DELETE_BRANCH_QUIET : 0) |
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	int prune_merged = 0;
     + 	int delete_merged = 0;
      +	int dry_run = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
       			 N_("edit the description for the branch")),
     - 		OPT_BOOL(0, "prune-merged", &prune_merged,
     - 			N_("delete local branches whose upstream matches <branch> and is merged")),
     + 		OPT_BOOL(0, "delete-merged", &delete_merged,
     + 			N_("delete local branches whose upstream matches <branch> and are merged")),
      +		OPT_BOOL(0, "dry-run", &dry_run,
     -+			N_("with --prune-merged, only print which branches would be deleted")),
     ++			N_("with --delete-merged, only print which branches would be deleted")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     -+	if (dry_run && !prune_merged)
     -+		die(_("--dry-run requires --prune-merged"));
     ++	if (dry_run && !delete_merged)
     ++		die(_("--dry-run requires --delete-merged"));
      +
       	if (recurse_submodules_explicit) {
       		if (!submodule_propagate_branches)
     @@ builtin/branch.c: int cmd_branch(int argc,
      @@ builtin/branch.c: int cmd_branch(int argc,
       				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
     - 	} else if (prune_merged) {
     --		ret = prune_merged_branches(argc, argv, quiet);
     -+		ret = prune_merged_branches(argc, argv, quiet, dry_run);
     + 	} else if (delete_merged) {
     +-		ret = delete_merged_branches(argc, argv, quiet);
     ++		ret = delete_merged_branches(argc, argv, quiet, dry_run);
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
     +@@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a deleteMerged=false branch' '
       	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
       '
       
     -+test_expect_success '--prune-merged --dry-run lists but does not delete' '
     ++test_expect_success '--delete-merged --dry-run lists but does not delete' '
      +	test_when_finished "rm -rf pm-dry" &&
      +	git clone pm-upstream pm-dry &&
      +	git -C pm-dry remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
      +	git -C pm-dry branch two two-commit &&
      +	git -C pm-dry branch --set-upstream-to=origin/next two &&
      +
     -+	git -C pm-dry branch --dry-run --prune-merged "origin/*" >actual &&
     ++	git -C pm-dry branch --dry-run --delete-merged "origin/*" >actual &&
      +	test_grep "Would delete branch one " actual &&
      +	test_grep "Would delete branch two " actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
      +	git -C pm-dry rev-parse --verify refs/heads/two
      +'
      +
     -+test_expect_success '--prune-merged --dry-run only lists branches the live run would delete' '
     ++test_expect_success '--delete-merged --dry-run only lists branches the live run would delete' '
      +	test_when_finished "rm -rf pm-dry-mixed" &&
      +	git clone pm-upstream pm-dry-mixed &&
      +	git -C pm-dry-mixed remote add fork ../pm-fork &&
     @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
      +	git -C pm-dry-mixed branch merged one-commit &&
      +	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
      +
     -+	git -C pm-dry-mixed branch --dry-run --prune-merged "origin/*" >out &&
     ++	git -C pm-dry-mixed branch --dry-run --delete-merged "origin/*" >out &&
      +	test_grep "Would delete branch merged" out &&
      +	test_grep ! "Would delete branch wip" out &&
      +	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
      +	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
      +'
      +
     -+test_expect_success '--dry-run without --prune-merged is rejected' '
     ++test_expect_success '--dry-run without --delete-merged is rejected' '
      +	test_must_fail git -C forked branch --dry-run 2>err &&
     -+	test_grep "requires --prune-merged" err
     ++	test_grep "requires --delete-merged" err
      +'
      +
       test_done

-- 
gitgitgadget
