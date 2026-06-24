Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0F2BEC45
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338113; cv=none; b=BB5fgc2fVO0L2OMQRgdsmV5s7ptkETdCmfxm8WPUmJzNiIKPTEhzxXvlEGjK2TOM48J/6wpMX2o+uooPkjkYVhgZ9Ns7Cc3ThJLnheHjyvrz+0kDFRfYkIRXUkt1nqgwPPJCZ+FIY1fhiN82uidxpe1msx2gXSgGFg6QJdYFdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338113; c=relaxed/simple;
	bh=IEfMC+/37WdT5BttBDlBgrqhcsuDz76hMIyOjwdQqBk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L7L4xQipMmrioW0MBLQJ859BcPBjPJnrCIDtEe9ACQQAuSj5e3MqQGQ545RpmjpVGTyWYOAbMQSylxGoyqBaql4GGMFZ72eiv353PMl2s1Ox2M/3zz7uzccHpaOcB0ouecY0vkn9510lNvUD1WXKGohhbonmffdIRiVxbWpqLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/w2YxjP; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/w2YxjP"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-139b914bab6so1765631c88.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338111; x=1782942911; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYmlCNTBoWT/41ENof3B/49WOYff2Iqqo8S1OnreQm8=;
        b=U/w2YxjPhYqOzNu6O7T2mOdI2GBLhWPlGaCb/9tpctixbXJ5Ich+cQ4BrhIhFrWgUi
         9UANltcZ05lUIujt2Ie6nsAbYicaWxR3oTxSDxWJhHLc4nqehWY8d7+B1nZHJsJ/G68T
         zyiE1K0jfat54wuXCVUnpSrxA351TpDqbah4kj0vfZjzK+J068cHcLSFuBCl8m44Kafy
         LfCl1Y8m+lichU41+NFe9rNG5SdrWNjW8ryj+US3nZMmyB0/oycrF8z6ta5eSAv0c4oO
         BUDqwNMKVP6LRxyiocDOA5IauSF83SUNtAOlS2hoGwYpAfPDuZOEcJk42zv3XhV6LvNc
         6NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338111; x=1782942911;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uYmlCNTBoWT/41ENof3B/49WOYff2Iqqo8S1OnreQm8=;
        b=HzhXuChJEV0f343KHAe5eqSkHdZ1Kf2eYu+ROz90+LxAYvXFjsxCQx3rJ/nbAUYb3k
         IJ/sfNBFrQbatw6k4oe10XbG7N4uowAHc7b3KjBlSPTJ/09DH36WHUJShj9dGaQiYIvj
         0t2rnxW7Oskqawz2ItBdoAEqaD2tCywUuDTL8hiTPHXlulnjqAtjyUcXPnLCw2sOB48v
         1OwgQgceJt1n6Pmc6ZMMojiN6IydosckTPy+ypiz204RcGVRpJMaKQfw3yblPQ6Vchd/
         djfoGlEsshQtdndLSEiehuL/OGh98O9UPYvk+VQerZizEKExLmqxM+/TJ/+36foMkx7E
         zUBw==
X-Gm-Message-State: AOJu0YxUvOShnzUSziR0B/xyD2Xn+69f0BWa6xtGMnYeXKFzU9hyrCqf
	+FjGuCTcKKzaeGdIBQ7x4x6fFLOpRx0Ep0+iTfl6o6xzcMIedZlHYn/W
X-Gm-Gg: AfdE7cld6JuJPK72Qc/WBWFr3oebVT884bB5rstqcBOaRlzF3tyAZPVst/rK8cOQLvx
	0WHKG1NnFV1QR3qc2QeNZ3k6nCKXGhT05+Gzu85EEwPMxcTYmnW/v8IToE9g0qQQZ7r0/4kOsSb
	Xx9c0PLvtrCuH/ImBv9Pl18C48kHNVB0ToqlsgI30QVnTAokQyxITDcHFkOdERoNR1Pg+qJqmaN
	G2c1RhUiC1Cg36zILVG7CC1y+YIE66WIoiZB5ZYTq3rUZBXNA4CN7Ee6Y83WbNVKZGQ1V1tiPmZ
	XwOloOu38n0ett+zriwcFitVOLARrk4svaVhuX8A7ZffniU1eKNcCVUNjTCh4JlEHYSLMLZTXIq
	iEZI2WDcFyJhjCBxygIUXans2DQNHCXfSeOeFoovZD9LeZisRcA==
X-Received: by 2002:a05:7022:6614:b0:139:bf81:637f with SMTP id a92af1059eb24-139d0c16e5bmr3075573c88.16.1782338108659;
        Wed, 24 Jun 2026 14:55:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e940asm1566821c88.9.2026.06.24.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:07 -0700 (PDT)
Message-Id: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:54:59 +0000
Subject: [PATCH v18 0/7] branch: delete-merged
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

Delete branches that have already been merged on upstream.

Changes in v18:

 * Instead of keeping the whole chain of upstream branches, keep only the
   ones an unmerged branch still needs. When a kept (merged) branch in turn
   tracks a branch that is being deleted, clear its now-stale upstream
   config.
 * Rework spare_stacked_bases() to record the kept bases and, in a second
   pass, clear the upstream of any whose own base is going away. Build the
   to-delete list with strset_for_each_entry() instead of re-walking the
   candidate array.

Changes in v17:

 * Keep a merged branch when another surviving branch still tracks it as its
   upstream, so --delete-merged no longer deletes a branch out from under
   one stacked on top of it.
 * Move the --dry-run and branch.<name>.deleteMerged opt-out fully into
   their own commits.

Changes in v16:

 * Convert delete_merged_branches() to take an unsigned int flags argument
   instead of separate quiet/dry_run booleans, matching delete_branches()
 * Reuse the strbuf across the skip-config loop (strbuf_reset per iteration,
   single strbuf_release after) instead of allocating and freeing it each
   time
 * Rewrite the --delete-merged tests as integration tests: branches that
   land commits upstream, with deletion and the checked-out, upstream-gone,
   and push-equals-upstream safety cases exercised together in one run and
   output asserted via test_cmp
 * Collapse the many per-aspect test repos into a single reused repo set up
   by a setup_repo_for_delete_merged helper, and rename helpers off the old
   pm_/prune naming
 * Nest single-repo setup sequences in ( cd ... ) subshells instead of
   prefixing every command with -C

Changes in v15:

 * Renamed --prune-merged to --delete-merged throughout. Not necessarily
   final, but something to advance the discussion.
 * --delete-merged now silently skips not-yet-merged branches instead of
   warning.
 * Initialized the delete_branches() flag locals where declared. Only force
   stays deferred.
 * delete_branches()/check_branch_commit() doc and code cleanups: redundant
   branch NULL checks dropped, ref_array candidates = { 0 }, a BUG() for the
   unreachable non-branch ref, and reworked --delete-merged doc wording.
 * Broadened the --forked tests (local commits for realism, remote add -f,
   --forked coverage), renamed the misleading trunk fixture, and replaced
   the misnamed detached branch with git checkout --detach.

Changes in v14:

 * Fixed a git branch -d -r regression (broke t5404/t5505/t5514): the
   remotes path set a local force but not the DELETE_BRANCH_FORCE bit that
   check_branch_commit() reads, so it wrongly ran the merge check.
 * Made flags the single source of truth in delete_branches() so the bit and
   the derived locals can't disagree.
 * Works locally, but GitHub CI has problems that are there for other
   branches too, hopefully not related
   (https://github.com/git/git/pull/2285).

Changes in v13:

 * Reworked --forked into a real ref-filter applied in apply_ref_filter()
   instead of a post-pass, so non-matching branches are never allocated.
 * Match exact --forked patterns on full refnames (only globs use the
   abbreviated upstream), and dropped the old helper machinery, forward
   declaration, and string_list in favor of a strvec.
 * Replaced the boolean parameters of
   delete_branches()/check_branch_commit() with a single unsigned int flags.
 * --prune-merged now collects candidates via filter_refs() rather than its
   own branch walk.
 * --prune-merged now takes its patterns as positional arguments (e.g. git
   branch --prune-merged origin/main 'feature*') instead of repeating the
   option.

Changes in v12:

 * Reworked --forked from a standalone action into a --list-mode filter.
 * Switched --forked and --prune-merged to repeatable OPT_STRING_LIST
   options.
 * Dropped the bare-remote-name resolution for --forked, the argument is now
   a ref or a glob.

Changes in v11:

 * The flags now take a branch, not a remote. --forked and --prune-merged
   accept a literal upstream short name like origin/main or a wildmatch
   pattern like origin/. The old --all-remotes flag is gone, since origin/
   covers that case.
 * The prune guard now compares @{push} against @{upstream}. A branch is
   spared when these are equal. That is the trunk like case, such as local
   main tracking and pushing to origin/main, where "fully merged to
   upstream" cannot be told apart from "just pulled". Only branches that
   push somewhere other than their upstream, typically fork based topics,
   are candidates. The earlier /HEAD by name guard that the reviewer
   rejected is gone.
 * New --dry-run for --prune-merged.

Changes in v10:

 * --forked / --prune-merged now take a branch glob instead of a remote name
   — origin, origin/*, origin/release-- all work. This replaces the
   remote-only form and subsumes the old --all-remotes flag, which has been
   dropped.
 * New --dry-run for --prune-merged.

Changes in v9:

 * --force no longer has special meaning with --prune-merged; reachability
   is always enforced. Use git branch -D to delete an unmerged branch.
   Matches how git branch's other read/safe actions treat --force.
 * Synopsis drops [-f]; "not fully merged" hint points at git branch -D.
 * Dropped the --prune-merged --force tests.

Changes in v8:

 * Delete only when the branch's work is actually reachable from its
   upstream
 * Skip branches whose upstream is gone (even with --force)
 * Simplified the internal safety flag to live in one place

Changes in v7:

 * --prune-merged now checks if a branch is merged into its own upstream
   first. If the upstream is gone, it checks against the remote's default
   branch instead. If neither exists, the branch is refused (use --force to
   delete anyway).

Changes in v6:

 * --prune-merged now measures merged-ness against the remote's default
   branch instead of the candidate's upstream — so the decision no longer
   depends on which branch happens to be checked out locally.
 * delete_branches() / check_branch_commit() gained a per-candidate override
   that lets a caller substitute a different "what counts as merged"
   reference (or skip the check). branch -d callers pass NULL and keep their
   existing semantics.
 * prune_merged_branches() resolves each candidate's push-remote HEAD and
   threads it through, so --prune-merged --all-remotes measures each
   candidate against its own remote rather than a single global reference.

Changes in v5:

 * Drop commit 'fetch: add --prune-merged'

Changes in v4:

 * Resolve each remote's HEAD and collect the targets into a
   protected_default_refs set in collect_forked_set.
 * In prune_merged_branches, skip a candidate when its upstream is a
   protected default ref and the local branch name matches the default
   branch's leaf name (so a local main tracking origin/main is spared, but a
   renamed trunk tracking origin/main is not).
 * Also skip when the candidate's push ref points at a protected default
   ref, so a topic branch configured to push to origin/main is never pruned.
 * Tests: spare the local default branch; only protect by matching leaf name
   (not by upstream alone); spare a branch whose push ref is the remote
   default.

Changes in v3:

 * s/remote-tracking refs/remote-tracking branches/g

Changes in v2:

 * The whole feature moved out of git fetch and into git branch. git fetch
   --prune-merged now just calls git branch --prune-merged after fetching.
 * The fetch.pruneLocalBranches and remote..pruneLocalBranches config
   options are gone, replaced by per-branch opt-out via branch..pruneMerged.
 * New git branch --forked lists local branches whose upstream lives on the
   given remote (read-only building block).
 * New git branch --prune-merged deletes those branches, but only if their
   tip is reachable from the upstream tracking ref; --force skips that
   safety check.
 * New git branch --all-remotes lets --forked/--prune-merged operate across
   every configured remote at once.
 * The currently checked-out branch in any worktree is always preserved.
 * branch..pruneMerged=false lets you exempt a branch (e.g. a long-running
   topic branch) even with --force; doesn't affect explicit git branch -d.
 * delete_branches() got a warn_only mode so bulk deletion prints a one-line
   warning per skipped branch instead of the noisy four-line hint that git
   branch -d shows.
 * New section in git-branch docs; git-fetch docs trimmed to just mention
   --prune-merged.
 * New tests in t3200-branch.sh for the new branch flags; t5510-fetch.sh
   shrunk since most logic moved.

Harald Nordgren (7):
  branch: add --forked filter for --list mode
  branch: convert delete_branches() to a flags argument
  branch: let delete_branches skip unmerged branches on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --delete-merged <branch>
  branch: add branch.<name>.deleteMerged opt-out
  branch: add --dry-run for --delete-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  48 ++++-
 builtin/branch.c                 | 266 +++++++++++++++++++++---
 ref-filter.c                     |  70 +++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 342 +++++++++++++++++++++++++++++++
 6 files changed, 715 insertions(+), 28 deletions(-)


base-commit: ab776a62a78576513ee121424adb19597fbb7613
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v18
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v18
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v17:

 1:  d8cc17bd7f = 1:  3e29ff17bd branch: add --forked filter for --list mode
 2:  d14b0403f0 = 2:  cdd4fea4a7 branch: convert delete_branches() to a flags argument
 3:  ef2719dac3 = 3:  a0fd5b4a6c branch: let delete_branches skip unmerged branches on bulk refusal
 4:  80518f5d11 = 4:  a56d8fe93e branch: prepare delete_branches for a bulk caller
 5:  46da7c8140 ! 5:  a84c555d99 branch: add --delete-merged <branch>
     @@ Commit message
          upstream. The work has already landed on the upstream they track,
          so the local copy is no longer needed.
      
     -    Three kinds of branches are not deleted:
     +    A branch is not deleted when:
      
     -      * any branch checked out in any worktree
     -      * any branch whose upstream remote-tracking branch no longer
     -        exists, since a missing upstream is not by itself a sign of
     -        integration
     -      * any branch whose push destination equals its upstream
     -        (<branch>@{push} is the same as <branch>@{upstream}), such as
     -        a local "main" that tracks and pushes to "origin/main". Right
     -        after a pull it just looks "fully merged", so it is kept. Only
     -        branches that push somewhere other than their upstream,
     -        typically topics in a fork workflow, are candidates.
     +      * it is checked out in any worktree
     +      * its upstream remote-tracking branch no longer exists, since a
     +        missing upstream is not by itself a sign of integration
     +      * its push destination equals its upstream (<branch>@{push} is
     +        the same as <branch>@{upstream}), such as a local "main" that
     +        tracks and pushes to "origin/main". Right after a pull it just
     +        looks "fully merged", so it is kept. Only branches that push
     +        somewhere other than their upstream, typically topics in a fork
     +        workflow, are candidates.
      
          A branch whose work is not yet merged into its upstream is silently
          skipped, so one unmerged topic does not abort the whole sweep.
      
          A branch that another, surviving branch tracks as its upstream is
          also kept, so a branch is never deleted out from under one stacked
     -    on top of it. Sparing such a base can in turn protect its own
     -    upstream, so the check repeats until the set stops changing.
     +    on top of it. Such a kept branch is itself merged, so when its own
     +    upstream is being deleted, clear its now-stale upstream config.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
      +silently skipped. Delete it with `git branch -D` if you want to
      +remove it anyway.
      ++
     -+A branch that another, surviving branch still tracks as its upstream
     -+is kept, so a branch is never deleted out from under one stacked on
     -+top of it.
     ++A branch that another, surviving branch tracks as its upstream is
     ++kept, so a branch is never deleted out from under one stacked on top
     ++of it. If that kept branch in turn tracks a branch that is being
     ++deleted, its now-stale upstream configuration is cleared.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
       	return 0;
       }
       
     -+static int collect_upstream(const struct reference *ref, void *cb_data)
     -+{
     -+	struct string_list *upstreams = cb_data;
     -+	struct branch *branch = branch_get(ref->name);
     -+	const char *upstream = branch_get_upstream(branch, NULL);
     ++struct spare_data {
     ++	struct strset *deletable;
     ++	struct strset *spared;
     ++};
      +
     -+	string_list_append(upstreams, ref->name)->util =
     -+		xstrdup_or_null(upstream);
     ++/*
     ++ * A surviving branch stacked on a deletion candidate would lose its
     ++ * upstream, so drop that candidate from the delete set and remember it
     ++ * in "spared" so its own upstream can be tidied up afterwards.
     ++ */
     ++static int spare_stacked_base(const struct reference *ref, void *cb_data)
     ++{
     ++	struct spare_data *data = cb_data;
     ++	struct branch *branch;
     ++	const char *upstream, *up_short;
     ++
     ++	if (strset_contains(data->deletable, ref->name))
     ++		return 0;
     ++	branch = branch_get(ref->name);
     ++	upstream = branch_get_upstream(branch, NULL);
     ++	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     ++	    !strset_contains(data->deletable, up_short))
     ++		return 0;
     ++
     ++	strset_remove(data->deletable, up_short);
     ++	strset_add(data->spared, up_short);
      +	return 0;
      +}
      +
      +/*
     -+ * Keep any branch that another, surviving branch tracks as its
     -+ * upstream, so we never delete a branch out from under one stacked on
     -+ * top of it.  Sparing a branch makes it a survivor whose own upstream
     -+ * then needs the same protection, so repeat until nothing changes.
     ++ * Keep any branch that a surviving branch tracks as its upstream, so we
     ++ * never delete a branch out from under one stacked on top of it.  Such a
     ++ * base is itself merged, so when its own upstream is also going away
     ++ * (no surviving branch tracks it), clear the base's now-stale upstream.
      + */
      +static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
      +{
     -+	struct string_list upstreams = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     -+	bool spared;
     -+
     -+	refs_for_each_branch_ref(refs, collect_upstream, &upstreams);
     -+	do {
     -+		spared = false;
     -+		for_each_string_list_item(item, &upstreams) {
     -+			const char *up = item->util, *up_short;
     -+
     -+			if (!up || strset_contains(deletable, item->string))
     -+				continue;
     -+			if (!skip_prefix(up, "refs/heads/", &up_short) ||
     -+			    !strset_contains(deletable, up_short))
     -+				continue;
     -+
     -+			strset_remove(deletable, up_short);
     -+			spared = true;
     -+		}
     -+	} while (spared);
     -+
     -+	string_list_clear(&upstreams, 1);
     ++	struct strset spared = STRSET_INIT;
     ++	struct spare_data data = { .deletable = deletable, .spared = &spared };
     ++	struct strbuf key = STRBUF_INIT;
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
     ++
     ++	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
     ++
     ++	strset_for_each_entry(&spared, &iter, entry) {
     ++		struct branch *branch = branch_get(entry->key);
     ++		const char *upstream = branch_get_upstream(branch, NULL);
     ++		const char *up_short;
     ++
     ++		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     ++		    !strset_contains(deletable, up_short))
     ++			continue;
     ++
     ++		strbuf_reset(&key);
     ++		strbuf_addf(&key, "branch.%s.merge", branch->name);
     ++		repo_config_set_gently(the_repository, key.buf, NULL);
     ++		strbuf_reset(&key);
     ++		strbuf_addf(&key, "branch.%s.remote", branch->name);
     ++		repo_config_set_gently(the_repository, key.buf, NULL);
     ++	}
     ++
     ++	strbuf_release(&key);
     ++	strset_clear(&spared);
      +}
      +
      +static int delete_merged_branches(int argc, const char **argv,
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	struct ref_array candidates = { 0 };
      +	struct strset deletable = STRSET_INIT;
      +	struct strvec to_delete = STRVEC_INIT;
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
      +	int i, ret = 0;
      +
      +	if (!argc)
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +
      +	spare_stacked_bases(refs, &deletable);
      +
     -+	for (i = 0; i < candidates.nr; i++) {
     -+		const char *short_name;
     -+
     -+		if (skip_prefix(candidates.items[i]->refname, "refs/heads/",
     -+				&short_name) &&
     -+		    strset_contains(&deletable, short_name))
     -+			strvec_push(&to_delete, short_name);
     -+	}
     ++	strset_for_each_entry(&deletable, &iter, entry)
     ++		strvec_push(&to_delete, entry->key);
      +
      +	if (to_delete.nr)
      +		ret = delete_branches(to_delete.nr, to_delete.v,
     @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
      +		git checkout --detach
      +	) &&
      +
     ++	git -C repo branch --dry-run --delete-merged origin/next >out &&
     ++	test_grep ! "feature" out &&
     ++
      +	git -C repo branch --delete-merged origin/next 2>err &&
      +
      +	test_must_be_empty err &&
      +	git -C repo rev-parse --verify refs/heads/feature &&
     -+	git -C repo rev-parse --verify refs/heads/topic
     ++	git -C repo rev-parse --verify refs/heads/topic &&
     ++	echo origin/next >expect &&
     ++	git -C repo rev-parse --abbrev-ref feature@{upstream} >actual &&
     ++	test_cmp expect actual &&
     ++	echo feature >expect &&
     ++	git -C repo rev-parse --abbrev-ref topic@{upstream} >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
     @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success '--delete-merged clears the upstream of a kept base whose own base is deleted' '
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git branch lower origin/next &&
     ++		git branch --set-upstream-to=origin/next lower &&
     ++		git branch mid origin/next &&
     ++		git branch --set-upstream-to=lower mid &&
     ++		git checkout -b tip mid &&
     ++		git commit --allow-empty -m "tip work" &&
     ++		git branch --set-upstream-to=mid tip &&
     ++		git checkout --detach
     ++	) &&
     ++
     ++	git -C repo branch --delete-merged origin/next lower &&
     ++
     ++	test_must_fail git -C repo rev-parse --verify refs/heads/lower &&
     ++	git -C repo rev-parse --verify refs/heads/mid &&
     ++	test_must_fail git -C repo rev-parse mid@{upstream} &&
     ++	echo mid >expect &&
     ++	git -C repo rev-parse --abbrev-ref tip@{upstream} >actual &&
     ++	test_cmp expect actual
     ++'
      +
       test_done
 6:  27903fbb1d ! 6:  d52d717b70 branch: add branch.<name>.deleteMerged opt-out
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       	struct strset deletable = STRSET_INIT;
       	struct strvec to_delete = STRVEC_INIT;
      +	struct strbuf key = STRBUF_INIT;
     + 	struct hashmap_iter iter;
     + 	struct strmap_entry *entry;
      +	bool quiet = flags & DELETE_BRANCH_QUIET;
       	int i, ret = 0;
       
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       	ref_array_clear(&candidates);
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the upstream of a kept base whose ow
       	test_cmp expect actual
       '
       
 7:  49c1bcf1fb ! 7:  8d0323f4b3 branch: add --dry-run for --delete-merged
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: A branch that another, surviving branch still tracks as its upstream
     - is kept, so a branch is never deleted out from under one stacked on
     - top of it.
     +@@ Documentation/git-branch.adoc: kept, so a branch is never deleted out from under one stacked on top
     + of it. If that kept branch in turn tracks a branch that is being
     + deleted, its now-stale upstream configuration is cleared.
       
      +`--dry-run`::
      +	With `--delete-merged`, print which branches would be

-- 
gitgitgadget
