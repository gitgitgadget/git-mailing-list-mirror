Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A32D879C
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379955; cv=none; b=MEBLSBoeq/6bfElcbiSS2+hyC83MPAOsR92onJRUARUnFINSOoqNmFpZZArQILRz5vf5VGWwyweh4ZUaPYf53u1EvUnESUDtFe3Wfy4bIGFyf9Flwxyjj3MWCm6ueNflgTR/Fb89Md2JhUpkwGa2yPm3eTRnGwJnK9XCy7K6sVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379955; c=relaxed/simple;
	bh=TvZi6a7U/ynuwRIfaO5HbjgjhSZAEAj6ZEsKh0lVNh4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UjaC96Q3TqKOeDCTIPURMZqTHyRGOKCLjLPFgEs5ZfGyHpjhWYPtQ09ki8DvtsDzTJhdwgAGVRjXrX7LcC5Aoz8zv+TpnqJy3pXIPTfSPfdSZBJFacAmEjzEHhYJTZ2mthMf1NHSZh9pMsv1LztUN3e77VaucXo0j3gu5ObbEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvUjJr2C; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvUjJr2C"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-11beb0a7bd6so236317c88.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379953; x=1767984753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bTWtsk40QJdq+WFYanEleEjNvob31nwf+eMAWYadsE=;
        b=YvUjJr2CZ5U2GnJjbHSGHJQ6n2s5TXarrETyyQWw/vCKqTxQuocVsizn0m5WsJgp4m
         WkmPc9B8aDR73mAd53ao8kz2KV52jWmbTaFWKUf4diZ382yNb2wlcRBRjTqMXzWUZpLw
         QVsGUmyZE9w1io8hqXUhxz1yP/1V0+VnRQHKHqslmBQbiztxJfQjU4CB6Zzxt8/eIGhD
         lFgf5YF9x+3cWs3kInRelGkUZyeRmfiysditz9n7Zr3dxmti4KAAImDdYHRKRI1yy9WS
         mUx7CzTn2FRgrcp83RpYx/rZ4U9PhVKzeqxQKD85AbULqP9uP1oioljASfVYJ+bBiD94
         Tbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379953; x=1767984753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bTWtsk40QJdq+WFYanEleEjNvob31nwf+eMAWYadsE=;
        b=sZhwpID3Qanhv1og7LMqTtPvI76z0mXxGMni1NFcKoAxeBdVOnpzLZ6DVKCM7KzM5y
         /fySBwYfjEhBASbw/l3RGKlPtPHKy0HTDbLNpf/BhPkRVsfF3mK9ui8SgEMROjdlHO4K
         Crdy4GI1mShzx4eOSfquGh3/N6Dj0QlxdGz/J4L7bF6Yt+6fLbJ62KqjXxBycXQwqiS4
         RSZ4Kr4ug/os8jOCuzgqKtgnXrf1n6ygOPAUG28XgKU/as//5Gx3IEOLONkl+UV+jKmw
         qiHgQ1nZm5VAffmHvXYftHTgs+kSw3hqooycilBH89ETCxtunddi+bKhFpfXWSrWVO37
         exmA==
X-Gm-Message-State: AOJu0YyjkQwETxrRj/nPqHqOFeiNDEVVjhkw+cyPxBvFg4mvymxdBkVj
	Ql2D6ffV0iii2V8s61M1tYYOU8z9nWn2CUQM4r7iqbnwJ6quYAj/T3+8omHzCiS0
X-Gm-Gg: AY/fxX7RT3mIs2poL7Us6dpWHYfK+1I+8iwopotqU77Jd4zlq/Eo3D4cn00tWqKhSFf
	jTUat6cDjnmAx/VVoy0vmc2qLyhfC82H6bjltpxzEi16svZrSQIH/B7x/sbnTfO8/rnaK8P8FHK
	uc5C7qJbraoBIaUz1Xf3O7FOIsTzGNGrwoigztrrSJmK4Z/39BwJJ6ItpfiF1MOki7zbJDfrMKY
	jbjmLF9cHFitOp2XbgDoZ6ylEgApMq/EWB5aGLuJGKaWfdCdCMsH4/eAnrqtgyBk/XtNqRSS77T
	RjlvH1sTKeF537bOG2Em4Y7o8rMrP+57xEVdzlYYjxMieIXU86AzjtEZJyrQkRDGMzjMXdWJQO6
	PvhcRAuQHlOJGVQu2lFc53E673Izu2qmFj4q+c/wZqrZJFAlIUunY8OxVPEAk90Bvu71JKuL+Sh
	tODmW8e8fVjNSlhw==
X-Google-Smtp-Source: AGHT+IEezCWjkcI9aqFQlstt5pBZQQFKZ+mKCVeEIa78CXu8oiy7tjwThLjfkZk75bEjeqTHPMbqTg==
X-Received: by 2002:a05:693c:4088:b0:2ac:16c8:ff8f with SMTP id 5a478bee46e88-2b143478f03mr333904eec.15.1767379952498;
        Fri, 02 Jan 2026 10:52:32 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42ddbsm1541749eec.28.2026.01.02.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:32 -0800 (PST)
Message-Id: <742f2d381af52cd8314a6a643e84b6b9daf99c7c.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:19 +0000
Subject: [PATCH 05/10] xdiff: use xdfenv_t in xdl_trim_ends() and
 xdl_cleanup_records()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

View with --color-words. Prepare these functions to use the fields:
delta_start, delta_end. A future patch will add these fields to
xdfenv_t.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 60 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 0d7d9f6146..0acb3437d4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -261,7 +261,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * matches on the other file. Also, lines that have multiple matches
  * might be potentially discarded if they appear in a run of discardable.
  */
-static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
+static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
@@ -273,11 +273,11 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Create temporary arrays that will help us decide if
 	 * changed[i] should remain false, or become true.
 	 */
-	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
+	if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
 		ret = -1;
 		goto cleanup;
 	}
-	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
+	if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
 		ret = -1;
 		goto cleanup;
 	}
@@ -285,17 +285,17 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
+	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart]; i <= xe->xdf1.dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
+	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart]; i <= xe->xdf2.dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
@@ -305,27 +305,27 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Use temporary arrays to decide if changed[i] should remain
 	 * false, or become true.
 	 */
-	xdf1->nreff = 0;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
-	     i <= xdf1->dend; i++, recs++) {
+	xe->xdf1.nreff = 0;
+	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart];
+	     i <= xe->xdf1.dend; i++, recs++) {
 		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->reference_index[xdf1->nreff++] = i;
+		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->xdf1.dstart, xe->xdf1.dend))) {
+			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
-			xdf1->changed[i] = true;
+			xe->xdf1.changed[i] = true;
 			/* i.e. discard */
 	}
 
-	xdf2->nreff = 0;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
-	     i <= xdf2->dend; i++, recs++) {
+	xe->xdf2.nreff = 0;
+	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart];
+	     i <= xe->xdf2.dend; i++, recs++) {
 		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->reference_index[xdf2->nreff++] = i;
+		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->xdf2.dstart, xe->xdf2.dend))) {
+			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
-			xdf2->changed[i] = true;
+			xe->xdf2.changed[i] = true;
 			/* i.e. discard */
 	}
 
@@ -340,27 +340,27 @@ cleanup:
 /*
  * Early trim initial and terminal matching records.
  */
-static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
+static int xdl_trim_ends(xdfenv_t *xe) {
 	long i, lim;
 	xrecord_t *recs1, *recs2;
 
-	recs1 = xdf1->recs;
-	recs2 = xdf2->recs;
-	for (i = 0, lim = (long)XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	recs1 = xe->xdf1.recs;
+	recs2 = xe->xdf2.recs;
+	for (i = 0, lim = (long)XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec); i < lim;
 	     i++, recs1++, recs2++)
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
-	xdf1->dstart = xdf2->dstart = i;
+	xe->xdf1.dstart = xe->xdf2.dstart = i;
 
-	recs1 = xdf1->recs + xdf1->nrec - 1;
-	recs2 = xdf2->recs + xdf2->nrec - 1;
+	recs1 = xe->xdf1.recs + xe->xdf1.nrec - 1;
+	recs2 = xe->xdf2.recs + xe->xdf2.nrec - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
-	xdf1->dend = (long)xdf1->nrec - i - 1;
-	xdf2->dend = (long)xdf2->nrec - i - 1;
+	xe->xdf1.dend = (long)xe->xdf1.nrec - i - 1;
+	xe->xdf2.dend = (long)xe->xdf2.nrec - i - 1;
 
 	return 0;
 }
@@ -393,10 +393,10 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdl_classify_record(2, &cf, rec);
 	}
 
-	xdl_trim_ends(&xe->xdf1, &xe->xdf2);
+	xdl_trim_ends(xe);
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_cleanup_records(&cf, &xe->xdf1, &xe->xdf2) < 0) {
+	    xdl_cleanup_records(&cf, xe) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
-- 
gitgitgadget

