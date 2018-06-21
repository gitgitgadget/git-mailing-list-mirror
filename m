Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6703C1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeFUOa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:30:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37247 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933128AbeFUOaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:30:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so6533705wmg.2
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On2UMdlmSYXYAgFYf/5ej4eIV4lTOu8Ls2peht2UGOg=;
        b=oxkdI/lSg/YAINXplQcJEQeHKQYK4htgV4X5TMiCMOz7auoBzll8svtDvYqBDHSv2Q
         bA7ngPstzkt8NpkD+fomx0xHVvvXNPnvxBMb/NTlqTMYeSc/YHEMUMddYBYfBvXuJNRe
         BwUDTbsMEsU+b818Fahd307iCas0wEbMgQmnqM01amtQgPmtVc6nBDjsRcPWAk472Wyv
         V0uK/0xMitb4NF3/8pNWbsfYCiljCO3Q3lOQGnQAc9ljL8JsTJRZMXEZdXDkjq6mzt/r
         G41ZKCWeY/ld0O7T6r2Qe8dPP1tBAZ7YeCEcSDeU+3J6MD/CHwolgDBWAWeXFFEU1dgl
         wqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On2UMdlmSYXYAgFYf/5ej4eIV4lTOu8Ls2peht2UGOg=;
        b=bP74+ecrodTY8nn/CGQ75RRPFcRLzND8UEn3LMGDiS9jblt60agH25HjA/BRQ2kULe
         esh+RNeqUOZEoRKrzc+lePpSXHBmzXi51qfMQHer2iEe6PoPoEYbIIwBou+VN1EC6HcA
         3JTI6ubU+PHDS0aeLwitMx3RpE1yDJ5BmrIC0HnoobtFt6lVz3/CvKi0Ew/HqaXKVDIf
         zbCFt/Rch/m0Uy0H00DFKa+beA3ApgDZzd6M8DmXANHdkPVAT7D1TPvhpChUlPl/UMDr
         7c1UywiX2Zg8eT4nshtgDxWf0p4qrXfX1qL2LbuiKEqkJUAGgEOsJOcn8u7aKupm5oTU
         ectA==
X-Gm-Message-State: APt69E1zbuhK3+ZdE4bGhn8PBcfCG1fnpm+gYIth1ZEjolXK47JLs27m
        3hetWt2yfEwT7S2FGe7UavupR83H
X-Google-Smtp-Source: ADUXVKIcZq81RU7nai3Vc3HDX5AnO1Dx1dwBNOhWRwnTuXBWnHIWZ5TgqUsI1Xmw0YHHuptH5+4WwQ==
X-Received: by 2002:a1c:328a:: with SMTP id y132-v6mr5243890wmy.70.1529591454019;
        Thu, 21 Jun 2018 07:30:54 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm1333591wrj.73.2018.06.21.07.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:30:52 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in C
Date:   Thu, 21 Jun 2018 16:17:31 +0200
Message-Id: <20180621141732.19952-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621141732.19952-1-alban.gruin@gmail.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com>
 <20180621141732.19952-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites (the misnamed) setup_reflog_action() from shell to C. The
new version is called checkout_base_commit().

A new command is added to rebase--helper.c, “checkout-base”, as well as
a new flag, “verbose”, to avoid silencing the output of the checkout
operation called by checkout_base_commit().

The function `run_git_checkout()` will also be used in the next commit,
therefore its code is not part of `checkout_base_commit()`.

The shell version is then stripped in favour of a call to the helper.

As $GIT_REFLOG_ACTION is no longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  9 +++++++--
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 30 ++++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index d2990b210..fb5996a2c 100644
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
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +51,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "checkout-base", &command,
+			    N_("checkout the base commit"), CHECKOUT_BASE),
 		OPT_END()
 	};
 
@@ -93,5 +96,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == CHECKOUT_BASE && argc == 2)
+		return !!checkout_base_commit(&opts, argv[1], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f..af46cf9c2 100644
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
+	git rebase--helper --checkout-base "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index 51c8ab7ac..27f8453fe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3129,6 +3129,36 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int run_git_checkout(struct replay_opts *opts, const char *commit,
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
+	return run_command_silent_on_success(&cmd);
+}
+
+int checkout_base_commit(struct replay_opts *opts, const char *commit,
+			 int verbose)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (run_git_checkout(opts, commit, verbose, action))
+			return error(_("Could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 35730b13e..42c3dda81 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -100,6 +100,9 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int checkout_base_commit(struct replay_opts *opts, const char *commit,
+			 int verbose);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.17.1

