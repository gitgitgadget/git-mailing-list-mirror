Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150FA1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfFRX3T (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39814 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so9748536qkd.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/fVbtc+e4k81hyyN9o4Pt+aT8gInbHXcWDi8q9Ax64=;
        b=uDNxdAFabGUimKE8QMrZmBCvXXxmXbvL4uZ9W6LK+OWg+eLVFj56PtqJwbVluDhllP
         X9Q5FcLMH8y896q5IeXAcgQ+bSLstDHC9DQOeHpcNo6gLPE2kbQXUaENXwrydO2rFBEm
         OlhOWjH6wO7w0oF+f6FV9Cy1C2kj2gL7c6cP4Mgd2P/PlXpZeeJvyW7YSDBv0+JezcYm
         jR3/r51Gug7tFDxzRIq8hN4AL4BVoN1vt0znbHW1DAgZMjE89Kcl8NfhzAKKyNeTHvp1
         KB+Sf8MB2M2Vf3wRQvy3wj9pkozAD9mIMZ+QhZ9bzHJq7siyhI/54okXX/wk5dhsW67A
         sm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/fVbtc+e4k81hyyN9o4Pt+aT8gInbHXcWDi8q9Ax64=;
        b=TDW8Ygfob1T33glmsG4tD4qfpmMAfMOYMeuasrtovKdCi2x6EI+bTwqHN1eGfim0XX
         uLOqIu85v0b56wB4f7hIcTeJVXGdpu1doyPgE93ciPLeQzR7PiWRhD/ZCQwwga2TSIFR
         f8f2H1xiNkYfX1BkQgn/mHKqFkTDCYg6VKAdWcVR4EEMZjsmtzQCjoADHwGEzBCB6olj
         v3CQWkdj27IXUDazJhOZuDHR9X2YZyHDZsChEEYt2n2T9lYR/o7Bc9VR90o9w2O09XLF
         0MSSbRZK8l3a9pflnha+7ArSI19Cb6eN2CNi/52l/T66jMHah/xoq/lMaqAKxWIQfvcu
         jZSw==
X-Gm-Message-State: APjAAAWooXL7ffnVsWrXXgCLTx+I9QKz0K0KAAzua/4YBlYNFESg0O6c
        xh9gGQqShFejJRh1lYS3iOkoSKWvnik=
X-Google-Smtp-Source: APXvYqyVzMB8kD+I0VfoAhOviDlgYFjmbkd7f1WDCHKS4uyFrf5DTFBPCgMToju5m2KXJ7p6C+FREg==
X-Received: by 2002:ae9:e20c:: with SMTP id c12mr96335250qkc.210.1560900557590;
        Tue, 18 Jun 2019 16:29:17 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.29.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Daniel Ferreira <bnmvco@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [GSoC][PATCH v7 05/10] dir-iterator: refactor state machine model
Date:   Tue, 18 Jun 2019 20:27:42 -0300
Message-Id: <c2466d5ad9f0680045fa16db6d8a6852c28f5066.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dir_iterator_advance() is a large function with two nested loops. Let's
improve its readability factoring out three functions and simplifying
its mechanics. The refactored model will no longer depend on
level.initialized and level.dir_state to keep track of the iteration
state and will perform on a single loop.

Also, dir_iterator_begin() currently does not check if the given string
represents a valid directory path. Since the refactored model will have
to stat() the given path at initialization, let's also check for this
kind of error and make dir_iterator_begin() return NULL, on failures,
with errno appropriately set. And add tests for this new behavior.

Improve documentation at dir-iteration.h and code comments at
dir-iterator.c to reflect the changes and eliminate possible
ambiguities.

Finally, adjust refs/files-backend.c to check for now possible
dir_iterator_begin() failures.

Original-patch-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir-iterator.c               | 234 ++++++++++++++++++-----------------
 dir-iterator.h               |  15 ++-
 refs/files-backend.c         |  17 ++-
 t/helper/test-dir-iterator.c |   5 +
 t/t0066-dir-iterator.sh      |  13 ++
 5 files changed, 163 insertions(+), 121 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 0c8880868a..594fe4d67b 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -4,8 +4,6 @@
 #include "dir-iterator.h"
 
 struct dir_iterator_level {
-	int initialized;
-
 	DIR *dir;
 
 	/*
@@ -13,16 +11,6 @@ struct dir_iterator_level {
 	 * (including a trailing '/'):
 	 */
 	size_t prefix_len;
-
-	/*
-	 * The last action that has been taken with the current entry
-	 * (needed for directories, which have to be included in the
-	 * iteration and also iterated into):
-	 */
-	enum {
-		DIR_STATE_ITER,
-		DIR_STATE_RECURSE
-	} dir_state;
 };
 
 /*
@@ -34,9 +22,11 @@ struct dir_iterator_int {
 	struct dir_iterator base;
 
 	/*
-	 * The number of levels currently on the stack. This is always
-	 * at least 1, because when it becomes zero the iteration is
-	 * ended and this struct is freed.
+	 * The number of levels currently on the stack. After the first
+	 * call to dir_iterator_begin(), if it succeeds to open the
+	 * first level's dir, this will always be at least 1. Then,
+	 * when it comes to zero the iteration is ended and this
+	 * struct is freed.
 	 */
 	size_t levels_nr;
 
@@ -50,113 +40,118 @@ struct dir_iterator_int {
 	struct dir_iterator_level *levels;
 };
 
+/*
+ * Push a level in the iter stack and initialize it with information from
+ * the directory pointed by iter->base->path. It is assumed that this
+ * strbuf points to a valid directory path. Return 0 on success and -1
+ * otherwise, leaving the stack unchanged.
+ */
+static int push_level(struct dir_iterator_int *iter)
+{
+	struct dir_iterator_level *level;
+
+	ALLOC_GROW(iter->levels, iter->levels_nr + 1, iter->levels_alloc);
+	level = &iter->levels[iter->levels_nr++];
+
+	if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
+		strbuf_addch(&iter->base.path, '/');
+	level->prefix_len = iter->base.path.len;
+
+	level->dir = opendir(iter->base.path.buf);
+	if (!level->dir) {
+		if (errno != ENOENT) {
+			warning_errno("error opening directory '%s'",
+				      iter->base.path.buf);
+		}
+		iter->levels_nr--;
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Pop the top level on the iter stack, releasing any resources associated
+ * with it. Return the new value of iter->levels_nr.
+ */
+static int pop_level(struct dir_iterator_int *iter)
+{
+	struct dir_iterator_level *level =
+		&iter->levels[iter->levels_nr - 1];
+
+	if (level->dir && closedir(level->dir))
+		warning_errno("error closing directory '%s'",
+			      iter->base.path.buf);
+	level->dir = NULL;
+
+	return --iter->levels_nr;
+}
+
+/*
+ * Populate iter->base with the necessary information on the next iteration
+ * entry, represented by the given dirent de. Return 0 on success and -1
+ * otherwise.
+ */
+static int prepare_next_entry_data(struct dir_iterator_int *iter,
+				   struct dirent *de)
+{
+	strbuf_addstr(&iter->base.path, de->d_name);
+	/*
+	 * We have to reset these because the path strbuf might have
+	 * been realloc()ed at the previous strbuf_addstr().
+	 */
+	iter->base.relative_path = iter->base.path.buf +
+				   iter->levels[0].prefix_len;
+	iter->base.basename = iter->base.path.buf +
+			      iter->levels[iter->levels_nr - 1].prefix_len;
+
+	if (lstat(iter->base.path.buf, &iter->base.st)) {
+		if (errno != ENOENT)
+			warning_errno("failed to stat '%s'", iter->base.path.buf);
+		return -1;
+	}
+
+	return 0;
+}
+
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter =
 		(struct dir_iterator_int *)dir_iterator;
 
+	if (S_ISDIR(iter->base.st.st_mode)) {
+		if (push_level(iter) && iter->levels_nr == 0) {
+			/* Pushing the first level failed */
+			return dir_iterator_abort(dir_iterator);
+		}
+	}
+
+	/* Loop until we find an entry that we can give back to the caller. */
 	while (1) {
+		struct dirent *de;
 		struct dir_iterator_level *level =
 			&iter->levels[iter->levels_nr - 1];
-		struct dirent *de;
 
-		if (!level->initialized) {
-			/*
-			 * Note: dir_iterator_begin() ensures that
-			 * path is not the empty string.
-			 */
-			if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
-				strbuf_addch(&iter->base.path, '/');
-			level->prefix_len = iter->base.path.len;
-
-			level->dir = opendir(iter->base.path.buf);
-			if (!level->dir && errno != ENOENT) {
-				warning_errno("error opening directory '%s'",
+		strbuf_setlen(&iter->base.path, level->prefix_len);
+		errno = 0;
+		de = readdir(level->dir);
+
+		if (!de) {
+			if (errno)
+				warning_errno("error reading directory '%s'",
 					      iter->base.path.buf);
-				/* Popping the level is handled below */
-			}
-
-			level->initialized = 1;
-		} else if (S_ISDIR(iter->base.st.st_mode)) {
-			if (level->dir_state == DIR_STATE_ITER) {
-				/*
-				 * The directory was just iterated
-				 * over; now prepare to iterate into
-				 * it.
-				 */
-				level->dir_state = DIR_STATE_RECURSE;
-				ALLOC_GROW(iter->levels, iter->levels_nr + 1,
-					   iter->levels_alloc);
-				level = &iter->levels[iter->levels_nr++];
-				level->initialized = 0;
-				continue;
-			} else {
-				/*
-				 * The directory has already been
-				 * iterated over and iterated into;
-				 * we're done with it.
-				 */
-			}
+			else if (pop_level(iter) == 0)
+				return dir_iterator_abort(dir_iterator);
+			continue;
 		}
 
-		if (!level->dir) {
-			/*
-			 * This level is exhausted (or wasn't opened
-			 * successfully); pop up a level.
-			 */
-			if (--iter->levels_nr == 0)
-				return dir_iterator_abort(dir_iterator);
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
 
+		if (prepare_next_entry_data(iter, de))
 			continue;
-		}
 
-		/*
-		 * Loop until we find an entry that we can give back
-		 * to the caller:
-		 */
-		while (1) {
-			strbuf_setlen(&iter->base.path, level->prefix_len);
-			errno = 0;
-			de = readdir(level->dir);
-
-			if (!de) {
-				/* This level is exhausted; pop up a level. */
-				if (errno) {
-					warning_errno("error reading directory '%s'",
-						      iter->base.path.buf);
-				} else if (closedir(level->dir))
-					warning_errno("error closing directory '%s'",
-						      iter->base.path.buf);
-
-				level->dir = NULL;
-				if (--iter->levels_nr == 0)
-					return dir_iterator_abort(dir_iterator);
-				break;
-			}
-
-			if (is_dot_or_dotdot(de->d_name))
-				continue;
-
-			strbuf_addstr(&iter->base.path, de->d_name);
-			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
-				if (errno != ENOENT)
-					warning_errno("failed to stat '%s'",
-						      iter->base.path.buf);
-				continue;
-			}
-
-			/*
-			 * We have to set these each time because
-			 * the path strbuf might have been realloc()ed.
-			 */
-			iter->base.relative_path =
-				iter->base.path.buf + iter->levels[0].prefix_len;
-			iter->base.basename =
-				iter->base.path.buf + level->prefix_len;
-			level->dir_state = DIR_STATE_ITER;
-
-			return ITER_OK;
-		}
+		return ITER_OK;
 	}
 }
 
@@ -187,17 +182,32 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
-
-	if (!path || !*path)
-		BUG("empty path passed to dir_iterator_begin()");
+	int saved_errno;
 
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
+	iter->levels_nr = 0;
 
-	iter->levels_nr = 1;
-	iter->levels[0].initialized = 0;
+	/*
+	 * Note: stat already checks for NULL or empty strings and
+	 * inexistent paths.
+	 */
+	if (stat(iter->base.path.buf, &iter->base.st) < 0) {
+		saved_errno = errno;
+		goto error_out;
+	}
+
+	if (!S_ISDIR(iter->base.st.st_mode)) {
+		saved_errno = ENOTDIR;
+		goto error_out;
+	}
 
 	return dir_iterator;
+
+error_out:
+	dir_iterator_abort(dir_iterator);
+	errno = saved_errno;
+	return NULL;
 }
diff --git a/dir-iterator.h b/dir-iterator.h
index 970793d07a..0822821e56 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -8,19 +8,23 @@
  *
  * Iterate over a directory tree, recursively, including paths of all
  * types and hidden paths. Skip "." and ".." entries and don't follow
- * symlinks except for the original path.
+ * symlinks except for the original path. Note that the original path
+ * is not included in the iteration.
  *
  * Every time dir_iterator_advance() is called, update the members of
  * the dir_iterator structure to reflect the next path in the
  * iteration. The order that paths are iterated over within a
- * directory is undefined, but directory paths are always iterated
- * over before the subdirectory contents.
+ * directory is undefined, directory paths are always given before
+ * their contents.
  *
  * A typical iteration looks like this:
  *
  *     int ok;
  *     struct iterator *iter = dir_iterator_begin(path);
  *
+ *     if (!iter)
+ *             goto error_handler;
+ *
  *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
  *             if (want_to_stop_iteration()) {
  *                     ok = dir_iterator_abort(iter);
@@ -59,8 +63,9 @@ struct dir_iterator {
 };
 
 /*
- * Start a directory iteration over path. Return a dir_iterator that
- * holds the internal state of the iteration.
+ * Start a directory iteration over path. On success, return a
+ * dir_iterator that holds the internal state of the iteration.
+ * In case of failure, return NULL and set errno accordingly.
  *
  * The iteration includes all paths under path, not including path
  * itself and not including "." or ".." entries.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 63e55e6773..7ed81046d4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2143,13 +2143,22 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 						  const char *gitdir)
 {
-	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
-	struct ref_iterator *ref_iterator = &iter->base;
+	struct dir_iterator *diter;
+	struct files_reflog_iterator *iter;
+	struct ref_iterator *ref_iterator;
 	struct strbuf sb = STRBUF_INIT;
 
-	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
 	strbuf_addf(&sb, "%s/logs", gitdir);
-	iter->dir_iterator = dir_iterator_begin(sb.buf);
+
+	diter = dir_iterator_begin(sb.buf);
+	if(!diter)
+		return empty_ref_iterator_begin();
+
+	iter = xcalloc(1, sizeof(*iter));
+	ref_iterator = &iter->base;
+
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
+	iter->dir_iterator = diter;
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
 
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 84f50bed8c..fab1ff6237 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -17,6 +17,11 @@ int cmd__dir_iterator(int argc, const char **argv)
 
 	diter = dir_iterator_begin(path.buf);
 
+	if (!diter) {
+		printf("dir_iterator_begin failure: %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
+
 	while (dir_iterator_advance(diter) == ITER_OK) {
 		if (S_ISDIR(diter->st.st_mode))
 			printf("[d] ");
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 6e06dc038d..c739ed7911 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -52,4 +52,17 @@ test_expect_success 'dir-iterator should list files in the correct order' '
 	test_cmp expected-pre-order-output actual-pre-order-output
 '
 
+test_expect_success 'begin should fail upon inexistent paths' '
+	test_must_fail test-tool dir-iterator ./inexistent-path \
+		>actual-inexistent-path-output &&
+	echo "dir_iterator_begin failure: 2" >expected-inexistent-path-output &&
+	test_cmp expected-inexistent-path-output actual-inexistent-path-output
+'
+
+test_expect_success 'begin should fail upon non directory paths' '
+	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
+	echo "dir_iterator_begin failure: 20" >expected-non-dir-output &&
+	test_cmp expected-non-dir-output actual-non-dir-output
+'
+
 test_done
-- 
2.22.0

