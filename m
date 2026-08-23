Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113462E1722
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505571; cv=none; b=eH8DVIqrDA/AeJDOr0QGBA63se5xkh/hKVzIUYOeJKDvqry3w91NKJ0ECFuiuDcpXGmKugTTanU+mli4+4efGYhCgpZi7RmFt7Q9o0KKJNgziOrYMHr4jG+5tH3HCf6QQwP2D069961ZNMHzg3zxu3MLGdNYuBqP9B/gJmd8/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505571; c=relaxed/simple;
	bh=lrLOpiwUYqoSmyooRxxouvi5hmSyRdADKIxBQj8qXcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGAoJ+gmM13jRkt3y6iCYcT/hC0cL1Ta0KmpYLPQR+Wx+T6WyRw+1BG/0A64j98u5StNDMMTVt7REX2NzetDc1hgpy71M886g9cRP6atN4nyTXXCzEKJ0+J4rp3XnxcdHmrfud6blK4HZS8UAnae+blGMN/BHYWHSIM/OOP3NNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1arLPNI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1arLPNI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso36389815ad.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505562; x=1788110362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SKbTg2fccCNv5y9oPCvlF0Yx4GhwXET3Wq2x3I80Uw=;
        b=A1arLPNIZzzv+yQsT1rJuwTvkiFCslATFCnMKsX+8C2I+blJrjm4GFM8fS6akZYn2Z
         +TPOFhH1/bM29MFNJjES+8mQZT7ZsfIXNadDFsZm4hYviH3NwXZwaJpEHLLJpCvtp80j
         eDiKvPerZRnzL3SpH/E40ysXkoSNsaBmR3HuWyTwYpneIwzxX4tKb8H4rziJe5Yvdts2
         yuPV+N6OmQrqVnyc1g3GJaj+aR+UOgsjP3Cs15wv/0OxduCVHLhKF81Xx1a7ppJ1iXnN
         Jj4WryX2hmDgy20R6aSl257Nt1OAKTWrTk4GAullshvmdk3BRe9U6Bw1zi352A0fJJgB
         gbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505562; x=1788110362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SKbTg2fccCNv5y9oPCvlF0Yx4GhwXET3Wq2x3I80Uw=;
        b=otS9EnqUAXGZ3qt0dIodqqHfAe83/XCyJk+eaKS2pgzGSK5qPVg6gsmMieY34uetGd
         QKRX1YA77+QNqgSjQPI4DypnwGfDGdlKF27uO4B1C55deYiIKLBu0p0v9CSaxjm2WFH2
         zW0MffMeX/hgJOm3/puQOImMnQOzbpsmjbESCX0G9FGmD6l7QPHFd91vLsplPSkiKHMp
         8fMZNpY4h5MvW4XFDyLyBHEKu6x7rDIfZpaVEhVI6DP0JOyY90q6i0zJJhnf0MAZhKHB
         cGwXmmLeDcfz52HmeiYPCXv+JWnNwai8TbgzptVWhAb5AgrnKWolhgc3woGlM6TVY1/o
         NlvQ==
X-Gm-Message-State: AFuF++nKr9u71jNTMtkZdlH8M+14rlukPPy8HsZZQy6NSwt9WxL8pJHm
	DhXRZ0G3I0FIa9rAWiwOX9Bxis1Jpqxsvr/8JOKYW67EOfYV6zA0zmUvMiQ92g==
X-Gm-Gg: AR+sD11KAA4sE4LMRgrDEuWJsD1sYq7EE3q2K4et0BAujekbydqeAAnNoRTwEPkBnkp
	ZGBQXBrQPI5QlkGTFcPlWfo8GQ+Ku0o1imH5rgCyqw7He8afw4IFhRw6DZYlFinRYMBGgNOK8IA
	HMt8XdE6+DjvrbNCamlnMrBOgna/vIoS9NyWBp4MoGMz88Si2qgXCK01avqIGR2RY5d0m8trKYj
	V2WlH1SJSdFdKT+QZDB+wrctiB/j7nxFsSTlmPAjctN7zHBm93TjkfQ9WmwiJqAXJ9e8SH8jyXn
	2u28yx+RRTu/RMokr56oGxg7PNwWKds41PEmrs0FyaPRRN8thX6WbFMd9kvTQLCeB9A2boo0pZS
	Q7nzP/cyyxtKoCJugierYAwX1j4A9SLnFjpQvWstd9ODWa6WOmxkcTecr6+HcO0WrUPKTQtwiA2
	9xEUJne8k121ykQIRYVFx0Vvhzi1qx44dw/yhBJBF3nqsbNRWxdov9DF91jIEO/+CpGmC4q0guG
	KuEx30QPH6h51iH77TNdpWUPJtBr+mVH79kxKbqesxOApQOuBUMv3oKNfdkh9MbvMXvgY2SCGoA
	TtTicxxwNg8C/jb2va2CR9kEHiiw95XekNngO5k1+/OCww==
X-Received: by 2002:a17:903:2c0c:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d64b0270b8mr388433355ad.9.1787505559793;
        Sun, 23 Aug 2026 10:19:19 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d37cesm20926091eec.15.2026.08.23.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:19 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 02/14] organize: add the labeler, organizer, and apply --labels-only
Date: Sun, 23 Aug 2026 10:18:46 -0700
Message-ID: <20260823171915.2662373-3-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core builtin reconciles a tree against a hand-written [labels] section,
but nothing fills [labels] in and every move is a bare rename. A project
needs to record where each file belongs and to repoint the references a
move breaks.

Add the two configured commands that supply that judgment, the way a merge
driver's command is configured in git config:

  organize.labeler    records a [labels] line per root file in scope
  organize.organizer  returns edits for the files a move touches

git organize apply --labels-only runs the labeler and writes [labels],
preserving the lines of already placed files. Plain git organize apply,
when an organizer is configured, hands it the standing moves over a pipe;
the organizer returns a patch of the edits and a reason for any move it
declines. The moves and the patch apply as one git apply transaction, so a
failure leaves the tree untouched. A declined move keeps its file and its
[labels] line.

The organizer patch is validated before anything applies. It may edit a
referring file, or rename a moved file as it edits it, but it must not add,
delete, or copy files, and any rename must match a planned move.

Add a reference labeler and organizer under contrib/organize for Git's own
tree. The labeler places each source by the "area:" prefix its own commits
carry most often, mined with git log --follow: the area its authors name
need not be its filename, so ws.c files under whitespace and
diffcore-pickaxe.c under pickaxe. git-layout.map groups these prefix tokens
into components under [tokens]; odb owns object, object-file, blob, tag, and
so on. A source whose prefix is a broad area name that also swept its
neighbors, or that has too little history to name an area, falls back to its
filename through the [names] section. A source that neither section places,
but that changes chiefly alongside one component, is promoted there. A
source that couples broadly stays at the root. Each record also carries the
prefix, the #include coupling, and the co-change profile as advisory
signals. The organizer repoints the moved build object in the Makefile and
meson.build, and rewrites the #include of each moved header to its new path
across the tree.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/git-organize.adoc | 108 ++++++-
 Makefile                        |   2 +
 builtin/organize.c              |  48 +++-
 contrib/organize/git-layout.map |  41 +++
 contrib/organize/labeler        | 333 ++++++++++++++++++++++
 contrib/organize/organizer      | 334 ++++++++++++++++++++++
 meson.build                     |   2 +
 organize/gitorganize-format.c   |   5 +
 organize/labeler-protocol.c     |  52 ++++
 organize/labeler-protocol.h     |  15 +
 organize/organize.c             | 165 ++++++++++-
 organize/organize.h             |  50 +++-
 organize/organizer-protocol.c   | 254 +++++++++++++++++
 organize/organizer-protocol.h   |  18 ++
 t/t0096-organize.sh             | 479 +++++++++++++++++++++++++++++---
 15 files changed, 1817 insertions(+), 89 deletions(-)
 create mode 100644 contrib/organize/git-layout.map
 create mode 100755 contrib/organize/labeler
 create mode 100755 contrib/organize/organizer
 create mode 100644 organize/labeler-protocol.c
 create mode 100644 organize/labeler-protocol.h
 create mode 100644 organize/organizer-protocol.c
 create mode 100644 organize/organizer-protocol.h

diff --git a/Documentation/git-organize.adoc b/Documentation/git-organize.adoc
index 4ff76f5c13..8b216146b6 100644
--- a/Documentation/git-organize.adoc
+++ b/Documentation/git-organize.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git organize status'
 'git organize apply'
+'git organize apply' --labels-only [--reseed]
 
 
 DESCRIPTION
@@ -31,18 +32,36 @@ rule it satisfies places it; a file matching no rule is the backlog.
 source in scope, `<path> <key>=<value> ...`, with every label the project
 defines. A placed file is listed too, so its `[labels]` line records its
 labels, independently of the directory name. Only a label named in a rule
-places a file.
+places a file; a label named in no rule places nothing and is recorded for a
+reader.
+
+The labeler and organizer live in config: `organize.labeler` and
+`organize.organizer`. A label is a key and value the labeler attaches to a
+file. `git organize apply --labels-only` runs the labeler and records the
+labels. A file is out of place when its matching rule names a directory it
+is not in yet.
 
 `git organize status` reads `[labels]` and reports the out-of-place files,
 the backlog, a file in scope that `[labels]` does not record, and a
-recorded path that no longer exists. It runs nothing and
-changes nothing.
+recorded path that no longer exists. status runs no
+configured command and changes nothing.
 
 `git organize apply` reconciles the tree. It moves each out-of-place file
-into its directory. A move is a content-identical rename, so `git log
---follow` and `git blame` track the file exactly. apply stages the result
-and repoints each carved file's `[labels]` line to its new path, carrying
-its labels. It commits nothing. apply requires a clean worktree.
+into its directory. A move that git organize makes on its own is a
+content-identical rename, so `git log --follow` and `git blame` track the
+file exactly. apply stages the result and repoints each carved file's
+`[labels]` line to its new path, carrying its labels. It commits nothing.
+
+A move can require an edit elsewhere, such as repointing a reference in
+another file, or an edit to the moved file itself, such as repointing its
+own references. A project supplies those edits with an organizer, its
+`organize.organizer` command. apply hands the organizer its
+moves. The organizer returns a patch of the edits and, for any move it
+cannot complete, a reason to skip it. When the organizer edits a file as it
+moves, git's rename detection matches it while its similarity stays above
+the rename threshold. apply applies the moves and the patch as one
+transaction. With no organizer configured, apply moves the files and makes
+no other edit.
 
 
 COMMANDS
@@ -52,13 +71,59 @@ status::
 	Report the files whose placement value names a directory they are not
 	in (the moves), the backlog (recorded files with no matching
 	rule), a file in scope that `[labels]` does not record, and a recorded
-	path that no longer exists. Changes nothing.
+	path that no longer exists. Runs no configured
+	command and changes nothing.
 
 apply::
 	Move each out-of-place file into its directory as a content-identical
-	rename, repoint each carved file's `[labels]` line to its new path, and
-	stage the result. apply requires a clean worktree, so the change can be
-	discarded as a whole.
+	rename, apply the organizer's edits, repoint each carved file's
+	`[labels]` line to its new path, and stage the result. apply requires a
+	clean worktree, so the change can be discarded as a whole.
++
+With `--labels-only`, apply instead records the `[labels]` line for every root
+file in scope and stages the file. A file already recorded keeps its line, so a
+placement chosen by hand or in an earlier run stands; the labeler only seeds a
+file that has no line yet. With `--reseed`, re-derive every line from the
+labeler, discarding the recorded placements. This is the only path that runs a
+labeler; `git organize apply` without `--labels-only` and `git organize status`
+never do.
+
+
+OPTIONS
+-------
+
+--labels-only::
+	With apply, run the labeler and record the labels; move no file. A
+	recorded file keeps its line; the labeler only seeds a file that has no
+	line yet.
+
+--reseed::
+	With apply `--labels-only`, re-derive every `[labels]` line from the
+	labeler, discarding the recorded placements. Use it to re-apply the
+	labeler after its map changes; without it a recorded line is kept.
+
+
+CONFIGURATION
+-------------
+organize.labeler::
+	The command that records the labels. `git organize apply
+	--labels-only` runs it over the root files in scope. It writes one
+	record per file on its standard output: the path, a NUL, its
+	space-separated `key=value` labels, a NUL. A file in scope with no
+	record is unrecorded, reported apart from the backlog. Use user or
+	system config for this setting; do
+	not take it from a repository file.
+
+organize.organizer::
+	The command that returns move edits. apply runs it over the moves. It
+	reads the pending moves on its standard input and returns a patch and
+	any skip reasons; see PROTOCOL. Optional. Without it, apply performs the
+	moves and makes no other edit. Use user or system config for this
+	setting; do not take it from a repository file.
+
+The labeler and organizer are trusted, the way a clean or smudge filter or a
+hook is trusted. Set them in user or system config, so a repository you clone
+cannot supply its own.
 
 
 FILES
@@ -71,10 +136,23 @@ FILES
 	file takes the directory of the first rule its labels satisfy, and a
 	file matching no rule is the backlog. `[labels]` holds the recorded
 	labels, one `<path> <key>=<value> ...` line per source in scope,
-	including placed files. The project writes `[scope]` and `[layout]`; the
-	move apply repoints a carved file's line. A `#` line is a comment; git
-	organize rewrites the file whole, keeping the hand-authored `[scope]`
-	and `[layout]` verbatim.
+	including placed files. The project writes `[scope]` and `[layout]`;
+	`git organize apply --labels-only` writes `[labels]`, and the move apply
+	repoints a carved file's line. A `#` line is a comment; git organize
+	rewrites the file whole, keeping the hand-authored `[scope]` and
+	`[layout]` verbatim.
+
+
+PROTOCOL
+--------
+apply speaks a line protocol with the organizer over a pipe. It writes the
+version line `git-organize 1 organize`, then a `move <src> <dst> <label>`
+line per pending move, with C-quoted paths. The organizer replies with the
+same version line. For each declined move, it writes `reject <src>
+<reason>`. It may then write `patch`, followed by a git patch that runs to
+the end of its output. The patch may edit referring files and may rename a
+moved file as it edits it, but it must not add, delete, or copy files, and
+any rename must match a planned move.
 
 
 GIT
diff --git a/Makefile b/Makefile
index da7c4df7d3..86297e9459 100644
--- a/Makefile
+++ b/Makefile
@@ -1238,7 +1238,9 @@ LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += oidtree.o
 LIB_OBJS += organize/gitorganize-format.o
+LIB_OBJS += organize/labeler-protocol.o
 LIB_OBJS += organize/organize.o
+LIB_OBJS += organize/organizer-protocol.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
diff --git a/builtin/organize.c b/builtin/organize.c
index 9462d8687f..354ba2151f 100644
--- a/builtin/organize.c
+++ b/builtin/organize.c
@@ -5,7 +5,8 @@
  * status reports the files in scope whose matching rule names a directory they
  * are not in yet (the moves), the backlog (files with no matching rule), and a
  * declared path that no longer exists. apply moves the misplaced files and
- * stages the result.
+ * stages the result; apply --labels-only instead runs the labeler and records
+ * the labels.
  */
 #include "builtin.h"
 #include "gettext.h"
@@ -16,6 +17,7 @@
 static const char *const organize_usage[] = {
 	"git organize status",
 	"git organize apply",
+	"git organize apply --labels-only [--reseed]",
 	NULL
 };
 
@@ -71,6 +73,7 @@ static int organize_status(struct repository *repo)
 static int organize_apply(struct repository *repo)
 {
 	struct organize_plan plan = ORGANIZE_PLAN_INIT;
+	int moved = 0, rejected = 0;
 
 	organize_plan_build(repo, &plan);
 	if (!plan.moves_nr) {
@@ -81,7 +84,17 @@ static int organize_apply(struct repository *repo)
 
 	organize_plan_apply(repo, &plan);
 
-	printf(_("organize apply: %d move(s).\n"), (int)plan.moves_nr);
+	for (size_t i = 0; i < plan.moves_nr; i++) {
+		if (plan.moves[i].skip_reason)
+			rejected++;
+		else
+			moved++;
+	}
+	printf(_("organize apply: %d move(s), %d skipped.\n"), moved, rejected);
+	for (size_t i = 0; i < plan.moves_nr; i++)
+		if (plan.moves[i].skip_reason)
+			printf("  skipped %-28s %s\n", plan.moves[i].src,
+			       plan.moves[i].skip_reason);
 	printf(_("organize apply: the result is staged; nothing is committed.\n"));
 
 	organize_plan_release(&plan);
@@ -93,18 +106,39 @@ int cmd_organize(int argc,
 		 const char *prefix,
 		 struct repository *repo)
 {
+	int labels_only = 0, reseed = 0;
 	struct option options[] = {
+		OPT_BOOL(0, "labels-only", &labels_only,
+			 N_("with apply, run the labeler and record the labels")),
+		OPT_BOOL(0, "reseed", &reseed,
+			 N_("with apply --labels-only, re-derive every recorded label")),
 		OPT_END()
 	};
 	const char *subcmd;
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, organize_usage, 0);
 	subcmd = argc ? argv[0] : "status";
 	if (argc > 1)
 		die(_("git organize: too many arguments"));
-	if (!strcmp(subcmd, "status"))
-		return organize_status(repo);
-	else if (!strcmp(subcmd, "apply"))
-		return organize_apply(repo);
-	die(_("git organize: unknown subcommand '%s'"), subcmd);
+	if (reseed && !labels_only)
+		die(_("git organize: --reseed is a --labels-only option"));
+	if (!strcmp(subcmd, "status")) {
+		if (labels_only)
+			die(_("git organize: --labels-only is an apply option"));
+		ret = organize_status(repo);
+	} else if (!strcmp(subcmd, "apply")) {
+		if (labels_only) {
+			organize_run_labeler(repo, reseed);
+			printf(_("organize apply --labels-only: the declaration is "
+				 "staged; nothing is committed.\n"));
+			ret = 0;
+		} else {
+			ret = organize_apply(repo);
+		}
+	} else {
+		die(_("git organize: unknown subcommand '%s'"), subcmd);
+	}
+
+	return ret;
 }
diff --git a/contrib/organize/git-layout.map b/contrib/organize/git-layout.map
new file mode 100644
index 0000000000..580d556b92
--- /dev/null
+++ b/contrib/organize/git-layout.map
@@ -0,0 +1,41 @@
+# Git component layout for the reference labeler, in two sections.
+#
+# [tokens] lists, per component directory, the commit-subject prefix tokens
+# that belong to it. A file is placed by the "area:" prefix its own commits
+# carry most often, mined with git log --follow. The area its authors name need
+# not be its filename (ws.c files under whitespace, diffcore-pickaxe.c under
+# pickaxe). The fine tokens consolidate into a component; that consolidation is
+# the project knowledge a mechanical pass cannot supply.
+#
+# [names] lists the filename token, the name before the first hyphen. A file
+# whose dominant prefix is a broad area name that also swept its neighbors
+# (commit, config, refs, ...), or whose commits name no area, is placed by
+# its filename instead. Program sources stay at the root.
+[tokens]
+odb: blob commit-slab fsck hash loose match-trees object object-file object-file-convert object-name odb oidmap oidset oidtree replace-object replace_object sha1-array sha1-lookup sha1_name tag tmp-objdir tree tree-walk
+refs: ls-refs pack-refs ref-filter reflog reflog-walk refspec worktree
+pack: bloom chunk-format commit-graph delta-islands diff-delta midx pack-bitmap pack-bitmap-write pack-check pack-mtimes pack-objects pack-revindex pack-write packfile patch-delta prune prune-packed pseudo-merge reachable repack repack-promisor server-info
+diff: combine-diff diff diff-merges diffcore-break diffcore-delta diffcore-order diffcore-rename patch-ids pickaxe range-diff tree-diff userdiff xdiff-interface
+merge: fmt-merge-msg ll-merge merge merge-blobs merge-ort rerere
+revision: bisect blame commit-reach decorate format-patch graph line-log line-range list list-objects list-objects-filter list-objects-filter-options pretty revision shallow
+index: cache-tree checkout dir dir-iterator entry fsmonitor fsmonitor--daemon fsmonitor-ll fsmonitor-settings name-hash parallel-checkout pathspec preload-index read-cache resolve-undo sparse-index split-index statinfo symlinks unpack-trees wt-status
+setup: alias hook ident repository setup version
+convert: attr convert whitespace
+transport: bundle bundle-uri cat-file connect connected fetch-negotiator fetch-pack http pkt-line promisor-remote protocol protocol-caps remote remote-curl send-pack serve sideband transport transport-helper upload-pack walker
+notes: notes notes-cache notes-merge
+submodule: submodule submodule-config
+archive: archive archive-tar archive-zip
+[names]
+odb: object odb oid oidmap oidset oidtree loose blob tag commit tree replace match tmp fsck hash sha1dc streaming
+refs: refs refspec reflog ref ls worktree
+pack: pack packfile midx delta prune reachable server bloom chunk pseudo repack
+diff: diff diffcore combine range userdiff xdiff patch pickaxe
+merge: merge rerere fmt
+revision: revision log bisect shallow blame line graph decorate list pretty
+index: read cache split sparse unpack name preload resolve statinfo entry parallel dir pathspec checkout symlinks fsmonitor wt
+setup: config setup environment repository repo ident alias version hook
+convert: attr convert ws whitespace
+transport: transport remote connect connected send fetch upload walker http protocol serve pkt sideband bundle promisor
+notes: notes
+submodule: submodule
+archive: archive
diff --git a/contrib/organize/labeler b/contrib/organize/labeler
new file mode 100755
index 0000000000..2116015f2d
--- /dev/null
+++ b/contrib/organize/labeler
@@ -0,0 +1,333 @@
+#!/usr/bin/perl
+# Reference labeler for git organize(1). This is a demonstration; a real
+# project supplies its own.
+#
+# git organize keeps the root *.c and *.h sources in scope. The labeler prints
+# one NUL-terminated label record per file,
+#
+#     <path> \0 component=<dir> role=<role> prefix=<token> \
+#               includes=<c>:<n>,... cochange=<c>:<n>,... \0
+#
+# component names the directory to move the file into. component and role are
+# the labels git organize acts on. prefix, includes, and cochange are advisory
+# signals the labeler records for a human to read.
+#
+# COMPONENT. The labeler names each file's component from the "area:" prefix its
+# own commits carry most often, mined with `git log --follow` over the file's
+# whole history. The area its authors name need not match its filename: ws.c
+# goes under whitespace, diffcore-pickaxe.c under pickaxe. The [tokens] section
+# of git-layout.map maps the fine prefix tokens to component directories. When a
+# file's dominant prefix is a broad area name that also swept its neighbors
+# (commit, config, refs, ...), or its commits name no area, the labeler falls
+# back to the file's name through the [names] section.
+# When neither section names a component, the labeler applies a co-change test:
+# a file that changes chiefly alongside one component moves there, and any other
+# file gets component=? (backlog). Programs (Makefile PROGRAM_OBJS) stay at the
+# root.
+#
+# ADVISORY. prefix is the dominant token itself. includes is the file's #include
+# coupling, each included in-scope header bucketed by its component. cochange
+# is the components the file co-changes with, mined from focused commits (<= 25
+# files). includes and cochange list the strongest components first, capped at
+# five. A human reads them to see where a file couples and whether git-layout.map
+# named a different component than a raw signal would.
+#
+# Usage:
+#     labeler                the label records on stdout
+
+use strict;
+use warnings;
+use File::Temp qw(tempdir);
+use POSIX ();
+
+my $CAP = 5;			# most-coupled components kept in an advisory list
+
+my $top = `git rev-parse --show-toplevel`;
+chomp $top;
+chdir $top or die "organize labeler: cannot cd to $top: $!\n";
+(my $here = $0) =~ s{/[^/]*$}{};
+my $mapfile = "$here/git-layout.map";
+
+# git-layout.map: [tokens] maps a commit-prefix token to its component, [names]
+# maps a filename token to its component.
+my (%tok_dir, %name_dir, $section);
+open my $map, '<', $mapfile or die "organize labeler: cannot read $mapfile: $!\n";
+while (<$map>) {
+	next if /^#/;
+	if (/^\[(\w+)\]\s*$/) { $section = $1; next; }
+	next unless /:/;
+	my ($dir, $tokens) = split /:/, $_, 2;
+	my $into = $section eq 'tokens' ? \%tok_dir : \%name_dir;
+	$into->{$_} = $dir for split ' ', $tokens;
+}
+close $map;
+
+# The standalone programs, from the Makefile.
+my %is_program;
+open my $mk, '<', 'Makefile' or die "organize labeler: cannot read Makefile: $!\n";
+while (<$mk>) {
+	$is_program{"$1.c"} = 1 if /^\s*PROGRAM_OBJS\s*\+?=\s*(\S+)\.o/;
+}
+close $mk;
+
+# Prefix tokens that name no area: mass-change and non-source markers. The
+# labeler ignores a commit subject led by one of these when tallying components.
+my %noise = map { $_ => 1 } qw(
+	treewide cocci coccinelle comments comment makefile doc docs
+	documentation style cleanup misc various global build ci test tests
+	config.mak wildmatch);
+
+# The name of a file with its extension and directory removed, lowercased.
+sub stem {
+	my ($p) = @_;
+	$p =~ s{.*/}{};
+	$p =~ s/\.[ch]$//;
+	return lc $p;
+}
+
+# The filename token: the stem up to its first hyphen (object-file -> object).
+sub name_token {
+	my ($s) = @_;
+	$s =~ s/-.*//;
+	return $s;
+}
+
+# A prefix token with a file-suffix variant folded to its base (commit.c and
+# serve.[ch] -> commit and serve), lowercased and trimmed.
+sub normalize {
+	my ($t) = @_;
+	$t = lc $t;
+	$t =~ s/^\s+//;
+	$t =~ s/\s+$//;
+	$t =~ s/\*?\.\[ch\]$//;
+	$t =~ s/\*?\.[ch]$//;
+	$t =~ s/\*?\.py$//;
+	return $t;
+}
+
+sub is_noise {
+	my ($t) = @_;
+	return 1 if $t eq '';
+	return 1 if $t =~ m{[ ,\[\]{}()*/'"]};
+	return 1 if $noise{$t};
+	return 0;
+}
+
+# The token matches the file's name: it is the stem, an extension of it, or a
+# hyphen-prefix of it. Used only to break a tie between equally frequent tokens.
+sub affinity {
+	my ($t, $s) = @_;
+	return 1 if $t eq $s;
+	return 1 if index($s, "$t-") == 0;
+	return 1 if index($t, $s) == 0;
+	return 0;
+}
+
+# The commit-prefix token a file's history carries most often, or undef when its
+# history names no area. Ties break toward a token that matches the file's name,
+# then by name.
+sub dominant_prefix {
+	my ($file) = @_;
+	my $s = stem($file);
+	my %count;
+	for my $subject (split /\n/, `git log --follow --no-merges --format=%s -- "$file"`) {
+		my $i = index($subject, ':');
+		next if $i <= 0;
+		my $t = normalize(substr($subject, 0, $i));
+		next if is_noise($t);
+		$count{$t} += 1;
+	}
+	return undef unless %count;
+	my @ranked = sort {
+		$count{$b} <=> $count{$a}
+			or affinity($b, $s) <=> affinity($a, $s)
+			or $a cmp $b
+	} keys %count;
+	return $ranked[0];
+}
+
+# The component and dominant prefix for a file: the component from the prefix
+# token via [tokens], else from the filename token via [names], else the
+# backlog. Programs stay at the root. Kept side-effect free so a worker process
+# can call it (see pass 1).
+sub classify {
+	my ($file) = @_;
+	my $p = dominant_prefix($file);
+	my $prefix = defined $p ? $p : '?';
+	return ('?', $prefix) if $is_program{$file};
+	return ($tok_dir{$p}, $prefix) if defined $p && exists $tok_dir{$p};
+	my $d = $name_dir{ name_token(stem($file)) };
+	return (defined $d ? $d : '?', $prefix);
+}
+
+# Pass 1: name the component for every scoped file, recording its component and
+# dominant prefix. The `git log --follow` mining dominates the run, so fan the
+# files across a pool of worker processes (ORGANIZE_JOBS, default the CPU count).
+# Each worker writes "path<TAB>component<TAB>prefix" for its share, and the
+# parent reads them back.
+my (%component, %prefix);
+my @files = grep { length } (split(/\n/, `git ls-files ':(glob)*.c'`),
+			     split(/\n/, `git ls-files ':(glob)*.h'`));
+{
+	my $jobs = $ENV{ORGANIZE_JOBS};
+	if (!$jobs) { chomp($jobs = `nproc 2>/dev/null`); $jobs ||= 4; }
+	$jobs = scalar(@files) if @files && $jobs > @files;
+	$jobs = 1 if $jobs < 1;
+	my $dir = tempdir(CLEANUP => 1);
+	my @pids;
+	for my $j (0 .. $jobs - 1) {
+		my $pid = fork();
+		die "organize labeler: cannot fork: $!\n" unless defined $pid;
+		if (!$pid) {
+			open my $out, '>', "$dir/$j" or POSIX::_exit(1);
+			my $n = 0;
+			for (my $i = $j; $i < @files; $i += $jobs) {
+				my ($c, $p) = classify($files[$i]);
+				print {$out} "$files[$i]\t$c\t$p\n";
+				$n++;
+			}
+			# Write a trailing sentinel line to prove the worker ran
+			# to the end. A worker that dies mid-run leaves a
+			# truncated file with no sentinel, which the parent
+			# rejects rather than read as a short but valid share.
+			# The parent matches this exact line, "# done <count>";
+			# a record line is TAB-separated, so it cannot collide.
+			print {$out} "# done $n\n";
+			close $out or POSIX::_exit(1);
+			POSIX::_exit(0);	# skip END/DESTROY so the tempdir survives
+		}
+		push @pids, $pid;
+	}
+	for my $pid (@pids) {
+		waitpid($pid, 0);
+		die "organize labeler: a worker failed\n" if $?;
+	}
+	for my $j (0 .. $jobs - 1) {
+		open my $in, '<', "$dir/$j"
+			or die "organize labeler: worker $j left no output\n";
+		my $sentinel = 0;
+		while (<$in>) {
+			chomp;
+			if (/^# done [0-9]+$/) { $sentinel = 1; next; }
+			my ($f, $c, $p) = split /\t/, $_, 3;
+			$component{$f} = $c;
+			$prefix{$f} = $p;
+		}
+		close $in;
+		die "organize labeler: worker $j left truncated output\n"
+			unless $sentinel;
+	}
+}
+
+# Pass 2a: the #include coupling profile, each included in-scope header
+# bucketed by its component.
+sub includes_profile {
+	my ($file) = @_;
+	open my $fh, '<', $file or return {};
+	my %prof;
+	while (<$fh>) {
+		next unless /^\s*#\s*include\s*"([^"]+)"/;
+		(my $inc = $1) =~ s{.*/}{};	# includes name the header directly
+		my $c = $component{$inc};
+		$prof{$c}++ if defined $c && $c ne '?';
+	}
+	close $fh;
+	return \%prof;
+}
+
+# Pass 2b: the co-change profile. A focused commit (<= 25 files) ties every pair
+# of files it touches; tally each file's scoped neighbors by their component.
+my %cochange;
+{
+	my @batch;
+	my $flush = sub {
+		return if @batch > 25;
+		my @scoped = grep { exists $component{$_} } @batch;
+		return if @scoped < 2;
+		for my $f (@scoped) {
+			for my $g (@scoped) {
+				next if $g eq $f;
+				my $c = $component{$g};
+				$cochange{$f}{$c}++ if $c ne '?';
+			}
+		}
+	};
+	open my $log, '-|', qw(git log --no-merges --format=%x01 --name-only)
+		or die "organize labeler: cannot read the commit log: $!\n";
+	my $started = 0;
+	while (my $line = <$log>) {
+		chomp $line;
+		if ($line =~ /^\x01/) {
+			$flush->() if $started;
+			@batch = ();
+			$started = 1;
+		} elsif ($line ne '') {
+			push @batch, $line;
+		}
+	}
+	$flush->() if $started;
+	close $log;
+}
+
+# Pass 3: promote a backlog file whose co-change coupling concentrates on one
+# component. The prefix and name gave this file no component, but it co-changes
+# chiefly with a single component, and its #includes do not point elsewhere, so
+# the labeler moves it to that component. A file that couples broadly stays at
+# the root. A .c and its .h combine their coupling and take the same component,
+# so a pair moves as one. The thresholds keep only a concentrated signal with
+# enough evidence behind it (alloc and cbtree join odb, git-curl-compat joins
+# transport; csum-file and mem-pool stay at the root as too diffuse or too
+# sparse).
+my $PROMOTE_SHARE = 0.60;
+my $PROMOTE_COUNT = 15;
+{
+	my %pair;
+	for my $file (@files) {
+		next if $component{$file} ne '?' || $is_program{$file};
+		(my $stem = $file) =~ s/\.[ch]$//;
+		push @{$pair{$stem}}, $file;
+	}
+	my @promote;			# [ [files], component ], decided before applying
+	for my $stem (sort keys %pair) {
+		my (%co, %inc);
+		for my $file (@{$pair{$stem}}) {
+			$co{$_}  += $cochange{$file}{$_} for keys %{$cochange{$file} || {}};
+			my $ip = includes_profile($file);
+			$inc{$_} += $ip->{$_} for keys %$ip;
+		}
+		next unless %co;
+		my $total = 0; $total += $_ for values %co;
+		my ($top) = sort { $co{$b} <=> $co{$a} or $a cmp $b } keys %co;
+		next unless $co{$top} >= $PROMOTE_COUNT
+			 && $co{$top} / $total >= $PROMOTE_SHARE;
+		if (%inc) {		# an #include profile must not point elsewhere
+			my ($itop) = sort { $inc{$b} <=> $inc{$a} or $a cmp $b } keys %inc;
+			next unless $itop eq $top;
+		}
+		push @promote, [ $pair{$stem}, $top ];
+	}
+	for my $p (@promote) {
+		$component{$_} = $p->[1] for @{$p->[0]};
+	}
+}
+
+# A "c:n,c:n" advisory list: the strongest components first, capped at $CAP.
+sub advisory {
+	my ($prof) = @_;
+	my @c = sort { $prof->{$b} <=> $prof->{$a} or $a cmp $b } keys %$prof;
+	@c = @c[0 .. $CAP - 1] if @c > $CAP;
+	return join ',', map { "$_:$prof->{$_}" } @c;
+}
+
+for my $file (@files) {
+	my $c = $component{$file};
+	my $role = $is_program{$file} ? 'program'
+		 : $file =~ /\.h$/ ? ($c eq '?' ? 'public' : 'header')
+		 : 'lib';
+	my $rec = "component=$c role=$role prefix=$prefix{$file}";
+	my $inc = advisory(includes_profile($file));
+	my $cox = advisory($cochange{$file} || {});
+	$rec .= " includes=$inc" if length $inc;
+	$rec .= " cochange=$cox" if length $cox;
+	print "$file\0$rec\0";
+}
diff --git a/contrib/organize/organizer b/contrib/organize/organizer
new file mode 100755
index 0000000000..56c805301b
--- /dev/null
+++ b/contrib/organize/organizer
@@ -0,0 +1,334 @@
+#!/usr/bin/perl
+# Reference organizer for git organize(1). This is a demonstration; a real
+# project supplies its own.
+#
+# When a .c source moves into a component directory, its build object moves
+# with it; when a .h header moves, every #include of it must be repointed to
+# the new path (the Git build uses -I. only, so an include names the full path).
+# The organizer reads the pending moves and returns a patch that repoints
+# every reference the reorganization leaves stale across Git's build systems:
+#
+#   Makefile                 the moved object list (stem.o/.s/.sp) and any
+#                            bare source name in a list (LOCALIZED_C_CORE)
+#   meson.build              the moved source path
+#   Documentation/Makefile   a moved header named by a ../<name>.h argument
+#   contrib/buildsystems/CMakeLists.txt
+#                            a moved .c named bare or by ${CMAKE_SOURCE_DIR}/
+#   #include "foo.h"         -> #include "dir/foo.h" in every C includer
+#   Documentation/**/*.adoc  a tutorial #include "foo.h" example line
+#
+# An include may name the header bare or by a ../ path (from a subdirectory),
+# and may write "#include" or "# include"; the repoint names the full path,
+# which -I. resolves from any directory. An includer that itself moves is
+# renamed-with-modification (its rename plus the repoint); a stationary
+# includer is edited in place. The .adoc tutorials always name the full new
+# path, so their #include example lines are repointed unconditionally, without
+# the shadow/depth resolution a real C include needs.
+#
+# The organizer declines any move whose references it cannot repoint. It
+# repoints every #include in the tracked C sources and tutorials, except that
+# frozen test data under t/tNNNN/ is deliberately left alone: those files are
+# fixtures (for example a mailinfo.c that git am replays byte for byte), so an
+# apparent #include in them is data, not a reference to follow. Outside those
+# fixtures, the only reference it can miss is one in a build file. After it
+# edits the build files above, it rejects a move whose old path a build file
+# still names (in a build file it does not edit, or in a form its edit missed).
+# That file stays at the root with its references intact, and apply moves the
+# rest.
+#
+# The code runs in four phases:
+#   Phase 1  read the "move <src> <dst>" lines from stdin.
+#   Phase 2  edit the build files as if every move happened, then reject a
+#            move a build file still names (build_edits, names_missing_path).
+#   Phase 3  build the new content of every file the accepted moves change
+#            (build_edits, include_edits, adoc_edits).
+#   Phase 4  emit one diff per changed file: a stationary file in place, an
+#            includer that itself moves as a rename-with-modification.
+# Name matching lives in the boundary regexes ($LB, $LB_ROOT, $RB) and in
+# include_names_root.
+
+use strict;
+use warnings;
+use File::Temp qw(tempdir);
+
+my $protocol = "git-organize 1 organize";
+chomp(my $top = `git rev-parse --show-toplevel`);
+chdir $top or die "organize organizer: cannot cd to $top: $!\n";
+
+sub unquote {
+	my ($s) = @_;
+	return $s unless $s =~ /\A"(.*)"\z/s;
+	my $body = $1;
+	my %esc = (a=>"\a", b=>"\b", t=>"\t", n=>"\n", v=>"\013",
+		f=>"\f", r=>"\r", '"'=>'"', '\\'=>'\\');
+	$body =~ s{\\([0-7]{1,3}|.)}
+		{ exists $esc{$1} ? $esc{$1} : $1 =~ /\A[0-7]/ ? chr(oct $1) : $1 }ges;
+	return $body;
+}
+sub shift_token {
+	$_[0] =~ s/\A\s+//;
+	my $tok = $_[0] =~ s/\A("(?:\\.|[^"\\])*")// ? $1 : $_[0] =~ s/\A(\S+)// ? $1
+		: die "organize organizer: malformed move line\n";
+	return unquote($tok);
+}
+sub slurp { open my $fh,'<',$_[0] or die "cannot read $_[0]: $!\n"; local $/; <$fh> }
+
+# Boundary vocabulary. A moved name matches only as a whole path component, so
+# remote.c never matches inside ls-remote.c and a subdirectory sibling
+# (builtin/remote.c) keeps its prefix and stays. Every name match below flanks
+# the name with these boundaries:
+#   $LB       left: not preceded by a name character
+#   $LB_ROOT  left, root only: also not preceded by a path separator
+#   $RB       right: the name token ends here
+#   $DIRS     an optional ../ and directory prefix before a name
+my $LB      = qr/(?<![A-Za-z0-9_.\-])/;
+my $LB_ROOT = qr/(?<![A-Za-z0-9_.\-\/])/;
+my $RB      = qr/(?![A-Za-z0-9])/;
+my $DIRS    = qr/(?:\.\.?\/)*(?:[A-Za-z0-9_.\-]+\/)*/;
+# bare_re: a bare root name, at a hard left boundary with no path separator, so
+# a subdir sibling (builtin/remote.c) keeps its prefix and stays.
+sub bare_re { my ($name) = @_; qr/$LB_ROOT\Q$name\E$RB/ }
+# cmake_re: a root .c named bare or as ${CMAKE_SOURCE_DIR}/<name> (captured in
+# $1). The name follows the CMAKE variable slash or a hard boundary, never a
+# real subdirectory component, so a nested source (compat/win32/headless.c)
+# stays.
+sub cmake_re {
+	my ($name) = @_;
+	qr/$LB(?:(\$\{CMAKE_SOURCE_DIR\}\/)|$LB_ROOT)\Q$name\E$RB/;
+}
+
+# === Phase 1: read the pending moves ===
+my @moves;
+while (my $line = <STDIN>) {
+	next unless $line =~ s/\Amove //;
+	my $src = shift_token($line); my $dst = shift_token($line);
+	push @moves, [$src, $dst];
+}
+
+# The build files the organizer edits. A moved .c is a build object (Makefile /
+# meson) and may also appear as a bare source name in a Makefile list and as a
+# path in the contrib CMake build. A moved .h is named by a ../ argument in
+# Documentation/Makefile. An absent build file is skipped.
+my @buildfiles = ('Makefile', 'meson.build',
+	'Documentation/Makefile', 'contrib/buildsystems/CMakeLists.txt');
+
+# Edit the build files for the given moves, returning path -> edited content
+# (undef for an absent file).
+sub build_edits {
+	my ($moves) = @_;
+	my %build = map { $_ => (-e $_ ? slurp($_) : undef) } @buildfiles;
+	for my $m (@$moves) {
+		my ($src, $dst) = @$m;
+		(my $stem = $src) =~ s/\.[ch]\z//;
+		(my $dir = $dst) =~ s{/[^/]*\z}{};
+		# A ../ argument in Documentation/Makefile names a moved header
+		# (../fsck.h feeds lint-fsck-msgids.perl). The ../ steps out of
+		# Documentation/ to the root, so ../<dst> names the new path.
+		if ($src !~ /\.c\z/) {
+			my $mk = 'Documentation/Makefile';
+			$build{$mk} =~ s{$LB\.\./\Q$src\E$RB}{../$dst}g
+				if defined $build{$mk};
+			next;
+		}
+		# A moved .c: Makefile object (stem.o/.s/.sp) and meson path.
+		$build{'Makefile'} =~ s{(^|\s)\Q$stem\E\.(sp|s|o)$RB}{$1$dir/$stem.$2}mg
+			if defined $build{'Makefile'};
+		$build{'meson.build'} =~ s{'\Q$src\E'}{'$dst'}g
+			if defined $build{'meson.build'};
+		# A bare source name in a Makefile list (LOCALIZED_C_CORE).
+		if (defined $build{'Makefile'}) {
+			my $re = bare_re($src);
+			$build{'Makefile'} =~ s{$re}{$dst}g;
+		}
+		# The contrib CMake names a .c bare or by ${CMAKE_SOURCE_DIR}/.
+		if (defined $build{'contrib/buildsystems/CMakeLists.txt'}) {
+			my $re = cmake_re($src);
+			$build{'contrib/buildsystems/CMakeLists.txt'} =~
+				s{$re}{($1 // '') . $dst}ge;
+		}
+	}
+	return \%build;
+}
+
+# The paths that exist once every move is made: the tracked files, less each
+# old path, plus each new path.
+my %exists = map { $_ => 1 } split /\n/, `git ls-files`;
+for my $m (@moves) { delete $exists{$m->[0]}; $exists{$m->[1]} = 1; }
+
+# A referenced path token, normalized to a repository-relative path.
+sub norm_ref {
+	my ($t) = @_;
+	while ($t =~ m{\A\.\.?/}) { $t =~ s{\A[^/]*/}{}; }
+	$t =~ s{\A/+}{};
+	return $t;
+}
+# Whether a build file's content still names $old at a path that will not exist
+# once the moves are made. A comment names a file rather than a rule, so it is
+# skipped.
+sub names_missing_path {
+	my ($content, $old) = @_;
+	(my $base = $old) =~ s{.*/}{};
+	for my $line (split /\n/, $content) {
+		next if $line =~ /\A\s*#/;
+		while ($line =~ /$LB($DIRS)\Q$base\E$RB/g) {
+			return 1 unless $exists{norm_ref($1 . $base)};
+		}
+	}
+	return 0;
+}
+
+# === Phase 2: decide the rejects (completeness contract) ===
+# Edit the build files as if every move happened, then a move whose old path a
+# build file still names is one the organizer cannot fully repoint. The search
+# covers the edited build files and every other build file in the tree.
+my $build_for_rejects = build_edits(\@moves);
+my @rejects;
+for my $m (@moves) {
+	my ($src) = @$m;
+	(my $base = $src) =~ s{.*/}{};
+	my $grep = "git grep -lF -e '$base' --"
+		. " '*Makefile' '*.mak' '*meson.build' '*CMakeLists.txt'"
+		. " 'config.mak*' 2>/dev/null";
+	my @files = grep { length } split /\n/, `$grep`;
+	for my $f (@files) {
+		my $edited = $build_for_rejects->{$f};
+		my $content = defined $edited ? $edited : slurp($f);
+		if (names_missing_path($content, $src)) {
+			push @rejects, [$src, "a build file names it and the "
+				. "organizer cannot repoint that reference"];
+			last;
+		}
+	}
+}
+
+my %rejected = map { $_->[0] => 1 } @rejects;
+my @accepted = grep { !$rejected{$_->[0]} } @moves;
+my %dst_of = map { $_->[0] => $_->[1] } @accepted;
+
+# Whether a #include names the moved ROOT header rather than a same-named header
+# in the includer's own directory. A ../ include names the root only when its
+# ../ count matches the includer's depth (one ../ from a depth-1 file reaches
+# the root). A bare include names the root unless a sibling header in the
+# includer's own directory shadows it (reftable/tree.h shadows a root tree.h).
+sub include_names_root {
+	my ($dots, $depth, $fdir, $src) = @_;
+	my $up = $dots =~ tr{/}{};
+	return $up == $depth if $up;
+	return $depth == 0 || !(-e "$fdir/$src");
+}
+
+# For each accepted header move, repoint #include "foo.h" (bare or ../ path) to
+# the full new path in every C includer, keeping an include that resolves to a
+# shadowing local header (per include_names_root) unchanged. Returns includer
+# path -> edited content.
+sub include_edits {
+	my ($moves) = @_;
+	my %repoint;   # includer -> list of [src, dst]
+	for my $m (@$moves) {
+		my ($src, $dst) = @$m;
+		next unless $src =~ /\.h\z/;
+		(my $re = $src) =~ s/\./\\./g;
+		my $pat = '#[[:blank:]]*include[[:blank:]]*"(\.\./)*' . $re . '"';
+		my $grep = "git grep -lE '$pat' --"
+			. " '*.c' '*.h' ':(exclude)t/t[0-9][0-9][0-9][0-9]/**'";
+		for my $inc (split /\n/, `$grep`) {
+			push @{$repoint{$inc}}, [$src, $dst];
+		}
+	}
+	my %edited;
+	for my $f (keys %repoint) {
+		my $text = slurp($f);
+		(my $fdir = $f) =~ s{/?[^/]*\z}{};
+		my $depth = $fdir eq '' ? 0 : 1 + ($fdir =~ tr{/}{});
+		for my $e (@{$repoint{$f}}) {
+			my ($src, $dst) = @$e;
+			$text =~ s{^(\h*#\h*include\h*")((?:\.\./)*)\Q$src\E(")}{
+				include_names_root($2, $depth, $fdir, $src)
+					? "$1$dst$3" : "$1$2$src$3"
+			}egm;
+		}
+		$edited{$f} = $text;
+	}
+	return \%edited;
+}
+
+# For each accepted header move, repoint the tutorial #include "foo.h" example
+# lines. A tutorial always names the full new path, so the repoint is
+# unconditional (no shadow/depth resolution) and matches the #include anywhere
+# in the line, at the start of a code block or in backticks mid-prose. Only the
+# quoted path changes; the #include spelling is left as written. Returns
+# tutorial path -> edited content.
+sub adoc_edits {
+	my ($moves) = @_;
+	my %repoint;   # tutorial -> list of [src, dst]
+	for my $m (@$moves) {
+		my ($src, $dst) = @$m;
+		next unless $src =~ /\.h\z/;
+		(my $re = $src) =~ s/\./\\./g;
+		my $apat = '#[[:blank:]]*include[[:blank:]]*"' . $re . '"';
+		my $grep = "git grep -lE '$apat' --"
+			. " 'Documentation/*.adoc' 'Documentation/**/*.adoc'"
+			. " ':(exclude)t/t[0-9][0-9][0-9][0-9]/**'";
+		for my $doc (split /\n/, `$grep`) {
+			push @{$repoint{$doc}}, [$src, $dst];
+		}
+	}
+	my %edited;
+	for my $f (keys %repoint) {
+		my $text = slurp($f);
+		for my $e (@{$repoint{$f}}) {
+			my ($src, $dst) = @$e;
+			$text =~ s{(#\h*include\h*")\Q$src\E(")}{$1$dst$2}g;
+		}
+		$edited{$f} = $text;
+	}
+	return \%edited;
+}
+
+# === Phase 3: collect the edits over the accepted moves ===
+# A rejected move stays at the root, so its build references, includers, and
+# tutorials keep naming it unchanged.
+my $build = build_edits(\@accepted);
+my $includers = include_edits(\@accepted);
+my $tutorials = adoc_edits(\@accepted);
+
+# === Phase 4: emit the patch ===
+my $tmp = tempdir(CLEANUP => 1);
+# hunk body (from the first @@) of a diff between $orig and the edited $text
+sub hunk {
+	my ($orig, $text) = @_;
+	open my $o, '>', "$tmp/e" or die; print {$o} $text; close $o;
+	my $d = `git diff --no-index -- "$orig" "$tmp/e"`;
+	my $i = index($d, "\n\@\@");
+	return $i < 0 ? '' : substr($d, $i + 1);
+}
+# A file's diff for the emitted patch: a plain hunk when $from and $to match, a
+# rename-with-modification when they differ. An empty $hunk yields no diff.
+sub diff_hunk {
+	my ($from, $to, $hunk) = @_;
+	return '' unless length $hunk;
+	my $out = "diff --git a/$from b/$to\n";
+	$out .= "rename from $from\nrename to $to\n" if $from ne $to;
+	return $out . "--- a/$from\n+++ b/$to\n$hunk";
+}
+
+# One diff per edited file, in a fixed order: build files, then includers, then
+# tutorials. A build file and a tutorial stay in place; an includer that itself
+# moves is a rename-with-modification (its new path is $dst_of{$f}).
+my $patch = '';
+for my $f (@buildfiles) {
+	next unless defined $build->{$f};
+	my $orig = slurp($f);
+	next if $build->{$f} eq $orig;
+	$patch .= diff_hunk($f, $f, hunk($f, $build->{$f}));
+}
+for my $f (sort keys %$includers) {
+	$patch .= diff_hunk($f, $dst_of{$f} // $f, hunk($f, $includers->{$f}));
+}
+for my $f (sort keys %$tutorials) {
+	$patch .= diff_hunk($f, $f, hunk($f, $tutorials->{$f}));
+}
+
+print "$protocol\n";
+print "reject $_->[0] $_->[1]\n" for @rejects;
+if (length $patch) { print "patch\n"; print $patch; }
diff --git a/meson.build b/meson.build
index a2d987b124..38ec7d4f40 100644
--- a/meson.build
+++ b/meson.build
@@ -443,7 +443,9 @@ libgit_sources = [
   'oidset.c',
   'oidtree.c',
   'organize/gitorganize-format.c',
+  'organize/labeler-protocol.c',
   'organize/organize.c',
+  'organize/organizer-protocol.c',
   'pack-bitmap-write.c',
   'pack-bitmap.c',
   'pack-check.c',
diff --git a/organize/gitorganize-format.c b/organize/gitorganize-format.c
index cdade12f5b..541dd373aa 100644
--- a/organize/gitorganize-format.c
+++ b/organize/gitorganize-format.c
@@ -246,6 +246,11 @@ void gitorganize_write(struct gitorganize *g)
 	else
 		strbuf_addstr(&out, "[layout]\n");
 	strbuf_addstr(&out, "[labels]\n");
+	strbuf_addstr(&out,
+		      "# The recorded placement of each source; edit a line to "
+		      "change it.\n"
+		      "# apply --labels-only fills in unrecorded sources; "
+		      "--reseed re-derives all.\n");
 	for (size_t i = 0; i < g->records.nr; i++) {
 		const char *labels = g->records.items[i].util;
 
diff --git a/organize/labeler-protocol.c b/organize/labeler-protocol.c
new file mode 100644
index 0000000000..6541412c18
--- /dev/null
+++ b/organize/labeler-protocol.c
@@ -0,0 +1,52 @@
+#include "git-compat-util.h"
+#include "labeler-protocol.h"
+#include "gettext.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "strvec.h"
+#include "wrapper.h"
+
+/*
+ * Run the labeler and record, in `labeled` (path -> its "k=value k=value" string in
+ * util), each scoped_files file it labels. The labeler writes `path \0 labels \0`
+ * per file, where labels is its space-separated key=value labels.
+ */
+void run_labeler(const char *cmd, struct string_list *scoped_files,
+		 struct string_list *labeled)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	const char *p, *end;
+
+	strvec_push(&cp.args, cmd);
+	cp.use_shell = 1;
+	if (capture_command(&cp, &out, 0))
+		die(_("organize apply --labels-only: labeler failed: %s"), cmd);
+
+	p = out.buf;
+	end = out.buf + out.len;
+	while (p < end) {
+		const char *path = p;
+		const char *labels;
+
+		p += strlen(p) + 1;
+		if (p > end)
+			die(_("organize apply --labels-only: truncated labeler record"));
+		labels = p;
+		p += strlen(p) + 1;
+		if (p > end)
+			die(_("organize apply --labels-only: truncated labeler record"));
+		if (strchr(labels, '\n'))
+			die(_("organize apply --labels-only: a label must not "
+			      "contain a newline: %s"), path);
+
+		if (!string_list_has_string(scoped_files, path))
+			continue;	/* not a scoped_files file */
+		if (string_list_has_string(labeled, path))
+			die(_("organize: duplicate labeler record for '%s'"),
+			    path);
+		string_list_insert(labeled, path)->util = xstrdup(labels);
+	}
+	strbuf_release(&out);
+}
diff --git a/organize/labeler-protocol.h b/organize/labeler-protocol.h
new file mode 100644
index 0000000000..0c2ea01686
--- /dev/null
+++ b/organize/labeler-protocol.h
@@ -0,0 +1,15 @@
+#ifndef LABELER_PROTOCOL_H
+#define LABELER_PROTOCOL_H
+
+struct string_list;
+
+/*
+ * The labeler protocol. git organize runs the configured labeler and
+ * records, in `labeled` (path -> its "k=value ..." string in util), the
+ * labels it returns for every file in `scoped_files`. The labeler writes one
+ * `path \0 labels \0` record per file.
+ */
+void run_labeler(const char *cmd, struct string_list *scoped_files,
+		 struct string_list *labeled);
+
+#endif /* LABELER_PROTOCOL_H */
diff --git a/organize/organize.c b/organize/organize.c
index 0d9850dfc0..8c623444c0 100644
--- a/organize/organize.c
+++ b/organize/organize.c
@@ -1,6 +1,9 @@
 #include "git-compat-util.h"
 #include "organize.h"
 #include "gitorganize-format.h"
+#include "labeler-protocol.h"
+#include "organizer-protocol.h"
+#include "config.h"
 #include "gettext.h"
 #include "pathspec.h"
 #include "quote.h"
@@ -13,6 +16,19 @@
 #include "wrapper.h"
 #include "wt-status.h"
 
+/* The configured command organize.<key> (labeler or organizer), or NULL. */
+static const char *organize_command(struct repository *repo, const char *key)
+{
+	struct strbuf k = STRBUF_INIT;
+	const char *cmd;
+
+	strbuf_addf(&k, "organize.%s", key);
+	if (repo_config_get_string_tmp(repo, k.buf, &cmd))
+		cmd = NULL;
+	strbuf_release(&k);
+	return cmd;
+}
+
 /*
  * The [layout] rule whose directory equals `path`'s directory, or NULL when
  * `path` is a root file or its directory matches no rule. A file in a [layout]
@@ -114,6 +130,7 @@ static void add_move(struct organize_plan *plan, const char *src,
 	m->src = xstrdup(src);
 	m->dst = dst;
 	m->rule_value = xstrdup(value);
+	m->skip_reason = NULL;
 }
 
 void organize_plan_build(struct repository *repo, struct organize_plan *plan)
@@ -202,25 +219,66 @@ static int worktree_dirty(struct repository *repo)
 	return has_unstaged_changes(repo, 0) || has_uncommitted_changes(repo, 0);
 }
 
-/* Map each move's src to its dst, in `dst_of`. */
+/* Map each standing (non-rejected) move's src to its dst, in `dst_of`. */
 static void plan_dst_map(struct organize_plan *plan, struct string_list *dst_of)
 {
 	for (size_t i = 0; i < plan->moves_nr; i++)
-		string_list_insert(dst_of, plan->moves[i].src)->util =
-			plan->moves[i].dst;
+		if (!plan->moves[i].skip_reason)
+			string_list_insert(dst_of, plan->moves[i].src)->util =
+				plan->moves[i].dst;
+}
+
+/*
+ * Emit `<prefix><name>` for a `diff --git` header the way git's diff does: when
+ * the prefixed path needs C-quoting, wrap the whole unit in one pair of double
+ * quotes ("a/<escaped>") rather than quoting the name alone. An ordinary path
+ * is emitted verbatim, so the header is byte-identical to git's diff.
+ */
+static void add_diff_git_path(struct strbuf *out, const char *prefix,
+			      const char *name)
+{
+	if (quote_c_style(prefix, NULL, NULL, CQUOTE_NODQ) ||
+	    quote_c_style(name, NULL, NULL, CQUOTE_NODQ)) {
+		strbuf_addch(out, '"');
+		quote_c_style(prefix, out, NULL, CQUOTE_NODQ);
+		quote_c_style(name, out, NULL, CQUOTE_NODQ);
+		strbuf_addch(out, '"');
+	} else {
+		strbuf_addstr(out, prefix);
+		strbuf_addstr(out, name);
+	}
 }
 
-/* A content-identical rename entry per move. */
-static void build_rename_patch(struct organize_plan *plan, struct strbuf *out)
+/*
+ * A content-identical rename entry per standing move the organizer did not
+ * claim. A claimed move is one the organizer renames itself, with content
+ * changes, so git leaves that entry to the organizer's patch.
+ */
+static void build_rename_patch(struct organize_plan *plan,
+			       struct string_list *claimed, struct strbuf *out)
 {
 	for (size_t i = 0; i < plan->moves_nr; i++) {
 		struct organize_move *m = &plan->moves[i];
 
-		/* These are tracked_files source paths, which need no quoting. */
-		strbuf_addf(out, "diff --git a/%s b/%s\n", m->src, m->dst);
+		if (m->skip_reason || string_list_has_string(claimed, m->src))
+			continue;
+		/*
+		 * C-quote the paths the way git's diff does, so a byte special
+		 * to the patch format (newline, quote, ...) is escaped. An
+		 * ordinary path passes through unquoted, so this is byte-for-
+		 * byte git's rename header.
+		 */
+		strbuf_addstr(out, "diff --git ");
+		add_diff_git_path(out, "a/", m->src);
+		strbuf_addch(out, ' ');
+		add_diff_git_path(out, "b/", m->dst);
+		strbuf_addch(out, '\n');
 		strbuf_addstr(out, "similarity index 100%\n");
-		strbuf_addf(out, "rename from %s\n", m->src);
-		strbuf_addf(out, "rename to %s\n", m->dst);
+		strbuf_addstr(out, "rename from ");
+		quote_c_style(m->src, out, NULL, 0);
+		strbuf_addstr(out, "\nrename to ");
+		quote_c_style(m->dst, out, NULL, 0);
+		strbuf_addch(out, '\n');
 	}
 }
 
@@ -235,7 +293,8 @@ static int git_apply_index(const char *patch, size_t len)
 
 /*
  * Repoint each carved file's [labels] line to its new path, carrying its labels
- * unchanged: only its location changes. Returns nonzero when [labels] changed.
+ * unchanged: only its location changes. A rejected move stays put and keeps its
+ * line. Returns nonzero when [labels] changed.
  */
 static int repoint_moved_declarations(struct organize_plan *plan)
 {
@@ -278,19 +337,32 @@ static int repoint_moved_declarations(struct organize_plan *plan)
 void organize_plan_apply(struct repository *repo, struct organize_plan *plan)
 {
 	struct strbuf patch = STRBUF_INIT;
+	struct strbuf combined = STRBUF_INIT;
+	struct string_list claimed = STRING_LIST_INIT_DUP;
+	const char *organizer;
 
 	if (worktree_dirty(repo))
 		die(_("organize apply: the worktree has uncommitted changes; "
 		      "commit or stash first"));
 
+	organizer = organize_command(repo, "organizer");
+	if (organizer)
+		run_organizer(organizer, plan, &patch, &claimed);
+
 	/*
-	 * Content-identical renames for every move, applied as one
-	 * git apply --index transaction, so a failure leaves the tree untouched.
+	 * Content-identical renames for every unclaimed move, then the
+	 * organizer's edits (when any), apply as one git apply --index: git
+	 * checks the whole patch before it writes, so a patch that does not
+	 * apply changes nothing. The [labels] update in .gitorganize follows the
+	 * apply and is staged separately rather than as part of it.
 	 */
-	build_rename_patch(plan, &patch);
-	if (patch.len && git_apply_index(patch.buf, patch.len))
+	build_rename_patch(plan, &claimed, &combined);
+	if (patch.len)
+		strbuf_addbuf(&combined, &patch);
+	if (combined.len && git_apply_index(combined.buf, combined.len))
 		die(_("organize apply: the change does not apply cleanly; "
 		      "nothing was changed"));
+	strbuf_release(&combined);
 
 	if (repoint_moved_declarations(plan)) {
 		struct child_process add = CHILD_PROCESS_INIT;
@@ -302,15 +374,80 @@ void organize_plan_apply(struct repository *repo, struct organize_plan *plan)
 			      "restore with git reset --hard"));
 	}
 
+	string_list_clear(&claimed, 0);
 	strbuf_release(&patch);
 }
 
+void organize_run_labeler(struct repository *repo, int reseed)
+{
+	struct organize_ctx ctx = ORGANIZE_CTX_INIT;
+	struct string_list labeled = STRING_LIST_INIT_DUP;
+	struct string_list records = STRING_LIST_INIT_DUP;
+	struct child_process add = CHILD_PROCESS_INIT;
+	const char *cmd;
+
+	organize_ctx_load(repo, &ctx);
+	cmd = organize_command(repo, "labeler");
+	if (!cmd)
+		die(_("organize: organize.labeler is not set"));
+	run_labeler(cmd, &ctx.scoped_files, &labeled);
+
+	/*
+	 * A [labels] line for every scoped_files file. A file already recorded
+	 * keeps its line: the recorded placement is authoritative, so a decision
+	 * made by hand or in an earlier run survives, and the labeler only seeds a
+	 * file it has not yet placed. With reseed, take the labeler's fresh label
+	 * for every file instead, discarding the recorded placements. Walking the
+	 * scoped_files set keeps a new, unrecorded source visible either way. The
+	 * loop below then preserves every placed file already listed.
+	 */
+	for (size_t i = 0; i < ctx.scoped_files.nr; i++) {
+		const char *path = ctx.scoped_files.items[i].string;
+		struct string_list_item *rec =
+			string_list_lookup(&ctx.gitorg.records, path);
+		struct string_list_item *it;
+
+		if (rec && !reseed) {
+			string_list_insert(&records, path)->util =
+				xstrdup((const char *)rec->util);
+			continue;
+		}
+		if (layout_dir_rule(&ctx.gitorg, path))
+			continue;	/* placed by its directory; no line needed */
+		it = string_list_lookup(&labeled, path);
+		string_list_insert(&records, path)->util =
+			xstrdup(it ? (const char *)it->util : "");
+	}
+	for (size_t i = 0; i < ctx.gitorg.records.nr; i++) {
+		const char *path = ctx.gitorg.records.items[i].string;
+
+		if (strchr(path, '/') &&
+		    string_list_has_string(&ctx.tracked_files, path) &&
+		    !string_list_has_string(&records, path))
+			string_list_insert(&records, path)->util =
+				xstrdup(ctx.gitorg.records.items[i].util);
+	}
+
+	string_list_clear(&ctx.gitorg.records, 1);
+	ctx.gitorg.records = records;	/* ctx.gitorg owns the fresh [labels] */
+	gitorganize_write(&ctx.gitorg);
+
+	add.git_cmd = 1;
+	strvec_pushl(&add.args, "add", ".gitorganize", NULL);
+	if (run_command(&add))
+		die(_("organize apply --labels-only: staging .gitorganize failed"));
+
+	organize_ctx_release(&ctx);
+	string_list_clear(&labeled, 1);
+}
+
 void organize_plan_release(struct organize_plan *plan)
 {
 	for (size_t i = 0; i < plan->moves_nr; i++) {
 		free(plan->moves[i].src);
 		free(plan->moves[i].dst);
 		free(plan->moves[i].rule_value);
+		free(plan->moves[i].skip_reason);
 	}
 	FREE_AND_NULL(plan->moves);
 	plan->moves_nr = plan->moves_alloc = 0;
diff --git a/organize/organize.h b/organize/organize.h
index c26453d2be..84e6558f8b 100644
--- a/organize/organize.h
+++ b/organize/organize.h
@@ -15,30 +15,42 @@ struct repository;
  *   [scope]    the scope pathspecs, one per line; no [scope] section means
  *     nothing is in scope.
  *
- *   [layout]   the project's placement map, hand-authored: ordered
- *     `<label>:<value> = <directory>` rules (`.` is the root). A file's labels
- *     are matched against the rules in order, and the first rule it satisfies
- *     places it; a file matching no rule is backlog. Only a label named in
- *     a rule places a file.
+ *   [layout]   the project's directory map, hand-authored: ordered
+ *     `<label>:<value> = <directory>` rules (`.` is the root). git organize
+ *     matches a file's labels against the rules in order; the first rule it
+ *     satisfies names the file's directory. A file matching no rule is backlog.
+ *     Only a rule named in [layout] moves a file.
  *
  *   [labels]   the recorded labels, one line per source in scope, `<path> <key>=
- *     <value> ...`, with every label the project defines. Placed files are listed
- *     too, so a placed file's [labels] line records its labels, independently of
- *     the directory name.
+ *     <value> ...`, with every label the project defines. A file already in its
+ *     directory is listed too, so its [labels] line records its labels, apart
+ *     from the directory name. A label named in no rule moves no file; git
+ *     organize records it for a reader.
+ *
+ * The labeler and organizer commands live in config, organize.labeler and
+ * organize.organizer.
  *
  *   status  Read [labels] and report the files in scope whose matching rule
  *     names a directory they are not in yet (the moves), the backlog, and a
  *     recorded path that no longer exists.
  *
- *   apply   Perform the moves. A move is a content-identical rename, applied as
- *     one git apply --index transaction. A carved file's [labels] line is
- *     repointed to its new path, carrying its labels.
+ *   apply   Perform the moves. A move is a content-preserving rename. When an
+ *     organizer is configured, hand it the moves; it returns edits to referring
+ *     files as a patch and a reason for any move it declines. Moves and the
+ *     patch apply as one git apply. With no organizer, each move is a plain git
+ *     mv. A carved file's [labels] line is repointed to its new path, carrying
+ *     its labels.
+ *
+ *   apply --labels-only  Run the labeler and write a [labels] line for every
+ *     file in scope, keeping the line of a file already in its directory.
+ *     Staged. This is the only path that runs a labeler.
  */
 
 struct organize_move {
 	char *src;	/* current path */
 	char *dst;	/* declared path */
-	char *rule_value;	/* the matched rule's value */
+	char *rule_value;	/* the matched rule's value, sent to the organizer */
+	char *skip_reason;	/* why the organizer declined it; NULL when it stands */
 };
 
 struct organize_plan {
@@ -67,11 +79,21 @@ struct organize_plan {
 void organize_plan_build(struct repository *repo, struct organize_plan *plan);
 
 /*
- * Perform the plan: apply the moves as one content-identical-rename
- * transaction; the result is staged. Requires a clean worktree.
+ * Perform the plan: consult the organizer when one is configured, then apply
+ * the standing moves and the organizer's patch; the result is staged.
+ * Requires a clean worktree. Records each declined move's reason in the plan.
  */
 void organize_plan_apply(struct repository *repo, struct organize_plan *plan);
 
+/*
+ * Fill the [labels] record for every file in scope, staged. A file already
+ * recorded keeps its line (the recorded placement is authoritative); an
+ * unrecorded file is seeded from the labeler (its labels, or empty when the
+ * labeler leaves it unplaced). With reseed, re-derive every line from the
+ * labeler, discarding the recorded placements.
+ */
+void organize_run_labeler(struct repository *repo, int reseed);
+
 void organize_plan_release(struct organize_plan *plan);
 
 #endif /* ORGANIZE_H */
diff --git a/organize/organizer-protocol.c b/organize/organizer-protocol.c
new file mode 100644
index 0000000000..d50617e010
--- /dev/null
+++ b/organize/organizer-protocol.c
@@ -0,0 +1,254 @@
+#include "git-compat-util.h"
+#include "organizer-protocol.h"
+#include "organize.h"
+#include "gitorganize-format.h"
+#include "apply.h"
+#include "gettext.h"
+#include "quote.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "strvec.h"
+#include "wrapper.h"
+
+#define ORGANIZE_PROTOCOL "git-organize 1 organize"
+
+/* Record a skip reason for a standing move, taking ownership of `reason`. */
+static void reject_move(struct organize_plan *plan, const char *src,
+			char *reason)
+{
+	for (size_t move_idx = 0; move_idx < plan->moves_nr; move_idx++) {
+		struct organize_move *move = &plan->moves[move_idx];
+
+		if (!strcmp(move->src, src)) {
+			free(move->skip_reason);
+			move->skip_reason = reason;
+			return;
+		}
+	}
+	free(reason);	/* a skip_reason for a move we did not propose is ignored */
+}
+
+/* Serialize the standing moves as the organizer request. */
+static void build_request(struct organize_plan *plan, struct strbuf *request)
+{
+	strbuf_addstr(request, ORGANIZE_PROTOCOL "\n");
+	for (size_t move_idx = 0; move_idx < plan->moves_nr; move_idx++) {
+		struct organize_move *move = &plan->moves[move_idx];
+
+		if (move->skip_reason)
+			continue;
+		strbuf_addstr(request, "move ");
+		quote_c_style(move->src, request, NULL, 0);
+		strbuf_addch(request, ' ');
+		quote_c_style(move->dst, request, NULL, 0);
+		strbuf_addf(request, " %s\n", move->rule_value);
+	}
+}
+
+/* The next "diff --git " line, at column 0, at or after `from`, or `end`. */
+static const char *next_entry(const char *from, const char *end)
+{
+	while (from < end) {
+		if (starts_with(from, "diff --git "))
+			return from;
+		from = memchr(from, '\n', end - from);
+		if (!from)
+			return end;
+		from++;
+	}
+	return end;
+}
+
+/*
+ * Whether an entry's text mentions a directory the plan moves into, so that an
+ * in-place edit is one that repoints a reference toward a moved file rather
+ * than an edit of an unrelated file.
+ */
+static int repoints_a_move(const char *entry, const char *entry_end,
+			   const struct string_list *dstdirs)
+{
+	for (size_t i = 0; i < dstdirs->nr; i++) {
+		const char *dir = dstdirs->items[i].string;
+
+		if (memmem(entry, entry_end - entry, dir, strlen(dir)))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * The organizer is a trusted command that the repository configures, like a
+ * clean or smudge filter. This is an integrity check on the organizer patch,
+ * not a sandbox against a hostile organizer. It reads each entry's per-entry
+ * header with git's own diff-header parser (parse_git_diff_header), the same
+ * names `git apply` acts on, and refuses a header that steps outside the plan.
+ * It does not confine what the hunks the applying patch carries may change.
+ *
+ * Check each entry's header and record which moves the patch claims. An entry
+ * is one of:
+ *   - old == new: an in-place edit. The file must stay put (not be a move) and
+ *     the edit must repoint a reference into a directory the plan moves a file
+ *     into, which bounds a mistaken organizer to files the moves touch.
+ *   - old != new: a rename-with-modification. It must match a planned move
+ *     (old -> new), which git organize then assigns to the organizer (a claim).
+ * Refuse a header that adds, deletes, or copies a file, or changes a file's
+ * mode; git organize controls which files exist and their modes. The patch
+ * must be in git diff format.
+ */
+static void validate_patch(struct organize_plan *plan,
+			   const struct strbuf *patch,
+			   struct string_list *claimed)
+{
+	struct string_list dst_map = STRING_LIST_INIT_NODUP;
+	struct string_list dstdirs = STRING_LIST_INIT_DUP;
+	struct strbuf root = STRBUF_INIT;
+	const char *cursor = patch->buf;
+	const char *end = patch->buf + patch->len;
+
+	for (size_t move_idx = 0; move_idx < plan->moves_nr; move_idx++) {
+		struct organize_move *move = &plan->moves[move_idx];
+		const char *slash;
+
+		if (move->skip_reason)
+			continue;
+		string_list_insert(&dst_map, move->src)->util = move->dst;
+		slash = strrchr(move->dst, '/');
+		if (slash) {
+			struct strbuf dir = STRBUF_INIT;
+
+			strbuf_add(&dir, move->dst, slash - move->dst + 1);
+			string_list_insert(&dstdirs, dir.buf);
+			strbuf_release(&dir);
+		}
+	}
+
+	while (cursor < end && *cursor == '\n')
+		cursor++;
+	if (cursor < end && !starts_with(cursor, "diff --git "))
+		die(_("organize apply: the organizer patch is not in git diff format"));
+
+	while (cursor < end && starts_with(cursor, "diff --git ")) {
+		const char *newline = memchr(cursor, '\n', end - cursor);
+		size_t first = newline ? (size_t)(newline - cursor + 1)
+				       : (size_t)(end - cursor);
+		struct patch entry;
+		int linenr = 0, hdrlen;
+		const char *old_name, *new_name, *entry_end;
+		struct string_list_item *dst;
+
+		memset(&entry, 0, sizeof(entry));
+		hdrlen = parse_git_diff_header(&root, NULL, &linenr, 1, cursor,
+					       first, end - cursor, &entry);
+		if (hdrlen < 0)
+			die(_("organize apply: cannot parse the organizer patch"));
+		entry_end = next_entry(cursor + hdrlen, end);
+		if (entry.is_new || entry.is_delete || entry.is_copy)
+			die(_("organize apply: the organizer patch must not add, "
+			      "delete, or copy files"));
+		if (entry.old_mode != entry.new_mode)
+			die(_("organize apply: the organizer patch must not change "
+			      "a file's mode"));
+		old_name = entry.old_name ? entry.old_name : entry.def_name;
+		new_name = entry.new_name ? entry.new_name : entry.def_name;
+		if (!old_name || !new_name)
+			die(_("organize apply: cannot tell which file the organizer "
+			      "patch touches"));
+
+		dst = string_list_lookup(&dst_map, old_name);
+		if (!strcmp(old_name, new_name)) {
+			if (dst)
+				die(_("organize apply: the organizer patch edits %s "
+				      "in place, but it is part of a move"), old_name);
+			if (!repoints_a_move(cursor, entry_end, &dstdirs))
+				die(_("organize apply: the organizer patch edits %s "
+				      "in place, but the edit does not repoint a "
+				      "move"), old_name);
+		} else if (!dst || strcmp(dst->util, new_name)) {
+			die(_("organize apply: the organizer patch renames %s to %s, "
+			      "which is not a planned move"), old_name, new_name);
+		} else {
+			string_list_insert(claimed, old_name);
+		}
+		release_patch(&entry);
+		cursor = entry_end;
+	}
+
+	string_list_clear(&dst_map, 0);
+	string_list_clear(&dstdirs, 0);
+	strbuf_release(&root);
+}
+
+/*
+ * Parse the organizer response: the version line, then the reject directives
+ * and the optional patch, which is validated against the plan.
+ */
+static void parse_response(struct organize_plan *plan,
+			   const struct strbuf *response, struct strbuf *patch,
+			   struct string_list *claimed)
+{
+	const char *cursor = response->buf;
+	const char *end = response->buf + response->len;
+	struct strbuf path = STRBUF_INIT;
+
+	if (!skip_prefix(cursor, ORGANIZE_PROTOCOL, &cursor) || *cursor != '\n')
+		die(_("organize: organizer did not send the protocol header '%s'"),
+		    ORGANIZE_PROTOCOL);
+	cursor++;
+
+	while (cursor < end) {
+		const char *newline = memchr(cursor, '\n', end - cursor);
+		const char *args;
+
+		if (!newline)
+			die(_("organize: truncated organizer response"));
+
+		if (skip_prefix(cursor, "reject ", &args)) {
+			const char *reason = read_path_token(args, &path);
+
+			/*
+			 * read_path_token on a quoted path unquotes past a raw
+			 * newline, so its end (or the trimmed reason) can lie
+			 * beyond this line's newline; a negative length would
+			 * wrap in xstrndup below.
+			 */
+			if (reason > newline)
+				die(_("organize: malformed reject line"));
+			while (reason < newline && *reason == ' ')
+				reason++;
+			reject_move(plan, path.buf,
+				    xstrndup(reason, newline - reason));
+			cursor = newline + 1;
+		} else if (starts_with(cursor, "patch\n")) {
+			const char *body = newline + 1;
+
+			strbuf_add(patch, body, end - body);
+			if (patch->len)
+				validate_patch(plan, patch, claimed);
+			break;
+		} else if (newline == cursor) {
+			cursor = newline + 1;	/* skip a blank line */
+		} else {
+			die(_("organize: unexpected organizer line"));
+		}
+	}
+	strbuf_release(&path);
+}
+
+/* Run the organizer over the standing moves, then validate its patch. */
+void run_organizer(const char *command, struct organize_plan *plan,
+		   struct strbuf *patch, struct string_list *claimed)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+	struct strbuf request = STRBUF_INIT, response = STRBUF_INIT;
+
+	build_request(plan, &request);
+	strvec_push(&child.args, command);
+	child.use_shell = 1;
+	if (pipe_command(&child, request.buf, request.len, &response,
+			 0, NULL, 0))
+		die(_("organize: organizer failed: %s"), command);
+	parse_response(plan, &response, patch, claimed);
+	strbuf_release(&request);
+	strbuf_release(&response);
+}
diff --git a/organize/organizer-protocol.h b/organize/organizer-protocol.h
new file mode 100644
index 0000000000..4159d4ef24
--- /dev/null
+++ b/organize/organizer-protocol.h
@@ -0,0 +1,18 @@
+#ifndef ORGANIZER_PROTOCOL_H
+#define ORGANIZER_PROTOCOL_H
+
+struct organize_plan;
+struct strbuf;
+struct string_list;
+
+/*
+ * The organizer protocol. git organize sends the standing moves to the
+ * configured organizer, which may reject moves or return a patch of content
+ * edits. run_organizer validates that patch against the plan, fills `patch`
+ * with the edits and `claimed` with the moves the organizer renames itself,
+ * and records each rejected move on the plan.
+ */
+void run_organizer(const char *command, struct organize_plan *plan,
+		   struct strbuf *patch, struct string_list *claimed);
+
+#endif /* ORGANIZER_PROTOCOL_H */
diff --git a/t/t0096-organize.sh b/t/t0096-organize.sh
index a352a1c7d1..c2e6539ef2 100755
--- a/t/t0096-organize.sh
+++ b/t/t0096-organize.sh
@@ -4,9 +4,39 @@ test_description='git organize reconciles a tree against a declared layout'
 
 . ./test-lib.sh
 
-# There is no labeler yet, so tests write .gitorganize by hand: root *.c/*.h in
-# scope, odb/refs components, and a [labels] census.
-write_declaration () {
+# A labeler records blob.c under odb, refs.c under refs, header.h as public.
+# It writes a NUL-separated path and key=value label record per file.
+write_labeler () {
+	write_script labeler <<-\EOF
+	printf 'blob.c\0component=odb role=lib\0'
+	printf 'refs.c\0component=refs role=lib\0'
+	printf 'header.h\0component=? role=public\0'
+	EOF
+}
+
+# Point a stub organizer at the patch on its standard input; $2, if given, is
+# the reason it declines a move.
+write_organizer () {
+	cat >"$1.patch" &&
+	write_script "$1" <<-EOF
+	cat >/dev/null
+	printf 'git-organize 1 organize\n'
+	${2:+printf 'reject %s\n' '$2'}
+	printf 'patch\n'
+	cat $1.patch
+	EOF
+}
+
+# Point organize at the given labeler (and optional organizer), the way a
+# project points a merge driver at a command, and write the project-authored
+# [scope] pathspecs and [layout] rules: role:public and role:program keep a
+# file at the root (first match wins), a component value routes to its directory.
+configure_organize () {
+	git config organize.labeler "$1" &&
+	if test $# -gt 1
+	then
+		git config organize.organizer "$2"
+	fi &&
 	cat >.gitorganize <<-\EOF
 	[scope]
 	:(glob)*.c
@@ -16,24 +46,106 @@ write_declaration () {
 	role:program = .
 	component:odb = odb
 	component:refs = refs
-	[labels]
-	blob.c component=odb role=lib
-	header.h component=? role=public
-	refs.c component=refs role=lib
 	EOF
 }
 
-test_expect_success 'setup a tree and a declaration' '
+test_expect_success 'setup a tree and a labeler' '
 	echo blob >blob.c &&
 	echo refs >refs.c &&
 	echo header >header.h &&
 	git add . &&
 	git commit -m init &&
-	write_declaration &&
+	write_labeler &&
+	configure_organize ./labeler &&
 	git add .gitorganize &&
 	git commit -m declare
 '
 
+test_expect_success 'apply --labels-only records the labels' '
+	git organize apply --labels-only &&
+	cat >expect <<-\EOF &&
+	[scope]
+	:(glob)*.c
+	:(glob)*.h
+	[layout]
+	role:public = .
+	role:program = .
+	component:odb = odb
+	component:refs = refs
+	[labels]
+	# The recorded placement of each source; edit a line to change it.
+	# apply --labels-only fills in unrecorded sources; --reseed re-derives all.
+	blob.c component=odb role=lib
+	header.h component=? role=public
+	refs.c component=refs role=lib
+	EOF
+	test_cmp expect .gitorganize &&
+	git diff --cached --name-only >staged &&
+	test_grep "^.gitorganize$" staged &&
+	git commit -m labels
+'
+
+test_expect_success 'apply --labels-only preserves a recorded label; --reseed re-derives' '
+	git init preserve &&
+	(
+		cd preserve &&
+		echo blob >blob.c &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		configure_organize ./labeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		test_grep "^blob.c component=odb" .gitorganize &&
+		# a hand-made placement decision the labeler would not make
+		sed "s|^blob.c component=odb|blob.c component=refs|" .gitorganize >edited &&
+		mv edited .gitorganize &&
+		# a plain re-run keeps the recorded decision
+		git organize apply --labels-only &&
+		test_grep "^blob.c component=refs" .gitorganize &&
+		test_grep ! "^blob.c component=odb" .gitorganize &&
+		# --reseed discards it and re-derives from the labeler
+		git organize apply --labels-only --reseed &&
+		test_grep "^blob.c component=odb" .gitorganize
+	)
+'
+
+test_expect_success 'a file added under a carved directory is governed in place' '
+	git init subdirs &&
+	(
+		cd subdirs &&
+		echo blob >blob.c &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		configure_organize ./labeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		git organize apply &&
+		git commit -m carve &&
+		test_path_is_file odb/blob.c &&
+		# the carved file alone is in scope and in place
+		git organize status >before &&
+		test_grep "1 in scope" before &&
+		# a NEW file added directly under the carved odb/ directory is
+		# governed by its location: in scope and in place, not invisible
+		echo extra >odb/extra.c &&
+		git add odb/extra.c &&
+		git organize status >after &&
+		test_grep "2 in scope (2 in place" after &&
+		git organize status --exit-code &&
+		# a file outside any [layout] directory stays ungoverned
+		mkdir vendor &&
+		echo v >vendor/z.c &&
+		git add vendor/z.c &&
+		git organize status >vend &&
+		test_grep "2 in scope" vend
+	)
+'
+
 test_expect_success 'status reports the files to move' '
 	git organize status >actual &&
 	# header.h is public (in place at root); blob.c and refs.c move next
@@ -74,47 +186,319 @@ test_expect_success 'apply refuses a dirty worktree' '
 		echo other >other.c &&
 		git add . &&
 		git commit -m init &&
-		cat >.gitorganize <<-\EOF &&
-		[scope]
-		:(glob)*.c
-		[layout]
-		component:odb = odb
-		[labels]
-		blob.c component=odb
-		other.c component=?
-		EOF
+		write_labeler &&
+		configure_organize ./labeler &&
 		git add .gitorganize &&
 		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
 		echo dirty >>other.c &&
 		test_must_fail git organize apply 2>err &&
 		test_grep "uncommitted changes" err
 	)
 '
 
-test_expect_success 'a file in scope with no matching rule is backlog' '
-	git init backlog &&
+test_expect_success 'organizer may decline a move and patch a referrer' '
+	git init sub &&
+	(
+		cd sub &&
+		echo blob >blob.c &&
+		echo refs >refs.c &&
+		printf "blob.o\n" >build.list &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		write_organizer organizer "refs.c held for test" <<-\EOF &&
+		diff --git a/build.list b/build.list
+		--- a/build.list
+		+++ b/build.list
+		@@ -1 +1 @@
+		-blob.o
+		+odb/blob.o
+		EOF
+		configure_organize ./labeler ./organizer &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		git organize apply >out &&
+		test_grep "1 move(s), 1 skipped" out &&
+		test_grep "skipped refs.c" out &&
+		git diff --cached -M --name-status >actual &&
+		test_grep "^R100.*blob.c.*odb/blob.c" actual &&
+		test_grep "^M.*build.list" actual &&
+		echo odb/blob.o >expect &&
+		test_cmp expect build.list &&
+		test_path_is_file refs.c &&
+		test_path_is_file odb/blob.c &&
+		test_path_is_missing blob.c &&
+		# the carved file is repointed; the declined file keeps its line
+		test_grep "^odb/blob.c component=odb" .gitorganize &&
+		test_grep "^refs.c component=refs" .gitorganize &&
+		test_grep ! "^blob.c " .gitorganize
+	)
+'
+
+test_expect_success 'apply rejects an in-place edit of a moved file' '
+	git init tamper &&
 	(
-		cd backlog &&
+		cd tamper &&
+		echo blob >blob.c &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		write_organizer tamper_organizer <<-\EOF &&
+		diff --git a/blob.c b/blob.c
+		--- a/blob.c
+		+++ b/blob.c
+		@@ -1 +1 @@
+		-blob
+		+tampered
+		EOF
+		configure_organize ./labeler ./tamper_organizer &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		test_must_fail git organize apply 2>err &&
+		test_grep "part of a move" err &&
+		# the rejected apply changed nothing
+		test_path_is_file blob.c &&
+		test_path_is_missing odb/blob.c
+	)
+'
+
+test_expect_success 'apply rejects a rename that is not a planned move' '
+	git init renamer &&
+	(
+		cd renamer &&
+		echo blob >blob.c &&
+		echo readme >README &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		write_organizer rename_organizer <<-\EOF &&
+		diff --git a/README b/MOVED
+		similarity index 100%
+		rename from README
+		rename to MOVED
+		EOF
+		configure_organize ./labeler ./rename_organizer &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		test_must_fail git organize apply 2>err &&
+		test_grep "not a planned move" err &&
+		# the rejected apply changed nothing
+		test_path_is_file README &&
+		test_path_is_missing MOVED &&
+		test_path_is_file blob.c
+	)
+'
+
+test_expect_success 'apply rejects a body that edits a file the header does not name' '
+	git init header-lies &&
+	(
+		cd header-lies &&
+		echo blob >blob.c &&
+		echo refs >refs.c &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		# the diff --git header claims the planned blob.c move, but the body
+		# edits refs.c (another moved file); apply resolves the real target
+		# from the patch, not the header, and rejects it.
+		write_organizer liar <<-\EOF &&
+		diff --git a/blob.c b/odb/blob.c
+		--- a/refs.c
+		+++ b/refs.c
+		@@ -1 +1 @@
+		-refs
+		+tampered
+		EOF
+		configure_organize ./labeler ./liar &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		test_must_fail git organize apply 2>err &&
+		test_grep "part of a move" err &&
+		# the rejected apply changed nothing
+		test_grep "^refs$" refs.c &&
+		test_path_is_missing refs/refs.c &&
+		test_path_is_missing odb/blob.c
+	)
+'
+
+test_expect_success 'apply rejects an in-place edit that repoints no move' '
+	git init meddle &&
+	(
+		cd meddle &&
+		echo blob >blob.c &&
+		echo other >other.c &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		# other.c does not move, and the edit names no directory the plan
+		# moves into, so it is not repointing a reference to a moved file
+		write_organizer meddler <<-\EOF &&
+		diff --git a/other.c b/other.c
+		--- a/other.c
+		+++ b/other.c
+		@@ -1 +1 @@
+		-other
+		+meddled
+		EOF
+		configure_organize ./labeler ./meddler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		test_must_fail git organize apply 2>err &&
+		test_grep "does not repoint" err &&
+		# the rejected apply changed nothing
+		test_grep "^other$" other.c &&
+		test_path_is_file blob.c &&
+		test_path_is_missing odb/blob.c
+	)
+'
+
+test_expect_success 'organizer may rename-with-modification a moved file' '
+	git init renamemod &&
+	(
+		cd renamemod &&
+		cat >blob.c <<-\EOF &&
+		#include "a.h"
+		#include "b.h"
+		#include "x.h"
+		#include "c.h"
+		#include "d.h"
+		EOF
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		write_organizer renamemod_organizer <<-\EOF &&
+		diff --git a/blob.c b/odb/blob.c
+		rename from blob.c
+		rename to odb/blob.c
+		--- a/blob.c
+		+++ b/odb/blob.c
+		@@ -1,5 +1,5 @@
+		 #include "a.h"
+		 #include "b.h"
+		-#include "x.h"
+		+#include "sub/x.h"
+		 #include "c.h"
+		 #include "d.h"
+		EOF
+		configure_organize ./labeler ./renamemod_organizer &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		git organize apply &&
+		test_path_is_file odb/blob.c &&
+		test_path_is_missing blob.c &&
+		test_grep "sub/x.h" odb/blob.c &&
+		git diff --cached -M --name-status >actual &&
+		test_grep "^R[0-9]*.*blob.c.*odb/blob.c" actual &&
+		test_grep "^odb/blob.c component=odb role=lib" .gitorganize &&
+		test_grep ! "^blob.c " .gitorganize &&
+		git diff --cached --name-only >staged &&
+		test_grep "^.gitorganize$" staged
+	)
+'
+
+test_expect_success 'a basename shared across directories does not collide' '
+	git init dup &&
+	(
+		cd dup &&
+		echo root >dup.c &&
+		mkdir sub &&
+		echo sub >sub/dup.c &&
+		git add . &&
+		git commit -m init &&
+		# a labeler that labels only the root dup.c
+		write_script duplabeler <<-\EOF &&
+		printf "dup.c\0component=odb role=lib\0"
+		EOF
+		configure_organize ./duplabeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		git organize status >actual &&
+		test_grep "dup.c  *-> odb/dup.c" actual &&
+		test_grep ! "sub/dup.c" actual &&
+		git organize apply &&
+		test_path_is_file odb/dup.c &&
+		test_path_is_file sub/dup.c &&
+		test_path_is_missing dup.c &&
+		git commit -m reconciled
+	)
+'
+
+test_expect_success 'a rule that maps a label to the root keeps its file in place' '
+	git init prog &&
+	(
+		cd prog &&
+		echo lib >lib.c &&
+		echo tool >tool.c &&
+		git add . &&
+		git commit -m init &&
+		# tool.c carries role=program, which the layout maps to the root
+		# (role:program = .), so it stays; lib.c matches component:odb and moves
+		write_script proglabeler <<-\EOF &&
+		printf "lib.c\0component=odb role=lib\0"
+		printf "tool.c\0component=? role=program\0"
+		EOF
+		configure_organize ./proglabeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		test_grep "^tool.c component=? role=program" .gitorganize &&
+		git commit -m labels &&
+		git organize status >actual &&
+		test_grep "organize: 2 in scope (1 in place, 1 to move, 0 backlog)" actual &&
+		test_grep ! "tool.c  *->" actual &&
+		git organize apply &&
+		test_path_is_file tool.c &&
+		test_path_is_file odb/lib.c &&
+		test_path_is_missing lib.c
+	)
+'
+
+test_expect_success 'a file in scope with no recorded label is unrecorded' '
+	git init scoped &&
+	(
+		cd scoped &&
 		echo a >a.c &&
 		git add . &&
 		git commit -m init &&
-		cat >.gitorganize <<-\EOF &&
-		[scope]
-		:(glob)*.c
-		[layout]
-		component:odb = odb
-		[labels]
-		a.c component=?
+		write_script alabeler <<-\EOF &&
+		printf "a.c\0component=? role=lib\0"
 		EOF
+		configure_organize ./alabeler &&
 		git add .gitorganize &&
 		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		# a.c is recorded but matches no rule: backlog
 		git organize status >actual &&
-		test_grep "backlog" actual &&
-		test_grep "^  a.c$" actual
+		test_grep "backlog:" actual &&
+		test_grep "^  a.c$" actual &&
+		# a source in scope that [labels] never recorded is unrecorded
+		echo b >b.c &&
+		git add b.c &&
+		git commit -m add-b &&
+		git organize status >actual &&
+		test_grep "in scope but unrecorded:" actual &&
+		test_grep "^  b.c$" actual
 	)
 '
 
-test_expect_success 'status reports a declared path that no longer exists' '
+test_expect_success 'status reports a recorded path that no longer exists' '
 	git init orphan &&
 	(
 		cd orphan &&
@@ -122,17 +506,15 @@ test_expect_success 'status reports a declared path that no longer exists' '
 		echo b >b.c &&
 		git add . &&
 		git commit -m init &&
-		cat >.gitorganize <<-\EOF &&
-		[scope]
-		:(glob)*.c
-		[layout]
-		role:public = .
-		[labels]
-		a.c role=public
-		b.c role=public
+		write_script twolabeler <<-\EOF &&
+		printf '\''a.c\0component=? role=public\0b.c\0component=? role=public\0'\''
 		EOF
+		configure_organize ./twolabeler &&
 		git add .gitorganize &&
 		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		# remove a recorded file outside the tool
 		git rm -q b.c &&
 		git commit -m drop-b &&
 		git organize status >actual &&
@@ -177,6 +559,25 @@ test_expect_success 'status rejects a malformed .gitorganize' '
 	)
 '
 
+test_expect_success 'the recorded labels carry arbitrary key=value pairs' '
+	git init extra &&
+	(
+		cd extra &&
+		echo z >z.c &&
+		git add . &&
+		git commit -m init &&
+		write_script extralabeler <<-\EOF &&
+		printf '\''z.c\0component=? role=lib note=demo\0'\''
+		EOF
+		configure_organize ./extralabeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		# a label the engine does not place still round-trips into [labels]
+		test_grep "^z.c component=? role=lib note=demo" .gitorganize
+	)
+'
+
 test_expect_success 'a subcommand rejects extra operands' '
 	test_must_fail git -C bad organize status junk 2>err &&
 	test_grep "too many arguments" err
-- 
2.54.0

