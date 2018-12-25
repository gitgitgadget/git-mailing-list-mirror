Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BAB211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeLYN4R (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 08:56:17 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:38522 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYN4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 08:56:17 -0500
Received: by mail-it1-f175.google.com with SMTP id h65so17804433ith.3
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myMvp/5hcMaZvnsykSuIzmIl6V6WLA/4vauEvxYHO+M=;
        b=rmpH+k52D9d1Y3kRUjmgc1ExazWQFjeT4oWuQr7s8KFCW0rpS1oHcewtHZpK5ibs6F
         3vKmfDxNCdljdpWIRDSoG4Hb8pRGNvclWRu50ZZNTi0BGGbJ3zTeCGdkCgUl2kKpGZZp
         +uJk1Rjnh4iVT4I5FU0txzHcB0WbbZeaiy6JUDP5yiXQL4yLN+8pm7b2kFwUsQk8gAwi
         B2S2pVry9nYaw2kYLD3A0Ghee+/aX9epVtDlo+as3hQJ3rHBwt+8accINI+KwxkDd2LY
         1qegtyYDW3dXduG6sj/JNmAxWl5bvOV9dMgR8FrQuIDRqa2LzgcZBIpaQieTYLimF6Kd
         +mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myMvp/5hcMaZvnsykSuIzmIl6V6WLA/4vauEvxYHO+M=;
        b=UmXftFNVQaf2Bk/2xinQX2XIRgVL4f7gUSm3E+rKzpc+3AFrKh4Kt1IeLBwqBX+wGt
         qNgO4EJdPEOm1ZEMA9hD8lWKz994pd9UM6WEwoHbUsbU3pwBOk68UN7+0Om9peIBmafi
         80XiOOX4KC8EFkz8n2c/fzVvVpLAMMc5BSWDIJHA+Tkh4/B5Y8O3NFWWO7Ioq9p9Atz6
         QGU3p/P8SH1nTB7I6YXTTeSZBZ9N98H6uoiZnWc/BdCq7dZCqJqqnSOi3Aivz9oy9Eog
         nNaTKu2/fM2Inu2Z+oGPOhBTVzfSMiR6oT60KfWMB05IiUReOR6YWC7JRpz+xBV4l0AL
         Hy8w==
X-Gm-Message-State: AA+aEWadUICa6qxh5p9UvGoLJUMm+fn6KAjzte0WUVs9LQyR3AzciZ3f
        CRgvv3hltzlRqInk+kX1IxJnUbNU
X-Google-Smtp-Source: AFSGD/VIJ44EEUeXrbxFP+zrfX1iTmxxgZJTYFhqxgRti9bTafDd3hvJdwwaLVIP9dHKMyiLDeGT7w==
X-Received: by 2002:a24:1aca:: with SMTP id 193mr10822255iti.150.1545746175568;
        Tue, 25 Dec 2018 05:56:15 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [99.245.246.183])
        by smtp.gmail.com with ESMTPSA id p132sm9595961itb.35.2018.12.25.05.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:56:15 -0800 (PST)
Date:   Tue, 25 Dec 2018 08:56:13 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v5 3/4] merge: cleanup messages like commit
Message-ID: <421942870ce23ed425139187332b9ebcd784124e.1545745331.git.liu.denton@gmail.com>
References: <cover.1542768902.git.liu.denton@gmail.com>
 <cover.1545745331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545745331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
index 63a3fc0954..22783651b6 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -27,6 +27,11 @@ they run `git merge`. To make it easier to adjust such scripts to the
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
index c3c976d471..ab0db46ede 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,6 +37,7 @@
 #include "tag.h"
 #include "alias.h"
 #include "commit-reach.h"
+#include "wt-status.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -97,6 +98,9 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
+static const char *cleanup_arg;
+static enum commit_msg_cleanup_mode cleanup_mode;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -245,6 +249,7 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
+	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
@@ -608,6 +613,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
@@ -793,23 +800,32 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
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
@@ -828,7 +844,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
-	strbuf_stripspace(&msg, 0 < option_edit);
+	cleanup_message(&msg, cleanup_mode, 0);
 	if (!msg.len)
 		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
@@ -876,7 +892,6 @@ static int finish_automerge(struct commit *head,
 	parents = remoteheads;
 	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
-	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
 			&result_commit, NULL, sign_commit))
@@ -1385,6 +1400,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
+	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit);
+
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/pull.c b/builtin/pull.c
index 1b90622b13..938be2f610 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -96,6 +96,7 @@ static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
+static char *opt_cleanup;
 static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
@@ -163,6 +164,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
+		N_("how to strip spaces and #comments from message"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
@@ -639,6 +643,8 @@ static int run_merge(void)
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
index a24711374c..3dc2ff9a8d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -991,13 +991,19 @@ size_t wt_status_locate_end(const char *s, size_t len)
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
index 1fcf93afbf..739a3e4dfb 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -127,6 +127,7 @@ struct wt_status {
 };
 
 size_t wt_status_locate_end(const char *s, size_t len);
+void wt_status_append_cut_line(struct strbuf *buf);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
2.20.1

