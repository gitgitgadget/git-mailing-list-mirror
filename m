Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E7C1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAWU7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34041 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfAWU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so4159601wrp.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQuBbgxTdhepmfIatQ3mgqhjkKwSXtfG4dYMHMULmQI=;
        b=vDbsmt+ZsXFmEbwJFJENTWytF/JyvLl0MUSp3x39uUXxw+GeC6qzWNm8ly20KFQ5EE
         OFCIAKXyzhrUqHhFjxpNvLofdhU8mgmXoBiRZke9gJ82a3zYlTTh+ZtZaihtaa5y/z8C
         8hEKinZVnGCSHusgyJ9QM/uRRayU2H417ZlWDruaE1J0evoIRfEY2rxALQzrma2S2G72
         6sA8UQHPIstB84jDH7CHNnMg16H4sTtapHcxeY5QZbVUyZAOWLjPBasCYdkSXDRwbKcb
         RyhfwR6VLnaDtq0SgHINYaYPCoZPy/xusTTumvtnhOoEYb/kEKaQU9SsX5GrHsH4LGDk
         LYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQuBbgxTdhepmfIatQ3mgqhjkKwSXtfG4dYMHMULmQI=;
        b=tacNAt46qRhpvuTeXnXA5RzvJ20VwkK8if4019cohrzmuysgyhvgkXgcwR9lxvYfab
         6Ob49JOt1CwEJcesLFLoxGH64jLj33jLq7NRfxEDutlsTmEpFuhW+4unRYaUrgFXfDT6
         72L6z5tkGsPz4acJvkROJqQT9fsaoBpczznfzVxuSX9GDugcaLRO0Jhc4aePFursy69s
         9XgPEAPsQLie0geQwpVV264CQJtyNE3ZmoHhUL8HQoIqFkV/dpGvGArAOI4xik9590RY
         wniSmYEl1WfowlDxfCvQNSNL/Gemhqf6xpQDxTrKHpEVStDEsVVPZzTeKLT9SVzlThlo
         aufQ==
X-Gm-Message-State: AJcUukev1Pnu+qZz1g1zc1MEfmIr2PjEVSgD+LxlJIVRg+mBZE97bpDZ
        a5W5qdLNhhA3Im24YTemDp0gJ8Vg
X-Google-Smtp-Source: ALg8bN4Pr/Pli6Eymci4+CB94gyd2D2EsO00H8RGQ0oy8qmHH6xG0qPBtsZgjQc2UXhAa2/c0u8Ggg==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr4598069wrr.326.1548277180473;
        Wed, 23 Jan 2019 12:59:40 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:39 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 13/16] rebase-interactive: append_todo_help() changes
Date:   Wed, 23 Jan 2019 21:58:18 +0100
Message-Id: <20190123205821.27459-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
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
index d8d045067c..92de982bc4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4580,22 +4580,13 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
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

