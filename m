Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6B020248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCUGyB (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:54:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCUGyB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:54:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so3558920pgk.12
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3k3TNZ/zc4SxHCpHGjS40R6EOMvUUMUV8YJpphudCK0=;
        b=ukbz0GC6i3OqUp9ykQli16Kkmt+gX1KBNEWRNZO84tEsCjzqrZf0+5Ls6Ivc+uz+B7
         66fy92qui2sHsOkhTUd2aEfRo5lLygnAae211VwTJct3LFRXMgHm8mwAV5uj2NcfVkx9
         mFxT5sc7OiYaZHqlDyQ4Khl/ILn//FJ7znNcY2NDzjdD988ERjpY1MrYkSr9WAk0iO75
         ux4O4f4XSIQT2wOMOyAqxjme7bK/6MSuypN0dZN2QqcjSUo1+9Y4OpUIJRbfxd7D4PyK
         YPpnF8jq49jbgR3qGhWQuxX3bclBFw6yHp7lDaoOpKosai2NErY/oy7kamIr/jYJFMLs
         7i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3k3TNZ/zc4SxHCpHGjS40R6EOMvUUMUV8YJpphudCK0=;
        b=T6MnauM0ZjXcHKtyVkSLMVGk25OJ8QJm0iGQj/DMc7pVUmY+fx5Ai5tNOMIffwc2t9
         kn/IRtHBuQNWQgdB31hkVhOgWRbgSwu028OMjZnhSyLqYx2fwTvJ7Ty4lb0t4vUOlwlN
         cozvk+D+DKjt3FE+a/2OLCXSKYNdwmjw96Dh7acUHH49Qh0eBMxe3pfzkJKlrksGqE5U
         gguOUEDnzT5EA+QUbONjKsqa9N5FKp0r3Elz8vTMZxdMM5rjaa9UsK0yD5NtP/MFktte
         3AALkWX/OrHFYMC67Ffz4LJB4FtHadBHZzfViWtFMrsXxPWZVAdgGRGJixWG6N/4jy/c
         7VRQ==
X-Gm-Message-State: APjAAAW01olD+1h7+NZeZmAM9rrboyGQVbkLcuJX7UGSccS7A+2Ir3dj
        QNJcu/mVR9phuVqKkXdykFvEW8IOENM=
X-Google-Smtp-Source: APXvYqyQTqdelatZ84sPk/4R5ml+kJPBRnXo3RnCgQ2FucI3SXtRP8ecQXBwSSsM+mQXXE3a4fGyyA==
X-Received: by 2002:a65:6108:: with SMTP id z8mr1979275pgu.188.1553151239633;
        Wed, 20 Mar 2019 23:53:59 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id c2sm8218288pfm.187.2019.03.20.23.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:58 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:57 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 08/11] merge: cleanup messages like commit
Message-ID: <dc43289d0503fd3b691dc2635f9a6dc062af9c3d.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
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

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  4 +++
 builtin/merge.c                 | 35 ++++++++++++++----
 builtin/pull.c                  | 23 ++++++++++++
 t/t5521-pull-options.sh         |  8 +++++
 t/t7604-merge-custom-message.sh | 63 +++++++++++++++++++++++++++++++++
 wt-status.c                     | 12 +++++--
 wt-status.h                     |  1 +
 7 files changed, 136 insertions(+), 10 deletions(-)

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
index 5ce8946d39..f5783a901d 100644
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
@@ -800,8 +807,13 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
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
@@ -809,11 +821,19 @@ static void prepare_to_commit(struct commit_list *remoteheads)
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
+
+		strbuf_commented_addf(&msg, "\n");
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
@@ -1389,6 +1408,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
+	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
+
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/pull.c b/builtin/pull.c
index 33db889955..55ebb5808e 100644
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
+static char *opt_cleanup;
 static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
@@ -168,6 +170,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
+		N_("how to strip spaces and #comments from message"),
+		0),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
@@ -644,6 +649,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_commit);
 	if (opt_edit)
 		argv_array_push(&args, opt_edit);
+	if (opt_cleanup)
+		argv_array_push(&args, opt_cleanup);
 	if (opt_ff)
 		argv_array_push(&args, opt_ff);
 	if (opt_verify_signatures)
@@ -875,6 +882,22 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
+	if (opt_cleanup) {
+		const char *prefix = "--cleanup=";
+		const char *cleanup_arg;
+
+		if (strncmp(opt_cleanup, prefix, strlen(prefix)))
+			BUG("expecting prefix %s, argument is %s", prefix, opt_cleanup);
+
+		cleanup_arg = &opt_cleanup[strlen(prefix)];
+
+		/*
+		 * this only checks the validity of cleanup_arg; we don't need
+		 * a valid value for use_editor
+		 */
+		get_cleanup_mode(cleanup_arg, 0, 1);
+	}
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
2.21.0.512.g57bf1b23e1

