Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26CC41F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbeGXRlr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35272 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388362AbeGXRlr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so4791470wrt.2
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZ3yeEqHoSjxs/HedBbcWUUdqFgpLWAy1S1/pipEy40=;
        b=u47W74QY+6fVIxw4oIaS2jJD+8B5o14SW9/YjiY/FzDTk4xDUjHHtpV+et7o2jfSBh
         KImVThxkuVu36wJ2M5XBQ+w3Me5AsmMLrps7HlCJWEl4AMHAUYA9vNcPlfMPEeCZ6AR3
         QAlUWzFwrB3ZZL6/EnupAtnqOxS4fyFddNiCE+mSuoBmZ8xL0mYGgLW1kPcm14qIrSf8
         OxE7P5CWu+fxfC6M9psd0u7z4vhZK/veIfbQPUXHBPiKc8NZ6fobt9OQ0IU/gkwYwfjD
         Wrz4ZTqcO9kOP32LVFYhLYWXXAR4RnYDbgJE5pTpXXC1wuk13gLHc29LVJOiofAQ/wg0
         bjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZ3yeEqHoSjxs/HedBbcWUUdqFgpLWAy1S1/pipEy40=;
        b=bhsf1e5suoijuMIDEm1fNSYCUJfkKAwp7QzYiBrEXlD07rFBoQQqS1Mj2dJPqNOnHA
         AT4N2kmAM0LoeV6Q+aasf0EIVrL7tymIr6BmayJGuvALeC779Z+IRIx1gumhKKz8H/kv
         0QeGsCWUZ13g2JDniflcCTdSoS1bgSxEAeyEJJpt6mIrrUy3frE93gSz+t5gg22lfEBG
         xD3sKceuw2KDmUE4e/HEayGPxgdtBFZ3QoAYZ8cUtLuFpb30Rwx90MiFB0Z4/aMeMdJe
         lzoHvUFWmWhNZhRmFnQ5Oazh2ZYAXmdchSR/M2eK7ZW+JtgcVff5yAWkhRWDx+ZGIzCU
         WGMg==
X-Gm-Message-State: AOUpUlGxTLtysMUKrUJRJlfMRC/Dmu9ebcVmAMQjJGf9U9+UntPwQSUu
        9p9zDjES9B5KfcvT+BJdDGQXMaGH
X-Google-Smtp-Source: AAOMgpee/UGp5UqTUu2K7NS5daLb/Eo3m/u7KqxCdeCh0S13v/fzg6doKGyaA2fBURbvhZJ8dD4gtQ==
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr12002055wrj.166.1532450067853;
        Tue, 24 Jul 2018 09:34:27 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:26 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 11/20] rebase -i: rewrite complete_action() in C
Date:   Tue, 24 Jul 2018 18:32:12 +0200
Message-Id: <20180724163221.15201-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites complete_action() from shell to C.

A new mode is added to rebase--helper (`--complete-action`), as well as
a new flag (`--autosquash`).

Finally, complete_action() is stripped from git-rebase--interactive.sh.

The original complete_action() would return the code 2 when the todo
list contained no actions.  This was a special case for rebase -i and
-p; git-rebase.sh would then apply the autostash, delete the state
directory, and die with the message "Nothing to do".  This cleanup is
rewritten in C instead of returning 2.  As rebase -i no longer returns
2, the comment describing this behaviour in git-rebase.sh is updated to
reflect this change.

The first check might seem useless as we write "noop" to the todo list
if it is empty.  Actually, the todo list might contain commented
commands (ie. empty commits).  In this case, complete_action() won’t
write "noop", and will abort without starting the editor.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 12 ++++-
 git-rebase--interactive.sh | 53 ++------------------
 git-rebase.sh              |  2 +-
 sequencer.c                | 99 ++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  4 ++
 5 files changed, 118 insertions(+), 52 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index bed3dd2b95..d7fa5a5062 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,13 +13,13 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
 		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
-		CHECKOUT_ONTO
+		CHECKOUT_ONTO, COMPLETE_ACTION
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -29,6 +29,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits thas begin with squash!/fixup!")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
@@ -57,6 +59,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "checkout-onto", &command,
 			    N_("checkout a commit"), CHECKOUT_ONTO),
+		OPT_CMDMODE(0, "complete-action", &command,
+			    N_("complete the action"), COMPLETE_ACTION),
 		OPT_END()
 	};
 
@@ -110,5 +114,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	if (command == CHECKOUT_ONTO && argc == 4)
 		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
+	if (command == COMPLETE_ACTION && argc == 6)
+		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
+					 argv[4], argv[5], autosquash);
+
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b68f108f28..59dc4888a6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -127,54 +127,6 @@ init_revisions_and_shortrevisions () {
 	fi
 }
 
-complete_action() {
-	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
-
-	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-	todocount=${todocount##* }
-
-cat >>"$todo" <<EOF
-
-$comment_char $(eval_ngettext \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
-	"$todocount")
-EOF
-	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
-
-	has_action "$todo" ||
-		return 2
-
-	cp "$todo" "$todo".backup
-	collapse_todo_ids
-	git_sequence_editor "$todo" ||
-		die_abort "$(gettext "Could not execute editor")"
-
-	has_action "$todo" ||
-		return 2
-
-	git rebase--helper --check-todo-list || {
-		ret=$?
-		git rebase--helper --checkout-onto "$onto_name" "$onto" \
-		    "$orig_head" ${verbose:+--verbose}
-		exit $ret
-	}
-
-	expand_todo_ids
-
-	test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
-	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
-	    ${verbose:+--verbose}
-	require_clean_work_tree "rebase"
-	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-	     --continue
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -193,5 +145,8 @@ git_rebase__interactive () {
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
-	complete_action
+	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
+		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
+		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
+		${verbose:+--verbose} ${force_rebase:+--no-ff}
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index f3b10c7f62..86da3816be 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -219,7 +219,7 @@ run_specific_rebase () {
 	if test $ret -eq 0
 	then
 		finish_rebase
-	elif test $ret -eq 2 # special exit status for rebase -i
+	elif test $ret -eq 2 # special exit status for rebase -p
 	then
 		apply_autostash &&
 		rm -rf "$state_dir" &&
diff --git a/sequencer.c b/sequencer.c
index 238c534049..28082fe13e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -30,6 +30,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "rebase-interactive.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -53,6 +54,9 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * file and written to the tail of 'done'.
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+static GIT_PATH_FUNC(rebase_path_todo_backup,
+		     "rebase-merge/git-rebase-todo.backup")
+
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4495,6 +4499,101 @@ int skip_unnecessary_picks(struct object_id *output_oid)
 	return 0;
 }
 
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash)
+{
+	const char *shortonto, *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct strbuf *buf = &(todo_list.buf);
+	struct object_id oid;
+	struct stat st;
+
+	get_oid(onto, &oid);
+	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
+
+	if (!lstat(todo_file, &st) && st.st_size == 0 &&
+	    write_message("noop\n", 5, todo_file, 0))
+		return error_errno(_("could not write '%s'"), todo_file);
+
+	if (autosquash && rearrange_squash())
+		return 1;
+
+	if (cmd && *cmd)
+		sequencer_add_exec_commands(cmd);
+
+	if (strbuf_read_file(buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (parse_insn_buffer(buf->buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	if (count_commands(&todo_list) == 0) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		fputs("Nothing to do\n", stderr);
+		return 1;
+	}
+
+	strbuf_addch(buf, '\n');
+	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
+				      "Rebase %s onto %s (%d commands)",
+				      count_commands(&todo_list)),
+			      shortrevisions, shortonto, count_commands(&todo_list));
+	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
+
+	if (write_message(buf->buf, buf->len, todo_file, 0)) {
+		todo_list_release(&todo_list);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	copy_file(rebase_path_todo_backup(), todo_file, 0666);
+	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+
+	strbuf_reset(buf);
+
+	if (launch_sequence_editor(todo_file, buf, NULL)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return error(_("could not execute editor"));
+	}
+
+	strbuf_stripspace(buf, 1);
+	if (buf->len == 0) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		fputs("Nothing to do\n", stderr);
+		return 1;
+	}
+
+	todo_list_release(&todo_list);
+
+	if (check_todo_list()) {
+		checkout_onto(opts, onto_name, onto, orig_head);
+		return 1;
+	}
+
+	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	if (opts->allow_ff && skip_unnecessary_picks(&oid))
+		return error(_("could not skip unnecessary pick commands"));
+
+	checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head);
+	if (require_clean_work_tree("rebase", "", 1, 1))
+		return 1;
+
+	return sequencer_continue(opts);
+}
+
 struct subject2item_entry {
 	struct hashmap_entry entry;
 	int i;
diff --git a/sequencer.h b/sequencer.h
index f11dabfd65..3ab3791c8a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -89,6 +89,10 @@ int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(struct object_id *output_oid);
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

