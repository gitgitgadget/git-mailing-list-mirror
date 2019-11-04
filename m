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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4961F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfKDT0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:26:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfKDT0w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:26:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so18460968wra.10
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jrfEeOPBGJRlH7Qeb9GjMc5Nc5TU5Y54NmdsdIc0kmA=;
        b=BXEGvF7/niBTsSaFnI8vkczT78TmvvvBGB21yvD0QEZPNoHnt8mHuG7VVpdIFrwS3s
         uEUvah6b5bRDqUxwQjmknJpIrj03YTb7yUGjjwte96nxcy26IrHmmFA7WChijydcVy0Z
         dc/1KJfq7RUa3aqe2u5eAksaabmqUM11d+2Tzg+0YK1YG1Yb/4eeMv0ar1O3hl5+4Ug4
         TOdkfIGCCpTQjFJk/PrLZQKM9Wghywyxk9PMVwVy7QUqWD628dAmSkNarm7Lz3ecbkVj
         r5Q/k+kKHf9w5o2bRjGDXZea5bXFoo852jN8lauPQaQ3vSqbW4ffHoxx0pSA5vZhVdNx
         IafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jrfEeOPBGJRlH7Qeb9GjMc5Nc5TU5Y54NmdsdIc0kmA=;
        b=oio7+F0PKX/Xh4lfBd1qOWZTapXOrDMyqhUqRZMXX6Wkl9wODFTwtyUxn82o3+ud5M
         FNNYTPRWD+Q1wRPBh66zcPE7/2S8Y53KNT7/MG8HIhJh6RRdGqmzwyi87aJqvnYvRaPv
         jQ4jM2/BPa+khqs7Lmkurc1s0M/Acryw7DUOgsyn3cVsy7fCqa11nqsu6Uqfhy2I0R9E
         pyHf8eF+XII25AvwmXGzntNEEFqHOcbeKd3NsDn/JkaW0uUrWxe0MRwGOle+Ey9tuVOo
         YterNT6OW9v/MJMp/Vk/dd4nHL6pOpC26BW3ed0d2WWV26dKYHcAVSsvuc4CcAUT/E+Q
         Z6Uw==
X-Gm-Message-State: APjAAAX0wTyayUU9jJc04CSRVBHP70V92PZ1RjyfxFpuNhxREJecfRms
        xTo47Sgo5foVc0+lHMLxfC0F5xHS
X-Google-Smtp-Source: APXvYqxadNREZutGkKswUQEwtsAtSMt57D5vSEDAJ1trxMXPWYR/FTGUOX09tPElqgHPeUBwDlcCUg==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr11713651wru.342.1572895609821;
        Mon, 04 Nov 2019 11:26:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm9504105wmf.37.2019.11.04.11.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:26:49 -0800 (PST)
Message-Id: <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.git.1572895605.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 19:26:45 +0000
Subject: [PATCH 5/5] commit: support the --pathspec-from-file option
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

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt    |  14 ++++-
 builtin/commit.c                |  25 ++++++--
 t/t7526-commit-pathspec-file.sh | 107 ++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 5 deletions(-)
 create mode 100755 t/t7526-commit-pathspec-file.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4341d0e3ab..ec4752298d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
+	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-null]]
+	   [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -277,6 +278,17 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	the last commit without committing changes that have
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
+	
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
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
diff --git a/builtin/commit.c b/builtin/commit.c
index e588bc6ad3..532f305926 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,9 +107,9 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
-static int no_post_rewrite, allow_empty_message;
+static int no_post_rewrite, allow_empty_message, pathspec_file_null;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
-static char *sign_commit;
+static char *sign_commit, *pathspec_from_file;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -343,6 +343,23 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
+	if (pathspec_from_file) {
+		if (interactive)
+			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with path arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_FULL,
+				    prefix, pathspec_from_file, pathspec_file_null);
+	}
+	else if (pathspec_file_null)
+		die(_("--pathspec-file-null requires --pathspec-from-file"));
+
+	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
+		die(_("No paths with --include/--only does not make sense."));
+
 	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
 
@@ -1198,8 +1215,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
-	if (argc == 0 && (also || (only && !amend && !allow_empty)))
-		die(_("No paths with --include/--only does not make sense."));
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
@@ -1535,6 +1550,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_FILENAME(0, "pathspec-from-file", &pathspec_from_file, N_("read pathspecs from file")),
+		OPT_BOOL(0, "pathspec-file-null", &pathspec_file_null, N_("with --pathspec-from-file, pathspecs are separated with NUL character")),
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
new file mode 100755
index 0000000000..c5d68e01e6
--- /dev/null
+++ b/t/t7526-commit-pathspec-file.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='commit --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+cat > expect.a <<EOF
+A	fileA.t
+EOF
+
+cat > expect.ab <<EOF
+A	fileA.t
+A	fileB.t
+EOF
+
+cat > expect.bc <<EOF
+A	fileB.t
+A	fileC.t
+EOF
+
+test_expect_success setup '
+	test_commit file0 &&
+	checkpoint=$(git rev-parse --verify HEAD) &&
+	
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t
+'
+
+restore_checkpoint () {
+	git reset --soft "$checkpoint"
+}
+
+verify_state () {
+	git diff-tree --no-commit-id --name-status -r HEAD >actual &&
+	test_cmp "$1" actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	echo fileA.t | git commit --pathspec-from-file=- -m "Commit" &&
+
+	verify_state expect.a
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	echo fileA.t >list &&
+	git commit --pathspec-from-file=list -m "Commit" &&
+
+	verify_state expect.a
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	printf fileA.tQfileB.t | q_to_nul | git commit --pathspec-from-file=- --pathspec-file-null -m "Commit" &&
+
+	verify_state expect.ab
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	verify_state expect.ab
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\r\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	verify_state expect.ab
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	verify_state expect.a
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-null' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" >list &&
+	test_must_fail git commit --pathspec-from-file=list --pathspec-file-null -m "Commit"
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	printf "fileB.t\nfileC.t" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	verify_state expect.bc
+'
+
+test_done
-- 
gitgitgadget
