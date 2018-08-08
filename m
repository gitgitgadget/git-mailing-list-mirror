Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1E71F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbeHHVUp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53604 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeHHVUn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so3807682wmh.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O7tiBRwYOr7+tRjMR+6k9P+47zX6AtevV/9zlS8MExs=;
        b=NGWW7561ssXHaHBKg5JYeSDLnn44vNML5e0oTaRWxen0TDho2TgUFSWJ0ORFXstdhn
         P7PWJPxssB4OWRHBUhyNUY8CryJvNVCyZxdOIMSKHooK/GrcYFyg3tTeIglCuKXalWH5
         h/UdsahsUoPIbCwbtgEkUO+j3pdVTDpmvMaH12Vk1kuou0R5ABvzgyhxG/FWJzq27Mmz
         W9H/FqKCre/Oj9meUUjzt2cddZW4CZl7YAaHl1D3qOk8zBR+CV1kR1MFBYN1CHA4KCwp
         QxxxXyiS1JerX2hd4b4ANxCeJ1x+6FUfoi6/zX9LcmJZHXraFWK8VX6S2DqC/Y0um+Ly
         ndgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7tiBRwYOr7+tRjMR+6k9P+47zX6AtevV/9zlS8MExs=;
        b=LTTYCgKxBTAccW0IEHDOFsD41BYq4tYH0tZpuaS5F3aio/qmIQr1B6h4MsqVBnAKO3
         WIgI4fDLbyB/Gwsrjc20R8lJf75qrb2tDZ6y8k5ydxuT9hBDGUDySnN1pORJNM/HwRY1
         N1ZFVRuzROkP79F4gbm8pYTQ0Q1Ix1Rwe4kgtL32kddeyofXUu0Ltd0Wr9vYEzHveCsz
         aV43kaceUdqQ+iRAItyr4M0sK4kOeS34kMMSjubAas8BvCQ9JQ7+HdIf1ppTV0Cb75el
         7sk5MscNVhG1PjEiG2v+o+SWg/5l5uVt2fBAYWIqTiWZu7tL57Vw/usRJHkXWF9t+8Ce
         oz/w==
X-Gm-Message-State: AOUpUlGWoFAAWGhNAkFT0AdZGtX8xJptRvyloWNZU3+3G4y560rK2P9m
        3RXGU8JawrTiSIy40JJmcprd1h00
X-Google-Smtp-Source: AA+uWPy3N1BTasQtsMQYI6mCZ7PSRnYBYC24CIchsDA6j9I2YVJz9NTxNVsgHiLnFbhmkuNIO3AUVw==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr2525757wmc.81.1533754778329;
        Wed, 08 Aug 2018 11:59:38 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:37 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 23/26] stash: convert `stash--helper.c` into `stash.c`
Date:   Wed,  8 Aug 2018 21:59:02 +0300
Message-Id: <c659174b1be950072580ee176d59f85574cdb96c.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
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
---
 .gitignore                           |   1 -
 Makefile                             |   3 +-
 builtin.h                            |   2 +-
 builtin/{stash--helper.c => stash.c} | 132 ++++++++++++-----------
 git-stash.sh                         | 153 ---------------------------
 git.c                                |   2 +-
 6 files changed, 74 insertions(+), 219 deletions(-)
 rename builtin/{stash--helper.c => stash.c} (91%)
 delete mode 100755 git-stash.sh

diff --git a/.gitignore b/.gitignore
index 3abbba81a..3284a1e9b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,7 +156,6 @@
 /git-show-ref
 /git-stage
 /git-stash
-/git-stash--helper
 /git-status
 /git-stripspace
 /git-submodule
diff --git a/Makefile b/Makefile
index af82bc7ee..c41e31ad8 100644
--- a/Makefile
+++ b/Makefile
@@ -612,7 +612,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
@@ -1083,7 +1082,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/stash--helper.o
+BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 55ceb1574..e8102d825 100644
--- a/builtin.h
+++ b/builtin.h
@@ -222,7 +222,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
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
index f54a476e3..0ef88408a 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash.c
@@ -14,77 +14,77 @@
 #include "log-tree.h"
 #include "diffcore.h"
 
-static const char * const git_stash_helper_usage[] = {
-	N_("git stash--helper list [<options>]"),
-	N_("git stash--helper show [<options>] [<stash>]"),
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
-	N_("git stash--helper branch <branchname> [<stash>]"),
-	N_("git stash--helper clear"),
-	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
-	N_("git stash--helper create [<message>]"),
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_usage[] = {
+	N_("git stash list [<options>]"),
+	N_("git stash show [<options>] [<stash>]"),
+	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash branch <branchname> [<stash>]"),
+	N_("git stash clear"),
+	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
+	N_("git stash create [<message>]"),
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
+static const char * const git_stash_create_usage[] = {
+	N_("git stash create [<message>]"),
 	NULL
 };
 
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
@@ -224,11 +224,11 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_clear_usage,
+			     git_stash_clear_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc != 0)
-		return error(_("git stash--helper clear with parameters is unimplemented"));
+		return error(_("git stash clear with parameters is unimplemented"));
 
 	return do_clear_stash();
 }
@@ -519,7 +519,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_apply_usage, 0);
+			     git_stash_apply_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -591,7 +591,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_drop_usage, 0);
+			     git_stash_drop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -615,7 +615,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_pop_usage, 0);
+			     git_stash_pop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -641,7 +641,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_branch_usage, 0);
+			     git_stash_branch_usage, 0);
 
 	if (argc == 0)
 		return error(_("No branch name specified"));
@@ -674,7 +674,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_list_usage,
+			     git_stash_list_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!ref_exists(ref_stash))
@@ -762,7 +762,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	if (argc > 1) {
 		free_stash_info(&info);
 		argv_array_clear(&stash_args);
-		usage_with_options(git_stash_helper_show_usage, options);
+		usage_with_options(git_stash_show_usage, options);
 	}
 
 	/* Do the diff thing. */
@@ -781,7 +781,7 @@ static int do_store_stash(const char *w_commit, const char *stash_msg,
 	struct object_id obj;
 
 	if (!stash_msg)
-		stash_msg  = xstrdup("Created via \"git stash--helper store\".");
+		stash_msg  = xstrdup("Created via \"git stash store\".");
 
 	ret = get_oid(w_commit, &obj);
 	if (!ret) {
@@ -807,11 +807,11 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_store_usage,
+			     git_stash_store_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (argc != 1) {
-		fprintf(stderr, _("\"git stash--helper store\" requires one <commit> argument\n"));
+		fprintf(stderr, _("\"git stash store\" requires one <commit> argument\n"));
 		return -1;
 	}
 
@@ -1220,23 +1220,26 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
+	int i;
 	int include_untracked = 0;
 	int ret = 0;
-	const char *stash_msg = NULL;
 	struct stash_info info;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
+	const char *stash_msg;
 	struct option options[] = {
-		OPT_BOOL('u', "include-untracked", &include_untracked,
-			 N_("include untracked files in stash")),
-		OPT_STRING('m', "message", &stash_msg, N_("message"),
-			 N_("stash message")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_create_usage,
+			     git_stash_create_usage,
 			     0);
 
-	ret = do_create_stash(argc, argv, prefix, &stash_msg,
+	for (i = 0; i < argc; ++i)
+		strbuf_addf(&stash_msg_buf, "%s ", argv[i]);
+
+	stash_msg = strbuf_detach(&stash_msg_buf, NULL);
+
+	ret = do_create_stash(0, NULL, prefix, &stash_msg,
 			      include_untracked, 0, &info, 0);
 
 	if (!ret)
@@ -1445,9 +1448,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_push_usage,
-			     0);
+	if (argc)
+		argc = parse_options(argc, argv, prefix, options,
+				     git_stash_push_usage,
+				     0);
 
 	return do_push_stash(argc, argv, prefix, keep_index, patch_mode,
 			     include_untracked, quiet, stash_msg);
@@ -1479,7 +1483,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_save_usage,
+			     git_stash_save_usage,
 			     0);
 
 	for (i = 0; i < argc; ++i)
@@ -1491,7 +1495,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 			     include_untracked, quiet, stash_msg);
 }
 
-int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
 	const char *index_file;
@@ -1502,16 +1506,16 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
 	index_file = get_index_file();
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (argc < 1)
-		usage_with_options(git_stash_helper_usage, options);
-	if (!strcmp(argv[0], "apply"))
+	if (argc == 0)
+		return !!push_stash(0, NULL, prefix);
+	else if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "clear"))
 		return !!clear_stash(argc, argv, prefix);
@@ -1533,7 +1537,13 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!push_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
+	if (*argv[0] == '-') {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_push(&args, "push");
+		argv_array_pushv(&args, argv);
+		return !!push_stash(args.argc, args.argv, prefix);
+	}
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
-		      git_stash_helper_usage, options);
+		      git_stash_usage, options);
 }
diff --git a/git-stash.sh b/git-stash.sh
deleted file mode 100755
index 695f1feba..000000000
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
index a3c83f57e..add13c823 100644
--- a/git.c
+++ b/git.c
@@ -543,7 +543,7 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.18.0.573.g56500d98f

