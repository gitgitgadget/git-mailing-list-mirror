Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41DB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbeDYM3C (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:29:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:35351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753897AbeDYM3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:01 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MA9FV-1f4xtU3POD-00BLsU; Wed, 25 Apr 2018 14:28:54 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 06/17] sequencer: introduce new commands to reset the revision
Date:   Wed, 25 Apr 2018 14:28:47 +0200
Message-Id: <548acb39f06d2569893159076cecca1daa954eb1.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:2MvMQYrUW2a7fDqfXg25USn9p09JR9JV7XYfnlfk2Rn5VtqRpu3
 TD4GmVaLOeCS0mQc9BhU3rAW6uvUEPbSmAeneL08wvDHlvHtjQEy9WwAayKSLiOeoZTJljK
 XjzuyWqCckG5iitC4T7+FMpCLU80nwC+K+5OO7H1z1CVE9vf0h0C/DGXLPNqiMigWcdvRQm
 y9sdgaUZOUfUGNbemMdsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YwyVA6r18Co=:nBBTcssQn4XCbEVXCKBg4i
 KJOmu28ZMpwmA3MjNigiLkINlWUaIH5whg8JA7l264aFYIvQRdcL3T/3t7UXfLuVmoK3ESLWm
 W0nmcfi6HqvHPs3ZSTZi4tGyGxaaQbj6B876Sb1OOjCAfoitWJKJF9l4Cv0febcmfU6+1gkXG
 I9zoCoHFG4TmSUg/bp7qMbepZCHj/OyDw7tguArzef+T4mHwxyscK2/M1u0bCeShJAgwH5Xlm
 4Rtiet7qYUPu3xd6DQ62nYJDw7qJnW+vh/7vsC1SGoc/u6U/YxtQd1/yluH7IQhlBvUFkKP1U
 0ZeTo66Aud3G0Q6Z8PxpG5ZlycjgDze6vAO1ySVFroOF1PgcXJ4wvMl/T/2c7VNN6hPEIEzA4
 XUP5MCTQxyF5q764Cqr41kVqNs9+2vDQYS5ysphn05Fn+KalBdMFEyr8oEHLVNd0wWgJxZXDh
 cJOJNdN9bDf7yAajEiExCizSQeVU8rBUz96YKDbUVgvOhReYdFY8AQNT/MXlvxMXxN/ChSJDM
 tVi1FTkak2/yb97qzSfGy93oKrWIY433cvkZBfJ6WXxcrXU5ULsKTjk3hwVpgnTiQmXmcDg5y
 SNVQ8AhipwsaNo98KdWhkFcyQgamLHIgZtWAKPP2uikksf9IosJMVycJODd4VbCBcxP8aCeEr
 7DvFKD+ToOS5kKM4xqJSOg1wEA3cAkVtT4Alsgo0r+ctrS4zMkuSE830XVuhWhM8ZJRWirPm6
 IQ/MaTeidcv4o272zump8Y12/kVEpMOmtXdxV67zwTZOOe1at6iPccIGd35QAX1mqd6Ht8HaM
 +9FUiBeOQpdLfCBla9jU95uSjL0wFe5hUgAo+Yq83a22fXczIm7VvCCaSACoENTPOdx6GWF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will teach the sequencer to rebase merges.
This will be done in a very different way from the unfortunate design of
`git rebase --preserve-merges` (which does not allow for reordering
commits, or changing the branch topology).

The main idea is to introduce new todo list commands, to support
labeling the current revision with a given name, resetting the current
revision to a previous state, and  merging labeled revisions.

This idea was developed in Git for Windows' Git garden shears (that are
used to maintain Git for Windows' "thicket of branches" on top of
upstream Git), and this patch is part of the effort to make it available
to a wider audience, as well as to make the entire process more robust
(by implementing it in a safe and portable language rather than a Unix
shell script).

This commit implements the commands to label, and to reset to, given
revisions. The syntax is:

	label <name>
	reset <name>

Internally, the `label <name>` command creates the ref
`refs/rewritten/<name>`. This makes it possible to work with the labeled
revisions interactively, or in a scripted fashion (e.g. via the todo
list command `exec`).

These temporary refs are removed upon sequencer_remove_state(), so that
even a `git rebase --abort` cleans them up.

We disallow '#' as label because that character will be used as separator
in the upcoming `merge` command.

Later in this patch series, we will mark the `refs/rewritten/` refs as
worktree-local, to allow for interactive rebases to be run in parallel in
worktrees linked to the same repository.

As typos happen, a failed `label` or `reset` command will be rescheduled
immediately. As the previous code to reschedule a command is embedded
deeply in the pick/fixup/squash code path, we simply duplicate the few
lines. This will allow us to extend the new code path easily for the
upcoming `merge` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   2 +
 sequencer.c                | 213 +++++++++++++++++++++++++++++++++++--
 2 files changed, 208 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a60df2ee5a0..d6e8958dae4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -162,6 +162,8 @@ s, squash <commit> = use commit, but meld into previous commit
 f, fixup <commit> = like \"squash\", but discard this commit's log message
 x, exec <commit> = run command (the rest of the line) using shell
 d, drop <commit> = remove commit
+l, label <label> = label current HEAD with a name
+t, reset <label> = reset HEAD to a label
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
diff --git a/sequencer.c b/sequencer.c
index f9c1ddb5385..c9655edffa5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,8 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "unpack-trees.h"
+#include "worktree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -120,6 +122,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
 static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 	"rebase-merge/rewritten-pending")
+
+/*
+ * The path of the file listing refs that need to be deleted after the rebase
+ * finishes. This is used by the `label` command to record the need for cleanup.
+ */
+static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
+
 /*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
@@ -245,18 +254,34 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 
 int sequencer_remove_state(struct replay_opts *opts)
 {
-	struct strbuf dir = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	int i;
 
+	if (is_rebase_i(opts) &&
+	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
+		char *p = buf.buf;
+		while (*p) {
+			char *eol = strchr(p, '\n');
+			if (eol)
+				*eol = '\0';
+			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0)
+				warning(_("could not delete '%s'"), p);
+			if (!eol)
+				break;
+			p = eol + 1;
+		}
+	}
+
 	free(opts->gpg_sign);
 	free(opts->strategy);
 	for (i = 0; i < opts->xopts_nr; i++)
 		free(opts->xopts[i]);
 	free(opts->xopts);
 
-	strbuf_addstr(&dir, get_dir(opts));
-	remove_dir_recursively(&dir, 0);
-	strbuf_release(&dir);
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, get_dir(opts));
+	remove_dir_recursively(&buf, 0);
+	strbuf_release(&buf);
 
 	return 0;
 }
@@ -1280,6 +1305,8 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_LABEL,
+	TODO_RESET,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -1298,6 +1325,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 'l', "label" },
+	{ 't', "reset" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1803,7 +1832,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));
 
-	if (item->command == TODO_EXEC) {
+	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
+	    item->command == TODO_RESET) {
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
@@ -2471,6 +2501,159 @@ static int do_exec(const char *command_line)
 	return status;
 }
 
+static int safe_append(const char *filename, const char *fmt, ...)
+{
+	va_list ap;
+	struct lock_file lock = LOCK_INIT;
+	int fd = hold_lock_file_for_update(&lock, filename,
+					   LOCK_REPORT_ON_ERROR);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (fd < 0)
+		return -1;
+
+	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT) {
+		error_errno(_("could not read '%s'"), filename);
+		rollback_lock_file(&lock);
+		return -1;
+	}
+	strbuf_complete(&buf, '\n');
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		error_errno(_("could not write to '%s'"), filename);
+		strbuf_release(&buf);
+		rollback_lock_file(&lock);
+		return -1;
+	}
+	if (commit_lock_file(&lock) < 0) {
+		strbuf_release(&buf);
+		rollback_lock_file(&lock);
+		return error(_("failed to finalize '%s'"), filename);
+	}
+
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int do_label(const char *name, int len)
+{
+	struct ref_store *refs = get_main_ref_store();
+	struct ref_transaction *transaction;
+	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
+	struct strbuf msg = STRBUF_INIT;
+	int ret = 0;
+	struct object_id head_oid;
+
+	if (len == 1 && *name == '#')
+		return error("Illegal label name: '%.*s'", len, name);
+
+	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
+	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
+
+	transaction = ref_store_transaction_begin(refs, &err);
+	if (!transaction) {
+		error("%s", err.buf);
+		ret = -1;
+	} else if (get_oid("HEAD", &head_oid)) {
+		error(_("could not read HEAD"));
+		ret = -1;
+	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
+					  NULL, 0, msg.buf, &err) < 0 ||
+		   ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		ret = -1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	strbuf_release(&msg);
+
+	if (!ret)
+		ret = safe_append(rebase_path_refs_to_delete(),
+				  "%s\n", ref_name.buf);
+	strbuf_release(&ref_name);
+
+	return ret;
+}
+
+static const char *reflog_message(struct replay_opts *opts,
+	const char *sub_action, const char *fmt, ...);
+
+static int do_reset(const char *name, int len, struct replay_opts *opts)
+{
+	struct strbuf ref_name = STRBUF_INIT;
+	struct object_id oid;
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc desc;
+	struct tree *tree;
+	struct unpack_trees_options unpack_tree_opts;
+	int ret = 0, i;
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	/* Determine the length of the label */
+	for (i = 0; i < len; i++)
+		if (isspace(name[i]))
+			len = i;
+
+	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
+	if (get_oid(ref_name.buf, &oid) &&
+	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
+		error(_("could not read '%s'"), ref_name.buf);
+		rollback_lock_file(&lock);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = &the_index;
+	unpack_tree_opts.dst_index = &the_index;
+	unpack_tree_opts.fn = oneway_merge;
+	unpack_tree_opts.merge = 1;
+	unpack_tree_opts.update = 1;
+
+	if (read_cache_unmerged()) {
+		rollback_lock_file(&lock);
+		strbuf_release(&ref_name);
+		return error_resolve_conflict(_(action_name(opts)));
+	}
+
+	if (!fill_tree_descriptor(&desc, &oid)) {
+		error(_("failed to find tree of %s"), oid_to_hex(&oid));
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	tree = parse_tree_indirect(&oid);
+	prime_cache_tree(&the_index, tree);
+
+	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
+		ret = error(_("could not write index"));
+	free((void *)desc.buffer);
+
+	if (!ret)
+		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
+						len, name), "HEAD", &oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+
+	strbuf_release(&ref_name);
+	return ret;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -2574,7 +2757,7 @@ N_("Could not execute the todo command\n"
 
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
-	int res = 0;
+	int res = 0, reschedule = 0;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
@@ -2645,7 +2828,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					intend_to_amend();
 				return error_failed_squash(item->commit, opts,
 					item->arg_len, item->arg);
-			} else if (res && is_rebase_i(opts))
+			} else if (res && is_rebase_i(opts) && item->commit)
 				return res | error_with_patch(item->commit,
 					item->arg, item->arg_len, opts, res,
 					item->command == TODO_REWORD);
@@ -2671,9 +2854,25 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				/* `current` will be incremented below */
 				todo_list->current = -1;
 			}
+		} else if (item->command == TODO_LABEL) {
+			if ((res = do_label(item->arg, item->arg_len)))
+				reschedule = 1;
+		} else if (item->command == TODO_RESET) {
+			if ((res = do_reset(item->arg, item->arg_len, opts)))
+				reschedule = 1;
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
+		if (reschedule) {
+			advise(_(rescheduled_advice),
+			       get_item_line_length(todo_list,
+						    todo_list->current),
+			       get_item_line(todo_list, todo_list->current));
+			todo_list->current--;
+			if (save_todo(todo_list, opts))
+				return -1;
+		}
+
 		todo_list->current++;
 		if (res)
 			return res;
-- 
2.17.0.windows.1.33.gfcbb1fa0445


