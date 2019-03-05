Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B12A20248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCETS4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfCETSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so10751591wrw.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ussKeisM82eX7ZmcIN6IMqpXj6Naqim7vG7tq13QVuA=;
        b=BYk0r9RYblWsisd9P9mNYrAnsupkCK8HD+viy45yB9ybAbvZnI3WDS3QwWAkahn7YT
         6xvNnhZV/Y7RDkyZZN6VxTV0qcONubZWZc/mkJo7ORGwPv5abNkyS56lZ9cCeIkTzBsP
         Cp56bYUp2gD6zrL069H2fFelvE3CGF54aIl4zJ2UJ11RFLgoxVOO7zMGoWSgkXSEvem+
         Jqfh7y9BDX4eSHR7IlYR1zpa2Fv0HCjWJ+1lLTIeWYQFGBpyBvIeSOY60SrRwtTj6WF0
         2+IFBUcDmNfbSsHA3OJNzQY0SMZgNNXpebH+dm+k+a97FAenANTBgBk3aTrcwJ8YECcP
         lklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ussKeisM82eX7ZmcIN6IMqpXj6Naqim7vG7tq13QVuA=;
        b=t1g/HEiaVwMJKq5dAI2Y1TPZVdHgeLvhIanV2hMyGtfLWNrSZSSssZbJRBpp1BG8w4
         V7GNkvB05V8467DrGuM+ekY1fcOgUsyUSejm2pI7h2lWVwbW0XApOhgrJpaMyiRO9dcY
         eBu2dYI/cTEJ2/6a/oBVsmQ+JMh+Dpkc1YjENd3kuXFq0wYOUahg46tsMSYSxxVOspp7
         OZ10ILJlLs4OAuPeJYFAprihW6yrqLSycg2OJ4X/9G5T4I0xI9Mzb4e2rbjtTqgoorCq
         d8gEOxPXlriYu/GeDq16CIWgD+6ZO0kExzEGcHT45ClgqlPtEUjcgSmuE44Koy5uNK6g
         mmdA==
X-Gm-Message-State: APjAAAUVjKFK60LjT28y7BvMNArwDQMJmxR7eSLzg0NdY+DvPpWiMGNz
        QEfWxfjheGiQkGOaQnjhwN3U19o8
X-Google-Smtp-Source: APXvYqynvvvBTrcV3gTNVN41x9qpmwUHIDlmxHs7uJgJFFEK5Ioc0dngFUskzc3jeZif0WZh1lxkzQ==
X-Received: by 2002:adf:8061:: with SMTP id 88mr288206wrk.77.1551813532739;
        Tue, 05 Mar 2019 11:18:52 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:52 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 15/18] rebase-interactive: append_todo_help() changes
Date:   Tue,  5 Mar 2019 20:18:02 +0100
Message-Id: <20190305191805.13561-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the writing of the comment "Rebase $shortrevisions onto
$shortonto ($command_count commands)" from todo_list_write_to_file() to
append_todo_help().

shortrevisions, shortonto, and command_count are passed as parameters to
append_todo_help().

During the initial edit of the todo list, shortrevisions and shortonto
are not NULL.  Therefore, if shortrevisions or shortonto is NULL, then
edit_todo would be true, otherwise it would be false.  Thus, edit_todo
is removed from the parameters of append_todo_help().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 rebase-interactive.c | 12 +++++++++++-
 rebase-interactive.h |  3 ++-
 sequencer.c          | 17 ++++-------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index d396ecc599..807f8370db 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -28,7 +28,8 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 	return MISSING_COMMIT_CHECK_IGNORE;
 }
 
-void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+void append_todo_help(unsigned keep_empty, int command_count,
+		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf)
 {
 	const char *msg = _("\nCommands:\n"
@@ -48,6 +49,15 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 ".       specified). Use -c <commit> to reword the commit message.\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
+	unsigned edit_todo = !(shortrevisions && shortonto);
+
+	if (!edit_todo) {
+		strbuf_addch(buf, '\n');
+		strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
+					      "Rebase %s onto %s (%d commands)",
+					      command_count),
+				      shortrevisions, shortonto, command_count);
+	}
 
 	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 187b5032d6..0e5925e3aa 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -5,7 +5,8 @@ struct strbuf;
 struct repository;
 struct todo_list;
 
-void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+void append_todo_help(unsigned keep_empty, int command_count,
+		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
diff --git a/sequencer.c b/sequencer.c
index b7289c93d4..8f3836c479 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4619,22 +4619,13 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
 			    const char *shortonto, int num, unsigned flags)
 {
-	int edit_todo = !(shortrevisions && shortonto), res;
+	int res;
 	struct strbuf buf = STRBUF_INIT;
 
 	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
-
-	if (flags & TODO_LIST_APPEND_TODO_HELP) {
-		int command_count = count_commands(todo_list);
-		if (!edit_todo) {
-			strbuf_addch(&buf, '\n');
-			strbuf_commented_addf(&buf, Q_("Rebase %s onto %s (%d command)",
-						       "Rebase %s onto %s (%d commands)",
-						       command_count),
-					      shortrevisions, shortonto, command_count);
-		}
-		append_todo_help(edit_todo, flags & TODO_LIST_KEEP_EMPTY, &buf);
-	}
+	if (flags & TODO_LIST_APPEND_TODO_HELP)
+		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, count_commands(todo_list),
+				 shortrevisions, shortonto, &buf);
 
 	res = write_message(buf.buf, buf.len, file, 0);
 	strbuf_release(&buf);
-- 
2.20.1

