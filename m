Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9322FE02
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239810; cv=none; b=AJwUnk6MMqpzyA8igLlnGB8HjfKyqR7HOANO/YC0X/vDJgqdK5ScONhoCZuLFWN9zDts9Wwp6aQDDVMf6WHhAZb+uVquJ4ywwTXZ3lx+p9xQLOs+IXMaJ07lZs2MRMJLYBCQztW/uMRKfSx2jMIOrN2L6O65hnh+Eov8NUE9T2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239810; c=relaxed/simple;
	bh=aFuo/Yoinisa8FbLpq4Ek4E7RHMdutV6id81sjWy5v4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P101fSpaS1eeg91RkwKTRhTTAiFg9aX6oftRnHZGVdrD1upxQxzH6D4mG+f0sJxsD1kI3sHFGYB91n0mYLKgBSCi0kCwmi8eG4kYME/Zl9Qh7QW2oUjjx7xrYDc0wkhKOLL9hg7LXkZ0aWfURsaMCKRQcfm9xG9uTGPkaY6i5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg/0uM1A; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg/0uM1A"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5eee40cc0so15379191cf.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239807; x=1758844607; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQSQr5K+VmXtcRPP93z7xif+aWAeTAJ1pN59aAmDJzU=;
        b=eg/0uM1ABZGPUV45ugXxjqjd9tBrwbIdcXQnfeIIj6pfzeuPkb0GrU51j19N+P6V04
         b60Zw/ZIdoKBnDf+T8E10j6FZaJiMUIYAsVtcdZhWO0m67CS5zi8OXFzki7Xq9Ezr2PN
         7urRYI7pFeG8XWKOYGHNzpVwhuYvYBMPVw1Wv0baW35XmOTu4Uwh78wjS0NI2U2pIvf/
         FpzZSz0ZS4DHZNSYsZZCO2hK0XzZqOaQek5BZliVca1UFgAu1yDlqsLxW2/AQplzpfol
         swKPJ6IQqWEZ1AHoKZ0BCQMBcS8IJDchh/lPDCNPPps9CEE/1FX/9efUzfNmmHElBc8M
         9O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239807; x=1758844607;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQSQr5K+VmXtcRPP93z7xif+aWAeTAJ1pN59aAmDJzU=;
        b=YNRAN+J/oX0VCGpZ22/+zP8ICei8Q0wWz+3A4MQn+Gsg3H8LMQh/uocKOYDI2OHZnh
         pWo7OpVb+vgV+T+32HjbTu/OV1oRIqoWvxc3JgDiQMS4wh83sQCW2rpngVlXiecB7nLS
         FFXCz2ZQmSlMcTKfHPgmltVhTMlC+W9aaQexgwkxeaVEnWi0GRzoMPE18yZUHms1KqVJ
         FQGLHyukApqoZclzWetG+Tt8LtTfOSmEAn49yJsTyhhREt+RHhvmszALlp5Ri2T9zGpI
         dhq3InDCXwg62PwJjtgbA9X1cbO69V6UPHGUTxgMFRX9oNpg9vKf/HLfujrHRZKSNOJ0
         6Xzw==
X-Gm-Message-State: AOJu0YzknDeQDW7tfv1T4ZlC21zMVU+2TeH5fpyGdLAS1zUOg8SOLuee
	EKPowzZ+OsYMXp5o7vCY3Sjva122RQ6moUbzUh+jczONYVt6ZJOUTiINt1xPOSYP
X-Gm-Gg: ASbGncsMEGjY3FdSfKGwr7soLZOVtQy2bXPJ0Yx0kVKmKranO6mCeXldCjK1cIiz29Y
	lqTzUDzrxkAf4qG+hOc3lAPNJE0I3bITHPH3SXSE4ABhiyke5ktTg9GkdGROwuoishVym88gRop
	7iVQNIu3IEh5Y98Rr60QouxtDhxZItkpTAj7XI3mSHlwFG3wcUqlIN663RMBGGkytGju8wRjhEL
	mNPqx7NMTbV/seYB5hT0Yg3EPw3XDdkcR7sHoP6G9pw5cY21xzpzM9tyoR2hf5st9YQa5mqCppd
	n3nv5pcUEVQCm0ObUzjhrldbn/vquZkGlkvcRYlF6trkjBo0PjYKuBhK8Wpoe8O+nXWSeu1tl19
	69UL0VZu9VeYT3lrYxivJVPxT1RM+26r7l5aAtU5E1IM=
X-Google-Smtp-Source: AGHT+IH75BvtvJZcqqE15wuSsSErFr5w1Jz+vVyHMbLVhEubd9PdYXKvex0ywpYne7pkkI0hKX0SQg==
X-Received: by 2002:a05:622a:98c:b0:4b7:9438:c362 with SMTP id d75a77b69052e-4c06ed9a1a4mr14185211cf.33.1758239807023;
        Thu, 18 Sep 2025 16:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b67bcsm20759051cf.25.2025.09.18.16.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:46 -0700 (PDT)
Message-Id: <9a5ac3c48899e146e07b076b826b00a7c001b44a.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:29 +0000
Subject: [PATCH v2 10/10] xdiff: treat xdfile_t.rchg like an enum
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

Define macros NO(0), YES(1), MAYBE(2) as the enum values for rchg to
make the code easier to follow. Perhaps 'rchg' should be renamed to
'changed'?

A few of the code changes might appear to change behavior, such as:
    -    while (xdf->rchg[g->start - 1])
    +    while (xdf->rchg[g->start - 1] == YES)
because it appears the value of MAYBE is being ignored.  However, MAYBE
is only ever assigned as a value to a temporary array (dis1 & dis2) and
then as a last step use that temporary array to decide if it wants to
change xdfile_t.rchg[i] to YES or leave it as NO.  As such, rchg will
never have a value of MAYBE and thus there is no behavioral change.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiff.h      |  4 ++++
 xdiff/xdiffi.c     | 22 +++++++++++-----------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 24 ++++++++++++------------
 5 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2cecde5afe..7092879829 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -27,6 +27,10 @@
 extern "C" {
 #endif /* #ifdef __cplusplus */
 
+#define NO 0
+#define YES 1
+#define MAYBE 2
+
 /* xpparm_t.flags */
 #define XDF_NEED_MINIMAL (1 << 0)
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 83c4cff6f7..44fd27823a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->rchg[xdf2->rindex[off2]] = 1;
+			xdf2->rchg[xdf2->rindex[off2]] = YES;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->rchg[xdf1->rindex[off1]] = 1;
+			xdf1->rchg[xdf1->rindex[off1]] = YES;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -708,7 +708,7 @@ struct xdlgroup {
 static void group_init(xdfile_t *xdf, struct xdlgroup *g)
 {
 	g->start = g->end = 0;
-	while (xdf->rchg[g->end])
+	while (xdf->rchg[g->end] == YES)
 		g->end++;
 }
 
@@ -722,7 +722,7 @@ static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->start = g->end + 1;
-	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
+	for (g->end = g->start; xdf->rchg[g->end] == YES; g->end++)
 		;
 
 	return 0;
@@ -738,7 +738,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->end = g->start - 1;
-	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
+	for (g->start = g->end; xdf->rchg[g->start - 1] == YES; g->start--)
 		;
 
 	return 0;
@@ -753,10 +753,10 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
-		xdf->rchg[g->start++] = 0;
-		xdf->rchg[g->end++] = 1;
+		xdf->rchg[g->start++] = NO;
+		xdf->rchg[g->end++] = YES;
 
-		while (xdf->rchg[g->end])
+		while (xdf->rchg[g->end] == YES)
 			g->end++;
 
 		return 0;
@@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->rchg[--g->start] = 1;
-		xdf->rchg[--g->end] = 0;
+		xdf->rchg[--g->start] = YES;
+		xdf->rchg[--g->end] = NO;
 
-		while (xdf->rchg[g->start - 1])
+		while (xdf->rchg[g->start - 1] == YES)
 			g->start--;
 
 		return 0;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 4d857e8ae2..c2e85b8ab9 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = YES;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = YES;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.rchg[line1++ - 1] = 1;
+				env->xdf1.rchg[line1++ - 1] = YES;
 			while (count2--)
-				env->xdf2.rchg[line2++ - 1] = 1;
+				env->xdf2.rchg[line2++ - 1] = YES;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bf69a58527..20cda5e258 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = YES;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = YES;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = YES;
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = YES;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 5c7e858b6b..c11875d07f 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -214,9 +214,9 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	 * current line (i) is already a multimatch line.
 	 */
 	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
-		if (!dis[i - r])
+		if (dis[i - r] == NO)
 			rdis0++;
-		else if (dis[i - r] == 2)
+		else if (dis[i - r] == MAYBE)
 			rpdis0++;
 		else
 			break;
@@ -230,9 +230,9 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	if (rdis0 == 0)
 		return 0;
 	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
-		if (!dis[i + r])
+		if (dis[i + r] == NO)
 			rdis1++;
-		else if (dis[i + r] == 2)
+		else if (dis[i + r] == MAYBE)
 			rpdis1++;
 		else
 			break;
@@ -272,7 +272,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		dis1[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -280,26 +280,26 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		dis2[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
-		if (dis1[i] == 1 ||
-		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
+		if (dis1[i] == YES ||
+		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
 		} else
-			xdf1->rchg[i] = 1;
+			xdf1->rchg[i] = YES;
 	}
 	xdf1->nreff = nreff;
 
 	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
-		if (dis2[i] == 1 ||
-		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
+		if (dis2[i] == YES ||
+		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
 		} else
-			xdf2->rchg[i] = 1;
+			xdf2->rchg[i] = YES;
 	}
 	xdf2->nreff = nreff;
 
-- 
gitgitgadget
