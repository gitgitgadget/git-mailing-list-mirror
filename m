Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344FF1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeACQgm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:42 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40861 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeACQej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id f206so3622249wmf.5
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yIbu/9U/4415rpcJl4hvoaMWtx2zJBs7JqdaJ9Gzt8M=;
        b=Wxm7LDqqW0dsCORfDga9vPMHyLXub0bYJ6W+9e81v8lU8IOwDjXzkMjD57wuKfN6fa
         FoZ75Kl30k0g9rvqFcGoRVHpEWvuRbV0IrjW1swwoeVgTJcK0wEXPMXAZUvcqa/Y7Ayr
         7t49s5IqqVreHnqJL1HWXuB3avrFug+0poYw0CPlE4qHEKUfRJId9urhbZujr+1xfI+i
         +pZE4B1n8/QiywLe8lyBYKAQaU9GvEbfyZjyTuqyyu1KdvFoJVHt8Ab1sIyE+OwSxpbv
         yvTtzaUdyD3c6e8+fkLjvx1eRb1E4Dt7fW4+vnuKK6icgGK7tmIzTrgQZu0Ftm1AHf/O
         /iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yIbu/9U/4415rpcJl4hvoaMWtx2zJBs7JqdaJ9Gzt8M=;
        b=ahMYN1074Cd78tykWeyKgVccr+HCs8C4EJBRuIMxJWbFw2Y/OjbnD8Euz6Uidn1ZEG
         YuXtlKtyA3AkyT2o6GFVPICJ7n9eQIfmubvbmfmHAQdTDow6cv7GxLFpCctKqMqgcrTw
         F7IyCDfX+CEEicRU1ZLxXLji3nSkVsQN/D5Q4E4vB8DQgP1u9F6o3cuHOyqJf6ltHro7
         v0ELMoue/43uZ6EzVZvwfK0M1owTODfybTCv3j1rysZ5xGCuf22VTdL6CnaVvk0EPolU
         RpYmY8kc88qs2LLywtmgxt8qSLz4E3Nbx+DaAYbqN1iyDaVVmICuu2dyXrbxM9Jvz3Hk
         yUuw==
X-Gm-Message-State: AKGB3mKiNt/EE/Xznpq81DgTmFMx8O0uQH7Ksu6r26oXjIsHSqP9hQBZ
        x1DX1sy2Eu1UxrK5v4cgPPi1YIHJ
X-Google-Smtp-Source: ACJfBosSstgRjPquIlOQGqTE5NOuSxNGE+yzWYs00MTWsFop5PwdZG+JONc2B5vClf5LkO6HqqXwGw==
X-Received: by 10.28.35.4 with SMTP id j4mr1714009wmj.55.1514997278045;
        Wed, 03 Jan 2018 08:34:38 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:37 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 14/40] sha1_file: prepare for external odbs
Date:   Wed,  3 Jan 2018 17:33:37 +0100
Message-Id: <20180103163403.11303-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the following commits we will need some functions that were
internal to sha1_file.c, so let's first make them non static
and declare them in "cache.h". While at it, let's rename
'create_tmpfile()' to 'create_object_tmpfile()' to make its
name less generic.

Let's also split out 'sha1_file_name_alt()' from
'sha1_file_name()' and 'open_sha1_file_alt()' from
'open_sha1_file()', as we will need both of these new
functions too.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     |  8 ++++++++
 sha1_file.c | 47 +++++++++++++++++++++++++++++------------------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 3fabf998ce..f41c102cb4 100644
--- a/cache.h
+++ b/cache.h
@@ -964,6 +964,12 @@ extern void check_repository_format(void);
  */
 extern const char *sha1_file_name(const unsigned char *sha1);
 
+/*
+ * Like sha1_file_name, but return the filename within a specific alternate
+ * object directory. Shares the same static buffer with sha1_file_name.
+ */
+extern const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1);
+
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
@@ -1251,6 +1257,8 @@ extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
+extern int create_object_tmpfile(struct strbuf *tmp, const char *filename);
+extern void close_sha1_file(int fd);
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 261baf800f..785e8dda03 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -322,17 +322,22 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/", get_object_directory());
+	strbuf_addf(&buf, "%s/", objdir);
 
 	fill_sha1_path(&buf, sha1);
 	return buf.buf;
 }
 
+const char *sha1_file_name(const unsigned char *sha1)
+{
+	return sha1_file_name_alt(get_object_directory(), sha1);
+}
+
 struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
 {
 	strbuf_setlen(&alt->scratch, alt->base_len);
@@ -902,24 +907,14 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	return -1;
 }
 
-/*
- * Like stat_sha1_file(), but actually open the object and return the
- * descriptor. See the caveats on the "path" parameter above.
- */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+static int open_sha1_file_alt(const unsigned char *sha1, const char **path)
 {
-	int fd;
 	struct alternate_object_database *alt;
-	int most_interesting_errno;
-
-	*path = sha1_file_name(sha1);
-	fd = git_open(*path);
-	if (fd >= 0)
-		return fd;
-	most_interesting_errno = errno;
+	int most_interesting_errno = errno;
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
+		int fd;
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
@@ -931,6 +926,22 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	return -1;
 }
 
+/*
+ * Like stat_sha1_file(), but actually open the object and return the
+ * descriptor. See the caveats on the "path" parameter above.
+ */
+static int open_sha1_file(const unsigned char *sha1, const char **path)
+{
+	int fd;
+
+	*path = sha1_file_name(sha1);
+	fd = git_open(*path);
+	if (fd >= 0)
+		return fd;
+
+	return open_sha1_file_alt(sha1, path);
+}
+
 /*
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
@@ -1527,7 +1538,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_sha1_file(int fd)
+void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
@@ -1551,7 +1562,7 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+int create_object_tmpfile(struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -1591,7 +1602,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	const char *filename = sha1_file_name(sha1);
 
-	fd = create_tmpfile(&tmp_file, filename);
+	fd = create_object_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

