Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9BA21F453
	for <e@80x24.org>; Wed, 13 Feb 2019 09:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbfBMJvy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 04:51:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45532 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733295AbfBMJvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 04:51:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id j3so892573pfi.12
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAxI0pIzoDFYZaznoqwtX9WY1tXsO6JduIwH7m/EEig=;
        b=pbJQWnsDXQh8x6Z+UiF8ZBhMEhmk0VIEGntxtdnxd5n9TQ9tNwdeOoAiJv/rlnmvJ/
         S25kYP9h+T6hwaH/lMrULV38G3+i/LopIWi/Cr1SAjmNLrDkB3OjIRa/GSgd/hyac/fb
         WZEB+ZDkW7x4xcPlCWBKKzVf1IKmV9PSFNoreXj1B4auMgxsDt6sucLdZpTwQJ0d5GOE
         5XqaaadIJehXA4ut5Z6K8P4nFhaUkxMzs5xBfSbk1+YnS9iS+H7Jq89MC09+MB8U9FQF
         6j+tjysZEz1M+ZMyT6R2jWwcaPkcwNfprT42n2EbWoUUHFJrmdPe8Iogjctd5Nj3ldwK
         SyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAxI0pIzoDFYZaznoqwtX9WY1tXsO6JduIwH7m/EEig=;
        b=QCX1iSObEEh7qsIkWvPSKP2BOgD5zy+pLr9YK50EaPMroi3StZG+sAWTi2pa6qmw9W
         A/rfCZL2JNCS5t8/uCKxlMlX/vC176XKvesQeBdPdhQdYBj6AbN/5Sz8/OBBrw0fZa5U
         Gpk3kemj4bQgUFS1pZ+/1uaKxST6MveoX4LZMaRhTT+YX/GlBtOd3f2FiyJpyRd9BL6E
         7OfivSZJknCGLQeGNMftl6rFjcB/IRi5y5doxFRRI9v9nS7Nfcd1Gd5mgWitiqg24aXJ
         rFu32O3JUltkAG4XCh9J3Tcj7TinXPn9zqyEAGU7yLz88kyD4/kelsHRJxmUWd5dtasP
         rXaA==
X-Gm-Message-State: AHQUAubHGPrkSjpg22z//1kES3qTP79vZdMr8BGQY7HgKAwXdX3AH/Id
        wUxYTYpsrQm+bBN6ufJidhQ=
X-Google-Smtp-Source: AHgI3IZwbu9wtijFog6MfIoj7h+5NpP5fA+cBa5k9hBwkOHa+QCR0ypMl7L2lVkHJWjNL5V21nsWGA==
X-Received: by 2002:a63:534c:: with SMTP id t12mr8050523pgl.205.1550051513350;
        Wed, 13 Feb 2019 01:51:53 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b15sm11052666pfj.44.2019.02.13.01.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:51:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 13 Feb 2019 16:51:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        luke@diamand.org, newren@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] read-cache.c: fix writing "link" index ext with null base oid
Date:   Wed, 13 Feb 2019 16:51:29 +0700
Message-Id: <20190213095129.31272-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190209112328.26317-1-pclouds@gmail.com>
References: <20190209112328.26317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 7db118303a (unpack_trees: fix breakage when o->src_index !=
o->dst_index - 2018-04-23) and changes in merge code to use separate
index_state for source and destination, when doing a merge with split
index activated, we may run into this line in unpack_trees():

    o->result.split_index = init_split_index(&o->result);

This is by itself not wrong. But this split index information is not
fully populated (and it's only so when move_cache_to_base_index() is
called, aka force splitting the index, or loading index_state from a
file). Both "base_oid" and "base" in this case remain null.

So when writing the main index down, we link to this index with null
oid (default value after init_split_index()), which also means "no split
index" internally. This triggers an incorrect base index refresh:

    warning: could not freshen shared index '.../sharedindex.0{40}'

This patch makes sure we will not refresh null base_oid (because the
file is never there). It also makes sure not to write "link" extension
with null base_oid in the first place (no point having it at
all). Read code already has protection against null base_oid.

There is also another side fix in remove_split_index() that causes a
crash when doing "git update-index --no-split-index" when base_oid in
the index file is null. In this case we will not load
istate->split_index->base but we dereference it anyway and are rewarded
with a segfault. This should not happen anymore, but it's still wrong to
dereference a potential NULL pointer, especially when we do check for
NULL pointer in the next code.

Reported-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 added a new test

 read-cache.c           |  5 +++--
 split-index.c          | 34 ++++++++++++++++++----------------
 t/t1700-split-index.sh | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8f644f68b4..d140b44f8f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2520,7 +2520,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return err;
 
 	/* Write extension data here */
-	if (!strip_extensions && istate->split_index) {
+	if (!strip_extensions && istate->split_index &&
+	    !is_null_oid(&istate->split_index->base_oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
 		err = write_link_extension(&sb, istate) < 0 ||
@@ -2794,7 +2795,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	ret = write_split_index(istate, lock, flags);
 
 	/* Freshen the shared index only if the split-index was written */
-	if (!ret && !new_shared_index) {
+	if (!ret && !new_shared_index && !is_null_oid(&si->base_oid)) {
 		const char *shared_index = git_path("sharedindex.%s",
 						    oid_to_hex(&si->base_oid));
 		freshen_shared_index(shared_index, 1);
diff --git a/split-index.c b/split-index.c
index 5820412dc5..a9d13611a4 100644
--- a/split-index.c
+++ b/split-index.c
@@ -440,24 +440,26 @@ void add_split_index(struct index_state *istate)
 void remove_split_index(struct index_state *istate)
 {
 	if (istate->split_index) {
-		/*
-		 * When removing the split index, we need to move
-		 * ownership of the mem_pool associated with the
-		 * base index to the main index. There may be cache entries
-		 * allocated from the base's memory pool that are shared with
-		 * the_index.cache[].
-		 */
-		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
+		if (istate->split_index->base) {
+			/*
+			 * When removing the split index, we need to move
+			 * ownership of the mem_pool associated with the
+			 * base index to the main index. There may be cache entries
+			 * allocated from the base's memory pool that are shared with
+			 * the_index.cache[].
+			 */
+			mem_pool_combine(istate->ce_mem_pool,
+					 istate->split_index->base->ce_mem_pool);
 
-		/*
-		 * The split index no longer owns the mem_pool backing
-		 * its cache array. As we are discarding this index,
-		 * mark the index as having no cache entries, so it
-		 * will not attempt to clean up the cache entries or
-		 * validate them.
-		 */
-		if (istate->split_index->base)
+			/*
+			 * The split index no longer owns the mem_pool backing
+			 * its cache array. As we are discarding this index,
+			 * mark the index as having no cache entries, so it
+			 * will not attempt to clean up the cache entries or
+			 * validate them.
+			 */
 			istate->split_index->base->cache_nr = 0;
+		}
 
 		/*
 		 * We can discard the split index because its
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f053bf83eb..ea5181aff9 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -447,4 +447,22 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
 	test_line_count = 0 cache-tree.out
 '
 
+test_expect_success 'do not refresh null base index' '
+	test_create_repo merge &&
+	(
+		cd merge &&
+		test_commit initial &&
+		git checkout -b side-branch &&
+		test_commit extra &&
+		git checkout master &&
+		git update-index --split-index &&
+		test_commit more &&
+		# must not write a new shareindex, or we wont catch the problem
+		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
+		# i.e. do not expect warnings like
+		# could not freshen shared index .../shareindex.00000...
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.21.0.rc0.328.g0e39304f8d

