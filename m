Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428D36402A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113394; cv=none; b=ktmMYbIZki2s21QV3Yy4ihj6ChuPgYoECOXRT77S/sLWYK+zUZxpZS/oJDJmvedVeP5GYqaCnS1sRrfpq64I+zaqDKrWpRoRnGER8JbcecG8MkYLkW8tnPRZZ056kKFmDLYAh12V9oig1UBjemp1mAr/ALggbUG71WXsc2O/oXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113394; c=relaxed/simple;
	bh=oe4QzJY2a/02y59YExXtyLqcutFYJLtuzUgt5hiHBB8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GYcSXj8ad2uhAG5GkgmZis7+GwA5/bmbN/fpXck4upd2Xqfhf56MODDW63I6gKrb0SnE7KudszMuYe1es/+K55KWbHKQDMe8STOTRjDDYVPNrGhYJKTVViyl5GogMkGlJrjdhZMoImsap7JLhXIBBDMenA3BB3BIciqFtG0Xez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k732MeJc; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k732MeJc"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so7466289eec.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113391; x=1782718191; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLRuHLxo/2UEBVsqK/EYqHHgrWNOZHFvuij0QPZ26h8=;
        b=k732MeJcxymTqiL0ZzyvUbARt2+IvqhP+RjAigX3lsO+ThPgswijtSPBXnZ/mK3GsH
         PtSCZzJhoSSAINWlnLFhYa1+JVBmjs2edYpOjBBDSeKU3deviWwGYUivoJ7xxr9bhXhd
         Xwry/ism/MtpvEB2oyozA54M5pCU8NVl+8XdqtpgR2c9kJ9PDbUaGQUbE3VFss99ttQd
         ZlFJZErmmmaMvVmQAx1I0xiamNKXD9K0pxZ7TZEDxYMUHcTRMr1k5ZOA3lpp84G61KU0
         ZUH92Rb1Vf9JhjUodq/vidNHL6gsz0yTfYSG3Mv4Z0M0KBQP7bnrHoknbQU5yUalSto1
         gRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113391; x=1782718191;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLRuHLxo/2UEBVsqK/EYqHHgrWNOZHFvuij0QPZ26h8=;
        b=bY8DPtjlwy2afn9htRYTJzrhlypZ9QKNCAgPFiITr6me+6rPysSYE8BxAFdkuPY9YK
         H+E4kkA4v4mNM/WixfwHfQrKzjJFPDbEEYTG5OO8EB/FP3WkD6VpG5J4ovr9o1R/iz8R
         vG61SXSmeH1e7Pw6U9TQgrS7zZpqkShZHYemY4hY1nA73vIPb8SoJh4SqfAn16hr/2k+
         hVlV06D2eH2aaYKnU5Sdaf2BOhdwSrB4vvKcD346AZjVWI98ndZOTZyprXsS0IkIrytn
         Jq2zBaYIYhlxU3WW0lHuH7sgLdPdTpZRo/WlZrcTGAdlsKtewrYgNQh4uCrq+bumK7XL
         Cwdg==
X-Gm-Message-State: AOJu0YzkAfKjykgWtNJSu38SSp1FBDaevUqPxoWsI+gwFDAP4GrCy2f8
	jROtM2qWPCXNHuMmTBVJrK7KdlN1qsToI+Tlww6CZhii9aFM3+1aU55RhImONg==
X-Gm-Gg: AfdE7clAOuImzzq6ul1Y6qCiQIH59SFYhaJCllETWPqo6utl0z3Ljh6J5PpnNs1DIUz
	6ZUv3+cYM235+3wyoSXspLwvG0Ns7UE6wHi08aOYPj2K/nlN6uAw7hvrNzu0nhhmNESAt+rxYzI
	/WAlUg6u89zNaj0TKcJzDW6fwu0YCwKzl/UdwXGPzGqzAEAlxvmtV7KG46yCNQxSOXyhvqdIFYG
	JrG/Kyw00AI38PvmN2B2mAwRIIPHCTWoprMb1WtdLO4iZ3PJZJHOiIJ/87RKZDIeY+IGDdH9aDs
	9T24WN4libiJ8w7Xxh883pgUtb/gg21fXiFpSH7o47FMlg8D16ECUcxuVBERU2ym/KHqx14lfac
	wlSldFZN4p8TObRuPFQNZvpg44mtyD6W3lV7jgoRi8yEmTyA+2HpH/wfVzhS7oAObcByghHR9Q/
	ggmlUdl8mFTH5IONvLPw==
X-Received: by 2002:a05:7300:181f:b0:2ef:8b91:212 with SMTP id 5a478bee46e88-30c0ceac969mr8667074eec.14.1782113390700;
        Mon, 22 Jun 2026 00:29:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bde9335sm9181479eec.21.2026.06.22.00.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:29:49 -0700 (PDT)
Message-Id: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:41 +0000
Subject: [PATCH v17 0/7] branch: delete-merged
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
 Documentation/git-branch.adoc    |  47 ++++-
 builtin/branch.c                 | 247 ++++++++++++++++++++++---
 ref-filter.c                     |  70 +++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 308 +++++++++++++++++++++++++++++++
 6 files changed, 661 insertions(+), 28 deletions(-)


base-commit: 8d96f09e9245ddf80c1981476fcbac8c4bb4125f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v17
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v17
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v16:

 1:  1f6a758265 = 1:  d8cc17bd7f branch: add --forked filter for --list mode
 2:  4f8af602ba = 2:  d14b0403f0 branch: convert delete_branches() to a flags argument
 3:  efc891c255 = 3:  ef2719dac3 branch: let delete_branches skip unmerged branches on bulk refusal
 4:  b1ecd38fe3 ! 4:  80518f5d11 branch: prepare delete_branches for a bulk caller
     @@ builtin/branch.c: enum delete_branch_flags {
       	DELETE_BRANCH_QUIET = (1 << 1),
       	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
      +	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
     -+	DELETE_BRANCH_DRY_RUN = (1 << 4),
       };
       
       static int check_branch_commit(const char *branchname, const char *refname,
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
       	bool force;
       	bool quiet = flags & DELETE_BRANCH_QUIET;
       	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     -+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
      +	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
       	struct strbuf bname = STRBUF_INIT;
       	enum interpret_branch_kind allowed_interpret;
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
       		head_rev = lookup_commit_reference(the_repository, &head_oid);
       
       	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 		free(target);
     - 	}
     - 
     --	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     -+	if (!dry_run &&
     -+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     - 		ret = 1;
     - 
     - 	for_each_string_list_item(item, &refs_to_delete) {
     - 		char *describe_ref = item->util;
     - 		char *name = item->string;
     --		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     -+		if (dry_run) {
     -+			if (!quiet)
     -+				printf(remote_branch
     -+					? _("Would delete remote-tracking branch %s (was %s).\n")
     -+					: _("Would delete branch %s (was %s).\n"),
     -+					name + branch_name_pos, describe_ref);
     -+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     - 			char *refname = name + branch_name_pos;
     - 			if (!quiet)
     - 				printf(remote_branch
 5:  998fb6a68c ! 5:  46da7c8140 branch: add --delete-merged <branch>
     @@ Commit message
          A branch whose work is not yet merged into its upstream is silently
          skipped, so one unmerged topic does not abort the whole sweep.
      
     +    A branch that another, surviving branch tracks as its upstream is
     +    also kept, so a branch is never deleted out from under one stacked
     +    on top of it. Sparing such a base can in turn protect its own
     +    upstream, so the check repeats until the set stops changing.
     +
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
      +A branch whose work has not yet been merged into its upstream is
      +silently skipped. Delete it with `git branch -D` if you want to
      +remove it anyway.
     +++
     ++A branch that another, surviving branch still tracks as its upstream
     ++is kept, so a branch is never deleted out from under one stacked on
     ++top of it.
      +
       `-v`::
       `-vv`::
       `--verbose`::
      
       ## builtin/branch.c ##
     +@@
     + #include "branch.h"
     + #include "path.h"
     + #include "string-list.h"
     ++#include "strmap.h"
     + #include "column.h"
     + #include "utf8.h"
     + #include "ref-filter.h"
      @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
       	N_("git branch [<options>] [-r | -a] [--points-at]"),
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
       	return 0;
       }
       
     ++static int collect_upstream(const struct reference *ref, void *cb_data)
     ++{
     ++	struct string_list *upstreams = cb_data;
     ++	struct branch *branch = branch_get(ref->name);
     ++	const char *upstream = branch_get_upstream(branch, NULL);
     ++
     ++	string_list_append(upstreams, ref->name)->util =
     ++		xstrdup_or_null(upstream);
     ++	return 0;
     ++}
     ++
     ++/*
     ++ * Keep any branch that another, surviving branch tracks as its
     ++ * upstream, so we never delete a branch out from under one stacked on
     ++ * top of it.  Sparing a branch makes it a survivor whose own upstream
     ++ * then needs the same protection, so repeat until nothing changes.
     ++ */
     ++static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
     ++{
     ++	struct string_list upstreams = STRING_LIST_INIT_DUP;
     ++	struct string_list_item *item;
     ++	bool spared;
     ++
     ++	refs_for_each_branch_ref(refs, collect_upstream, &upstreams);
     ++	do {
     ++		spared = false;
     ++		for_each_string_list_item(item, &upstreams) {
     ++			const char *up = item->util, *up_short;
     ++
     ++			if (!up || strset_contains(deletable, item->string))
     ++				continue;
     ++			if (!skip_prefix(up, "refs/heads/", &up_short) ||
     ++			    !strset_contains(deletable, up_short))
     ++				continue;
     ++
     ++			strset_remove(deletable, up_short);
     ++			spared = true;
     ++		}
     ++	} while (spared);
     ++
     ++	string_list_clear(&upstreams, 1);
     ++}
     ++
      +static int delete_merged_branches(int argc, const char **argv,
      +				 unsigned int flags)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct ref_filter filter = REF_FILTER_INIT;
      +	struct ref_array candidates = { 0 };
     -+	struct strvec deletable = STRVEC_INIT;
     ++	struct strset deletable = STRSET_INIT;
     ++	struct strvec to_delete = STRVEC_INIT;
      +	int i, ret = 0;
      +
      +	if (!argc)
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +		push = branch_get_push(branch, NULL);
      +		if (!push || !strcmp(push, upstream))
      +			continue;
     ++		if (check_branch_commit(short_name, short_name,
     ++					&candidates.items[i]->objectname, NULL,
     ++					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
     ++			continue;
      +
     -+		strvec_push(&deletable, short_name);
     ++		strset_add(&deletable, short_name);
      +	}
      +
     -+	if (deletable.nr)
     -+		ret = delete_branches(deletable.nr, deletable.v,
     ++	spare_stacked_bases(refs, &deletable);
     ++
     ++	for (i = 0; i < candidates.nr; i++) {
     ++		const char *short_name;
     ++
     ++		if (skip_prefix(candidates.items[i]->refname, "refs/heads/",
     ++				&short_name) &&
     ++		    strset_contains(&deletable, short_name))
     ++			strvec_push(&to_delete, short_name);
     ++	}
     ++
     ++	if (to_delete.nr)
     ++		ret = delete_branches(to_delete.nr, to_delete.v,
      +				      FILTER_REFS_BRANCHES,
      +				      DELETE_BRANCH_SKIP_UNMERGED |
      +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
      +				      flags);
      +
     -+	strvec_clear(&deletable);
     ++	strvec_clear(&to_delete);
     ++	strset_clear(&deletable);
      +	ref_array_clear(&candidates);
      +	ref_filter_clear(&filter);
      +	return ret;
     @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
      +	test_must_fail git -C forked branch --delete-merged 2>err &&
      +	test_grep "requires at least one <branch>" err
      +'
     ++
     ++test_expect_success '--delete-merged keeps a branch that is an upstream' '
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	merged_branch feature origin/next &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b topic feature &&
     ++		git commit --allow-empty -m "topic work" &&
     ++		git branch --set-upstream-to=feature topic &&
     ++		git checkout --detach
     ++	) &&
     ++
     ++	git -C repo branch --delete-merged origin/next 2>err &&
     ++
     ++	test_must_be_empty err &&
     ++	git -C repo rev-parse --verify refs/heads/feature &&
     ++	git -C repo rev-parse --verify refs/heads/topic
     ++'
     ++
     ++test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git branch b3 origin/next &&
     ++		git branch --set-upstream-to=origin/next b3 &&
     ++		git branch b2 origin/next &&
     ++		git branch --set-upstream-to=b3 b2 &&
     ++		git checkout -b b1 b2 &&
     ++		git commit --allow-empty -m "b1 work" &&
     ++		git branch --set-upstream-to=b2 b1 &&
     ++		git checkout --detach
     ++	) &&
     ++
     ++	git -C repo branch --delete-merged origin/next &&
     ++
     ++	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     ++	cat >expect <<-\EOF &&
     ++	b1
     ++	b2
     ++	b3
     ++	main
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
       test_done
 6:  a27d2724a2 ! 6:  27903fbb1d branch: add branch.<name>.deleteMerged opt-out
     @@ Documentation/git-branch.adoc: A branch is not deleted when:
      
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     - 	struct ref_filter filter = REF_FILTER_INIT;
       	struct ref_array candidates = { 0 };
     - 	struct strvec deletable = STRVEC_INIT;
     + 	struct strset deletable = STRSET_INIT;
     + 	struct strvec to_delete = STRVEC_INIT;
      +	struct strbuf key = STRBUF_INIT;
      +	bool quiet = flags & DELETE_BRANCH_QUIET;
       	int i, ret = 0;
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       		if (!skip_prefix(full_name, "refs/heads/", &short_name))
       			BUG("filter returned non-branch ref '%s'", full_name);
      @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     - 		if (!push || !strcmp(push, upstream))
     + 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
       			continue;
       
      +		strbuf_reset(&key);
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
      +			continue;
      +		}
      +
     - 		strvec_push(&deletable, short_name);
     + 		strset_add(&deletable, short_name);
       	}
       
      @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       				      flags);
       
      +	strbuf_release(&key);
     - 	strvec_clear(&deletable);
     + 	strvec_clear(&to_delete);
     + 	strset_clear(&deletable);
       	ref_array_clear(&candidates);
     - 	ref_filter_clear(&filter);
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged requires at least one <branch>' '
     - 	test_grep "requires at least one <branch>" err
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch
     + 	test_cmp expect actual
       '
       
      +test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
 7:  6d5c52353e ! 7:  49c1bcf1fb branch: add --dry-run for --delete-merged
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into its upstream is
     - silently skipped. Delete it with `git branch -D` if you want to
     - remove it anyway.
     +@@ Documentation/git-branch.adoc: A branch that another, surviving branch still tracks as its upstream
     + is kept, so a branch is never deleted out from under one stacked on
     + top of it.
       
      +`--dry-run`::
      +	With `--delete-merged`, print which branches would be
     @@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into
       `--verbose`::
      
       ## builtin/branch.c ##
     +@@ builtin/branch.c: enum delete_branch_flags {
     + 	DELETE_BRANCH_QUIET = (1 << 1),
     + 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
     + 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
     ++	DELETE_BRANCH_DRY_RUN = (1 << 4),
     + };
     + 
     + static int check_branch_commit(const char *branchname, const char *refname,
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     + 	bool quiet = flags & DELETE_BRANCH_QUIET;
     + 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     + 	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
     ++	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
     + 	struct strbuf bname = STRBUF_INIT;
     + 	enum interpret_branch_kind allowed_interpret;
     + 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     + 		free(target);
     + 	}
     + 
     +-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     ++	if (!dry_run &&
     ++	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     + 		ret = 1;
     + 
     + 	for_each_string_list_item(item, &refs_to_delete) {
     + 		char *describe_ref = item->util;
     + 		char *name = item->string;
     +-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     ++		if (dry_run) {
     ++			if (!quiet)
     ++				printf(remote_branch
     ++					? _("Would delete remote-tracking branch %s (was %s).\n")
     ++					: _("Would delete branch %s (was %s).\n"),
     ++					name + branch_name_pos, describe_ref);
     ++		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     + 			char *refname = name + branch_name_pos;
     + 			if (!quiet)
     + 				printf(remote_branch
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;

-- 
gitgitgadget
