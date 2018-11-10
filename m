Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098431F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeKJPdb (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44598 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeKJPda (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so2815236lfe.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyEo3d97wQuMdDhBA+d61nOsv0ybVhKBjv6wkamxKpE=;
        b=DAiLp60zolsmp7cHyfGm6WZ5nKpTcGdQ9vJmNrE1GyXiFUk0vbwnr9LycUDfvitHXp
         HhmkEuvKc/gqM+0y1CRo46hv8MJrCU/x8aQI5aRddDnHmgQqn99Hhj7EXWAyM7frB3L3
         EBlUshy+j/jsZRe74kmAFhDvnCmUr11n1XN52uSoG4pGhXYUKMOgjmZAzXw7S804x8fr
         p5Uem5197oJlEBMNoghm5WITEK0Z70RzejnroQpvDO6yIggLBDmtZ+gcA2HNOx4w4uFp
         TDk28HT8g6AaxCxvQh7ylFSEolct5pzVLe6m7H84gLFeFXeDF6WfCR5qmsx7EQNOWveg
         OlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyEo3d97wQuMdDhBA+d61nOsv0ybVhKBjv6wkamxKpE=;
        b=C4uWK9aOrzeU7G4XTEPEyo7gLLWGOFRH4UyZHu3+5YUPubnQME2w8aN9MHUwuz3+Y3
         klc1CfG36BeExmdnJ7mEUrg0A2x1VYj3RHCfAx6bQCMDWGLXSLaDU6g/YIqBwCBQ3YRE
         WL42VWkwXE0WjAJgg/09vNqvVy0fYfyk2SnplWAJ1RWz3/1S/eMyZXOsOT2UTjBJ29dK
         dePbJamX81INciA+semwwoc4GUOTqYvxQgTZIeeHjNOnBaxwn35Z7nmB+uRbdaIL8S0r
         ggE6nz50FianYU89pUyRvDUbMC8mImJr5XxtqXxVNfNRFBjT3O3EPuGvSQ8zPBppLRte
         DpaQ==
X-Gm-Message-State: AGRZ1gIdv0ejZFvqwitdfTqJdqRO0oUWGjXEqbn3HgZv1H5WHE3F1Mxe
        CX/IBdtiRiYGoVgpi/1gM6tAtlmp
X-Google-Smtp-Source: AJdET5fTanSraDF6LAG4nvLuXjALt/gaw6CcctCHq4nfItJ6BV6mXwxSr9xSMXIE9h9OtUYSvaGhfg==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr6659433lfe.154.1541828983366;
        Fri, 09 Nov 2018 21:49:43 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:42 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 22/22] rebase-interactive.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:10 +0100
Message-Id: <20181110054910.10568-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there add a forward declaration for struct strbuf.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase--interactive.c | 2 +-
 rebase-interactive.c          | 6 +++---
 rebase-interactive.h          | 5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index bd7d39e2af..dd2a55ab1d 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -240,7 +240,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(flags);
+		ret = edit_todo_list(the_repository, flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3cc19283ff..68aff1dac2 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -53,7 +53,7 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 	}
 }
 
-int edit_todo_list(unsigned flags)
+int edit_todo_list(struct repository *r, unsigned flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *todo_file = rebase_path_todo();
@@ -69,7 +69,7 @@ int edit_todo_list(unsigned flags)
 
 	strbuf_release(&buf);
 
-	transform_todos(the_repository, flags | TODO_LIST_SHORTEN_IDS);
+	transform_todos(r, flags | TODO_LIST_SHORTEN_IDS);
 
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
@@ -85,7 +85,7 @@ int edit_todo_list(unsigned flags)
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
 
-	transform_todos(the_repository, flags & ~(TODO_LIST_SHORTEN_IDS));
+	transform_todos(r, flags & ~(TODO_LIST_SHORTEN_IDS));
 
 	return 0;
 }
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 971da03776..17b6c9f6d0 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -1,8 +1,11 @@
 #ifndef REBASE_INTERACTIVE_H
 #define REBASE_INTERACTIVE_H
 
+struct strbuf;
+struct repository;
+
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf);
-int edit_todo_list(unsigned flags);
+int edit_todo_list(struct repository *r, unsigned flags);
 
 #endif
-- 
2.19.1.1231.g84aef82467

