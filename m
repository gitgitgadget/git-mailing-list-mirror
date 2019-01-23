Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351781F453
	for <e@80x24.org>; Wed, 23 Jan 2019 05:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfAWFG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 00:06:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36414 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWFG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 00:06:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so532563plo.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 21:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hakPKX9YJGR3EtfTY9N1k+fe1u8NZdnBffqLQ0o/FGk=;
        b=fmrTxOY7Zmz8ohuNCe6BEroR2MIIjFW32lF8H7Qrv9qJFMrnDNadpi5jA2FgGF6M+r
         Cq2/5VF+fchbWFEfFYgOrYwjKrruUEjhOA//aj06fg7oA7ZLPm8NE0t07gGhTAy7riae
         GwlBrZbhY9ZJbGUasZDajlkBRgM52x7UN+VFDwTX9AV+tPXYL9jrLne28J6/LylMXvdi
         MVSFPPlXK1TtBxIO3sXac4omBIFUUuX9T5qIh1qp0Sq2+aHPtGqOOXZfM3jJOUPDbnu0
         uKTih1+ZO8TGChMN6/J7IIdq8Q6RrgmV5aQt5uzUz50AkMt7Or1SRxr1joQPPdZICCuU
         LNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hakPKX9YJGR3EtfTY9N1k+fe1u8NZdnBffqLQ0o/FGk=;
        b=SyvIuhRHzWwim9gY2HUGERgKQ2eufWriO3U5Yi5PrQT4g/qGSyUW8RnMDwiJKj1LD/
         bV6K5Y+TAq4092rgxPZJinpx8ByxEvA1Da35CAKRn6Hhvf8ykyha42suFJgDK5eLEQhd
         u+9dWpqq5ZKoSR+VUqKbh+GjxISOjXv9575jBhVu5PnjGDmVrT/o6Jq9J5WKOEWSmNMw
         VfRc8rg7xQUPBMpurXZJeAbaKWua99hoMciWf9u0wNxi0feOLEQcF4QQQ5ryfx2P50Qz
         x4KkY/k7u3vDz8jZ5YUFVWFr/23KTA53smQEx3kZOOSVEJb3jAFB55974F2jVGtcP+OO
         wlMg==
X-Gm-Message-State: AJcUukfYmmxz/q2OJUNYBrWwBCprQa5Rc4kwmwlChvTIsBtGBN9UA8OI
        JEwkf5IDskHHGnirvcVE9FldXjdZ
X-Google-Smtp-Source: ALg8bN71hYz4uzf+2nWd8oQDuH0PQ4FxiYAXMdG9U4PjytcUzaWQ4D7dKDKLl0tFzSLDa01JKxbHCg==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr804238pli.271.1548219988393;
        Tue, 22 Jan 2019 21:06:28 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id i1sm28937148pgb.46.2019.01.22.21.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 21:06:27 -0800 (PST)
Date:   Tue, 22 Jan 2019 21:06:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v6 4/4] merge: add scissors line on merge conflict
Message-ID: <39640b9e9e1171f1978082dc15b70b9277fa30d0.1548219737.git.liu.denton@gmail.com>
References: <cover.1545745331.git.liu.denton@gmail.com>
 <cover.1548219737.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548219737.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Next, if commit.cleanup = scissors is specified, don't produce a
scissors line in commit if one already exists in the MERGE_MSG file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  4 ++-
 builtin/commit.c                | 20 ++++++++++----
 builtin/merge.c                 | 14 ++++++++++
 t/t7600-merge.sh                | 46 +++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 22783651b6..c2a263ba74 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -30,7 +30,9 @@ set to `no` at the beginning of them.
 --cleanup=<mode>::
 	This option determines how the merge message will be cleaned up
 	before commiting or being passed on. See linkgit:git-commit[1] for more
-	details.
+	details. In addition, if the '<mode>' is given a value of `scissors`,
+	scissors will be prepended to MERGE_MSG before being passed on in the case
+	of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/commit.c b/builtin/commit.c
index 3ac0a21a22..eb549b57a3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -665,6 +665,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -725,6 +726,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -735,8 +738,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -804,7 +813,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -829,10 +839,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
index 19fb3abb77..fbf4a24850 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -912,6 +912,20 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	/*
+	 * We can't use cleanup_mode because if we're not using the editor,
+	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
+	 * though the message is meant to be processed later by git-commit.
+	 * Thus, we will get the cleanup mode is returned we _are_ using an
+	 * editor.
+	 */
+	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
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
index d879efd330..2cb57e5878 100755
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
+	cat >expect <<-EOF &&
+		Merge tag '"'"'c7'"'"'
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	file
+		EOF
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
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
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
+	test_i18ncmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.20.1.3.ge68552ea27.dirty

