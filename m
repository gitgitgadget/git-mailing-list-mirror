Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823230C370
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159827; cv=none; b=NVTAh2BsrWATkfnrG4v95U6KhgQqgCcuL7+qa2AjT6ooji68JyEnJ8NeE8DqrFDL/eVqB5/NtWt644ze11ltNIb6O4A4Rw4K1i1gW/ZwNHq73eUEr8hXqY2dkcck7gNF4sdqCut6lkuHg/QDjRxjYQK5niK1seI6An7UdflV71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159827; c=relaxed/simple;
	bh=JkT/bgAaTy9o+3ALM2nDJC3QChKT2X+fyQci5Ma/wAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o+7Bwoq7hY/sPti4EXPIVYE6N3o51jA7CXfwi/yygJAiO8y7W20Bx0eNC+9TRYa/nvd8EN139R1djEvbpcgE4lZYK2jCOBSj4vA7HBeAIVLIHtqnFVxTdAmydDVSW4pZyM+lx5deSnNT3bimtByyQSsnXccs+VDBgvEwN7hpbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3guNyqa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3guNyqa"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2956d816c10so26589355ad.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159823; x=1763764623; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0PfUNSjPWZqHVtxcsIm+YMYRY0zWcCR/cD6ys2VJXE=;
        b=K3guNyqa0+YWbHMvbZyD1U0/uH6wmuKO7O0jbjADH9QNMINDhXWq+giG8LAgMNDjii
         Mawq06fJIcdeE2Yl4TFcaPBfNgWBPwbKRU+flkZ4UD1X4UcjyJq59MdYe8j7tHSiAyI8
         UNmXWqQEAVxTALUvUWAsb5T7wx0JpERxf2q11YbyrvHHTNhLzMrziiRJtRAYj13KLC7h
         xW/BwqF9Z1wLmN6bB/dwoavCcN+YPpg59tBX5JG/XNVv4V3OImCQuv6rq9gpj/idstFn
         MJg8DoTjCTB1zjUfDP63Il7t3PdF0TtZ3/V1cfz1xp3bN5bBQFIk5ct5yfDCkdqcgxqm
         vhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159823; x=1763764623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p0PfUNSjPWZqHVtxcsIm+YMYRY0zWcCR/cD6ys2VJXE=;
        b=jCbDi5+E74pJ9+HNuip7oZH80LtcXgL2mS4TOAUz218oqP82WDnOBdVij1CY6s0ZVd
         RLUZN7B/d7sTUeR2vfHuNKTkwAczvZFFzOg6UUAJL4jQqr23/Nk0N8W/JHo/bRflJSAe
         P4MylbWJi1gNX9Y08ttdG0L94Pe/xrbisZPUa89zVxha83pJnwk4MlQQuKs8E3Ntax/J
         d4xtSORfY5qbmEtDpY61/47p80ORLTMXAgb0pQHG2CWAwLG+j+PK/0Y79cLIVtDBENoD
         xS+EjuKnR+54agZJ9qSuc+CROhcMDVuEo/Q/6brIWDUGA9b0jDQ20r/6sgAmLGgJPh4m
         uGRQ==
X-Gm-Message-State: AOJu0Ywb7lZ/u5yA0PbC3SJSf1tfH6EaqgHfA+I5VrEnJ3aiWAdo0IB3
	qTT0J9Wl1AE1rwZ4oTdhPDLFuUVTWb1ejrLBmrb6+twhh9VYoePH2vieQJJliaPs
X-Gm-Gg: ASbGncuEBPDs1LGeIfzz+agACJm2v+kZr3ECrGfLB5uoOAqYurf7DPHc1QlqqSRd46h
	/0aVNXfbTydAanKD4vo4Ux6Rd+QKNSDiQjNR4YpEC4UVPNTt6n2FbSaZxfTSyREbUEVCD5ULJDM
	AVj5YvRlZFCwqSIVP8Z+SwYIkcXkfwLD594TahfrvS9Xv7mj4dE6h+K5LnFqof5YJkCiHvkjMX3
	7FTf60wQswL5Y8IirbltHLqpp5PhUL6nd92J60+Q3dmpy8RVD2AqFlAqbIsV3hikSvRwW7kHWvC
	uwTFbDsOkX/tStMyaD+Ok9ENCECLydOVSgGENQYVwJSi4/rO5ccKwjfS14dK0ikE2ZEm8vJX+nN
	J5dbNW/hQ5XgtOOewGfXvgXlaWw1DAIgLL67M1sTTf+VKqGJ6fAo38iq6c7e30xVMYZkb20yi2x
	yrZg==
X-Google-Smtp-Source: AGHT+IEuCtlJG8uhwOm1rF94uGZF3pG+NGmyc/rhm4AKJJK/OnnE1sVcLo6AYpl041B1LKq56N77cw==
X-Received: by 2002:a05:7022:a88:b0:11a:126f:ee78 with SMTP id a92af1059eb24-11b4171750cmr2608407c88.34.1763159823146;
        Fri, 14 Nov 2025 14:37:03 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b86afe12esm1496723c88.6.2025.11.14.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:02 -0800 (PST)
Message-Id: <c103fa6bea97b119c01ac139cd18ca5e272a4b29.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:50 +0000
Subject: [PATCH v4 04/10] xdiff: use size_t for xrecord_t.size
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is the appropriate type because size is describing the number of
elements, bytes in this case, in memory.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   |  7 +++----
 xdiff/xemit.c    |  8 ++++----
 xdiff/xmerge.c   | 16 ++++++++--------
 xdiff/xprepare.c |  6 +++---
 xdiff/xtypes.h   |  2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 411a8aa69f..edd05466df 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -403,10 +403,9 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
  */
 static int get_indent(xrecord_t *rec)
 {
-	long i;
 	int ret = 0;
 
-	for (i = 0; i < rec->size; i++) {
+	for (size_t i = 0; i < rec->size; i++) {
 		uint8_t c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
@@ -993,11 +992,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, (long)rec[i].size, flags);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, (long)rec[i].size, flags);
 
 		xch->ignore = ignore;
 	}
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ead930088a..2f8007753c 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
 {
 	xrecord_t *rec = &xdf->recs[ri];
 
-	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
+	if (xdl_emit_diffrec((char const *)rec->ptr, (long)rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 	xrecord_t *rec = &xdf->recs[ri];
 
 	if (!xecfg->find_func)
-		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
-	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
+		return def_ff((const char *)rec->ptr, (long)rec->size, buf, sz);
+	return xecfg->find_func((const char *)rec->ptr, (long)rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -151,7 +151,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
 	xrecord_t *rec = &xdf->recs[ri];
-	long i = 0;
+	size_t i = 0;
 
 	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 75cb3e76a2..0dd4558a32 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	xrecord_t *rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
-			(const char *)rec2[i].ptr, rec2[i].size, flags);
+		int result = xdl_recmatch((const char *)rec1[i].ptr, (long)rec1[i].size,
+			(const char *)rec2[i].ptr, (long)rec2[i].size, flags);
 		if (!result)
 			return -1;
 	}
@@ -119,11 +119,11 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int nee
 	if (count < 1)
 		return 0;
 
-	for (i = 0; i < count; size += recs[i++].size)
+	for (i = 0; i < count; size += (int)recs[i++].size)
 		if (dest)
 			memcpy(dest + size, recs[i].ptr, recs[i].size);
 	if (add_nl) {
-		i = recs[count - 1].size;
+		i = (int)recs[count - 1].size;
 		if (i == 0 || recs[count - 1].ptr[i - 1] != '\n') {
 			if (needs_cr) {
 				if (dest)
@@ -156,7 +156,7 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int needs_cr, int add_n
  */
 static int is_eol_crlf(xdfile_t *file, int i)
 {
-	long size;
+	size_t size;
 
 	if (i < file->nrec - 1)
 		/* All lines before the last *must* end in LF */
@@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 
 static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 {
-	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
-			    (const char *)rec2->ptr, rec2->size, flags);
+	return xdl_recmatch((const char *)rec1->ptr, (long)rec1->size,
+			    (const char *)rec2->ptr, (long)rec2->size, flags);
 }
 
 /*
@@ -441,7 +441,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
 		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
-				xe->xdf2.recs[i].size))
+				(long)xe->xdf2.recs[i].size))
 			return 1;
 	return 0;
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 4c56467076..b3219aed3e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->rec.ha == rec->ha &&
-				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
-					(const char *)rec->ptr, rec->size, cf->flags))
+				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
+					(const char *)rec->ptr, (long)rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -157,7 +157,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = (uint8_t const *)prev;
-			crec->size = (long) (cur - prev);
+			crec->size = cur - prev;
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 69727fb299..354349b523 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -40,7 +40,7 @@ typedef struct s_chastore {
 
 typedef struct s_xrecord {
 	uint8_t const *ptr;
-	long size;
+	size_t size;
 	unsigned long ha;
 } xrecord_t;
 
-- 
gitgitgadget

