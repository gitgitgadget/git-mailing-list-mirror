Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B977317706
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295006; cv=none; b=YqbZEumYS19sqjlCwlAw/WkJnpzDE7xGZC3HUq22+2FVHyZl603tltSas2nrg6InZkqkzcS15ASFUMrtL59Ho3cwUOvClLLRa8SWF92/VUmru3HNjlQTAQ8grzw+/p+fL8FUE5WejbDq/HTEZaftg847lUWif+aIRkE9uAQVkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295006; c=relaxed/simple;
	bh=zejrKiRM2CWHXswyfUP3N98+xfqSySoV4HBV8AsHsIw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lltIYNXyWjFIFuAyq4jzmSE0TT65ozUsgYza0IRKCBjeSUi9fUeKOPEOJHyIye8uCbKoIDk0h66rQSkPdtAOWwd2W83aZeMkE2IUiPhUlG4ssxrPW5kMCRqSE1IlfAkdPNmOAE+NuSQWMeC3zQgd9EREsdLr/JwpPtf/0pxMIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEMrH9fc; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEMrH9fc"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8a3e61fa206so103079339f.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295003; x=1758899803; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=kEMrH9fc33cEpJS/TKFyUfQtkhrue6FryX/YPb/+O5NkyYMgVyyvbfBUy3/jQ+v1Ud
         fbBA0glmL8Bp+saeuLk4mvji+yZ9NA5l0RKZGj4yFgnfvauwcdn851QmwsxM0qPZrc3Q
         t+UYyvADFdwhpaz8nllUM/LrXX7IkewCItfGswJ3Q9P6UfZM8inmki13L3fBzOWTG9Pf
         fNYxfvQgJq06yLTAl9D/Wz8wkU3RKtLO0FTBvY1DD5moe8Jmi3IVE57DL45XZjC8B9pB
         uhzJHfU1RY8B7+M2F1lYeBrYMuw4AuHG4wY1RG9Y14bHR3pKnoH+78dNqxUMJPJre5Zh
         Xgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295003; x=1758899803;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=vVC2Z+Sty6UafsxowvgwonlF6Hm6X5+g5skpc3dbMPQ7NYFJ7UtEoQW+sts8kwOm/R
         +JcIlOWy6wAaUjEXKupvB326Vig+l9uUUrUxlbeBLsyO8EceYlmGwKGT+PCimZ2fFT7Z
         AxX3+q4/ZOV/ldzf1E4koaYvI+prNWHGQOBE0/Jl6a2hYKeU71++NayBYZFmRDvAQzNH
         abplHMbPGLWpCU9/6WEN7+NeT2/Mjv4hA7Yv9tAUmBv9LEnwpmoK/wleI8Ujy8OIAtFH
         2nRaLesDMm2G8YryshO/PLrknY97Qx+3itOXbByQeYwhUWHQIH6G7U4Qw20MvKy/sQpx
         UdvQ==
X-Gm-Message-State: AOJu0YxNW6FRcNeSztO0Nu/ZVB5aR+vbB40zmNbStado9enMCkz1VE7S
	ZrtsI5D1lWTap1UTK9epvo9wfpySS2c4ZXK6ObWpKpzxmExGrTjdc4kVAfxW4Rx6
X-Gm-Gg: ASbGncuw6SiXWC+r1ND3POded4gQg/VdUlQi/fujnyjem9UM7kb0z5mMKTAdO4B4j7I
	ATFsPolPQggm+OcfMOcx28mHwQDY1GmEyI08kEmkSKWjVz5j9Ul8QDKNYsl+eHRQ37vixBFP0Qa
	ny/u+dDt6k0w2Xku1eG9krW+Bv5Z4DENfhcZOFALu48rTfykJH3xkxx93DaYFyrneK05KCvzay3
	ttic2ti5hN140YTQhWoy2tl3X5tlQIjgH4bFrZw6hRnebYdjlSSFffnEnjTunWe1jpMWDefrjId
	OHneDE71w30NxbRlz0tp5VszVHpVq3Y9Iz7idd0Y2IujBVHi24dhVYjgT04tiIW7TCtKX0lglNl
	lAju3gN2MtCF58YvcchmVTwZUTA==
X-Google-Smtp-Source: AGHT+IGwBG6Pww23bjDChgupsTbfZfSQIKKFmyrQzyNhnZtwKriT9WLa9I34k2Wd21hwtOgoSpYzaQ==
X-Received: by 2002:a05:6e02:e4e:b0:3fc:4a8c:23d with SMTP id e9e14a558f8ab-424432f910amr83495065ab.15.1758295002912;
        Fri, 19 Sep 2025 08:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3d9a1b0dsm2281351173.18.2025.09.19.08.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:41 -0700 (PDT)
Message-Id: <807ce3e5aae0253dd58c7a4d0bd04ca341b070c8.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:27 +0000
Subject: [PATCH v3 05/10] xdiff: delete struct diffdata_t
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

Every field in this struct is an alias for a certain field in xdfile_t.

diffdata_t.nrec   -> xdfile_t.nreff
diffdata_t.ha     -> xdfile_t.ha
diffdata_t.rindex -> xdfile_t.rindex
diffdata_t.rchg   -> xdfile_t.rchg

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c | 32 ++++++++------------------------
 xdiff/xdiffi.h | 11 ++---------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a96e36dfb..bbf0161f84 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -257,10 +257,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
  * sub-boxes by calling the box splitting function. Note that the real job
  * (marking changed lines) is done in the two boundary reaching checks.
  */
-int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
-		 diffdata_t *dd2, long off2, long lim2,
+int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
+		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = dd1->ha, *ha2 = dd2->ha;
+	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
@@ -273,17 +273,11 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 	 * be obviously changed.
 	 */
 	if (off1 == lim1) {
-		char *rchg2 = dd2->rchg;
-		long *rindex2 = dd2->rindex;
-
 		for (; off2 < lim2; off2++)
-			rchg2[rindex2[off2]] = 1;
+			xdf2->rchg[xdf2->rindex[off2]] = 1;
 	} else if (off2 == lim2) {
-		char *rchg1 = dd1->rchg;
-		long *rindex1 = dd1->rindex;
-
 		for (; off1 < lim1; off1++)
-			rchg1[rindex1[off1]] = 1;
+			xdf1->rchg[xdf1->rindex[off1]] = 1;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -300,9 +294,9 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 		/*
 		 * ... et Impera.
 		 */
-		if (xdl_recs_cmp(dd1, off1, spl.i1, dd2, off2, spl.i2,
+		if (xdl_recs_cmp(xdf1, off1, spl.i1, xdf2, off2, spl.i2,
 				 kvdf, kvdb, spl.min_lo, xenv) < 0 ||
-		    xdl_recs_cmp(dd1, spl.i1, lim1, dd2, spl.i2, lim2,
+		    xdl_recs_cmp(xdf1, spl.i1, lim1, xdf2, spl.i2, lim2,
 				 kvdf, kvdb, spl.min_hi, xenv) < 0) {
 
 			return -1;
@@ -318,7 +312,6 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	long ndiags;
 	long *kvd, *kvdf, *kvdb;
 	xdalgoenv_t xenv;
-	diffdata_t dd1, dd2;
 	int res;
 
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
@@ -357,16 +350,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xenv.snake_cnt = XDL_SNAKE_CNT;
 	xenv.heur_min = XDL_HEUR_MIN_COST;
 
-	dd1.nrec = xe->xdf1.nreff;
-	dd1.ha = xe->xdf1.ha;
-	dd1.rchg = xe->xdf1.rchg;
-	dd1.rindex = xe->xdf1.rindex;
-	dd2.nrec = xe->xdf2.nreff;
-	dd2.ha = xe->xdf2.ha;
-	dd2.rchg = xe->xdf2.rchg;
-	dd2.rindex = xe->xdf2.rindex;
-
-	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
+	res = xdl_recs_cmp(&xe->xdf1, 0, xe->xdf1.nreff, &xe->xdf2, 0, xe->xdf2.nreff,
 			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
 			   &xenv);
 	xdl_free(kvd);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 126c9d8ff4..49e52c67f9 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -24,13 +24,6 @@
 #define XDIFFI_H
 
 
-typedef struct s_diffdata {
-	long nrec;
-	unsigned long const *ha;
-	long *rindex;
-	char *rchg;
-} diffdata_t;
-
 typedef struct s_xdalgoenv {
 	long mxcost;
 	long snake_cnt;
@@ -46,8 +39,8 @@ typedef struct s_xdchange {
 
 
 
-int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
-		 diffdata_t *dd2, long off2, long lim2,
+int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
+		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
 int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *xe);
-- 
gitgitgadget

