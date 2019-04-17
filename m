Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7054C20248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfDQOdP (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36118 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732483AbfDQOdO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so3904026wml.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=oxBRKvQ27Xk9sUIZnHEVJCPeVAkgflsfVxg5fYefr1s=;
        b=E15psLeYq4ld4bd/icBwLMrY4P7hQdmCRwhJvLaupkSCKbqB92kieo9gjzizvBvuZZ
         ghkWL2oiWWB42UwTx6kEazDGKqMf4B3p6QGs0GLEb5vwgJDTcxuG3cxhWJymmAjp4JOB
         zYZxDkEKjvYGpLRrLhgpuj3wctp7hYWGyQmNPRnv9WrWXImGpWL8GlEBhXJB3XXMsboK
         5BARzRCvdxusFILe7m5NFDnGW8spDCgH1oDQQWko/QYzxyymCpllT9UoMB2IOcVQ0qO9
         hyRbVYA9styIO9vlxo8yZTM1cjFLqlJscKuP2chf+E78A+AQA4TzfNCSnpOPbRbjbF7W
         CB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=oxBRKvQ27Xk9sUIZnHEVJCPeVAkgflsfVxg5fYefr1s=;
        b=pJ8ArjDg4NnwiCY6pr1lPyP/w5hrrTgkdW8dsmH1cdOu6TUYhAldhTCVmeozD3IH+J
         DIiD9tTcQ4BXx5Qc2/0CNndZIOgENxROHu8ao/kUo/LSsE7fSlNofdJb1lDVeO6ehnRu
         j3h3UQQlYUGRvxLii8Jhl5hCaLaTkXaDvONFoEsYunh/JU8jtf7c384aiTU/h9pDSOqg
         H/Z65cASCIU10Fxsmjz3E9tz0afyhis4VaUpUv9Ns44dsMeTE1Z+eYPG1xDsVcjJxf9Y
         eWiERthidaWH9mxKhQxfD5f5hzSDxfTxg/GpIsXu08GNFLeeO3hDUV5PjWHTlczYcx6L
         GNaw==
X-Gm-Message-State: APjAAAX8AObwE8H7n5huFikzw5mQvGkVKoPCTVT3j0XZ2Z50tXfuQqPU
        qooOTT73fwFbCVFSXwYaf/nmO64h940=
X-Google-Smtp-Source: APXvYqxSkEakMTlvMb9qI/PEw0BSzWZe4KOYZ8kOdRrXLnbuwNTojpWPvRgolReRtm9k5hfqRVMwiA==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr32593757wme.67.1555511590825;
        Wed, 17 Apr 2019 07:33:10 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:33:10 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 11/12] rebase: use a common action enum
Date:   Wed, 17 Apr 2019 15:30:43 +0100
Message-Id: <20190417143044.17655-12-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

cmd_rebase() and cmd_rebase__interactive() used different enums to hold
the current action. Change to using a common enum so the values are the
same when we change `rebase -i` to avoid forking `rebase--interactive`.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 91 +++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 277dbaadf4..0020e1ecf6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -119,6 +119,29 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	return replay;
 }
 
+enum action {
+	ACTION_NONE = 0,
+	ACTION_CONTINUE,
+	ACTION_SKIP,
+	ACTION_ABORT,
+	ACTION_QUIT,
+	ACTION_EDIT_TODO,
+	ACTION_SHOW_CURRENT_PATCH,
+	ACTION_SHORTEN_OIDS,
+	ACTION_EXPAND_OIDS,
+	ACTION_CHECK_TODO_LIST,
+	ACTION_REARRANGE_SQUASH,
+	ACTION_ADD_EXEC
+};
+
+static const char *action_names[] = { "undefined",
+				      "continue",
+				      "skip",
+				      "abort",
+				      "quit",
+				      "edit_todo",
+				      "show_current_patch" };
+
 static int add_exec_commands(struct string_list *commands)
 {
 	const char *todo_file = rebase_path_todo();
@@ -347,10 +370,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
 	struct object_id squash_onto = null_oid;
-	enum {
-		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
-		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
-	} command = 0;
+	enum action command = ACTION_NONE;
 	struct option options[] = {
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
@@ -367,22 +387,22 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
-			    CONTINUE),
-		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
+			    ACTION_CONTINUE),
+		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), ACTION_SKIP),
 		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
-			    EDIT_TODO),
+			    ACTION_EDIT_TODO),
 		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
-			    SHOW_CURRENT_PATCH),
+			    ACTION_SHOW_CURRENT_PATCH),
 		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
+			N_("shorten commit ids in the todo list"), ACTION_SHORTEN_OIDS),
 		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand commit ids in the todo list"), EXPAND_OIDS),
+			N_("expand commit ids in the todo list"), ACTION_EXPAND_OIDS),
 		OPT_CMDMODE(0, "check-todo-list", &command,
-			N_("check the todo list"), CHECK_TODO_LIST),
+			N_("check the todo list"), ACTION_CHECK_TODO_LIST),
 		OPT_CMDMODE(0, "rearrange-squash", &command,
-			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
+			N_("rearrange fixup/squash lines"), ACTION_REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
-			N_("insert exec commands in todo list"), ADD_EXEC),
+			N_("insert exec commands in todo list"), ACTION_ADD_EXEC),
 		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"), N_("onto"),
 		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
 		{ OPTION_CALLBACK, 0, "restrict-revision", &opts.restrict_revision,
@@ -428,36 +448,36 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= opts.rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts.rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
-	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
 	switch (command) {
-	case NONE: {
+	case ACTION_NONE: {
 		if (!opts.onto && !opts.upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
 
 		ret = do_interactive_rebase(&opts, flags);
 		break;
 	}
-	case SKIP: {
+	case ACTION_SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		rerere_clear(the_repository, &merge_rr);
 	}
 		/* fallthrough */
-	case CONTINUE: {
+	case ACTION_CONTINUE: {
 		struct replay_opts replay_opts = get_replay_opts(&opts);
 
 		ret = sequencer_continue(the_repository, &replay_opts);
 		break;
 	}
-	case EDIT_TODO:
+	case ACTION_EDIT_TODO:
 		ret = edit_todo_file(flags);
 		break;
-	case SHOW_CURRENT_PATCH: {
+	case ACTION_SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
@@ -466,17 +486,17 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 		break;
 	}
-	case SHORTEN_OIDS:
-	case EXPAND_OIDS:
+	case ACTION_SHORTEN_OIDS:
+	case ACTION_EXPAND_OIDS:
 		ret = transform_todo_file(flags);
 		break;
-	case CHECK_TODO_LIST:
+	case ACTION_CHECK_TODO_LIST:
 		ret = check_todo_list_from_file(the_repository);
 		break;
-	case REARRANGE_SQUASH:
+	case ACTION_REARRANGE_SQUASH:
 		ret = rearrange_squash_in_todo_file();
 		break;
-	case ADD_EXEC: {
+	case ACTION_ADD_EXEC: {
 		struct string_list commands = STRING_LIST_INIT_DUP;
 
 		split_exec_commands(opts.cmd, &commands);
@@ -1417,22 +1437,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
-	enum {
-		NO_ACTION,
-		ACTION_CONTINUE,
-		ACTION_SKIP,
-		ACTION_ABORT,
-		ACTION_QUIT,
-		ACTION_EDIT_TODO,
-		ACTION_SHOW_CURRENT_PATCH,
-	} action = NO_ACTION;
-	static const char *action_names[] = { "undefined",
-					      "continue",
-					      "skip",
-					      "abort",
-					      "quit",
-					      "edit_todo",
-					      "show_current_patch" };
+	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1599,7 +1604,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
-	if (action != NO_ACTION && total_argc != 2) {
+	if (action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 	}
@@ -1608,7 +1613,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
-	if (action != NO_ACTION && !in_progress)
+	if (action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
@@ -1708,7 +1713,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.action = "show-current-patch";
 		options.dont_finish_rebase = 1;
 		goto run_rebase;
-	case NO_ACTION:
+	case ACTION_NONE:
 		break;
 	default:
 		BUG("action: %d", action);
-- 
2.21.0

