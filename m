Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0ED1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeAXJas (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:30:48 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:46500 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeAXJap (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:30:45 -0500
Received: by mail-pg0-f54.google.com with SMTP id s9so2288009pgq.13
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUPW91W2KlzFVANid4kKLqxuHHOtanhGGvVU1XY1e0k=;
        b=XM3Tahg2ikxtXrfcTSGTzDLd08CJLz2Wdgv+GnG9Lf3jsCuE9UgJnb0KinfMRYVJWb
         Ry1rTyIz3jemow8RfWSOQ4OGocKSAXy8U1oFxHnak7SCT62N0/JqF6wZ8lTbnWax61uV
         BDlx3ecXveE3XQURACGwQ2I59s7tcpoT8UurufYLVIDUUPQUFZ4hQYfrtvAzKUeysW5r
         Ye06xW4tK5jrDXz8P2xSPsEhN4M5VRKnBcNZPYfJ1aheGCmTXdZFxe9/OA/cJkfHEQrR
         KrzbXj23Fq89/ihI6DIRk4PRO+gHqKB/o7+2L3x7fMo1UwgQxSI+yfSNvgX5EHO6pedS
         slBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUPW91W2KlzFVANid4kKLqxuHHOtanhGGvVU1XY1e0k=;
        b=epW8f+PyUEyPwtT9GYjTpiml8bO5UpVm7xSCrv/Q/z4tIKuQ+Ii/Q1uHzwfnApvxkC
         3O4/0vYM0GF8S9AesDQuGJ5C05K46tBLa1WohbUYf5mNW+NefnX6447w4w49GpiOiZ9x
         MVYdBt4n/klMZCBppwHPh0bBjYUoRU8sskZhd+RdAT+iYSN6HlnaQ0l6OKc3/abXM04p
         sqva4svJD1ocUso3nKJJ/8uLm64zK5/8bg7f3qmYTZ9U9TOufCMEimyo4kL6g+M8VRiD
         CL0rdwR6p8F9boo7B9z0VCgzpyFZ8DhteE/xqJIsubk20CFKTMYcSMknjAgS4QKBFEi4
         6dpw==
X-Gm-Message-State: AKwxytfERtLZ1WNq1mBCv8gWcGF/biLTQLYpCjx/an6o8bVxXF/zPK9B
        zVCaVs43YBexQvXugA5l2Ndd6A==
X-Google-Smtp-Source: AH8x227/jgWJXoXDMFByVOt8sKkr0YcUvZaA5jyfsfP9T++/omF8HRid/0rByRtLoFy1WaF9LvXbBg==
X-Received: by 10.101.98.193 with SMTP id m1mr6256978pgv.174.1516786244950;
        Wed, 24 Jan 2018 01:30:44 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id g15sm34596503pgu.52.2018.01.24.01.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:30:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:30:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] dir.c: fix missing dir invalidation in untracked code
Date:   Wed, 24 Jan 2018 16:30:21 +0700
Message-Id: <20180124093023.9071-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093023.9071-1-pclouds@gmail.com>
References: <20180118095036.29422-1-pclouds@gmail.com>
 <20180124093023.9071-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's start with how create a new directory cache after the last one
becomes invalid (e.g. because its dir mtime has changed...). In
open_cached_dir():

1. We start out with valid_cached_dir() returning false, which should
   call invalidate_directory() to put a directory state back to
   initial state, no untracked entries (untracked_nr zero), no sub
   directory traversal (dirs[].recurse zero).

2. Since the cache cannot be used, we go the slow path opendir() and
   go through items one by one via readdir(). All the directories on
   disk will be added back to the cache (if not already exist in
   dirs[]) and its flag "recurse" gets changed to one to note that
   it's part of the cached dir travesal next time.

3. By the time we reach close_cached_dir() we should have a good
   subdir list in dirs[]. Those with "recurse" flag set are the ones
   present in the on-disk directory. The directory is now marked
   "valid".

Next time read_directory() is called, since the directory is marked
valid, it will skip readdir(), go fast path and traverse through
dirs[] array instead.

Steps one and two need some tight cooperation. If a subdir is removed,
readdir() will not find it and of course we cannot examine/invalidate
it. To make sure removed directories on disk are gone from the cache,
step one must make sure recurse flag of all subdirs are zero.

But that's not true. If "valid" flag is already false, there is a
chance we go straight to the end of valid_cached_dir() without calling
invalidate_directory(). Or we fail to meet the "if (untracked-valid)"
condition and skip over the invalidate_directory().

After step 3, we mark the cache valid. Any stale subdir with incorrect
recurse flag becomes a real subdir next time we traverse the directory
using dirs[] array.

We could avoid this by making sure invalidate_directory() is always
called (therefore dirs[].recurse cleared) at the beginning of
open_cached_dir(). Which is what this patch does.

As to how we get into this situation, the key in the test is this
command

    git checkout master

where "one/file" is replaced with "one" in the index. This index
update triggers untracked_cache_invalidate_path(), which clears valid
flag of the root directory while keeping "recurse" flag on the subdir
"one" on. On the next git-status, we go through steps 1-3 above and
save an incorrect cache on disk. The second git-status blindly follows
the bad cache data and shows the problem.

This is arguably because of a bad design where "recurse" flag plays
double roles: whether a directory should be saved on disk, and whether
it is part of a directory traversal.

We need to keep recurse flag set at "checkout master" because of the
first role: we need to keep subdir caches (dir "two" for example has
not been touched at all, no reason to throw its cache away).

As long as we make sure to ignore/reset "recurse" flag at the
beginning of a directory traversal, we're good. But maybe eventually
we should separate these two roles.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                             | 22 ++++++++++++++--------
 t/t7063-status-untracked-cache.sh |  4 ++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index ee1605f004..44b4dd2ec8 100644
--- a/dir.c
+++ b/dir.c
@@ -733,7 +733,16 @@ static void invalidate_directory(struct untracked_cache *uc,
 				 struct untracked_cache_dir *dir)
 {
 	int i;
-	uc->dir_invalidated++;
+
+	/*
+	 * Invalidation increment here is just roughly correct. If
+	 * untracked_nr or any of dirs[].recurse is non-zero, we
+	 * should increment dir_invalidated too. But that's more
+	 * expensive to do.
+	 */
+	if (dir->valid)
+		uc->dir_invalidated++;
+
 	dir->valid = 0;
 	dir->untracked_nr = 0;
 	for (i = 0; i < dir->dirs_nr; i++)
@@ -1740,23 +1749,18 @@ static int valid_cached_dir(struct dir_struct *dir,
 	refresh_fsmonitor(istate);
 	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
 		if (lstat(path->len ? path->buf : ".", &st)) {
-			invalidate_directory(dir->untracked, untracked);
 			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
 			return 0;
 		}
 		if (!untracked->valid ||
 			match_stat_data_racy(istate, &untracked->stat_data, &st)) {
-			if (untracked->valid)
-				invalidate_directory(dir->untracked, untracked);
 			fill_stat_data(&untracked->stat_data, &st);
 			return 0;
 		}
 	}
 
-	if (untracked->check_only != !!check_only) {
-		invalidate_directory(dir->untracked, untracked);
+	if (untracked->check_only != !!check_only)
 		return 0;
-	}
 
 	/*
 	 * prep_exclude will be called eventually on this directory,
@@ -1788,8 +1792,10 @@ static int open_cached_dir(struct cached_dir *cdir,
 	if (valid_cached_dir(dir, untracked, istate, path, check_only))
 		return 0;
 	cdir->fdir = opendir(path->len ? path->buf : ".");
-	if (dir->untracked)
+	if (dir->untracked) {
+		invalidate_directory(dir->untracked, untracked);
 		dir->untracked->dir_opened++;
+	}
 	if (!cdir->fdir)
 		return -1;
 	return 0;
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index dba7f50bbb..46b947824f 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -707,7 +707,7 @@ test_expect_success SYMLINKS 'setup worktree for symlink test' '
 	git commit -m"second commit"
 '
 
-test_expect_failure SYMLINKS '"status" after symlink replacement should be clean with UC=true' '
+test_expect_success SYMLINKS '"status" after symlink replacement should be clean with UC=true' '
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
@@ -742,7 +742,7 @@ test_expect_success 'setup worktree for non-symlink test' '
 	git commit -m"second commit"
 '
 
-test_expect_failure '"status" after file replacement should be clean with UC=true' '
+test_expect_success '"status" after file replacement should be clean with UC=true' '
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
-- 
2.16.0.47.g3d9b0fac3a

