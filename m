Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D147F1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 13:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeFRNTQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 09:19:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42985 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFRNTP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 09:19:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so16820842wrk.9
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIrVWh1OSH37wG2vMJ8F8JJYgMLShv4r5KnBgPqypbM=;
        b=aESTe3axavgm6dQxMKJZ3YAfjk5XTCO40xjNp7deFNi9JL6/Z/sc6z0j18Q4Spa6Gu
         JIGXtNlB6V53gFDpFAnQN3J8NbiMWlFOiNN5rZcxtjvQSElAIHaZrI4swxG5iO+Z4rNU
         aFPMhsO1X8CW18GUaEpIvlAsrTYKz6mWsU5RKFyYCZHFiIkvPZtpeOY/OdoGS6g2u4sV
         1ULtDSSKR3KCUjQVo/WdmzZVhiuhWz1N9X5xqUe91VobmYMJqqEjZuOBFzLZR1nhMY0N
         EK2d3HUCCnF3XeQqv5nFG68A1aaCD+eFQlIsgO3K6vQJINQ2PBMdMhDmRo+bYQCo5jnM
         R+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIrVWh1OSH37wG2vMJ8F8JJYgMLShv4r5KnBgPqypbM=;
        b=mgB9MNx6GAfhbkejBb7wKZM+QujlUgFjMLmeVVWIrdsrwiurTkd8khmJ4hxjYgXxzz
         mj8OM7IujCQct+MnlwckAhqXytiPbX5HFQkqaW8rN7s+VRI6HtsYdjOrtn2yzH2P84H7
         Nf9Fm1jKDlqZv4nnSms4iFk1OyPUVlEWobMUQOVL1B87fIhW5s2iMh9sFyAYauh9bNO1
         ThgWe0i60I7uvZE8YWCJp1h++2nkGaJsoPmvTIyKD7115UNBTOsqo3AgFPtoJpxh7uEl
         LZFM66XeYA34KsLGnsS7Z13vZkpihKV6/aL6YD99a6ImajL/avuhC5MJvMGb8HRWHq9m
         zwJA==
X-Gm-Message-State: APt69E3/RuM7E9/vjjlXLCu4YTWl5MosEK1FZHS40feBykborcLnI9Ah
        YQ9NYIZaA10HMULX6xA8eTD9U8Sq
X-Google-Smtp-Source: ADUXVKKHR5yw+LBHlGdMh2enXuDs96GMiOhJ1FcNiWh57v4Y0EWFHIJlioDzh45hdPh3oSiNCdJNIA==
X-Received: by 2002:adf:f344:: with SMTP id e4-v6mr10274894wrp.161.1529327953802;
        Mon, 18 Jun 2018 06:19:13 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id c10-v6sm14230575wrs.6.2018.06.18.06.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 06:19:12 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 2/3] rebase -i: rewrite setup_reflog_action() in C
Date:   Mon, 18 Jun 2018 15:18:43 +0200
Message-Id: <20180618131844.13408-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180618131844.13408-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites setup_reflog_action() from shell to C.

A new command is added to rebase--helper.c, “setup-reflog”, as such as a
new flag, “verbose”, to silence the output of the checkout operation
called by setup_reflog_action().

The shell version is then stripped in favour of a call to the helper. As
$GIT_REFLOG_ACTION is not longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  9 +++++++--
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 31 +++++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index d2990b210..d677fb663 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "verbose", &verbose, N_("verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +51,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "setup-reflog", &command,
+			    N_("setup the reflog action"), SETUP_REFLOG),
 		OPT_END()
 	};
 
@@ -93,5 +96,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == SETUP_REFLOG && argc == 2)
+		return !!setup_reflog_action(&opts, argv[1], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f..048bbf041 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -72,6 +72,7 @@ collapse_todo_ids() {
 
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
+	comment_for_reflog start
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
 	git update-ref ORIG_HEAD $orig_head
@@ -119,19 +120,6 @@ initiate_action () {
 	esac
 }
 
-setup_reflog_action () {
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
-	fi
-}
-
 init_basic_state () {
 	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
@@ -211,7 +199,7 @@ git_rebase__interactive () {
 		return 0
 	fi
 
-	setup_reflog_action
+	git rebase--helper --setup-reflog "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index 3437673d2..4bfe29c7b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3131,6 +3131,37 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int checkout_base_commit(struct replay_opts *opts, const char *commit,
+				int verbose, const char *action)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	argv_array_push(&cmd.args, "checkout");
+	argv_array_push(&cmd.args, commit);
+	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+
+	if (verbose)
+		return run_command(&cmd);
+	else
+		return run_command_silent_on_success(&cmd);
+}
+
+int setup_reflog_action(struct replay_opts *opts, const char *commit,
+			int verbose)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (checkout_base_commit(opts, commit, verbose, action))
+			die(_("Could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 35730b13e..55e4057d8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -100,6 +100,9 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int setup_reflog_action(struct replay_opts *opts, const char *commit,
+			int verbose);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.16.4

