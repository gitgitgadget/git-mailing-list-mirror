Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67444203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbdGXSyG (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 14:54:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36625 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbdGXSyE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 14:54:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id 184so13700238wmo.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=hZpWBfk5XMNBfIiBbExgahOTzwBNxZX8LlVsHubnm/U=;
        b=J3lQLOiDvZzpupE+lkHgSqocxTBxqPDGaQ/TyMgDSrSlFQTyv/jkCWFf4nc8vaUHw8
         HCukcKvdH8GCwdGEkzBqJ6Ek11VhYGn98zrhtU3ze4xkYMGgTxvyU1Jejj6ahAF19Mo0
         w6zBxLFGGW4lKuw/ZZ8hf6nExZUyCCe2kXV/1aIfKhnpOIn9mt3lA8fLffD/g8fr4+5h
         VpO1rSBJzxJOtJkGY+Or4UmRE9sd/zXUDwsbZWzoAiQt4ueN5L4/5Rg5pgu1I80AMFwz
         d22nvoZX7vWpOBjYGisBtUYFNVSa9pABkEAbnV5/2QL3ilulbkSXwn58m9fWrvP9Xgz5
         DmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=hZpWBfk5XMNBfIiBbExgahOTzwBNxZX8LlVsHubnm/U=;
        b=gRv40Saz2p8ZuvcO5oNKOk/ZeEPIOj2USEoEej3Yls7ekeTeDOZnlTy6KXLSvSU2Qw
         Ga+PlvbD6C+ceKgNa+3G+HDA7HslP8Sqfth5zOqBJi87lIjm5LhrkMku6nxUjkl7OnMw
         RZv0L2TOvb2QahKbU7TpFfJDyEawrCxtsGN1Yr/3f9PK67flAmmIrvEwR6ipscwlm+Dc
         kjNm9pR6YDWyFKoLxOGEabgWreRY4bPn7xHwYokBUlMPFiwNJ09fbZBrFwNJEnsEj2Oh
         scp/4zcpb8+LxLEYBGpopi50DuKvfTvzJ2hVINi7akx4RmBxOkIgMucAJA/TX4hyPcQ9
         5raw==
X-Gm-Message-State: AIVw113onn+GHn58UgICUJoF6NDE8ZwHJeDkUrC2W3hLybCLluR7ehTe
        2u0Rfq5YC8CF2A==
X-Received: by 10.28.134.199 with SMTP id i190mr5758255wmd.165.1500922443327;
        Mon, 24 Jul 2017 11:54:03 -0700 (PDT)
Received: from localhost.localdomain (x4db2767d.dyn.telefonica.de. [77.178.118.125])
        by smtp.gmail.com with ESMTPSA id m15sm12818691wrb.85.2017.07.24.11.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 11:54:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Remove help advice text from git editors for interactive rebase and reword
Date:   Mon, 24 Jul 2017 20:47:07 +0200
Message-Id: <20170724184707.22828-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.88.ge338f4246
In-Reply-To: <20170724172335.hcigpdzt4bewlk6w@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> So I actually would be OK with having an advice.* option to squelch
> rebase and/or commit instructions. But only if users decide they would
> never like to see that text. So yes, your tool could piggy-back on that
> config option, but it would be a slight abuse of the intent.

I don't mind the advice in the interactive rebase TODO list.  It's at
the end of the file, nothing comes after that, so it's never in the
way.

However, I do care about the advices in the commit message template,
because they are _between_ the commit message I'm writing and the diff
(using commit.verbose=true) I'm writing about.  So I build git
for my own use with the patch below for a couple of years now, but
never submitted it.


On a related note, when committing a merge or cherry-pick the commit
message templates includes this:

  # It looks like you may be committing a merge.
  # If this is not correct, please remove the file
  #       .git/MERGE_HEAD
  # and try again.

This text traces back almost to the dawn of time, to commit 9c065315f
(Make "git commit" work correctly in the presense of a manual merge,
2005-06-08).  Now, I can well imagine that stray MERGE_HEAD files
caused troubles back then, especially with those "manual merges"...  
But is it really an issue with modern git?!  I think this is long
outdated and could be removed.


  -- >8 --

Subject: [PATCH] commit: allow suppression of commit message template advices

The commit message template includes a lot of advices:

  - The default commit message template asks the user nicely to write
    a commit message and tells about comments and how to abort.
  - It includes some outdated hints about merges and cherry-picks.
  - Finally, in case of 'git commit -v' it reminds about the role of
    the scissors line separating the commit message from the diff.

While these reminders are useful for new users, with time they learn
what the score is, and experienced users might find these advices are
just wasting a couple of lines' worth of screen real estate.

Make displaying these advices configurable via the 'advice.commitMsg'
config variable.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config.txt |  2 ++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 builtin/commit.c         | 69 ++++++++++++++++++++++++++----------------------
 wt-status.c              | 14 +++++-----
 5 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..29c8736b1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -331,6 +331,8 @@ advice.*::
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
+	commitMsg::
+		Advices shown in the commit message template.
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
diff --git a/advice.c b/advice.c
index d81e1cb74..7851bb20c 100644
--- a/advice.c
+++ b/advice.c
@@ -10,6 +10,7 @@ int advice_push_needs_force = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
+int advice_commit_msg = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
@@ -31,6 +32,7 @@ static struct {
 	{ "statushints", &advice_status_hints },
 	{ "statusuoption", &advice_status_u_option },
 	{ "commitbeforemerge", &advice_commit_before_merge },
+	{ "commitmsg", &advice_commit_msg },
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
diff --git a/advice.h b/advice.h
index c84a44531..92c9937d6 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_push_needs_force;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_commit_before_merge;
+extern int advice_commit_msg;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
diff --git a/builtin/commit.c b/builtin/commit.c
index 8e9380251..ead7bf5ef 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -810,38 +810,42 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == CLEANUP_SCISSORS)
 				wt_status_add_cut_line(s->fp);
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-			    whence == FROM_MERGE
-				? _("\n"
-					"It looks like you may be committing a merge.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n")
-				: _("\n"
-					"It looks like you may be committing a cherry-pick.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n"),
-				whence == FROM_MERGE ?
-					git_path_merge_head() :
-					git_path_cherry_pick_head());
+			if (advice_commit_msg)
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+				    whence == FROM_MERGE
+					? _("\n"
+						"It looks like you may be committing a merge.\n"
+						"If this is not correct, please remove the file\n"
+						"	%s\n"
+						"and try again.\n")
+					: _("\n"
+						"It looks like you may be committing a cherry-pick.\n"
+						"If this is not correct, please remove the file\n"
+						"	%s\n"
+						"and try again.\n"),
+					whence == FROM_MERGE ?
+						git_path_merge_head() :
+						git_path_cherry_pick_head());
 		}
 
 		fprintf(s->fp, "\n");
-		if (cleanup_mode == CLEANUP_ALL)
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\nwith '%c' will be ignored, and an empty"
-				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode == CLEANUP_SCISSORS && whence == FROM_COMMIT)
+		if (cleanup_mode == CLEANUP_ALL) {
+			if (advice_commit_msg)
+				status_printf(s, GIT_COLOR_NORMAL,
+					_("Please enter the commit message for your changes."
+					  " Lines starting\nwith '%c' will be ignored, and an empty"
+					  " message aborts the commit.\n"), comment_line_char);
+		} else if (cleanup_mode == CLEANUP_SCISSORS && whence == FROM_COMMIT)
 			wt_status_add_cut_line(s->fp);
-		else /* CLEANUP_SPACE, that is. */
-			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				  " Lines starting\n"
-				  "with '%c' will be kept; you may remove them"
-				  " yourself if you want to.\n"
-				  "An empty message aborts the commit.\n"), comment_line_char);
+		else /* CLEANUP_SPACE, that is. */ {
+			if (advice_commit_msg)
+				status_printf(s, GIT_COLOR_NORMAL,
+					_("Please enter the commit message for your changes."
+					  " Lines starting\n"
+					  "with '%c' will be kept; you may remove them"
+					  " yourself if you want to.\n"
+					  "An empty message aborts the commit.\n"), comment_line_char);
+		}
 
 		/*
 		 * These should never fail because they come from our own
@@ -856,7 +860,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
 				"Author:    %.*s <%.*s>"),
-				ident_shown++ ? "" : "\n",
+				ident_shown++ || !advice_commit_msg ? "" : "\n",
 				(int)(ai.name_end - ai.name_begin), ai.name_begin,
 				(int)(ai.mail_end - ai.mail_begin), ai.mail_begin);
 
@@ -864,18 +868,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
 				"Date:      %s"),
-				ident_shown++ ? "" : "\n",
+				ident_shown++ || !advice_commit_msg ? "" : "\n",
 				show_ident_date(&ai, DATE_MODE(NORMAL)));
 
 		if (!committer_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
 				"Committer: %.*s <%.*s>"),
-				ident_shown++ ? "" : "\n",
+				ident_shown++ || !advice_commit_msg ? "" : "\n",
 				(int)(ci.name_end - ci.name_begin), ci.name_begin,
 				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
 
-		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
+		if (ident_shown || advice_commit_msg)
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
diff --git a/wt-status.c b/wt-status.c
index 77c27c511..09cb24be9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -934,13 +934,15 @@ size_t wt_status_locate_end(const char *s, size_t len)
 
 void wt_status_add_cut_line(FILE *fp)
 {
-	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
-	struct strbuf buf = STRBUF_INIT;
-
 	fprintf(fp, "%c %s", comment_line_char, cut_line);
-	strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
-	fputs(buf.buf, fp);
-	strbuf_release(&buf);
+	if (advice_commit_msg) {
+		const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
+		fputs(buf.buf, fp);
+		strbuf_release(&buf);
+	}
 }
 
 static void wt_longstatus_print_verbose(struct wt_status *s)
-- 
2.14.0.rc0.88.ge338f4246

