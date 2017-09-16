Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C5D20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdIPIKT (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:10:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35882 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdIPIHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id r136so4498443wmf.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJ0/9TQ9dO/MGE7JsDaMakYVPaaGsEsQNlvQyTFQlHk=;
        b=rdzdBogM6pvRH/qZhcAeQkDEfF5akCN/PDzxRYysTekNLhSXTts48FztwkgmzFlkGq
         Xj5kdTmkWD1czsvz9YZi6Kjs7sivVZvXLMqFKWMK6DBuv5svKAgrQQzIQqem7pae2urP
         OlLIo3KzpipecnuiOh0u5REF1wyJRyjbEAuB7Edt0QkuKGG9P+h0l2VA48BYTmuiI7nk
         3fPXaYpmmttUnyzXCB4sUnvEHGjeRVbvH1y6k7BU78flvJYbTl5qa/ZWDx58d5U8reAH
         tUTttOKjT5PapQMNJ7685/Fa7GqwBockfX+/DfgZz3+Vt0AyLxKl2zLQAl4n+GVvnOmO
         3yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJ0/9TQ9dO/MGE7JsDaMakYVPaaGsEsQNlvQyTFQlHk=;
        b=QYBRRDV4RQTN/AumKE6orS68+TSP5H67HgA520vKKXE8bb48lbcFkUefD3DghzkgAY
         4/NVAZZc8SB2AxUNyOZ9oqENouvrMO67TB8hT7NGdUfLnIsBONmCZf3k8UpijgJ5qaUV
         AQv3gQcpNQndWdlRGVLJFowsN3DSUkWbApiq2+sA0RdJJ0nRaNHVGX4Jx2PDV85w5/fM
         Sc0jpVDWACNG6fnK1hwRJrqjbvvD3536MFWqjqBP/9YBdsEHsuYxgIsvv89vaM2wM4Gt
         vPuAhWVrF+ZhyGxTKAb616kqGmCZnf4GB/qYmRa+PbAYGRe1+AhVvyp5jBXlzOBqhWit
         sXtg==
X-Gm-Message-State: AHPjjUhBJzUp+v+EvKR6+MH9382q26cchixmT+tK8mP3wlMXmqcsZtFN
        /dotDZDlA4M5gKj/
X-Google-Smtp-Source: AOwi7QCXcGlwkcfo9l2+yJ2OGQ1gYuWvtjScwfm8a3uBH1smS15p/6ATIvYEn8vAIlTzgPgj7R/dsw==
X-Received: by 10.28.129.23 with SMTP id c23mr4991770wmd.27.1505549273977;
        Sat, 16 Sep 2017 01:07:53 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:53 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 08/40] sha1_file: prepare for external odbs
Date:   Sat, 16 Sep 2017 10:06:59 +0200
Message-Id: <20170916080731.13925-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index a916bc79e3..00d89568f3 100644
--- a/cache.h
+++ b/cache.h
@@ -902,6 +902,12 @@ extern void check_repository_format(void);
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
@@ -1189,6 +1195,8 @@ extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
+extern int create_object_tmpfile(struct strbuf *tmp, const char *filename);
+extern void close_sha1_file(int fd);
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 5f71bbac3e..bea1ae6afb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -251,17 +251,22 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
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
@@ -822,24 +827,14 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
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
@@ -851,6 +846,22 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
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
@@ -1428,7 +1439,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_sha1_file(int fd)
+void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
@@ -1452,7 +1463,7 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+int create_object_tmpfile(struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -1492,7 +1503,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	const char *filename = sha1_file_name(sha1);
 
-	fd = create_tmpfile(&tmp_file, filename);
+	fd = create_object_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
-- 
2.14.1.576.g3f707d88cd

