Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709F2DC79B
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505270; cv=none; b=uTnSLA4neuLgIdFLGzBkomynWx961/wVd83Lzy4lpzOBwAuQju+nlBijSXVXWpL/BRZmAZaWNrrWEj13WgajvS76Jpfog9Ldlhxe8d/t7OZIOPwuI4PBtfzAY6Hs5N+2mwkTSq/+saVjxDJm43TGJm5DOBz/8Xz2lisnQcjshw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505270; c=relaxed/simple;
	bh=5PzV0eQGUPgvPVfGX0GFM5a3aW5AQIoWGxSxwGYRU/Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KltjLyPQIIlKWRYQ+N0JaWPcVsVdSyN5t39w5/DrFDtyWbJbWnoB1PcOPblvPqVTDgNIbvxxrP0ckS98dBSgwWCBLVAzQ4mmbEhf/eYgVbGCEXEahsZMX3TwMWeYceuFUPantQhXhQLKyAEL1Cqxzdsp/q18O4ofGOQiVMiost4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+ItfDYm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+ItfDYm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3437ea05540so5579330a91.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505267; x=1764110067; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdzVU4nwFKp9XLGuZeUiC20Ju9LsKz+p6AtajJ3SsBo=;
        b=G+ItfDYmnEJuHw8PCdLqdW6Mj5niQwT0FtNmZd4ebkXLA6jpydjNzKqQfZwE1L9tjj
         WeheLQto3u/IXjCj4PDV9NBHCk878nMJ1s++WbMavNr8/nYjLvkq889LyajZxLIvmx4y
         9IKqYrb763Dzq77GI4TMCgYP69aj4fDlwlcfFcDGYaEf2OAQ9IDeINFhS3N0vny/With
         6grKuXeBgYNcH7ScURaCGH/LofgKAZVVkLf8uFzqs8AeS58OBzep1zjlChaqz/QTYLtl
         I7xDc9u+PeEACnxOfyYBxQ5JOLRt67wQSiOOVxff/ZX92pSNpoFuOf9UtI6kXmlNyOZH
         OiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505267; x=1764110067;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdzVU4nwFKp9XLGuZeUiC20Ju9LsKz+p6AtajJ3SsBo=;
        b=jaOtULl6kHZvHWzoTbDgglze78u4JCdHJqc+uW+lcxQI9BdYHPxO/JFG3Ru/RcHWX/
         9RzUd6Cza5IoE5t5t6Lr85flts2l/xVzkGVvjuT4brCw3Rj3sJZp0Sz1oz3XHSbhAYEI
         k6eQ7LUrb9X2voYnsn7og0ymademUBiNgwHHpNAjf1cuUjCsVm3YSC6BuVGzpNTu+ATq
         XHEf13UfiAsatT8+dPGfoHTxANxxp7lSgff9rv/MFesTBu/OpSUnvTwqKI5o0Wz/en4b
         Fi9DqdGl8bCf2/qY4p61QZ5zB2U+OgQoSCbkmt9af7NovAbHY/Y4NRZW+ruPWIm+2iIU
         wxAg==
X-Gm-Message-State: AOJu0Yw8UrTHAMaEEhoIAgZouMT8h/UVYgon40vV2+F4mjzBaqg4aame
	P9HOByzwfDC1KDbBya3D52EugsuxdZMszJ2nh0HmzANhChpgFoRAWgtTct4HQw==
X-Gm-Gg: ASbGncuhVhKp9LA+zYZrGFpWpROCThn/u+WJdzFAOWh1UmrGOlZyYj4CHaA6n41JGjR
	fL4MI4qjsuRkClD9jNoPhVrFRs3K00SWtJwk+W5bw1sMZ2QjsrU1pl58NrrKF8Wa4s/islY/E40
	Z8NNYdQeyjpLCnwiMXTCp+7+75H2R07cQq3UPk2/74YxTdrYsCF0n1/EorzPP/QNOgIeDklHaeo
	LQrjKy/FpsbOFQPhuWPG34SJrwfIzlzIZxOCbWh93gm822nKv11yB27b+XvgHHyrEpSzmknvXr2
	E4IFyjqxZ0LMqvB8BQTVFPSC4Mbmq35g76lTpb7v8cHp7x5S/750wRVsDp5qOE3RJ1Hwx7NEu6F
	DMEiECZeQFgmDBuYcQ83nfi31sRm28gkaO1VRx4KZSMl93pj5qli08TNob63VeK1E7tLO0D71uq
	Ajc2Y3Qrs+NhJMFHjUUdqBNTYzY+pJnGOTmw==
X-Google-Smtp-Source: AGHT+IHlxZx3QmM0EmAr9QigtcuRv2igcGEHg3Xv/cqThohLmMIWT1Q4LaT8jDDwzvRCcUGFv40VPA==
X-Received: by 2002:a17:90b:28cc:b0:33f:ebc2:643 with SMTP id 98e67ed59e1d1-343fa527f01mr20209217a91.23.1763505267192;
        Tue, 18 Nov 2025 14:34:27 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bbfcd102sm501230a91.3.2025.11.18.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:26 -0800 (PST)
Message-Id: <dd76d4f58630fe165998f26f010fb3a4c69fd1fb.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:15 +0000
Subject: [PATCH v5 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of char
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

Make xrecord_t.ptr uint8_t because it's referring to bytes in memory.

In order to avoid a refactor avalanche, many uses of this field were
cast to char* or similar.

Places where casting was unnecessary:
xemit.c:156
xmerge.c:124
xmerge.c:127
xmerge.c:164
xmerge.c:169
xmerge.c:172
xmerge.c:178

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  6 +++---
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  6 +++---
 xdiff/xtypes.h    |  2 +-
 xdiff/xutils.c    |  4 ++--
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6f3998ee54..95989b6af1 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
 	int ret = 0;
 
 	for (i = 0; i < rec->size; i++) {
-		char c = rec->ptr[i];
+		char c = (char) rec->ptr[i];
 
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
index 192334f1b7..4c56467076 100644
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
@@ -156,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
-			crec->ptr = prev;
+			crec->ptr = (uint8_t const *)prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 7a2d429ec5..69727fb299 100644
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

