Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5621F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeBKAKZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:40121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752977AbeBKAKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:23 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MaZWz-1eQeIL3kdt-00K5BV; Sun, 11 Feb 2018 01:10:17 +0100
Date:   Sun, 11 Feb 2018 01:10:16 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 04/12] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <6c1e131d2eb26534869c06b714cc5cc729004a41.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cY+jcK+HKvG0L138d3NRLl0AqnUEwf3aa5nHCOlBtU1dNigEFui
 X7Q1P67UYEFGDxWOs7sxHpfyPAWZrlCkK/ZcfwWlxduhHV4JNcUHCTOaC+TAD9sXveSBSw5
 n5LhJnRrPC3sRc1x+EqRxp7SgIE7KgfxemEnMmnhhgB5luNT7/EgShaximmrBW1FGZmKduO
 C0MEjyeBA+uUnzlq/r8PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Z7JlWqk9QA=:YoDkKBxu1svAWeOULyBZXg
 1EIZW/mpI84X6wdJ4KMkEK/JFR4xIGR8Sm1GMhxWfyCJgVSMj5+D3YqJJCN9/wpONmQJUo14d
 bwQLS7cXLveMoWVzilJLb3huR/jATVp2HxY4Fg/jEMAD+veR/KGCSOHxVAr5sSDU17TFvf0Pu
 G8AmKtaAhpQrFJdYNTAHSXzRwLZoCKl+3a8Ng4mM3H5RD6WtLSYGkoVCnQ2XX779EX7PKTfdq
 b4M7eg3oLP6N+k4k+tGJhpkMQlBQN5DbdkIFWa8qvnYmjJb5FLKIsjiJ7i1IXashekZuI4IMD
 6e1twGxzhgViDJh/FcnvvEw7PHzxgxuAiwFpLCBgFTJbKvBqG1iFK6ybYhdmzOaorxVgYzusA
 FV19NNdgIY70l4O1HvmwIb/EE+7DgKgae/ZueqlpZHtUmKo0JA/icOvvWuJGudIaOhgIepesV
 VOypvQej791+jiUhGcHqtudcucleb0vDxGWB7YGlhsnomhk5mwyk7xbBrnen3J6CKkNzXz02X
 YjDNSfxinOpE+dj+rm+aeL/QfcdklVvfvO9U2mGlg73GeQrwFwBC9J7fL9zjj9340Lj3+ei3b
 JSZiKyCpa6oso0i5t33NyK7oRHLdx9ZGrHews0EDdTTrJ0OyZBxUTvou52zgwtGJ4FV2fErhR
 02YHfrkoyCV/Akxfitcof1i3oQb8fjzoba4LQ1/q/OmEBGnEk0cOvBtr7sPiMz+Fa6j3ztmWM
 hIkI7gKLrkg74Rr7T3kvY66ylOZ1oBn96bCsZRA3e/JN6XpZxKuMX/WM++ChSrxkU45PwhbOO
 hTCie0F1+lO8krwadOnF7jld+q+41K2IldiLp1YKq/pHI25nw8=
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
revision to a previous state, and  merging labeled revisions.

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

These temporary refs are removed upon sequencer_remove_state(), so that
even a `git rebase --abort` cleans them up.

We disallow '#' as label because that character will be used as separator
in the upcoming `merge` command.

Later in this patch series, we will mark the `refs/rewritten/` refs as
worktree-local, to allow for interactive rebases to be run in parallel in
worktrees linked to the same repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   2 +
 sequencer.c                | 190 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 186 insertions(+), 6 deletions(-)

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
index 764ad43388f..8638086f667 100644
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
+ * finishes. This is used by the `label` command to record the need for cleanup.
+ */
+static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
+
 /*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
@@ -195,18 +204,33 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 
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
@@ -769,6 +793,8 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_LABEL,
+	TODO_RESET,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -787,6 +813,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 'l', "label" },
+	{ 't', "reset" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1281,7 +1309,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));
 
-	if (item->command == TODO_EXEC) {
+	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
+	    item->command == TODO_RESET) {
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
@@ -1922,6 +1951,151 @@ static int do_exec(const char *command_line)
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
+	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
+		return error_errno(_("could not read '%s'"), filename);
+	strbuf_complete(&buf, '\n');
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		error_errno(_("could not write to '%s'"), filename);
+		rollback_lock_file(&lock);
+		return -1;
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
+	unpack_tree_opts.reset = 1;
+
+	if (read_cache_unmerged())
+		return error_resolve_conflict(_(action_name(opts)));
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
@@ -2105,7 +2279,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				/* `current` will be incremented below */
 				todo_list->current = -1;
 			}
-		} else if (!is_noop(item->command))
+		} else if (item->command == TODO_LABEL)
+			res = do_label(item->arg, item->arg_len);
+		else if (item->command == TODO_RESET)
+			res = do_reset(item->arg, item->arg_len, opts);
+		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
-- 
2.16.1.windows.1


