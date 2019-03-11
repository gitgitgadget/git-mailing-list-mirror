Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD0620248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfCKDmp (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45807 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so2671206pfm.12
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gMKA5R+Sm1GGYtPw/lmyNSNvVlUsbscM+EbboDwLjOQ=;
        b=lwOhVNGkjc2MQYlePEwPCnQs2ae6MuYH+Q60BaVeS0iF7EYeq1uOXeGtN5qnGuSd1P
         f6I7Ao4ERqBnFCze4MkY11XBunxkQJS9103KLxZ229cWVHXcgXqXVGwffdL5VtNVGPEm
         mahorfiv/xTV1oCMfyknmuO+Eu0wmaMr/1/qXInAfFkF5RAWMmP4GgKca0uLOpIMxYAD
         lgQI5NxjJGR0jbeoRiCfJ/knc96EJR4cRHu7dlwYTDcwaFJhnw0cB4t5thghARc23BNq
         2eSFYu8Bg7wO0sMrXdTRLBc8almtN+9HK1bogo2Um9gatkNzJ8uhuRIAL+3r/aLOFhjR
         7R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMKA5R+Sm1GGYtPw/lmyNSNvVlUsbscM+EbboDwLjOQ=;
        b=R8d9M1lENEITWomWjM3WaIhQWYzUCaBkfvD+b7Z1B3Ze3w+LpBl4GPvddtMx5I9Hm6
         K+Txz+Yd3C23S6DBuR22uHggf/wrw1PbBozcA8+I47b791dB/nP3CueWLPzbHXD3+rkV
         ieWau9fNuBKygNKWaezVtXvxQwWmHeNMUBWd9sTxi6qfkK3m73H6mYU90JEDqHOslNC+
         LjfM77qR8CMfpG/6RPbQx8IZl6GKUgV+ywMAv+tojls08QFLlOnAzqbE7Bv5/oXr0YhT
         30DJog3MWQGBr7wE76zUo/cxBcuPQN1gZI8hXNpuiN8yoJ3YC8DKxDLQx5fk2xEAikT1
         jYiA==
X-Gm-Message-State: APjAAAWlXtfX4YQF0TBaY86lRBQhaJFyCklRDdKxCrj4zKW1JnzoqKsL
        W0Yd6ytvjGkaKyUWPE0Fc75eMHVe
X-Google-Smtp-Source: APXvYqwwKeZ9ZCij/vPEcr3cWuUFASSpbnbkixxPlT4DgOlp9QueQvdRsoG2+py8emyS0JJeFTDfzw==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr32588845plo.265.1552275763470;
        Sun, 10 Mar 2019 20:42:43 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 11sm5753832pfh.131.2019.03.10.20.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:43 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:41 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 5/8] merge: cleanup messages like commit
Message-ID: <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change allows git-merge messages to be cleaned up with the
commit.cleanup configuration or --cleanup option, just like how
git-commit does it.

We also give git-pull the passthrough option of --cleanup so that it can
also take advantage of this change.

Finally, add testing to ensure that messages are properly cleaned up.
Note that some newlines that were added to the commit message were
removed so that if a file were read via -F, it would be copied
faithfully.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  5 +++
 builtin/merge.c                 | 31 +++++++++++++----
 builtin/pull.c                  |  6 ++++
 t/t7604-merge-custom-message.sh | 61 +++++++++++++++++++++++++++++++++
 wt-status.c                     | 12 +++++--
 wt-status.h                     |  1 +
 6 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 92a7d936c1..646100ea9a 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -32,6 +32,11 @@ they run `git merge`. To make it easier to adjust such scripts to the
 updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
+--cleanup=<mode>::
+	This option determines how the merge message will be cleaned up
+	before commiting or being passed on. See linkgit:git-commit[1] for more
+	details.
+
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
 	pointer, without creating a merge commit.  This is the default
diff --git a/builtin/merge.c b/builtin/merge.c
index 5ce8946d39..4f5fcf5ce9 100644
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
+	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
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
@@ -797,23 +804,32 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 	exit(1);
 }
 
+static const char comment_line_explanation[] =
+N_("Lines starting with '%c' will be ignored.\n");
+
 static const char merge_editor_comment[] =
 N_("Please enter a commit message to explain why this merge is necessary,\n"
    "especially if it merges an updated upstream into a topic branch.\n"
    "\n"
-   "Lines starting with '%c' will be ignored, and an empty message aborts\n"
-   "the commit.\n");
+   "An empty message aborts the commit.\n");
 
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
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			wt_status_append_cut_line(&msg);
+		else
+			strbuf_commented_addf(&msg, _(comment_line_explanation), comment_line_char);
+
+		strbuf_commented_addf(&msg, "\n");
+		strbuf_commented_addf(&msg, _(merge_editor_comment));
+	}
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
@@ -832,7 +848,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
-	strbuf_stripspace(&msg, 0 < option_edit);
+	cleanup_message(&msg, cleanup_mode, 0);
 	if (!msg.len)
 		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
@@ -880,7 +896,6 @@ static int finish_automerge(struct commit *head,
 	parents = remoteheads;
 	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
-	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
 			&result_commit, NULL, sign_commit))
@@ -1389,6 +1404,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
+	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
+
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/pull.c b/builtin/pull.c
index 33db889955..3ec7882375 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -101,6 +101,7 @@ static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
+static char *opt_cleanup;
 static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
@@ -168,6 +169,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
+		N_("how to strip spaces and #comments from message"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
@@ -644,6 +648,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_commit);
 	if (opt_edit)
 		argv_array_push(&args, opt_edit);
+	if (opt_cleanup)
+		argv_array_push(&args, opt_cleanup);
 	if (opt_ff)
 		argv_array_push(&args, opt_ff);
 	if (opt_verify_signatures)
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 89619cf446..3fcd58eb2c 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -47,4 +47,65 @@ test_expect_success 'merge --log appends to custom message' '
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
+	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cleanup commit messages (whitespace option)' '
+	git reset --hard c1 &&
+	{ echo;echo "# text";echo; } >text &&
+	echo "# text" >expect &&
+	git merge --cleanup=whitespace -F text c2 &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'cleanup merge messages (scissors option)' '
+	git reset --hard c1 &&
+	cat >text <<EOF &&
+
+# to be kept
+
+  # ------------------------ >8 ------------------------
+# to be kept, too
+# ------------------------ >8 ------------------------
+to be removed
+# ------------------------ >8 ------------------------
+to be removed, too
+EOF
+
+	cat >expect <<EOF &&
+# to be kept
+
+  # ------------------------ >8 ------------------------
+# to be kept, too
+EOF
+	git merge --cleanup=scissors -e -F text c2 &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cleanup commit messages (strip option)' '
+	git reset --hard c1 &&
+	{ echo;echo "# text";echo sample;echo; } >text &&
+	echo sample >expect &&
+	git merge --cleanup=strip -F text c2 &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	test_cmp expect actual
+
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
2.21.0.370.g4fdb13b891

