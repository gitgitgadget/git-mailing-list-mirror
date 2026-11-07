Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079850;
	b=oxJxIodaA110jhg6Jzn+O5I6UZ3cE8Q8J+/pxxANaRmwYYKLhbV90qHGkR5sATTlIfY+
	 3h31ZqZeY9evWBtcyM7jEy0+jgrp0BpEsosDcfYdy8+97KchyzpUbBXmlTnPTUETz/Pfx
	 87lnpbg7J4peEx91ApDwH4rlOCMaHjf4wLCxPJyp4rR+99J6e8P3Iwgog7OjVKz5k7dl8
	 DBbLiFkJkAq8K9x9YQW2i4z3gs37IZj9hXISq9q8GDSFH4ciKgWQ+gE4NQ4qlC05z2nim
	 fn38h2PSl2Rgu8aYLYEhnseCrvWUqZLc1ZqHpDQ+IJ9UCk2IyprosLttzr7LXPYj2Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079850;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DRTvAv5bHu7EWd1/IARVBAltoYB7GftoWlcOw2SO/IM=;
	b=DJGYcyB/ozX4Xg7tUiAiX5KjUhCMFjkJ7AgXCqhqf3nS61lTH25E0DhUNYBZQHFn3kLI
	 QhIZjuvzmS/v7yIh4VB+zmSmPhe408JlAtfXOPpCU7VpBhD43P26mJyjKpZOuUhi1MwgG
	 mVd/GMXpF65kxw+XUvYibyr9SYSX/KuzN99kCGhxqBMnxtTHOjYSaUVXFUYU2vTUgjx7l
	 zjdoplSAt+FIAs2KW9dGfqTvR4vdPFp1KhxTSdB8Dxpz6THuvwVyU6atJwhZqkhwajuMk
	 sfkbn6+4Zi7oOsRO8m64WMhach5E+BPzq4PRafPfNrCzqnaA8+e9n/WbVfjR3EIbxbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=vdwaa.nl;
	spf=fail smtp.mailfrom=vdwaa.nl;
	dkim=pass header.d=kpnmail.nl header.i=@kpnmail.nl header.a=rsa-sha256 header.s=kpnmail01 header.b=SWBYjAcV;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF19606A32E
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF19606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.a=rsa-sha256 header.s=kpnmail01 header.b=SWBYjAcV
X-KPN-MessageId: b7bf94f3-dae1-11f1-87e7-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b7bf94f3-dae1-11f1-87e7-00505699b430;
	Sat, 07 Nov 2026 20:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:message-id:date:subject:to:from;
	bh=DRTvAv5bHu7EWd1/IARVBAltoYB7GftoWlcOw2SO/IM=;
	b=SWBYjAcVgAo43VwlUnGscNrRQxO7j8bNJ5UzPVC2YHkUlmQfzKJhrI5YmTpLbaIpdfOH4LmcYepvU
	 O5lxPsnoNR2riwpT4+QLKbFduRZgzC4jdvtrao+y1CDxe8B8cpCW19Wv9CbVnCWxDOa1Zb3W901Nzc
	 nA1hQwQoBj2MTnF8=
X-KPN-MID: 33|jBHMP7CFB9n1Sq3R53W3iaTvnMigPBMM8Rd9PklmmORsJnFxrNbel+rAcGmgihr
 xO3Qsx+H+J/yPyYP0WayZSuOcphBUInacTqV503NSbT0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|p/lqWG3h2Q9jfs9G1YhzSk+OlDTLvhC6Dfdh7ChSbRGNHS/sxG/LHz5gjgdjuWe
 v09WNi68RdzvGo3RI38FYfg==
Received: from natrium (77-171-66-179.fixed.kpn.net [77.171.66.179])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b7b7f590-dae1-11f1-a6e0-00505699772e;
	Sat, 07 Nov 2026 20:30:41 +0100 (CET)
From: Jelle van der Waa <jelle@vdwaa.nl>
To: git@vger.kernel.org
Cc: Jelle van der Waa <jelle@vdwaa.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 2/2] history: add --verbose option for reword
Date: Sat,  7 Nov 2026 20:30:19 +0100
Message-ID: <20261107193020.583215-3-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107193020.583215-1-jelle@vdwaa.nl>
References: <20261107193020.583215-1-jelle@vdwaa.nl>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rewording a commit message it is often useful to have context of
the changes. This commit implements the --verbose option of git commit
in git history reword with the only difference in that it does not
folllow the commit.verbose configuration setting.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 Documentation/git-history.adoc | 11 +++-
 builtin/history.c              | 60 ++++++++++++++++++---
 t/t3451-history-reword.sh      | 97 ++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 1fcc30150a..a476780623 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
-git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [-v | --verbose] [--[no-]gpg-sign[=<key-id>]]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
 git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>
 
@@ -180,6 +180,15 @@ OPTIONS
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
+`-v`::
+`--verbose`::
+`--no-verbose`::
+	For `reword`, show the diff of the commit being reworded at the bottom
+	of the commit message to help the user describe the commit by reminding
+	what changes the commit has.
+	Note that this diff output doesn't have its lines prefixed with `#`.
+	This diff will not be a part of the commit message.
+
 `-S[<key-id>]`::
 `--gpg-sign[=<key-id>]`::
 `--no-gpg-sign`::
diff --git a/builtin/history.c b/builtin/history.c
index cdb0d30784..e2e0aba4a9 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -3,9 +3,11 @@
 #include "builtin.h"
 #include "advice.h"
 #include "cache-tree.h"
+#include "color.h"
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
+#include "diff.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
@@ -34,7 +36,7 @@
 #define GIT_HISTORY_FIXUP_USAGE \
 	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]")
+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [-v | --verbose] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
 #define GIT_HISTORY_SQUASH_USAGE \
@@ -47,11 +49,32 @@ static void change_data_free(void *util, const char *str UNUSED)
 	free(d);
 }
 
+static void print_verbose_diff(struct repository *repo,
+			       const struct object_id *old_tree,
+			       const struct object_id *new_tree,
+			       FILE *fp)
+{
+	struct diff_options opts;
+
+	repo_diff_setup(repo, &opts);
+	opts.output_format = DIFF_FORMAT_PATCH;
+	opts.flags.allow_textconv = 1;
+	opts.use_color = GIT_COLOR_NEVER;
+	opts.file = fp;
+	diff_setup_done(&opts);
+
+	diff_tree_oid(old_tree, new_tree, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+	diff_free(&opts);
+}
+
 static int fill_commit_message(struct repository *repo,
 			       const struct object_id *old_tree,
 			       const struct object_id *new_tree,
 			       const char *default_message,
 			       const char *action,
+			       int verbose,
 			       struct strbuf *out)
 {
 	const char *path = git_path_commit_editmsg();
@@ -84,6 +107,10 @@ static int fill_commit_message(struct repository *repo,
 
 	wt_status_collect_changes_trees(&s, old_tree, new_tree);
 	wt_status_print(&s);
+	if (verbose) {
+		wt_status_add_cut_line(&s);
+		print_verbose_diff(repo, old_tree, new_tree, s.fp);
+	}
 	wt_status_collect_free_buffers(&s);
 	string_list_clear_func(&s.change, change_data_free);
 	if (fclose(s.fp))
@@ -95,7 +122,7 @@ static int fill_commit_message(struct repository *repo,
 		return -1;
 	}
 
-	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
+	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, verbose);
 
 	if (!out->len) {
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
@@ -107,6 +134,7 @@ static int fill_commit_message(struct repository *repo,
 
 enum commit_tree_flags {
 	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
+	COMMIT_TREE_VERBOSE = (1 << 1),
 };
 
 static int history_config(const char *var, const char *value,
@@ -122,6 +150,19 @@ static int history_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, NULL);
 }
 
+static int reword_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *data)
+{
+	const char **sign_commit = data;
+
+	if (!strcmp(var, "commit.gpgsign")) {
+		*sign_commit = git_config_bool(var, value) ? "" : NULL;
+		return 0;
+	}
+
+	return git_diff_ui_config(var, value, ctx, NULL);
+}
+
 #define OPT_HISTORY_GPG_SIGN(v) { \
 	.type = OPTION_STRING, \
 	.short_name = 'S', \
@@ -172,7 +213,9 @@ static int commit_tree_ext(struct repository *repo,
 
 	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
 		ret = fill_commit_message(repo, old_tree, new_tree,
-					  message_template, action, &commit_message);
+					  message_template, action,
+					  !!(flags & COMMIT_TREE_VERBOSE),
+					  &commit_message);
 		if (ret < 0)
 			goto out;
 	} else {
@@ -221,6 +264,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
 					   const char *sign_commit,
+					   int verbose,
 					   struct commit **out)
 {
 	struct object_id parent_tree_oid;
@@ -233,7 +277,8 @@ static int commit_tree_with_edited_message(struct repository *repo,
 
 	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, sign_commit, out,
-			       COMMIT_TREE_EDIT_MESSAGE);
+			       COMMIT_TREE_EDIT_MESSAGE |
+			       (verbose ? COMMIT_TREE_VERBOSE : 0));
 }
 
 enum ref_action {
@@ -754,13 +799,14 @@ static int cmd_history_reword(int argc,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
 	const char *sign_commit = NULL;
-	int dry_run = 0;
+	int dry_run = 0, verbose = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
 			       N_("control which refs should be updated"),
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT__VERBOSE(&verbose, N_("show diff in commit message")),
 		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
@@ -769,7 +815,7 @@ static int cmd_history_reword(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
-	repo_config(repo, history_config, &sign_commit);
+	repo_config(repo, reword_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
@@ -790,7 +836,7 @@ static int cmd_history_reword(int argc,
 		goto out;
 
 	ret = commit_tree_with_edited_message(repo, "reworded", original,
-					      sign_commit, &rewritten);
+					      sign_commit, verbose, &rewritten);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 6dbe2143d3..4ec07fb493 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -16,6 +16,19 @@ reword_with_message () {
 	rm fake-editor.sh message
 }
 
+reword_and_capture () {
+	write_script fake-editor.sh <<-\EOF &&
+	cp "$1" captured &&
+	{
+		echo reworded &&
+		sed -n "/^# -* >8 -*$/,\$p" "$1"
+	} >new-message &&
+	mv new-message "$1"
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh &&
+	git history reword "$@"
+}
+
 expect_graph () {
 	cat >expect &&
 	lib_test_cmp_graph --graph --format=%s "$@"
@@ -434,6 +447,90 @@ test_expect_success 'aborts with empty commit message' '
 	)
 '
 
+test_expect_success '--verbose shows the diff of the reworded commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		echo unstaged >first.t &&
+		echo staged >third.t &&
+		git add third.t &&
+		git show --format= HEAD~ >expect &&
+
+		reword_and_capture --verbose HEAD~ &&
+
+		test_grep "^# -* >8 -*\$" captured &&
+		sed -n "/^diff --git/,\$p" captured >actual &&
+		test_cmp expect actual &&
+
+		test_commit_message HEAD~ <<-\EOF
+		reworded
+		EOF
+	)
+'
+
+test_expect_success 'no diff is shown without --verbose' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		test_tick &&
+		reword_and_capture HEAD &&
+		test_grep ! "^diff --git" captured &&
+		test_grep ! ">8" captured &&
+
+		test_tick &&
+		reword_and_capture --verbose --no-verbose HEAD &&
+		test_grep ! "^diff --git" captured &&
+		test_grep ! ">8" captured &&
+
+		test_tick &&
+		git config commit.verbose true &&
+		reword_and_capture HEAD &&
+		test_grep ! "^diff --git" captured &&
+		test_grep ! ">8" captured
+	)
+'
+
+test_expect_success '--verbose works in a bare repository' '
+	test_when_finished "rm -rf repo repo.git" &&
+	git init repo &&
+	test_commit -C repo first &&
+	test_commit -C repo second &&
+	git clone --bare repo repo.git &&
+	(
+		cd repo.git &&
+		reword_and_capture --verbose HEAD~ &&
+		test_grep "^diff --git a/first.t b/first.t\$" captured &&
+		test_commit_message HEAD~ <<-\EOF
+		reworded
+		EOF
+	)
+'
+
+test_expect_success '--verbose on a merge diffs against the first parent' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git switch -c side &&
+		test_commit theirs &&
+		git switch - &&
+		test_commit ours &&
+		git merge --no-edit side &&
+
+		reword_and_capture --verbose HEAD &&
+		test_grep "^diff --git a/theirs.t b/theirs.t\$" captured &&
+		test_grep ! "^diff --git a/ours.t" captured
+	)
+'
+
 test_expect_success 'retains changes in the worktree and index' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.56.0

