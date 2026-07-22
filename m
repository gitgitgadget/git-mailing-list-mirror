Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C33ACEF4
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704244; cv=none; b=juKm7hJv7pFhFNMHSiDtaLB5iUPACgPkU2WBNpLRtNtquupkXLKsGB6gOVeLrzw4hS+4nkWVMco8oXh34GKekOAYOfS474r84hpG0JYUAiDFHEWxdPieitOHK1WlKN5tsa4kZspmnQLwnEUHj25x+t4S99JHrgeeYmtAXpjAqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704244; c=relaxed/simple;
	bh=m5Bw+wm5MXkbgM7gKSvgDA/6cxW3DWPHYFt4pK/cJa4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eYX1+8J7gqDePLrxa7XhPKT3mHBYeZhPC4M60Wx/jn0SnI6myd9z2AzBC5rXb8Gk6zHwFULwyR72thpAJx+JyrvFETDmM64SV1aU4b1JR1/x2yzGoXmcOKRnJO09WSYPMTlRKCZLnHHObCLDihoKzHMec4Iu/IT/WCoT1qpszsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeEYfrSY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeEYfrSY"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e602d2c0fso520376485a.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 00:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704240; x=1785309040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S00R29AtObpg8WGF5vG3ZX7vzyVsaPILraOhkDX30pQ=;
        b=QeEYfrSYWnBBy2J4ZyoqDutrb15O4vDqGabCmaP21pTAILj7INNICKz1dieHz+lB2W
         ANBG6KLXP88hH4mq9wIVKP7o6Lt5/W9TqnrvNOjgFXS9s7oF/HgSn+ysZDzK0YmftduH
         nHpRvLYOR/DnZL/dsh+f9v6rzejDIs5c74g/t+kkkXb1sOCs3oFMwc/g2JvhVBdkYkK1
         WKyNyxyyfpZ6sFNLe4rdljFVi126TZS8jB4HF5Dgi8B1cTPJwrSuBMvqv9gqS4Ox6iV5
         X/ZtvCvxm2+LGy0DDUCo5xITbrU1FRFz6iX2yxZC0ZpFz1fMNukiqQlQhDu1n2bkyzSk
         otaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704240; x=1785309040;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S00R29AtObpg8WGF5vG3ZX7vzyVsaPILraOhkDX30pQ=;
        b=Il9uBZzLif2VpX7TZLD7VjtJ8GC/guShQnHXuDb1QUmYNvzRdPJ/AIpmJ0Rdzk0Vpc
         sLWiWN1cxs82tC5zPXlSOWMiyMDVCMKqXJmwzEBUw2uCQOluLvKTaTvT0/U+1RK/60QJ
         tFEfaRf92p831XOYENf0iQ3mg92KNXfhWK8h56U/ff/EzDfZRDKXWk4WA5p5RfhWwA6Q
         ac0SNDhj0BIKuxtqYsvfFehIBpaTfMdcZVGc2OlIrel1ksfr19PE16eVXrcj9i0kPXAz
         fsegsB8YP/tb+wZ9g546kUfREQ1UoqTe127N4nl5+nHKHMh3vuVKA8ZCPCsvKZdscRTd
         mlww==
X-Gm-Message-State: AOJu0Yy8exika61jTBPKgMp8P/LF0ErN3AskioH2LAYTXdBSxnXinl13
	hDD6neE6TF9nXXSht671FUNCpHu6VQAdyia8nUoldZ314IspD/bxFgrgo0GrEw==
X-Gm-Gg: AR+sD10bY7XN0DQjcsiHYgxWDaV+frP65d5cbLcxOMvYbJlOi2sSQSGKmZn5fM+gmA5
	Oy7YmxhniSYIef+pu5QQ/FWxk0cOgKAGWnECIhMlmppK/8AiVSm9Y/bFM/EmtMyqsETr+uTIAe/
	SuVQ1n4iJRBuYxH6Vn7xXpe+ZAFcIDDD9sFNGGEpYkTwgnHsT8SHujd6AuCt97PlBpx6Ua5Zeth
	H9yyyWvQJq30UPuhqKbli2WjGgPYZrU9Ira4640u5heXzTEr6XmGLEESanAzla/ghzz+7CGcA12
	YATQzNACPQKyWaLuIARPVs2Jv8pl3gQyFQhKLDzZKNTQrnBbhIhin3xS5KHghkTTKgayR4pNON7
	CByRCkJiL8kaRTpvYF1fLxr0PYIIw98022sCVza91PZxp4E5jjbwixBt8WvQfJ1JYO1O4OcWchi
	eonFo=
X-Received: by 2002:a05:620a:8d85:b0:92e:68f1:db9b with SMTP id af79cd13be357-930f2d7155amr204291985a.16.1784704240225;
        Wed, 22 Jul 2026 00:10:40 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68a7fffsm100637185a.11.2026.07.22.00.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:10:39 -0700 (PDT)
Message-Id: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 07:10:31 +0000
Subject: [PATCH v20 0/7] branch: delete-merged
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

Changes in v20:

 * Protect branches transitively required by a surviving local upstream
   stack. Traverse upstream chains once and defer delete-set mutation until
   traversal completes.
 * Make stacked-branch handling independent of ref iteration order and
   update the documentation accordingly.
 * Clarify variable names with regards to branch names (short) to reduce
   confusion.

Changes in v19:

 * Fix bug where dry-run would still remove config, added test coverage.
 * Redesigned --delete-merged as a repeatable upstream selector with
   optional positional patterns limiting deletion scope.
 * Protect same-name upstream branches independently of push-default
   configuration.
 * Simplified flags handling where local caching became complicated when
   mutating values.
 * Clarified assertions in tests.

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
 Documentation/git-branch.adoc    |  49 +++-
 builtin/branch.c                 | 276 +++++++++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 393 +++++++++++++++++++++++++++++++
 6 files changed, 774 insertions(+), 31 deletions(-)


base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v20
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v20
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v19:

 1:  562648132d = 1:  51c1c9d075 branch: add --forked filter for --list mode
 2:  c7ebd9344c = 2:  711574b2e5 branch: convert delete_branches() to a flags argument
 3:  0c4f3358e3 = 3:  47c5975dc7 branch: let delete_branches skip unmerged branches on bulk refusal
 4:  64a202526a = 4:  46268acec5 branch: prepare delete_branches for a bulk caller
 5:  a6caa5b397 ! 5:  ef9f57e735 branch: add --delete-merged <branch>
     @@ Commit message
          A branch whose work is not yet merged into its upstream is silently
          skipped, so one unmerged topic does not abort the whole sweep.
      
     -    A branch that another, surviving branch tracks as its upstream is
     -    also kept, so a branch is never deleted out from under one stacked
     -    on top of it. Such a kept branch is itself merged, so when its own
     -    upstream is being deleted, clear its now-stale upstream config.
     +    A branch that a surviving branch depends on through a chain of local
     +    upstreams is also kept, so no branch is deleted out from under stacked
     +    work. Collect this transitive set without changing the candidate set
     +    during ref iteration: walk upstream chains from surviving branches,
     +    visit each branch at most once, and remove the collected bases only
     +    after the iteration completes. This makes the result independent of
     +    ref iteration order without repeated full scans.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
      +silently skipped. Delete it with `git branch -D` if you want to
      +remove it anyway.
      ++
     -+A branch that another, surviving branch tracks as its upstream is
     -+kept, so a branch is never deleted out from under one stacked on top
     -+of it. If that kept branch in turn tracks a branch that is being
     -+deleted, its now-stale upstream configuration is cleared.
     ++A branch that a surviving branch depends on through a chain of local
     ++upstreams is kept, so a branch is never deleted out from under stacked
     ++work.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
       	return 0;
       }
       
     -+struct spare_data {
     -+	struct strset *deletable;
     -+	struct strset *spared;
     ++struct stacked_branch_data {
     ++	struct strset *deletable_branch_names;
     ++	struct strset *protected_branch_names;
     ++	struct strset *visited_branch_names;
      +};
      +
     -+/*
     -+ * A surviving branch stacked on a deletion candidate would lose its
     -+ * upstream, so drop that candidate from the delete set and remember it
     -+ * in "spared" so its own upstream can be tidied up afterwards.
     -+ */
     -+static int spare_stacked_base(const struct reference *ref, void *cb_data)
     ++static int collect_stacked_branch_bases(const struct reference *ref,
     ++					void *cb_data)
      +{
     -+	struct spare_data *data = cb_data;
     -+	struct branch *branch;
     -+	const char *upstream, *up_short;
     ++	struct stacked_branch_data *data = cb_data;
     ++	const char *branch_name;
      +
     -+	if (strset_contains(data->deletable, ref->name))
     -+		return 0;
     -+	branch = branch_get(ref->name);
     -+	upstream = branch_get_upstream(branch, NULL);
     -+	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     -+	    !strset_contains(data->deletable, up_short))
     ++	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
     ++		BUG("expected local branch ref, got '%s'", ref->name);
     ++	if (strset_contains(data->deletable_branch_names, branch_name))
      +		return 0;
      +
     -+	strset_remove(data->deletable, up_short);
     -+	strset_add(data->spared, up_short);
     ++	while (strset_add(data->visited_branch_names, branch_name)) {
     ++		struct branch *branch = branch_get(branch_name);
     ++		const char *upstream_refname = branch_get_upstream(branch, NULL);
     ++		const char *upstream_branch_name;
     ++
     ++		if (!upstream_refname ||
     ++		    !skip_prefix(upstream_refname, "refs/heads/",
     ++				 &upstream_branch_name) ||
     ++		    !strset_contains(data->deletable_branch_names,
     ++				    upstream_branch_name))
     ++			break;
     ++
     ++		strset_add(data->protected_branch_names, upstream_branch_name);
     ++		branch_name = upstream_branch_name;
     ++	}
     ++
      +	return 0;
      +}
      +
     -+/*
     -+ * Keep any branch that a surviving branch tracks as its upstream, so we
     -+ * never delete a branch out from under one stacked on top of it.  Such a
     -+ * base is itself merged, so when its own upstream is also going away
     -+ * (no surviving branch tracks it), clear the base's now-stale upstream.
     -+ */
     -+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
     ++static void protect_stacked_branch_bases(struct ref_store *refs,
     ++					 struct strset *deletable_branch_names)
      +{
     -+	struct strset spared = STRSET_INIT;
     -+	struct spare_data data = { .deletable = deletable, .spared = &spared };
     -+	struct strbuf key = STRBUF_INIT;
     ++	struct strset protected_branch_names = STRSET_INIT;
     ++	struct strset visited_branch_names = STRSET_INIT;
     ++	struct stacked_branch_data data = {
     ++		.deletable_branch_names = deletable_branch_names,
     ++		.protected_branch_names = &protected_branch_names,
     ++		.visited_branch_names = &visited_branch_names,
     ++	};
     ++	struct refs_for_each_ref_options opts = {
     ++		.prefix = "refs/heads/",
     ++	};
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
      +
     -+	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
     -+
     -+	strset_for_each_entry(&spared, &iter, entry) {
     -+		struct branch *branch = branch_get(entry->key);
     -+		const char *upstream = branch_get_upstream(branch, NULL);
     -+		const char *up_short;
     -+
     -+		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     -+		    !strset_contains(deletable, up_short))
     -+			continue;
     ++	refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
      +
     -+		strbuf_reset(&key);
     -+		strbuf_addf(&key, "branch.%s.merge", branch->name);
     -+		repo_config_set_gently(the_repository, key.buf, NULL);
     -+		strbuf_reset(&key);
     -+		strbuf_addf(&key, "branch.%s.remote", branch->name);
     -+		repo_config_set_gently(the_repository, key.buf, NULL);
     -+	}
     ++	strset_for_each_entry(&protected_branch_names, &iter, entry)
     ++		strset_remove(deletable_branch_names, entry->key);
      +
     -+	strbuf_release(&key);
     -+	strset_clear(&spared);
     ++	strset_clear(&visited_branch_names);
     ++	strset_clear(&protected_branch_names);
      +}
      +
      +static int branch_pushes_to_upstream(struct branch *branch,
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct ref_filter filter = REF_FILTER_INIT;
      +	struct ref_array candidates = { 0 };
     -+	struct strset deletable = STRSET_INIT;
     -+	struct strvec to_delete = STRVEC_INIT;
     ++	struct strset deletable_branch_names = STRSET_INIT;
     ++	struct strvec branches_to_delete = STRVEC_INIT;
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
      +	size_t i;
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	filter_refs(&candidates, &filter, filter.kind);
      +
      +	for (i = 0; i < (size_t)candidates.nr; i++) {
     -+		const char *full_name = candidates.items[i]->refname;
     -+		const char *short_name;
     ++		const char *branch_refname = candidates.items[i]->refname;
     ++		const char *branch_name;
      +		struct branch *branch;
     -+		const char *upstream;
     ++		const char *upstream_refname;
      +
     -+		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     -+			BUG("filter returned non-branch ref '%s'", full_name);
     -+		if (branch_checked_out(full_name))
     ++		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
     ++			BUG("filter returned non-branch ref '%s'", branch_refname);
     ++		if (branch_checked_out(branch_refname))
      +			continue;
      +
     -+		branch = branch_get(short_name);
     -+		upstream = branch_get_upstream(branch, NULL);
     -+		if (!upstream || !refs_ref_exists(refs, upstream))
     ++		branch = branch_get(branch_name);
     ++		upstream_refname = branch_get_upstream(branch, NULL);
     ++		if (!upstream_refname || !refs_ref_exists(refs, upstream_refname))
      +			continue;
     -+		if (branch_pushes_to_upstream(branch, upstream))
     ++		if (branch_pushes_to_upstream(branch, upstream_refname))
      +			continue;
     -+		if (check_branch_commit(short_name, short_name,
     ++		if (check_branch_commit(branch_name, branch_name,
      +					&candidates.items[i]->objectname, NULL,
      +					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
      +			continue;
      +
     -+		strset_add(&deletable, short_name);
     ++		strset_add(&deletable_branch_names, branch_name);
      +	}
      +
     -+	spare_stacked_bases(refs, &deletable);
     ++	protect_stacked_branch_bases(refs, &deletable_branch_names);
      +
     -+	strset_for_each_entry(&deletable, &iter, entry)
     -+		strvec_push(&to_delete, entry->key);
     ++	strset_for_each_entry(&deletable_branch_names, &iter, entry)
     ++		strvec_push(&branches_to_delete, entry->key);
      +
     -+	if (to_delete.nr)
     -+		ret = delete_branches(to_delete.nr, to_delete.v,
     ++	if (branches_to_delete.nr)
     ++		ret = delete_branches(branches_to_delete.nr, branches_to_delete.v,
      +				      FILTER_REFS_BRANCHES,
      +				      DELETE_BRANCH_SKIP_UNMERGED |
      +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
      +				      flags);
      +
     -+	strvec_clear(&to_delete);
     -+	strset_clear(&deletable);
     ++	strvec_clear(&branches_to_delete);
     ++	strset_clear(&deletable_branch_names);
      +	ref_array_clear(&candidates);
      +	ref_filter_clear(&filter);
      +	return ret;
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	)
      +'
      +
     -+test_expect_success '--delete-merged clears the deleted upstream of a spared branch' '
     ++test_expect_success '--delete-merged keeps the upstream chain of a surviving branch' '
      +	setup_repo_for_delete_merged &&
      +	(
      +		cd repo &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +		git commit --allow-empty -m "tip work" &&
      +
      +		git branch --delete-merged origin/next \
     -+			--delete-merged lower &&
     ++			--delete-merged lower >actual 2>&1 &&
     ++		test_must_be_empty actual &&
      +
      +		check_branches <<-\EOF &&
     ++		lower
      +		main
      +		mid
      +		tip
      +		EOF
      +
     -+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
     ++		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
      +		cat >expect <<-\EOF &&
     ++		branch.lower.remote origin
     ++		branch.lower.merge refs/heads/next
     ++		branch.mid.remote .
     ++		branch.mid.merge refs/heads/lower
      +		branch.tip.remote .
      +		branch.tip.merge refs/heads/mid
      +		EOF
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	)
      +'
      +
     ++test_expect_success '--delete-merged result is independent of stacked branch names' '
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git branch c-lower origin/next --track &&
     ++		git branch b-mid c-lower --track &&
     ++		git checkout -b a-tip b-mid --track &&
     ++		git commit --allow-empty -m "tip work" &&
     ++
     ++		git branch --delete-merged origin/next \
     ++			--delete-merged "c-*" &&
     ++
     ++		check_branches <<-\EOF &&
     ++		a-tip
     ++		b-mid
     ++		c-lower
     ++		main
     ++		EOF
     ++
     ++		git branch --delete-merged origin/next \
     ++			--delete-merged "c-*" >actual 2>&1 &&
     ++		test_must_be_empty actual &&
     ++
     ++		check_branches <<-\EOF
     ++		a-tip
     ++		b-mid
     ++		c-lower
     ++		main
     ++		EOF
     ++	)
     ++'
     ++
      +test_expect_success '--delete-merged requires a value' '
      +	test_must_fail git -C forked branch --delete-merged 2>err &&
      +	test_grep "requires a value" err
 6:  734d27c908 ! 6:  fa70108611 branch: add branch.<name>.deleteMerged opt-out
     @@ Documentation/git-branch.adoc: A branch is not deleted when:
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       	struct ref_array candidates = { 0 };
     - 	struct strset deletable = STRSET_INIT;
     - 	struct strvec to_delete = STRVEC_INIT;
     + 	struct strset deletable_branch_names = STRSET_INIT;
     + 	struct strvec branches_to_delete = STRVEC_INIT;
      +	struct strbuf key = STRBUF_INIT;
       	struct hashmap_iter iter;
       	struct strmap_entry *entry;
       	size_t i;
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 		const char *short_name;
     + 		const char *branch_name;
       		struct branch *branch;
     - 		const char *upstream;
     + 		const char *upstream_refname;
      +		int opt_out;
       
     - 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     - 			BUG("filter returned non-branch ref '%s'", full_name);
     + 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
     + 			BUG("filter returned non-branch ref '%s'", branch_refname);
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
       			continue;
       
      +		strbuf_reset(&key);
     -+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
     ++		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
      +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
      +		    !opt_out) {
      +			if (!(flags & DELETE_BRANCH_QUIET))
      +				fprintf(stderr,
      +					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
     -+					short_name, short_name);
     ++					branch_name, branch_name);
      +			continue;
      +		}
      +
     - 		strset_add(&deletable, short_name);
     + 		strset_add(&deletable_branch_names, branch_name);
       	}
       
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       				      flags);
       
      +	strbuf_release(&key);
     - 	strvec_clear(&to_delete);
     - 	strset_clear(&deletable);
     + 	strvec_clear(&branches_to_delete);
     + 	strset_clear(&deletable_branch_names);
       	ref_array_clear(&candidates);
      
       ## t/t3200-branch.sh ##
 7:  7aa9d5db14 ! 7:  13bac431a3 branch: add --dry-run for --delete-merged
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: kept, so a branch is never deleted out from under one stacked on top
     - of it. If that kept branch in turn tracks a branch that is being
     - deleted, its now-stale upstream configuration is cleared.
     +@@ Documentation/git-branch.adoc: A branch that a surviving branch depends on through a chain of local
     + upstreams is kept, so a branch is never deleted out from under stacked
     + work.
       
      +`--dry-run`::
      +	With `--delete-merged`, print which branches would be
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
       			char *refname = name + branch_name_pos;
       			if (!(flags & DELETE_BRANCH_QUIET))
       				printf(remote_branch
     -@@ builtin/branch.c: static int spare_stacked_base(const struct reference *ref, void *cb_data)
     -  * base is itself merged, so when its own upstream is also going away
     -  * (no surviving branch tracks it), clear the base's now-stale upstream.
     -  */
     --static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
     -+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable,
     -+				unsigned int flags)
     - {
     - 	struct strset spared = STRSET_INIT;
     - 	struct spare_data data = { .deletable = deletable, .spared = &spared };
     -@@ builtin/branch.c: static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable
     - 
     - 	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
     - 
     --	strset_for_each_entry(&spared, &iter, entry) {
     --		struct branch *branch = branch_get(entry->key);
     --		const char *upstream = branch_get_upstream(branch, NULL);
     --		const char *up_short;
     -+	if (!(flags & DELETE_BRANCH_DRY_RUN)) {
     -+		strset_for_each_entry(&spared, &iter, entry) {
     -+			struct branch *branch = branch_get(entry->key);
     -+			const char *upstream = branch_get_upstream(branch, NULL);
     -+			const char *up_short;
     - 
     --		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     --		    !strset_contains(deletable, up_short))
     --			continue;
     -+			if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     -+			    !strset_contains(deletable, up_short))
     -+				continue;
     - 
     --		strbuf_reset(&key);
     --		strbuf_addf(&key, "branch.%s.merge", branch->name);
     --		repo_config_set_gently(the_repository, key.buf, NULL);
     --		strbuf_reset(&key);
     --		strbuf_addf(&key, "branch.%s.remote", branch->name);
     --		repo_config_set_gently(the_repository, key.buf, NULL);
     -+			strbuf_reset(&key);
     -+			strbuf_addf(&key, "branch.%s.merge", branch->name);
     -+			repo_config_set_gently(the_repository, key.buf, NULL);
     -+			strbuf_reset(&key);
     -+			strbuf_addf(&key, "branch.%s.remote", branch->name);
     -+			repo_config_set_gently(the_repository, key.buf, NULL);
     -+		}
     - 	}
     - 
     - 	strbuf_release(&key);
     -@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 		strset_add(&deletable, short_name);
     - 	}
     - 
     --	spare_stacked_bases(refs, &deletable);
     -+	spare_stacked_bases(refs, &deletable, flags);
     - 
     - 	strset_for_each_entry(&deletable, &iter, entry)
     - 		strvec_push(&to_delete, entry->key);
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a
       		check_branches <<-\EOF &&
       		feature
       		main
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstream of a spared bra
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream chain of a surviving bra
       		git checkout -b tip mid --track &&
       		git commit --allow-empty -m "tip work" &&
       
      +		git branch --dry-run --delete-merged origin/next \
     -+			--delete-merged lower &&
     ++			--delete-merged lower >actual 2>&1 &&
     ++		test_must_be_empty actual &&
      +
     -+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
     ++		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
      +		cat >expect <<-\EOF &&
     ++		branch.lower.remote origin
     ++		branch.lower.merge refs/heads/next
      +		branch.mid.remote .
      +		branch.mid.merge refs/heads/lower
      +		branch.tip.remote .
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstr
      +		test_cmp expect actual &&
      +
       		git branch --delete-merged origin/next \
     - 			--delete-merged lower &&
     - 
     + 			--delete-merged lower >actual 2>&1 &&
     + 		test_must_be_empty actual &&
      @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
       	)
       '

-- 
gitgitgadget
