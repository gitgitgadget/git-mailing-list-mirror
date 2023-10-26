Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4E3E488
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="xyDJYUvx"
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F61B4
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:45 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-586ad15f9aaso593477eaf.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360405; x=1698965205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuOo59OigsBMXEvYkxbmw8PjDWl6n5fyljau8ya574Q=;
        b=xyDJYUvxlvBZrMK5gTso5u3PERgJMwhg0Q353OMtA529zcLZTiCgYBbTplJM6YWo/q
         VSRUn/b4d/+QRexTYdDLy7QZJJEQta0CtlZjT2L1cve1rb3eQ9GAHamxRaPukWcYFn0T
         0F7emWYl44AUGvaQXx8aWS4iloQS7fcmmKWpjHJomuEmdqOLMs9IIWNc7jaonsg41iDu
         rI/fo0zOPOnYkuUY1ifGxPj/Z5xEYnYYqER/JNA3mW75gOzqHXOIgIPt/TkprRqPQ4VP
         QulIbSR1R9km33/G0ZSzm9y6ipkANHqu+RdZQWnpxNu8AaevnrcMsUeZYIZ5clOuKuZp
         oUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360405; x=1698965205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuOo59OigsBMXEvYkxbmw8PjDWl6n5fyljau8ya574Q=;
        b=KnXoetm3ZQwJIRwJO3k3lsmMrd6D7cCHjY/7C42XqV1aPGy3roeANWWA+CZcVedY96
         nrU/BGMyXzhFWOjsdDxF3MPhoYSOmd94k2DohuB2ZJVRbafvur8S7kQqr0inch9CE3es
         A642KjixzjcZAxJ7o0mObXWprZOlLjIldz9HP39/y1Q2EDV2CJ/ze+F8JQaL6rKK+IF/
         hB2CBbfYADYZIMg87jdrwvOi/zypBDzUq73D7FQmrAAmpHHdwKqiVBVFjzxfEgeEFyDo
         N55LXdK/3Zbc8iylYe7Hjsgf4gyx5jgBHGgi+2Q+tjrVehb51SUkL/wVn6vUOT060pHP
         n8bg==
X-Gm-Message-State: AOJu0YwGSjkbf2bM2OsY3t6xxc0ZjUt8MKm9wnlvVu7owRNegSMpTGaa
	Vc9pEBUlLoBA0n2IXWoI0PWfVBNxhlfneikbIaU=
X-Google-Smtp-Source: AGHT+IHCcX9W8F0qo9Kx/gMFQUxLUPTLrPLsKDTA0XCNleRWWEEsuGInFbX8ziuOPzXmNSQ7qQ4ldA==
X-Received: by 2002:a05:6358:903:b0:168:eded:d6c9 with SMTP id r3-20020a056358090300b00168ededd6c9mr1393532rwi.29.1698360404883;
        Thu, 26 Oct 2023 15:46:44 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:44 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH v2 4/6] add: set unique color for noob mode arrows
Date: Thu, 26 Oct 2023 15:46:13 -0700
Message-ID: <20231026224615.675172-5-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.404.g2bcc23f3db
In-Reply-To: <20231026224615.675172-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 table.c     | 64 +++++++++++++++++++++++++++++++----------------------
 wt-status.c |  1 +
 wt-status.h |  1 +
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/table.c b/table.c
index 527e38c07d..d29b311440 100644
--- a/table.c
+++ b/table.c
@@ -5,6 +5,7 @@
 #include "wt-status.h"
 #include "config.h"
 #include "string-list.h"
+#include "color.h"
 #include "sys/ioctl.h"
 
 static const char *color(int slot, struct wt_status *s)
@@ -26,7 +27,7 @@ static void build_table_border(struct strbuf *buf, int cols)
 static void build_table_entry(struct strbuf *buf, char *entry, int cols)
 {
 	int len = strlen(entry);
-	size_t col_width = (cols / 3) - 5; /* subtract for padding */
+	size_t col_width = (cols / 3) - 9; /* subtract for padding */
 
 	strbuf_reset(buf);
 
@@ -65,52 +66,51 @@ static void build_table_entry(struct strbuf *buf, char *entry, int cols)
 		strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2);
 }
 
-static void add_arrow_to_entry(struct strbuf *buf, int add_after_entry)
+static void build_arrow(struct strbuf *buf, struct strbuf* arrow, int add_after_entry)
 {
 	struct strbuf empty = STRBUF_INIT;
 	struct strbuf trimmed = STRBUF_INIT;
-	struct strbuf holder = STRBUF_INIT;
 	int len = strlen(buf->buf);
 
+	strbuf_reset(arrow);
 	strbuf_addstr(&trimmed, buf->buf);
 	strbuf_trim(&trimmed);
 
 	if (!strbuf_cmp(&trimmed, &empty) && !add_after_entry) {
 		strbuf_reset(buf);
-		strbuf_addchars(buf, '-', len + 1);
+		strbuf_addchars(arrow, '-', len + 1);
 	} else if (add_after_entry) {
 		strbuf_rtrim(buf);
-		strbuf_addchars(buf, ' ', 1);
-		strbuf_addchars(buf, '-', len - strlen(buf->buf) + 1);
+		strbuf_addchars(arrow, ' ', 1);
+		strbuf_addchars(arrow, '-', len - strlen(buf->buf) + 1);
 	} else if (!add_after_entry) {
 		strbuf_ltrim(buf);
-		strbuf_addchars(&holder, '-', len - strlen(buf->buf) - 2);
-		strbuf_addchars(&holder, '>', 1);
-		strbuf_addchars(&holder, ' ', 1);
-		strbuf_addstr(&holder, buf->buf);
-		strbuf_reset(buf);
-		strbuf_addstr(buf, holder.buf);
+		strbuf_addchars(arrow, '-', len - strlen(buf->buf) - 3);
+		strbuf_addchars(arrow, '>', 1);
+		strbuf_addchars(arrow, ' ', 1);
 	}
 }
 
-static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s, int hide_pipe)
+static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct strbuf *arrow1, struct strbuf *arrow2, struct strbuf *arrow3, struct wt_status *s, int hide_pipe)
 {
 	printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
+	if (strlen(arrow1->buf) > 0)
+		color_fprintf(s->fp, color(WT_STATUS_ARROW, s), "%s", arrow1->buf);
 	if (hide_pipe != 1 && hide_pipe != 3)
 		printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
+	if (strlen(arrow2->buf) > 0)
+		color_fprintf(s->fp, color(WT_STATUS_ARROW, s), "%s", arrow2->buf);
 	if (hide_pipe != 2 && hide_pipe != 3)
 		printf(_("|"));
+	if (strlen(arrow3->buf) > 0) {
+		color_fprintf(s->fp, color(WT_STATUS_ARROW, s), "%s", arrow3->buf);
+	}
 	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
 	printf(_("|\n"));
 }
 
-static void print_table_body_line_(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
-{
-	print_table_body_line(buf1, buf2, buf3, s, 0);
-}
-
 void print_noob_status(struct wt_status *s, int advice)
 {
 	struct winsize w;
@@ -119,6 +119,9 @@ void print_noob_status(struct wt_status *s, int advice)
 	struct strbuf table_col_entry_1 = STRBUF_INIT;
 	struct strbuf table_col_entry_2 = STRBUF_INIT;
 	struct strbuf table_col_entry_3 = STRBUF_INIT;
+	struct strbuf arrow_1 = STRBUF_INIT;
+	struct strbuf arrow_2 = STRBUF_INIT;
+	struct strbuf arrow_3 = STRBUF_INIT;
 	struct string_list_item *item, *item2;
 
 	/* Get terminal width */
@@ -170,17 +173,21 @@ void print_noob_status(struct wt_status *s, int advice)
 			strbuf_addstr(&buf_2, item2->string);
 			if (!strbuf_cmp(&buf_1, &buf_2)) {
 				build_table_entry(&table_col_entry_3, buf_1.buf, cols);
-				add_arrow_to_entry(&table_col_entry_1, 1);
-				add_arrow_to_entry(&table_col_entry_2, 0);
-				add_arrow_to_entry(&table_col_entry_3, 0);
+				build_arrow(&table_col_entry_1, &arrow_1, 1);
+				build_arrow(&table_col_entry_2, &arrow_2, 0);
+				build_arrow(&table_col_entry_3, &arrow_3, 0);
 				is_arrow = 1;
 			}
 		}
 
 		if (!is_arrow)
-			print_table_body_line_(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, &arrow_1, &arrow_2, &arrow_3, s, 0);
 		else
-			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s, 3);
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, &arrow_1, &arrow_2, &arrow_3, s, 3);
+
+		strbuf_reset(&arrow_1);
+		strbuf_reset(&arrow_2);
+		strbuf_reset(&arrow_3);
 	}
 
 	for_each_string_list_item(item, &s->change) {
@@ -203,8 +210,8 @@ void print_noob_status(struct wt_status *s, int advice)
 				strbuf_addstr(&buf_2, item2->string);
 				if (!strbuf_cmp(&buf_1, &buf_2)) {
 					build_table_entry(&table_col_entry_3, buf_1.buf, cols);
-					add_arrow_to_entry(&table_col_entry_2, 1);
-					add_arrow_to_entry(&table_col_entry_3, 0);
+					build_arrow(&table_col_entry_2, &arrow_2, 1);
+					build_arrow(&table_col_entry_3, &arrow_3, 0);
 					is_arrow = 1;
 				}
 			}
@@ -215,9 +222,12 @@ void print_noob_status(struct wt_status *s, int advice)
 		}
 
 		if (!is_arrow)
-			print_table_body_line_(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, &arrow_1, &arrow_2, &arrow_3, s, 0);
 		else
-			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s, 2);
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, &arrow_1, &arrow_2, &arrow_3, s, 2);
+		strbuf_reset(&arrow_1);
+		strbuf_reset(&arrow_2);
+		strbuf_reset(&arrow_3);
 	}
 	
 	if (!s->untracked.nr && !s->change.nr) {
diff --git a/wt-status.c b/wt-status.c
index 969f79f441..1332d07dba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -49,6 +49,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
+	GIT_COLOR_CYAN,   /* WT_STATUS_ARROW */
 };
 
 static const char *color(int slot, struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 64551f3a75..7b883fd476 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -19,6 +19,7 @@ enum color_wt_status {
 	WT_STATUS_LOCAL_BRANCH,
 	WT_STATUS_REMOTE_BRANCH,
 	WT_STATUS_ONBRANCH,
+	WT_STATUS_ARROW,
 	WT_STATUS_MAXSLOT
 };
 
-- 
2.42.0.404.g2bcc23f3db

