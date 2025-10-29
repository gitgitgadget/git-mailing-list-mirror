Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1831AF18
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776397; cv=none; b=hYIYA2l1dn+tWf2OEP8mGF564e6BEW+pKtSTbNwW+M1b+PjaMTrrHeO3rVD9AFGq+4fOpXVg0A9u+PKG12GOsD8aopJ1CEiyZe+v7EupMnKtDbyMWG0FTF5P9znP5hTJUhlvNaix50pe+3iBUQkenPkAlx1VyfXtE6/lEWgLqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776397; c=relaxed/simple;
	bh=y5OJkb0L78vPvJ+jhN1RdX98+20kBmaDY8tOtQJDUJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QeGWUKPdS5dQURUiIKh2k5ZcuST3aleQdpfBvGqr/QVZdLTaSUyTSwe9umI0YdYLShAsiVNrFw+/fJ+e4J6G4Uzf1JiuIGClusiUfy2IrkHZKG3XJCEmw0ebZBD91gMTRGu5F04LiUhoiEmjSxDk51oP+kRSUzOKknkl+mMNoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvFyiiMJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvFyiiMJ"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-945a6c8721aso15678939f.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776394; x=1762381194; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtA/R1CHcKFfR89ANxyVKitl/byV5o/MAbL8oFYOFuE=;
        b=AvFyiiMJO2oNjN1JfAvOLdngRjTMQyxi/qkxF87EEowkBNMUhGilstKaLwkVF8EWvH
         KI7vIWvBoB+u6TgxvTTguQSikl3JnEACtsKz+hEHW5+A+K/cL07BPIpUO5ysZivyUQUh
         H2NIzE9HWhK/JFrI4KIRAgkG6KNW2g961hZNBR7t0n0QniragkuDkwPzkEckGmuuh0d9
         cXXR5KS9+MD+lsr/ixvpVNa9Dx74LAluZYhLMbNX9xomTZKVY/WC6BQCTVtmdgx/JJZI
         PW6Bp1A+aN6HhLwdRtCsdmPDYyESJ5SL2ktd/RczGyUuOdsqT/BeFdQWRHl/pHJPtgXV
         urug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776394; x=1762381194;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtA/R1CHcKFfR89ANxyVKitl/byV5o/MAbL8oFYOFuE=;
        b=mfmZsbgLXuJdQQzCDVm7Ay2blGkDmNJ7JWnzEO6zY/4Oon2IDy62zYgB5TcsOBGmhS
         zqrzs4ljqMVgJixoVLBdXgLLsjmC/vQHQYyWJmm4d7dtNbfuYoKHB6kx3UXRjTydd8Ec
         qIANvz/BKFVA4tQ8ZEql9HgqbBEdg/AGztXFAM4fxTkVxS6KVyIS3/O9A+lrJGnEr1wb
         Z5oKrPTuVjoco4V91pIbetISLXwdGWQS6vtuERCkfS738SYHfBT4XH78Q2YLL8ZgNL1z
         nYNPllAoAf4ahrAn9YdK9vO+B+UySg7yabQM/JiJGtgg4RAHp5nMv1UjhHKp8Vs0Ltpz
         dwBA==
X-Gm-Message-State: AOJu0Yyw0DmiefIhmpPt0I4vUMD1XOK81JADzFCRrifedDmz1l4lTqX0
	XDAZ+P+w0qcDGJaQ7dfhD/vPH+u6Cquuf1qhNmViwYNCViRZFmyd2u90rx9B0w==
X-Gm-Gg: ASbGncuz26umw+JolGm+Jb/IM9yDu7PCr/YiYK1XLYnTxdmUN7au1dj9S5KXpqkeuY4
	VKyLyrGvirJN+jw9w9vWqJTHCAqouIQDrhqu+luyCeOL+p241QRfGPtdmcerpNiTROUh91sQUk9
	Z8Xze854EzbnNxk3dddQj3o5OM7UqKcUuddlG46M6brFaaOU8JPqtVHvXNNg4uLXeA68Xa2m7nC
	oK+2AjK8F7ESTFAbH97CyCI9TDI1AZ8E5XJSPW+r4QFAeGyFslPYI4eRFjSkeMJV4Pf+HO16DS6
	3jPztcl+eTZSRUcTIxvFazzKKYgdmqMfjqYpO7ixrBXO7fCcPZpJrIzWgXMmpP83E40zmhwZag1
	E49Bbj1G4+sUPu4Pp7oDpSgtDCuCKIJuBzvx9+vty+3Sa+vv46WjEQ4IhHzKq3E7N1uot4XJ+Wp
	2idw==
X-Google-Smtp-Source: AGHT+IHvoncKOvChd2dIMcIHRg1ZKMAmU1MGrVitR9WDTR16hipFMFf1VNeiJL49uH/vc98P6wFqnA==
X-Received: by 2002:a05:6602:7518:b0:948:15a2:57fd with SMTP id ca18e2360f4ac-94815a25a6cmr153733239f.3.1761776394436;
        Wed, 29 Oct 2025 15:19:54 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea9e372f3sm6032251173.58.2025.10.29.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:53 -0700 (PDT)
Message-Id: <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:41 +0000
Subject: [PATCH v2 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of char
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

Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
referring to bytes in memory, rather than Unicode code points, use
uint8_t instead of char.

Every usage of this field was inspected and cast to char*, or similar,
to avoid signedness warnings/errors from the compiler. Casting was used
so that the whole of xdiff doesn't need to be refactored in order to
change the type of this field.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  6 +++---
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  8 ++++----
 xdiff/xtypes.h    |  2 +-
 xdiff/xutils.c    |  4 ++--
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6f3998ee54..411a8aa69f 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
 	int ret = 0;
 
 	for (i = 0; i < rec->size; i++) {
-		char c = rec->ptr[i];
+		uint8_t c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
 			return ret;
@@ -993,11 +993,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
 
 		xch->ignore = ignore;
 	}
@@ -1008,7 +1008,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 	size_t i;
 
 	for (i = 0; i < xpp->ignore_regex_nr; i++)
-		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
+		if (!regexec_buf(xpp->ignore_regex[i], (const char *)rec->ptr, rec->size, 1,
 				 &regmatch, 0))
 			return 1;
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index b2f1f30cd3..ead930088a 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
 {
 	xrecord_t *rec = &xdf->recs[ri];
 
-	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
+	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 	xrecord_t *rec = &xdf->recs[ri];
 
 	if (!xecfg->find_func)
-		return def_ff(rec->ptr, rec->size, buf, sz);
-	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
+		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index fd600cbb5d..75cb3e76a2 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	xrecord_t *rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch(rec1[i].ptr, rec1[i].size,
-			rec2[i].ptr, rec2[i].size, flags);
+		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
+			(const char *)rec2[i].ptr, rec2[i].size, flags);
 		if (!result)
 			return -1;
 	}
@@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 
 static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 {
-	return xdl_recmatch(rec1->ptr, rec1->size,
-			    rec2->ptr, rec2->size, flags);
+	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
+			    (const char *)rec2->ptr, rec2->size, flags);
 }
 
 /*
@@ -382,10 +382,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		 * we have a very simple mmfile structure.
 		 */
 		t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
-		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
+		t1.size = (char *)xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
 			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;
 		t2.ptr = (char *)xe2->xdf2.recs[m->i2].ptr;
-		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
+		t2.size = (char *)xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
 			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.ptr;
 		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
 			return -1;
@@ -440,7 +440,7 @@ static int line_contains_alnum(const char *ptr, long size)
 static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
-		if (line_contains_alnum(xe->xdf2.recs[i].ptr,
+		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
 				xe->xdf2.recs[i].size))
 			return 1;
 	return 0;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 669b653580..bb61354f22 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
-	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1].ptr);
+	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 192334f1b7..4cb18b2b88 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->rec.ha == rec->ha &&
-				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
-					rec->ptr, rec->size, cf->flags))
+				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
+					(const char *)rec->ptr, rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -156,8 +156,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
-			crec->ptr = prev;
-			crec->size = (long) (cur - prev);
+			crec->ptr = (uint8_t const *)prev;
+			crec->size =(long) ( cur - prev);
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 7c8c057bca..b1c520a378 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,7 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	char const *ptr;
+	uint8_t const *ptr;
 	long size;
 	unsigned long ha;
 } xrecord_t;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 447e66c719..7be063bfb6 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -465,10 +465,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	xdfenv_t env;
 
 	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1].ptr;
-	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2].ptr +
+	subfile1.size = (char *)diff_env->xdf1.recs[line1 + count1 - 2].ptr +
 		diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.ptr;
 	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1].ptr;
-	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2].ptr +
+	subfile2.size = (char *)diff_env->xdf2.recs[line2 + count2 - 2].ptr +
 		diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.ptr;
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
-- 
gitgitgadget

