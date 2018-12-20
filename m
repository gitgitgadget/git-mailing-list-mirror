Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41131F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbeLTTpY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389489AbeLTTpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so2985870wrp.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+vYJTBBsL/3j1u7TscbYY7ltzR/Vwdr3yyklg0Kz38=;
        b=p0UcvVCBrlEVUKdjpzvrjvTObGKzRFuYjQTVzjJnEA1C4vjicdeggaX+B4srzIKGN+
         TD2yJn6vWf4JwZMNfSgHGVdvJXPi46j/7Yum0TUS31fV5SacjqvJL1QBEXAUeFiaiGaR
         9BeLHbz64hw6TvHDZs/4WJlIFmfV9XvvWy2jMFGgs6AWiiJT4W5hy//JpG51hw32hBbd
         U5tEKAOMCZI2NB3fFQfKQvBnOseB04s8jcriB5y36kW2PpYcxUU05DuH8vRsfyxzhrM3
         40EdyGwQLCHW7xXbpP4hrpUgalIvDIflZ6zW7CH3ArB3XcHgFmbanzX3kQxYcq0Jciou
         QGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+vYJTBBsL/3j1u7TscbYY7ltzR/Vwdr3yyklg0Kz38=;
        b=uiYCGrfQ7/sv0fzoZ1CNMb44CdXb09sPryGZO5Zkz/eemf6vTkxspZ2H0yyL5DBPuR
         vvNxwU70DpsgprNPt5KhxhUroAmv1ZbNw1y/H6tG35bdxv5TKUTqdjCW1CRmb+nDyRYj
         SLXGOqyHFYCKLmBRwBenL1e2NixeIhPATKZbRZJTLf3Fow+HSE+Sq0v91/en7MzMVgkw
         Ynr/kEy9klwVxOpV7fj3WsgSye6u1VmjAYU9yvmB1zDvnHZYwk24Fn9AA5q6vJ8QsN91
         T1sqY1B1Y6ZdN8TGAAQqV388YlvF6nAxwNQqP2yI1ZgSl1Bmwi9Z7/HV7HhlZUqLubB3
         sdwQ==
X-Gm-Message-State: AA+aEWYrA7MrPCd3on2s7xhPSFn+O7SbgKMEB6VWJiFePo61kVVa0LSJ
        YUw9uRkTYjgbxsgk3T8Nqk48KU9txbU=
X-Google-Smtp-Source: AFSGD/VbqhcejWkfPZMNpsQf7MqYRoNDs2RZFgv+N+b2MhAyCqFf02QxaT/lMu5BaYekFhav9DZTYQ==
X-Received: by 2002:adf:d1d2:: with SMTP id m18mr24851215wri.138.1545335110622;
        Thu, 20 Dec 2018 11:45:10 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:10 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 23/26] stash: convert `stash--helper.c` into `stash.c`
Date:   Thu, 20 Dec 2018 21:44:39 +0200
Message-Id: <a6d4d880ffb837a806bf361be28e0b5445b418c1.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old shell script `git-stash.sh`  was removed and replaced
entirely by `builtin/stash.c`. In order to do that, `create` and
`push` were adapted to work without `stash.sh`. For example, before
this commit, `git stash create` called `git stash--helper create
--message "$*"`. If it called `git stash--helper create "$@"`, then
some of these changes wouldn't have been necessary.

This commit also removes the word `helper` since now stash is
called directly and not by a shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 .gitignore                           |   1 -
 Makefile                             |   3 +-
 builtin.h                            |   2 +-
 builtin/{stash--helper.c => stash.c} | 154 +++++++++++++++------------
 git-stash.sh                         | 153 --------------------------
 git.c                                |   2 +-
 6 files changed, 91 insertions(+), 224 deletions(-)
 rename builtin/{stash--helper.c => stash.c} (91%)
 delete mode 100755 git-stash.sh

diff --git a/.gitignore b/.gitignore
index 6ecab90ab2..0d77ea5894 100644
--- a/.gitignore
+++ b/.gitignore
@@ -162,7 +162,6 @@
 /git-show-ref
 /git-stage
 /git-stash
-/git-stash--helper
 /git-status
 /git-stripspace
 /git-submodule
diff --git a/Makefile b/Makefile
index c246fc7078..8cee2731aa 100644
--- a/Makefile
+++ b/Makefile
@@ -619,7 +619,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-legacy-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
@@ -1117,7 +1116,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/stash--helper.o
+BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index ff4460aff7..b78ab6e30b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -225,7 +225,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
-extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_stash(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash.c
similarity index 91%
rename from builtin/stash--helper.c
rename to builtin/stash.c
index 39fcff32b7..fe32ff42fd 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash.c
@@ -16,75 +16,70 @@
 
 #define INCLUDE_ALL_FILES 2
 
-static const char * const git_stash_helper_usage[] = {
-	N_("git stash--helper list [<options>]"),
-	N_("git stash--helper show [<options>] [<stash>]"),
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
-	N_("git stash--helper branch <branchname> [<stash>]"),
-	N_("git stash--helper clear"),
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_usage[] = {
+	N_("git stash list [<options>]"),
+	N_("git stash show [<options>] [<stash>]"),
+	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash branch <branchname> [<stash>]"),
+	N_("git stash clear"),
+	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_list_usage[] = {
-	N_("git stash--helper list [<options>]"),
+static const char * const git_stash_list_usage[] = {
+	N_("git stash list [<options>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_show_usage[] = {
-	N_("git stash--helper show [<options>] [<stash>]"),
+static const char * const git_stash_show_usage[] = {
+	N_("git stash show [<options>] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_drop_usage[] = {
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+static const char * const git_stash_drop_usage[] = {
+	N_("git stash drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_pop_usage[] = {
-	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+static const char * const git_stash_pop_usage[] = {
+	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_apply_usage[] = {
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+static const char * const git_stash_apply_usage[] = {
+	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_branch_usage[] = {
-	N_("git stash--helper branch <branchname> [<stash>]"),
+static const char * const git_stash_branch_usage[] = {
+	N_("git stash branch <branchname> [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_clear_usage[] = {
-	N_("git stash--helper clear"),
+static const char * const git_stash_clear_usage[] = {
+	N_("git stash clear"),
 	NULL
 };
 
-static const char * const git_stash_helper_store_usage[] = {
-	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+static const char * const git_stash_store_usage[] = {
+	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
 	NULL
 };
 
-static const char * const git_stash_helper_create_usage[] = {
-	N_("git stash--helper create [<message>]"),
-	NULL
-};
-
-static const char * const git_stash_helper_push_usage[] = {
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_push_usage[] = {
+	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
-static const char * const git_stash_helper_save_usage[] = {
-	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_save_usage[] = {
+	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
@@ -221,7 +216,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_clear_usage,
+			     git_stash_clear_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc)
@@ -526,7 +521,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_apply_usage, 0);
+			     git_stash_apply_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -599,7 +594,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_drop_usage, 0);
+			     git_stash_drop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -625,7 +620,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_pop_usage, 0);
+			     git_stash_pop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -652,7 +647,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_branch_usage, 0);
+			     git_stash_branch_usage, 0);
 
 	if (!argc) {
 		fprintf_ln(stderr, _("No branch name specified"));
@@ -687,7 +682,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_list_usage,
+			     git_stash_list_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!ref_exists(ref_stash))
@@ -767,7 +762,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (argc > 1) {
 		free_stash_info(&info);
-		usage_with_options(git_stash_helper_show_usage, options);
+		usage_with_options(git_stash_show_usage, options);
 	}
 
 	rev.diffopt.flags.recursive = 1;
@@ -813,7 +808,7 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_store_usage,
+			     git_stash_store_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (argc != 1) {
@@ -1227,29 +1222,18 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
-	int include_untracked = 0;
 	int ret = 0;
-	const char *stash_msg = NULL;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct stash_info info;
 	struct pathspec ps;
-	struct option options[] = {
-		OPT_BOOL('u', "include-untracked", &include_untracked,
-			 N_("include untracked files in stash")),
-		OPT_STRING('m', "message", &stash_msg, N_("message"),
-			 N_("stash message")),
-		OPT_END()
-	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_create_usage,
-			     0);
+	/* Starting with argv[1], since argv[0] is "create" */
+	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
 	if (!check_changes_tracked_files(ps))
 		return 0;
 
-	strbuf_addstr(&stash_msg_buf, stash_msg);
 	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
@@ -1479,9 +1463,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_push_usage,
-			     0);
+	if (argc)
+		argc = parse_options(argc, argv, prefix, options,
+				     git_stash_push_usage,
+				     0);
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
 	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
@@ -1514,7 +1499,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_save_usage,
+			     git_stash_save_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (argc)
@@ -1528,10 +1513,12 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+int cmd_stash(int argc, const char **argv, const char *prefix)
 {
+	int i = -1;
 	pid_t pid = getpid();
 	const char *index_file;
+	struct argv_array args = ARGV_ARRAY_INIT;
 
 	struct option options[] = {
 		OPT_END()
@@ -1539,16 +1526,16 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
 	index_file = get_index_file();
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (argc < 1)
-		usage_with_options(git_stash_helper_usage, options);
-	if (!strcmp(argv[0], "apply"))
+	if (!argc)
+		return !!push_stash(0, NULL, prefix);
+	else if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "clear"))
 		return !!clear_stash(argc, argv, prefix);
@@ -1570,7 +1557,42 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!push_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
+	else if (*argv[0] != '-')
+		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
+			      git_stash_usage, options);
+
+	if (strcmp(argv[0], "-p")) {
+		while (++i < argc && strcmp(argv[i], "--")) {
+			/*
+			 * `akpqu` is a string which contains all short options,
+			 * except `-m` which is verified separately.
+			 */
+			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
+			    strchr("akpqu", argv[i][1]))
+				continue;
+
+			if (!strcmp(argv[i], "--all") ||
+			    !strcmp(argv[i], "--keep-index") ||
+			    !strcmp(argv[i], "--no-keep-index") ||
+			    !strcmp(argv[i], "--patch") ||
+			    !strcmp(argv[i], "--quiet") ||
+			    !strcmp(argv[i], "--include-untracked"))
+				continue;
+
+			/*
+			 * `-m` and `--message=` are verified separately because
+			 * they need to be immediately followed by a string
+			 * (i.e.`-m"foobar"` or `--message="foobar"`).
+			 */
+			if (starts_with(argv[i], "-m") ||
+			    starts_with(argv[i], "--message="))
+				continue;
+
+			usage_with_options(git_stash_usage, options);
+		}
+	}
 
-	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
-		      git_stash_helper_usage, options);
+	argv_array_push(&args, "push");
+	argv_array_pushv(&args, argv);
+	return !!push_stash(args.argc, args.argv, prefix);
 }
diff --git a/git-stash.sh b/git-stash.sh
deleted file mode 100755
index 695f1feba3..0000000000
--- a/git-stash.sh
+++ /dev/null
@@ -1,153 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2007, Nanako Shiraishi
-
-dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="list [<options>]
-   or: $dashless show [<stash>]
-   or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-   or: $dashless branch <branchname> [<stash>]
-   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		      [-u|--include-untracked] [-a|--all] [<message>]
-   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [-m <message>]
-		       [-- <pathspec>...]]
-   or: $dashless clear"
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-START_DIR=$(pwd)
-. git-sh-setup
-require_work_tree
-prefix=$(git rev-parse --show-prefix) || exit 1
-cd_to_toplevel
-
-TMP="$GIT_DIR/.git-stash.$$"
-TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
-trap 'rm -f "$TMP-"* "$TMPindex"' 0
-
-ref_stash=refs/stash
-
-if git config --get-colorbool color.interactive; then
-       help_color="$(git config --get-color color.interactive.help 'red bold')"
-       reset_color="$(git config --get-color '' reset)"
-else
-       help_color=
-       reset_color=
-fi
-
-#
-# Parses the remaining options looking for flags and
-# at most one revision defaulting to ${ref_stash}@{0}
-# if none found.
-#
-# Derives related tree and commit objects from the
-# revision, if one is found.
-#
-# stash records the work tree, and is a merge between the
-# base commit (first parent) and the index tree (second parent).
-#
-#   REV is set to the symbolic version of the specified stash-like commit
-#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
-#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
-#   s is set to the SHA1 of the stash commit
-#   w_commit is set to the commit containing the working tree
-#   b_commit is set to the base commit
-#   i_commit is set to the commit containing the index tree
-#   u_commit is set to the commit containing the untracked files tree
-#   w_tree is set to the working tree
-#   b_tree is set to the base tree
-#   i_tree is set to the index tree
-#   u_tree is set to the untracked files tree
-#
-#   GIT_QUIET is set to t if -q is specified
-#   INDEX_OPTION is set to --index if --index is specified.
-#   FLAGS is set to the remaining flags (if allowed)
-#
-# dies if:
-#   * too many revisions specified
-#   * no revision is specified and there is no stash stack
-#   * a revision is specified which cannot be resolve to a SHA1
-#   * a non-existent stash reference is specified
-#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
-#
-
-test "$1" = "-p" && set "push" "$@"
-
-PARSE_CACHE='--not-parsed'
-# The default command is "push" if nothing but options are given
-seen_non_option=
-for opt
-do
-	case "$opt" in
-	--) break ;;
-	-*) ;;
-	*) seen_non_option=t; break ;;
-	esac
-done
-
-test -n "$seen_non_option" || set "push" "$@"
-
-# Main command set
-case "$1" in
-list)
-	shift
-	git stash--helper list "$@"
-	;;
-show)
-	shift
-	git stash--helper show "$@"
-	;;
-save)
-	shift
-	cd "$START_DIR"
-	git stash--helper save "$@"
-	;;
-push)
-	shift
-	cd "$START_DIR"
-	git stash--helper push "$@"
-	;;
-apply)
-	shift
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	;;
-clear)
-	shift
-	git stash--helper clear "$@"
-	;;
-create)
-	shift
-	git stash--helper create --message "$*"
-	;;
-store)
-	shift
-	git stash--helper store "$@"
-	;;
-drop)
-	shift
-	git stash--helper drop "$@"
-	;;
-pop)
-	shift
-	cd "$START_DIR"
-	git stash--helper pop "$@"
-	;;
-branch)
-	shift
-	cd "$START_DIR"
-	git stash--helper branch "$@"
-	;;
-*)
-	case $# in
-	0)
-		cd "$START_DIR"
-		git stash--helper push &&
-		say "$(gettext "(To restore them type \"git stash apply\")")"
-		;;
-	*)
-		usage
-	esac
-	;;
-esac
diff --git a/git.c b/git.c
index de9c774573..8a20909eae 100644
--- a/git.c
+++ b/git.c
@@ -554,7 +554,7 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.20.1.441.g764a526393

