Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964D27FD4F
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379962; cv=none; b=SY6j8xrHtSljvGH7GqAOrJ/wwmFrXc8B48vJ3QUZSnrB3FhnsreX6HbZWte0s7tb9b2IvT4wPR8OKNvH38DC/mUbk+4MiSRZTKpQmJZJD5eZT7sTUPfyUZt2ejy3m0MBHuQCBTtJ1MoOwGxNMoX88wqsb5977WjLzgEdnePo6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379962; c=relaxed/simple;
	bh=dNYGqFivFMH63zPIW8D0c1QAxgAKweT9fp3qO18ZcSw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hau/WhqYhXP4pnpZxZQ0Tn8Wvouhan6/fhzgWQz5IwqXkmg4STe8XxfWNX56g7S8QG520vWpHXrEfoSzV4qi6ZotARR9XCjsBbKo7vmzHLuX7TeKZy8Gu+veVCz7GVPfPc5u5zFU/+gV/dHkPwrhN50scyaD04aZCY0eAirZPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM/lJ+bH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM/lJ+bH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so12701303b3a.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379959; x=1767984759; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpb9kImJPSayzbGNet7zb7pghWwIojhYuIRHx+6HJZA=;
        b=UM/lJ+bH8y6jgVOr2hn4J1wrjrPIUKTg1B7/FvI+EeCkfCsuiRT0T2DI/slSNUzjRJ
         BnasIIuPFrVvawwXUP2VsdOBz1tYohyCIY7gyEOdZBVr9wvkCRWUZT+1Ftzupv2cjXsc
         YTtkBonQeJPG/yJBjZ+HU/gd3usWTJhqRrh2bszBCG7Fa60TwDK4bgPa6EB44E6Is2l8
         DBZkNO7uydEiVsFVPNhL96iN5T42EpuypGEMNMbCa1EhYCX+BXVmGH3PMXMTCcUCg3La
         KXSA2mjJbfAtcrJnU/XhIt/pAN3lbscYwAP9KbcGXDuA7JF2rLX3E2J00h3BRXAzn1EB
         7ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379959; x=1767984759;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rpb9kImJPSayzbGNet7zb7pghWwIojhYuIRHx+6HJZA=;
        b=TJ9c5LOpflVGvvIeq5ZVyMn2c4wL3JNwxve7vnH71nfUoKIOdTpG9c2iQk4G0+h/ib
         Ixv29M34CIh+D6r8yx8fVKvdSlZEqnT6XsxxvL/BtdhdDS+UQuFdma0t5FhMN/LPS1zj
         WNVykHY8Rgn/DoNLrYCKP0ycr0OFnl9DC5zJR5PkFB566XLmteq06cLlKJgRHzzD2QK4
         6gQecTIiLbGE0AXEuX/wEjMHV6Bp8/wPqwm0RWDB1tJdAwlEXmWZAKQ2tMyCj7ZzyOv/
         PmetncX9Y+x/xtherpjKPYPfIxeMtG1Sucd9jdaPoO+Pv5sQrlSwAFMS5k5cC+KoX1Oi
         fc0A==
X-Gm-Message-State: AOJu0YyhFf3fy4kZzU+klQ7A10WYC8vp6XE/4UAcvetlty98axqHDMZh
	PjbH3+L2kOv9RDtOgrr4c/9qTNc/CiRqwuargNHSakbXXf3E/uuNa7Ur4OArRg==
X-Gm-Gg: AY/fxX4eQI3EQhQJveXN/vgx+rG5dq0sY/pk4f9BBeMY2vWQrxGMugWS1zpyDC1wdnY
	atf+RwciQmsLjQF4YgLYiHU2sJDykqcFf0ScwSXWsHlvcq9DUiRviZg6HWOP74aLOaWNc6SlA3K
	uSoOm26jDiWaD7/18MsdTvU7Jbx6dy48Fe2cgiutCZH4ugjcQaMVxIAeVC/styhZ5iIJf3Qlm1f
	4MlqD4Z0Q/MaI0j65nQESlOfpD6mClKz75mGbOk5Kl+sCYNw1Bzl6MeJggokAeVdfxrGEKZlFEV
	H4A1syteE0orCOa1pc+529Y/yjH/bXk1bTKrH2IXu3ZSwP9X2G7y5GLNaEqUiwKK12bGRlBPxQy
	SpXRxOdRlb77DVnrI2bxLUnypP2tsGcd7RIf0ZjaYJpLHvD2LZWqxK5C1G+m0io+MMoctKe6MNZ
	VbEhU2avFCsqPSMg==
X-Google-Smtp-Source: AGHT+IEROfUj2WWl7UqilmtFEYd331oTtgD9YdFVTbWRTtm1S9blyjlTQyJ1kMNaBBLzfG+WMx+o4w==
X-Received: by 2002:a05:7022:6889:b0:119:e56b:9592 with SMTP id a92af1059eb24-121722f6544mr32800264c88.23.1767379959435;
        Fri, 02 Jan 2026 10:52:39 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm159831277c88.17.2026.01.02.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:38 -0800 (PST)
Message-Id: <1dba6b34aa5c3eec06ae50a74d133c37b1d2404e.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:24 +0000
Subject: [PATCH 10/10] xdiff: move xdl_cleanup_records() from xprepare.c to
 xdiffi.c
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

Only the classic diff uses xdl_cleanup_records(). Move it,
xdl_clean_mmatch(), and the macros to xdiffi.c and call
xdl_cleanup_records() inside of xdl_do_classic_diff(). This better
organizes the code related to the classic diff.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 180 ++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xprepare.c | 191 +----------------------------------------------
 2 files changed, 181 insertions(+), 190 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index e3196c7245..0f1fd7cf80 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -21,6 +21,7 @@
  */
 
 #include "xinclude.h"
+#include "compat/ivec.h"
 
 static size_t get_hash(xdfile_t *xdf, long index)
 {
@@ -33,6 +34,14 @@ static size_t get_hash(xdfile_t *xdf, long index)
 #define XDL_SNAKE_CNT 20
 #define XDL_K_HEUR 4
 
+#define XDL_KPDIS_RUN 4
+#define XDL_MAX_EQLIMIT 1024
+#define XDL_SIMSCAN_WINDOW 100
+
+#define DISCARD 0
+#define KEEP 1
+#define INVESTIGATE 2
+
 typedef struct s_xdpsplit {
 	long i1, i2;
 	int min_lo, min_hi;
@@ -311,6 +320,175 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 }
 
 
+static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
+	long r, rdis0, rpdis0, rdis1, rpdis1;
+
+	/*
+	 * Limits the window that is examined during the similar-lines
+	 * scan. The loops below stops when action[i - r] == KEEP
+	 * (line that has no match), but there are corner cases where
+	 * the loop proceed all the way to the extremities by causing
+	 * huge performance penalties in case of big files.
+	 */
+	if (i - s > XDL_SIMSCAN_WINDOW)
+		s = i - XDL_SIMSCAN_WINDOW;
+	if (e - i > XDL_SIMSCAN_WINDOW)
+		e = i + XDL_SIMSCAN_WINDOW;
+
+	/*
+	 * Scans the lines before 'i' to find a run of lines that either
+	 * have no match (action[j] == DISCARD) or have multiple matches
+	 * (action[j] == INVESTIGATE). Note that we always call this
+	 * function with action[i] == INVESTIGATE, so the current line
+	 * (i) is already a multimatch line.
+	 */
+	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
+		if (action[i - r] == DISCARD)
+			rdis0++;
+		else if (action[i - r] == INVESTIGATE)
+			rpdis0++;
+		else if (action[i - r] == KEEP)
+			break;
+		else
+			BUG("Illegal value for action[i - r]");
+	}
+	/*
+	 * If the run before the line 'i' found only multimatch lines,
+	 * we return false and hence we don't make the current line (i)
+	 * discarded. We want to discard multimatch lines only when
+	 * they appear in the middle of runs with nomatch lines
+	 * (action[j] == DISCARD).
+	 */
+	if (rdis0 == 0)
+		return 0;
+	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
+		if (action[i + r] == DISCARD)
+			rdis1++;
+		else if (action[i + r] == INVESTIGATE)
+			rpdis1++;
+		else if (action[i + r] == KEEP)
+			break;
+		else
+			BUG("Illegal value for action[i + r]");
+	}
+	/*
+	 * If the run after the line 'i' found only multimatch lines,
+	 * we return false and hence we don't make the current line (i)
+	 * discarded.
+	 */
+	if (rdis1 == 0)
+		return false;
+	rdis1 += rdis0;
+	rpdis1 += rpdis0;
+
+	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
+}
+
+struct xoccurrence
+{
+	size_t file1, file2;
+};
+
+
+DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
+
+
+/*
+ * Try to reduce the problem complexity, discard records that have no
+ * matches on the other file. Also, lines that have multiple matches
+ * might be potentially discarded if they appear in a run of discardable.
+ */
+static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
+	long i;
+	size_t nm, mlim;
+	xrecord_t *recs;
+	uint8_t *action1 = NULL, *action2 = NULL;
+	struct IVec_xoccurrence occ;
+	bool need_min = !!(flags & XDF_NEED_MINIMAL);
+	int ret = 0;
+	ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
+	ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
+
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
+	/*
+	 * Create temporary arrays that will help us decide if
+	 * changed[i] should remain false, or become true.
+	 */
+	if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
+		ret = -1;
+		goto cleanup;
+	}
+	if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
+		ret = -1;
+		goto cleanup;
+	}
+
+	/*
+	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
+	 */
+	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
+		mlim = XDL_MAX_EQLIMIT;
+	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= dend1; i++, recs++) {
+		nm = occ.ptr[recs->minimal_perfect_hash].file2;
+		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+	}
+
+	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
+		mlim = XDL_MAX_EQLIMIT;
+	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= dend2; i++, recs++) {
+		nm = occ.ptr[recs->minimal_perfect_hash].file1;
+		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+	}
+
+	/*
+	 * Use temporary arrays to decide if changed[i] should remain
+	 * false, or become true.
+	 */
+	xe->xdf1.nreff = 0;
+	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
+	     i <= dend1; i++, recs++) {
+		if (action1[i] == KEEP ||
+		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->delta_start, dend1))) {
+			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
+			/* changed[i] remains false, i.e. keep */
+		} else
+			xe->xdf1.changed[i] = true;
+			/* i.e. discard */
+	}
+
+	xe->xdf2.nreff = 0;
+	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
+	     i <= dend2; i++, recs++) {
+		if (action2[i] == KEEP ||
+		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->delta_start, dend2))) {
+			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
+			/* changed[i] remains false, i.e. keep */
+		} else
+			xe->xdf2.changed[i] = true;
+			/* i.e. discard */
+	}
+
+cleanup:
+	xdl_free(action1);
+	xdl_free(action2);
+	ivec_free(&occ);
+
+	return ret;
+}
+
+
 int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags)
 {
 	long ndiags;
@@ -318,6 +496,8 @@ int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags)
 	xdalgoenv_t xenv;
 	int res;
 
+	xdl_cleanup_records(xe, flags);
+
 	/*
 	 * Allocate and setup K vectors to be used by the differential
 	 * algorithm.
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b53a3b80c4..3f555e29f4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -24,14 +24,6 @@
 #include "compat/ivec.h"
 
 
-#define XDL_KPDIS_RUN 4
-#define XDL_MAX_EQLIMIT 1024
-#define XDL_SIMSCAN_WINDOW 100
-
-#define DISCARD 0
-#define KEEP 1
-#define INVESTIGATE 2
-
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
 	xrecord_t rec;
@@ -50,8 +42,6 @@ typedef struct s_xdlclassifier {
 } xdlclassifier_t;
 
 
-
-
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	memset(cf, 0, sizeof(xdlclassifier_t));
 
@@ -186,175 +176,6 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
-	long r, rdis0, rpdis0, rdis1, rpdis1;
-
-	/*
-	 * Limits the window that is examined during the similar-lines
-	 * scan. The loops below stops when action[i - r] == KEEP
-	 * (line that has no match), but there are corner cases where
-	 * the loop proceed all the way to the extremities by causing
-	 * huge performance penalties in case of big files.
-	 */
-	if (i - s > XDL_SIMSCAN_WINDOW)
-		s = i - XDL_SIMSCAN_WINDOW;
-	if (e - i > XDL_SIMSCAN_WINDOW)
-		e = i + XDL_SIMSCAN_WINDOW;
-
-	/*
-	 * Scans the lines before 'i' to find a run of lines that either
-	 * have no match (action[j] == DISCARD) or have multiple matches
-	 * (action[j] == INVESTIGATE). Note that we always call this
-	 * function with action[i] == INVESTIGATE, so the current line
-	 * (i) is already a multimatch line.
-	 */
-	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
-		if (action[i - r] == DISCARD)
-			rdis0++;
-		else if (action[i - r] == INVESTIGATE)
-			rpdis0++;
-		else if (action[i - r] == KEEP)
-			break;
-		else
-			BUG("Illegal value for action[i - r]");
-	}
-	/*
-	 * If the run before the line 'i' found only multimatch lines,
-	 * we return false and hence we don't make the current line (i)
-	 * discarded. We want to discard multimatch lines only when
-	 * they appear in the middle of runs with nomatch lines
-	 * (action[j] == DISCARD).
-	 */
-	if (rdis0 == 0)
-		return 0;
-	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
-		if (action[i + r] == DISCARD)
-			rdis1++;
-		else if (action[i + r] == INVESTIGATE)
-			rpdis1++;
-		else if (action[i + r] == KEEP)
-			break;
-		else
-			BUG("Illegal value for action[i + r]");
-	}
-	/*
-	 * If the run after the line 'i' found only multimatch lines,
-	 * we return false and hence we don't make the current line (i)
-	 * discarded.
-	 */
-	if (rdis1 == 0)
-		return false;
-	rdis1 += rdis0;
-	rpdis1 += rpdis0;
-
-	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
-}
-
-struct xoccurrence
-{
-	size_t file1, file2;
-};
-
-
-DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
-
-
-/*
- * Try to reduce the problem complexity, discard records that have no
- * matches on the other file. Also, lines that have multiple matches
- * might be potentially discarded if they appear in a run of discardable.
- */
-static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
-	long i;
-	size_t nm, mlim;
-	xrecord_t *recs;
-	uint8_t *action1 = NULL, *action2 = NULL;
-	struct IVec_xoccurrence occ;
-	bool need_min = !!(flags & XDF_NEED_MINIMAL);
-	int ret = 0;
-	ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
-	ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
-
-	IVEC_INIT(occ);
-	ivec_zero(&occ, xe->mph_size);
-
-	for (size_t j = 0; j < xe->xdf1.nrec; j++) {
-		size_t mph1 = xe->xdf1.recs[j].minimal_perfect_hash;
-		occ.ptr[mph1].file1 += 1;
-	}
-
-	for (size_t j = 0; j < xe->xdf2.nrec; j++) {
-		size_t mph2 = xe->xdf2.recs[j].minimal_perfect_hash;
-		occ.ptr[mph2].file2 += 1;
-	}
-
-	/*
-	 * Create temporary arrays that will help us decide if
-	 * changed[i] should remain false, or become true.
-	 */
-	if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
-		ret = -1;
-		goto cleanup;
-	}
-	if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
-		ret = -1;
-		goto cleanup;
-	}
-
-	/*
-	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
-	 */
-	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
-	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= dend1; i++, recs++) {
-		nm = occ.ptr[recs->minimal_perfect_hash].file2;
-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
-	}
-
-	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
-	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= dend2; i++, recs++) {
-		nm = occ.ptr[recs->minimal_perfect_hash].file1;
-		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
-	}
-
-	/*
-	 * Use temporary arrays to decide if changed[i] should remain
-	 * false, or become true.
-	 */
-	xe->xdf1.nreff = 0;
-	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
-	     i <= dend1; i++, recs++) {
-		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->delta_start, dend1))) {
-			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
-			xe->xdf1.changed[i] = true;
-			/* i.e. discard */
-	}
-
-	xe->xdf2.nreff = 0;
-	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
-	     i <= dend2; i++, recs++) {
-		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->delta_start, dend2))) {
-			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
-			xe->xdf2.changed[i] = true;
-			/* i.e. discard */
-	}
-
-cleanup:
-	xdl_free(action1);
-	xdl_free(action2);
-	ivec_free(&occ);
-
-	return ret;
-}
-
-
 /*
  * Early trim initial and terminal matching records.
  */
@@ -414,19 +235,9 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	}
 
 	xe->mph_size = cf.count;
+	xdl_free_classifier(&cf);
 
 	xdl_trim_ends(xe);
-	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
-	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_cleanup_records(xe, xpp->flags) < 0) {
-
-		xdl_free_ctx(&xe->xdf2);
-		xdl_free_ctx(&xe->xdf1);
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-
-	xdl_free_classifier(&cf);
 
 	return 0;
 }
-- 
gitgitgadget
