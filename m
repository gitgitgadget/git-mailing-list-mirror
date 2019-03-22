Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B158120248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfCVXXA (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:23:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40174 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfCVXW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:22:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so4436299qts.7
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WV1uTcn7eh12Y1cgNRgtyoHOOchVs7TOzTJlWTZ5k8=;
        b=yAfOWcuZN71ytM8Pns2CnllW3W04FBLX5ItBsBbkSeEIiLNa3+yU3X6pw3CYl0tCxQ
         HH7oO6wLXMDL6do+041/8xuFCb0eAKtLiZdoc6xzPGdSw/hD3kUjrdjMbZ5GCI5Y3aw1
         ZsTNxrvl5FLTqBd2jOJm8opp1XX2Vn4J0S6laSbbZTUDcTOekfHXaA7rN9rQ/nwDvAjI
         Z24qh8OkGucDYyL5xMdZsCWB/o8GfDze20fLUv7Mv3KqqMbL6rA8nGWHYwUmq9i4SBGW
         T7MuceQpZhU8OuxlpA76ub3iLY/Xc5yLpo39MeFvAbl5RwSNxH7u1fZDcYFSPKS66pLF
         2sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WV1uTcn7eh12Y1cgNRgtyoHOOchVs7TOzTJlWTZ5k8=;
        b=K1u0bIzvwtmsA3LpTwEeYu1TfeL0GK1NeDeYc0rP0nIv3Q03e7sSPMV+Xvr+FtD6PD
         0/i0+32f0lCMPAFhjUiv+wMPLOQbzoeGh1yar1O8VrKdsHS/0mOnjkArAAbKpge/h2L2
         T9U/W/g35FQmjyxsQ6EJIPHxxDC/gQ0PQKgbMyUcpHDq3nKIOmYnEaJXToGZakp/rdvf
         Kyrl61H7InwhA+Z1poiUBLYmNBnYrnnbYHR4wiTaZE2WKqIlBjuza3HqgG90uwvVJYyI
         fKLwrnNvqEb/yRSZMUf6XB4wbT4BTGfqVWITYRA7Bh5/whJ6lGpDdz7BYV1M5nFsWuaQ
         Kp9Q==
X-Gm-Message-State: APjAAAXwHovOcDk7fOBLeTqqaxtpnX9snRRxZjOPEalGOg9eXmfq0N6I
        v3HejAgwrSoY2nUPfmKBiRvhxw8fqG4=
X-Google-Smtp-Source: APXvYqxaNl4VrhiS/Cj4h7nUnzjr5YIYHQ2cU34ywU4VAGKYXoTwR5EqwWhVnGzohe8aiWMASFyl4A==
X-Received: by 2002:a0c:9ba1:: with SMTP id o33mr10601574qve.15.1553296978406;
        Fri, 22 Mar 2019 16:22:58 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:22:57 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 3/7] dir-iterator: add flags parameter to dir_iterator_begin
Date:   Fri, 22 Mar 2019 20:22:33 -0300
Message-Id: <20190322232237.13293-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the possibility of giving flags to dir_iterator_begin to initialize
a dir-iterator with special options.

Currently possible flags are DIR_ITERATOR_PEDANTIC, which makes
dir_iterator_advance abort imediatelly in the case of an error while
trying to fetch next entry; and DIR_ITERATOR_FOLLOW_SYMLINKS, which
makes the iteration follow symlinks to directories and include its
contents in the iteration. These new flags will be used in a subsequent
patch.

Also adjust refs/files-backend.c to the new dir_iterator_begin
signature.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir-iterator.c       | 28 +++++++++++++++++++++++++---
 dir-iterator.h       | 39 +++++++++++++++++++++++++++++++++------
 refs/files-backend.c |  2 +-
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f2dcd82fde..17aca8ea41 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -48,12 +48,16 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/* Combination of flags for this dir-iterator */
+	unsigned flags;
 };
 
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter =
 		(struct dir_iterator_int *)dir_iterator;
+	int ret;
 
 	while (1) {
 		struct dir_iterator_level *level =
@@ -71,6 +75,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 			level->dir = opendir(iter->base.path.buf);
 			if (!level->dir && errno != ENOENT) {
+				if (iter->flags & DIR_ITERATOR_PEDANTIC)
+					goto error_out;
 				warning("error opening directory %s: %s",
 					iter->base.path.buf, strerror(errno));
 				/* Popping the level is handled below */
@@ -122,6 +128,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (!de) {
 				/* This level is exhausted; pop up a level. */
 				if (errno) {
+					if (iter->flags & DIR_ITERATOR_PEDANTIC)
+						goto error_out;
 					warning("error reading directory %s: %s",
 						iter->base.path.buf, strerror(errno));
 				} else if (closedir(level->dir))
@@ -138,11 +146,20 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				continue;
 
 			strbuf_addstr(&iter->base.path, de->d_name);
-			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
-				if (errno != ENOENT)
+
+			if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
+				ret = stat(iter->base.path.buf, &iter->base.st);
+			else
+				ret = lstat(iter->base.path.buf, &iter->base.st);
+
+			if (ret < 0) {
+				if (errno != ENOENT) {
+					if (iter->flags & DIR_ITERATOR_PEDANTIC)
+						goto error_out;
 					warning("error reading path '%s': %s",
 						iter->base.path.buf,
 						strerror(errno));
+				}
 				continue;
 			}
 
@@ -159,6 +176,10 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			return ITER_OK;
 		}
 	}
+
+error_out:
+	dir_iterator_abort(dir_iterator);
+	return ITER_ERROR;
 }
 
 int dir_iterator_abort(struct dir_iterator *dir_iterator)
@@ -182,7 +203,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }
 
-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -195,6 +216,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 
+	iter->flags = flags;
 	iter->levels_nr = 1;
 	iter->levels[0].initialized = 0;
 
diff --git a/dir-iterator.h b/dir-iterator.h
index 970793d07a..890d5d8dbb 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -19,7 +19,7 @@
  * A typical iteration looks like this:
  *
  *     int ok;
- *     struct iterator *iter = dir_iterator_begin(path);
+ *     struct iterator *iter = dir_iterator_begin(path, 0);
  *
  *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
  *             if (want_to_stop_iteration()) {
@@ -40,6 +40,20 @@
  * dir_iterator_advance() again.
  */
 
+/*
+ * Flags for dir_iterator_begin:
+ *
+ * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
+ *   in case of an error while trying to fetch the next entry, which is
+ *   to emit a warning and keep going. With this flag, resouces are
+ *   freed and ITER_ERROR is return immediately.
+ *
+ * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks to
+ *   directories, i.e., iterate over linked directories' contents.
+ */
+#define DIR_ITERATOR_PEDANTIC (1 << 0)
+#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
+
 struct dir_iterator {
 	/* The current path: */
 	struct strbuf path;
@@ -54,20 +68,28 @@ struct dir_iterator {
 	/* The current basename: */
 	const char *basename;
 
-	/* The result of calling lstat() on path: */
+	/*
+	 * The result of calling lstat() on path or stat(), if the
+	 * DIR_ITERATOR_FOLLOW_SYMLINKS flag was set at
+	 * dir_iterator's initialization.
+	 */
 	struct stat st;
 };
 
 /*
- * Start a directory iteration over path. Return a dir_iterator that
- * holds the internal state of the iteration.
+ * Start a directory iteration over path with the combination of
+ * options specified by flags. Return a dir_iterator that holds the
+ * internal state of the iteration.
  *
  * The iteration includes all paths under path, not including path
  * itself and not including "." or ".." entries.
  *
- * path is the starting directory. An internal copy will be made.
+ * Parameters are:
+ *  - path is the starting directory. An internal copy will be made.
+ *  - flags is a combination of the possible flags to initialize a
+ *    dir-iterator or 0 for default behaviour.
  */
-struct dir_iterator *dir_iterator_begin(const char *path);
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags);
 
 /*
  * Advance the iterator to the first or next item and return ITER_OK.
@@ -76,6 +98,11 @@ struct dir_iterator *dir_iterator_begin(const char *path);
  * dir_iterator and associated resources and return ITER_ERROR. It is
  * a bug to use iterator or call this function again after it has
  * returned ITER_DONE or ITER_ERROR.
+ *
+ * Note that whether dir-iterator will return ITER_ERROR when failing
+ * to fetch the next entry or just emit a warning and try to fetch the
+ * next is defined by the 'pedantic' option at dir-iterator's
+ * initialization.
  */
 int dir_iterator_advance(struct dir_iterator *iterator);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ef053f716c..2ce9783097 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2143,7 +2143,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
 	strbuf_addf(&sb, "%s/logs", gitdir);
-	iter->dir_iterator = dir_iterator_begin(sb.buf);
+	iter->dir_iterator = dir_iterator_begin(sb.buf, 0);
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
 
-- 
2.20.1

