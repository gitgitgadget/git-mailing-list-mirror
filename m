Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F32690EC
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379961; cv=none; b=ixS94soLnJwCd++A1azXDW5ljdz38DpS+9KWMX3GVo50ArhB+1XYcWTmu2y+3n5ycmnu/q6F7oIKwfgqbetULSiNc2iePlnBpVizY9XQDYu9DTRZWy4x94bAkEaoCdcJd3akRlrKh96YLLwyCpmOWxyLgDRU6xXOsrlkD3Wv+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379961; c=relaxed/simple;
	bh=PLwQ6iM8YzgAowjpcJXZDrZTqGUTL/EWMWHX/78aSAQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r+L8ojac3jihhSZk3Y9LO6up5zZmL7Qr5DTMMm76PsJFUlADMtmSXttonmH/GHsmwN0zJov87DUpV2kkpo/jwwZUM3DIpnVSL6RnhB5YWA9m9atF/ENKdctlgeYp3Ajpzso+ks3Pcu0R3blSA1XQHQ8iUMcE1C8hftLGRloyzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV6kGlCK; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV6kGlCK"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso8259280a12.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379958; x=1767984758; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mvhKcT4LXGmvIrx/xH30GQf3t5yOnPg2le57uPZb94=;
        b=eV6kGlCKX7cfFadQE8RXOO20HhhR/tsiZtb5VmD6wUIyZew26aRBrR5fCzjKDsxHwu
         twSzT+7kqPZ+aKUxV1TlAxEGkVeoXqqt0mL2s+4WGGqedG7e0wvWx6UCH6lZP/IKMKoV
         d9JmXDXa+DQfG9HsW+UdFlASx1lCbwsX+ZsCUgR9h0kuq3VKS9VcXAcfbUEkSlJhX8cv
         itrGkMmG1uYmWdZMO4C39VaNaVzF5Zfp0bKafFnXWMcSxYp2xjl+r6ADRBa8FIOWw3Tu
         z5bqzvTZplgc0qxq8odFyz39dkx3N+0KjA/0ozom3BMeU0z2qRTj7Z99NUA+Rk+42LIx
         SwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379958; x=1767984758;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1mvhKcT4LXGmvIrx/xH30GQf3t5yOnPg2le57uPZb94=;
        b=Y9HEN9AlKQxXgItu2UqktcouWdTKhmVimpPyQKUGXY2lUxcC3mPQSyMqhP/twbixgi
         NcVggeApugF4LevBf+NpNoFuhBRcKwAIxUe9GD9ePZ/5PWgmisD75PMBjp20kXEjsQbm
         KGvonMI/ynDZW0sLh6y8uKcWpgBIihFmZqjbrz1lf+j0uzfcvNjJGKYzdmducGaPgT3s
         xlywG/S9efc+xqUaIoypFr2S6eBnONvZmPju+KVb8P/HDBAQOk3IETdcS2X0nDvrtHts
         lWgpnqPFqtrDAQy5rmQ9y3z2f5jkfi7DpwNr+VQf5t7k6mw6r8+PacGa35kHAQ3hPUrE
         /0Kg==
X-Gm-Message-State: AOJu0YwitqqbQ7C4FIvI+l3FVndG3MUsH6Pddv3GO4yN5Gr2nuwaLXQi
	BX8uXN5eA4KAU/9Su6IP8piCl8oYX3Qfjja3MzJ+6AHEgVYXe8eIFVKDyKUpPKeq
X-Gm-Gg: AY/fxX55Hlsv/ELPBj29Kecu9Tt9mwawrQ2f081x0aIXD2dRTJ2FKKSxzXRK6F6pVGJ
	BNRXCL4vkGYJcEqIq7RiFejhe0qO0YxzcKJDszXMJpp6XspGjp7jnrsLFKpPCZJlCAaazKOx2dH
	+WwXddADMSSW16zWTv3OfCimbCaO+x6UsUyD+ISw29avmvr640H4jzpgJPZ2aJRkV0CDbwX/5q/
	XgtM3BqWPgtsHQ8Pxz7UAzv6euhqD4izRAfHiphzkhvy3kL5InAd/SbhcE1/k0F47QWU8WOXDnA
	AsfmCOha1UVJYSgcYL5MS8ef+vzk1/cwJTA7BGZ5kDZy/PE2hlUTzqP/Km6/RgenBlbK1eWRCUI
	fS0fsdqqWhJ8yQeDzLDUvi6GQlUoRYyTKsLxlztrTc4HI7myqA7ADUDCdYuR4LTS21TdbLkjOuE
	9xO7D2ZO/yj9UlLg==
X-Google-Smtp-Source: AGHT+IF2Ticg1Wovj5GgUpER9KNg+WyUNLCm/T8ro8Ho4aFATiOuKT/xV0ICtSP2MSotI+SKbpXE/g==
X-Received: by 2002:a05:701b:2712:b0:11b:9386:8269 with SMTP id a92af1059eb24-1217230598emr27360465c88.46.1767379958028;
        Fri, 02 Jan 2026 10:52:38 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm162712003c88.0.2026.01.02.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:37 -0800 (PST)
Message-Id: <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:23 +0000
Subject: [PATCH 09/10] xdiff: remove dependence on xdlclassifier from
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

Disentangle xdl_cleanup_records() from the classifier so that it can be
moved from xprepare.c into xdiffi.c.

The classic diff is the only algorithm that needs to count the number
of times each line occurs in each file. Make xdl_cleanup_records()
count the number of lines instead of the classifier so it won't slow
down patience or histogram.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 52 +++++++++++++++++++++++++++++++++---------------
 xdiff/xtypes.h   |  1 +
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d3cdb6ac02..b53a3b80c4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -21,6 +21,7 @@
  */
 
 #include "xinclude.h"
+#include "compat/ivec.h"
 
 
 #define XDL_KPDIS_RUN 4
@@ -35,7 +36,6 @@ typedef struct s_xdlclass {
 	struct s_xdlclass *next;
 	xrecord_t rec;
 	long idx;
-	long len1, len2;
 } xdlclass_t;
 
 typedef struct s_xdlclassifier {
@@ -92,7 +92,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
+static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t *rec) {
 	size_t hi;
 	xdlclass_t *rcrec;
 
@@ -113,13 +113,10 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->rec = *rec;
-		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
 	}
 
-	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
-
 	rec->minimal_perfect_hash = (size_t)rcrec->idx;
 
 	return 0;
@@ -253,22 +250,44 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
 	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
 }
 
+struct xoccurrence
+{
+	size_t file1, file2;
+};
+
+
+DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
+
 
 /*
  * Try to reduce the problem complexity, discard records that have no
  * matches on the other file. Also, lines that have multiple matches
  * might be potentially discarded if they appear in a run of discardable.
  */
-static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
-	long i, nm, mlim;
+static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
+	long i;
+	size_t nm, mlim;
 	xrecord_t *recs;
-	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
-	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
+	struct IVec_xoccurrence occ;
+	bool need_min = !!(flags & XDF_NEED_MINIMAL);
 	int ret = 0;
 	ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
 	ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
 
+	IVEC_INIT(occ);
+	ivec_zero(&occ, xe->mph_size);
+
+	for (size_t j = 0; j < xe->xdf1.nrec; j++) {
+		size_t mph1 = xe->xdf1.recs[j].minimal_perfect_hash;
+		occ.ptr[mph1].file1 += 1;
+	}
+
+	for (size_t j = 0; j < xe->xdf2.nrec; j++) {
+		size_t mph2 = xe->xdf2.recs[j].minimal_perfect_hash;
+		occ.ptr[mph2].file2 += 1;
+	}
+
 	/*
 	 * Create temporary arrays that will help us decide if
 	 * changed[i] should remain false, or become true.
@@ -288,16 +307,14 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= dend1; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
-		nm = rcrec ? rcrec->len2 : 0;
+		nm = occ.ptr[recs->minimal_perfect_hash].file2;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
 	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= dend2; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
-		nm = rcrec ? rcrec->len1 : 0;
+		nm = occ.ptr[recs->minimal_perfect_hash].file1;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
@@ -332,6 +349,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
 cleanup:
 	xdl_free(action1);
 	xdl_free(action2);
+	ivec_free(&occ);
 
 	return ret;
 }
@@ -387,18 +405,20 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 	for (size_t i = 0; i < xe->xdf1.nrec; i++) {
 		xrecord_t *rec = &xe->xdf1.recs[i];
-		xdl_classify_record(1, &cf, rec);
+		xdl_classify_record(&cf, rec);
 	}
 
 	for (size_t i = 0; i < xe->xdf2.nrec; i++) {
 		xrecord_t *rec = &xe->xdf2.recs[i];
-		xdl_classify_record(2, &cf, rec);
+		xdl_classify_record(&cf, rec);
 	}
 
+	xe->mph_size = cf.count;
+
 	xdl_trim_ends(xe);
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_cleanup_records(&cf, xe) < 0) {
+	    xdl_cleanup_records(xe, xpp->flags) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index a939396064..2528bd37e8 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -56,6 +56,7 @@ typedef struct s_xdfile {
 typedef struct s_xdfenv {
 	xdfile_t xdf1, xdf2;
 	size_t delta_start, delta_end;
+	size_t mph_size;
 } xdfenv_t;
 
 
-- 
gitgitgadget

