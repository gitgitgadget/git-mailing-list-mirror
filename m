Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293A320248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBZM25 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:28:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfBZM24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:28:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so2200229wmg.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnplFJRZNdKYTJhYahyeAWgxc5FRPuAciAhRdIMpSa0=;
        b=EWMH/VS49rDlyYYbbuU9J2Gn2a8x9ktM4mgKcZ3RcczWGW2FNaMNXalv5JAxFYNJNT
         OKirgetLct5u9hsITO8kWYUewmhZdyMeWTU9gr83IOaYWAl9M/0W01kBJ0jVBblf3lqT
         wEPNjjT7RvmCSyR0yBItpftjDOuM4i6Hky7LvJJQgzM4r/0OkaU9a6Q25aseYU3TG4qL
         HQiRbAJ9WskxubPiZO9KlTF9mA3DTmqxmFkGq6BzMHuxHPOtxzTSxjikw2zjJQ4Lyig1
         HUQUrUJQjpek0Q0Kc/ejyHzq4tLciO3KI28SyD13w57fowGJ0vZi7obATFPQgo1mtBAd
         L9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnplFJRZNdKYTJhYahyeAWgxc5FRPuAciAhRdIMpSa0=;
        b=qADCrbZ0qVN/dqxNT8OA6+Ni9pofZ/fOu7rTZaisGRpwO0PczpsmO0gHmvbRxnkftl
         wUPYPhQ5h/we0ZZ90LiLsZHQdPMEqAHIKCpwexxdxg3UqdFJrXa35mRhN+DFixr+ku7c
         Eh6M51yAsylv2YQQ27d0OyDksZ0shNxbXU7WD/RNsE+z+C8tQv3omLCwhK7T9FYQMoFq
         qk27FSzCQAL6c9a6vDVjUZGWDOE43s4GIK5dPen39pAV/A7+c7hiWrIs2xGrlmpjlgT4
         yx4GnTq5unKbHUZWtYrkCfAqTcSIBX97SW/ASp/AuDXfXrpngRAgJQ5LuGcLwCDUhcV3
         eFDA==
X-Gm-Message-State: AHQUAuYmJeyFVpAsiLJIQTlv4+zIHkVDfsnfVCdtXdFXI9omqSvqlhuM
        fbBJ8eFi3JT187e1gT9dP3NWJJ9fN4Y=
X-Google-Smtp-Source: AHgI3IZKFo7tcWKLtPvY/nebBV9jPvoNp5J5YoZSH3lDaepeDeA5lSyWtPnqScITCkh4yaV0T4U8Hw==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr2507824wmg.101.1551184133373;
        Tue, 26 Feb 2019 04:28:53 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm2733165wme.24.2019.02.26.04.28.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Feb 2019 04:28:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH v3 2/5] dir-iterator: add flags parameter to dir_iterator_begin
Date:   Tue, 26 Feb 2019 13:28:26 +0100
Message-Id: <20190226122829.19178-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

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
 dir-iterator.h       | 40 ++++++++++++++++++++++++++++++++--------
 refs/files-backend.c |  2 +-
 3 files changed, 58 insertions(+), 12 deletions(-)

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
index 970793d07a..fe9eb9a04b 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -6,9 +6,10 @@
 /*
  * Iterate over a directory tree.
  *
- * Iterate over a directory tree, recursively, including paths of all
- * types and hidden paths. Skip "." and ".." entries and don't follow
- * symlinks except for the original path.
+ * With no flags to modify behaviour, iterate over a directory tree,
+ * recursively, including paths of all types and hidden paths. Skip
+ * "." and ".." entries and don't follow symlinks except for the
+ * original path.
  *
  * Every time dir_iterator_advance() is called, update the members of
  * the dir_iterator structure to reflect the next path in the
@@ -19,7 +20,7 @@
  * A typical iteration looks like this:
  *
  *     int ok;
- *     struct iterator *iter = dir_iterator_begin(path);
+ *     struct iterator *iter = dir_iterator_begin(path, 0);
  *
  *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
  *             if (want_to_stop_iteration()) {
@@ -40,6 +41,20 @@
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
@@ -59,15 +74,19 @@ struct dir_iterator {
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
@@ -76,6 +95,11 @@ struct dir_iterator *dir_iterator_begin(const char *path);
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
index dd8abe9185..c3d3b6c454 100644
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
2.21.0.rc2.261.ga7da99ff1b

