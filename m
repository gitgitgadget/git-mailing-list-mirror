Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB741A776
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348050; cv=none; b=SyahDp8R8nx9cc9f4INh+NcfpuHuqmlLnIrnOov0zV+J5TaRi7Yj45I1y+n/75RUvESbYhw5h2pRgdQkJFF4v1S8kJletvnxGkjD5RIYZ3A3zlps7O8vAGqjAaFVBN6OWz6IAITeQsiVIagFcLNf/uLcW8wW3OKRJH1Hcz4xSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348050; c=relaxed/simple;
	bh=TB6KBrMY4/zXySXb/XiZfqJM9HTuQxFKQbb/yo09Spg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V2LTQntN0gcpQ7LTHYKTTChGtA5y3v70T34rmpzsQsDkRhqkg1iA/g2bR/PzWwpYY+skurAnW8ntJmuLH6XOJOVhFoGuCjUreW0Y9hge+zHFni+YRXTbNdh/lYeB+JivAz3nu3tU58v9rBgutt4PUWfFpU4b+jBzSlb22mbUFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp+HFG+B; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp+HFG+B"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-17bc533fda3so1566318c88.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792348042; x=1792952842; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JZXmfppFHu7QwGteKZpUySPOABAaUItBEkRkguo2HJI=;
        b=Fp+HFG+BLaznQzlo2DnvSIYgp35a+ICWqeHAdZqhWsw08QbFeBhLhJ6fel8opc732+
         WMWjUipetQ83n98Vbdi/xFoEY3biFa0xJciIHuR2oiFinsUL/WoUi+aL/sgl7eijhvtG
         rS6r2XBcWydcz+T6kfX2UtXncFP0grib0fA1QDz2lxCsmI17HLR/w9vl1i3/9rKFOANh
         iAXMIqZUu6JprPBiwUhhN1FM9vDKw6XWn4UYIptgRVG5LQ2KYYmew3Gltx2hpZl7Z2DB
         JbdDFH12+R6us1HLB0+UAiMCl9Qrv2rSfftjPL0I+DwvJJ0vKiH4WIJEjuZbwe64PU97
         D8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792348042; x=1792952842;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZXmfppFHu7QwGteKZpUySPOABAaUItBEkRkguo2HJI=;
        b=lif0BuKjkzqMQChfB36QQANQC5h64SO0535C4zj9T8h3Kg4zFlwzA5s1BqdWPcss3v
         gL1t6qS7wng6ura5WfslsGjM//rHvj6ux+8KFSpxpO2NqlugTIR06/AwLQBXf0Dko/z+
         K4GLZI89nFmU9dbzBuRtrQOcDE5fhDQ/VotD4/Sh1TL47htT616aJIu5P1g8/qcV6qGu
         5VRAg9ybXdp4Mbqvozf/+SbIjndD96knK/v2Euaus3izB5tM7jPihDbJs0B4pGpHsubB
         QLgbWNTkq9+GhO5BB4T4LnK7SI2kRxrCiaO+o6l4VtGUCgBUiSfnVUHssOsbAKlr/yuq
         6tEg==
X-Gm-Message-State: AFq9FYIbp4SCaDZ2hMvGoOl1DvHiUVmALoR+7T4GXWTykdyRnraQ5Uo5
	e72281MhCQawiBWzjE7NBxaaStb+feZC2zffvGhtLrn0cg8agzF2Fj0nb7kDKtHW
X-Gm-Gg: AYBFou24lS7J+delbLZkg0T2NBsndZPymN+E0VMDV5IlmDpBWBDy9KqsSS9FU6WLWOb
	sKV5lIVx59ESapnXS5o5beqeunXZQpuRtqnzYFPfwL5z1vqCkuMq25nz1I9XYF6HnMHxPj0aJJH
	ZPv95dDWp3sEbdxa0eb2qrDp5RRgojPkwjSlpz7v1dOnjoNz/ZDEeY//D2L7yCU4DVKYjvqfDCQ
	zync171kQoX6cy0FU0bgI1Nu+E65PK6GfTP4rWGVi91kSAUv5Jl5xD1GDHxFke4f1J8fU/lQzYA
	Opvu+j1IUVPAESWTXjcoPPUWv2gQ2L697pmRzz0ztV9bU3tZBxB4mj2vD9gKt/9EceRzQt3ukrz
	GGQeXzC5v2Um9eG0duxhTxacDbKNXrTvYKyQvVkfX94q64aOtJlw3ST0Pz+FT2MORzHgeqXkWog
	nIyUL9UWZt3u1uZRo6Ho1k8+UERh2UHN3YeuiTDPtCq2uxB2cl5pvDcW0pKQgqNPkwHn8IGRBIL
	hOPI8yc6mjR
X-Received: by 2002:a05:701b:2059:20b0:144:fa57:c617 with SMTP id a92af1059eb24-18513e7b77fmr8665374c88.34.1792348042391;
        Sun, 18 Oct 2026 11:27:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.179.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-185aaea8b24sm15671099c88.19.2026.10.18.11.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 11:27:21 -0700 (PDT)
Message-Id: <1c47ba225e221a35e4df3057dbf47cea37a83fe5.1792348037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 18:27:16 +0000
Subject: [PATCH v2 2/3] reflog: add --operations to show one entry per command
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After a rebase, "git reflog" shows one entry for every commit the
rebase replayed, plus one for its start and one for its end. Together
with an entry for every branch switch, finding where a branch was
before the rebase means reading past all of them.

Teach "git reflog" and "git log -g" an "--operations" option that
shows each rebase as the single entry that finished or aborted it, and
leaves out entries that change no branch, like branch switches and the
"reset: moving to HEAD" that "git stash" and "git merge --abort" leave
behind:

  $ git reflog --operations
  4e5f6a7 HEAD@{0}: rebase (finish): returning to refs/heads/topic
  8c9d0e1 HEAD@{5}: commit: fix typo
  1a2b3c4 HEAD@{7}: commit: add tests

The HEAD@{<n>} numbers keep their usual values, so the previous entry
on the same branch can be used to undo the rebase:

  $ git reset --hard HEAD@{7}

Commands run while a rebase is stopped, such as an amend after an
"edit", are folded into that rebase, and a "git pull --rebase" is shown
as one entry the same way.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-reflog.adoc       |   3 +
 Documentation/rev-list-options.adoc |  11 +++
 reflog-walk.c                       |  61 +++++++++++++++-
 reflog-walk.h                       |   1 +
 revision.c                          |   8 +++
 revision.h                          |   1 +
 t/t1414-reflog-walk.sh              | 105 ++++++++++++++++++++++++++++
 7 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 38af0c977a..672b9ea72e 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -41,6 +41,9 @@ command-line (or `HEAD`, by default). The reflog covers all recent
 actions, and in addition the `HEAD` reflog records branch switching.
 `git reflog show` is an alias for `git log -g --abbrev-commit
 --pretty=oneline`; see linkgit:git-log[1] for more information.
+With `--operations`, branch switches and other entries that change no
+branch are left out, and a rebase is shown as a single entry instead
+of one entry for each commit it replayed.
 
 The "list" subcommand lists all refs which have a corresponding reflog.
 
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index bd9f345690..a40ba2641b 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -348,6 +348,17 @@ See also linkgit:git-reflog[1].
 +
 Under `--pretty=reference`, this information will not be shown at all.
 
+`--operations`::
+	Show one reflog entry for each command that changed a branch.
+	A rebase is shown as only the entry that finished or aborted it,
+	including any commands run while it was stopped, such as
+	`git commit --amend`. Switching branches is not shown, and
+	neither is a reset that left `HEAD` where it was, such as the one
+	`git stash` does.
+	The previous entry on the same branch is the state before the
+	rebase started. It is an error to use this option unless
+	`--walk-reflogs` is in use.
+
 `--merge`::
 	Show commits touching conflicted paths in the range `HEAD...<other>`,
 	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
diff --git a/reflog-walk.c b/reflog-walk.c
index 4dbeaa93a7..82528f5b66 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "commit.h"
 #include "refs.h"
+#include "reflog.h"
 #include "diff.h"
 #include "repository.h"
 #include "revision.h"
@@ -18,6 +19,7 @@ struct complete_reflogs {
 		timestamp_t timestamp;
 		int tz;
 		char *message;
+		bool user_operation;
 	} *items;
 	int nr, alloc;
 };
@@ -38,6 +40,7 @@ static int read_one_reflog(const char *refname UNUSED,
 	item->timestamp = timestamp;
 	item->tz = tz;
 	item->message = xstrdup(message);
+	item->user_operation = true;
 	array->nr++;
 	return 0;
 }
@@ -65,6 +68,46 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
 	free_complete_reflog(array);
 }
 
+static bool has_rebase_step(const char *message, const char *step)
+{
+	size_t end = strcspn(message, ":\n");
+	size_t len = strlen(step);
+
+	return end >= len + 3 && message[end - 1] == ')' &&
+	       !strncmp(message + end - len - 3, " (", 2) &&
+	       !strncmp(message + end - len - 1, step, len);
+}
+
+static void mark_operations(struct complete_reflogs *array)
+{
+	int start = -1;
+
+	for (int i = 0; i < array->nr; i++) {
+		struct reflog_info *item = &array->items[i];
+		const char *msg = item->message;
+
+		if (has_rebase_step(msg, REFLOG_STEP_FINISH) ||
+		    has_rebase_step(msg, REFLOG_STEP_ABORT)) {
+			if (start >= 0)
+				for (int j = start; j < i; j++)
+					array->items[j].user_operation = false;
+			start = -1;
+			item->user_operation = true;
+			continue;
+		}
+		if (has_rebase_step(msg, REFLOG_STEP_START))
+			start = i;
+
+		if (starts_with(msg, REFLOG_SWITCH_PREFIX))
+			item->user_operation = false;
+		else if (starts_with(msg, REFLOG_RENAME_PREFIX))
+			item->user_operation = true;
+		else
+			item->user_operation =
+				!oideq(&item->ooid, &item->noid);
+	}
+}
+
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
@@ -135,6 +178,16 @@ void init_reflog_walk(struct reflog_walk_info **info)
 	(*info)->complete_reflogs.strdup_strings = 1;
 }
 
+void reflog_walk_mark(struct reflog_walk_info *info, bool operations)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &info->complete_reflogs) {
+		if (operations)
+			mark_operations(item->util);
+	}
+}
+
 void reflog_walk_info_release(struct reflog_walk_info *info)
 {
 	size_t i;
@@ -342,8 +395,12 @@ static struct commit *next_reflog_commit(struct commit_reflog *log)
 {
 	for (; log->recno >= 0; log->recno--) {
 		struct reflog_info *entry = &log->reflogs->items[log->recno];
-		struct object *obj = parse_object(the_repository,
-						  &entry->noid);
+		struct object *obj;
+
+		if (!entry->user_operation)
+			continue;
+
+		obj = parse_object(the_repository, &entry->noid);
 
 		if (obj && obj->type == OBJ_COMMIT)
 			return (struct commit *)obj;
diff --git a/reflog-walk.h b/reflog-walk.h
index 989583dc55..1d86795f84 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -7,6 +7,7 @@ struct date_mode;
 
 void init_reflog_walk(struct reflog_walk_info **info);
 void reflog_walk_info_release(struct reflog_walk_info *info);
+void reflog_walk_mark(struct reflog_walk_info *info, bool operations);
 int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct commit *commit, const char *name);
 void show_reflog_message(struct reflog_walk_info *info, int,
diff --git a/revision.c b/revision.c
index a83e499047..88785651fe 100644
--- a/revision.c
+++ b/revision.c
@@ -2458,6 +2458,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		commit_list_insert(c, &revs->ancestry_path_bottoms);
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
 		init_reflog_walk(&revs->reflog_info);
+	} else if (!strcmp(arg, "--operations")) {
+		revs->reflog_operations = 1;
 	} else if (!strcmp(arg, "--default")) {
 		if (argc <= 1)
 			return error("bad --default argument");
@@ -3247,6 +3249,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
+	if (!revs->reflog_info && revs->reflog_operations)
+		die(_("the option '%s' requires '%s'"), "--operations", "--walk-reflogs");
+
+	if (revs->reflog_info)
+		reflog_walk_mark(revs->reflog_info, revs->reflog_operations);
+
 	if (revs->line_level_traverse &&
 	    (revs->full_diff ||
 	     (revs->diffopt.output_format &
diff --git a/revision.h b/revision.h
index e5dabd18ce..c4f5e06698 100644
--- a/revision.h
+++ b/revision.h
@@ -221,6 +221,7 @@ struct rev_info {
 			exclude_first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			reflog_operations:1,
 
 			/*
 			 * Blobs are shown without regard for their existence.
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index be6c3f472c..e15f6f2381 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'set up some reflog entries' '
 	test_commit one &&
@@ -131,6 +132,110 @@ test_expect_success 'walk prefers reflog to ref tip' '
 	test_cmp expect actual
 '
 
+test_expect_success '--operations shows a rebase as one entry' '
+	git init operations &&
+	(
+		cd operations &&
+		test_commit base &&
+		git switch -c topic &&
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+		git switch main &&
+		test_commit upstream &&
+		git switch topic &&
+		git rebase main &&
+
+		cat >expect <<-\EOF &&
+		HEAD@{0} rebase (finish): returning to refs/heads/topic
+		HEAD@{6} commit: upstream
+		HEAD@{8} commit: C
+		HEAD@{9} commit: B
+		HEAD@{10} commit: A
+		HEAD@{12} commit (initial): base
+		EOF
+		git log -g --format="%gd %gs" HEAD --operations >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--operations shows a stopped rebase as one entry once it finishes' '
+	set_fake_editor &&
+	(
+		cd operations &&
+		FAKE_LINES="edit 1 2" git rebase -i HEAD~2 &&
+
+		cat >expect <<-\EOF &&
+		HEAD@{0} rebase: fast-forward
+		HEAD@{1} rebase (start): checkout HEAD~2
+		EOF
+		git log -g --operations --format="%gd %gs" -2 >actual &&
+		test_cmp expect actual &&
+
+		git commit --amend -m "B amended" &&
+		git rebase --continue &&
+
+		cat >expect <<-\EOF &&
+		HEAD@{0} rebase (finish): returning to refs/heads/topic
+		HEAD@{5} rebase (finish): returning to refs/heads/topic
+		EOF
+		git log -g --operations --format="%gd %gs" -2 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--operations shows an aborted rebase as one entry' '
+	(
+		cd operations &&
+		FAKE_LINES="edit 1 2" git rebase -i HEAD~2 &&
+		git rebase --abort &&
+
+		cat >expect <<-\EOF &&
+		HEAD@{0} rebase (abort): returning to refs/heads/topic
+		HEAD@{3} rebase (finish): returning to refs/heads/topic
+		EOF
+		git log -g --operations --format="%gd %gs" -2 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--operations leaves out the reset done by git stash' '
+	(
+		cd operations &&
+		echo change >>C.t &&
+		git stash &&
+
+		echo "HEAD@{1} rebase (abort): returning to refs/heads/topic" >expect &&
+		git log -g --operations --format="%gd %gs" -1 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--operations shows a pull --rebase as one entry' '
+	git clone operations downstream &&
+	(
+		cd operations &&
+		test_commit upstream-change
+	) &&
+	(
+		cd downstream &&
+		test_commit local-change &&
+		git pull --rebase &&
+
+		cat >expect <<-\EOF &&
+		HEAD@{0} pull --rebase (finish): returning to refs/heads/topic
+		HEAD@{3} commit: local-change
+		EOF
+		git log -g --operations --format="%gd %gs" -2 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--operations requires --walk-reflogs' '
+	test_must_fail git log --operations 2>err &&
+	test_grep "requires .--walk-reflogs." err
+'
+
 test_expect_success 'rev-list -g complains when there are no reflogs' '
 	test_must_fail git rev-list -g
 '
-- 
gitgitgadget

