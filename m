Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFD1C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiGHQ0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiGHQ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B2F6A
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:25:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p4so3384161wms.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=0yc4f6BN9XkcJKB+aBFwXZF6Glat4pFQoTqrGB7dE+4=;
        b=BZzvCk+DxA6daALQe+lW7YEfZK6DX9vIthOFU0OgfurmqZETaVrkhZatqS1CC3FOsD
         EgNRFIc1G3C1nlxd6MCsD2etSoL8lpuxptqNDU/haOvWSorKCwZ4UzhUgjC8cPqHV0JM
         PtLBT37rvTpL4RKvS+0M4qMVhiCNHm7xy3cfk5T7l25fFROUA9Lxds/BjtrKC/mV+52I
         d6ZGItIu7xDhy+2L5WcYVCk/o2Y2fhjOD+j1hiviT/gdrAZ5v2zEVsGAz0/u4my9dT8M
         DdHMCRyTaRS3gzVbwFLAFsD8oQAgDSOGBCABn6TJHLD2SR8am3P5W7PUHeNG19QWwMVW
         EW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=0yc4f6BN9XkcJKB+aBFwXZF6Glat4pFQoTqrGB7dE+4=;
        b=uTo0ixs5lC5tyhnGOZNwpP1Q0tf59Jl38iErq8BwtddZw4zdKaiVpbyDkF0SPk9QJ/
         J3O0JvETG/u3ZY7bgMvT8jdR7wczz9NxTM3h85I8LzoDlgxWeyVE+0y5vTL1ucs6SYbW
         ZrrSpb+ZPo52X63KftNCly+655mLVNFrP7gNVPTM1FUJKzF7nDrbNsk9ajJ7DXhlGg5w
         kMpHHu6D99ouKU9MI+0IjDwqeUpXUXqPnghkAo+47QaheYUcpN2eb5vdJZmkifdQxdcm
         TnzH4uFjcfMzCJDPHp9c9EGodcK5IxJCD3JCn4YhAYSA7Umk87S79C7v1KkvDpRMtJ+B
         tGhg==
X-Gm-Message-State: AJIora+LzVgoumDhPNRiOWRsjgBJojvv9H12O6U6Xbn9gZmyxa3M1LHP
        Lj3/486seYhoCNTV1u/589k1aIe+fHI=
X-Google-Smtp-Source: AGRyM1v+e4oIF5OS6JX8Zy1NANJceDOhxXAZ5XmhKJaiuRne57yu06NU8oF9Q3bMM+nL9vPRsxYH7g==
X-Received: by 2002:a05:600c:3b8c:b0:3a0:4cc2:2b62 with SMTP id n12-20020a05600c3b8c00b003a04cc22b62mr621016wms.185.1657297525715;
        Fri, 08 Jul 2022 09:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0021baf5e590dsm41308486wrb.71.2022.07.08.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:25:25 -0700 (PDT)
Message-Id: <8c24cd7737b29d461788b71f6a94eb74c468ad33.1657297520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
        <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 16:25:19 +0000
Subject: [PATCH v2 4/4] xdiff: introduce XDL_ALLOC_GROW()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a helper to grow an array. This is analogous to ALLOC_GROW() in
the rest of the codebase but returns −1 on allocation failure to
accommodate other users of libxdiff such as libgit2. It will also
return a error if the multiplication overflows while calculating the
new allocation size. Note that this keeps doubling on reallocation
like the code it is replacing rather than increasing the existing size
by half like ALLOC_GROW(). It does however copy ALLOC_GROW()'s trick
of adding a small amount to the new allocation to avoid a lot of
reallocations at small sizes.

Note that xdl_alloc_grow_helper() uses long rather than size_t for
`nr` and `alloc` to match the existing code.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xmacros.h  | 10 ++++++++++
 xdiff/xprepare.c | 19 ++++---------------
 xdiff/xutils.c   | 17 +++++++++++++++++
 xdiff/xutils.h   |  3 ++-
 4 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 0977d1615ac..8487bb396fa 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -58,4 +58,14 @@ do { \
 /* Allocate an array of nr zeroed out elements, returns NULL on failure */
 #define XDL_CALLOC_ARRAY(p, nr)	((p) = xdl_calloc(nr, sizeof(*(p))))
 
+/*
+ * Ensure array p can accommodate at least nr elements, growing the
+ * array and updating alloc (which is the number of allocated
+ * elements) as necessary. Frees p and returns -1 on failure, returns
+ * 0 on success
+ */
+#define XDL_ALLOC_GROW(p, nr, alloc)	\
+	(-!((nr) <= (alloc) ||		\
+	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
+
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b016570c488..c84549f6c50 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -111,7 +111,6 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
-	xdlclass_t **rcrecs;
 
 	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
@@ -127,14 +126,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 			return -1;
 		}
 		rcrec->idx = cf->count++;
-		if (cf->count > cf->alloc) {
-			cf->alloc *= 2;
-			if (!(rcrecs = (xdlclass_t **) xdl_realloc(cf->rcrecs, cf->alloc * sizeof(xdlclass_t *)))) {
-
+		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
-			}
-			cf->rcrecs = rcrecs;
-		}
 		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->line = line;
 		rcrec->size = rec->size;
@@ -163,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs, **rrecs;
+	xrecord_t **recs;
 	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
@@ -190,12 +183,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (nrec >= narec) {
-				narec *= 2;
-				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *))))
-					goto abort;
-				recs = rrecs;
-			}
+			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = prev;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 115b2b1640b..9e36f24875d 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -432,3 +432,20 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 
 	return 0;
 }
+
+void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
+{
+	void *tmp = NULL;
+	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
+	if (nr > n)
+		n = nr;
+	if (SIZE_MAX / size >= n)
+		tmp = xdl_realloc(p, n * size);
+	if (tmp) {
+		*alloc = n;
+	} else {
+		xdl_free(p);
+		*alloc = 0;
+	}
+	return tmp;
+}
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fba7bae03c7..fd0bba94e8b 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -42,6 +42,7 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 		       int line1, int count1, int line2, int count2);
 
-
+/* Do not call this function, use XDL_ALLOC_GROW instead */
+void* xdl_alloc_grow_helper(void* p, long nr, long* alloc, size_t size);
 
 #endif /* #if !defined(XUTILS_H) */
-- 
gitgitgadget
