Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CF3B95F8
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900129; cv=none; b=b4xsx2i6cnB8VhgPhEkbQq+6TNhW/HRToEZbYSKQkBY9EOAkoNaRp+v0OJpvSFGLX8qeXqsMUdTEbRgidpsWW1KVjqSjK2plIyJdhjQXqpTSfwe3CiSj7RpWR048EhADRT/mJ/pm5SoHDGn7EwzQiL9pqRq93y2oGYT3cBF3un4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900129; c=relaxed/simple;
	bh=K37Vy3t2IcBlDOqRvBTHvVVfz7ixNR9aea5J6g0XJNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jbtOh89cJSgBqlEXLWGQkn6BWClbuuaoGyvMYvvB3Aw6bu3lqbT4u0jsqYIH8EcuVPYZGI68OkBHUrFbssD+JAA21D03mXE4k1jIiBYIxl7kvy2rUSmJtoF4iorSszUmLIHGL76tkkCU1RiZToyFi5oXPRoaQ7wmNM8n+zL9oVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjCSAhb/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjCSAhb/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9399d91ee7aso334888485a.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900127; x=1789504927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=plT7pxYJHGOqrG839OkKJFRqWO7V8v5l+sB9dyVMuuI=;
        b=cjCSAhb/J9LrKZi9WbuujuVvlbDN0AM2GEYr/0jHOMhykas6CO4WNuMIlU7eYVuvvE
         Q//KRAvliYnnm+GBNZEX6SjMzQi6N7Rs12OHfiPigWosGJC70+kIOdjKry3iFBe/90SK
         hFgQVEa/qM5hXVSq2XTNBVitexDFcOwsEGVjpsfmlvsINIz7Fc2gK7Xo06LGJ2oeH7Qy
         LQNW3UJJ7+sNqXY552vMGXhz22VQ3MR3JuM0kl2bz7Dl3Hc5p6lZfPIHR/nolb0HraZs
         KEUc6rOQYa0AHPiLxPwRBYCSOv5S5ZBlz8fyiIuss93n4drtIhvM8eCS4OdusXSpqcy/
         mcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900127; x=1789504927;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plT7pxYJHGOqrG839OkKJFRqWO7V8v5l+sB9dyVMuuI=;
        b=FbeeD8wxUGj/6JAVuAHd4dOoqyuRz6/AvmCweX3d3Ma+FB2GocLgBPPZ+oFhEEAZiX
         9i7um15guRuMsNDwUdJA23Xyh+mMAy7Ua49lVqMnVthxFIE/0fpEvaLGIU8k3MDHVIjU
         FBvm/6+jgU7u8+jIE7mJkbFpwS5Zusb7p8ur+ji0xoo2/rTnKUiB5on974Do5yZHLE7T
         U4BlONMA8hP9UgtMXK/+zei1cu9lcSYGWuY1c2n+r8WblUM1e65/U8vjQVGYhEjymcS6
         6p5mZgVDsQCeJBukchKQyFKEN5MZxegPcniEm7eeOlYKWzM+7vjT0BxGhqyRJsUTHwHm
         znZA==
X-Gm-Message-State: AFuF++niDC3ann41svh6eiT/q+b+ivnoF9LaMi/TtnM1ayG4uXuWtvke
	EdlqNMA6OkGENKz8FyNTDOd4FKQl6K4W9PUJHHhYkbEb60AXLwu3A3+ao8lB/Ei7
X-Gm-Gg: AYBFou11/EogEA2lxbupoyluGq/gyyG84hNp70kNpLPH03p6+nZ4kQ7gacD8ZmEKSEq
	qYSFEhasym0dSKZZm1UD9PcdkLZW1wxB4zLd0TWcw+upmvhm4tgj0Yb4uFVrAwDd5lHr/GUROuB
	39J167WjVjsxY5Q5sLbPshGayVCztelR2dOnULjBKr1uX1Vqy8RPbiOw8Z6hX1scx9fTrwGzILg
	alIc3XxYZ2Z1LJjfz3+2BLYdF6ob/0au1Jkg3ukRWa6NbQk4QUFPs06F97NXsoWsGCepQ2TppuK
	XWlvYdADRV2zoMmLRTCIM8GvncrQAjog3qGqcEaSxBY2lgZOn1TYkadXcrwoepsfez2UkIYStHr
	iYxB+pTcBtu8GTXkMSZC7tqcnTXf3Q2OZllAqcLAyksZXXbhgrx0WwKpFG4EyuHOCbiyKze0kZS
	KS5DxsQeP+Hd8heARbZolSEg5Ug0nva/ZN/2/U3IoFtN6ln+YF1ebTnovuDUWuIP+kZA==
X-Received: by 2002:a05:620a:618e:b0:934:946d:599d with SMTP id af79cd13be357-939806dc5c8mr3401854485a.33.1788900127188;
        Tue, 08 Sep 2026 13:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939af600829sm506115185a.2.2026.09.08.13.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:06 -0700 (PDT)
Message-Id: <4d30ff193697145e45692bc0fd022da43c76b868.1788900120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:57 +0000
Subject: [PATCH v15 6/8] history: protect branches when squashing a range
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

