Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BC81F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395307AbfIGXoh (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:44:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40033 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfIGXoh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:44:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so9168670ota.7
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmVWpkNwSTH7XRWHOLwC74yUis34VVRNV4FUMqXwO1o=;
        b=NMUu+kjnn7QlbllgHHhIVDbcEjadMLNI6VQLYzli3WnbCPcbgCWIlBNTbmoCDCrHay
         9/BZBBNOObZDWLJpJzJnpUP396t4Da4qEbw3JYnLIFOoVIZm5F8g7I3fvwt6dNLSC7Zj
         WxBe8Ba8fifv1K8eZm52pTCjWQIw2GgPfeRXNvfn6HQuST1PX5vZuJ6EmZJ1Frg/EIdI
         IkOcDvaRS5ilVU9UNnarzTK+K2KSV+iBnBQZ+inCdZ5vPvdZ1smmVpHCb2jMl81I4Xqq
         vBM9E5vLAus3vOYI0XBoquJ6hx0/haZEAu2wiiROL4FlnyLTcb6mgpfZGsqBclTVki1T
         ZZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmVWpkNwSTH7XRWHOLwC74yUis34VVRNV4FUMqXwO1o=;
        b=ju0qunPVolMSOLM3t4SXNze8BXYBvVNIlGO5XwWgG0Fp0OXgUWwnzaJTT0FqW0c5yf
         Qu2yhWJacYhMdoAx8NMaeumDq6fVhGfpTGm+ZgeL5qN3qDXcdYiNlvLf1uGlPcyVIsCS
         3NTmCS1Oo0bqUWHHMbyk85hHfAxTjntqmY4tIhTUiW7olRubWG+dklpoRXtXZBxbf4gE
         SgWs/bUYy5bkYYNylCkMjX9tBRPrN/FBoQpD4omi/BEA20LWQS90lWWrAILsbUU04P5X
         GLv4P384Jd5ONC59IEDMcK/QMWWNOynMTW15kUWbyP1IAweRrAY/WeeS5Gr6I4/YooXh
         18aA==
X-Gm-Message-State: APjAAAVJeQQptANiniDVPcdW56J/TCBN7ALt9rcjM6EUbrKcanUI4Qsn
        IRfPFm5x5ukGRU5XK9uytZc=
X-Google-Smtp-Source: APXvYqx+j8sgdR9J/AJjykP5UHq0AI8qsgPxLLJR7iMRCqtH+qN5pwZZgv1PLH5DNnaf7ivbmBLAuQ==
X-Received: by 2002:a05:6830:14c2:: with SMTP id t2mr13654204otq.195.1567899875575;
        Sat, 07 Sep 2019 16:44:35 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:8a10:1290:ccab:112b:24b3:bd34])
        by smtp.gmail.com with ESMTPSA id 13sm3912081otv.14.2019.09.07.16.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 16:44:35 -0700 (PDT)
From:   Warren He <pickydaemon@gmail.com>
X-Google-Original-From: Warren He <wh109@yahoo.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, pickydaemon@gmail.com, wh109@yahoo.com
Subject: [PATCH v2] rebase: introduce --update-branches option
Date:   Sat,  7 Sep 2019 16:44:13 -0700
Message-Id: <20190907234413.1591-2-wh109@yahoo.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20190907234413.1591-1-wh109@yahoo.com>
References: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
 <20190907234413.1591-1-wh109@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebasing normally updates the current branch to the rewritten version.
If any other branches point to commits rewritten along the way, those
remain untouched. This commit adds an `--update-branches` option, which
instructs the command to update any such branches that it encounters to
point to the rewritten versions of those commits.

Signed-off-by: Warren He <wh109@yahoo.com>
---
 Documentation/git-rebase.txt      |  9 ++++
 builtin/rebase.c                  | 11 ++++-
 sequencer.c                       | 58 +++++++++++++++++++++++-
 sequencer.h                       |  6 ++-
 t/t3431-rebase-update-branches.sh | 94 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100755 t/t3431-rebase-update-branches.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6156609..b650a8f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -246,6 +246,13 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--update-branches::
+	If there are branch refs that point to commits that will be
+	reapplied, add shell commands to the todo list to update those
+	refs to point to the commits in the final history.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --allow-empty-message::
 	By default, rebasing commits with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
@@ -535,6 +542,7 @@ are incompatible with the following options:
  * --interactive
  * --exec
  * --keep-empty
+ * --update-branches
  * --edit-todo
  * --root when used in combination with --onto
 
@@ -543,6 +551,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
+ * --preserve-merges and --update-branches
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 670096c..ab2308c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -78,6 +78,7 @@ struct rebase_options {
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
+	int update_branches;
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
@@ -349,8 +350,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto, head_hash,
-			&commands, opts->autosquash, &todo_list);
+			shortrevisions, opts->onto_name, opts->onto, opts->head_name,
+			head_hash, &commands, opts->autosquash, &todo_list);
 	}
 
 	string_list_clear(&commands, 0);
@@ -375,6 +376,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= opts->update_branches ? TODO_LIST_UPDATE_BRANCHES : 0;
 
 	switch (command) {
 	case ACTION_NONE: {
@@ -1453,6 +1455,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
+		OPT_BOOL(0, "update-branches", &options.update_branches,
+			 N_("update branches that point to rebased commits")),
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
@@ -1710,6 +1714,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.keep_empty)
 		imply_interactive(&options, "--keep-empty");
 
+	if (options.update_branches)
+		imply_interactive(&options, "--update-branches");
+
 	if (gpg_sign) {
 		free(options.gpg_sign_opt);
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
diff --git a/sequencer.c b/sequencer.c
index 34ebf8e..0fe8452 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4901,6 +4901,59 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 	todo_list->alloc = alloc;
 }
 
+/*
+ * Add commands to update branch refs after the todo list would pick a commit
+ * that a branch ref points to.
+ */
+static void todo_list_add_branch_updates(struct repository *r,
+					 struct todo_list *todo_list,
+					 const char *head_name)
+{
+	struct strbuf *buf = &todo_list->buf;
+	/* watch out: items in here point into todo_list's buf, not its own */
+	struct todo_list new_list = TODO_LIST_INIT;
+	int i;
+
+	load_ref_decorations(NULL, 0);
+
+	for (i = 0; i < todo_list->nr; i++) {
+		const struct todo_item *item = todo_list->items + i;
+		enum todo_command command = item->command;
+		const struct name_decoration *decoration;
+
+		*append_new_todo(&new_list) = todo_list->items[i];
+
+		if (!(is_pick_or_similar(command) || command == TODO_MERGE))
+			continue;
+
+		decoration = get_name_decoration(&item->commit->object);
+		for (; decoration; decoration = decoration->next) {
+			size_t base_offset;
+
+			/*
+			 * (i)  skip other refs like tags and remote refs
+			 * (ii) rebase itself will update the current branch
+			 *      for us
+			 */
+			if (decoration->type != DECORATION_REF_LOCAL ||
+			    !strcmp(decoration->name, head_name))
+				continue;
+
+			base_offset = buf->len;
+			strbuf_addf(buf, "exec git branch -f %s\n",
+				    prettify_refname(decoration->name));
+			parse_insn_line(r, append_new_todo(&new_list), buf->buf,
+					buf->buf + base_offset,
+					buf->buf + buf->len - 1);
+		}
+	}
+
+	SWAP(new_list.items, todo_list->items);
+	SWAP(new_list.nr, todo_list->nr);
+	SWAP(new_list.alloc, todo_list->alloc);
+	todo_list_release(&new_list);
+}
+
 static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
 				struct strbuf *buf, int num, unsigned flags)
 {
@@ -5051,7 +5104,7 @@ static int skip_unnecessary_picks(struct repository *r,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head,
+		    struct commit *onto, const char *head_name, const char *orig_head,
 		    struct string_list *commands, unsigned autosquash,
 		    struct todo_list *todo_list)
 {
@@ -5070,6 +5123,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
 	}
 
+	if (flags & TODO_LIST_UPDATE_BRANCHES)
+		todo_list_add_branch_updates(r, todo_list, head_name);
+
 	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 6704acb..69c6f71 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -143,6 +143,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
 #define TODO_LIST_APPEND_TODO_HELP (1U << 5)
+#define TODO_LIST_UPDATE_BRANCHES (1U << 6)
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
@@ -152,8 +153,9 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash, struct todo_list *todo_list);
+		    struct commit *onto, const char *head_name, const char *orig_head,
+		    struct string_list *commands, unsigned autosquash,
+		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 /*
diff --git a/t/t3431-rebase-update-branches.sh b/t/t3431-rebase-update-branches.sh
new file mode 100755
index 0000000..b57b64a
--- /dev/null
+++ b/t/t3431-rebase-update-branches.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='git rebase --update-branches
+
+This test runs git rebase, updating branch refs that point to commits
+that are rebased.
+
+Initial setup:
+
+ A - B  (master)
+  |\
+  |  C      (linear-early)
+  |    \
+  |      D  (linear-late)
+  |\
+  |  E          (feat-e)
+  |\   \
+  |  F  |       (feat-f)
+  |    \|
+  |      G      (interim)
+  |        \
+  |          H  (my-dev, my-hotfixes)
+   \
+     I - J - fixup! I                 (fixup-early)
+		      \
+			K - fixup! J  (fixup-late)
+'
+. ./test-lib.sh
+
+test_expect_success 'set up common' '
+	test_commit A &&
+	test_commit B
+'
+
+test_expect_success 'set up linear' '
+	git checkout -b linear-early A &&
+	test_commit C &&
+	git checkout -b linear-late &&
+	test_commit D
+'
+
+test_expect_success 'smoketest linear' '
+	git rebase --update-branches master
+'
+
+test_expect_success 'check linear' '
+	test_cmp_rev linear-early HEAD^
+'
+
+test_expect_success 'set up merge' '
+	git checkout -b feat-e A &&
+	test_commit E &&
+	git checkout -b feat-f A &&
+	test_commit F &&
+	git checkout -b interim &&
+	test_merge G feat-e &&
+	git checkout -b my-dev &&
+	test_commit H &&
+	git branch my-hotfixes
+'
+
+test_expect_success 'smoketest merge' '
+	git rebase -r --update-branches master
+'
+
+test_expect_success 'check merge' '
+	test_cmp_rev feat-e HEAD^^2 &&
+	test_cmp_rev feat-f HEAD^^ &&
+	test_cmp_rev interim HEAD^ &&
+	test_cmp_rev my-hotfixes HEAD
+'
+
+test_expect_success 'set up fixup' '
+	git checkout -b fixup-early A &&
+	test_commit I &&
+	test_commit J &&
+	test_commit "fixup! I" I.t II fixup-I &&
+	git checkout -b fixup-late &&
+	test_commit K &&
+	test_commit "fixup! J" J.t JJ fixup-J
+'
+
+test_expect_success 'smoketest fixup' '
+	git rebase -i --autosquash --update-branches master
+'
+
+test_expect_success 'check fixup' '
+	test_cmp_rev fixup-early HEAD^ &&
+	test_cmp_rev fixup-early^:I.t fixup-I:I.t &&
+	test_cmp_rev fixup-early:J.t fixup-J:J.t &&
+	test_cmp_rev HEAD:K.t K:K.t
+'
+
+test_done
-- 
2.7.4

