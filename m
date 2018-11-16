Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7712D1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 15:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeKQBdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 20:33:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43257 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKQBdC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 20:33:02 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so577086iop.10
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PX2VkK/10AqbnxxlIufP3nVTBjSzrDqmjZhJy5s5n1U=;
        b=vbIr/W4a5lbQymG/opbXXSPZyk9kzHSlRXJ76FG1mqpl8lxro9kCKEQ1yYMbzoOWZH
         P5sWL6/o9bx5VoEbvow21YA+Fd5YNr6uBeTuQ19WtdQP+cuCk0r7ErufSbJmk0kJ3m9Q
         +zmBEQ8mtBM+S16OP1Jbh0wqfKzqf2pVS9FvZZiRpkYmuTvzxcaSqTXhCVnB/7h9uZ33
         8jAulzFadySv98o/zfAHRl1H4evialnnKO81ulYvzDwlkBrA6u4sdxXAvwZg3in1zVXq
         hE/rzhNK+xHG8mFh9R1Mf3hDdrkC2adjun+lhck+gFRk7K2eVxU9pwjQ4H55ET+AlphK
         0yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PX2VkK/10AqbnxxlIufP3nVTBjSzrDqmjZhJy5s5n1U=;
        b=Q/l5N7sw7pWELyeAACT+DQDFg7GuRuCBzxSK25vxuZQ18sStzRwydWwTTwNIxYzFxK
         0BIhyXD/tnZFO9M4Xm8hdsmXHjoggNQax6tfBIwoG7bEbDl7o7krJe65owc5HzvgbBpF
         mcte1gUIl2qB3/Kgo/OhgwdhCRPuUF89ToynFq9FtArtuKhN+KtLa4OMpppQgnCCzkDT
         HXFNGlEk+AcnsJes4q85QCriGvyh4i231fUPKXIls0IGPe8aOGK9RIvTHblGRryTeRi8
         /zidvbIKKRrkte/5/JUC/cBa4+FhTReqzszDR7mnWepVvNx3y6jSNPkf9yvmthIwp+dQ
         0EbA==
X-Gm-Message-State: AGRZ1gL/WbOpBL5o7nkkM6mH04YSp+NrOQC/gKPkz+XdzOk2ByYXWxT0
        jAuDY0ReGXz1jqW826GQNaQ3UDEx
X-Google-Smtp-Source: AFSGD/XO5XB6nxNynFu2AAYyT60Q3PBo2l933QVN3RmWVhU4aFP465iak5DWmRy+xpRKP+jMLRZTeQ==
X-Received: by 2002:a6b:bf46:: with SMTP id p67-v6mr9133840iof.239.1542381613536;
        Fri, 16 Nov 2018 07:20:13 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id c102sm5733114itd.38.2018.11.16.07.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:20:13 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:20:11 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 2/2] merge: add scissors line on merge conflict
Message-ID: <cd62694df6be87700e10439716d7faf5ddce8cb4.1542380929.git.liu.denton@gmail.com>
References: <cover.1542172724.git.liu.denton@gmail.com>
 <cover.1542380929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542380929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
merge.cleanup = scissors.

In addition, we give pull the passthrough option of --cleanup so that it
can also take advantage of this change.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  6 +++++
 builtin/merge.c                 | 16 +++++++++++
 builtin/pull.c                  |  6 +++++
 t/t7600-merge.sh                | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 63a3fc0954..115e0ca6f0 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -27,6 +27,12 @@ they run `git merge`. To make it easier to adjust such scripts to the
 updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
+--cleanup=<mode>::
+	This option determines how the merge message will be cleaned up
+	before being passed on. Specifically, if the '<mode>' is given a
+	value of `scissors`, scissors will be prepended to the message in
+	the case of a merge conflict. See also linkgit:git-commit[1].
+
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
 	pointer, without creating a merge commit.  This is the default
diff --git a/builtin/merge.c b/builtin/merge.c
index 8f4a5065c2..23a6e6bb93 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -36,6 +36,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "wt-status.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -96,6 +97,9 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
+static const char *cleanup_arg;
+static int put_scissors;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -243,6 +247,7 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
+	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
@@ -606,6 +611,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
@@ -894,6 +901,13 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	if (put_scissors) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
@@ -1402,6 +1416,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
+	put_scissors = cleanup_arg && !strcmp(cleanup_arg, "scissors");
+
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/pull.c b/builtin/pull.c
index 681c127a07..88245bce0e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -95,6 +95,7 @@ static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
+static char *opt_cleanup;
 static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
@@ -162,6 +163,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
+		N_("how to strip spaces and #comments from message"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
@@ -625,6 +629,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_commit);
 	if (opt_edit)
 		argv_array_push(&args, opt_edit);
+	if (opt_cleanup)
+		argv_array_push(&args, opt_cleanup);
 	if (opt_ff)
 		argv_array_push(&args, opt_ff);
 	if (opt_verify_signatures)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..0d3db34f08 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -247,6 +247,54 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	{
+		cat <<-EOF
+		Merge tag '"'"'c7'"'"'
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	file
+		EOF
+	} >expect &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge --squash c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	{
+		cat <<-EOF
+		Squashed commit of the following:
+
+		$(git show -s c7)
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	file
+		EOF
+	} >expect &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	test_cmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.19.1

