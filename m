Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B948AC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377411AbiDTKAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377373AbiDTJ7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55673BF93
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e21so1485267wrc.8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y1ESANf/m0uLV1VxDTeCxu5by2O2N28lW6PIgjqXsEY=;
        b=Pi7gkWalKvSSFdnOqgAhdtrl4P1fYVzd0T1PHPOgM7Cy8th5tr8wwkLFAkW9dCJ4IX
         5EpZcniCM0gCfwzdZ93tn9DR3Q2iQPTUabJ/FW9A7Pe9v7PTazmCYQyd/0MwlzQV8Fcp
         2GSW/qJp1WJafF5F737Sd312pSdwWnzkp3DvCRhUfMf9PZzIGbKViJirpRJunlBsrZ9y
         RM/LXOPGBYOROO6fwd6FTEclPiZbGCBvq1Ezik4Ziqej8wvHP4hf6oNDWZSyOFKTSocN
         FT9sPeBa2718/nBT3+gjur2Oxz/v/+Un+VdD4WxMtEfeIjln/yzeHfd51E7G069eZyNw
         NOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y1ESANf/m0uLV1VxDTeCxu5by2O2N28lW6PIgjqXsEY=;
        b=hEQWOgsL3TQN2iJvkQ2HKKL75dbgofhr5TO4JiGl0kdAy0gdOVfLa6OInaFE0xWwwu
         bdNEHmugCKc2NChORhmmY7CJ2juvDdDbJQwHi21oBlDR6kd2+Tx8AGK5ECvWL5oTLvpP
         EarSFvCGBtUXssluMIIh+x0DwRs167oQe3TS0sSLP8+0blHv7N9AmIfqc9g9CvedkFDC
         E8Ri1NM2kjwUmWuTDYB3pJZSrK0EoCk12lOCyyZI+sgW/yOf5nTt/90Dr463wtO9/ASQ
         5zU72HoYyqfUnnOayzYD4PfPlmDJpG3LN+5Y+cjd69pRBvts4NPqlQxoDhULAIq4BgoA
         XEWA==
X-Gm-Message-State: AOAM5314ZsKZLZcV4nfOwP18Fc5E6TAzIAJ0b5gxAe4t8d0kWlm+osWa
        4L4HZQXWuFEKh5SMglLzj0gGHZ1bMlY=
X-Google-Smtp-Source: ABdhPJxci5ST5/4NkAKfvCyVmhd22r+30aPB13SfsyPDsYJhVULhMYe0DeRTaeLV+orNl2ii/0W6/w==
X-Received: by 2002:a5d:6201:0:b0:207:8d91:aaa9 with SMTP id y1-20020a5d6201000000b002078d91aaa9mr15006627wru.262.1650448624065;
        Wed, 20 Apr 2022 02:57:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm14678036wrf.41.2022.04.20.02.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:57:03 -0700 (PDT)
Message-Id: <b0d21affa788c5ac953617c3f006b19a28f85d79.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:51 +0000
Subject: [PATCH v2 8/8] rebase: cleanup action handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Treating the action as a string is a hang over from the scripted
rebase. The last commit removed the only remaining use of the action
that required a string so lets convert the other action users to use
the existing action enum instead. If we ever need the action name as a
string in the future the action_names array exists exactly for that
purpose.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 91 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 70426e17b40..323f5154092 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -58,6 +58,26 @@ enum empty_type {
 	EMPTY_ASK
 };
 
+enum action {
+	ACTION_NONE = 0,
+	ACTION_CONTINUE,
+	ACTION_SKIP,
+	ACTION_ABORT,
+	ACTION_QUIT,
+	ACTION_EDIT_TODO,
+	ACTION_SHOW_CURRENT_PATCH
+};
+
+static const char *action_names[] = {
+	"undefined",
+	"continue",
+	"skip",
+	"abort",
+	"quit",
+	"edit_todo",
+	"show_current_patch"
+};
+
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
@@ -84,7 +104,7 @@ struct rebase_options {
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
 	struct strvec git_am_opts;
-	const char *action;
+	enum action action;
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
@@ -155,24 +175,6 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	return replay;
 }
 
-enum action {
-	ACTION_NONE = 0,
-	ACTION_CONTINUE,
-	ACTION_SKIP,
-	ACTION_ABORT,
-	ACTION_QUIT,
-	ACTION_EDIT_TODO,
-	ACTION_SHOW_CURRENT_PATCH
-};
-
-static const char *action_names[] = { "undefined",
-				      "continue",
-				      "skip",
-				      "abort",
-				      "quit",
-				      "edit_todo",
-				      "show_current_patch" };
-
 static int edit_todo_file(unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
@@ -309,8 +311,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	return ret;
 }
 
-static int run_sequencer_rebase(struct rebase_options *opts,
-				  enum action command)
+static int run_sequencer_rebase(struct rebase_options *opts)
 {
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
@@ -325,7 +326,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
 	flags |= opts->flags & REBASE_NO_QUIET ? TODO_LIST_WARN_SKIPPED_CHERRY_PICKS : 0;
 
-	switch (command) {
+	switch (opts->action) {
 	case ACTION_NONE: {
 		if (!opts->onto && !opts->upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
@@ -358,7 +359,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 		break;
 	}
 	default:
-		BUG("invalid command '%d'", command);
+		BUG("invalid command '%d'", opts->action);
 	}
 
 	return ret;
@@ -615,7 +616,7 @@ static int run_am(struct rebase_options *opts)
 	strvec_push(&am.args, "am");
 	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
 		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
-	if (opts->action && !strcmp("continue", opts->action)) {
+	if (opts->action == ACTION_CONTINUE) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 		if (opts->gpg_sign_opt)
@@ -626,7 +627,7 @@ static int run_am(struct rebase_options *opts)
 
 		return move_to_original_branch(opts);
 	}
-	if (opts->action && !strcmp("skip", opts->action)) {
+	if (opts->action == ACTION_SKIP) {
 		strvec_push(&am.args, "--skip");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 		status = run_command(&am);
@@ -635,7 +636,7 @@ static int run_am(struct rebase_options *opts)
 
 		return move_to_original_branch(opts);
 	}
-	if (opts->action && !strcmp("show-current-patch", opts->action)) {
+	if (opts->action == ACTION_SHOW_CURRENT_PATCH) {
 		strvec_push(&am.args, "--show-current-patch");
 		return run_command(&am);
 	}
@@ -728,7 +729,7 @@ static int run_am(struct rebase_options *opts)
 	return status;
 }
 
-static int run_specific_rebase(struct rebase_options *opts, enum action action)
+static int run_specific_rebase(struct rebase_options *opts)
 {
 	int status;
 
@@ -746,7 +747,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 			opts->gpg_sign_opt = tmp;
 		}
 
-		status = run_sequencer_rebase(opts, action);
+		status = run_sequencer_rebase(opts);
 	} else if (opts->type == REBASE_APPLY)
 		status = run_am(opts);
 	else
@@ -1016,7 +1017,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
 	int ignore_whitespace = 0;
-	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1065,18 +1065,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-ff", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
-		OPT_CMDMODE(0, "continue", &action, N_("continue"),
+		OPT_CMDMODE(0, "continue", &options.action, N_("continue"),
 			    ACTION_CONTINUE),
-		OPT_CMDMODE(0, "skip", &action,
+		OPT_CMDMODE(0, "skip", &options.action,
 			    N_("skip current patch and continue"), ACTION_SKIP),
-		OPT_CMDMODE(0, "abort", &action,
+		OPT_CMDMODE(0, "abort", &options.action,
 			    N_("abort and check out the original branch"),
 			    ACTION_ABORT),
-		OPT_CMDMODE(0, "quit", &action,
+		OPT_CMDMODE(0, "quit", &options.action,
 			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
-		OPT_CMDMODE(0, "edit-todo", &action, N_("edit the todo list "
+		OPT_CMDMODE(0, "edit-todo", &options.action, N_("edit the todo list "
 			    "during an interactive rebase"), ACTION_EDIT_TODO),
-		OPT_CMDMODE(0, "show-current-patch", &action,
+		OPT_CMDMODE(0, "show-current-patch", &options.action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
 		OPT_CALLBACK_F(0, "apply", &options, NULL,
@@ -1189,7 +1189,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges"));
 
-	if (action != ACTION_NONE && total_argc != 2) {
+	if (options.action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 	}
@@ -1208,11 +1208,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.root && options.fork_point > 0)
 		die(_("cannot combine '--root' with '--fork-point'"));
 
-	if (action != ACTION_NONE && !in_progress)
+	if (options.action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
-	if (action == ACTION_EDIT_TODO && !is_merge(&options))
+	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
@@ -1222,16 +1222,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		else if (exec.nr)
 			trace2_cmd_mode("interactive-exec");
 		else
-			trace2_cmd_mode(action_names[action]);
+			trace2_cmd_mode(action_names[options.action]);
 	}
 
-	switch (action) {
+	switch (options.action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
 		struct lock_file lock_file = LOCK_INIT;
 		int fd;
 
-		options.action = "continue";
 		/* Sanity check */
 		if (get_oid("HEAD", &head))
 			die(_("Cannot read HEAD"));
@@ -1257,7 +1256,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	case ACTION_SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-		options.action = "skip";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
@@ -1272,7 +1270,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 		struct strbuf head_msg = STRBUF_INIT;
 
-		options.action = "abort";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
@@ -1312,17 +1309,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	case ACTION_EDIT_TODO:
-		options.action = "edit-todo";
 		options.dont_finish_rebase = 1;
 		goto run_rebase;
 	case ACTION_SHOW_CURRENT_PATCH:
-		options.action = "show-current-patch";
 		options.dont_finish_rebase = 1;
 		goto run_rebase;
 	case ACTION_NONE:
 		break;
 	default:
-		BUG("action: %d", action);
+		BUG("action: %d", options.action);
 	}
 
 	/* Make sure no rebase is in progress */
@@ -1346,7 +1341,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
-	    (action != ACTION_NONE) ||
+	    (options.action != ACTION_NONE) ||
 	    (exec.nr > 0) ||
 	    options.autosquash) {
 		allow_preemptive_ff = 0;
@@ -1786,7 +1781,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.revisions = revisions.buf;
 
 run_rebase:
-	ret = run_specific_rebase(&options, action);
+	ret = run_specific_rebase(&options);
 
 cleanup:
 	strbuf_release(&buf);
-- 
gitgitgadget
