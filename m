Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52D71F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeKJPdb (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:31 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40175 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbeKJPd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so2831412lfe.7
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv5iZSGv0Hvdh5Dmc7r+znF1VXqOaKwH08pwampdoQI=;
        b=MJKqpqtWnwZVsSzXsq6Lh+QKTt1EMotgwH3Lpzza7ZYKnrFey//ySQm63OnYV1tQPy
         xxRDWZC/ZypeoRPas3Fzv4h1zayeRYvLZcObd8Ih5BJxyDW+Hara65ovLySJGLvtE+Ze
         QwN3tiMWJc6SXIdx+EAxmHbY0K+MquxF7t0kyR44YhKtvzomDZPnwHm4jxC8LqlzeyiG
         ZyxIXrAu8NM2pWttH2AdZOHE4PnXTRBKNNT3W4iufFRpatF093kT2dgCjiSWbdQ6NoSz
         AsiFNd5tBqS59tthKFsMhqrZIXpVsIG0ITeKYKNnNcbnseKzCJidi7e6ZiwpZpTpiBPg
         Slsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uv5iZSGv0Hvdh5Dmc7r+znF1VXqOaKwH08pwampdoQI=;
        b=suXiQtxGjkviHIBqAj+q5XxPOv/aTe++hUYA1Lbn05O5ur7pqhPqmPMzsAX9OpeEGJ
         ISz/uPY1qh+GGe0JUX/mkvJGsFv2nStOtcBs3SF0EOmeDf7Sd79uLfeELQmXGvHj+zLu
         dSdwT7NCyhyceWtuDbCpMZaRW/THKWytAxJ9vzj/6AX7uAn1AVBdyodUdH++19QeE9Cm
         pGaZayImmSZbt1bQc4VHnEbni005S1e2Z90zGRGB4peLxfMGGUYjophnGSDTcXMiZeik
         bwfSHbxMQvZSrZasfNxG/bN74UaFXk3aJ8IiTWdzpaKP94PyLgyx6N1QauThvXARl6DV
         DYzQ==
X-Gm-Message-State: AGRZ1gI3HTT1/Jeh//f6OWqQMIOWhQTxkD0SgY1KHPuA19UzJW2xrOv7
        dB9u9Z7PS4cpzCCBVzKRHXM7gUMZ
X-Google-Smtp-Source: AJdET5d3np4KpHxLzwjZndzSiTiMYWFPL2ATLffQHdm6gbl7dgOIFLeo1rKJjcmDqfmLtXrIElYxLA==
X-Received: by 2002:a19:c396:: with SMTP id t144mr6752774lff.110.1541828982234;
        Fri, 09 Nov 2018 21:49:42 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:41 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 21/22] rerere.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:09 +0100
Message-Id: <20181110054910.10568-22-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c                  |  2 +-
 builtin/rebase--interactive.c |  2 +-
 builtin/rebase.c              |  4 ++--
 builtin/rerere.c              | 10 ++++++----
 rerere.c                      | 26 +++++++++++++-------------
 rerere.h                      |  6 +++---
 6 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 232f3962d7..f0eeec82a9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2033,7 +2033,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 static void am_rerere_clear(void)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	rerere_clear(&merge_rr);
+	rerere_clear(the_repository, &merge_rr);
 	string_list_clear(&merge_rr, 1);
 }
 
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index d867050fd2..bd7d39e2af 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -233,7 +233,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	case SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-		rerere_clear(&merge_rr);
+		rerere_clear(the_repository, &merge_rr);
 		/* fallthrough */
 	case CONTINUE:
 		ret = sequencer_continue(the_repository, &opts);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d9bedecf86..bc07d932a5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -997,7 +997,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		options.action = "skip";
 
-		rerere_clear(&merge_rr);
+		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
 		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
@@ -1010,7 +1010,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 		options.action = "abort";
 
-		rerere_clear(&merge_rr);
+		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
 		if (read_basic_state(&options))
diff --git a/builtin/rerere.c b/builtin/rerere.c
index e89ccbc524..6f28c19b20 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -82,11 +82,12 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(&merge_rr);
+		rerere_clear(the_repository, &merge_rr);
 	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(&merge_rr);
+		rerere_gc(the_repository, &merge_rr);
 	else if (!strcmp(argv[0], "status")) {
-		if (setup_rerere(&merge_rr, flags | RERERE_READONLY) < 0)
+		if (setup_rerere(the_repository, &merge_rr,
+				 flags | RERERE_READONLY) < 0)
 			return 0;
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
@@ -101,7 +102,8 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 				merge_rr.items[i].util = NULL;
 		}
 	} else if (!strcmp(argv[0], "diff")) {
-		if (setup_rerere(&merge_rr, flags | RERERE_READONLY) < 0)
+		if (setup_rerere(the_repository, &merge_rr,
+				 flags | RERERE_READONLY) < 0)
 			return 0;
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
diff --git a/rerere.c b/rerere.c
index b5b2357411..13624038e6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -198,10 +198,10 @@ static struct rerere_id *new_rerere_id(unsigned char *sha1)
  * work on (i.e. what is left by the previous invocation of "git
  * rerere" during the current conflict resolution session).
  */
-static void read_rr(struct string_list *rr)
+static void read_rr(struct repository *r, struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *in = fopen_or_warn(git_path_merge_rr(the_repository), "r");
+	FILE *in = fopen_or_warn(git_path_merge_rr(r), "r");
 
 	if (!in)
 		return;
@@ -593,7 +593,7 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
 {
 	int i;
 
-	if (setup_rerere(merge_rr, RERERE_READONLY))
+	if (setup_rerere(r, merge_rr, RERERE_READONLY))
 		return 0;
 	if (read_index(r->index) < 0)
 		return error(_("index file corrupt"));
@@ -882,7 +882,7 @@ static int is_rerere_enabled(void)
 	return 1;
 }
 
-int setup_rerere(struct string_list *merge_rr, int flags)
+int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 {
 	int fd;
 
@@ -896,9 +896,9 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 		fd = 0;
 	else
 		fd = hold_lock_file_for_update(&write_lock,
-					       git_path_merge_rr(the_repository),
+					       git_path_merge_rr(r),
 					       LOCK_DIE_ON_ERROR);
-	read_rr(merge_rr);
+	read_rr(r, merge_rr);
 	return fd;
 }
 
@@ -912,7 +912,7 @@ int repo_rerere(struct repository *r, int flags)
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int fd, status;
 
-	fd = setup_rerere(&merge_rr, flags);
+	fd = setup_rerere(r, &merge_rr, flags);
 	if (fd < 0)
 		return 0;
 	status = do_plain_rerere(r, &merge_rr, fd);
@@ -1110,7 +1110,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	if (read_index(r->index) < 0)
 		return error(_("index file corrupt"));
 
-	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
+	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
 		return 0;
 
@@ -1178,7 +1178,7 @@ static void prune_one(struct rerere_id *id,
 		unlink_rr_item(id);
 }
 
-void rerere_gc(struct string_list *rr)
+void rerere_gc(struct repository *r, struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
@@ -1188,7 +1188,7 @@ void rerere_gc(struct string_list *rr)
 	timestamp_t cutoff_noresolve = now - 15 * 86400;
 	timestamp_t cutoff_resolve = now - 60 * 86400;
 
-	if (setup_rerere(rr, 0) < 0)
+	if (setup_rerere(r, rr, 0) < 0)
 		return;
 
 	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
@@ -1236,11 +1236,11 @@ void rerere_gc(struct string_list *rr)
  *
  * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
  */
-void rerere_clear(struct string_list *merge_rr)
+void rerere_clear(struct repository *r, struct string_list *merge_rr)
 {
 	int i;
 
-	if (setup_rerere(merge_rr, 0) < 0)
+	if (setup_rerere(r, merge_rr, 0) < 0)
 		return;
 
 	for (i = 0; i < merge_rr->nr; i++) {
@@ -1250,6 +1250,6 @@ void rerere_clear(struct string_list *merge_rr)
 			rmdir(rerere_path(id, NULL));
 		}
 	}
-	unlink_or_warn(git_path_merge_rr(the_repository));
+	unlink_or_warn(git_path_merge_rr(r));
 	rollback_lock_file(&write_lock);
 }
diff --git a/rerere.h b/rerere.h
index 5ad8864b3c..c32d79c3bd 100644
--- a/rerere.h
+++ b/rerere.h
@@ -23,7 +23,7 @@ struct rerere_id {
 	int variant;
 };
 
-int setup_rerere(struct string_list *, int);
+int setup_rerere(struct repository *,struct string_list *, int);
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define rerere(flags) repo_rerere(the_repository, flags)
 #endif
@@ -37,8 +37,8 @@ int repo_rerere(struct repository *, int);
 const char *rerere_path(const struct rerere_id *, const char *file);
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
-void rerere_clear(struct string_list *);
-void rerere_gc(struct string_list *);
+void rerere_clear(struct repository *, struct string_list *);
+void rerere_gc(struct repository *, struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	N_("update the index with reused conflict resolution if possible"))
-- 
2.19.1.1231.g84aef82467

