Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150981F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeHJTXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52675 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeHJTXO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so2576088wmh.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hEyCgugmINtLGs0o+liLfpeUEp67+DRDK8qe4cNhryw=;
        b=OpekxLu2GB/T0Kzcfe7AaVgUDR9gkl54mUYVt03LwGznnNcMQZ0ayHLhoO26112nub
         pc1BKXDJn5cKvxFrFShlNcyddfpjGujljOexH+EzxIP8DpPTx8VyfmjYJ0lrwJVT1vPa
         JZ3/6tgH/8GeiRzbiJsDQsNwOFCvBcQG/w/z1EpGAYyrYHrdO1rZXGOBFHHwiffxvS9S
         bXAim92Hhc7dqj1VvrqitvDbjsAozdnj5Leq2PpAffWvdJF/2w9zhVZ63/L+Z37/1l0o
         MDInXilNOvXaKVFxqil3cvHING9loa+dQC3Loer179fRizZC4RoJFDygMGYxWD0gF9pu
         dMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hEyCgugmINtLGs0o+liLfpeUEp67+DRDK8qe4cNhryw=;
        b=ojWn7H2UuxvhqHj3NhVJQ97MTsRjXzkdaMvrKI8Pp2O5Y6AXzI3PJ0yMRuVHuviDIK
         gmCtrFS0LDSCHOlOFkC9xkkWXBe/mwlPWbNTe4sVjcg7cbXM+So8qdUZt/62O29XzSvR
         FJ82+CtjMBYnOwY72Pe9y/Hgn0Y4+7mtXKM0cieVqwivtkK3iSkA91PZ9KkuJum3ww6h
         TTwi6LK5GLz20WP+WMXWuzftWIDr7yz/jH2D2pjhELaqkE6tkFopEB/HNCzfwm3y48mg
         lNf/k/+f8IBsJB2mhp4SRuKHoeEka702N7NwUkCii0yEUM7Hllxv3m0xReZIQLKngaxp
         IqGQ==
X-Gm-Message-State: AOUpUlFoXAqDxdckp2I9CBL4e09tJ/lF5cXeBeGNHX4UkbJEXMrahq+p
        UVNh56VteJJhsOGNeSXmbwtAmcVM
X-Google-Smtp-Source: AA+uWPx9Exmxk1mYH7M19WkLpKP3mGIiZCvwmEhmHRAgR3qzBq141GVYFAapSSUlVC73We8lQU5mmw==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr1892345wmg.155.1533919953986;
        Fri, 10 Aug 2018 09:52:33 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 12/20] rebase -i: remove unused modes and functions
Date:   Fri, 10 Aug 2018 18:51:39 +0200
Message-Id: <20180810165147.4779-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the modes `--skip-unnecessary-picks`, `--append-todo-help`,
and `--checkout-onto` from rebase--helper.c, the functions of
git-rebase--interactive.sh that were rendered useless by the rewrite of
complete_action(), and append_todo_help_to_file() from
rebase-interactive.c.

skip_unnecessary_picks() and checkout_onto() becomes static, as they are
only used inside of the sequencer.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v5.

 builtin/rebase--helper.c   | 23 ++----------------
 git-rebase--interactive.sh | 50 --------------------------------------
 rebase-interactive.c       | 22 -----------------
 rebase-interactive.h       |  1 -
 sequencer.c                |  8 +++---
 sequencer.h                |  4 ---
 6 files changed, 6 insertions(+), 102 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 01b3333958..e1460136f5 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -17,9 +17,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
-		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
-		CHECKOUT_ONTO, COMPLETE_ACTION
+		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
+		COMPLETE_ACTION
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -44,21 +43,15 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("expand commit ids in the todo list"), EXPAND_OIDS),
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
@@ -94,26 +87,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
-		struct object_id oid;
-		int ret = skip_unnecessary_picks(&oid);
-
-		if (!ret)
-			puts(oid_to_hex(&oid));
-		return !!ret;
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
 					 argv[4], argv[5], autosquash);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 59dc4888a6..0d66c0f8b8 100644
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
index 4a9a10eff4..0f4119cbae 100644
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
-		return -1;
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
index d33f3176b7..971da03776 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -3,7 +3,6 @@
 
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf);
-int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty);
 int edit_todo_list(unsigned flags);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index ae1f44de2f..3800439c10 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3175,9 +3175,9 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
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
@@ -4424,7 +4424,7 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(struct object_id *output_oid)
+static int skip_unnecessary_picks(struct object_id *output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
diff --git a/sequencer.h b/sequencer.h
index d58766c6d7..02e3d7940e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -91,7 +91,6 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(struct object_id *output_oid);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
@@ -114,9 +113,6 @@ void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
-int checkout_onto(struct replay_opts *opts,
-		  const char *onto_name, const char *onto,
-		  const char *orig_head);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.18.0

