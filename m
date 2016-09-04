Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575F620193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbcIDUUC (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbcIDUT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id w12so959677wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3UQRzwWzxzpAv7XZGVTucApJzZa9yc2Bqr6OLlbJqFQ=;
        b=Ymp5/bX8GjvMuB9tcxH7FT4hfkNHmImvIJ9yIyG59+2EDyV5czpC57RmgBKJTu/klP
         8qtunJa3aihFwuvaV6cnmrq8e4C65JHLujsJCMjuBN2Zu1TU4uF3tnmsPHcORCbtzgTR
         +5DrJHWOjrxylB2TiU2MaYviCkwAnYHJoxOAbEdPjd6ZBgLBLZD3TscTWpZyiyoq+axy
         G7QGfJSou4bPbh0AqN/6WO7gXiwr9oFGYF4vUmOMhNVSqNvz28Nr1K1+AQyK0d34qSay
         Ef4iY9eLe7+MxkZSqeXYe6tbXBRAKjiQxYbl/KjqXHkkIZQbGC+VxbfUHirpxEyYkoAL
         PCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3UQRzwWzxzpAv7XZGVTucApJzZa9yc2Bqr6OLlbJqFQ=;
        b=aSUWVykN4r1/j1OxFm1lYAOC9dLpcF5r7x1WWIUqqCQLl5MeRnsGNzOiPT4BlIhp92
         W/o4EzJRNO/39lN6LCsdWkx975uVMP/SrNS2qH4qnOLe2MaQGmqv6vdjRU4NORSTbnjV
         fNls39qwPZ8ERnvnDR8jE9Lgczm9yyIBKQcdVno+OldqZDdXXVT8o4nATySu6c2NysDM
         4mkzIVKVp+3HRo6akN0vHY4XLhJlcEbTG22Z4SoXp8MiWqLe4KCwct0mQB5fDyJ6YFEg
         oJ1RaniNd/rscN94Hjg44guoiLl3zaQvzoc8inF6V24137rAzZKtlx4UhUyPl59OD7O/
         I4TA==
X-Gm-Message-State: AE9vXwPk7Q5tlHNomY4AHHzyQo+ffhABng8tdKEkGZ9xyEqxXfO2krpGGuitFGfRY9sLsg==
X-Received: by 10.194.236.68 with SMTP id us4mr27303092wjc.12.1473020364618;
        Sun, 04 Sep 2016 13:19:24 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 26/41] builtin/apply: make try_create_file() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:18 +0200
Message-Id: <20160904201833.21676-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", try_create_file() should return -1 in case of
error.

Unfortunately try_create_file() currently returns -1 to signal a
recoverable error. To fix that, let's make it return 1 in case of
a recoverable error and -1 in case of an unrecoverable error.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c787ead..3145e03 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4150,38 +4150,48 @@ static int add_index_file(struct apply_state *state,
 	return 0;
 }
 
+/*
+ * Returns:
+ *  -1 if an unrecoverable error happened
+ *   0 if everything went well
+ *   1 if a recoverable error happened
+ */
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
-	int fd;
+	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
 
 	if (S_ISGITLINK(mode)) {
 		struct stat st;
 		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
 			return 0;
-		return mkdir(path, 0777);
+		return !!mkdir(path, 0777);
 	}
 
 	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
-		return symlink(buf, path);
+		return !!symlink(buf, path);
 
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
-		return -1;
+		return 1;
 
 	if (convert_to_working_tree(path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
-	write_or_die(fd, buf, size);
+
+	res = write_in_full(fd, buf, size) < 0;
+	if (res)
+		error_errno(_("failed to write to '%s'"), path);
 	strbuf_release(&nbuf);
 
-	if (close(fd) < 0)
-		die_errno(_("closing file '%s'"), path);
-	return 0;
+	if (close(fd) < 0 && !res)
+		return error_errno(_("closing file '%s'"), path);
+
+	return res ? -1 : 0;
 }
 
 /*
@@ -4195,15 +4205,24 @@ static void create_one_file(struct apply_state *state,
 			    const char *buf,
 			    unsigned long size)
 {
+	int res;
+
 	if (state->cached)
 		return;
-	if (!try_create_file(path, mode, buf, size))
+
+	res = try_create_file(path, mode, buf, size);
+	if (res < 0)
+		exit(128);
+	if (!res)
 		return;
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
 			return;
-		if (!try_create_file(path, mode, buf, size))
+		res = try_create_file(path, mode, buf, size);
+		if (res < 0)
+			exit(128);
+		if (!res)
 			return;
 	}
 
@@ -4222,7 +4241,10 @@ static void create_one_file(struct apply_state *state,
 		for (;;) {
 			char newpath[PATH_MAX];
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
-			if (!try_create_file(newpath, mode, buf, size)) {
+			res = try_create_file(newpath, mode, buf, size);
+			if (res < 0)
+				exit(128);
+			if (!res) {
 				if (!rename(newpath, path))
 					return;
 				unlink_or_warn(newpath);
-- 
2.10.0.41.g9df52c3

