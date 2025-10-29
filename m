Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AD2DE703
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776398; cv=none; b=q55k80+0/sYItUST15wcKqj+HXnPp2jmGiHSG9flwcR0pNHF2mxSD/mdSnaUFrjQ/FH18wbxgcWeOrzF61BS2K6DS/1mFooiNMditQDCE7u0yvrpWRSNkvrrNG5frSzh1zdn05NmcoT4Zs4pjVkZ24NB09hy4PZirNiLudcXEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776398; c=relaxed/simple;
	bh=2ierVzBrhIlX01JkBtd05iwns7LdX6kyzOABHqSxegY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qguIROFNEQksO/IDGI27OUkibH+MwlLnsz84vDObG1zaB9iyGh2Bbu9kigSOVN6rNFLIQSsVmUy4dxxNKDxg3yUICRpWUfdRxu/KJmTKYDSvqPDp6y60UXvqSskroHxc7n2DfzLN4V37UdVMVqdvTIw4/PZu0wTjyIbQkwdOJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itG4q+Xq; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itG4q+Xq"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-940d2b701a3so36566739f.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776396; x=1762381196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DuMHsiWRYl/pA1uNdigtkXaoOOrxSjt9njcG+5kJrQ=;
        b=itG4q+XqcoEgVHtFVoE8LBmEtnjs3D9c9D5Y9ujUpP3RbFGmGnp2W0C55H14lH9mQp
         HKZtBxxAHdlKi5ftaCwZgcHJ8nRBy14XahcT91lFzOElw7uNNe3C+NThdCNZtjOspq8L
         tQ0aml+UoZps5ULBwvwtSOgNNWUm2p/8QErhkLjeyXt2d6udBXf2EO/SpFpt76GfXSUG
         uSV99TsvlRFp03hHaGtK1fSgat6RX78Jep2Xw2f8UdrqG2BwK1fTBLs7QoKhFx3ipF+Q
         C44tHTGG1v+SqbaMc6WbOu5CjLHbJRUJL8F3nTtxbAddyCzuZl8Z/1yYTk7VINt8gP38
         H4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776396; x=1762381196;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DuMHsiWRYl/pA1uNdigtkXaoOOrxSjt9njcG+5kJrQ=;
        b=PjyVG+cHMLy/BUNVS08cr1aQ3tG5z++EsLL2QdUl5K8jQK/PiM+ZFQKwWqPKmRs9lm
         /Eiu6QW2vK8oyLjqDpetmcQ9c0bIorZ9lbflR/BXuHrPtFtzuxOxcUJHC5OgrA15D1q2
         EZUOM8lHnYRp6CxcPjf5NBxaM6Qdgh7zJxAezIv98ZhLej+rhfnnmMilZ2wTlH2vZV2h
         UaLuuFaE/nL6Rh9oCR9O2Rku6WfLW/mk0ZXbraQdq8dcwWlk0R5S3U3tT8//aC5uXbY7
         yPivahmgbkWqty6OglRDXvg+VTAREOxYgyZg6uKMJSFP0WbNqsS2A4ASCFzqEpX3DiJx
         IGjQ==
X-Gm-Message-State: AOJu0Yw73NaY/v9UXwRRP2a9sa2QEHq1VnWiEC5U7YLU69eR3dMgG56B
	KBSh5x2APjut0is4+OgXODYuBcfSbdb1Nnv9oA8/b9lJKvx1VxKygLyS9aL7Pg==
X-Gm-Gg: ASbGncsKFoDjcDtq9HIZtCaq8spDlwAK8uB+OwNxLaAejoHoid+MXx2p3y9aoMMv6ND
	lPoGTk2S5zUTginVc00iBisaWJv68QBuaZgYkmKyyVLtazLFi6XHtlqMGYZmq9o2hNANuLzrMaH
	8wj4s8IL0jWe1bNOrQIplPxgCADuzbcyGGN8BnJ639Px7wkF1ulC20MUVBhJsAB7AUtYktO++PV
	Blgy1mNJ0JUu4wCnUyXl3Piva0jIqau/yKwmMCEt5fI8Hdbn6G5BSsubylU0TgGCdxRlo0IWBea
	VWletMYtovQUGxf5PRP2DkmdXEVmk2KfmPIwV2f5gPkGKOs4fjNnFPN1j1+OVY3vmzKK0ApzZIl
	tUbEjALA7tDs+dnxsjnpImqvDiR6jLteQbs20q98a3H4sBKxxo632rncckj4ssY96rB1rGicPZD
	GPMw==
X-Google-Smtp-Source: AGHT+IGr1xRuEuZLA+1gLMylHeP+V5QI7o9DNRbR82Am/QUefVmDe7W7jyQkJdvTsTgS1//+DifFog==
X-Received: by 2002:a05:6e02:1a65:b0:430:bcef:e0a8 with SMTP id e9e14a558f8ab-433015524a9mr14483985ab.28.1761776395648;
        Wed, 29 Oct 2025 15:19:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946dc5esm5897944173.32.2025.10.29.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:55 -0700 (PDT)
Message-Id: <07e28aad3b5dc453967456b0017ae4751c9275bc.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:42 +0000
Subject: [PATCH v2 04/10] xdiff: use size_t for xrecord_t.size
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
index 4cb18b2b88..b3219aed3e 100644
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
-			crec->size =(long) ( cur - prev);
+			crec->size = cur - prev;
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index b1c520a378..88b1fe4649 100644
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

