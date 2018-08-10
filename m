Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682EF1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeHJTXE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42703 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so8843918wrs.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fa6h/emJpob802uLiROCq7ZGYNnp5rMBI+SkNA1V6rU=;
        b=OBHt/K+YrH/HpcHJspMl3RfDegHG0HGTW3zxACFHgkqqDIx33kpsyrUAW15wS/Elfo
         +GZs6TaVlc29KeFfIXiv4l5VRMLDeJxnZM2F8Unu7S/45Kdp4dK8QOlhg5CF8xXaPw6k
         aWvydmPxMWSn7LmnCFwAajdnbGk6Yw+pGTTGKk94J/lKb7kKTiSJvHFX6fSkf+8PC+qm
         Mcnk+2UBGV+OhrgU8azx9vV8A39sgGXGgFZaSJfR318kM1zepK78YqmbRr+XN3qf9Ujf
         iX3UEFy/c3EBNFdG5JG51XtZ3i7k/pX3sWBjkC9UJmiX8YsMK8LI0O8pOqbQ3/IjH7hx
         0yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fa6h/emJpob802uLiROCq7ZGYNnp5rMBI+SkNA1V6rU=;
        b=JN0qMTRID2ho0yxOo8zpQk6UlIdxvUfbf8YgQCTCxNrEL9LpOVFJbzFTIRPLvO+hCg
         TYcG9VfyUM1KXQwHgf3SpPmx5P4kSo3ioZrX7rAQPJti5tuIgf2lqCIdq4ZhcrHTelVD
         OWw4v1K+69uZ+zrB/Sh+p68TE3W8FU/7ZU0+ByzdBXYspRGWLXE1A8Z3jgkEuwfB9xqT
         4NT5onWJKobK6EYiYljtlct5L+617UaDD+KSBemEd5JrP0kPZmBYI1AJ1iqJh5wMdgkU
         lgg+djeKFyJz+NBg6sZkDkDySSpQfIpvkeQ43uqrF2vlivLVdRofh9JdgqNrX2dPQfE2
         UO8A==
X-Gm-Message-State: AOUpUlGBhHn4FaXn2IbeHz33I0tL2VTF4sgVITLn4X0Swe2RVCC50etZ
        p9qaidjIHGrM0LfjJ72cUvuBuBF+
X-Google-Smtp-Source: AA+uWPyi14zKxGCWa7gvhnMutyia2q2PY03JdUCT9ZF37c4vZfCUW3jSJMmNBDr3GSGUSJGwSb+e1g==
X-Received: by 2002:a5d:574d:: with SMTP id q13-v6mr4574329wrw.24.1533919943891;
        Fri, 10 Aug 2018 09:52:23 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:22 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 06/20] rebase -i: rewrite setup_reflog_action() in C
Date:   Fri, 10 Aug 2018 18:51:33 +0200
Message-Id: <20180810165147.4779-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites (the misnamed) setup_reflog_action() from shell to C. The
new version is called prepare_branch_to_be_rebased().

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
No changes since v5.

 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 30 ++++++++++++++++++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 731a64971d..0e76dadba6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -18,7 +18,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,6 +28,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -51,6 +52,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "prepare-branch", &command,
+			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_END()
 	};
 
@@ -94,5 +97,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == PREPARE_BRANCH && argc == 2)
+		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f4..77e972bb6c 100644
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
+	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index eaa1aa7deb..c1cfa2ee5c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3141,6 +3141,36 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int run_git_checkout(struct replay_opts *opts, const char *commit,
+			    const char *action)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	argv_array_push(&cmd.args, "checkout");
+	argv_array_push(&cmd.args, commit);
+	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+
+	if (opts->verbose)
+		return run_command(&cmd);
+	else
+		return run_command_silent_on_success(&cmd);
+}
+
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (run_git_checkout(opts, commit, action))
+			return error(_("could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 792e448b67..f619b02a13 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -109,6 +109,8 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.18.0

