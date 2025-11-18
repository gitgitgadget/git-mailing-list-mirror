Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1F2FF159
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505271; cv=none; b=IoaMzy9kPTbJ4h9D0H/FTMr8O4D1zd0v5chiGIGNPOVnoWbbU1hK/q5oExbka1452HHjUX+O3wtRDA/qqKEv7SuTwiQYwSGhfDpjutRzrsxxH41EWQMA64XuDVPljZkN4QXy/5yPlPIQZNeCVw+bpI0S4sRsPSrb1RnW+hA3Z8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505271; c=relaxed/simple;
	bh=F94EEkbepCuqVKVcRjzoY/evBAP6T8ehuVI66RVWGYg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uy8QqPgSdmT6YszQGTlVBjjdixzstsi5yxZNmo07MmAXJAs2MQgpWD8SX7yHsiO/hDYPt/Umu3toGC96ja0luiu1Wexqig7JSw6fdV7Tj6AcJzaxQVEOz87sSAOOKFLtiVFjYSs6L07Z/ApRo8iXVahXO4FnvXuOGUAa5UMgoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcXP0gbY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcXP0gbY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29812589890so75313835ad.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505268; x=1764110068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hBn6eMPffg0KSSsgjrdsaoz+AH4+Satn+xF9Uar+ZM=;
        b=LcXP0gbYSr5djar9laocxF2X7Fiyq95IDMDNw6gpar4l6PHb/cXtZO02tF5uei577o
         ee4LciZfTMtX3IBIsbr6EnEnZ+jOIj1jTak6f9bWJNiiAGlxrJoT68ZJHkQM86bU0kOT
         r66FXVzarODkICcPYqvFrSSPWV1q+Y5UE6KOkpwzNkwypeDpD4QCySn9Q64Tkd74MAso
         QtVSri4Bdtu3SlEDip7Bf3N6CBnhjZk4MmwlbdtQ0aZRHGx7VuYAFt+ncTg6tcInaF6N
         2ZA0obP09CDhzYqmoByw5V908va5kRzzpEom3JjtQ7FhjEt7G5s4w6Xunn4iY8UWv3Ig
         xO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505268; x=1764110068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hBn6eMPffg0KSSsgjrdsaoz+AH4+Satn+xF9Uar+ZM=;
        b=iwRvTyeYiQagbPRkoDQHjC6ab0wTCBE9ZtxbotzaFZqBLNntye7KShTvSzJ3DBcGqC
         /wNLRThNi9wNR3wfy7xkxosiouR0jazlyNeQZmG9cugKZrhf2A4mkYxZ9RnqDE+J7FRO
         RiUmAUyqs4Fi5IAgbQkUWZOy46cj8OYl+4gQccuLUzPiFoFNrsT6466xN9CWkaWbDqPG
         bfARJkE2NjETcAdnRQelzaT/8S4FKq/JYCI3/t8ZnDxoIKAQmBmjsHfd7U85Oy60H5Zl
         r6Z93VzARRowhOiPdR0Z9mniwVaZm6yO6EPmhRwzpMuzi90dY/awmodmB0Xk/sedNQzJ
         MUwg==
X-Gm-Message-State: AOJu0YwKwdST5cb6k4H/p8P2ctPSv/pB5ZXsm6BWvZqIfKAMLWyvpYts
	aq7dz+7iB9ZOkV8f8SsQ75zD3BC0aKoliWSQZixPF7YcMEeoI3HdSQMd+Zy3Uw==
X-Gm-Gg: ASbGncvk7UpC5+fVhcT+D6BJe0otUtD4W/oLxRvoG5MVfJ5oq9jGStsd3O1OsQWkOzr
	87oi/+Aq+JYzDLfZJ/CTWye3R5RsW3i21l0vhjPBW0dcJYzSXXL55TCdO2EcoWmzZtDjgrlPajm
	8zdbtX65F4uYEP4vA/NKApFwn/BBENgATeqFBUcZ9RdNy7+0PLSbDPQvFKrPbXJY9KvVb6rZzm8
	u/gVwK8HEsPaPNC1IoZYWwkwMdfODO0qNxZRLX6mBNCTzVtnwCfFZRgxk9raKy6BmbknJZCTeMu
	LZ+uTJBQcQN7mhHA0fh8kEXeD9xIggIJau6Og8YyQJTmt+b4+7Uy72lmcFk5u2n+zfOqpiYYzuD
	wPWjjXonBw8Pe4/ci6AzsP7vTWFuAqcWsynSHyS0fCDp1ArDNDDnGZGrzzBmRe6Vc0bCzQ4lXB8
	UYwkjPJ8WFAnYg
X-Google-Smtp-Source: AGHT+IGJZ4eoDrA+bPSjqYFYHNTP8cU4ss7pTczz2EIhqlmSTpEKOb+wmVvSMe1syplhBwzzoUii3g==
X-Received: by 2002:a17:903:124b:b0:295:9cb5:ae12 with SMTP id d9443c01a7336-29a0540d482mr6769285ad.25.1763505268356;
        Tue, 18 Nov 2025 14:34:28 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c234f1asm184453645ad.17.2025.11.18.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:27 -0800 (PST)
Message-Id: <11cec1d2ec7defbaf130fbe544c806ffb5a485ed.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:16 +0000
Subject: [PATCH v5 04/10] xdiff: use size_t for xrecord_t.size
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
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
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
index 95989b6af1..cb8e412c7b 100644
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
 		char c = (char) rec->ptr[i];
 
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

