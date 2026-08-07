Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D33A5445
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088386; cv=none; b=n17RX2scWB1Y4lD6QoWN/aR0MYMPXNd8J2vkeiAGNdZ0R8JokWPaJlqOcPi6aUpgDatNC8GyRrPbmnNMyMGwGZmP8W+0qcMWXMWbcXu+Poa4AT/uFHuT+Qc8JaAunIaeNMp2d3xZKZRrM8qvrk4QzR3EjkbqIcPdxrbVPfVrYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088386; c=relaxed/simple;
	bh=l5YQztks8WiW7dpccr57oQl2L8g9WWcWXwf4ckQb67Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MdBKUr8sVNdAdEzXX3imp1pbYOYdFMV03cp1yIl1mj/rZEhLqIpJB0zmrOaNBNsOe8IfN+wR1vpmbhBKLr7GZY7JcHIRycVV+sRTwZbllUsiByk6yXboEJ66V9tnwvo4kGWO+//R/ebbG1r2A5KBpi+OtuElkbLVAWXutZKpUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx84AxND; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx84AxND"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2613440a91.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088384; x=1786693184; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VLNavmXKSgOiloQ1M4CFiwn8/XfxtgbG3hIbsMDV6uU=;
        b=Kx84AxNDeefPOBD5VzqDr/twAxzdcaFH77O6301Gk3fBlW/6RhQQ3weUpIFlrJqfqz
         naxzifgo88WxYG4iQCsbjNilRuE7RZ1bLECF4IQxGeNI4WR44NWyTFsExEZqpjO9Rxf+
         rINwbMQGhH4TSzZOKp6S+Fb+tOhrVu8vKl35TdcdZW8fnMneIUGnB9fm0oeDbrMRfAYE
         6eShO3U4jh469qRClb3VacLLgkXmCpmv3uY6i8IlDJ3JumnRJWw1+xxBxnw4U9ukYLoU
         D+rG+qQqNVe7Pz34PQZmHabm97GMXzx7go4lP/b+LPHqeHHIXbXWVMz4/PXnaiS1zYf8
         8r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088384; x=1786693184;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLNavmXKSgOiloQ1M4CFiwn8/XfxtgbG3hIbsMDV6uU=;
        b=CBySgEoCrx0M6X24bU7hZ7bucTZJUYi+UQ5B5cuxHg6gTUlQJPE79ijFLZiEGoYVv0
         fIJZh2Da35HWc/ToBCF4mogR/H/NQdtTaj7lqT0rpqyfm8L32lA03xjyDnetvaWRGOPy
         TKj1pHbADj2rE30FpFBDZYGlGqlxTIS+1nKt4ftsatyDVeGAMxYQUptqIshpL+QkavEG
         t9X+fFtmXtKCdyTJ+/h0eSi5v+POwTovhpITRtRTD3nsrtSImHqo/aCIa4+fwlt9F0yl
         8j/lxuS2nxi5yLHgMw+JRAildytSyoEXB4JUMDMfuLvhpugQIHxG/ZlBZOLUlA9z5rcy
         6b6A==
X-Gm-Message-State: AOJu0YyJiXColb2imcrYqgNw3Y8q8mCaTU4tP6y/JJgWkDAifk5cqVQP
	88hPMwdXiYKrL+lq9P0veWEfAs9HFmi/1OTLHZTK5hY8zF0BG1uWqA0ok1LNGjmf
X-Gm-Gg: AR+sD1057cKuq17v49ZNFI08Lj1VzPFMbqdnrZh2EIf6Y6wX5bQ416r1dLqRUMMFNFW
	D8P75ngbFnzU2UDV6T+7mtBP6/YhFmYrnvRfhFF56y36Qg4LN8ibSmUnKJG4ow5kensM3SUeyGg
	1ht6bGqTXfrNvztLZ9hQGUIF4V/1ojeNCnAXrfK6O9XCc8zmxA6Tdr5oY7Xh+IAPPgGI5kdXKvD
	lVVF8X4PJoOKxmuyDzKNj4ULN2i9vjlWPf6YzPhzPxLeYI6qRrB/jXOmHTDkCc98xk5XcIzqtE8
	fvBtJZj6DPSoxO7ysJNZq/onBWbcUw8ywvz4pQGqMwKFKZvxy+cuGT9YlQKzwvJ67U6mY54B8Se
	QkMQTDBh+dqvsv0mjOgT9f/5LQTbbAPOW69NlFJE8g5RazqUK79eUi/N1m0WvT31Dsae5IIOy9Z
	4mRnLCAnF0NUhP8CItBstSkUsxKXkwwiiW5xAH65PyxO6YtnI4oZwwIS/cp5IyvJ0=
X-Received: by 2002:a17:90b:4f91:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-3903ba0745emr18378997a91.0.1786088383540;
        Fri, 07 Aug 2026 00:39:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b136c67bsm747931a91.0.2026.08.07.00.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:42 -0700 (PDT)
Message-Id: <e71a8adfbe7a212d9c2c8a47a30605a4d5f11c1c.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:29 +0000
Subject: [PATCH v13 6/8] history: protect branches when squashing a range
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

