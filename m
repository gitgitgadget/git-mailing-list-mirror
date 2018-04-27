Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22DB1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759280AbeD0Usk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 16:48:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:58433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759261AbeD0Usf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 16:48:35 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lqn7e-1eghLt1qiY-00eNzs; Fri, 27 Apr 2018 22:48:27 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 2/4] rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
Date:   Fri, 27 Apr 2018 22:48:21 +0200
Message-Id: <99624118cb9e68ac6b38c4abf344ad880b607bf4.1524862093.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524862093.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524862093.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:hpvaR7WsFuTquQu6SE2SUHAj7GctLlkZ/Syra0OdflOSzKgKidp
 mTwnzS0O8LmamlPUOugw5vwzcQO4h5rpSFNFdTiTfvO/ixem/5AQBRPel/yrwLIfSHh65pB
 onCndyND2KheJusW42DZ2MeU+gs0eol1TWanS5YgJXU2LgiU0xAe0JIVDFDYW/32ECa5VQc
 EBKXomwzu1iXb1m+keYUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mi7N1EfktYs=:lgcRrxwk1pvr3A7BLw4Nmu
 fvCisbZ8eFSsZa7axcRe2Ef1MAjuNzJqTGwyfP8w0nFXoeSoGNKrg0Iapf72WJ76VVCHa2kjz
 lshOc09htrwoJagTae2P1AHtVEfwxktaBzmtig7pkTXwjAJMbSKjlnhSSIlo5H5GSj2JgqiMS
 Rp/+R/8zy93WcqhusPZIiE1w1zWSPRXZ+DBIzWP0pDbl8PH6AgOAHOg+4uu7I8zrRQjGt9wCM
 MJoiRMYeu0g0SkWwPrWj0yLFjI1xMWnIAnr9oPdLNiFj3qX3qUYpGR1jMW76EaDsnaMfWkABk
 QrAuOpY7PAlh4jBGaZAHAR5uwcTKanKYmvA3jlp4DmXKkZTgXWuuNbGw0sHZLexN0B5SgDvTB
 fmgh4ZA8whbYYQWwsxwtizgJUBgrafdGCBbJF66oc9tu0UDFQ0D/N7mzsvpMtdsFPcSZMk0qJ
 E7GvW0bv5W9uItI4wo5emFp/vbKAT9HqkZYehLB7CKZ0cU0aJlJb421EnPTPp6DtzX+DvNnlM
 FAuPREbm4seSQGaCsKbTCpOQLf57DDsyWRbXuTHiZZ4VJ4x63+1aBeRu3hIDzZGtX0XlekRbJ
 sl895J+v4M+38WsONXC1+JrhvYKjatEXR0IUDPB+XW19nqbKmxWxZC0KbQjD//kgcfkXcHaNz
 8lctTcmdZS+rAr+FeqmYKLkrSOdq7P3ha3155XvMOUWT1dnwnUIOhuk12f3lbekE+EmOw37mh
 qGIADyS8iZj5Vx9nLz3hZ8a9RSgcsHIx1QzkFyC0bZUTd5BpIYt9J0y5kEMQ4bDHaU+HiraUa
 gOeSQux
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We previously relied on the localized versions of

	# This is a combination of <N> commits

(which we write into the commit messages during fixup/squash chains)
to contain <N> encoded in ASCII.

This is not true in general, and certainly not true when compiled with
GETTEXT_POISON=TryToKillMe, as demonstrated by the regression test we
just introduced in t3418.

So let's decouple keeping track of the count from the (localized) commit
messages by introducing a new file called 'current-fixups' that keeps
track of the current fixup/squash chain. This file contains a bit more
than just the count (it contains a list of "fixup <commit>"/"squash
<commit>" lines). This is done on purpose, as it will come in handy for
a fix for the bug where `git rebase --skip` on a final fixup/squash will
leave the commit message in limbo.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 78 ++++++++++++++++++++++++++++++-----------------------
 sequencer.h |  6 ++++-
 2 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5e3a50fafc9..d2e6f33023d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -74,13 +74,6 @@ static GIT_PATH_FUNC(rebase_path_message, "rebase-merge/message")
  * previous commit and from the first squash/fixup commit are written
  * to it. The commit message for each subsequent squash/fixup commit
  * is appended to the file as it is processed.
- *
- * The first line of the file is of the form
- *     # This is a combination of $count commits.
- * where $count is the number of commits whose messages have been
- * written to the file so far (including the initial "pick" commit).
- * Each time that a commit message is processed, this line is read and
- * updated. It is deleted just before the combined commit is made.
  */
 static GIT_PATH_FUNC(rebase_path_squash_msg, "rebase-merge/message-squash")
 /*
@@ -91,6 +84,11 @@ static GIT_PATH_FUNC(rebase_path_squash_msg, "rebase-merge/message-squash")
  * commit without opening the editor.)
  */
 static GIT_PATH_FUNC(rebase_path_fixup_msg, "rebase-merge/message-fixup")
+/*
+ * This file contains the list fixup/squash commands that have been
+ * accumulated into message-fixup or message-squash so far.
+ */
+static GIT_PATH_FUNC(rebase_path_current_fixups, "rebase-merge/current-fixups")
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
  * GIT_AUTHOR_DATE that will be used for the commit that is currently
@@ -253,6 +251,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 	for (i = 0; i < opts->xopts_nr; i++)
 		free(opts->xopts[i]);
 	free(opts->xopts);
+	strbuf_release(&opts->current_fixups);
 
 	strbuf_addstr(&dir, get_dir(opts));
 	remove_dir_recursively(&dir, 0);
@@ -1329,34 +1328,23 @@ static int update_squash_messages(enum todo_command command,
 		struct commit *commit, struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int count, res;
+	int res;
 	const char *message, *body;
 
-	if (file_exists(rebase_path_squash_msg())) {
+	if (opts->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
-		char *eol, *p;
+		char *eol;
 
-		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
+		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 9) <= 0)
 			return error(_("could not read '%s'"),
 				rebase_path_squash_msg());
 
-		p = buf.buf + 1;
-		eol = strchrnul(buf.buf, '\n');
-		if (buf.buf[0] != comment_line_char ||
-		    (p += strcspn(p, "0123456789\n")) == eol)
-			return error(_("unexpected 1st line of squash message:"
-				       "\n\n\t%.*s"),
-				     (int)(eol - buf.buf), buf.buf);
-		count = strtol(p, NULL, 10);
-
-		if (count < 1)
-			return error(_("invalid 1st line of squash message:\n"
-				       "\n\t%.*s"),
-				     (int)(eol - buf.buf), buf.buf);
+		eol = buf.buf[0] != comment_line_char ?
+			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header,
-			    _("This is a combination of %d commits."), ++count);
+		strbuf_addf(&header, _("This is a combination of %d commits."),
+			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 	} else {
@@ -1379,10 +1367,8 @@ static int update_squash_messages(enum todo_command command,
 				     rebase_path_fixup_msg());
 		}
 
-		count = 2;
 		strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is a combination of %d commits."),
-			    count);
+		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addstr(&buf, _("This is the 1st commit message:"));
 		strbuf_addstr(&buf, "\n\n");
@@ -1399,13 +1385,14 @@ static int update_squash_messages(enum todo_command command,
 	if (command == TODO_SQUASH) {
 		unlink(rebase_path_fixup_msg());
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is the commit message #%d:"), count);
+		strbuf_addf(&buf, _("This is the commit message #%d:"),
+			    ++opts->current_fixup_count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-			    count);
+			    ++opts->current_fixup_count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
@@ -1414,6 +1401,17 @@ static int update_squash_messages(enum todo_command command,
 
 	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
 	strbuf_release(&buf);
+
+	if (!res) {
+		strbuf_addf(&opts->current_fixups, "%s%s %s",
+			    opts->current_fixups.len ? "\n" : "",
+			    command_to_string(command),
+			    oid_to_hex(&commit->object.oid));
+		res = write_message(opts->current_fixups.buf,
+				    opts->current_fixups.len,
+				    rebase_path_current_fixups(), 0);
+	}
+
 	return res;
 }
 
@@ -1676,6 +1674,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	if (!res && final_fixup) {
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
+		unlink(rebase_path_current_fixups());
+		strbuf_reset(&opts->current_fixups);
+		opts->current_fixup_count = 0;
 	}
 
 leave:
@@ -2052,6 +2053,16 @@ static int read_populate_opts(struct replay_opts *opts)
 		read_strategy_opts(opts, &buf);
 		strbuf_release(&buf);
 
+		if (read_oneliner(&opts->current_fixups,
+				  rebase_path_current_fixups(), 1)) {
+			const char *p = opts->current_fixups.buf;
+			opts->current_fixup_count = 1;
+			while ((p = strchr(p, '\n'))) {
+				opts->current_fixup_count++;
+				p++;
+			}
+		}
+
 		return 0;
 	}
 
@@ -2398,10 +2409,9 @@ static int error_with_patch(struct commit *commit,
 static int error_failed_squash(struct commit *commit,
 	struct replay_opts *opts, int subject_len, const char *subject)
 {
-	if (rename(rebase_path_squash_msg(), rebase_path_message()))
-		return error(_("could not rename '%s' to '%s'"),
+	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
+		return error(_("could not copy '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
-	unlink(rebase_path_fixup_msg());
 	unlink(git_path_merge_msg());
 	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
diff --git a/sequencer.h b/sequencer.h
index e45b178dfc4..1898158c52d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,10 +44,14 @@ struct replay_opts {
 	char **xopts;
 	size_t xopts_nr, xopts_alloc;
 
+	/* Used by fixup/squash */
+	struct strbuf current_fixups;
+	int current_fixup_count;
+
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
-#define REPLAY_OPTS_INIT { -1 }
+#define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
-- 
2.17.0.windows.1.33.gfcbb1fa0445


