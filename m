Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D13320248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfDQKZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfDQKZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so2915995wmf.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=nzdRr+u/ozJQ+ukEKPgtAun2euWgtpIfOg2PzoTOPB4=;
        b=E6IpoX4rv7WRPHKR6JYZnCKOJ0PjndSIkdZ+eBdOCMwav67QRz+a6LAY5zdsFUD7dj
         V9MzKguIRVXrB6kxwxxb02jVcHkB8ncNTToTnun0MPly0nauj8RXNh7LjNvLmUC6jgbk
         x7dv2knGFohR4d6dhJ61AUd0g4ms9fwSbSNHUO5K5na6i4goIyImlOGQo5RlPLCAehp1
         ZwDfap0QCU5jqfTseYWd/IXgeR1YD3TjMLSwOLcNWIcUhE6vKv02uDVRdORslSzZLjK0
         kIqY9ECT8XVVSS/3Obdbb4sed0J2/TKcsO0Ev5rfXiN7Ih2zdGV520t9TwKBHIPuoRqd
         4ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=nzdRr+u/ozJQ+ukEKPgtAun2euWgtpIfOg2PzoTOPB4=;
        b=mXmJ6Ak7l7nsnWf+cA6vAdnFj1ZkzlkBEXubk/igjH+2cgZcgAnWVGC/wAUQyAHAz8
         V3BW86B5vJ+B2P1Zu/Jwmale1Zo4YVzVJl9bJplX0j09Va9dGO02HOHv2zDureyCuGIC
         Y6pCWqr+bRquEdLQEaEMnUEZJh1dT7/52al7OJfxNPfCWRcCnaiRRO0GUoVc1f48YJRE
         Gls54mM27U5EPTC/TcHceYyfcPpFEpfo8LBhqi8m8fqWOvTTGr+Nk6REVel195JjiN5R
         O3JE0HjE9Xfe4ciZrM5aNpPbEfy+huds6/8XJHl/ri816FnzanOaZdLQj2eOgMKyKh9V
         4lJw==
X-Gm-Message-State: APjAAAXFEJ6B6Bzf/etB5dNNrnMn7bmxpX9NmNuwiOK435+bnJAKDXXW
        j+IKVkUzwPxYtUzjoneyGM4=
X-Google-Smtp-Source: APXvYqy3SaWYCcMp6Fxryc4aOzy2W18nlZTe0CCZLVTa8xm43l7NtELG1SLG3b2lIAH+qEoRxXFWqA==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr30595549wmh.86.1555496720807;
        Wed, 17 Apr 2019 03:25:20 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:25:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v10 07/10] merge: cleanup messages like commit
Date:   Wed, 17 Apr 2019 11:23:27 +0100
Message-Id: <20190417102330.24434-8-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

This change allows git-merge messages to be cleaned up with the
commit.cleanup configuration or --cleanup option, just like how
git-commit does it.

We also give git-pull the option of --cleanup so that it can also take
advantage of this change.

Finally, add testing to ensure that messages are properly cleaned up.
Note that some newlines that were added to the commit message were
removed so that if a file were read via -F, it would be copied
faithfully.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  4 +++
 builtin/merge.c                 | 41 +++++++++++++++------
 builtin/pull.c                  | 12 +++++++
 t/t5521-pull-options.sh         |  8 +++++
 t/t7604-merge-custom-message.sh | 63 +++++++++++++++++++++++++++++++++
 wt-status.c                     | 12 +++++--
 wt-status.h                     |  1 +
 7 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 92a7d936c1..bcf0b3e49c 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -32,6 +32,10 @@ they run `git merge`. To make it easier to adjust such scripts to the
 updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
+--cleanup=<mode>::
+	This option determines how the merge message will be cleaned up
+	before commiting. See linkgit:git-commit[1] for more details.
+
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
 	pointer, without creating a merge commit.  This is the default
diff --git a/builtin/merge.c b/builtin/merge.c
index 5ce8946d39..e1f7b7342d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -38,6 +38,7 @@
 #include "tag.h"
 #include "alias.h"
 #include "commit-reach.h"
+#include "wt-status.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -98,6 +99,9 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
+static const char *cleanup_arg;
+static enum commit_msg_cleanup_mode cleanup_mode;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -249,6 +253,7 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
+	OPT_CLEANUP(&cleanup_arg),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
@@ -612,6 +617,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
@@ -800,20 +807,33 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 static const char merge_editor_comment[] =
 N_("Please enter a commit message to explain why this merge is necessary,\n"
    "especially if it merges an updated upstream into a topic branch.\n"
-   "\n"
-   "Lines starting with '%c' will be ignored, and an empty message aborts\n"
+   "\n");
+
+static const char scissors_editor_comment[] =
+N_("An empty message aborts the commit.\n");
+
+static const char no_scissors_editor_comment[] =
+N_("Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
 static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
 	strbuf_addbuf(&msg, &merge_msg);
-	strbuf_addch(&msg, '\n');
 	if (squash)
 		BUG("the control must not reach here under --squash");
-	if (0 < option_edit)
-		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
+	if (0 < option_edit) {
+		strbuf_addch(&msg, '\n');
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+			wt_status_append_cut_line(&msg);
+			strbuf_commented_addf(&msg, "\n");
+		}
+		strbuf_commented_addf(&msg, _(merge_editor_comment));
+		strbuf_commented_addf(&msg, _(cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS ?
+			scissors_editor_comment :
+			no_scissors_editor_comment), comment_line_char);
+	}
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
@@ -832,7 +852,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
-	strbuf_stripspace(&msg, 0 < option_edit);
+	cleanup_message(&msg, cleanup_mode, 0);
 	if (!msg.len)
 		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
@@ -880,7 +900,6 @@ static int finish_automerge(struct commit *head,
 	parents = remoteheads;
 	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
-	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
 			&result_commit, NULL, sign_commit))
@@ -1301,6 +1320,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 	resolve_undo_clear();
 
+	if (option_edit < 0)
+		option_edit = default_edit_option();
+
+	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit);
+
 	if (verbosity < 0)
 		show_diffstat = 0;
 
@@ -1386,9 +1410,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			fast_forward = FF_NO;
 	}
 
-	if (option_edit < 0)
-		option_edit = default_edit_option();
-
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/pull.c b/builtin/pull.c
index 33db889955..5bf82b4b27 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -24,6 +24,7 @@
 #include "lockfile.h"
 #include "wt-status.h"
 #include "commit-reach.h"
+#include "sequencer.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -101,6 +102,7 @@ static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
+static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
@@ -168,6 +170,7 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
+	OPT_CLEANUP(&cleanup_arg),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
@@ -644,6 +647,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_commit);
 	if (opt_edit)
 		argv_array_push(&args, opt_edit);
+	if (cleanup_arg)
+		argv_array_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		argv_array_push(&args, opt_ff);
 	if (opt_verify_signatures)
@@ -875,6 +880,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
+	if (cleanup_arg)
+		/*
+		 * this only checks the validity of cleanup_arg; we don't need
+		 * a valid value for use_editor
+		 */
+		get_cleanup_mode(cleanup_arg, 0);
+
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
 	if (!opt_ff)
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index c19d8dbc9d..ccde8ba491 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -77,6 +77,14 @@ test_expect_success 'git pull -q -v' '
 	test_must_be_empty out &&
 	test -s err)
 '
+test_expect_success 'git pull --cleanup errors early on invalid argument' '
+	mkdir clonedcleanup &&
+	(cd clonedcleanup && git init &&
+	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
+	test_must_be_empty out &&
+	test -s err)
+'
+
 
 test_expect_success 'git pull --force' '
 	mkdir clonedoldstyle &&
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index aba1279132..cd4f9607dc 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -49,4 +49,67 @@ test_expect_success 'merge --log appends to custom message' '
 	test_cmp exp.log actual
 '
 
+mesg_with_comment_and_newlines='
+# text
+
+'
+
+test_expect_success 'prepare file with comment line and trailing newlines'  '
+	printf "%s" "$mesg_with_comment_and_newlines" >expect
+'
+
+test_expect_success 'cleanup commit messages (verbatim option)' '
+	git reset --hard c1 &&
+	git merge --cleanup=verbatim -F expect c2 &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cleanup commit messages (whitespace option)' '
+	git reset --hard c1 &&
+	test_write_lines "" "# text" "" >text &&
+	echo "# text" >expect &&
+	git merge --cleanup=whitespace -F text c2 &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cleanup merge messages (scissors option)' '
+	git reset --hard c1 &&
+	cat >text <<-\EOF &&
+
+	# to be kept
+
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	# ------------------------ >8 ------------------------
+	to be removed
+	# ------------------------ >8 ------------------------
+	to be removed, too
+	EOF
+
+	cat >expect <<-\EOF &&
+	# to be kept
+
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	EOF
+	git merge --cleanup=scissors -e -F text c2 &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cleanup commit messages (strip option)' '
+	git reset --hard c1 &&
+	test_write_lines "" "# text" "sample" "" >text &&
+	echo sample >expect &&
+	git merge --cleanup=strip -F text c2 &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 445a36204a..b81fcd428d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1006,13 +1006,19 @@ size_t wt_status_locate_end(const char *s, size_t len)
 	return len;
 }
 
-void wt_status_add_cut_line(FILE *fp)
+void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
+
+	strbuf_commented_addf(buf, "%s", cut_line);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
+}
+
+void wt_status_add_cut_line(FILE *fp)
+{
 	struct strbuf buf = STRBUF_INIT;
 
-	fprintf(fp, "%c %s", comment_line_char, cut_line);
-	strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
+	wt_status_append_cut_line(&buf);
 	fputs(buf.buf, fp);
 	strbuf_release(&buf);
 }
diff --git a/wt-status.h b/wt-status.h
index 3a95975032..64f1ddc9fd 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -129,6 +129,7 @@ struct wt_status {
 };
 
 size_t wt_status_locate_end(const char *s, size_t len);
+void wt_status_append_cut_line(struct strbuf *buf);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
2.21.0

