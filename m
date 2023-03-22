Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3FC76195
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCVQBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCVQBF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:01:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6108037707
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso6263464wms.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y5Cx5Ly972ypwoXXjEuCJjboDkjsHrxc4c8nogbdt8=;
        b=W2fP6zAr0C+FAMsErCdgs5fVmG0LXaszrsNyiaPEADUC0zZNR3Dkj2XLTlOW1dBzlI
         gnQl/fe1moddP5WlbysV5Z7mk8JnPVt3jH0FCuianarK1/QSdczs17X6oHGXLD20PZUJ
         vAcqWicly6GuCP93SGYfmvU6GG5WirwLVJ3bKTmGBIb1zssO8nl7hYbi39tbvK8rEWY+
         nt/Q3jIfLtamf1HHM/w9+hglNbD1/bR9p7tJYGSlzPjLEf8tPdMxVZ7qtQOBL9gfMJGB
         hH+e1IYWFW1nV0Wx7GWapNaJ4cRB14SnUekuoI4PxvuK0z4VtIiEGaoQ1YxSMzT6U8tO
         6y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y5Cx5Ly972ypwoXXjEuCJjboDkjsHrxc4c8nogbdt8=;
        b=TA3OLkZQNb1uc41xUq7MNlyXNSuf0qsvLBOh3sceGE498tvRgoxvZQluZTHohPkEx4
         Td87yw5xzHFgyNEeWdSkvlOky8+loGpTT0yzLNM4hE+ND7JMGfS5szLJb5PsxFASRNyo
         2VBacA4Bkac89A3z1ctpiJY4T5dk2q4mrqjAAXqQFFWSYNO78Yl33dFZCpIB3XBFcfty
         pbK+SRFbnljhpzHlBn67oKgxFoOAgcmIfcQRDBHYT1baT7Dv26fCjIOp8TWjCFZyGWTq
         gCnZUMX0donZSPYnOUKgDMq98LtAXculDxTvA4ljIywkoXAkyAJaoRo2wHCILnjPmaUl
         iJSQ==
X-Gm-Message-State: AO0yUKVDso2h0BL0osarERjMLmbwKrrvkuz25pvnKHNoNJURIpHqNTQU
        p7lFi8qbis6H8CoF66Ri0v8N/q+xUms=
X-Google-Smtp-Source: AK7set+mUzKzomb0FHxm/OJ1dJEJNlt4dhJChn6yDRn0sb4BZpl1xcUoXdNOyDnrRxeJ9yRaN/Wz/Q==
X-Received: by 2002:a05:600c:218:b0:3ee:2552:7512 with SMTP id 24-20020a05600c021800b003ee25527512mr43997wmi.13.1679500862554;
        Wed, 22 Mar 2023 09:01:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm7488990wmb.36.2023.03.22.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:01:02 -0700 (PDT)
Message-Id: <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 16:00:57 +0000
Subject: [PATCH 2/4] split-index; stop abusing the `base_oid` to strip the
 "link" extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a split-index is in effect, the `$GIT_DIR/index` file needs to
contain a "link" extension that contains all the information about the
split-index, including the information about the shared index.

However, in some cases Git needs to suppress writing that "link"
extension (i.e. to fall back to writing a full index) even if the
in-memory index structure _has_ a `split_index` configured. This is the
case e.g. when "too many not shared" index entries exist.

In such instances, the current code sets the `base_oid` field of said
`split_index` structure to all-zero to indicate that `do_write_index()`
should skip writing the "link" extension.

This can lead to problems later on, when the in-memory index is still
used to perform other operations and eventually wants to write a
split-index, detects the presence of the `split_index` and reuses that,
too (under the assumption that it has been initialized correctly and
still has a non-null `base_oid`).

Let's stop zeroing out the `base_oid` to indicate that the "link"
extension should not be written.

One might be tempted to simply call `discard_split_index()` instead,
under the assumption that Git decided to write a non-split index and
therefore the the `split_index` structure might no longer be wanted.
However, that is not possible because that would release index entries
in `split_index->base` that are likely to still be in use. Therefore we
cannot do that.

The next best thing we _can_ do is to introduce a flag, specifically
indicating when the "link" extension should be skipped. So that's what
we do here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c                 | 37 ++++++++++++++++++++++--------------
 t/t7527-builtin-fsmonitor.sh |  2 +-
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b09128b1884..8fcb2d54c05 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2868,6 +2868,12 @@ static int record_ieot(void)
 	return !git_config_get_index_threads(&val) && val != 1;
 }
 
+enum strip_extensions {
+	WRITE_ALL_EXTENSIONS = 0,
+	STRIP_ALL_EXTENSIONS = 1,
+	STRIP_LINK_EXTENSION_ONLY = 2
+};
+
 /*
  * On success, `tempfile` is closed. If it is the temporary file
  * of a `struct lock_file`, we will therefore effectively perform
@@ -2876,7 +2882,7 @@ static int record_ieot(void)
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  int strip_extensions, unsigned flags)
+			  enum strip_extensions strip_extensions, unsigned flags)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -3045,7 +3051,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	if (!strip_extensions && istate->split_index &&
+	if (strip_extensions == WRITE_ALL_EXTENSIONS && istate->split_index &&
 	    !is_null_oid(&istate->split_index->base_oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
@@ -3060,7 +3066,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
+	if (strip_extensions != STRIP_ALL_EXTENSIONS && !drop_cache_tree && istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
@@ -3070,7 +3076,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->resolve_undo) {
+	if (strip_extensions != STRIP_ALL_EXTENSIONS && istate->resolve_undo) {
 		struct strbuf sb = STRBUF_INIT;
 
 		resolve_undo_write(&sb, istate->resolve_undo);
@@ -3081,7 +3087,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->untracked) {
+	if (strip_extensions != STRIP_ALL_EXTENSIONS && istate->untracked) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_untracked_extension(&sb, istate->untracked);
@@ -3092,7 +3098,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->fsmonitor_last_update) {
+	if (strip_extensions != STRIP_ALL_EXTENSIONS && istate->fsmonitor_last_update) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_fsmonitor_extension(&sb, istate);
@@ -3166,8 +3172,14 @@ static int commit_locked_index(struct lock_file *lk)
 		return commit_lock_file(lk);
 }
 
+/*
+ * Write the Git index into a `.lock` file
+ *
+ * If `strip_link_extension` is non-zero, avoid writing any "link" extension
+ * (used by the split-index feature).
+ */
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
-				 unsigned flags)
+				 unsigned flags, int strip_link_extension)
 {
 	int ret;
 	int was_full = istate->sparse_index == INDEX_EXPANDED;
@@ -3185,7 +3197,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, 0, flags);
+	ret = do_write_index(istate, lock->tempfile, strip_link_extension ? STRIP_LINK_EXTENSION_ONLY : 0, flags);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
 
@@ -3214,7 +3226,7 @@ static int write_split_index(struct index_state *istate,
 {
 	int ret;
 	prepare_to_write_split_index(istate);
-	ret = do_write_locked_index(istate, lock, flags);
+	ret = do_write_locked_index(istate, lock, flags, 0);
 	finish_writing_split_index(istate);
 	return ret;
 }
@@ -3366,9 +3378,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if ((!si && !test_split_index_env) ||
 	    alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
-		if (si)
-			oidclr(&si->base_oid);
-		ret = do_write_locked_index(istate, lock, flags);
+		ret = do_write_locked_index(istate, lock, flags, 1);
 		goto out;
 	}
 
@@ -3394,8 +3404,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		/* Same initial permissions as the main .git/index file */
 		temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
 		if (!temp) {
-			oidclr(&si->base_oid);
-			ret = do_write_locked_index(istate, lock, flags);
+			ret = do_write_locked_index(istate, lock, flags, 1);
 			goto out;
 		}
 		ret = write_shared_index(istate, &temp, flags);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index cbafdd69602..9fab9a2ab38 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1003,7 +1003,7 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
 	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
 '
 
-test_expect_failure 'split-index and FSMonitor work well together' '
+test_expect_success 'split-index and FSMonitor work well together' '
 	git init split-index &&
 	test_when_finished "git -C \"$PWD/split-index\" \
 		fsmonitor--daemon stop" &&
-- 
gitgitgadget

