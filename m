Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA12720248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfC3Wt2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42365 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3Wt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so6492525qtc.9
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFwzYyS24Sj7uW4/YpI3WSwS0fZiSiLROyQBRdvQzL8=;
        b=b7i3uuk6jL/lpxPIuAgWTvj55kOMXdWHeTUXc8rET7ynfeKeExDGLtBcEzOlsgmlTH
         g6d+utubmFmXG1qH7OjrSMxGVID/Rcd2sG5gd9VLip831sYC/4pgQbvAgbYMF6cZ4R+k
         kRS94DTVF2RxIS3HxdL5Ruhp+zViiOYE5t+A4qMF68VSlVm5sfSGzkeOeWbCfymLv6LN
         UopsP1x1C5QyYW03+8XXbHKZLg5EA1xkt2D17xczwofUhkiVIJXrumPuM+9EG58zsO0v
         YvPrUo1JqPnY6syfK7okxM5hc9D16iwDIGTKUuX8RNByMLbEIQWbi0/U1XjRvkQPF4Wi
         N6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFwzYyS24Sj7uW4/YpI3WSwS0fZiSiLROyQBRdvQzL8=;
        b=kyL066bWc1EohqYP6LsmBLpTImLmq2pOmhEVC3/gTklSjilVPg6SqOFbVUQHPbFM4i
         L4pbjisVs+DHI5TsOdmIIAtaBYyiHYVL1xiHqTsH4kXqWdhA5DBpVphRQoNXDixDVOxn
         iAxBOotO3zfTfuM85Zfyb4cA7etmr2ops7hPu6lRmmgBZn8iiAGwvGVHU4nwEbILsnT8
         A2ZEUznlFDkxjozHkKHNIEK207IuJ490gCM8zUAgn5qVny0Pszq09xbw3J61GF0wTvmb
         lKbGrHmPaRy+Ua6ziKoDyvmXp2v1tdRIVeku/AqVU9ZLREz1IufBhMH4aVcsAAscq+bu
         vuFw==
X-Gm-Message-State: APjAAAUYXCjFhZPhJjDW+DQBkgaMC0desZF1gNCVUwq0qcHIiUZQFhdI
        zU5juGC0zutZJFIscAcsoL1N5w==
X-Google-Smtp-Source: APXvYqwiOA0cHNI8yjcSH/ZilWO22SPVE73F9u22O8utmB2VPpivZOdIaPNnUy3xqUPHQPhciAmj2A==
X-Received: by 2002:ac8:2427:: with SMTP id c36mr47544598qtc.124.1553986167410;
        Sat, 30 Mar 2019 15:49:27 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:26 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [GSoC][PATCH v5 3/7] dir-iterator: add flags parameter to dir_iterator_begin
Date:   Sat, 30 Mar 2019 19:49:03 -0300
Message-Id: <20190330224907.3277-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the possibility of giving flags to dir_iterator_begin to initialize
a dir-iterator with special options.

Currently possible flags are DIR_ITERATOR_PEDANTIC, which makes
dir_iterator_advance abort immediately in the case of an error while
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
index 970793d07a..93646c3bea 100644
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

