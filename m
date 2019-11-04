Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B761F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfKDT0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:26:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:26:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so18460919wra.10
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/p7gyZ/9QkG1wANqK1PHp4afC42dPfzaEm+cbxjCfM=;
        b=TVLDSj42SfcRsWqKwTuWe8W0eSVKTIxNl6Z/4t9m7CADWLItgpke+O9st6JlXntwTt
         ynvyW7HMPGhFdKL/YzcbJD4y8pnbYYy66GidWiAfEB+bAZC1Xw+x1vrjF12v6GRK66oa
         Ht+c7O3bGAtzy2++YL42/7SiZ3ujmzqPqWqmfkF7NADrtLsVmYUaPe2ew9FY6I8XMTmI
         nE9Gq5ODYa+28odHrBs6p4IYPSbrEFMuk2uu7tLVkBdEXR+re6y0DjXvii8nkVStaiE2
         vTMFTUJyPvf6B/zQ1nuaFvrpx2puen0a3l/J3FgbZwiGzBun+QjAR7lnSqqCmKJ0UhVY
         zz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/p7gyZ/9QkG1wANqK1PHp4afC42dPfzaEm+cbxjCfM=;
        b=bq7fCKGBpIUH6h3UHRJOldPY6G32L+jxzv7GhyVecwOjnI7UTA23xWScX+5ZOzq1qf
         df6my5vYTx203rNlGATJTZ8YpKczgMRMiV99dKtm0gmMD6yvKjkmJoeamIgYT3EX62vD
         8QgLJuoSKzRrJj/07HCzBVaNS2BHybF2FRzpdeTsH8gICWtuYT07hVGOkQFYZhySsn5g
         uWjrB211ik82Dk53ePsCS6aXfLjew6pBCV6HBvKVYO/C8xYHtn5uockBa/18j20UgNrw
         X+wOVj2BUD7vtrCVaZxjp49SbrkPgpHaQVfg4LTIzeuwW7TSChlywFRK9oJnnxpmgRdH
         BkLQ==
X-Gm-Message-State: APjAAAUim4CI6tDhakh7JV/ttQCfFeGB2CxG+5/bMeoFEsymYbD0XVRm
        IPcv8cmaRNXvpJCHN16QWTmaYVF4
X-Google-Smtp-Source: APXvYqxPSDM1TeQgawFcpmpv51GO78knFmQOCQVRPRCfenj2WjknJUwFzRzlMj6SQQrgH3zWrpEj7w==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr7199066wrb.330.1572895608592;
        Mon, 04 Nov 2019 11:26:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm22656933wrn.48.2019.11.04.11.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:26:48 -0800 (PST)
Message-Id: <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.git.1572895605.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 19:26:43 +0000
Subject: [PATCH 3/5] reset: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This option solves the problem of commandline length limit for UI's
built on top of git. Plumbing commands are not always a good fit, for
two major reasons:
1) Some UI's serve as assistants that help user run git commands. In
   this case, replacing familiar commands with plumbing commands will
   confuse most users.
2) Some UI's have started and grown with porcelain commands. Replacing
   existing logic with plumbing commands could be cumbersome and prone
   to various new problems.

The new option is designed to behave very close to pathspecs passed in
commandline args, so that switching from one to another is simple.

The new option allows to read either a specified file or `stdin`.
Reading from file is a good way to avoid competing for stdin, and
also gives some extra flexibility.

Decisions taken for simplicity:
1) The new option is declared incompatible with other options that
   could use `stdin`.
2) It is not allowed to pass some refspecs in args and others in file.
3) New options do not have shorthands to avoid shorthand conflicts.

Also add new '--pathspec-file-null' switch that mirrors '-z' used in
various places. Some porcelain commands, such as `git commit`, already
use '-z', therefore it needed a new unambiguous name.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-reset.txt    |  18 ++++-
 builtin/reset.c                |  22 +++++-
 t/t7107-reset-pathspec-file.sh | 126 +++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 5 deletions(-)
 create mode 100755 t/t7107-reset-pathspec-file.sh

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b0ea6e0ce5..d484cd2827 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,18 +9,20 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<tree-ish>] [--] <pathspec>...
+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] [<tree-ish>]
 'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first and second form, copy entries from `<tree-ish>` to the index.
-In the third form, set the current branch head (`HEAD`) to `<commit>`,
+In the first three forms, copy entries from `<tree-ish>` to the index.
+In the last form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 
 'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
-	This form resets the index entries for all `<pathspec>` to their
+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] [<tree-ish>]::
+	These forms reset the index entries for all `<pathspec>` to their
 	state at `<tree-ish>`.  (It does not affect the working tree or
 	the current branch.)
 +
@@ -107,6 +109,16 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
+--pathspec-from-file=<file>::
+	Read `<pathspec>` from `<file>` instead. If `<file>` is exactly `-`
+	then read from standard input. Pathspecs are separated by LF or
+	CR/LF. Pathspecs can be quoted as explained for the configuration
+	variable `core.quotePath` (see linkgit:git-config[1]). See also
+	`--pathspec-file-null` and global `--literal-pathspecs`.
+
+--pathspec-file-null::
+	Only meaningful with `--pathspec-from-file`. Pathspecs are
+	separated with NUL character and are not expected to be quoted.
 
 EXAMPLES
 --------
diff --git a/builtin/reset.c b/builtin/reset.c
index fdd572168b..0eaa6b0bca 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -31,6 +31,7 @@
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
+	N_("git reset [-q] [--pathspec-from-file [--pathspec-file-null]] [<tree-ish>]"),
 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
 };
@@ -284,8 +285,8 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0, unborn;
-	const char *rev;
+	int patch_mode = 0, pathspec_file_null = 0, unborn;
+	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
@@ -306,6 +307,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
+		OPT_FILENAME(0, "pathspec-from-file", &pathspec_from_file,
+				N_("read pathspecs from file")),
+		OPT_BOOL(0, "pathspec-file-null", &pathspec_file_null,
+				N_("with --pathspec-from-file, pathspecs are separated with NUL character")),
 		OPT_END()
 	};
 
@@ -316,6 +321,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	if (pathspec_from_file) {
+		if (patch_mode)
+			die(_("--pathspec-from-file is incompatible with --patch"));
+
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with path arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_FULL,
+				    prefix, pathspec_from_file, pathspec_file_null);
+	} else if (pathspec_file_null)
+		die(_("--pathspec-file-null requires --pathspec-from-file"));
+
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
new file mode 100755
index 0000000000..cf7f085ad5
--- /dev/null
+++ b/t/t7107-reset-pathspec-file.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+
+test_description='reset --pathspec-from-file'
+
+. ./test-lib.sh
+
+cat > expect.a <<EOF
+ D fileA.t
+EOF
+
+cat > expect.ab <<EOF
+ D fileA.t
+ D fileB.t
+EOF
+
+cat > expect.a_bc_d <<EOF
+D  fileA.t
+ D fileB.t
+ D fileC.t
+D  fileD.t
+EOF
+
+test_expect_success setup '
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add . &&
+	git commit --include . -m "Commit" &&
+	checkpoint=$(git rev-parse --verify HEAD)
+'
+
+restore_checkpoint () {
+	git reset --hard "$checkpoint"
+}
+
+verify_state () {
+	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp "$1" actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t | git reset --pathspec-from-file=- &&
+
+	verify_state expect.a
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t >list &&
+	git reset --pathspec-from-file=list &&
+
+	verify_state expect.a
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf fileA.tQfileB.t | q_to_nul | git reset --pathspec-from-file=- --pathspec-file-null &&
+
+	verify_state expect.ab
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
+
+	verify_state expect.ab
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\r\nfileB.t" | git reset --pathspec-from-file=- &&
+
+	verify_state expect.ab
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
+
+	verify_state expect.a
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-null' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	printf "\"file\\101.t\"" >list &&
+	# Note: "git reset" has not yet learned to fail on wrong pathspecs
+	git reset --pathspec-from-file=list --pathspec-file-null &&
+	
+	test_must_fail verify_state expect.a
+'
+
+test_expect_success '--pathspec-from-file is not compatible with --soft --hard' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t >list &&
+	test_must_fail git reset --soft --pathspec-from-file=list &&
+	test_must_fail git reset --hard --pathspec-from-file=list
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t fileC.t fileD.t &&
+	printf "fileB.t\nfileC.t" | git reset --pathspec-from-file=- &&
+
+	verify_state expect.a_bc_d
+'
+
+test_done
-- 
gitgitgadget

