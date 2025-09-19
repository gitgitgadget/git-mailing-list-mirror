Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AF3176FF
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295004; cv=none; b=JROUAReajBcVhuW/4dgbBIOn7wz0ZjVYpzP3R462sPrZlGn9z3E6n3Z6nQUN22WDA+SsyIL+dfUUGao7JK/7juxCjbvR3QHEedm2Vjcw99w1i5NIKDFyvY9EiA5DBFnZLYB7OQ2qSLLeqXccdo1DVpwnsLYJAj/4tIE78E1iwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295004; c=relaxed/simple;
	bh=iNPZ6zToN3/coANG7+P3BaZatp7jypphFiA3XbL9+0U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u/oW1HeFfgbZ0xGT4zgHOQ6sAwenrcHOWSZSf1dHD6RxojBwkgFPKM/mJ/HEResi5Inoz+PAe5g5t/8yIdNpHOhwZ8+kgPNLqOM/rjcBhb6Vt4QKfsA49uAiA6vjITcB/yGVFwjzHaxu6FnikmCKzSCKzxbvTdmEkQokyrbL7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsAB5emo; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsAB5emo"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso149295ab.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295001; x=1758899801; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o4F823WXDlNlLg2iEhmJIRh6r2lzFNm80iwvaMOhHg=;
        b=UsAB5emo/cUYV01f1EwwOs7Kny8yLDOIsMPGx5mzezqJvzOAbiqJgP8MEyVwrb+oVb
         TFpsoDVD9PocULP2Pb/sK+GaNOHM6MPXkExLdkxKBiXGXuTXHX8PohdxzCQrxraq6m0f
         JHhIV5/jvGJH2bww+e03Hzj6H0UeqjZFEkt2m/ZXNSpGpf60TomhhplXWD7lm9j1IsrF
         DUs0MAUSSEqvZz40anfY/ZU3yLHv6wqZlpPYUtdfnKPBZQbmtNguA3mdK2Tr2VMS13RS
         V/Uu+UU6+l2dC12JsnjprHk8gh+nA2WXzTl67YORFcxX8AWn2qWJZ0ZMFIA+/YQWeHo3
         NnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295001; x=1758899801;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o4F823WXDlNlLg2iEhmJIRh6r2lzFNm80iwvaMOhHg=;
        b=AG7ExH3ataQF14fX/NSN0inGFkuEaD+NM5uON5rwEqyGBFRKcdDKwoLr0LJdYub99D
         JqxZFlY2Re9hT9ZNbU5/BRl5NE3++Bi6paApHRxyOUTdMODp2NSe23R2vFGeNPmpF4GI
         LRSDh6XPZj9SU4eYEZUeP0LQlwAYqOammHTzzqJyKxlxoYhP6PXB4QaaMU4NFE0hQVip
         L+kzYRYZFdbQ69GskYuNGDGUidaXdsrhtV93zLpzraQGVLsgOb0cK8SlCr18XafKDagA
         aRry01OwMVI329dlJE2e/06llX/jHFFvh3zP7yFh1i0SG/rLchg4jRacEBX5GiqE5K0R
         z2/w==
X-Gm-Message-State: AOJu0YyectykykwGBJqoDeSogqoqe/gTEg/db6HDx0usUtWW+Om99Qv4
	utW0k5njYeFcoQtbHe30Jxl9W9c3TIHb7v/Whz/rfIqwmJE/Wpqe9QN2F5g3mBY4
X-Gm-Gg: ASbGncsgEJRmyktsrmoxeuQ8TlEFIjDoki+rhPylOsRjnFb7haAdi3JmAHagW2FQb03
	p7tUXvqkiR5f15T1Jc6j81VNOb1ldmuvHcYynZY1+jR7WgVgCOem2vKNvLm4qNp8auCAd6UwJag
	YyaA2cHrvrpm/rQA6A3Xa6xaoPNYL01yzGVmB5nJ0n5gPaOVVBp55m29Dajch924l4kBlmqMT2N
	8c64E6KQILdiiuXPYX5uCh0NJ1mVGETSmcLrMjnLVia2QOtTHoNye6h9OloPHLMg5VyXnUdMWCI
	RSnkwSaI7Wdc3EGQSvSKG9keu1BhbOfBy6X1fFTBznQoMJ+zGRNIzyQ/IVBwtqFFDGAui0M+xLb
	8k6A+9d83SGDzaNZ3EK1aO6+tvuZiW0GVKFVi
X-Google-Smtp-Source: AGHT+IFsH1rlfrII0XiT4zEcKJVyfVO7Myc0bkJyLAo1F/tz8uq2+C0TYNIIYGNidGX1PFLVzmUSWw==
X-Received: by 2002:a92:cdad:0:b0:424:8160:46de with SMTP id e9e14a558f8ab-424819bcc22mr55780675ab.28.1758295000996;
        Fri, 19 Sep 2025 08:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244b29c962sm23021055ab.39.2025.09.19.08.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:40 -0700 (PDT)
Message-Id: <ddfee67e06bb56cfa8f11187dc27135bfce63647.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:26 +0000
Subject: [PATCH v3 04/10] xdiff: delete xdl_get_rec() in xemit
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

This function aliases the fields of xrecord_t, which makes it harder
to track the usages of those fields. Delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..b3793e81e2 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,21 +22,11 @@
 
 #include "xinclude.h"
 
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
-
-	*rec = xdf->recs[ri]->ptr;
-
-	return xdf->recs[ri]->size;
-}
-
-
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
-	long size, psize = strlen(pre);
-	char const *rec;
-
-	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
+{
+	xrecord_t *rec = xdf->recs[ri];
 
+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
 		return -1;
 	}
 
@@ -120,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	xrecord_t *rec = xdf->recs[ri];
+
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz);
-	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -160,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	xrecord_t *rec = xdf->recs[ri];
+	long i = 0;
 
-	while (len > 0 && XDL_ISSPACE(*rec)) {
-		rec++;
-		len--;
-	}
-	return !len;
+	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
+
+	return i == rec->size;
 }
 
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-- 
gitgitgadget

