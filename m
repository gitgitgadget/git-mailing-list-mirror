Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2601F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeGJMRi (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933342AbeGJMRb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so14374974wrn.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0IL7+zTYDBziFzTGCpTr/m53pc+zT/3AFEWpDkOEXN8=;
        b=JG1sbmbEtJ1B9Zdap3WiTWmueoLyg94EIjWPxOqhp8XGbI4ui8LJ4T3v5QwxmqIgNI
         Ku84oMvedJNOFpEUuIP/P/E510EcAJLxFz2BmLIOkzQ2J0lbTlwwh94fm6JYdkCu6xpH
         zVdGG9fOsZ1V52V+VSp+WE/BxQq+qHksWW4TyHF7sQXUig9VhCm1GgOMlGL76iiI4TV6
         8wpeVnejeBJKCMgEgpKhes8YsjLOpu+ySvOKg3K0t3O/eR304BARhgypD4VrZH2/ifh7
         +C3Pw3ccfmOHOtUZHr4IFJ6cXkTJKsipX/qf6+h/jFhSICarpOCoVXSL88YqINaWn0F3
         TEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0IL7+zTYDBziFzTGCpTr/m53pc+zT/3AFEWpDkOEXN8=;
        b=i5GjM1f9R1TK5UHowFEYfnIRuCbt4QGBSQhgg9ORN+kUCD6g5nGy0lZWdDtYvFwREi
         fVyh3hmqcEHeaTt5PdyClnWutX2+T9v6iLDPCDtWNE5rw4AHoYhsY2rZjw3180JHidlR
         +HAjnIraxUp0Sc38+ET5A2s4eeF4aKPR4XcjDsWDR7+oKsTMAKmdfJB/6MJH/WvpKJ3/
         vPv4y62saAo7orQLfqRqj5IPDM+3mKqHETWvHqrjkLdJVPPDBcCydO6w56sKajZ+EFmv
         J3krar5yIrEeNUbBbt+MCeoyO4ANHUaDRL8NSCZJrbKM/CDMB/a8osqKPzo79HqKbg/Q
         0Q9Q==
X-Gm-Message-State: APt69E3yZqDVg7Zr6HVTWttvOwlFmn0fwnY2N8J0/7BK1LXNlC7gbNJ2
        QR9ERsfRjVJFJXrDS6ogwyiSgsY4
X-Google-Smtp-Source: AAOMgpeR3/C0akcLB9auPYKwabsGk43yjdENDoX9VxhycQETgaZvKM2pyoxvn1utxXL+d/mS/KZPYw==
X-Received: by 2002:adf:b90a:: with SMTP id k10-v6mr18157370wrf.169.1531225049574;
        Tue, 10 Jul 2018 05:17:29 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:28 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 11/13] rebase--interactive: remove unused modes and functions
Date:   Tue, 10 Jul 2018 14:15:55 +0200
Message-Id: <20180710121557.6698-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the modes `--skip-unnecessary-picks`, `--append-todo-help`,
`--checkout-onto`, `--shorten-ids` and `--expand-ids` from
rebase--helper.c, the functions of git-rebase--interactive.sh that were
rendered useless by the rewrite of complete_action(), and
append_todo_help_to_file() from rebase-interactive.c.

skip_unnecessary_picks() and checkout_onto() becomes static, as they are
only used inside of the sequencer.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 32 +++---------------------
 git-rebase--interactive.sh | 50 --------------------------------------
 rebase-interactive.c       | 22 -----------------
 rebase-interactive.h       |  1 -
 sequencer.c                |  8 +++---
 sequencer.h                |  4 ---
 6 files changed, 7 insertions(+), 110 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index bb3698dba..8ab808da4 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -15,13 +15,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0,
 		autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1, ret;
-	const char *oid = NULL;
+	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
-		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
-		CHECKOUT_ONTO, COMPLETE_ACTION
+		CONTINUE = 1, ABORT, MAKE_SCRIPT, CHECK_TODO_LIST, REARRANGE_SQUASH,
+		ADD_EXEC, EDIT_TODO, PREPARE_BRANCH, COMPLETE_ACTION
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -40,27 +37,17 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 				ABORT),
 		OPT_CMDMODE(0, "make-script", &command,
 			N_("make rebase script"), MAKE_SCRIPT),
-		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
-		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand commit ids in the todo list"), EXPAND_OIDS),
 		OPT_CMDMODE(0, "check-todo-list", &command,
 			N_("check the todo list"), CHECK_TODO_LIST),
-		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
-			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
 		OPT_CMDMODE(0, "rearrange-squash", &command,
 			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
 			N_("insert exec commands in todo list"), ADD_EXEC),
-		OPT_CMDMODE(0, "append-todo-help", &command,
-			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "prepare-branch", &command,
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
-		OPT_CMDMODE(0, "checkout-onto", &command,
-			    N_("checkout a commit"), CHECKOUT_ONTO),
 		OPT_CMDMODE(0, "complete-action", &command,
 			    N_("complete the action"), COMPLETE_ACTION),
 		OPT_END()
@@ -81,7 +68,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
-	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (rebase_cousins >= 0 && !rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
@@ -93,28 +79,16 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
 		return !!sequencer_make_script(stdout, argc, argv, flags);
-	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
-		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
-		ret = !!skip_unnecessary_picks(&oid);
-		if (!ret && oid)
-			puts(oid);
-		return ret;
-	}
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
-	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help_to_file(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
-	if (command == CHECKOUT_ONTO && argc == 4)
-		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
 	if (command == COMPLETE_ACTION && argc == 6)
 		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
 					 argv[4], argv[5], autosquash, keep_empty);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 59dc4888a..0d66c0f8b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -16,56 +16,6 @@ todo="$state_dir"/git-rebase-todo
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
-comment_char=$(git config --get core.commentchar 2>/dev/null)
-case "$comment_char" in
-'' | auto)
-	comment_char="#"
-	;;
-?)
-	;;
-*)
-	comment_char=$(echo "$comment_char" | cut -c1)
-	;;
-esac
-
-die_abort () {
-	apply_autostash
-	rm -rf "$state_dir"
-	die "$1"
-}
-
-has_action () {
-	test -n "$(git stripspace --strip-comments <"$1")"
-}
-
-git_sequence_editor () {
-	if test -z "$GIT_SEQUENCE_EDITOR"
-	then
-		GIT_SEQUENCE_EDITOR="$(git config sequence.editor)"
-		if [ -z "$GIT_SEQUENCE_EDITOR" ]
-		then
-			GIT_SEQUENCE_EDITOR="$(git var GIT_EDITOR)" || return $?
-		fi
-	fi
-
-	eval "$GIT_SEQUENCE_EDITOR" '"$@"'
-}
-
-expand_todo_ids() {
-	git rebase--helper --expand-ids
-}
-
-collapse_todo_ids() {
-	git rebase--helper --shorten-ids
-}
-
-get_missing_commit_check_level () {
-	check_level=$(git config --get rebase.missingCommitsCheck)
-	check_level=${check_level:-ignore}
-	# Don't be case sensitive
-	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
-}
-
 # Initiate an action. If the cannot be any
 # further action it  may exec a command
 # or exit and not return.
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d8b946559..f99e596d2 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -52,28 +52,6 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 	}
 }
 
-int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty)
-{
-	struct strbuf buf = STRBUF_INIT;
-	FILE *todo;
-	int ret;
-
-	todo = fopen_or_warn(rebase_path_todo(), "a");
-	if (!todo)
-		return 1;
-
-	append_todo_help(edit_todo, keep_empty, &buf);
-
-	ret = fputs(buf.buf, todo);
-	if (ret < 0)
-		error_errno(_("could not append help text to '%s'"), rebase_path_todo());
-
-	fclose(todo);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
 int edit_todo_list(unsigned flags)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/rebase-interactive.h b/rebase-interactive.h
index c0ba83be3..47025c47a 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -6,7 +6,6 @@
 
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf);
-int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty);
 int edit_todo_list(unsigned flags);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index da975285d..6ceada4a9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3166,9 +3166,9 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
 	return 0;
 }
 
-int checkout_onto(struct replay_opts *opts,
-		  const char *onto_name, const char *onto,
-		  const char *orig_head)
+static int checkout_onto(struct replay_opts *opts,
+			 const char *onto_name, const char *onto,
+			 const char *orig_head)
 {
 	struct object_id oid;
 	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
@@ -4396,7 +4396,7 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(const char **output_oid)
+static int skip_unnecessary_picks(const char **output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
diff --git a/sequencer.h b/sequencer.h
index 02772b927..b9f9e7827 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -88,7 +88,6 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(const char **output_oid);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
@@ -111,9 +110,6 @@ void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
-int checkout_onto(struct replay_opts *opts,
-		  const char *onto_name, const char *onto,
-		  const char *orig_head);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.18.0

