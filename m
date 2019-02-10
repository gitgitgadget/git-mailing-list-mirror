Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD181F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBJN11 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33005 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfBJN1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so11716874wmb.0
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NiKZSwkto6M1ls6y+aDFk+4AOBgwy95xYvdIeZeTIs=;
        b=WGg3EEqwG0uzf3G6LP7RTQNghS7D0FNvJ4zK0hZ4qpk6YT2YXAd7zfj7q7awoyAIoL
         Mxe5JRTBAJgr3MOUdI18whNhwzfu33H3b4Q05uszj88783adLANylRIDpdZU6WTyq3+a
         Xfo5hKL3mabXVGTYEzQ9NyI8SxOqtuO5UDN2YN97IbIjqJFrUzGLMWTZWTNXNTZPreio
         +1XQIkBmH8bI8VEAZLC2q4vbU8KX2057GG77G5VZznRcf8W3a5L/IlvCgjr0vBDBLa4f
         SwWJjbZKq/eO6xWuO0VByIPPtooXNkV/4IoqO2Nr2z0p2glZ2PosoFSuaRKIAEdkhd1v
         rHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NiKZSwkto6M1ls6y+aDFk+4AOBgwy95xYvdIeZeTIs=;
        b=DPntfQU92woIo1FTC2Dl+04BbylXlH39lHNDMhGoDXd+Kk5tW2URRpAgWl8RPRdgVn
         O5cv7VrDzoIIA4RiGivom2Kx+DQAvwzCl5S0X+eoNZSPxKzug+Cp1naSy0RbAGL3RV+M
         YuWQc8YFiSuCuZJGQjlfxl8wZTndew8QT4+jZnWci171B8Kclcc17iIIsbKEnsAR9XgL
         v+KFz1KvpoDkTY+MwwzQxACxosrwpGNreBAzP9uISesvs4ESM1WRCGJ2LJcua/2dutRh
         fAODptQ05H/H9+ep9FdzGY58MfGmCdAdDT9tEk/mJD8Ie4bbcXyEXimxyuh+iIxQbeXw
         tX1g==
X-Gm-Message-State: AHQUAuYM4V7vzNEbVYCMaLqrn70srR3JR1llMgOZcCvJnOaF2tOkIMqQ
        SNFYJvWnXYsAtYrmeCN2r0TJ8M/c
X-Google-Smtp-Source: AHgI3IZljCcayND1MWzeDog4MUYLE7ozqSHX/hkU/WioQYsTxYCK+B/e6NPuQi298ca5TCo6YIJmSw==
X-Received: by 2002:a1c:22c5:: with SMTP id i188mr5741236wmi.39.1549805241929;
        Sun, 10 Feb 2019 05:27:21 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:21 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 13/16] rebase-interactive: append_todo_help() changes
Date:   Sun, 10 Feb 2019 14:26:45 +0100
Message-Id: <20190210132648.12821-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
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
No changes since v6.

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
index 74fbb14153..64d698032c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4636,22 +4636,13 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
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

