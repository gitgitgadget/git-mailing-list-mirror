Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2B40D596
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021200; cv=none; b=JrFEOX+tGZBp9TGx0WN1+PGBl4YC0Mf5VfkofnLrlMgcIztyc+qIrBQxFI7gYdvY0FgOLRF8tjG+sPpCK2wNjN51pVI+NJVVrubY+AIAV1oQhf6++DtYXqlSBGeav9kqCHpsyJgqShqVeOmIAHast1CWgLt9/CZvl6EtgXWkLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021200; c=relaxed/simple;
	bh=R8lxgWjMvG726qaRcMD6Gg6otatz4RWwlqz5FagG6oQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KaY2iTAqnnigtQszHj23wHFmUv95SKckqX2IDsMwcqo2dAqHNAFM6jOTAq67eH5Mh48AlgbbtoFeIwTnlrSP0yPy/J69dMrfDefhhfg/0tOBvuZmII4DYq6Gg1QYRJpg0xavEIbAZL1pjNMZLPDWzozchM4/XfB0ktMsViy1Lu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiki0vz+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiki0vz+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91587626ae1so396961385a.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021197; x=1782625997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ltO+2o83NgRg72PiOeaNiUcGSSmg6xA7R8VfAmqHQQ=;
        b=iiki0vz+/aZlq6e6UqUe+HlD56GzdhoY361ycjj1zUlClPVzN5z9uDm8xMU1XnMAMV
         szg2C5uX2TTJG2VYNK2qQfZUpimQM939odzelT5rE5gCAhHLO7DPOiJqlAxGG+gd7O4j
         +ydEf0kI6Vak7+mTbSfwbwTkl4DOWH0s8vcIoygnlwALAMk2mK6DOc8gv49bHn96Xa0B
         eCthDmsYn3qQ5fgBl0CkXvs/SYWEzdcC3f64Rao2s8hLp76pM00R4tRrANBOWC/gQW+4
         dquPe8nNRH3yqjzm5a8OlSa8kNpSO+BniZ9s8MakxsxxywKkDOAHGHHUKcCvtwNa975v
         7H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021197; x=1782625997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ltO+2o83NgRg72PiOeaNiUcGSSmg6xA7R8VfAmqHQQ=;
        b=K8tx7YrwGx4jr7uwhW6lAtYSQ9qAmKr0cgnVOxqwb86+wnEy5VwYijkqjr2lpbLxTr
         UsgqYC2VhBQGW1LSIQfH7WS9xMvehuzhR4vT1yU7IkfhMgzpu5oAcxNv5yjeD80IXfMp
         mHO9PyByPlzW1T+7CzKWg4iUPXc5+4ojFThbhZYicByZNZ4OQd3xPYEyIyjsnEAJhOJg
         pwXU+Sz1tDXNHruFGeO3KCPNM4N+NiWm3SpD0P4OmJKZvljTPmxe0nw9TjuCUQThqTvh
         CJdcRF2PB4V7Fl0+rp5oTKkexNn+ZWVmHyxxzivzzPrhtAQWoj8M6iT41YXKk8LdKz2o
         NPGw==
X-Gm-Message-State: AOJu0YwcZhhmGX8oOZii36Ykckm+pQLEnJ+iefw33esmtpgTZIkrK4Yn
	oiDC3slKK1jyvqS1MaFN5zLsatv9+nABVthklRprRwTxGh4n3VX5TUiDBy0FPQ==
X-Gm-Gg: AfdE7cnFSgXKScDi8J4CX0FsTMD7S7UJGZN89SM+sFB0q+sQv5nkx5SHr67q31F7L3m
	n55TSvQ+LpHtq4y/DmH3tYXrqaYmcgTMgPEp0MJcBbZP9CKmaeTAxYa9ichmQljfon+bz1uEWZU
	xpBgmX+BhkoerqQ3pAI4r3XJaj0Q5DpL6F/fnhTQpHaz1616JcYk02C3nGto27iZTzzHMVAHqCC
	MV+z3N8ARulfVmDxYwQoy9ofdaa41DhtoW9F+3jU76QHH1xE67j/Y7RmOVaNd/RA9t3N8TS0iPs
	gnQhItzP/379ejRm3GPSGUCETvtU76KNQ117LNq7y199nYe09hJCHwqAbdo+NnXiBrcCxJp6uOz
	KwzlSdovHS3Okm/dcVcSnEoInSHvvD/mO3tZgSW7Ai/WnKdo/GcyAGFWpVLVKMfnRtsTyVZTiuE
	0064liYNWNh84KYfkHYbCiKeCOKv/d
X-Received: by 2002:a05:620a:7014:b0:915:9531:f6e9 with SMTP id af79cd13be357-9208f15e57cmr1580056385a.6.1782021196905;
        Sat, 20 Jun 2026 22:53:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.117.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921daa7d65bsm501975285a.22.2026.06.20.22.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:53:15 -0700 (PDT)
Message-Id: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
References: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 05:53:11 +0000
Subject: [PATCH v4 0/4] history: add squash subcommand to fold a range
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (4):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  history: add squash subcommand to fold a range
  history: re-edit a squash with every message

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  26 +++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 328 +++++++++++++++++++++++++----
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 340 +++++++++++++++++++++++++++++++
 7 files changed, 663 insertions(+), 38 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 8d96f09e9245ddf80c1981476fcbac8c4bb4125f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v4
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v3:

 1:  1e31474ef6 = 1:  fc2801c0b1 history: extract helper for a commit's parent tree
 2:  498da64046 = 2:  ee591e83b4 history: give commit_tree_ext a message template
 3:  66b2f49fb4 ! 3:  80bfea642e history: add squash subcommand to fold a range
     @@ Commit message
          other commit, but the range must have a single base, so a range with
          more than one entry point is rejected.
      
     +    The folded commits leave the history, so by default the command refuses
     +    when another ref points at one of them. Use "--update-refs=head" to
     +    rewrite only the current branch and leave those refs untouched.
     +
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## Documentation/config/advice.adoc ##
     +@@ Documentation/config/advice.adoc: all advice messages.
     + 	forceDeleteBranch::
     + 		Shown when the user tries to delete a not fully merged
     + 		branch without the force option set.
     ++	historyUpdateRefs::
     ++		Shown when `git history squash` refuses because a ref points
     ++		into the range being folded, to tell the user about
     ++		`--update-refs=head`.
     + 	ignoredHook::
     + 		Shown when a hook is ignored because the hook is not
     + 		set as executable.
     +
       ## Documentation/git-history.adoc ##
      @@ Documentation/git-history.adoc: SYNOPSIS
       git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +folded like any other, but the range must have a single base, so a range
      +that reaches more than one entry point (for example a side branch that
      +forked before the range and was later merged into it) is rejected.
     +++
     ++The folded commits disappear from the history, so with the default
     ++`--update-refs=branches` the command refuses when another ref points at
     ++one of them. Rerun with `--update-refs=head` to rewrite only the current
     ++branch and leave those refs pointing at the old commits.
      +
       OPTIONS
       -------
       
      
     + ## advice.c ##
     +@@ advice.c: static struct {
     + 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
     + 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
     + 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
     ++	[ADVICE_HISTORY_UPDATE_REFS]			= { "historyUpdateRefs" },
     + 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
     + 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
     + 	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
     +
     + ## advice.h ##
     +@@ advice.h: enum advice_type {
     + 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
     + 	ADVICE_FORCE_DELETE_BRANCH,
     + 	ADVICE_GRAFT_FILE_DEPRECATED,
     ++	ADVICE_HISTORY_UPDATE_REFS,
     + 	ADVICE_IGNORED_HOOK,
     + 	ADVICE_IMPLICIT_IDENTITY,
     + 	ADVICE_MERGE_CONFLICT,
     +
       ## builtin/history.c ##
     +@@
     + #define USE_THE_REPOSITORY_VARIABLE
     + 
     + #include "builtin.h"
     ++#include "advice.h"
     + #include "cache-tree.h"
     + #include "commit.h"
     + #include "commit-reach.h"
      @@
       	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
       #define GIT_HISTORY_SPLIT_USAGE \
     @@ builtin/history.c: out:
      +				const char *range,
      +				struct commit **base_out,
      +				struct commit **oldest_out,
     -+				struct commit **tip_out)
     ++				struct commit **tip_out,
     ++				struct oidset *interior_out)
      +{
      +	struct rev_info revs;
      +	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
     @@ builtin/history.c: out:
      +		}
      +		if (!oldest)
      +			oldest = commit;
     ++		if (tip)
     ++			oidset_insert(interior_out, &tip->object.oid);
      +		tip = commit;
      +	}
      +
     @@ builtin/history.c: out:
      +	return ret;
      +}
      +
     ++struct interior_ref_cb {
     ++	const struct oidset *interior;
     ++	const char *name;
     ++};
     ++
     ++static int find_interior_ref(const struct reference *ref, void *cb_data)
     ++{
     ++	struct interior_ref_cb *data = cb_data;
     ++
     ++	if (oidset_contains(data->interior, ref->oid)) {
     ++		data->name = xstrdup(ref->name);
     ++		return 1;
     ++	}
     ++
     ++	return 0;
     ++}
     ++
      +static int cmd_history_squash(int argc,
      +			      const char **argv,
      +			      const char *prefix,
     @@ builtin/history.c: out:
      +		OPT_END(),
      +	};
      +	struct strbuf reflog_msg = STRBUF_INIT;
     ++	struct oidset interior = OIDSET_INIT;
      +	struct commit *base, *oldest, *tip, *rewritten;
      +	const struct object_id *base_tree_oid, *tip_tree_oid;
      +	struct commit_list *parents = NULL;
     @@ builtin/history.c: out:
      +	if (action == REF_ACTION_DEFAULT)
      +		action = REF_ACTION_BRANCHES;
      +
     -+	ret = resolve_squash_range(repo, argv[0], &base, &oldest, &tip);
     ++	ret = resolve_squash_range(repo, argv[0], &base, &oldest, &tip,
     ++				   &interior);
      +	if (ret < 0)
      +		goto out;
      +
     ++	if (action == REF_ACTION_BRANCHES) {
     ++		struct interior_ref_cb cb = { .interior = &interior };
     ++
     ++		refs_for_each_ref(get_main_ref_store(repo),
     ++				  find_interior_ref, &cb);
     ++		if (cb.name) {
     ++			ret = error(_("'%s' points into the squashed range"),
     ++				    cb.name);
     ++			advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
     ++					  _("Use --update-refs=head to rewrite only "
     ++					    "the current branch and leave such refs "
     ++					    "untouched."));
     ++			free((char *)cb.name);
     ++			goto out;
     ++		}
     ++	}
     ++
      +	ret = setup_revwalk(repo, action, tip, &revs);
      +	if (ret < 0)
      +		goto out;
     @@ builtin/history.c: out:
      +
      +out:
      +	strbuf_release(&reflog_msg);
     ++	oidset_clear(&interior);
      +	commit_list_free(parents);
      +	release_revisions(&revs);
      +	return ret;
     @@ t/meson.build: integration_tests = [
         't3451-history-reword.sh',
         't3452-history-split.sh',
         't3453-history-fixup.sh',
     -+  't3454-history-squash.sh',
     ++  't3455-history-squash.sh',
         't3500-cherry.sh',
         't3501-revert-cherry-pick.sh',
         't3502-cherry-pick-merge.sh',
      
     - ## t/t3454-history-squash.sh (new) ##
     + ## t/t3455-history-squash.sh (new) ##
      @@
      +#!/bin/sh
      +
     @@ t/t3454-history-squash.sh (new)
      +test_expect_success 'setup linear history touching two files' '
      +	test_commit base file a &&
      +	git tag start &&
     -+	test_commit one other x &&
     -+	test_commit two file c &&
     ++	test_commit --no-tag one other x &&
     ++	test_commit --no-tag two file c &&
      +	test_commit three file d
      +'
      +
     @@ t/t3454-history-squash.sh (new)
      +
      +test_expect_success 'reuses the message of a fixup! commit in the range' '
      +	git reset --hard start &&
     -+	test_commit reg1 file b &&
     ++	test_commit --no-tag reg1 file b &&
      +	git commit --allow-empty -m "fixup! reg1" &&
      +	test_commit reg2 file c &&
      +
     @@ t/t3454-history-squash.sh (new)
      +test_expect_success 'preserves authorship of the oldest commit' '
      +	git reset --hard start &&
      +	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
     -+		test_commit oldest file b &&
     ++		test_commit --no-tag oldest file b &&
      +	test_commit newest file c &&
      +
      +	git history squash start.. &&
     @@ t/t3454-history-squash.sh (new)
      +test_expect_success '--dry-run predicts the rewrite without performing it' '
      +	git reset --hard three &&
      +	head_before=$(git rev-parse HEAD) &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
      +	git history squash --dry-run start.. >out &&
     -+	grep "^update refs/heads/" out >update &&
     -+	predicted=$(awk "{print \$3}" update) &&
     ++	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
      +	git history squash start.. &&
     -+	test "$predicted" = "$(git rev-parse HEAD)"
     ++	test "$predicted" = "$(git rev-parse HEAD)" &&
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test_cmp_rev start HEAD^ &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
      +
      +test_expect_success '--update-refs=head only moves HEAD' '
     @@ t/t3454-history-squash.sh (new)
      +	test_cmp_rev "$other_before" other
      +'
      +
     -+test_expect_success '--update-refs=branches moves a branch pointing into the range' '
     ++test_expect_success 'refuses to fold a range a ref points into' '
     ++	git reset --hard three &&
     ++	git branch -f mid HEAD~1 &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "error: .* points into the squashed range" err &&
     ++	test_grep "hint: .*--update-refs=head" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++
     ++	git branch -D mid
     ++'
     ++
     ++test_expect_success 'advice.historyUpdateRefs silences the hint' '
     ++	git reset --hard three &&
     ++	git branch -f mid HEAD~1 &&
     ++
     ++	test_must_fail git -c advice.historyUpdateRefs=false \
     ++		history squash start.. 2>err &&
     ++	test_grep "points into the squashed range" err &&
     ++	test_grep ! "hint:" err &&
     ++
     ++	git branch -D mid
     ++'
     ++
     ++test_expect_success '--update-refs=head folds past a ref pointing into the range' '
      +	git reset --hard three &&
     -+	git branch -f mid HEAD~2 &&
     ++	git branch -f mid HEAD~1 &&
      +	mid_before=$(git rev-parse mid) &&
      +
     -+	git history squash start..@~1 &&
     ++	git history squash --update-refs=head start.. &&
      +
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
      +	test_cmp_rev "$mid_before" mid &&
     -+	test_commit_message mid -m one
     ++
     ++	git branch -D mid
     ++'
     ++
     ++test_expect_success 'refuses to fold a range a tag points into' '
     ++	git reset --hard three &&
     ++	git tag -f mark HEAD~1 &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "refs/tags/mark" err &&
     ++	test_grep "points into the squashed range" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++
     ++	git tag -d mark
      +'
      +
      +test_expect_success 'squashes a range whose internal merge has a single base' '
      +	git reset --hard start &&
     -+	test_commit before-side file b &&
     ++	test_commit --no-tag before-side file b &&
      +	git checkout -b inner-side &&
     -+	test_commit on-inner-side inner x &&
     ++	test_commit --no-tag on-inner-side inner x &&
      +	git checkout - &&
     -+	test_commit after-side file c &&
     ++	test_commit --no-tag after-side file c &&
      +	git merge --no-ff -m merge inner-side &&
     -+	test_commit after-merge file d &&
     ++	git branch -D inner-side &&
     ++	test_commit --no-tag after-merge file d &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
      +	git history squash start.. &&
     @@ t/t3454-history-squash.sh (new)
      +	test_path_is_file inner
      +'
      +
     ++test_expect_success 'folds a range whose tip is a merge commit' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag tipmerge-base file b &&
     ++	git checkout -b tipmerge-side &&
     ++	test_commit --no-tag tipmerge-side side x &&
     ++	git checkout - &&
     ++	test_commit --no-tag tipmerge-main file c &&
     ++	git merge --no-ff -m "merge tipmerge-side" tipmerge-side &&
     ++	git branch -D tipmerge-side &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++	test_path_is_file side
     ++'
     ++
     ++test_expect_success 'folds a range whose base is a merge commit' '
     ++	git reset --hard start &&
     ++	git checkout -b basemerge-side &&
     ++	test_commit --no-tag basemerge-side side x &&
     ++	git checkout - &&
     ++	test_commit --no-tag basemerge-main file b &&
     ++	git merge --no-ff -m "merge basemerge-side" basemerge-side &&
     ++	git branch -D basemerge-side &&
     ++	base=$(git rev-parse HEAD) &&
     ++	test_commit --no-tag basemerge-one file c &&
     ++	test_commit --no-tag basemerge-two file d &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash "$base.." &&
     ++
     ++	git rev-list --count "$base..HEAD" >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test_cmp_rev "$base" HEAD^ &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
     ++'
     ++
      +test_expect_success 'refuses to squash a range with more than one base' '
      +	git reset --hard start &&
      +	head_before=$(git rev-parse HEAD) &&
 4:  43e4270614 ! 4:  85c7817d7e history: re-edit a squash with every message
     @@ Documentation/git-history.adoc: history squash @~3..` folds the three most recen
       forked before the range and was later merged into it) is rejected.
      
       ## builtin/history.c ##
     -@@ builtin/history.c: out:
     - 	return ret;
     +@@ builtin/history.c: static int find_interior_ref(const struct reference *ref, void *cb_data)
     + 	return 0;
       }
       
      +static int build_squash_message(struct repository *repo,
     @@ builtin/history.c: static int cmd_history_squash(int argc,
       	};
       	struct strbuf reflog_msg = STRBUF_INIT;
      +	struct strbuf message = STRBUF_INIT;
     + 	struct oidset interior = OIDSET_INIT;
       	struct commit *base, *oldest, *tip, *rewritten;
       	const struct object_id *base_tree_oid, *tip_tree_oid;
     - 	struct commit_list *parents = NULL;
      @@ builtin/history.c: static int cmd_history_squash(int argc,
     - 	if (ret < 0)
     - 		goto out;
     + 		}
     + 	}
       
      +	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
      +		ret = build_squash_message(repo, base, tip, &message);
     @@ builtin/history.c: static int cmd_history_squash(int argc,
       out:
       	strbuf_release(&reflog_msg);
      +	strbuf_release(&message);
     + 	oidset_clear(&interior);
       	commit_list_free(parents);
       	release_revisions(&revs);
     - 	return ret;
      
     - ## t/t3454-history-squash.sh ##
     -@@ t/t3454-history-squash.sh: test_expect_success 'preserves authorship of the oldest commit' '
     + ## t/t3455-history-squash.sh ##
     +@@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the oldest commit' '
       	test_cmp expect actual
       '
       
     @@ t/t3454-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	echo b >file &&
      +	git add file &&
      +	git commit -m "re-one subject" -m "re-one body line" &&
     -+	test_commit re-two file c &&
     ++	test_commit --no-tag re-two file c &&
      +	test_commit re-three file d &&
      +
      +	write_script editor <<-\EOF &&
     @@ t/t3454-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	test_set_editor "$(pwd)/editor" &&
      +	git history squash --reedit-message start.. &&
      +
     -+	grep "re-one subject" buffer &&
     -+	grep "re-one body line" buffer &&
     -+	grep re-two buffer &&
     -+	grep re-three buffer &&
     ++	test_grep "re-one subject" buffer &&
     ++	test_grep "re-one body line" buffer &&
     ++	test_grep re-two buffer &&
     ++	test_grep re-three buffer &&
      +	git log --format="%s" -1 >actual &&
      +	echo combined >expect &&
      +	test_cmp expect actual

-- 
gitgitgadget
