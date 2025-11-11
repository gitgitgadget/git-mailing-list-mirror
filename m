Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1232A3EB
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890162; cv=none; b=f8m7EfuNWqFbuzKUuklCH73OW9A34I3cnGENNcoP7j83nJAvvy1whXcrQfXdk8pmy7nopP9NNOi9YbYPkNZnUMmFNaxcPbiKaVbB6DuY/z8IMzG1OrKdb4B3pBgiMhKM+FzrZxWva/pb2zr6X2U5XeSIEIl8uZZ2KNN7CpIytYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890162; c=relaxed/simple;
	bh=zYm6gc9N/nYWV0QLuSQDuSqp15FbpPVz4jhvso1lmU0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rVBsFtA4mopSsVTAeYm93pqgFpddZZgHm2U9QlChqdQTseVnJijS9FGO3tRI3dOg1++XPvTxziRC2v1OvIf0q+2NKcwIZ7Gy0xMGX6FeyIWE6Uuj8H9K8pnidtMHVaeIAGb16yfPoc0OBqutlwfvRKpIzpfWrmvVS8+9GgvT1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afDk6uNH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afDk6uNH"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b29b6f3178so1499385a.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890159; x=1763494959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCGwdzqMlRDVBpxldjog8ee2INIPpqK6TKs64LmAT2Y=;
        b=afDk6uNHeSVoFMtU91SbRl5gsMkG8rMGJJwrCold55GdpxFRQ9i6xBmcYwLuchR7Ek
         GTV9n3WvM99uDS+6wy9dC21DumlvpWqQRekvA7VKdazhbauzNNQ21U4689kfMuimOH77
         oN30XQJybR/q9PMx8YX04Ln+EQVuObS3/szKR+OgUaftd8y516RHiF6Mxz30Hk9JQcLS
         rdDvx+AUiIs7wsNwXLd8zCRHQ6xYWMjv9J9kZfSkETKxF626NGZAxO74BgL1qqGtGKr9
         19mZ1MEADkEfd0/7rBoMbIyyJE72a6fVVkUNIl+Ql37Zp25Mbxcf+sQsddGg+DBCJX1Z
         tU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890159; x=1763494959;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCGwdzqMlRDVBpxldjog8ee2INIPpqK6TKs64LmAT2Y=;
        b=G3s6ssufcj/0SRYVsi2BQZzEspfTWeM8ibw9EIYA39wKVju1VrX7SpTyi3tjc/d+EC
         8A5fzuBkN5GDzXx2W2cm+Zwqo+bxHn7ltU/KZrARdpKnregq29Z5M4q30WK1uSfQJTnB
         KiGBbS7WBEcHPexL3l4Qr2z/oITHOK8uwPLZitE/4zQMhE4MHSe500+SL9LeaFX96NfU
         ZBuw3u3ukA5eBRmv3wgweIu8V3jjHkE3urc0FCb1S1jghJdo9GoFQclWLUl5JFju5Zcf
         CR66w8GpFizVprAWnTbl9mAEOq48Skn0I8EALbH+du4lkLVifIvI0coV31P6GVeIWfVo
         KruQ==
X-Gm-Message-State: AOJu0YzwHdhT7lgGcexr4JXBGc2cabgyH5Xn0llMt/wpbzckf+vdciwI
	/Ktohgni8E6HDhxg8Db9JfG7vTk/i0MoQP+qtQjXk5w0f3KmLLZzC2bEOukPBA==
X-Gm-Gg: ASbGnct666zHlkwFYvaTNqsqrszKKigfeXvHsx+thLbshZ8eSm5EJ3fGoYjpQXUx38s
	CC0QOxli9ilagfCtWjO0BXRqLvNAUH6+VBf0VeRRlMgEmEKHYFHr8aeNeSJFH44GCvGJ7ePTVFk
	ra1puemOreJFpTynC6kVo5oq5h9Om8j9KkrP3Ye4a4pzKTp2zSdSt9FhXWgdCa+SNW24LPKyIWA
	shLWppkGmXLzlE7oYLX82STqkcLkTy/AEBawp+pj+RWoYWQNKhsZtJ3fvViKqH74CLgKn23DCsx
	ec9EzKxiCuPAamoy7UYqRC0QvdlHK3MBYfpzCJnOXvRuX4VTgMEJkKdw13ugOLLcRyjaFTcLjL1
	9LSHN0WezHV1bM7qCbk3VZjaAN3qBMrWrDWZgiTqLM2VxqNaNalAVk6QRLSEhoo6CkXxZwXMDlt
	2Nvx6XnHQoA57AeQ==
X-Google-Smtp-Source: AGHT+IHtCZFgI8detp0UaWfjyb7KGs73CyoHuU6Jeqo7qjnDZfkOtEXoYQIj07b1mln62DDocyo2iQ==
X-Received: by 2002:a05:620a:45a1:b0:80e:d31:1ea9 with SMTP id af79cd13be357-8b29b585e01mr81473985a.11.1762890159093;
        Tue, 11 Nov 2025 11:42:39 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a86ffc5sm43657285a.25.2025.11.11.11.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:38 -0800 (PST)
Message-Id: <da2b80ea0be3470cbfe04ff4d39727e6d5921a9a.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:26 +0000
Subject: [PATCH v3 04/10] xdiff: use size_t for xrecord_t.size
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

