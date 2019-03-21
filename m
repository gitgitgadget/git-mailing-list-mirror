Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B89320248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfCUGyE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:54:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36615 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCUGyD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:54:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so3700994pff.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9TOT/jnKBJCYSiQ22hbiwhygPS/MaEkZFG3c2YeXgc=;
        b=bkyh/FJXU0p1SQpFhVZhTdy2wdYCgQ7N4J9pFyu3KPQ/3tFtCwPvZWbm7In6tWHmEK
         1o0vtlJybek0tOrlVN6ctP4Y2W8WPGF1ryT5kSCD9eO65yyXV6ZDfC+2ROb5XU82jInz
         FTRDbIkJtTyDv3ydyCgqLvZ53GabSi68QBGQ9+GaxR/qZFhnNcbwyklTCTD12l7L5d1j
         kKDPgqjphsco8F5CU7K3NYbPLcuCBvcWJB3MCnpe01yayK2KM7KbHAqW9KeTwXBGO3o/
         qoQQO925+b4xk156HdcyzhxBxPb35RxkrbG9Z+Sdb3EW8qLJS5kkL3ooDC/mBtqu9XH3
         Vadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9TOT/jnKBJCYSiQ22hbiwhygPS/MaEkZFG3c2YeXgc=;
        b=GqmuQ64P8cwtmE6/jnl0BD87e8tyqDSTh/E41k9Mtuj4XQM6De21AL6uXWOfBbmQYk
         Lx1K5EML1GfbuNzxZCYj3InKZ8XYp5jTiTQ3zg1ourlpiJzrIOXXtr11SYPO8h/DMkfY
         6bjrFZQqiffq0DNHGAHdsGhhTwTX8wrrxYvJe7Q+LXGrkdLtQuWMAn0aCc7GbV6a9PHX
         GnYKfBGt7EDBg85UyEXa/oiU7QA3GhUJXLffmL5+GZYKrvzj++06pE2X2fDdi/aGLPqN
         LCaHJfm+qlNsKILI5tGRNhUVytHglS15mYJWozeI6ki3ZLuR31wVSSeGQPoucmu5m0wt
         cp7Q==
X-Gm-Message-State: APjAAAWnc4ylzaDoiKs7dyJnt+uGoeau9oM7KF9HOLrxR7oqAFJAvbjB
        ckH3NBkKypcm06JvOz8BUEY1hb/SwZY=
X-Google-Smtp-Source: APXvYqwxgZWpxuBxuNfEihXaDkmuFbUPTGrQkNuRP8MOkYSBxB6ht0jjwGKvxVL6VsiMxy3tyKrgQA==
X-Received: by 2002:a63:fc49:: with SMTP id r9mr1885487pgk.447.1553151242467;
        Wed, 20 Mar 2019 23:54:02 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id u13sm7079346pfa.169.2019.03.20.23.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:54:01 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 09/11] merge: add scissors line on merge conflict
Message-ID: <ebaeeb85fc05560e255d5fb2bc1b1566346906fd.1553150827.git.liu.denton@gmail.com>
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

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Next, if commit.cleanup = scissors is specified, don't produce a
scissors line in commit if one already exists in the MERGE_MSG file.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  7 +++--
 builtin/commit.c                | 20 ++++++++++----
 builtin/merge.c                 | 14 ++++++++++
 t/t7600-merge.sh                | 46 +++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index bcf0b3e49c..61876dbc33 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -33,8 +33,11 @@ updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
 --cleanup=<mode>::
-	This option determines how the merge message will be cleaned up
-	before commiting. See linkgit:git-commit[1] for more details.
+	This option determines how the merge message will be cleaned up before
+	commiting. See linkgit:git-commit[1] for more details. In addition, if
+	the '<mode>' is given a value of `scissors`, scissors will be appended
+	to `MERGE_MSG` before being passed on to the commit machinery in the
+	case of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/commit.c b/builtin/commit.c
index ba1e6027ba..b9159c2e7b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -668,6 +668,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -728,6 +729,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -738,8 +741,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -807,7 +816,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -832,10 +842,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
index f5783a901d..148554f08e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -920,6 +920,20 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	/*
+	 * We can't use cleanup_mode because if we're not using the editor,
+	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
+	 * though the message is meant to be processed later by git-commit.
+	 * Thus, we will get the cleanup mode which is returned when we _are_ using
+	 * an editor.
+	 */
+	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&the_index, &msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2f4c2801fb..7f9c68cbe7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -246,6 +246,52 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-\EOF &&
+	Merge tag '"'"'c7'"'"'
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge --squash c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
+
+	$(git show -s c7)
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_i18ncmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.21.0.512.g57bf1b23e1

