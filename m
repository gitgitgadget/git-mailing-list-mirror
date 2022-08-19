Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA0C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiHSE22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345847AbiHSE2V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:28:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C4101C5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so3841439wrq.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=geYARWAojJw7qqZ0DDWJ23cKvLp2sYEmy1q9sFy7Nws=;
        b=l5Q2ol3jRUjdsoozTzZBVibOI9YNRYi0yy9hEHjVXJlePAi9+vFFMK84VFhMaaK9Tg
         AJ7MIkn/vlfgkNykppipRURhgQLH9QZjKv/q4paGNPjzlZ5tBx9+ThV7714K1Uk6d0Qu
         8IL7dpFLlbUoCN+8zzxYUvQEg9Bmz85/eygwJEyfzKH7Nr5dCnLnkWuISat3Cc9Kau3C
         A/Jg+xzBCl+1S9IlixiL9IvmWkASxlAZ6sWBdDGNo8zppjbDpQE2glCpYSlC/j7wozzU
         ta1Z2ES4nRbzzpdj92itt50zIjpJ9LBYwbx/V/mIeMNFB8Q/kE8B52UlpqkLhQoF6Yp/
         OUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=geYARWAojJw7qqZ0DDWJ23cKvLp2sYEmy1q9sFy7Nws=;
        b=ujDTMzkH6BIMX1zfc2rwfmbK7FXvFOV8+NdroDI39YXUHuqWGt+n6L4Q5J1sfLCgQP
         yV9F8WpUzHtYVvJ2Dmx6xoAWuHq+21NxQezB8svJZbXFYjFiXiR9myItphWIn97SE0zU
         3RG+QU0cH5ekFGvmBtGq1CMQ9Z8sw1Hio97H6B6J69DDx/Vk7vATXv2FdfrBmKMhyrdh
         vlmcIGuAb/zozaxSxGJIki7Xt0tGktsMQgSKZoTK0I5iAS3VpPDULb/meyLuO8vpLR/L
         fVBQ6+mHe5N3a5eFwUUgyhcux3wDkkGmdFvfOJZ3ZusWlg034VfpabugIioeb61nmna/
         sB2g==
X-Gm-Message-State: ACgBeo0oD12wgjAMv6A2IJHDmMDeFicuD67CuU2CyVEU4wSuh+qV0u1M
        W6DKCt9wBnz0neZgiZd58xfb8gxcu18=
X-Google-Smtp-Source: AA6agR6IfMrjVfELTqo5556zS9tvW+qc68H3S0um/TaXZsFwOR2FWPBm1kQTEt+HJBJNRVunxMYHlA==
X-Received: by 2002:a5d:4204:0:b0:225:382f:a8be with SMTP id n4-20020a5d4204000000b00225382fa8bemr763021wrq.379.1660883296008;
        Thu, 18 Aug 2022 21:28:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003a5de95b105sm7349514wme.41.2022.08.18.21.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 21:28:15 -0700 (PDT)
Message-Id: <b810b3c8a2a7a9d121fc7c0438b4e4f3679557da.1660883290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
        <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 04:28:10 +0000
Subject: [PATCH v3 3/3] revision: allow --ancestry-path to take an argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We have long allowed users to run e.g.
    git log --ancestry-path master..seen
which shows all commits which satisfy all three of these criteria:
  * are an ancestor of seen
  * are not an ancestor of master
  * have master as an ancestor

This commit allows another variant:
    git log --ancestry-path=$TOPIC master..seen
which shows all commits which satisfy all of these criteria:
  * are an ancestor of seen
  * are not an ancestor of master
  * have $TOPIC in their ancestry-path
that last bullet can be defined as commits meeting any of these
criteria:
    * are an ancestor of $TOPIC
    * have $TOPIC as an ancestor
    * are $TOPIC

This also allows multiple --ancestry-path arguments, which can be
used to find commits with any of the given topics in their ancestry
path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/rev-list-options.txt | 44 +++++++++++----
 object.h                           |  2 +-
 revision.c                         | 89 ++++++++++++++++++++----------
 revision.h                         |  9 +++
 t/t6019-rev-list-ancestry-path.sh  | 14 ++++-
 5 files changed, 115 insertions(+), 43 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2f85726745a..aed486dc309 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -389,12 +389,14 @@ Default mode::
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.
 
---ancestry-path::
+--ancestry-path[=<commit>]::
 	When given a range of commits to display (e.g. 'commit1..commit2'
-	or 'commit2 {caret}commit1'), only display commits that exist
-	directly on the ancestry chain between the 'commit1' and
-	'commit2', i.e. commits that are both descendants of 'commit1',
-	and ancestors of 'commit2'.
+	or 'commit2 {caret}commit1'), only display commits in that range
+	that are ancestors of <commit>, descendants of <commit>, or
+	<commit> itself.  If no commit is specified, use 'commit1' (the
+	excluded part of the range) as <commit>.  Can be passed multiple
+	times; if so, a commit is included if it is any of the commits
+	given or if it is an ancestor or descendant of one of them.
 
 A more detailed explanation follows.
 
@@ -568,11 +570,10 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
 
 There is another simplification mode available:
 
---ancestry-path::
-	Limit the displayed commits to those directly on the ancestry
-	chain between the ``from'' and ``to'' commits in the given commit
-	range. I.e. only display commits that are ancestor of the ``to''
-	commit and descendants of the ``from'' commit.
+--ancestry-path[=<commit>]::
+	Limit the displayed commits to those which are an ancestor of
+	<commit>, or which are a descendant of <commit>, or are <commit>
+	itself.
 +
 As an example use case, consider the following commit history:
 +
@@ -604,6 +605,29 @@ option does. Applied to the 'D..M' range, it results in:
 			       \
 				L--M
 -----------------------------------------------------------------------
++
+We can also use `--ancestry-path=D` instead of `--ancestry-path` which
+means the same thing when applied to the 'D..M' range but is just more
+explicit.
++
+If we instead are interested in a given topic within this range, and all
+commits affected by that topic, we may only want to view the subset of
+`D..M` which contain that topic in their ancestry path.  So, using
+`--ancestry-path=H D..M` for example would result in:
++
+-----------------------------------------------------------------------
+		E
+		 \
+		  G---H---I---J
+			       \
+				L--M
+-----------------------------------------------------------------------
++
+Whereas `--ancestry-path=K D..M` would result in
++
+-----------------------------------------------------------------------
+		K---------------L--M
+-----------------------------------------------------------------------
 
 Before discussing another option, `--show-pulls`, we need to
 create a new example history.
diff --git a/object.h b/object.h
index a2219464c2b..9caef89f1f0 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------26
+ * revision.h:               0---------10         15             23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
diff --git a/revision.c b/revision.c
index 0c6e26cd9c8..19d76da235c 100644
--- a/revision.c
+++ b/revision.c
@@ -1105,7 +1105,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			   struct commit_list **list, struct prio_queue *queue)
 {
 	struct commit_list *parent = commit->parents;
-	unsigned left_flag;
+	unsigned pass_flags;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -1160,7 +1160,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	if (revs->no_walk)
 		return 0;
 
-	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
+	pass_flags = (commit->object.flags & (SYMMETRIC_LEFT | ANCESTRY_PATH));
 
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
@@ -1181,7 +1181,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (!*slot)
 				*slot = *revision_sources_at(revs->sources, commit);
 		}
-		p->object.flags |= left_flag;
+		p->object.flags |= pass_flags;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
@@ -1304,13 +1304,24 @@ static int still_interesting(struct commit_list *src, timestamp_t date, int slop
 }
 
 /*
- * "rev-list --ancestry-path A..B" computes commits that are ancestors
- * of B but not ancestors of A but further limits the result to those
- * that are descendants of A.  This takes the list of bottom commits and
- * the result of "A..B" without --ancestry-path, and limits the latter
- * further to the ones that can reach one of the commits in "bottom".
+ * "rev-list --ancestry-path=C_0 [--ancestry-path=C_1 ...] A..B"
+ * computes commits that are ancestors of B but not ancestors of A but
+ * further limits the result to those that have any of C in their
+ * ancestry path (i.e. are either ancestors of any of C, descendants
+ * of any of C, or are any of C). If --ancestry-path is specified with
+ * no commit, we use all bottom commits for C.
+ *
+ * Before this function is called, ancestors of C will have already
+ * been marked with ANCESTRY_PATH previously.
+ *
+ * This takes the list of bottom commits and the result of "A..B"
+ * without --ancestry-path, and limits the latter further to the ones
+ * that have any of C in their ancestry path. Since the ancestors of C
+ * have already been marked (a prerequisite of this function), we just
+ * need to mark the descendants, then exclude any commit that does not
+ * have any of these marks.
  */
-static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
+static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)
 {
 	struct commit_list *p;
 	struct commit_list *rlist = NULL;
@@ -1323,7 +1334,7 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
 	for (p = list; p; p = p->next)
 		commit_list_insert(p->item, &rlist);
 
-	for (p = bottom; p; p = p->next)
+	for (p = bottoms; p; p = p->next)
 		p->item->object.flags |= TMP_MARK;
 
 	/*
@@ -1356,38 +1367,39 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
 	 */
 
 	/*
-	 * The ones that are not marked with TMP_MARK are uninteresting
+	 * The ones that are not marked with either TMP_MARK or
+	 * ANCESTRY_PATH are uninteresting
 	 */
 	for (p = list; p; p = p->next) {
 		struct commit *c = p->item;
-		if (c->object.flags & TMP_MARK)
+		if (c->object.flags & (TMP_MARK | ANCESTRY_PATH))
 			continue;
 		c->object.flags |= UNINTERESTING;
 	}
 
-	/* We are done with the TMP_MARK */
+	/* We are done with TMP_MARK and ANCESTRY_PATH */
 	for (p = list; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
-	for (p = bottom; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
+		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
+	for (p = bottoms; p; p = p->next)
+		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
 	free_commit_list(rlist);
 }
 
 /*
- * Before walking the history, keep the set of "negative" refs the
- * caller has asked to exclude.
+ * Before walking the history, add the set of "negative" refs the
+ * caller has asked to exclude to the bottom list.
  *
  * This is used to compute "rev-list --ancestry-path A..B", as we need
  * to filter the result of "A..B" further to the ones that can actually
  * reach A.
  */
-static struct commit_list *collect_bottom_commits(struct commit_list *list)
+static void collect_bottom_commits(struct commit_list *list,
+				   struct commit_list **bottom)
 {
-	struct commit_list *elem, *bottom = NULL;
+	struct commit_list *elem;
 	for (elem = list; elem; elem = elem->next)
 		if (elem->item->object.flags & BOTTOM)
-			commit_list_insert(elem->item, &bottom);
-	return bottom;
+			commit_list_insert(elem->item, bottom);
 }
 
 /* Assumes either left_only or right_only is set */
@@ -1414,12 +1426,12 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *original_list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
-	struct commit_list *bottom = NULL;
 	struct commit *interesting_cache = NULL;
 
-	if (revs->ancestry_path) {
-		bottom = collect_bottom_commits(original_list);
-		if (!bottom)
+	if (revs->ancestry_path_implicit_bottoms) {
+		collect_bottom_commits(original_list,
+				       &revs->ancestry_path_bottoms);
+		if (!revs->ancestry_path_bottoms)
 			die("--ancestry-path given but there are no bottom commits");
 	}
 
@@ -1464,9 +1476,8 @@ static int limit_list(struct rev_info *revs)
 	if (revs->left_only || revs->right_only)
 		limit_left_right(newlist, revs);
 
-	if (bottom)
-		limit_to_ancestry(bottom, newlist);
-	free_commit_list(bottom);
+	if (revs->ancestry_path)
+		limit_to_ancestry(revs->ancestry_path_bottoms, newlist);
 
 	/*
 	 * Check if any commits have become TREESAME by some of their parents
@@ -2213,7 +2224,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			       const struct setup_revision_opt* opt)
 {
 	const char *arg = argv[0];
-	const char *optarg;
+	const char *optarg = NULL;
 	int argcount;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
@@ -2284,6 +2295,23 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
 		revs->limited = 1;
+		revs->ancestry_path_implicit_bottoms = 1;
+	} else if (skip_prefix(arg, "--ancestry-path=", &optarg)) {
+		struct commit *c;
+		struct object_id oid;
+		const char *msg = _("could not get commit for ancestry-path argument %s");
+
+		revs->ancestry_path = 1;
+		revs->simplify_history = 0;
+		revs->limited = 1;
+
+		if (repo_get_oid_committish(revs->repo, optarg, &oid))
+			return error(msg, optarg);
+		get_reference(revs, optarg, &oid, ANCESTRY_PATH);
+		c = lookup_commit_reference(revs->repo, &oid);
+		if (!c)
+			return error(msg, optarg);
+		commit_list_insert(c, &revs->ancestry_path_bottoms);
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
 		init_reflog_walk(&revs->reflog_info);
 	} else if (!strcmp(arg, "--default")) {
@@ -2991,6 +3019,7 @@ static void release_revisions_topo_walk_info(struct topo_walk_info *info);
 void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
+	free_commit_list(revs->ancestry_path_bottoms);
 	object_array_clear(&revs->pending);
 	object_array_clear(&revs->boundary_commits);
 	release_revisions_cmdline(&revs->cmdline);
diff --git a/revision.h b/revision.h
index e576845cdd1..a10520300ce 100644
--- a/revision.h
+++ b/revision.h
@@ -48,6 +48,7 @@
  */
 #define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
+#define ANCESTRY_PATH	(1u<<27)
 #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
 
 #define DECORATE_SHORT_REFS	1
@@ -164,6 +165,13 @@ struct rev_info {
 			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
+
+			/* True if --ancestry-path was specified without an
+			 * argument. The bottom revisions are implicitly
+			 * the arguments in this case.
+			 */
+			ancestry_path_implicit_bottoms:1,
+
 			first_parent_only:1,
 			exclude_first_parent_only:1,
 			line_level_traverse:1,
@@ -306,6 +314,7 @@ struct rev_info {
 	struct saved_parents *saved_parents_slab;
 
 	struct commit_list *previous_parents;
+	struct commit_list *ancestry_path_bottoms;
 	const char *break_bar;
 
 	struct revision_sources *sources;
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 5bd787a3c0a..738da23628b 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -8,8 +8,13 @@ test_description='--ancestry-path'
 #   /                     \
 #  A-------K---------------L--M
 #
-#  D..M                 == E F G H I J K L M
-#  --ancestry-path D..M == E F H I J L M
+#  D..M                                     == E F G H I J K L M
+#  --ancestry-path                     D..M == E F   H I J   L M
+#  --ancestry-path=F                   D..M == E F       J   L M
+#  --ancestry-path=G                   D..M ==     G H I J   L M
+#  --ancestry-path=H                   D..M == E   G H I J   L M
+#  --ancestry-path=K                   D..M ==             K L M
+#  --ancestry-path=K --ancestry-path=F D..M == E F       J K L M
 #
 #  D..M -- M.t                 == M
 #  --ancestry-path D..M -- M.t == M
@@ -70,6 +75,11 @@ test_ancestry () {
 test_ancestry "D..M" "E F G H I J K L M"
 
 test_ancestry "--ancestry-path D..M" "E F H I J L M"
+test_ancestry "--ancestry-path=F D..M" "E F J L M"
+test_ancestry "--ancestry-path=G D..M" "G H I J L M"
+test_ancestry "--ancestry-path=H D..M" "E G H I J L M"
+test_ancestry "--ancestry-path=K D..M" "K L M"
+test_ancestry "--ancestry-path=F --ancestry-path=K D..M" "E F J K L M"
 
 test_ancestry "D..M -- M.t" "M"
 test_ancestry "--ancestry-path D..M -- M.t" "M"
-- 
gitgitgadget
