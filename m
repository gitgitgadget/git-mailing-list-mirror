Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABF21F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeACUtv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:51 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34151 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbeACUtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:45 -0500
Received: by mail-wr0-f177.google.com with SMTP id 36so3027488wrh.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yMmwYrgCyAhXi+gnh83rRDhJ+uQ9eVCfPy3OHmkaAvQ=;
        b=rZc+aNJmvxSN5Tp/9/w/8UM0hvWGvcpVU4/XUcuUaq/XtehaFDHiVFNXe3J5Ygl26j
         1PBlXjOYRcYrBWu32erUYgfN0dRS6ATyeSOLF6wIpLTAIugMB70myNVcD5hUl3RH8f7O
         uUxlHF9Iyxsm3wxCYnJS3aaxtIEy0rlbgix+I6Vdc484mrWHGrHUGVk0UNfoRXe8i2F7
         OSVbueKgOogQssQ4u6w0hT5d00ZB2sHqorsWRUs9nAsh5kMo/1DJhg4nlWkBA5FxjErd
         uuT62BTmLBQ3zgECQeCXgnKiHIpAbevdl5eMXQbggw/u+x+++samXAgVNT6mXp8YqCa2
         Ud2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yMmwYrgCyAhXi+gnh83rRDhJ+uQ9eVCfPy3OHmkaAvQ=;
        b=K+hnEIyH6WCqjg7UcKno1Pb/QhralG2+FeHIdDOM2diGPO7C3vJH/bibsqBFs0WL+/
         xFMI5qkMtKIOqR/9RQNbJe/TU3NnZvxgZrrv2ZX+bs0EBwHHhJrm/gGb556RMfeT9F/u
         wsnk6oArUOjZnuovkD/cQIjpVTNMftNp6q2bl4unip7RlkELtkKXOBT5Cfbn2d4922/w
         vo2FR5swbe7K0XY9ySf7F6kJW5GIJoo+IPwhrtXyTsXteV1UnbwySw95G22yg0ru/ULy
         vOeSsLDsdkx1YEYmeChMPw6/tZUafaLvx+OfCw8VXviJqmaqx0BUfnEWT0mfPTYdsW9O
         FuBg==
X-Gm-Message-State: AKGB3mKkKYS+LMo+XsTbqP6rqMrejRTN4wweKLRcTHEQeXX/kfp8Rqp7
        ByEpE5aJOzCRCW4lqDc1wDQIVT10
X-Google-Smtp-Source: ACJfBouTuTCTiOGKz0aNeOEt2Ce4eBThjWOrE7eQqxhM7CJFHtQKbXTaQByU9QVJkwPnCQCO/D6JPQ==
X-Received: by 10.223.161.27 with SMTP id o27mr2808841wro.254.1515012583937;
        Wed, 03 Jan 2018 12:49:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l9sm1908443wrb.45.2018.01.03.12.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 12:49:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] dir.c: fix missing dir invalidation in untracked code
Date:   Wed,  3 Jan 2018 20:49:26 +0000
Message-Id: <20180103204928.3769-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180103204928.3769-1-avarab@gmail.com>
References: <20180103204928.3769-1-avarab@gmail.com>
In-Reply-To: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

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
---
 dir.c                             | 22 ++++++++++++++--------
 t/t7063-status-untracked-cache.sh |  4 ++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index edcb7bb462..163ca69df0 100644
--- a/dir.c
+++ b/dir.c
@@ -774,7 +774,16 @@ static void invalidate_directory(struct untracked_cache *uc,
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
@@ -1810,23 +1819,18 @@ static int valid_cached_dir(struct dir_struct *dir,
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
@@ -1858,8 +1862,10 @@ static int open_cached_dir(struct cached_dir *cdir,
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
2.15.1.424.g9478a66081

