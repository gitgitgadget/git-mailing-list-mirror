Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF3E1FAE3
	for <e@80x24.org>; Mon, 29 Jan 2018 22:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeA2Wyx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:54:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:63580 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeA2Wyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:54:50 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MePYV-1eP3me0ITH-00QCF2; Mon, 29 Jan 2018 23:54:43 +0100
Date:   Mon, 29 Jan 2018 23:54:41 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 02/10] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DwX5dxoiUS0RYSulNgL/LJ3lwCD0S+wU5xZTwbGrUOIK4r24Fcq
 mgB8+TizBeL7rTzUoq0nl0TfRSb2spKCOjNxVIDhy20VLExoPPwuUWFeRXYDm3HWQAFR5i7
 V7Y/GxJ8SZ6qpADUPyDPAE40EZVoQaApoha/HnPqTdXtivoeqnPXU3ZgXE01vOJC3ILwrUo
 UgWouFv/XLx796b74awPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:opJk6Mi3y2k=:yzSwPhJg80CBRBm5DRqHlI
 7o9cu/UxqaKTut89Tl31qX2jfOPxsgcATkPwxON8Z0NW7v75kqOttmPA5e1UJo6wYznIDr7yh
 L71tNw6dwXUcnLBDdJExFro+bWTnr14IhopS5F9+Ix4vWEN4qocrnjcCmqIH6s5J0IcPqZfJJ
 kBYgWNtpNe9hkwBKhnx2tKPlPuMKwS7ymJNtFuLJv5hSiwejd9lCsIW0QnTBG1lwtyawChTT7
 /XUIvLmrvL+cJ5Q98CEus3qNSogQtGvlE+LyIyyqwhTx/zjvFYTnECUtoh3aA1NEP0Zd7PNLJ
 aCfKGdlOf37O24fJ/+MEVg+I2FW3OPmFagQGEXHWTgx9ahB9/ugK1E0tORRwMmi+5hbC+Cugr
 TMtY3edgiSZ33oZ58otFI1mXRcs3JXBcqbUOIGmzA15zIc69IHj6saajQmK76p3emdP9OJ0bl
 CD/2Nl2QSV54xXXgD2PLvZlld8euO9yuPt1HCOu0/oq/slcFwAId3UY/zAXw7sMYjH+Yi7yDs
 OpBiT+Ryuztk1Ndt+WdL+POYb08/v6Q50PoL3ArESNYS71qcd0/3PcBuGJwNjDDSBn+jTWYTD
 /XBOmNunz6wZM5Gkp878tfG44ncaLHzW8s0LgA550d9FYO7mQwZRsU6HLoVoardLM8K3TBeBL
 /BJyQFD6O83bPGTrIRo6a658bDbakzfZljB44FYo1iFf9su3Dnbl+jrWmR+qEzlIKWPdUCHxr
 SyV/QdPhbM9B31xmdq13OIOwll2Xu4guB533JDJQDyGbks2vL0X3IUV71wdxpR9eDz8pCKbVx
 jZedgXr5trQpWEsqWryIWMBs3yxMLSmYZr/KFXYBj3RJL5BVrcHFi1GMm30AVvAVKzC3JsS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will teach the sequencer to recreate merges.
This will be done in a very different way from the unfortunate design of
`git rebase --preserve-merges` (which does not allow for reordering
commits, or changing the branch topology).

The main idea is to introduce new todo list commands, to support
labeling the current revision with a given name, resetting the current
revision to a previous state, merging labeled revisions.

This idea was developed in Git for Windows' Git garden shears (that are
used to maintain the "thicket of branches" on top of upstream Git), and
this patch is part of the effort to make it available to a wider
audience, as well as to make the entire process more robust (by
implementing it in a safe and portable language rather than a Unix shell
script).

This commit implements the commands to label, and to reset to, given
revisions. The syntax is:

	label <name>
	reset <name>

Internally, the `label <name>` command creates the ref
`refs/rewritten/<name>`. This makes it possible to work with the labeled
revisions interactively, or in a scripted fashion (e.g. via the todo
list command `exec`).

Later in this patch series, we will mark the `refs/rewritten/` refs as
worktree-local, to allow for interactive rebases to be run in parallel in
worktrees linked to the same repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   2 +
 sequencer.c                | 180 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fcedece1860..7e5281e74aa 100644
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
index 4d3f60594cb..92ca8d2adee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,6 +21,8 @@
 #include "log-tree.h"
 #include "wt-status.h"
 #include "hashmap.h"
+#include "unpack-trees.h"
+#include "worktree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -116,6 +118,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
 static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 	"rebase-merge/rewritten-pending")
+
+/*
+ * The path of the file listing refs that need to be deleted after the rebase
+ * finishes. This is used by the `merge` command.
+ */
+static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
+
 /*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
@@ -767,6 +776,8 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_LABEL,
+	TODO_RESET,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -785,6 +796,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 'l', "label" },
+	{ 't', "reset" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1253,7 +1266,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
-		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
+		} else if ((bol + 1 == eol || bol[1] == ' ') &&
+			   *bol == todo_command_info[i].c) {
 			bol++;
 			item->command = i;
 			break;
@@ -1279,7 +1293,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));
 
-	if (item->command == TODO_EXEC) {
+	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
+	    item->command == TODO_RESET) {
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
@@ -1919,6 +1934,144 @@ static int do_exec(const char *command_line)
 	return status;
 }
 
+static int safe_append(const char *filename, const char *fmt, ...)
+{
+	va_list ap;
+	struct lock_file lock = LOCK_INIT;
+	int fd = hold_lock_file_for_update(&lock, filename, 0);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (fd < 0)
+		return error_errno(_("could not lock '%s'"), filename);
+
+	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
+		return error_errno(_("could not read '%s'"), filename);
+	strbuf_complete(&buf, '\n');
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		rollback_lock_file(&lock);
+		return error_errno(_("could not write to '%s'"), filename);
+	}
+	if (commit_lock_file(&lock) < 0) {
+		rollback_lock_file(&lock);
+		return error(_("failed to finalize '%s'"), filename);
+	}
+
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
+static int do_reset(const char *name, int len)
+{
+	struct strbuf ref_name = STRBUF_INIT;
+	struct object_id oid;
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc desc;
+	struct tree *tree;
+	struct unpack_trees_options opts;
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
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.fn = oneway_merge;
+	opts.merge = 1;
+	opts.update = 1;
+	opts.reset = 1;
+
+	read_cache_unmerged();
+	if (!fill_tree_descriptor(&desc, &oid)) {
+		error(_("failed to find tree of %s"), oid_to_hex(&oid));
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	if (unpack_trees(1, &desc, &opts)) {
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
+	if (!ret) {
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg, "(rebase -i) reset '%.*s'", len, name);
+		ret = update_ref(msg.buf, "HEAD", &oid, NULL, 0,
+				 UPDATE_REFS_MSG_ON_ERR);
+		strbuf_release(&msg);
+	}
+
+	strbuf_release(&ref_name);
+	return ret;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -2102,7 +2255,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				/* `current` will be incremented below */
 				todo_list->current = -1;
 			}
-		} else if (!is_noop(item->command))
+		} else if (item->command == TODO_LABEL)
+			res = do_label(item->arg, item->arg_len);
+		else if (item->command == TODO_RESET)
+			res = do_reset(item->arg, item->arg_len);
+		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
@@ -2207,6 +2364,23 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		}
 		apply_autostash(opts);
 
+		strbuf_reset(&buf);
+		if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0)
+		    > 0) {
+			char *p = buf.buf;
+			while (*p) {
+				char *eol = strchr(p, '\n');
+				if (eol)
+					*eol = '\0';
+				if (delete_ref("(rebase -i) cleanup",
+					       p, NULL, 0) < 0)
+					warning(_("could not delete '%s'"), p);
+				if (!eol)
+					break;
+				p = eol + 1;
+			}
+		}
+
 		fprintf(stderr, "Successfully rebased and updated %s.\n",
 			head_ref.buf);
 
-- 
2.16.1.windows.1


