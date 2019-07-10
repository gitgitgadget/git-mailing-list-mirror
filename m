Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80091F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfGKAAT (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:00:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36407 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKAAS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:00:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so3410173qkl.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnmmwIJNP9kkVUAS3cBc0nlBHoiLXYNHoaymUDNzq/A=;
        b=nMKZeqYKILfgDHITJOw9BelDx4gBYSuykPnnjiEmpxOBn/xHb5Xu2Ua2OjnncJTMIy
         nF+TTBaHt47gPnkPqvR9zHbtXqlwLPgTNH7rYDCYgR3ssjCU70tu4alnGGh0lKx7zp1E
         eBp9GAvXQf7ziBzMp3r2P1/MkXHXeJADhsy2V5Mv4vqQ2b/nDMfJP0ib2mf2PfoRn4KL
         Y0r4aZKCNUEne0/8wxI3/DWSa1MT/lGKKdjdDSKbG3PwZd2B8Evau1A+5XQiDG9UVd1b
         x/Nhssc5xcrLX5z2wxIvOJpUvGnYrifPeMmCjxSLkP8FQpR+TZxi+K7Oo6M1y5gt0BEw
         EDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnmmwIJNP9kkVUAS3cBc0nlBHoiLXYNHoaymUDNzq/A=;
        b=k69MsfFZr/xHJUiInWf+W42zgNYhko3XBOaAr62kdgoVq8ve7GeDqbD664AUDs3OW8
         WceKAc4i1i4afYo3cju3YJjFC+zy+faeOrJMV1OeieKGCQp3ydIbcaQ03vTOWtXvkaiN
         /EZc+cXM1MofdWAMH/ewU/sDxg7oPGUEsM13YL6te64sW5op3iQDIjt5GNmWBa+n/L4R
         sLEnTIHnJRaiILnfWPHh86N7WLA0EmXaR+oAhAnlb9GV3bwbgdFM93UiSKbyFhX5lk3/
         1AVBcXQX5sLz14FdQXpytPNqHcQxAnUDqMR1pDYSlgXU0cjZNCtFGBMvWjFHAF9ZPDQD
         VT2Q==
X-Gm-Message-State: APjAAAX2UOzQg25XpjRPHG0SR/Crzx8cEMSgQL3O/DPyDJLtCf0XkrkR
        JBqqNK36dX8vYeD4BRjo2AA2uQ==
X-Google-Smtp-Source: APXvYqzgDYJZq9TRPdA0552l5djc0ZHtNDhcQo2qVJODtZJoCxvM00xf60TYj9RDHxsEBbJOO6yp+w==
X-Received: by 2002:a37:48d0:: with SMTP id v199mr745584qka.318.1562803216928;
        Wed, 10 Jul 2019 17:00:16 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.17.00.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:00:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [GSoC][PATCH v8 06/10] dir-iterator: add flags parameter to dir_iterator_begin
Date:   Wed, 10 Jul 2019 20:59:00 -0300
Message-Id: <fe838d7eb4a3f9affca32478397abf8aca9b0230.1562801255.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the possibility of giving flags to dir_iterator_begin to initialize
a dir-iterator with special options.

Currently possible flags are:
- DIR_ITERATOR_PEDANTIC, which makes dir_iterator_advance abort
immediately in the case of an error, instead of keep looking for the
next valid entry;
- DIR_ITERATOR_FOLLOW_SYMLINKS, which makes the iterator follow
symlinks and include linked directories' contents in the iteration.

These new flags will be used in a subsequent patch.

Also add tests for the flags' usage and adjust refs/files-backend.c to
the new dir_iterator_begin signature.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir-iterator.c               | 56 +++++++++++++++++--------
 dir-iterator.h               | 55 ++++++++++++++++++++-----
 refs/files-backend.c         |  2 +-
 t/helper/test-dir-iterator.c | 34 +++++++++++----
 t/t0066-dir-iterator.sh      | 80 ++++++++++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+), 36 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 594fe4d67b..b17e9f970a 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -38,13 +38,16 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/* Combination of flags for this dir-iterator */
+	unsigned int flags;
 };
 
 /*
  * Push a level in the iter stack and initialize it with information from
  * the directory pointed by iter->base->path. It is assumed that this
  * strbuf points to a valid directory path. Return 0 on success and -1
- * otherwise, leaving the stack unchanged.
+ * otherwise, setting errno accordingly and leaving the stack unchanged.
  */
 static int push_level(struct dir_iterator_int *iter)
 {
@@ -59,11 +62,13 @@ static int push_level(struct dir_iterator_int *iter)
 
 	level->dir = opendir(iter->base.path.buf);
 	if (!level->dir) {
+		int saved_errno = errno;
 		if (errno != ENOENT) {
 			warning_errno("error opening directory '%s'",
 				      iter->base.path.buf);
 		}
 		iter->levels_nr--;
+		errno = saved_errno;
 		return -1;
 	}
 
@@ -90,11 +95,13 @@ static int pop_level(struct dir_iterator_int *iter)
 /*
  * Populate iter->base with the necessary information on the next iteration
  * entry, represented by the given dirent de. Return 0 on success and -1
- * otherwise.
+ * otherwise, setting errno accordingly.
  */
 static int prepare_next_entry_data(struct dir_iterator_int *iter,
 				   struct dirent *de)
 {
+	int err, saved_errno;
+
 	strbuf_addstr(&iter->base.path, de->d_name);
 	/*
 	 * We have to reset these because the path strbuf might have
@@ -105,13 +112,17 @@ static int prepare_next_entry_data(struct dir_iterator_int *iter,
 	iter->base.basename = iter->base.path.buf +
 			      iter->levels[iter->levels_nr - 1].prefix_len;
 
-	if (lstat(iter->base.path.buf, &iter->base.st)) {
-		if (errno != ENOENT)
-			warning_errno("failed to stat '%s'", iter->base.path.buf);
-		return -1;
-	}
+	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
+		err = stat(iter->base.path.buf, &iter->base.st);
+	else
+		err = lstat(iter->base.path.buf, &iter->base.st);
 
-	return 0;
+	saved_errno = errno;
+	if (err && errno != ENOENT)
+		warning_errno("failed to stat '%s'", iter->base.path.buf);
+
+	errno = saved_errno;
+	return err;
 }
 
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
@@ -119,11 +130,11 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 	struct dir_iterator_int *iter =
 		(struct dir_iterator_int *)dir_iterator;
 
-	if (S_ISDIR(iter->base.st.st_mode)) {
-		if (push_level(iter) && iter->levels_nr == 0) {
-			/* Pushing the first level failed */
-			return dir_iterator_abort(dir_iterator);
-		}
+	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
+		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
+			goto error_out;
+		if (iter->levels_nr == 0)
+			goto error_out;
 	}
 
 	/* Loop until we find an entry that we can give back to the caller. */
@@ -137,22 +148,32 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 		de = readdir(level->dir);
 
 		if (!de) {
-			if (errno)
+			if (errno) {
 				warning_errno("error reading directory '%s'",
 					      iter->base.path.buf);
-			else if (pop_level(iter) == 0)
+				if (iter->flags & DIR_ITERATOR_PEDANTIC)
+					goto error_out;
+			} else if (pop_level(iter) == 0) {
 				return dir_iterator_abort(dir_iterator);
+			}
 			continue;
 		}
 
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
-		if (prepare_next_entry_data(iter, de))
+		if (prepare_next_entry_data(iter, de)) {
+			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
+				goto error_out;
 			continue;
+		}
 
 		return ITER_OK;
 	}
+
+error_out:
+	dir_iterator_abort(dir_iterator);
+	return ITER_ERROR;
 }
 
 int dir_iterator_abort(struct dir_iterator *dir_iterator)
@@ -178,7 +199,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }
 
-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -189,6 +210,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 	iter->levels_nr = 0;
+	iter->flags = flags;
 
 	/*
 	 * Note: stat already checks for NULL or empty strings and
diff --git a/dir-iterator.h b/dir-iterator.h
index 9b4cb7acd2..08229157c6 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -20,7 +20,8 @@
  * A typical iteration looks like this:
  *
  *     int ok;
- *     struct dir_iterator *iter = dir_iterator_begin(path);
+ *     unsigned int flags = DIR_ITERATOR_PEDANTIC;
+ *     struct dir_iterator *iter = dir_iterator_begin(path, flags);
  *
  *     if (!iter)
  *             goto error_handler;
@@ -44,6 +45,29 @@
  * dir_iterator_advance() again.
  */
 
+/*
+ * Flags for dir_iterator_begin:
+ *
+ * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
+ *   in case of an error at dir_iterator_advance(), which is to keep
+ *   looking for a next valid entry. With this flag, resources are freed
+ *   and ITER_ERROR is returned immediately. In both cases, a meaningful
+ *   warning is emitted. Note: ENOENT errors are always ignored so that
+ *   the API users may remove files during iteration.
+ *
+ * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks.
+ *   i.e., linked directories' contents will be iterated over and
+ *   iter->base.st will contain information on the referred files,
+ *   not the symlinks themselves, which is the default behavior. Broken
+ *   symlinks are ignored.
+ *
+ * Warning: circular symlinks are also followed when
+ * DIR_ITERATOR_FOLLOW_SYMLINKS is set. The iteration may end up with
+ * an ELOOP if they happen and DIR_ITERATOR_PEDANTIC is set.
+ */
+#define DIR_ITERATOR_PEDANTIC (1 << 0)
+#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
+
 struct dir_iterator {
 	/* The current path: */
 	struct strbuf path;
@@ -58,29 +82,38 @@ struct dir_iterator {
 	/* The current basename: */
 	const char *basename;
 
-	/* The result of calling lstat() on path: */
+	/*
+	 * The result of calling lstat() on path; or stat(), if the
+	 * DIR_ITERATOR_FOLLOW_SYMLINKS flag was set at
+	 * dir_iterator's initialization.
+	 */
 	struct stat st;
 };
 
 /*
- * Start a directory iteration over path. On success, return a
- * dir_iterator that holds the internal state of the iteration.
- * In case of failure, return NULL and set errno accordingly.
+ * Start a directory iteration over path with the combination of
+ * options specified by flags. On success, return a dir_iterator
+ * that holds the internal state of the iteration. In case of
+ * failure, return NULL and set errno accordingly.
  *
  * The iteration includes all paths under path, not including path
  * itself and not including "." or ".." entries.
  *
- * path is the starting directory. An internal copy will be made.
+ * Parameters are:
+ *  - path is the starting directory. An internal copy will be made.
+ *  - flags is a combination of the possible flags to initialize a
+ *    dir-iterator or 0 for default behavior.
  */
-struct dir_iterator *dir_iterator_begin(const char *path);
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
 
 /*
  * Advance the iterator to the first or next item and return ITER_OK.
  * If the iteration is exhausted, free the dir_iterator and any
- * resources associated with it and return ITER_DONE. On error, free
- * dir_iterator and associated resources and return ITER_ERROR. It is
- * a bug to use iterator or call this function again after it has
- * returned ITER_DONE or ITER_ERROR.
+ * resources associated with it and return ITER_DONE.
+ *
+ * It is a bug to use iterator or call this function again after it
+ * has returned ITER_DONE or ITER_ERROR (which may be returned iff
+ * the DIR_ITERATOR_PEDANTIC flag was set).
  */
 int dir_iterator_advance(struct dir_iterator *iterator);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ed81046d4..b1f8f53a09 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2150,7 +2150,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 
 	strbuf_addf(&sb, "%s/logs", gitdir);
 
-	diter = dir_iterator_begin(sb.buf);
+	diter = dir_iterator_begin(sb.buf, 0);
 	if(!diter)
 		return empty_ref_iterator_begin();
 
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index fab1ff6237..a5b96cb0dc 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -4,29 +4,44 @@
 #include "iterator.h"
 #include "dir-iterator.h"
 
-/* Argument is a directory path to iterate over */
+/*
+ * usage:
+ * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
+ */
 int cmd__dir_iterator(int argc, const char **argv)
 {
 	struct strbuf path = STRBUF_INIT;
 	struct dir_iterator *diter;
+	unsigned int flags = 0;
+	int iter_status;
+
+	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
+		if (strcmp(*argv, "--follow-symlinks") == 0)
+			flags |= DIR_ITERATOR_FOLLOW_SYMLINKS;
+		else if (strcmp(*argv, "--pedantic") == 0)
+			flags |= DIR_ITERATOR_PEDANTIC;
+		else
+			die("invalid option '%s'", *argv);
+	}
 
-	if (argc < 2)
-		die("BUG: test-dir-iterator needs one argument");
-
-	strbuf_add(&path, argv[1], strlen(argv[1]));
+	if (!*argv || argc != 1)
+		die("dir-iterator needs exactly one non-option argument");
 
-	diter = dir_iterator_begin(path.buf);
+	strbuf_add(&path, *argv, strlen(*argv));
+	diter = dir_iterator_begin(path.buf, flags);
 
 	if (!diter) {
 		printf("dir_iterator_begin failure: %d\n", errno);
 		exit(EXIT_FAILURE);
 	}
 
-	while (dir_iterator_advance(diter) == ITER_OK) {
+	while ((iter_status = dir_iterator_advance(diter)) == ITER_OK) {
 		if (S_ISDIR(diter->st.st_mode))
 			printf("[d] ");
 		else if (S_ISREG(diter->st.st_mode))
 			printf("[f] ");
+		else if (S_ISLNK(diter->st.st_mode))
+			printf("[s] ");
 		else
 			printf("[?] ");
 
@@ -34,5 +49,10 @@ int cmd__dir_iterator(int argc, const char **argv)
 		       diter->path.buf);
 	}
 
+	if (iter_status != ITER_DONE) {
+		printf("dir_iterator_advance failure\n");
+		return 1;
+	}
+
 	return 0;
 }
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index cc4b19c34c..9354d3f1ed 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -65,4 +65,84 @@ test_expect_success 'begin should fail upon non directory paths' '
 	test_cmp expected-non-dir-output actual-non-dir-output
 '
 
+test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
+	cat >expected-no-permissions-output <<-EOF &&
+	[d] (a) [a] ./dir3/a
+	EOF
+
+	mkdir -p dir3/a &&
+	>dir3/a/b &&
+	chmod 0 dir3/a &&
+
+	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
+	test_cmp expected-no-permissions-output actual-no-permissions-output &&
+	chmod 755 dir3/a &&
+	rm -rf dir3
+'
+
+test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
+	cat >expected-no-permissions-pedantic-output <<-EOF &&
+	[d] (a) [a] ./dir3/a
+	dir_iterator_advance failure
+	EOF
+
+	mkdir -p dir3/a &&
+	>dir3/a/b &&
+	chmod 0 dir3/a &&
+
+	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
+		>actual-no-permissions-pedantic-output &&
+	test_cmp expected-no-permissions-pedantic-output \
+		actual-no-permissions-pedantic-output &&
+	chmod 755 dir3/a &&
+	rm -rf dir3
+'
+
+test_expect_success SYMLINKS 'setup dirs with symlinks' '
+	mkdir -p dir4/a &&
+	mkdir -p dir4/b/c &&
+	>dir4/a/d &&
+	ln -s d dir4/a/e &&
+	ln -s ../b dir4/a/f &&
+
+	mkdir -p dir5/a/b &&
+	mkdir -p dir5/a/c &&
+	ln -s ../c dir5/a/b/d &&
+	ln -s ../ dir5/a/b/e &&
+	ln -s ../../ dir5/a/b/f
+'
+
+test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
+	cat >expected-no-follow-sorted-output <<-EOF &&
+	[d] (a) [a] ./dir4/a
+	[d] (b) [b] ./dir4/b
+	[d] (b/c) [c] ./dir4/b/c
+	[f] (a/d) [d] ./dir4/a/d
+	[s] (a/e) [e] ./dir4/a/e
+	[s] (a/f) [f] ./dir4/a/f
+	EOF
+
+	test-tool dir-iterator ./dir4 >out &&
+	sort out >actual-no-follow-sorted-output &&
+
+	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
+'
+
+test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
+	cat >expected-follow-sorted-output <<-EOF &&
+	[d] (a) [a] ./dir4/a
+	[d] (a/f) [f] ./dir4/a/f
+	[d] (a/f/c) [c] ./dir4/a/f/c
+	[d] (b) [b] ./dir4/b
+	[d] (b/c) [c] ./dir4/b/c
+	[f] (a/d) [d] ./dir4/a/d
+	[f] (a/e) [e] ./dir4/a/e
+	EOF
+
+	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
+	sort out >actual-follow-sorted-output &&
+
+	test_cmp expected-follow-sorted-output actual-follow-sorted-output
+'
+
 test_done
-- 
2.22.0

