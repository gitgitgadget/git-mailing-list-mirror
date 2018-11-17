Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C5D1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKRJu6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 04:50:58 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34171 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeKRJu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 04:50:58 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so4193801itd.1
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 15:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/fSHdLdOUqANYAY5JopKcYfYcRn2hBxabtuWBAEGt4=;
        b=rYbQ26h7yhSfWXclkLdD1+V7TVue6ZpmDu8bO4iV1ddrXui6m2zYzxrBe8UV+n3UNN
         PhTGuFrnsHT3zS9DCe24DDPmtAtSNBS8Il8brPWmdb34r1G57odkQX/KDaND2+3Wbo6z
         hBaWOTtqoZpWfT2vTVdrkGER8thMxc0Loni4eCYaJHwbhFCfgieOpW7bKaR+vlDN9uS2
         jPA2Z09hRIFVaRXvDlJYz2ZYN6uxD/NswQT1CRxpztFfVCJ0Xe8RS+7kBPbyP1CAM7Dg
         KIRAMo+YeET8ZKdZCDhH9MpGorzTCVujVxELRLoEaQT6gC2rh3tdXY1i0kEkI5PL7pb5
         LV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/fSHdLdOUqANYAY5JopKcYfYcRn2hBxabtuWBAEGt4=;
        b=IT9Ilsus09ZxFlzud6m43J6wXE7oUxNN6jyB6SHRro3lxjNwCr34LuqCI5DYYyyqAj
         QkZ0gkyg1vXmB4jz8kP5yurUNmnLD0JD/YJgpDYceiQsuwU58nsfLC9fJd9XHGUiArVI
         ebfdT9yrsF5iGkk/fgVDIDk9X540JWRax2WZuWpO3tdOMVyJLJ5vtPw2WBhnXkANLP2Y
         NT+b3TDatASshQXk4dsP1tx8rQa3TcQTcUxrbkyMC1hJ6r/aF2Inkl4vFg5BcfYErMio
         2Vj7/XGPRMl8dIv9eYQOI4J/K5qfUYpaSFXI6oJNqBOeXsMY5CIsXcuKAQNFwXkX3amy
         3whg==
X-Gm-Message-State: AGRZ1gLKJz2/4cNFXJ+YWYMBA0+0A9iyuuiQpo7/eE1DH8HAaJmTEZFO
        6rVJTG48MujzOPxX+aXKjQODWemX
X-Google-Smtp-Source: AFSGD/V82dUWLXHOBXKzeqXnpqL05Ro51+ItfcN/IJVtZlUZwhMs6YVEZ1buwg/FutWtY7tbtAedDA==
X-Received: by 2002:a24:5e50:: with SMTP id h77-v6mr3436258itb.58.1542497555260;
        Sat, 17 Nov 2018 15:32:35 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id j18sm11550152itl.20.2018.11.17.15.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 15:32:34 -0800 (PST)
Date:   Sat, 17 Nov 2018 18:32:33 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 1/1] merge: add scissors line on merge conflict
Message-ID: <5c1aa82794da23077ef4ec4e836ee221c64162ef.1542496915.git.liu.denton@gmail.com>
References: <cover.1542380929.git.liu.denton@gmail.com>
 <cover.1542496915.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542496915.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
merge.cleanup = scissors.

Next, if commit.cleanup = scissors is specified, don't produce a
scissors line in commit if one already exists in the MERGE_MSG file.

Finally, we give pull the passthrough option of --cleanup so that it
can also take advantage of this change.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  6 +++++
 builtin/commit.c                | 20 ++++++++++----
 builtin/merge.c                 | 16 +++++++++++
 builtin/pull.c                  |  6 +++++
 t/t7600-merge.sh                | 48 +++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 5 deletions(-)

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
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..7902645bc9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -659,6 +659,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -719,6 +720,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -729,8 +732,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			hook_arg1 = "squash";
 		} else
 			hook_arg1 = "merge";
+
+		merge_msg_start = sb.len;
 		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
+
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+		    wt_status_locate_end(sb.buf + merge_msg_start, sb.len - merge_msg_start) < sb.len - merge_msg_start)
+			merge_contains_scissors = 1;
 	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
@@ -798,7 +807,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -823,10 +833,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
-			 whence == FROM_COMMIT)
-			wt_status_add_cut_line(s->fp);
-		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
+		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+			if (whence == FROM_COMMIT && !merge_contains_scissors)
+				wt_status_add_cut_line(s->fp);
+		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\n"
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

