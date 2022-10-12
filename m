Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F7CC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJLJgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJLJfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE357207
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u10so25396593wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BieU9AgaJF5Ji/4FX7MwcUWI5/IOor7hnP5k7IMVWkk=;
        b=mHtEbLh+mzoGPUt0Dgjx6HDnmI0EfNEdtJLSABU2QsbnrIsc6o7LhpuqR0cBohYIT2
         kAqQ9gIfIuiu+294SaBPsxdRAfjB6qDw+RorpFGfV1+ek2oRnjx5G0aaiIr9jjLeBj0v
         biCKUuw9srqgL+r8TFL9aRsioeWyLD7bo9+4C15CVjLofVanuTPUrk6ks/ELH5lqxTey
         rPHeKu31DegXb3rAxcQFNwz5VsF6Y8Ez+ENxSOQUb36KJooouHJ1/2gA9QWzWPcD0Flz
         Uz3CtTIUapok3kcKJCYv9p4vrQWg7aUklQDLg8TIeX1r5JnrnnbEtMYMT+QEJfEAVb0p
         ztrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BieU9AgaJF5Ji/4FX7MwcUWI5/IOor7hnP5k7IMVWkk=;
        b=mS0DwVgfvOrD0bizF8otJiuy2ApXS+UYQk0rrn7uqFNfBsJ7HmR0KxU2xvu+lMvn3j
         a71Wbo+ojKk2r9uYX7SEA/RjUWzMN4aeT8fpcsDfpRXsUwewQ/W8hAyuDQjN02ZZdc/N
         H+LErYabm8GWu24G1KtTx9sequpt+hmb5AhiRs6N2HgJK4SK/UXOQARLWeeHESwiEpZW
         uFo7vN+Ncp1jGZsL82ux/jbptviD4rTVA/xKeI3rddBZTWtu6/tz36R6f6gdDG9mlOmc
         qxWctcwaSmbFHcm29PmVvW/BhtQU+NJOK0HW64N2o9Y680TpiHHEYYqVnKBzUgufLnbx
         xm4w==
X-Gm-Message-State: ACrzQf2YXyoTDmNn6Gd/EUv5WhjkTM08eecEJ8pSd6RUzXNqbcZBAPXg
        AgNSBYgKvT+gS2SOK22OPVyQ5GCZRW0=
X-Google-Smtp-Source: AMsMyM4/c39o+99BxvRs9zhxfnEvZ/T09W7cdR3TkuzFT5e6W/US2qqc2VPcQoPafjPghsulOXn5ww==
X-Received: by 2002:adf:ee0a:0:b0:22f:6a2a:92ab with SMTP id y10-20020adfee0a000000b0022f6a2a92abmr12475276wrn.545.1665567321805;
        Wed, 12 Oct 2022 02:35:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003bf6da9d2cesm1275108wmq.28.2022.10.12.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:21 -0700 (PDT)
Message-Id: <f9c8664b883d385f022b3c529bd2c336832488b6.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:12 +0000
Subject: [PATCH v3 8/8] rebase: cleanup action handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
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
 builtin/rebase.c | 93 +++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e4620935129..eb1fb8e3551 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -59,6 +59,26 @@ enum empty_type {
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
@@ -85,7 +105,7 @@ struct rebase_options {
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
 	struct strvec git_am_opts;
-	const char *action;
+	enum action action;
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
@@ -156,24 +176,6 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
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
@@ -310,8 +312,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	return ret;
 }
 
-static int run_sequencer_rebase(struct rebase_options *opts,
-				  enum action command)
+static int run_sequencer_rebase(struct rebase_options *opts)
 {
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
@@ -326,7 +327,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
 	flags |= opts->flags & REBASE_NO_QUIET ? TODO_LIST_WARN_SKIPPED_CHERRY_PICKS : 0;
 
-	switch (command) {
+	switch (opts->action) {
 	case ACTION_NONE: {
 		if (!opts->onto && !opts->upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
@@ -359,7 +360,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 		break;
 	}
 	default:
-		BUG("invalid command '%d'", command);
+		BUG("invalid command '%d'", opts->action);
 	}
 
 	return ret;
@@ -617,7 +618,7 @@ static int run_am(struct rebase_options *opts)
 	strvec_push(&am.args, "am");
 	strvec_pushf(&am.env, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
 		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
-	if (opts->action && !strcmp("continue", opts->action)) {
+	if (opts->action == ACTION_CONTINUE) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 		if (opts->gpg_sign_opt)
@@ -628,7 +629,7 @@ static int run_am(struct rebase_options *opts)
 
 		return move_to_original_branch(opts);
 	}
-	if (opts->action && !strcmp("skip", opts->action)) {
+	if (opts->action == ACTION_SKIP) {
 		strvec_push(&am.args, "--skip");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 		status = run_command(&am);
@@ -637,7 +638,7 @@ static int run_am(struct rebase_options *opts)
 
 		return move_to_original_branch(opts);
 	}
-	if (opts->action && !strcmp("show-current-patch", opts->action)) {
+	if (opts->action == ACTION_SHOW_CURRENT_PATCH) {
 		strvec_push(&am.args, "--show-current-patch");
 		return run_command(&am);
 	}
@@ -730,7 +731,7 @@ static int run_am(struct rebase_options *opts)
 	return status;
 }
 
-static int run_specific_rebase(struct rebase_options *opts, enum action action)
+static int run_specific_rebase(struct rebase_options *opts)
 {
 	int status;
 
@@ -748,7 +749,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 			opts->gpg_sign_opt = tmp;
 		}
 
-		status = run_sequencer_rebase(opts, action);
+		status = run_sequencer_rebase(opts);
 	} else if (opts->type == REBASE_APPLY)
 		status = run_am(opts);
 	else
@@ -1025,7 +1026,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
-	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1074,18 +1074,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1174,7 +1174,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (is_directory(merge_dir())) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
-		if (!(action == ACTION_ABORT) && is_directory(buf.buf)) {
+		if (!(options.action == ACTION_ABORT) && is_directory(buf.buf)) {
 			die(_("`rebase --preserve-merges` (-p) is no longer supported.\n"
 			"Use `git rebase --abort` to terminate current rebase.\n"
 			"Or downgrade to v2.33, or earlier, to complete the rebase."));
@@ -1201,7 +1201,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
 			"which is no longer supported; use 'merges' instead"));
 
-	if (action != ACTION_NONE && total_argc != 2) {
+	if (options.action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 	}
@@ -1232,11 +1232,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.root && options.fork_point > 0)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
 
-	if (action != ACTION_NONE && !in_progress)
+	if (options.action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
-	if (action == ACTION_EDIT_TODO && !is_merge(&options))
+	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
@@ -1246,16 +1246,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1281,7 +1280,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	case ACTION_SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-		options.action = "skip";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
@@ -1296,7 +1294,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 		struct strbuf head_msg = STRBUF_INIT;
 
-		options.action = "abort";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
@@ -1336,17 +1333,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1370,7 +1365,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
-	    (action != ACTION_NONE) ||
+	    (options.action != ACTION_NONE) ||
 	    (exec.nr > 0) ||
 	    options.autosquash) {
 		allow_preemptive_ff = 0;
@@ -1812,7 +1807,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.revisions = revisions.buf;
 
 run_rebase:
-	ret = run_specific_rebase(&options, action);
+	ret = run_specific_rebase(&options);
 
 cleanup:
 	strbuf_release(&buf);
-- 
gitgitgadget
