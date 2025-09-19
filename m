Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1785316900
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295007; cv=none; b=vBg7nNRkKNolWkZT/rhlRBJmCY67ttDeN3N5fnWryOsD0eBUtT1yXjXXhY6S88J+DVE7T47gk2gqRR3fLJJh5iyGefzU5VChABhxYqN/KgPr3+5MZzJ3l+g0jwycRG+838FltQhZeqwwo4IMMf0cX3JnLy7JKh/Kcubf5SoJLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295007; c=relaxed/simple;
	bh=Dx7F0xJkbmCiTVV+lasW2G3nSNX3mY9z59b23P62uXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NVJxruju4iuEpURlQLtk8CBbRr+rSIdETXW03Q+k0kU+Ipj4dqgqa99u3tAUKifINLG8YCf2mpt6QKsvh3oG56GHRE3eScV0nZzcBLQI7p1zNllc/fVxIlV/I2pyRg/aXUQKiw37qsAya6qawzsxHoOmwdrf63dMVZTmf9ESJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ5sxVvo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ5sxVvo"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4248746aabfso2753435ab.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295005; x=1758899805; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x86kg+za23uKWOtKewEno5MeTePCfGZ4eyxqpRLOv+k=;
        b=hQ5sxVvoBYU1srgkuTQxbsRksr0balyi+QFCvyELdeRshMG5Uywv6Jfpgfpm8Eds2p
         WtDVGjrs7NU7gy8zYhJhC2bGS/r5HRhC75zzzF1bM217jht9kR/zoYyGXO7z9MeK4tBq
         LkSik1pbA9LjEWociX+er57vzcFee01mSndEeJS/WMoGF3OuQmCHqod1WsIMKsL3827w
         tT78hlxHfktU6m0dHcmhr4s4uA5ccWJ+74kEalzENS3pbduLIJx/Z271gZwAp9rKgtkr
         GRD1/2ZjwC46b+tZ4+Q6EZp/Cgq40Hc4fVFwNwwQPl9lB8GI0QoDI+XGCyRPbr6gfOTY
         PwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295005; x=1758899805;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x86kg+za23uKWOtKewEno5MeTePCfGZ4eyxqpRLOv+k=;
        b=bS8uzafLm09eMDq4hqAjDA928QqVYT3w9wHoRW9qNfP3qv+xhspW+eUyZDzcj2b0Hj
         C+a63rvV5LBckrTX0rZndgwNSNjhokXTJvWzaEo+O/xRgfcNOLZ+5qoxlUAZfSXbWXwX
         /sLd7fOBOFDjcJUqc2Ph4jtwDIh+Ly1ZKfPxEKNwUjCK7t5dsBJPRbR2RyUw7BqvSZGy
         CssTNRqfh/3nWzZ/hACDyJ7pWbTJh0qC6lHXNraaYTEz+O/GdFqGsuluIsIEln3jj6UD
         36KsMClymCfAe5PT1mnFhOG75oZEISwPh3JZ+v5aFoECRpY+TnZuqyYdWcO7Vyl1Vf5Q
         JyyA==
X-Gm-Message-State: AOJu0YwptuGn4SjQ6qq18b95MDfk74cACCHvtklzsvn04azBHG9CAZ5k
	NRkKSMlo+XlMb4EiCF6nO8tdzAW/fHRM84J125jasfdMTg1xbDsrZpjriCWLEgCR
X-Gm-Gg: ASbGncuSI/YRFaxRuDZMkinTsTRAmpY6ayfteDTKsncZgqu0bZylieLGQuFWMnfFgQe
	lscZgxaBGD5wD3pxIrAAMhZZyIMDvLOnln+o29FaBDAP0zEsC8S2E8y1n82xSlE2ua8ea0P2wPs
	sBmGOF8JfUQDxQb6rAzZTDO+KsdMLe5pahkb6PkxyfPaNEbynvLfuICeCKGUdriVV4/nmlg3Hc7
	Tgo4BHmqwdnGupXIsTJx3rRHMJwMH7OP8OqQ58QHiY7U1w8IIWGG7k8GldqN5Vs9RUW7gSCpDiV
	MZDG0n5mYtx++qwo3812TIKk9qj45tzwRyuLuES6c4Hq8AFfzsWOcjAqZw/cv0xvne55Yae0JE1
	JWH78xeuZm2YLdU4tSXPisWvB8A==
X-Google-Smtp-Source: AGHT+IEtGUcEYxraBcXK5u8OBlVQLS5EVhgP8gI+zNj2Ua1wbiYy9djU313crtA7Yh8qByLhnSyp/A==
X-Received: by 2002:a05:6e02:2510:b0:412:fa25:dd54 with SMTP id e9e14a558f8ab-42481929aa3mr63511895ab.14.1758295004550;
        Fri, 19 Sep 2025 08:16:44 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4245169ea7dsm22558715ab.18.2025.09.19.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:43 -0700 (PDT)
Message-Id: <0bacb1191dad2748d2afa79665f1293b0381bde1.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:28 +0000
Subject: [PATCH v3 06/10] xdiff: delete redundant array xdfile_t.ha
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

When 0 <= i < xdfile_t.nreff the following is true:
xdfile_t.ha[i] == xdfile_t.recs[xdfile_t.rindex[i]]

This makes the code about 5% slower. The fields rindex and ha are
specific to the classic diff (myers and minimal). I plan on creating a
struct for classic diff, but there'a alot of cleanup that needs to be
done before that can happen and leaving ha in would make those cleanups
harder to follow.

A subsequent commit will delete the chastore cha from xdfile_t. That
later commit will investigate deleting ha and cha independently and
together.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 24 ++++++++++++++----------
 xdiff/xprepare.c | 12 ++----------
 xdiff/xtypes.h   |  1 -
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bbf0161f84..11cd090b53 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,6 +22,11 @@
 
 #include "xinclude.h"
 
+static unsigned long get_hash(xdfile_t *xdf, long index)
+{
+	return xdf->recs[xdf->rindex[index]]->ha;
+}
+
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
 #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
@@ -42,8 +47,8 @@ typedef struct s_xdpsplit {
  * using this algorithm, so a little bit of heuristic is needed to cut the
  * search and to return a suboptimal point.
  */
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
+static long xdl_split(xdfile_t *xdf1, long off1, long lim1,
+		      xdfile_t *xdf2, long off2, long lim2,
 		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
 		      xdalgoenv_t *xenv) {
 	long dmin = off1 - lim2, dmax = lim1 - off2;
@@ -87,7 +92,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				i1 = kvdf[d + 1];
 			prev1 = i1;
 			i2 = i1 - d;
-			for (; i1 < lim1 && i2 < lim2 && ha1[i1] == ha2[i2]; i1++, i2++);
+			for (; i1 < lim1 && i2 < lim2 && get_hash(xdf1, i1) == get_hash(xdf2, i2); i1++, i2++);
 			if (i1 - prev1 > xenv->snake_cnt)
 				got_snake = 1;
 			kvdf[d] = i1;
@@ -124,7 +129,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				i1 = kvdb[d + 1] - 1;
 			prev1 = i1;
 			i2 = i1 - d;
-			for (; i1 > off1 && i2 > off2 && ha1[i1 - 1] == ha2[i2 - 1]; i1--, i2--);
+			for (; i1 > off1 && i2 > off2 && get_hash(xdf1, i1 - 1) == get_hash(xdf2, i2 - 1); i1--, i2--);
 			if (prev1 - i1 > xenv->snake_cnt)
 				got_snake = 1;
 			kvdb[d] = i1;
@@ -159,7 +164,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				if (v > XDL_K_HEUR * ec && v > best &&
 				    off1 + xenv->snake_cnt <= i1 && i1 < lim1 &&
 				    off2 + xenv->snake_cnt <= i2 && i2 < lim2) {
-					for (k = 1; ha1[i1 - k] == ha2[i2 - k]; k++)
+					for (k = 1; get_hash(xdf1, i1 - k) == get_hash(xdf2, i2 - k); k++)
 						if (k == xenv->snake_cnt) {
 							best = v;
 							spl->i1 = i1;
@@ -183,7 +188,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				if (v > XDL_K_HEUR * ec && v > best &&
 				    off1 < i1 && i1 <= lim1 - xenv->snake_cnt &&
 				    off2 < i2 && i2 <= lim2 - xenv->snake_cnt) {
-					for (k = 0; ha1[i1 + k] == ha2[i2 + k]; k++)
+					for (k = 0; get_hash(xdf1, i1 + k) == get_hash(xdf2, i2 + k); k++)
 						if (k == xenv->snake_cnt - 1) {
 							best = v;
 							spl->i1 = i1;
@@ -260,13 +265,12 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
 	 */
-	for (; off1 < lim1 && off2 < lim2 && ha1[off1] == ha2[off2]; off1++, off2++);
-	for (; off1 < lim1 && off2 < lim2 && ha1[lim1 - 1] == ha2[lim2 - 1]; lim1--, lim2--);
+	for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, off1) == get_hash(xdf2, off2); off1++, off2++);
+	for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, lim1 - 1) == get_hash(xdf2, lim2 - 1); lim1--, lim2--);
 
 	/*
 	 * If one dimension is empty, then all records on the other one must
@@ -285,7 +289,7 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		/*
 		 * Divide ...
 		 */
-		if (xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvdb,
+		if (xdl_split(xdf1, off1, lim1, xdf2, off2, lim2, kvdf, kvdb,
 			      need_min, &spl, xenv) < 0) {
 
 			return -1;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 7acca1cb38..c39b65fea9 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -133,7 +133,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
 {
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
 	xdl_free(xdf->recs);
 	xdl_cha_free(&xdf->rcha);
 }
@@ -146,7 +145,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
@@ -181,8 +179,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
 		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
-			goto abort;
 	}
 
 	xdf->rchg += 1;
@@ -300,9 +296,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf1->dend; i++, recs++) {
 		if (dis1[i] == 1 ||
 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff] = i;
-			xdf1->ha[nreff] = (*recs)->ha;
-			nreff++;
+			xdf1->rindex[nreff++] = i;
 		} else
 			xdf1->rchg[i] = 1;
 	}
@@ -312,9 +306,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf2->dend; i++, recs++) {
 		if (dis2[i] == 1 ||
 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff] = i;
-			xdf2->ha[nreff] = (*recs)->ha;
-			nreff++;
+			xdf2->rindex[nreff++] = i;
 		} else
 			xdf2->rchg[i] = 1;
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8b8467360e..85848f1685 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -52,7 +52,6 @@ typedef struct s_xdfile {
 	char *rchg;
 	long *rindex;
 	long nreff;
-	unsigned long *ha;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

