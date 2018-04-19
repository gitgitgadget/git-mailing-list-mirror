Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F11B1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeDSMVA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:21:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:54367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeDSMU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:20:59 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGRhs-1fDaWx03sG-00DHgt; Thu, 19
 Apr 2018 14:20:51 +0200
Date:   Thu, 19 Apr 2018 14:20:35 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 06/17] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <77c08b61387057af1be57c2b50769651cc8ec898.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oidzsO3m9AywvDDalyW2TvFWzEVFhtpa/6HUZA8fPM91b/2VKaQ
 0A1k61hJuB4Z0PF48QtSsplutwkxI64pJc7MqdcRk75/p8M2ffwvgi32ZGJkOXalqOXhn5G
 WbBUWOodvR3CwWgwxj7V9rM5eeZWvZowGJ9vqqMb5jsIOGFgpe+ytrZBbVWcxtaRdsBzPvi
 lNMxuxCU6D//PKaaBcyog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f17HLdWqCls=:ndFTSepNfALjSTgo4XPswe
 Mco+kKH14jSrg7ImcV4eEFAn6XWmttC91Rrwk6xdlLQV6/gPYzWkUkHooQqcYE1RXpd3itryc
 k3pfkGzi/JIMI8CnpfpnVOC4VO6g2ARm/MVupMfS0NglY3JLx+s8niDVepZM5dvcxOmWEGNSU
 vhITqSym0UFTgRC0R8V/b9NkAf6LL84VBT9iIySrbkIEp38YBBSOghz3M3Pzjt1ogO4VsCIfE
 xs0E0s9emZwa6LTGA/bvPRHG5V0LubCes2YKYN/hzBHVJulm5z4VsC2loF6sJe9KnBdfYIGqh
 O7ROxxODpEWXUQgUo/J3qNJwnOVMJJKvCsNUIjhc7YhpZOI365pjfTldApnuT6pwWc2pvtqKu
 wmubsAZP3PggVVNPqR5Ds8KzQTxpciVXWZlQaKSUoO+ZdTOkTqVaTQIoqhRou5dKMrQTrxFl3
 ASa9rhoj5Was2/KqSaze2G6YGMaa3KI8MxfmTbk61KL8IefExn1cVp8CcyZVOpl29fsj9MJ/t
 U+lCU575IXhvPCnirUlQJHKAC4JWe9oZ5CFAT+gdEluQxc/jPRC/QzHOARKHRaSowbzZUM9do
 R6IDuXuE8DB2Cd4Y4BWAZgDMuF/q3E54TK1A0hki0c2I3zZzr4O6xZFd+XdI75WsHB5lqmV1l
 wEJkc1Ez+ildK6xmo2Golo63l2FPpZrovWMmrq1fyA/pqme+Ztaoi575rJ53mXOQquBBQo7P2
 NtuM2831nRxkCisrVT2DIvxQx5YzevydbTq1FDLn48slJRscll3F1xmQ5O2M7lt+AQNG8i5RO
 clU+UNs5wg/BXFZLYXUv9L9O72CIvfhsmWkVPg+tYtWbQmWQLk=
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
immediately. Note that this needs a little change in the original code to
perform a reschedule: there is no commit from which to generate a patch
here (and we will simply fall through to the regular `return res`). We
keep that code path, though, because we will use it for the upcoming
`merge` command, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   2 +
 sequencer.c                | 201 +++++++++++++++++++++++++++++++++++--
 2 files changed, 196 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e1b865f43f2..e8d3a7d7588 100644
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
index 01443e0f245..9e09026b594 100644
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
@@ -244,18 +253,33 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 
 int sequencer_remove_state(struct replay_opts *opts)
 {
-	struct strbuf dir = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	int i;
 
+	if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
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
@@ -1279,6 +1303,8 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_LABEL,
+	TODO_RESET,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -1297,6 +1323,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 'l', "label" },
+	{ 't', "reset" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1802,7 +1830,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));
 
-	if (item->command == TODO_EXEC) {
+	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
+	    item->command == TODO_RESET) {
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
@@ -2465,6 +2494,158 @@ static int do_exec(const char *command_line)
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
@@ -2610,7 +2791,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_pick_commit(item->command, item->commit,
 					opts, is_final_fixup(todo_list));
 			if (is_rebase_i(opts) && res < 0) {
-				/* Reschedule */
+reschedule:
 				advise(_(rescheduled_advice),
 				       get_item_line_length(todo_list,
 							    todo_list->current),
@@ -2639,7 +2820,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					intend_to_amend();
 				return error_failed_squash(item->commit, opts,
 					item->arg_len, item->arg);
-			} else if (res && is_rebase_i(opts))
+			} else if (res && is_rebase_i(opts) && item->commit)
 				return res | error_with_patch(item->commit,
 					item->arg, item->arg_len, opts, res,
 					item->command == TODO_REWORD);
@@ -2665,6 +2846,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				/* `current` will be incremented below */
 				todo_list->current = -1;
 			}
+		} else if (item->command == TODO_LABEL) {
+			if ((res = do_label(item->arg, item->arg_len)))
+				goto reschedule;
+		} else if (item->command == TODO_RESET) {
+			if ((res = do_reset(item->arg, item->arg_len, opts)))
+				goto reschedule;
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
-- 
2.17.0.windows.1.4.g7e4058d72e3


