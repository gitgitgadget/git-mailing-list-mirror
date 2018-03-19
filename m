Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE3B1FAE4
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933289AbeCSNcU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53931 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755194AbeCSNcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id e194so15142058wmd.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WLfp4k/SkFRkZq9g/bo1AOcJDsXMCh4/OGJBp8+PN54=;
        b=AGhBWPbyNSqfWYjEz+14MMxlY85lxP7u8vdHoh2HbCdcgdRnVcZ9BzI6H7Db8SZQ0h
         li6Sek+S7mp078awTg6YsusKXhdVSPjKAu1RuWfqqqHkWEXyczLR6HuycKCI/jO+MYRH
         Rg4e/AxhSGCow7uWFAsedZbjL17NLr4k9b9gzUmxk79kEvIZ7rOU/iXeLbCDuKWOXtDN
         ThsYTKs1U43JK0fQ1RthKgjzFT2zy+CbsQQ1hde0xLKmZ09lEkezQ5OGGY0VGH6XXk0+
         9ChkRfDPk+V+WH8iqUMeSBHR3Ax4JH73Fp6tMmCfBuMEzVUYkHtxC8Gd+ZZuKlvFdJgV
         BfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WLfp4k/SkFRkZq9g/bo1AOcJDsXMCh4/OGJBp8+PN54=;
        b=lKbGma9bPNacRYCbhRVNtROXHNJHKH5xrdp9BnoxDeWAmSGb6sfavHqZFoZDSSrI6s
         v4XzzkR2Q68fmDHXrQdF6O4gSd/FKtrQVsRu6XNtEsVUcUZHvnE6xG/PTzKLY/lGz9oz
         btZMZKvZdR4lvEBIVM+hS4xgZmEpZU7vK96rCJZqLuqqKkJokxcLPsUm5P5noWfQaMT8
         f2cZXCY1FtOUF17kC/UD8mu7rLe1eYfILR65qYT93Tk/nvci3D3ipETbGbOM5wOla8uG
         eAJXpR/MmdYr5bQ4MRWyDukPxjQV3/e2YvZZ3rYWtJ1mjSkF/ibNDxiF9uThKX5hO5EC
         uPzg==
X-Gm-Message-State: AElRT7E1E0XsAjVhF2bepnT1Gz4srHZFtr1g+YmRYr2n722Qmer9Mutg
        WSqBMcqyQOfNCducE6782gN8ENF6
X-Google-Smtp-Source: AG47ELuYPfLeu1i7BrvADw3lFUySQiuZHOfyj32HZdfFPW3GSIk50RIpsuacoiyf0u1qOqZhQzRXhw==
X-Received: by 10.28.11.79 with SMTP id 76mr9328483wml.41.1521466336479;
        Mon, 19 Mar 2018 06:32:16 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:15 -0700 (PDT)
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
Subject: [PATCH v2 06/36] sha1_file: prepare for external odbs
Date:   Mon, 19 Mar 2018 14:31:17 +0100
Message-Id: <20180319133147.15413-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 sha1_file.c | 49 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 4aa0129cf8..e6fd9b97ec 100644
--- a/cache.h
+++ b/cache.h
@@ -951,6 +951,12 @@ extern void check_repository_format(void);
  */
 extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
 
+/*
+ * Like sha1_file_name, but put in `buf` the filename within a
+ * specific alternate object directory.
+ */
+extern void sha1_file_name_alt(struct strbuf *buf, const char *objdir, const unsigned char *sha1);
+
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
@@ -1247,6 +1253,8 @@ extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
+extern int create_object_tmpfile(struct strbuf *tmp, const char *filename);
+extern void close_sha1_file(int fd);
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index f2e078e840..c460eb2658 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -320,13 +320,18 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name_alt(struct strbuf *buf, const char *objdir, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, get_object_directory());
+	strbuf_addstr(buf, objdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
 
+void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
+{
+	return sha1_file_name_alt(buf, get_object_directory(), sha1);
+}
+
 struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
 {
 	strbuf_setlen(&alt->scratch, alt->base_len);
@@ -905,6 +910,25 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	return -1;
 }
 
+static int open_sha1_file_alt(const unsigned char *sha1, const char **path)
+{
+	struct alternate_object_database *alt;
+	int most_interesting_errno = errno;
+
+	prepare_alt_odb();
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		int fd;
+		*path = alt_sha1_path(alt, sha1);
+		fd = git_open(*path);
+		if (fd >= 0)
+			return fd;
+		if (most_interesting_errno == ENOENT)
+			most_interesting_errno = errno;
+	}
+	errno = most_interesting_errno;
+	return -1;
+}
+
 /*
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
@@ -912,8 +936,6 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 static int open_sha1_file(const unsigned char *sha1, const char **path)
 {
 	int fd;
-	struct alternate_object_database *alt;
-	int most_interesting_errno;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
@@ -923,19 +945,8 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
-	most_interesting_errno = errno;
 
-	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
-		*path = alt_sha1_path(alt, sha1);
-		fd = git_open(*path);
-		if (fd >= 0)
-			return fd;
-		if (most_interesting_errno == ENOENT)
-			most_interesting_errno = errno;
-	}
-	errno = most_interesting_errno;
-	return -1;
+	return open_sha1_file_alt(sha1, path);
 }
 
 /*
@@ -1537,7 +1548,7 @@ int hash_object_file(const void *buf, unsigned long len, const char *type,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_sha1_file(int fd)
+void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
@@ -1561,7 +1572,7 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+int create_object_tmpfile(struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -1605,7 +1616,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	strbuf_reset(&filename);
 	sha1_file_name(&filename, oid->hash);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
+	fd = create_object_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
-- 
2.17.0.rc0.37.g8f476fabe9

