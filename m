Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C43563CD
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505568; cv=none; b=KaS4Iw7uWdvvM4okVYGd29jTcdVWERfnDWmcKNMmLCPM9/QAjIDN67pmIECv88iGRHZWOo1R5/Fp7zcwydpU8GY9691MYoep1w0wc0HtMK07emHuls8cyslqbBiFb4U6qT3QAqH/d2SnIO9bVAviFadQFjfoqyDN2L/wx6r//YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505568; c=relaxed/simple;
	bh=Ve/r84CopHWGdWliaUlmiILPF8qbiQQ9bFXR/kAr+Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvnINj9NYrv3Se2NzHSojlM8Zb3NyX++2ATulH4YjFx/6WQmRkJwNRzusi5iCDY3FUMDcp/CqOx4ensbDZ7TNwuqQsXF0iOVbGvsdbfkVXyTE8t/ztnTLPdZ7Wj8vVreqeChJ+n1lKptgBRF68oS5kXJaCIHa4MzSL0E1+8vJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iema91kI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iema91kI"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so2166872a12.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505563; x=1788110363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7ZFN7MbPtjo7ZNoNn7aJOxlgOG0hfgMLkk0q9HLusY=;
        b=iema91kIjtVO90SdwdsjxWp68wYjGjdhjPLLZqrddHAqk0mbyjVdj6hguz09ysi7l4
         WoMAhmJ/INiOPhUci5tQZWAn2uLBpU1n6ljuZdNFXpXRqEwWnelHFwRMbYAnJo9/+s9s
         UxJt9OsOb5TPYOFAjycaofzqsNrrrS7UtNwt3t49LERWzs91gU1f+aX4turliBeXLcpF
         BZ+IUIxMznMpxo/PzjpquDi3u6QLI4diwfThwvJEN3fiaxfz+PnbUcqOA7k0cH4i5u31
         dvCWhKnUzfiCMslxeGnuWLj+EUgH0zqMuLH1ScALF9vA3538gp0RvBcD+R69k+i1oooW
         9A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505563; x=1788110363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7ZFN7MbPtjo7ZNoNn7aJOxlgOG0hfgMLkk0q9HLusY=;
        b=ZSSN78zFFvmKZ3g6Xm7YdNxROYQB1dVYQH4f5cjtMITq/iJnefff4HPCDvZb2w01f4
         W9c2h/Z/GgiS8GZQ39oLkO3WjccFLyqfOSce5RbWrF8NEJuwUg9w7Y8Zi8SyD1ixA4AM
         OS11oleM5NDFaghPCgqH95sg+D71x70gUlFleBcRUNmhByftSIYcQrkystsENHA5RpvR
         r7XYIYPDOIXqUPs3tT5jTQCfl46sQWLUn2Lk9+F8fauKnzn7gPCQGt7PfeUtX2VSq7XZ
         dqoVw26OZCWmNjjdOw/11ocggIUbB72sBQsLZMDlf8Wbpum96TT5IanTp9Swp81XycHp
         7Gtg==
X-Gm-Message-State: AFuF++kVwtpti75OzO/qDmO89KGIBEDAiqUeJKRCWQhlRgd0l2nJXLWm
	Bwts999lXsECtQ87tH/oCbfNAD26ZzAo+0lx75VTTaKlz6Fao2hqzqA8wDGOdA==
X-Gm-Gg: AR+sD13qFJ+Ekb7Tz8oUcs/L2PTw01BOFWkG1mU7EE2jch5O4xuCx4qyCAMz/GHsBWI
	c9ykGOTcXdX9+ZQPpyYmXJtCyeARlGYAonP1hx3xDvdfOj5Y2xkaruZccLMD9Oo703ypc/EhdOh
	LpWDmc1kmFxTzq5uXc4qT7uZfpbjoUy22Pkn7onzh7j6Koz91cj+mUiCnfvRDj5GOWS4j4gJhZv
	0naeOnQLQv9inye1DUbt27lOiEYyEUb9LFTbpb6b7iG649gsmcHlcTHcM5FQyWFPs0YFC26Tcod
	seW7dS2gMLrKu7gPWzcS9waNHKkvb3xxlrDq/xbquzN08I6OyCZhJEEA9uTy2DTJRJOdkDvXFhd
	Uhuzk3xGy27KWu0rAzuk+gFwfIYuNsmlDGaEb+pzmJsyv6yMSkTbO4SWte7XQKIv6zkBosr5JoN
	7vQEtDR1yd3IwlHfVpbnnDzARKWhXQJUPjLJ8YmQdMmS4XbjtQcqI/bhBrOp33nbGd4URCqx21c
	nlyh9azkgjBTUCGIqsAXP9WdB22bdv8lqIoZ6K9HGEIUUEpAwrc7wSMjlZtD0i1Lfn+EGCe8AMX
	gdELdZ+D4SCh/yL6r4IS6OJHWkOxkgTs3EC5e+TbBcu+6Q==
X-Received: by 2002:a17:90b:1b0e:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-395deec7930mr21425883a91.7.1787505562406;
        Sun, 23 Aug 2026 10:19:22 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm17282107c88.10.2026.08.23.10.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:21 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 04/14] organize: add the --label selector
Date: Sun, 23 Aug 2026 10:18:48 -0700
Message-ID: <20260823171915.2662373-5-mmontalbo@gmail.com>
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

status and apply act on every out-of-place file at once. To reconcile one
group at a time, a caller needs a way to name a subset.

Add --label <key[=value]>. A key=value selector matches a file whose
recorded labels include it; a bare key matches any value of that label. The
selector is repeatable and the matches combine, so a file matching any
selector is included. A selector can name any recorded label, not only
the ones [layout] places files by.

git organize apply --label component=<name> then reconciles one component
at a time, which is how a large layout is carved in reviewable steps.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/git-organize.adoc | 118 ++++++++++++++++----------
 builtin/organize.c              |  25 ++++--
 organize/organize.c             |  34 +++++++-
 organize/organize.h             |   7 +-
 t/t0096-organize.sh             | 143 ++++++++++++++++++++++++++++++++
 5 files changed, 270 insertions(+), 57 deletions(-)

diff --git a/Documentation/git-organize.adoc b/Documentation/git-organize.adoc
index 37ada38234..aca8934b26 100644
--- a/Documentation/git-organize.adoc
+++ b/Documentation/git-organize.adoc
@@ -9,8 +9,8 @@ git-organize - Reconcile a source tree against a declared layout
 SYNOPSIS
 --------
 [verse]
-'git organize status' [--exit-code]
-'git organize apply'
+'git organize status' [--exit-code] [--label <key[=value]>...]
+'git organize apply' [--label <key[=value]>...]
 'git organize apply' --labels-only [--reseed]
 
 
@@ -24,16 +24,18 @@ file belongs in.
 
 `.gitorganize` at the repository root has three sections. `[scope]` names
 the files in scope, one pathspec per line; with no `[scope]` section
-nothing is in scope. `[layout]` is the project's placement map, authored by
-hand: ordered `<label>:<value> = <directory>` rules (`.` is the repository
-root). A file's labels are matched against the rules in order, and the first
-rule it satisfies places it; a file matching no rule is the backlog.
-`[labels]` holds the recorded labels, one line per
-source in scope, `<path> <key>=<value> ...`, with every label the project
-defines. A placed file is listed too, so its `[labels]` line records its
-labels, independently of the directory name. Only a label named in a rule
-places a file; a label named in no rule places nothing and is recorded for a
-reader.
+nothing is in scope. `[layout]` is the project's map of where each file
+belongs, authored by hand: ordered `<label>:<value> = <directory>` rules
+(`.` is the repository root). A file's labels are matched against the rules in
+order, and the first rule it satisfies gives the file its directory; a file
+matching no rule is the backlog.
+`[labels]` holds the recorded labels: one line, `<path> <key>=<value>
+...`, per recorded in-scope source, with every label the project
+defines. apply repoints a moved file's line to its new path and keeps
+it, so a placed file keeps its record. A file that already sits inside a
+`[layout]` directory before it is recorded has no line; its location
+alone places it. Only a label named in a rule places a file; a label
+named in no rule places nothing and is recorded for a reader.
 
 The labeler and organizer live in config: `organize.labeler` and
 `organize.organizer`. A label is a key and value the labeler attaches to a
@@ -60,7 +62,7 @@ own references. A project supplies those edits with an organizer, its
 `organize.organizer` command. apply hands the organizer its
 moves. The organizer returns a patch of the edits and, for any move it
 cannot complete, a reason to skip it. When the organizer edits a file as it
-moves, git's rename detection matches it while its similarity stays above
+moves, Git's rename detection matches it while its similarity stays above
 the rename threshold. apply applies the moves and the patch as one
 transaction. With no organizer configured, apply moves the files and makes
 no other edit.
@@ -70,25 +72,28 @@ COMMANDS
 --------
 
 status::
-	Report the files whose placement value names a directory they are not
+	Report the files whose matching rule names a directory they are not
 	in (the moves), the backlog (recorded files with no matching
 	rule), a file in scope that `[labels]` does not record, and a recorded
 	path that no longer exists. Runs no configured
-	command and changes nothing. With `--exit-code`, exit non-zero when a
-	file is out of place, a file in scope is unrecorded, or a recorded path
-	is missing.
+	command and changes nothing. With `--label`, limit the moves to the
+	files a label selects (see OPTIONS); the backlog, unrecorded, and
+	missing lists are always reported. With `--exit-code`, exit non-zero
+	when a file is out of place, a file in scope is unrecorded, or a
+	recorded path is missing.
 
 apply::
 	Move each out-of-place file into its directory as a content-identical
 	rename, apply the organizer's edits, repoint each carved file's
-	`[labels]` line to its new path, and stage the result. apply requires a
-	clean worktree, so the change can be discarded as a whole.
+	`[labels]` line to its new path, and stage the result. With `--label`,
+	reconcile only the files a label selects. apply requires a clean
+	worktree, so the change can be discarded as a whole.
 +
 With `--labels-only`, apply instead records the `[labels]` line for every root
 file in scope and stages the file. A file already recorded keeps its line, so a
-placement chosen by hand or in an earlier run stands; the labeler only seeds a
+directory chosen by hand or in an earlier run stands; the labeler only seeds a
 file that has no line yet. With `--reseed`, re-derive every line from the
-labeler, discarding the recorded placements. This is the only path that runs a
+labeler, discarding the recorded lines. This is the only path that runs a
 labeler; `git organize apply` without `--labels-only` and `git organize status`
 never do.
 
@@ -96,6 +101,14 @@ never do.
 OPTIONS
 -------
 
+--label <key[=value]>::
+	Limit the moves that status reports and apply makes to the files a
+	label selects. A `<key>=<value>` selector matches a file whose
+	recorded labels include it; a bare `<key>` matches any value of that
+	label. A selector can name any recorded label, not only the ones
+	`[layout]` places files by. Repeatable; the selectors combine, so a
+	file matching any of them is included.
+
 --exit-code::
 	Exit non-zero from status when a file is out of place, a file in scope
 	is unrecorded, or a recorded path is missing. A standing backlog alone
@@ -107,9 +120,11 @@ OPTIONS
 	line yet.
 
 --reseed::
-	With apply `--labels-only`, re-derive every `[labels]` line from the
-	labeler, discarding the recorded placements. Use it to re-apply the
-	labeler after its map changes; without it a recorded line is kept.
+	With apply `--labels-only`, discard the recorded lines and re-derive
+	them from the labeler. A file already placed in a `[layout]`
+	directory keeps its line, because the labeler derives labels from the
+	sources at the root. Use it to re-apply the labeler after its map
+	changes; without it a recorded line is kept.
 
 
 CONFIGURATION
@@ -119,20 +134,23 @@ organize.labeler::
 	--labels-only` runs it over the root files in scope. It writes one
 	record per file on its standard output: the path, a NUL, its
 	space-separated `key=value` labels, a NUL. A file in scope with no
-	record is unrecorded, reported apart from the backlog. Use user or
-	system config for this setting; do
-	not take it from a repository file.
+	record is unrecorded, reported apart from the backlog. This command is
+	honored from config at any level, repo-local `.git/config` included, and
+	so requires the trust you give `core.hooksPath`.
 
 organize.organizer::
 	The command that returns move edits. apply runs it over the moves. It
 	reads the pending moves on its standard input and returns a patch and
 	any skip reasons; see PROTOCOL. Optional. Without it, apply performs the
-	moves and makes no other edit. Use user or system config for this
-	setting; do not take it from a repository file.
+	moves and makes no other edit. This command is honored from config at
+	any level, repo-local `.git/config` included, and so requires the trust
+	you give `core.hooksPath`.
 
 The labeler and organizer are trusted, the way a clean or smudge filter or a
-hook is trusted. Set them in user or system config, so a repository you clone
-cannot supply its own.
+hook is trusted. Both are honored from config at any level, repo-local
+`.git/config` included. A repository you clone does not ship its `.git/config`,
+so a clone cannot supply them by that route, but treat a command written into
+`.git/config` with the same care you give `core.hooksPath`.
 
 
 FILES
@@ -140,16 +158,17 @@ FILES
 `.gitorganize`::
 	The declaration, at the repository root, in three sections. `[scope]`
 	names the files in scope, one pathspec per line; with no `[scope]`
-	section nothing is in scope. `[layout]` is the project's placement map:
-	ordered `<label>:<value> = <directory>` rules (`.` is the root), where a
-	file takes the directory of the first rule its labels satisfy, and a
-	file matching no rule is the backlog. `[labels]` holds the recorded
-	labels, one `<path> <key>=<value> ...` line per source in scope,
-	including placed files. The project writes `[scope]` and `[layout]`;
-	`git organize apply --labels-only` writes `[labels]`, and the move apply
-	repoints a carved file's line. A `#` line is a comment; git organize
-	rewrites the file whole, keeping the hand-authored `[scope]` and
-	`[layout]` verbatim.
+	section nothing is in scope. `[layout]` is the project's map of where
+	each file belongs: ordered `<label>:<value> = <directory>` rules (`.` is
+	the root), where a file takes the directory of the first rule its labels
+	satisfy, and a file matching no rule is the backlog. `[labels]` holds
+	the recorded labels, one `<path> <key>=<value> ...` line per in-scope
+	source that a rule, not its location, places; a file already inside a
+	`[layout]` directory is placed by its location and has no line. The
+	project writes `[scope]` and `[layout]`; `git organize apply
+	--labels-only` writes `[labels]`, and the move apply repoints a carved
+	file's line. A `#` line is a comment; git organize rewrites the file
+	whole, keeping the hand-authored `[scope]` and `[layout]` verbatim.
 
 
 PROTOCOL
@@ -159,9 +178,20 @@ version line `git-organize 1 organize`, then a `move <src> <dst> <label>`
 line per pending move, with C-quoted paths. The organizer replies with the
 same version line. For each declined move, it writes `reject <src>
 <reason>`. It may then write `patch`, followed by a git patch that runs to
-the end of its output. The patch may edit referring files and may rename a
-moved file as it edits it, but it must not add, delete, or copy files, and
-any rename must match a planned move.
+the end of its output.
+
+Before it runs `git apply`, git organize checks each entry in the patch with
+Git's own diff-header parser and refuses the patch if an entry adds, deletes,
+or copies a file, changes a file's mode, or renames a file to anything but a
+planned move. An in-place edit must repoint a move: it must leave the file
+where it is and mention a directory the plan moves into. So the patch git
+organize accepts is limited to edits of referring files and to renames that
+match a planned move.
+
+The organizer is a trusted, config-defined command, honored the way a clean or
+smudge filter is. These checks catch a well-meaning organizer's mistakes; they
+do not sandbox a hostile one, and they do not certify that the whole patch is
+sound.
 
 
 GIT
diff --git a/builtin/organize.c b/builtin/organize.c
index 35247c5aef..925ef17128 100644
--- a/builtin/organize.c
+++ b/builtin/organize.c
@@ -6,27 +6,30 @@
  * are not in yet (the moves), the backlog (files with no matching rule), and a
  * declared path that no longer exists. apply moves the misplaced files and
  * stages the result; apply --labels-only instead runs the labeler and records
- * the labels.
+ * the labels. --label <key[=value]> (repeatable) limits status and the move
+ * apply to files carrying a matching label.
  */
 #include "builtin.h"
 #include "gettext.h"
 #include "organize/organize.h"
 #include "parse-options.h"
 #include "repository.h"
+#include "strvec.h"
 
 static const char *const organize_usage[] = {
-	"git organize status [--exit-code]",
-	"git organize apply",
+	"git organize status [--exit-code] [--label <key[=value]>...]",
+	"git organize apply [--label <key[=value]>...]",
 	"git organize apply --labels-only [--reseed]",
 	NULL
 };
 
-static int organize_status(struct repository *repo, int exit_code)
+static int organize_status(struct repository *repo,
+			   const struct strvec *selectors, int exit_code)
 {
 	struct organize_plan plan = ORGANIZE_PLAN_INIT;
 	int to_move, backlog, unrecorded, orphans;
 
-	organize_plan_build(repo, &plan);
+	organize_plan_build(repo, selectors, &plan);
 	to_move = (int)plan.moves_nr;
 	backlog = (int)plan.backlog.nr;
 	unrecorded = (int)plan.unrecorded.nr;
@@ -70,12 +73,12 @@ static int organize_status(struct repository *repo, int exit_code)
 	return exit_code && (to_move || unrecorded || orphans) ? 1 : 0;
 }
 
-static int organize_apply(struct repository *repo)
+static int organize_apply(struct repository *repo, const struct strvec *selectors)
 {
 	struct organize_plan plan = ORGANIZE_PLAN_INIT;
 	int moved = 0, rejected = 0;
 
-	organize_plan_build(repo, &plan);
+	organize_plan_build(repo, selectors, &plan);
 	if (!plan.moves_nr) {
 		printf(_("organize apply: nothing to do\n"));
 		organize_plan_release(&plan);
@@ -106,8 +109,11 @@ int cmd_organize(int argc,
 		 const char *prefix,
 		 struct repository *repo)
 {
+	struct strvec selectors = STRVEC_INIT;
 	int exit_code = 0, labels_only = 0, reseed = 0;
 	struct option options[] = {
+		OPT_STRVEC(0, "label", &selectors, N_("key[=value]"),
+			   N_("limit to files carrying a matching label (repeatable)")),
 		OPT_BOOL(0, "exit-code", &exit_code,
 			 N_("exit non-zero from status when a file is out of place")),
 		OPT_BOOL(0, "labels-only", &labels_only,
@@ -128,7 +134,7 @@ int cmd_organize(int argc,
 	if (!strcmp(subcmd, "status")) {
 		if (labels_only)
 			die(_("git organize: --labels-only is an apply option"));
-		ret = organize_status(repo, exit_code);
+		ret = organize_status(repo, &selectors, exit_code);
 	} else if (!strcmp(subcmd, "apply")) {
 		if (labels_only) {
 			organize_run_labeler(repo, reseed);
@@ -136,11 +142,12 @@ int cmd_organize(int argc,
 				 "staged; nothing is committed.\n"));
 			ret = 0;
 		} else {
-			ret = organize_apply(repo);
+			ret = organize_apply(repo, &selectors);
 		}
 	} else {
 		die(_("git organize: unknown subcommand '%s'"), subcmd);
 	}
 
+	strvec_clear(&selectors);
 	return ret;
 }
diff --git a/organize/organize.c b/organize/organize.c
index 8c623444c0..298557a3da 100644
--- a/organize/organize.c
+++ b/organize/organize.c
@@ -29,6 +29,30 @@ static const char *organize_command(struct repository *repo, const char *key)
 	return cmd;
 }
 
+/*
+ * Whether a file's labels satisfy any --label selector. labels is the file's
+ * space-separated "key=value" list. A "key=value" selector must equal a label
+ * exactly; a bare "key" matches any value of that label.
+ */
+static int label_selected(const char *labels, struct string_list *selectors)
+{
+	for (size_t i = 0; i < selectors->nr; i++) {
+		const char *selector = selectors->items[i].string;
+		size_t sellen = strlen(selector);
+		int bare = !strchr(selector, '=');
+
+		for (const char *l = labels; *l; ) {
+			const char *sp = strchrnul(l, ' ');
+
+			if (!strncmp(l, selector, sellen) &&
+			    (bare ? l[sellen] == '=' : sp == l + sellen))
+				return 1;
+			l = *sp ? sp + 1 : sp;
+		}
+	}
+	return 0;
+}
+
 /*
  * The [layout] rule whose directory equals `path`'s directory, or NULL when
  * `path` is a root file or its directory matches no rule. A file in a [layout]
@@ -133,14 +157,19 @@ static void add_move(struct organize_plan *plan, const char *src,
 	m->skip_reason = NULL;
 }
 
-void organize_plan_build(struct repository *repo, struct organize_plan *plan)
+void organize_plan_build(struct repository *repo, const struct strvec *selectors,
+			 struct organize_plan *plan)
 {
 	struct organize_ctx ctx = ORGANIZE_CTX_INIT;
+	struct string_list want = STRING_LIST_INIT_NODUP;
 	struct string_list seen = STRING_LIST_INIT_DUP;
 	struct strbuf value_buf = STRBUF_INIT;
 
 	organize_ctx_load(repo, &ctx);
 
+	for (size_t i = 0; i < selectors->nr; i++)
+		string_list_append(&want, selectors->v[i]);
+
 	/*
 	 * Classify each recorded entry by the rule its labels match. A file
 	 * already in the rule's directory is in place. A file in another
@@ -175,7 +204,7 @@ void organize_plan_build(struct repository *repo, struct organize_plan *plan)
 
 		if (!strcmp(dst.buf, path))
 			plan->in_place++;	/* already in place */
-		else
+		else if (!want.nr || label_selected(labels, &want))
 			add_move(plan, path, strbuf_detach(&dst, NULL), rule->value);
 		strbuf_release(&dst);
 	}
@@ -207,6 +236,7 @@ void organize_plan_build(struct repository *repo, struct organize_plan *plan)
 			string_list_append(&plan->orphans, ctx.gitorg.records.items[i].string);
 
 	organize_ctx_release(&ctx);
+	string_list_clear(&want, 0);
 	string_list_clear(&seen, 0);
 	strbuf_release(&value_buf);
 }
diff --git a/organize/organize.h b/organize/organize.h
index 84e6558f8b..358298376c 100644
--- a/organize/organize.h
+++ b/organize/organize.h
@@ -4,6 +4,7 @@
 #include "string-list.h"
 
 struct repository;
+struct strvec;
 
 /*
  * The git organize engine. A project declares where each file belongs, and
@@ -74,9 +75,11 @@ struct organize_plan {
  * rule names a directory it is not in as a move. Also record the backlog
  * (recorded files that match no rule), the unrecorded files (in scope,
  * no [labels] line), and the orphans (declared paths
- * that no longer exist).
+ * that no longer exist). selectors limit the moves to files carrying one of the
+ * named labels; an empty strvec keeps them all.
  */
-void organize_plan_build(struct repository *repo, struct organize_plan *plan);
+void organize_plan_build(struct repository *repo, const struct strvec *selectors,
+			 struct organize_plan *plan);
 
 /*
  * Perform the plan: consult the organizer when one is configured, then apply
diff --git a/t/t0096-organize.sh b/t/t0096-organize.sh
index d8de3c7e90..297e616021 100755
--- a/t/t0096-organize.sh
+++ b/t/t0096-organize.sh
@@ -160,6 +160,56 @@ test_expect_success 'status --exit-code fails when a file is out of place' '
 	test_expect_code 1 git organize status --exit-code
 '
 
+test_expect_success 'status --label filters by a recorded label' '
+	git organize status --label component=odb >actual &&
+	test_grep "blob.c  *-> odb/blob.c" actual &&
+	test_grep ! refs.c actual &&
+	# a non-placement label selects too (role, not just the placing component)
+	git organize status --label role=lib >bylib &&
+	test_grep "blob.c  *-> odb/blob.c" bylib &&
+	test_grep "refs.c  *-> refs/refs.c" bylib &&
+	# header.h (role=public, in place) is not over-included by the filter
+	test_grep ! "header.h" bylib &&
+	# a bare key matches any value of that label
+	git organize status --label component >bykey &&
+	test_grep "blob.c  *-> odb/blob.c" bykey &&
+	test_grep "refs.c  *-> refs/refs.c" bykey
+'
+
+test_expect_success 'apply --label moves only the selected files' '
+	git init bylabel &&
+	(
+		cd bylabel &&
+		echo blob >blob.c &&
+		echo refs >refs.c &&
+		echo header >header.h &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		configure_organize ./labeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		# reconcile only the odb component; refs.c must stay put
+		git organize apply --label component=odb &&
+		git diff --cached -M --name-status >staged &&
+		test_grep "^R100.*blob.c.*odb/blob.c" staged &&
+		test_path_is_file odb/blob.c &&
+		test_path_is_missing blob.c &&
+		# refs.c is not selected: still at the root, absent from the staged set
+		test_path_is_file refs.c &&
+		test_path_is_missing refs/refs.c &&
+		test_grep ! "refs.c" staged &&
+		# [labels] repointed for odb only; the refs.c line is unchanged
+		test_grep "^odb/blob.c component=odb" .gitorganize &&
+		test_grep "^refs.c component=refs" .gitorganize &&
+		# refs.c is still reported as a pending move
+		git organize status >after &&
+		test_grep "refs.c  *-> refs/refs.c" after
+	)
+'
+
 test_expect_success 'apply moves files as content-identical renames and repoints [labels]' '
 	git organize apply &&
 	git diff --cached -M --name-status >actual &&
@@ -588,6 +638,99 @@ test_expect_success 'the recorded labels carry arbitrary key=value pairs' '
 	)
 '
 
+test_expect_success FUNNYNAMES 'apply moves a source whose name needs C-quoting' '
+	git init quoted &&
+	(
+		cd quoted &&
+		# a double-quote in the name forces the diff header to C-quote it
+		name="a\"b.c" &&
+		echo blob >"$name" &&
+		git add . &&
+		git commit -m init &&
+		# a labeler for the single quoted source; the NUL-separated
+		# record carries the quote literally
+		write_script quotedlabeler <<-\EOF &&
+		printf "a\"b.c\0component=odb role=lib\0"
+		EOF
+		configure_organize ./quotedlabeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		# the rename header C-quotes the path; the move still applies
+		git organize apply &&
+		test_path_is_file "odb/$name" &&
+		test_path_is_missing "$name" &&
+		git diff --cached --name-only >staged &&
+		test_grep "odb/a" staged
+	)
+'
+
+test_expect_success 'apply rejects a malformed reject line' '
+	git init badreject &&
+	(
+		cd badreject &&
+		echo blob >blob.c &&
+		echo refs >refs.c &&
+		git add . &&
+		git commit -m init &&
+		write_labeler &&
+		# the reject path is quoted but unterminated on its line, so
+		# unquoting scans past the newline into the next line
+		write_script rejector <<-\EOF &&
+		cat >/dev/null
+		printf "git-organize 1 organize\n"
+		printf "reject \"a\nb.c\" reason\n"
+		EOF
+		configure_organize ./labeler ./rejector &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize apply --labels-only &&
+		git commit -m labels &&
+		test_must_fail git organize apply 2>err &&
+		test_grep "malformed reject line" err
+	)
+'
+
+test_expect_success 'apply --labels-only rejects a duplicate labeler record' '
+	git init duprec &&
+	(
+		cd duprec &&
+		echo blob >blob.c &&
+		git add . &&
+		git commit -m init &&
+		# the labeler emits the same scoped path twice
+		write_script duprelabeler <<-\EOF &&
+		printf "blob.c\0component=odb role=lib\0"
+		printf "blob.c\0component=refs role=lib\0"
+		EOF
+		configure_organize ./duprelabeler &&
+		git add .gitorganize &&
+		git commit -m declare &&
+		test_must_fail git organize apply --labels-only 2>err &&
+		test_grep "duplicate labeler record" err
+	)
+'
+
+test_expect_success 'status rejects trailing junk after a quoted path' '
+	git init trailing &&
+	(
+		cd trailing &&
+		echo a >a.c &&
+		git add . &&
+		git commit -m init &&
+		# a quoted [labels] path with junk right after the close quote
+		cat >.gitorganize <<-\EOF &&
+		[layout]
+		component:odb = odb
+		[labels]
+		"a.c"junk component=odb
+		EOF
+		test_must_fail git organize status 2>err &&
+		test_grep "trailing text after path" err
+	)
+'
+
 test_expect_success 'a subcommand rejects extra operands' '
 	test_must_fail git -C bad organize status junk 2>err &&
 	test_grep "too many arguments" err
-- 
2.54.0

