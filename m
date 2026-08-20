Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6038F259
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249447; cv=none; b=IBou/sGOio0aDK2Pj9048dRwx94tcLe+2CDsf9miRhXEpyeD1zicgBFo3QENr+SimGGKa2CW0dy7bnQkf0rp98QTKfSAiukWUyfiUUEtQl49jDfMiMEfKSPnsKMl2pl72xAUS6FCKjKA23TqUyTgfIBTLIZEV1/rKg2IQZ+a4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249447; c=relaxed/simple;
	bh=K37Vy3t2IcBlDOqRvBTHvVVfz7ixNR9aea5J6g0XJNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DUQOYjm3O72iRZuWuzG9Sir59Ng675LzSavEEF+MZyg6TWhHFbK6QFg6aTjsIYtGV8Q63rsowsldSOhWpH/BlEVlExunNdsPrxULMPgbcD0BiyeWHVaV2isKaw8pW1ASzdc5Vi/RUtBl9O1aBAequgbt12omALVEZpl/yp4qacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/P3I5Cn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/P3I5Cn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso107169a34.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249444; x=1787854244; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=plT7pxYJHGOqrG839OkKJFRqWO7V8v5l+sB9dyVMuuI=;
        b=H/P3I5Cn1ojhm8rZkpnf5fi81NecuYjwtcaWPtxnOLZ0TcgweIXQxLQFpEAC9+gbPu
         2NZ8mO6zOdBXLuWF+mKIvGrIFnT7F6rtJTmv1huuFXqFsHrBLAdXwlKD++Rww2uZ1xCM
         kGnqmCZEtZEnV///AjjuAlExxD2+kLvhKGz1HqpWkvZV8qXa2RA7Q14es9dvDwsxW4Ri
         S7ocoACihO6kIze3d3SOYHNyt3ULYasm0hkken2KL7ghcr+wLyrjFUvhsJEQ5d7xWOqr
         2uCzyjdTPngQLV+xYb6eXQWUlktXTvKuPS6OpopvcaUXoeM13h7copDpm4+yYvv/Xkjj
         QF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249444; x=1787854244;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plT7pxYJHGOqrG839OkKJFRqWO7V8v5l+sB9dyVMuuI=;
        b=TaNSskxukbL/UD2BeNSuxwdKkaue8UA4oVuovO0NYLOy1NwssZgeDtatA86ATyQmIa
         FtnN4SUOYBMk52EoCNufVNzO9Df4mjS3F03cQnoYFQMBessQKv+XL9x4aTH8szZ/L7lo
         OizOwwiTSs3eAU63uCh4MyMYuCxbG5ieoukz0uDAkFZTVMXd/lFfSxqeGh35+TBfGYqn
         VB+5qOddx5xNb0zYezd+Izu1Yo6GHOZ6hNSOnEwmEBY5AhQXWmXrWVM5ycaObU+HvEVf
         6O3gthIMF1xWF9yHbF/DXEdX6V3PQWqRUmfALHJxXis3lcIEJ66qBn8MBFEJJHwIQzqo
         ogig==
X-Gm-Message-State: AOJu0Yx+zmrlkNxZuWT06MgFijD3vU2fOUAePJYJpNFQM/mz3xUBk42d
	0hqTS3cyJu0WnA9KT/Ear7LKcTxQMH3GqqwqCGETf6Nux2Wn8lcDq5Ke67bUsZ0g
X-Gm-Gg: AR+sD13RUbyEh99W3M3usF63c5YYePVqcOafVi9BY51aI+sEJg6tFUApFI3IxKgHNyp
	sE7FY6fe4EpQiagEew9IHGtjVmLGae1IEzpbPTP9k92qyxVNFeMfjaRJQK5EA2xT7zU34xz6Vr5
	lTBHDCR0xLR80DTJMnhTRhk5xibsXAECBviJY/aYeV80cy+n7pm5tLVoDpU27n8hZ4g8g0sujmX
	/F1BGOiT7X883gWY0F4eBU3LSe05/UvqFNa4a+Xx3Ve/JI7wo0lG6FPFEWqRfQ2qh1gzq82LdOW
	Xk6VihpNGPHEFnJOyAZkM8lQjuhOfEJloSK5ps4Dz5O9d7DmWx/zeUy8UMlEi6sisy7GaBX7vR2
	aG7cc5/HrtfsIdMWM0ijRELIR0LIw5OmIbF3jzJVkQwVyGpS24LlwJAWHYAtaLg/fV0IsOnQ+zK
	XWHrU9RSwl2/KvovBOzQhEqJUuI3s20ZDLvR7ivisUkegauvY7fKt/npZhdusKEf7E
X-Received: by 2002:a05:6830:211a:b0:7e5:6c74:b295 with SMTP id 46e09a7af769-7f461510ba4mr319181a34.14.1787249443773;
        Thu, 20 Aug 2026 11:10:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.251.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4439d218dsm5300908a34.26.2026.08.20.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:10:43 -0700 (PDT)
Message-Id: <b862a5b4c3a297cf614e8cff2b5e57ec86deb82b.1787249432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 18:10:30 +0000
Subject: [PATCH v14 6/8] history: protect branches when squashing a range
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A local branch that descends from the selected graph without containing
its tip cannot be replayed as a descendant of the squashed commit. Find
those branches with ref-filter before creating any replacement objects
and refuse the operation unless --update-refs=head was requested.

Limit this protection to local branches, matching the refs that the
default history rewrite mode updates; tags and remote-tracking refs
remain untouched. Sort the blocking refs and print their short branch
names so the user can decide whether to move them or leave them behind.

Add advice.historyUpdateRefs for the hint that points to
--update-refs=head.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |  4 ++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/history.c                | 70 ++++++++++++++++++++++++++++++--
 t/t3455-history-squash.sh        | 39 ++++++++++++++++++
 5 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..3d91c90eda 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -59,6 +59,10 @@ all advice messages.
 	forceDeleteBranch::
 		Shown when the user tries to delete a not fully merged
 		branch without the force option set.
+	historyUpdateRefs::
+		Shown when `git history squash` refuses because a local branch
+		cannot be rewritten as a descendant of the squashed commit, to
+		tell the user about `--update-refs=head`.
 	ignoredHook::
 		Shown when a hook is ignored because the hook is not
 		set as executable.
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..401d047391 100644
--- a/advice.c
+++ b/advice.c
@@ -58,6 +58,7 @@ static struct {
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
+	[ADVICE_HISTORY_UPDATE_REFS]			= { "historyUpdateRefs" },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
 	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..3f0b4f0485 100644
--- a/advice.h
+++ b/advice.h
@@ -25,6 +25,7 @@ enum advice_type {
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_FORCE_DELETE_BRANCH,
 	ADVICE_GRAFT_FILE_DEPRECATED,
+	ADVICE_HISTORY_UPDATE_REFS,
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
 	ADVICE_MERGE_CONFLICT,
diff --git a/builtin/history.c b/builtin/history.c
index 6541a397e8..e65b76b59f 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "advice.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -16,10 +17,12 @@
 #include "path.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "ref-filter.h"
 #include "replay.h"
 #include "reset.h"
 #include "revision.h"
 #include "sequencer.h"
+#include "string-list.h"
 #include "strvec.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -1061,6 +1064,7 @@ static int setup_squash_revisions(struct repository *repo,
  * of the oldest commit.
  */
 static int resolve_squash_range(struct repository *repo,
+				bool update_branches,
 				int argc, const char **argv,
 				struct commit **oldest_out,
 				struct commit **tip_out)
@@ -1069,6 +1073,8 @@ static int resolve_squash_range(struct repository *repo,
 	struct commit *commit, *oldest = NULL, *tip = NULL;
 	int ret, tip_count = 0;
 	bool walk_started = false;
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array refs = { 0 };
 
 	ret = setup_squash_revisions(repo, argc, argv, &revs);
 	if (ret < 0)
@@ -1101,9 +1107,12 @@ static int resolve_squash_range(struct repository *repo,
 			 * Allow parents that match the parents of the
 			 * squashed commit.
 			 */
-			for (q = oldest->parents; !seen && q; q = q->next)
-				if (p->item == q->item)
+			for (q = oldest->parents; !seen && q; q = q->next) {
+				if (p->item == q->item) {
 					seen = true;
+					commit_list_insert(commit, &filter.with_commit);
+				}
+			}
 			if (!seen) {
 				ret = error(_("parent %s of commit %s is "
 					      "outside the revision range"),
@@ -1119,12 +1128,17 @@ static int resolve_squash_range(struct repository *repo,
 				o->flags &= ~SQUASH_TIP;
 			}
 		}
-		if (!oldest)
+		if (!oldest) {
+			commit_list_insert(commit, &filter.with_commit);
 			oldest = commit;
+		}
 		tip = commit;
 		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
 		tip_count++;
 	}
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	reset_revision_walk();
+	walk_started = false;
 
 	if (!tip_count) {
 		ret = error(_("the revision range is empty"));
@@ -1141,6 +1155,49 @@ static int resolve_squash_range(struct repository *repo,
 		BUG("an in-range commit must have a parent");
 	}
 
+	commit_list_insert(tip, &filter.no_commit);
+	filter.kind = FILTER_REFS_BRANCHES;
+	if (update_branches &&
+	    filter_refs(&refs, &filter, filter.kind)) {
+		ret = error(_("could not filter refs"));
+		goto out;
+	}
+	if (refs.nr) {
+		struct ref_format format = REF_FORMAT_INIT;
+		struct ref_sorting *sorting;
+		struct string_list sorting_options = STRING_LIST_INIT_DUP;
+		struct strbuf branches = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		format.format = "%(refname:short)";
+		if (verify_ref_format(&format))
+			BUG("invalid branch format");
+		string_list_append(&sorting_options, "refname");
+		sorting = ref_sorting_options(&sorting_options);
+		ref_array_sort(sorting, &refs);
+		for (int i = 0; i < refs.nr; i++) {
+			strbuf_reset(&err);
+			strbuf_addstr(&branches, "\n  ");
+			if (format_ref_array_item(refs.items[i], &format,
+						  &branches, &err))
+				BUG("could not format branch name: %s", err.buf);
+		}
+		/*
+		 * TODO: also check HEADS from other worktrees.
+		 */
+		ret = error(_("the following branches cannot be rewritten as "
+			      "descendants of the squashed commit:%s"), branches.buf);
+		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
+				  _("Use --update-refs=head to rewrite only "
+				    "the current branch and leave such branches "
+				    "untouched."));
+		strbuf_release(&err);
+		strbuf_release(&branches);
+		ref_sorting_release(sorting);
+		string_list_clear(&sorting_options, 0);
+		goto out;
+	}
+
 	*oldest_out = oldest;
 	*tip_out = tip;
 	ret = 0;
@@ -1150,6 +1207,8 @@ out:
 	if (walk_started)
 		reset_revision_walk();
 	release_revisions(&revs);
+	ref_filter_clear(&filter);
+	ref_array_clear(&refs);
 	return ret;
 }
 
@@ -1183,8 +1242,11 @@ static int cmd_history_squash(int argc,
 	if (argc < 2)
 		return error(_("command expects a revision range"));
 	repo_config(repo, git_default_config, NULL);
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
 
-	ret = resolve_squash_range(repo, argc, argv, &oldest, &tip);
+	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
+				   argc, argv, &oldest, &tip);
 	if (ret < 0)
 		return ret;
 
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index df92aa4f6c..b1f65de5f5 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -62,4 +62,43 @@ test_expect_success 'rejects a merge parent outside the range' '
 	test_grep "parent .* of commit .* is outside the revision range" err
 '
 
+test_expect_success 'prints branches that cannot follow the squash' '
+	test_when_finished \
+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
+		 git branch -D feature" &&
+	git checkout -f -b feature start &&
+	test_commit C1 &&
+	test_commit C2 &&
+	git checkout -b topic-1 start &&
+	test_commit C3 &&
+	test_commit C4 &&
+	git checkout C3 &&
+	test_commit C5 &&
+	git checkout feature &&
+	git merge C5 &&
+	test_commit C6 &&
+	git checkout -b topic-2 C2 &&
+	test_commit C7 &&
+	git checkout feature &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "^error: the following branches cannot be rewritten" err &&
+	test_grep "^  topic-1$" err &&
+	test_grep "^  topic-2$" err &&
+	test_grep "^hint: .* --update-refs=head" err
+'
+
+test_expect_success 'advice.historyUpdateRefs silences the hint' '
+	git reset --hard three &&
+	git branch -f mid HEAD~1 &&
+
+	test_must_fail git -c advice.historyUpdateRefs=false \
+		history squash start.. 2>err &&
+	test_grep "^error: the following branches cannot be rewritten" err &&
+	test_grep "^  mid$" err &&
+	test_grep ! "hint:" err &&
+
+	git branch -D mid
+'
+
 test_done
-- 
gitgitgadget

