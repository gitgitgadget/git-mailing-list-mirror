Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E482208BE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="hMO8PUZb"
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587E114
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-27e1eea2f0dso423150a91.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697827197; x=1698431997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Svq8NxQV/OT0dUN7+ij2gVZXDdztRgBFcT6CDxcaC0w=;
        b=hMO8PUZbgrCKFxPyQcNWweqlQ+KVESGj1u9XXJs2ZAYnHtM4YiJXrcTLqLzuGl1cMs
         CvYiloxcFNEnPaVOJ//NoqEDRFuLlX/uIofF2lVR2PPdLnzwhsWM5pCeMDVoCIGo8ECD
         BR/vVgqyOepbYa412CLOxkYYRDED5sYd0p7J9uYeNuTlFlud3dyomf6RpauXiqb5y5IT
         50i1pFU3Z4+yeBEYmdSb4m4ErId7gcqdCBdhfmbJqzVhnSLHOSsjast5SvknEMuqgk1C
         zrcS3HUrPI6bWhhtumtJLME3b/C9r9dpvWHgyywCmX3tvV3LDVbPHuMTLGwRne9dIiVt
         Ih/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827197; x=1698431997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Svq8NxQV/OT0dUN7+ij2gVZXDdztRgBFcT6CDxcaC0w=;
        b=vKzg6n2OU02PmnwLlS7/+5zvPzMAI8k5t2ClKzPxr88GAgxel4ynuAhgFPSrj4HBEA
         SaRA25XF9tQ50H4X7JRnwB67A4i+wVKRKVo9BeI12WwuMfhgjOrhO3D4z9ptFfWM7JuX
         HILTecX0QDVPIvPp5WFu66mudWIiasaFIB30Bm00ORe6GVMbZw2oHkZAvIeGnzyKblN9
         roVD+wWpr6nb3/HT18Xwy/tUuCe3jTpN7cyU2HaL/SZTHE/Xv+DfAQHz8SZqkg2iJWwk
         83FrNFgRvKagy2uXSduiSMpMC2UPHBn6JEFZ0grnYVAQZ/epI8TK60wrpAF19YZ1AUYk
         awTQ==
X-Gm-Message-State: AOJu0YxRBS1uYt8O5a34hZpQsTW/B8V1DYfoS9QWj7U1IQ1HUMaYduTn
	vkpfF/uYEz81/6usLsJqqn3F8RGrsXbeSL5OMS3GIRQnntLhYg==
X-Google-Smtp-Source: AGHT+IGxkUhl+tm8J6xawrU1GKE2eM84xv+GpNf6yAqeBUs9XfkFfo+T9cNqfcuUgq6Rm1M//kbEjw==
X-Received: by 2002:a17:90a:54:b0:27d:2dde:597a with SMTP id 20-20020a17090a005400b0027d2dde597amr2840638pjb.10.1697827197388;
        Fri, 20 Oct 2023 11:39:57 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-46-176.mycingular.net. [166.170.46.176])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b0027e022bd62fsm2994353pji.5.2023.10.20.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:57 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH 5/5] add: set unique color for -t, --table arrows
Date: Fri, 20 Oct 2023 11:39:47 -0700
Message-ID: <20231020183947.463882-6-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.402.gbe8243af7b.dirty
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 table.c     | 62 +++++++++++++++++++++++++++++++----------------------
 wt-status.c |  1 +
 wt-status.h |  1 +
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/table.c b/table.c
index a6fc660fec..390b2e2dd9 100644
--- a/table.c
+++ b/table.c
@@ -5,6 +5,7 @@
 #include "wt-status.h"
 #include "config.h"
 #include "string-list.h"
+#include "color.h"
 #include "sys/ioctl.h"
 
 static const char *color(int slot, struct wt_status *s)
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
 void build_and_draw_status_table(struct wt_status *s, int advice)
 {
 	struct winsize w;
@@ -119,6 +119,9 @@ void build_and_draw_status_table(struct wt_status *s, int advice)
 	struct strbuf table_col_entry_1 = STRBUF_INIT;
 	struct strbuf table_col_entry_2 = STRBUF_INIT;
 	struct strbuf table_col_entry_3 = STRBUF_INIT;
+	struct strbuf arrow_1 = STRBUF_INIT;
+	struct strbuf arrow_2 = STRBUF_INIT;
+	struct strbuf arrow_3 = STRBUF_INIT;
 	struct string_list_item *item, *item2;
 
 	/* Get terminal width */
@@ -170,17 +173,21 @@ void build_and_draw_status_table(struct wt_status *s, int advice)
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
@@ -203,8 +210,8 @@ void build_and_draw_status_table(struct wt_status *s, int advice)
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
@@ -215,9 +222,12 @@ void build_and_draw_status_table(struct wt_status *s, int advice)
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
index 975cfc01a5..fe38260baa 100644
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
index 5d29c058c1..0517f81e1b 100644
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
2.42.0.402.gbe8243af7b.dirty

