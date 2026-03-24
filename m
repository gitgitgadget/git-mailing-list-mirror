Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794723B612
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389861; cv=none; b=UFV8mDghwp79HHLqe5KNX0cqSRaJ8sRXAPLyURojNqGDn9vH/dyhK1lCGy3Q7BQUt7IiI0guMzJ7o+/eyRG+IyWAzhqGcPazA/U+CkE7w+IukdgYTXMiy51tnNRgM1RA62+nypv5HnCkO+Oy71ryda466lyNe8FTu3OimvFE5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389861; c=relaxed/simple;
	bh=/F1PVvG1ro3+YLafc5suLrTNOKkfgHnIzM3Z9OYwH1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heOiB9fYl3buHmGk4Wz8VvEiS3BF6CXoZQdPYyf/ZFN+KDNVDwrnj95aR6hcRt4Wlz8cw/g3RfWNrToXEDyNFFtnD/trDFsHd/qBkkC5K8+rRsqhK5zXKO5h9SQGLdS2zm1l0/dpxO3NCSJL/ON0dgg+D+0P+Zv70eH4s6q/7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GanHxOd3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GanHxOd3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso2911476b3a.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389859; x=1774994659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdWFtga3xXbWni+CpXzFSMWBABSG0YeoWabhpNq1Sdc=;
        b=GanHxOd3/e8gkveHL7x+8Mj9xhkwYdY4F8L8JFHfelYnD8SUQo25BnbjPuBpIDBhbC
         KSiM/Ug0Xv4DdMea8tAW27Yp5UcODJVbQv1E5Gd3PKGemm4quGkUMlmnugYR6V6USewG
         Oh9+5PvAVwRfJxQsyRiYF+A9CwJW6j8Fbvtn2HPD2Mn2KGDDxm5+anUJZNfFiXYoFHvH
         ZmS61VFWkPzpiMU68JX4JPYYrMQYdXp9RBnwbP0lgPmMeCdJPyz4LOrPq7Z4sbEnQaEX
         ySCs86yVZsc4J1E+j7cWWPZgMf9RLGje2ozu6nvImbguJhDi1g2krXoRHHoqiwama5KE
         GJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389859; x=1774994659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdWFtga3xXbWni+CpXzFSMWBABSG0YeoWabhpNq1Sdc=;
        b=kcl85IpABfQVYBek1fb608BzmKzRlts6y3mL+yhgVnv84O5IG4JyPQbseLzIjQI9GK
         dfFrVnKl3df8CPaePWqVJycbat0vb9nYXfQAfI9ffZJPhcaw82//8EPPywjbbnXcNviz
         95DGG9+fCXgBu43H1cGTs5IKjLOfVhR4YA/Vd/oM3RS798A4v+CM67FStb2M1u61DIYO
         P99ooilg+YMWHNTfJI3T5Bs8R/n6yTrzMAeMGCYzHJ1dARAfA9Wh7a+5ySycVXniosYv
         q6pc//PDRSzc7aNZDxCR9Q8Q1C+ULO7boLM7k8pzCnhNajIMZW+1AzZjoN/yy9Hx95P0
         xfYA==
X-Gm-Message-State: AOJu0YxYWWPFPuTJxpro1NMEkNNvk1UQPtNp4GX0orqvh7mUn9+Hnl8P
	m/SaZDfQ+wP+0Uh+8eBd6MK1ott0yebRIUNY7w8njjLabol57n/Y1BBVV/oEiw==
X-Gm-Gg: ATEYQzx/bjH/Hriwd+DilAlYWhdTzvjETrDNeprUC2+obvOeSF13DyRL+UBSSCmG65H
	ZZ28Ksd0WcRWRNsebHFXk1zJa/CDaLuwM/hgMBk59Dn6iGfdYeMBXsskwm2RmFFrA3NE3SQByJ7
	izmdoLM4Yusf/r1ft5nVnZMnQIG6CD2d7qp83JKBowGA/b/n37eCLMQnhgCccLBJ1D+461g5Mrt
	WZwVSO8pJbVbnuwXqQ59fQMfoHhmKNnzl15ZVgiYBhbzng45Irlhc/DrSY8sg9FSupbEaJ+Q2UH
	vf/KhJP8FwR2BzleRUgKZn/fWNAh3YDO1PGxVCGL9rknZPloOCPia+77hKroPuhqJ4bEbwTGgY3
	1dUVmutV9o7nK3056kPfI8G28VZDhJiD9WSxMCOtBZIrcCtJRRoOpMoB8VBLuNbIR7cqfjnOUiT
	YpH2y0lIiVn+uVXgi/sSncuZMI4UhgQMR6JbVYtUnKbIc9kE5JqnopB0VZ/w==
X-Received: by 2002:a05:6a00:bd12:b0:82c:68f6:a18 with SMTP id d2e1a72fcca58-82c6e0e4d14mr1077695b3a.34.1774389858332;
        Tue, 24 Mar 2026 15:04:18 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:7ceb:99d5:377f:7f66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc1ddasm13870717b3a.19.2026.03.24.15.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:04:17 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 2/2] replay: add --revert mode to reverse commit changes
Date: Wed, 25 Mar 2026 03:34:01 +0530
Message-ID: <20260324220401.47040-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324220401.47040-1-siddharthasthana31@gmail.com>
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a `--revert <branch>` mode to git replay that undoes the changes
introduced by the specified commits. Like --onto and --advance, --revert
is a standalone mode: it takes a branch argument and updates that branch
with the newly created revert commits.

At GitLab, we need this in Gitaly for reverting commits directly on bare
repositories without requiring a working tree checkout.

The approach is the same as sequencer.c's do_pick_commit() -- cherry-pick
and revert are just the same three-way merge with swapped arguments:

  - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
  - Revert: merge(ancestor=commit, ours=current, theirs=parent)

We swap the base and pickme trees passed to merge_incore_nonrecursive()
to reverse the diff direction.

Reverts are processed newest-first (matching git revert behavior) to
reduce conflicts by peeling off changes from the top. Each revert
builds on the result of the previous one via the last_commit fallback
in the main replay loop, rather than relying on the parent-mapping
used for cherry-pick.

Revert commit messages follow the usual git revert conventions: prefixed
with "Revert" (or "Reapply" when reverting a revert), and including
"This reverts commit <hash>.". The author is set to the current user
rather than preserving the original author, matching git revert behavior.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc |  43 ++++++++-
 builtin/replay.c              |  35 ++++++--
 replay.c                      | 161 +++++++++++++++++++++++++---------
 replay.h                      |  11 ++-
 t/t3650-replay-basics.sh      | 111 +++++++++++++++++++++--
 5 files changed, 296 insertions(+), 65 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 8d696ce3ab..746312e9c6 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>
 
 DESCRIPTION
 -----------
@@ -42,6 +42,25 @@ The history is replayed on top of the <branch> and <branch> is updated to
 point at the tip of the resulting history. This is different from `--onto`,
 which uses the target only as a starting point without updating it.
 
+--revert <branch>::
+	Starting point at which to create the reverted commits; must be a
+	branch name.
++
+When `--revert` is specified, the commits in the revision range are reverted
+(their changes are undone) and the reverted commits are created on top of
+<branch>. The <branch> is then updated to point at the new commits. This is
+the same as running `git revert <revision-range>` but does not update the
+working tree.
++
+The commit messages follow `git revert` conventions: they are prefixed with
+"Revert" and include "This reverts commit <hash>." When reverting a commit
+whose message starts with "Revert", the new message uses "Reapply" instead.
+Unlike cherry-pick which preserves the original author, revert commits use
+the current user as the author, matching the behavior of `git revert`.
++
+This option is mutually exclusive with `--onto` and `--advance`. It is also
+incompatible with `--contained` (which is a modifier for `--onto` only).
+
 --contained::
 	Update all branches that point at commits in
 	<revision-range>. Requires `--onto`.
@@ -84,9 +103,10 @@ When using `--ref-action=print`, the output is usable as input to
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
 where the number of refs updated depends on the arguments passed and
-the shape of the history being replayed.  When using `--advance`, the
-number of refs updated is always one, but for `--onto`, it can be one
-or more (rebasing multiple branches simultaneously is supported).
+the shape of the history being replayed.  When using `--advance` or
+`--revert`, the number of refs updated is always one, but for `--onto`,
+it can be one or more (rebasing multiple branches simultaneously is
+supported).
 
 There is no stderr output on conflicts; see the <<exit-status,EXIT
 STATUS>> section below.
@@ -152,6 +172,21 @@ all commits they have since `base`, playing them on top of
 `origin/main`. These three branches may have commits on top of `base`
 that they have in common, but that does not need to be the case.
 
+To revert commits on a branch:
+
+------------
+$ git replay --revert main topic~2..topic
+------------
+
+This reverts the last two commits from `topic`, creating revert commits on
+top of `main`, and updates `main` to point at the result. This is useful when
+commits from `topic` were previously merged or cherry-picked into `main` and
+need to be undone.
+
+NOTE: For reverting an entire merge request as a single commit (rather than
+commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
+which can avoid unnecessary merge conflicts.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 2cdde830a8..d3c1d920f0 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -83,7 +83,7 @@ int cmd_replay(int argc,
 
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch>) "
+		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
 		   "[--ref-action[=<mode>]] <revision-range>"),
 		NULL
 	};
@@ -96,6 +96,9 @@ int cmd_replay(int argc,
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &opts.contained,
 			 N_("update all branches that point at commits in <revision-range>")),
+		OPT_STRING(0, "revert", &opts.revert,
+			   N_("branch"),
+			   N_("revert commits onto given branch")),
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
 			   N_("control ref update behavior (update|print)")),
@@ -105,19 +108,31 @@ int cmd_replay(int argc,
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	if (!opts.onto && !opts.advance) {
-		error(_("option --onto or --advance is mandatory"));
+	/* Exactly one mode must be specified */
+	if (!opts.onto && !opts.advance && !opts.revert) {
+		error(_("exactly one of --onto, --advance, or --revert is required"));
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	die_for_incompatible_opt3(!!opts.onto, "--onto",
+				  !!opts.advance, "--advance",
+				  !!opts.revert, "--revert");
 	die_for_incompatible_opt2(!!opts.advance, "--advance",
 				  opts.contained, "--contained");
-	die_for_incompatible_opt2(!!opts.advance, "--advance",
-				  !!opts.onto, "--onto");
+	die_for_incompatible_opt2(!!opts.revert, "--revert",
+				  opts.contained, "--contained");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
 
+	/*
+	 * Cherry-pick/rebase need oldest-first ordering so that each
+	 * replayed commit can build on its already-replayed parent.
+	 * Revert needs newest-first ordering (like git revert) to
+	 * reduce conflicts by peeling off changes from the top.
+	 */
+	int desired_reverse = !opts.revert;
+
 	repo_init_revisions(repo, &revs, prefix);
 
 	/*
@@ -129,7 +144,7 @@ int cmd_replay(int argc,
 	 * some options changing these values if we think they could
 	 * be useful.
 	 */
-	revs.reverse = 1;
+	revs.reverse = desired_reverse;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
@@ -144,11 +159,11 @@ int cmd_replay(int argc,
 	 * Detect and warn if we override some user specified rev
 	 * walking options.
 	 */
-	if (revs.reverse != 1) {
+	if (revs.reverse != desired_reverse) {
 		warning(_("some rev walking options will be overridden as "
 			  "'%s' bit in 'struct rev_info' will be forced"),
 			"reverse");
-		revs.reverse = 1;
+		revs.reverse = desired_reverse;
 	}
 	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
 		warning(_("some rev walking options will be overridden as "
@@ -174,7 +189,9 @@ int cmd_replay(int argc,
 		goto cleanup;
 
 	/* Build reflog message */
-	if (opts.advance) {
+	if (opts.revert) {
+		strbuf_addf(&reflog_msg, "replay --revert %s", opts.revert);
+	} else if (opts.advance) {
 		strbuf_addf(&reflog_msg, "replay --advance %s", opts.advance);
 	} else {
 		struct object_id oid;
diff --git a/replay.c b/replay.c
index a63f6714c4..d7239d4c83 100644
--- a/replay.c
+++ b/replay.c
@@ -8,6 +8,7 @@
 #include "refs.h"
 #include "replay.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "strmap.h"
 #include "tree.h"
 
@@ -17,6 +18,11 @@
  */
 #define the_repository DO_NOT_USE_THE_REPOSITORY
 
+enum replay_mode {
+	REPLAY_MODE_PICK,
+	REPLAY_MODE_REVERT,
+};
+
 static const char *short_commit_name(struct repository *repo,
 				     struct commit *commit)
 {
@@ -50,15 +56,37 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+static void generate_revert_message(struct strbuf *msg,
+				    struct commit *commit,
+				    struct repository *repo)
+{
+	const char *out_enc = get_commit_output_encoding();
+	const char *message = repo_logmsg_reencode(repo, commit, NULL, out_enc);
+	const char *subject_start;
+	int subject_len;
+	char *subject;
+
+	subject_len = find_commit_subject(message, &subject_start);
+	subject = xmemdupz(subject_start, subject_len);
+
+	sequencer_format_revert_message(repo, subject, commit,
+					commit->parents ? commit->parents->item : NULL,
+					false, msg);
+
+	free(subject);
+	repo_unuse_commit_buffer(repo, commit, message);
+}
+
 static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
-				    struct commit *parent)
+				    struct commit *parent,
+				    enum replay_mode mode)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
-	char *author;
+	char *author = NULL;
 	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
@@ -70,9 +98,16 @@ static struct commit *create_commit(struct repository *repo,
 
 	commit_list_insert(parent, &parents);
 	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
-	find_commit_subject(message, &orig_message);
-	strbuf_addstr(&msg, orig_message);
-	author = get_author(message);
+	if (mode == REPLAY_MODE_REVERT) {
+		generate_revert_message(&msg, based_on, repo);
+		/* For revert, use current user as author (NULL = use default) */
+	} else if (mode == REPLAY_MODE_PICK) {
+		find_commit_subject(message, &orig_message);
+		strbuf_addstr(&msg, orig_message);
+		author = get_author(message);
+	} else {
+		BUG("unexpected replay mode %d", mode);
+	}
 	reset_ident_date();
 	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
 				 &ret, author, NULL, sign_commit, extra)) {
@@ -153,11 +188,35 @@ static void get_ref_information(struct repository *repo,
 	}
 }
 
+static void set_up_branch_mode(struct repository *repo,
+			       char **branch_name,
+			       const char *option_name,
+			       struct ref_info *rinfo,
+			       struct commit **onto)
+{
+	struct object_id oid;
+	char *fullname = NULL;
+
+	if (repo_dwim_ref(repo, *branch_name, strlen(*branch_name),
+			  &oid, &fullname, 0) == 1) {
+		free(*branch_name);
+		*branch_name = fullname;
+	} else {
+		die(_("argument to %s must be a reference"), option_name);
+	}
+	*onto = peel_committish(repo, *branch_name, option_name);
+	if (rinfo->positive_refexprs > 1)
+		die(_("'%s' cannot be used with multiple revision ranges "
+		      "because the ordering would be ill-defined"),
+		    option_name);
+}
+
 static void set_up_replay_mode(struct repository *repo,
 			       struct rev_cmdline_info *cmd_info,
 			       const char *onto_name,
 			       bool *detached_head,
 			       char **advance_name,
+			       char **revert_name,
 			       struct commit **onto,
 			       struct strset **update_refs)
 {
@@ -172,9 +231,6 @@ static void set_up_replay_mode(struct repository *repo,
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
-	if (!onto_name == !*advance_name)
-		BUG("one and only one of onto_name and *advance_name must be given");
-
 	if (onto_name) {
 		*onto = peel_committish(repo, onto_name, "--onto");
 		if (rinfo.positive_refexprs <
@@ -183,23 +239,12 @@ static void set_up_replay_mode(struct repository *repo,
 		*update_refs = xcalloc(1, sizeof(**update_refs));
 		**update_refs = rinfo.positive_refs;
 		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	} else if (*advance_name) {
+		set_up_branch_mode(repo, advance_name, "--advance", &rinfo, onto);
+	} else if (*revert_name) {
+		set_up_branch_mode(repo, revert_name, "--revert", &rinfo, onto);
 	} else {
-		struct object_id oid;
-		char *fullname = NULL;
-
-		if (!*advance_name)
-			BUG("expected either onto_name or *advance_name in this function");
-
-		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
-			     &oid, &fullname, 0) == 1) {
-			free(*advance_name);
-			*advance_name = fullname;
-		} else {
-			die(_("argument to --advance must be a reference"));
-		}
-		*onto = peel_committish(repo, *advance_name, "--advance");
-		if (rinfo.positive_refexprs > 1)
-			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
+		BUG("expected one of onto_name, *advance_name, or *revert_name");
 	}
 	strset_clear(&rinfo.negative_refs);
 	strset_clear(&rinfo.positive_refs);
@@ -220,7 +265,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  kh_oid_map_t *replayed_commits,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
-					  struct merge_result *result)
+					  struct merge_result *result,
+					  enum replay_mode mode)
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
@@ -232,25 +278,45 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 	base_tree = repo_get_commit_tree(repo, base);
 
-	merge_opt->branch1 = short_commit_name(repo, replayed_base);
-	merge_opt->branch2 = short_commit_name(repo, pickme);
-	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
-
-	merge_incore_nonrecursive(merge_opt,
-				  base_tree,
-				  replayed_base_tree,
-				  pickme_tree,
-				  result);
-
-	free((char*)merge_opt->ancestor);
+	if (mode == REPLAY_MODE_PICK) {
+		/* Cherry-pick: normal order */
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = short_commit_name(repo, pickme);
+		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+
+		merge_incore_nonrecursive(merge_opt,
+					  base_tree,
+					  replayed_base_tree,
+					  pickme_tree,
+					  result);
+
+		free((char *)merge_opt->ancestor);
+	} else if (mode == REPLAY_MODE_REVERT) {
+		/* Revert: swap base and pickme to reverse the diff */
+		const char *pickme_name = short_commit_name(repo, pickme);
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
+		merge_opt->ancestor = pickme_name;
+
+		merge_incore_nonrecursive(merge_opt,
+					  pickme_tree,
+					  replayed_base_tree,
+					  base_tree,
+					  result);
+
+		free((char *)merge_opt->branch2);
+	} else {
+		BUG("unexpected replay mode %d", mode);
+	}
 	merge_opt->ancestor = NULL;
+	merge_opt->branch2 = NULL;
 	if (!result->clean)
 		return NULL;
 	/* Drop commits that become empty */
 	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
 	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
 		return replayed_base;
-	return create_commit(repo, result->tree, pickme, replayed_base);
+	return create_commit(repo, result->tree, pickme, replayed_base, mode);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -287,11 +353,16 @@ int replay_revisions(struct rev_info *revs,
 	};
 	bool detached_head;
 	char *advance;
+	char *revert;
+	enum replay_mode mode = REPLAY_MODE_PICK;
 	int ret;
 
 	advance = xstrdup_or_null(opts->advance);
+	revert = xstrdup_or_null(opts->revert);
+	if (revert)
+		mode = REPLAY_MODE_REVERT;
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
-			   &detached_head, &advance, &onto, &update_refs);
+			   &detached_head, &advance, &revert, &onto, &update_refs);
 
 	/* FIXME: Should allow replaying commits with the first as a root commit */
 
@@ -315,7 +386,8 @@ int replay_revisions(struct rev_info *revs,
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
+						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
+						  &merge_opt, &result, mode);
 		if (!last_commit)
 			break;
 
@@ -327,7 +399,7 @@ int replay_revisions(struct rev_info *revs,
 		kh_value(replayed_commits, pos) = last_commit;
 
 		/* Update any necessary branches */
-		if (advance)
+		if (advance || revert)
 			continue;
 
 		for (decoration = get_name_decoration(&commit->object);
@@ -361,11 +433,13 @@ int replay_revisions(struct rev_info *revs,
 		goto out;
 	}
 
-	/* In --advance mode, advance the target ref */
-	if (advance)
-		replay_result_queue_update(out, advance,
+	/* In --advance or --revert mode, update the target ref */
+	if (advance || revert) {
+		const char *ref = advance ? advance : revert;
+		replay_result_queue_update(out, ref,
 					   &onto->object.oid,
 					   &last_commit->object.oid);
+	}
 
 	ret = 0;
 
@@ -377,5 +451,6 @@ int replay_revisions(struct rev_info *revs,
 	kh_destroy_oid_map(replayed_commits);
 	merge_finalize(&merge_opt, &result);
 	free(advance);
+	free(revert);
 	return ret;
 }
diff --git a/replay.h b/replay.h
index d8407dc7f7..e916a5f975 100644
--- a/replay.h
+++ b/replay.h
@@ -13,7 +13,7 @@ struct replay_revisions_options {
 	/*
 	 * Starting point at which to create the new commits; must be a branch
 	 * name. The branch will be updated to point to the rewritten commits.
-	 * This option is mutually exclusive with `onto`.
+	 * This option is mutually exclusive with `onto` and `revert`.
 	 */
 	const char *advance;
 
@@ -22,7 +22,14 @@ struct replay_revisions_options {
 	 * committish. References pointing at decendants of `onto` will be
 	 * updated to point to the new commits.
 	 */
-	 const char *onto;
+	const char *onto;
+
+	/*
+	 * Starting point at which to create revert commits; must be a branch
+	 * name. The branch will be updated to point to the revert commits.
+	 * This option is mutually exclusive with `onto` and `advance`.
+	 */
+	const char *revert;
 
 	/*
 	 * Update branches that point at commits in the given revision range.
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index a03f8f9293..217f6fb292 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -74,8 +74,8 @@ test_expect_success '--onto with invalid commit-ish' '
 	test_cmp expect actual
 '
 
-test_expect_success 'option --onto or --advance is mandatory' '
-	echo "error: option --onto or --advance is mandatory" >expect &&
+test_expect_success 'exactly one of --onto, --advance, or --revert is required' '
+	echo "error: exactly one of --onto, --advance, or --revert is required" >expect &&
 	test_might_fail git replay -h >>expect &&
 	test_must_fail git replay topic1..topic2 2>actual &&
 	test_cmp expect actual
@@ -87,16 +87,14 @@ test_expect_success 'no base or negative ref gives no-replaying down to root err
 	test_cmp expect actual
 '
 
-test_expect_success 'options --advance and --contained cannot be used together' '
-	printf "fatal: options ${SQ}--advance${SQ} " >expect &&
-	printf "and ${SQ}--contained${SQ} cannot be used together\n" >>expect &&
+test_expect_success '--advance and --contained cannot be used together' '
 	test_must_fail git replay --advance=main --contained \
 		topic1..topic2 2>actual &&
-	test_cmp expect actual
+	test_grep "cannot be used together" actual
 '
 
 test_expect_success 'cannot advance target ... ordering would be ill-defined' '
-	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
+	echo "fatal: ${SQ}--advance${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
@@ -398,4 +396,103 @@ test_expect_success 'invalid replay.refAction value' '
 	test_grep "invalid.*replay.refAction.*value" error
 '
 
+test_expect_success 'argument to --revert must be a reference' '
+	echo "fatal: argument to --revert must be a reference" >expect &&
+	oid=$(git rev-parse main) &&
+	test_must_fail git replay --revert=$oid topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cannot revert with multiple sources' '
+	echo "fatal: ${SQ}--revert${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
+	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'using replay --revert to revert commits' '
+	# Reuse existing topic4 branch (has commits I and J on top of main)
+	START=$(git rev-parse topic4) &&
+	test_when_finished "git branch -f topic4 $START" &&
+
+	# Revert commits I and J
+	git replay --revert topic4 topic4~2..topic4 &&
+
+	# Verify the revert commits were created (newest-first ordering
+	# means J is reverted first, then I on top)
+	git log --format=%s -4 topic4 >actual &&
+	cat >expect <<-\EOF &&
+	Revert "I"
+	Revert "J"
+	J
+	I
+	EOF
+	test_cmp expect actual &&
+
+	# Verify commit message format includes hash (tip is Revert "I")
+	test_commit_message topic4 <<-EOF &&
+	Revert "I"
+
+	This reverts commit $(git rev-parse I).
+	EOF
+
+	# Verify reflog message
+	git reflog topic4 -1 --format=%gs >reflog-msg &&
+	echo "replay --revert topic4" >expect-reflog &&
+	test_cmp expect-reflog reflog-msg
+'
+
+test_expect_success 'using replay --revert in bare repo' '
+	# Reuse existing topic4 in bare repo
+	START=$(git -C bare rev-parse topic4) &&
+	test_when_finished "git -C bare update-ref refs/heads/topic4 $START" &&
+
+	# Revert commit J in bare repo
+	git -C bare replay --revert topic4 topic4~1..topic4 &&
+
+	# Verify revert was created
+	git -C bare log -1 --format=%s topic4 >actual &&
+	echo "Revert \"J\"" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'revert of revert uses Reapply' '
+	# Use topic4 and first revert J, then revert the revert
+	START=$(git rev-parse topic4) &&
+	test_when_finished "git branch -f topic4 $START" &&
+
+	# First revert J
+	git replay --revert topic4 topic4~1..topic4 &&
+	REVERT_J=$(git rev-parse topic4) &&
+
+	# Now revert the revert - should become Reapply
+	git replay --revert topic4 topic4~1..topic4 &&
+
+	# Verify Reapply prefix and message format
+	test_commit_message topic4 <<-EOF
+	Reapply "J"
+
+	This reverts commit $REVERT_J.
+	EOF
+'
+
+test_expect_success 'git replay --revert with conflict' '
+	# conflict branch has C.conflict which conflicts with topic1s C
+	test_expect_code 1 git replay --revert conflict B..topic1
+'
+
+test_expect_success 'git replay --revert incompatible with --contained' '
+	test_must_fail git replay --revert topic4 --contained topic4~1..topic4 2>error &&
+	test_grep "cannot be used together" error
+'
+
+test_expect_success 'git replay --revert incompatible with --onto' '
+	test_must_fail git replay --revert topic4 --onto main topic4~1..topic4 2>error &&
+	test_grep "cannot be used together" error
+'
+
+test_expect_success 'git replay --revert incompatible with --advance' '
+	test_must_fail git replay --revert topic4 --advance main topic4~1..topic4 2>error &&
+	test_grep "cannot be used together" error
+'
+
 test_done
-- 
2.51.0

