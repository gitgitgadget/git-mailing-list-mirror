Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFF2877F0
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926531; cv=none; b=SHjDw6BuUUTDrcthUMMfN3l6rQJhf8qyiu5IsNjFONvSeO0Tdo5xwmnJDtUZ5mo8DDh3YaZDRMg6ColfuJcmAF2v1pc3osstf7XVvKIIMcH0+2Mq4s4iNBLvqKgCSyJeaYhRt8h2LI0usWGehoLTITXAKO5bMxIc5WPx9klKmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926531; c=relaxed/simple;
	bh=3w+3liWh2VHeFlzLjswwEulyh5E2r7IOR5x34QLaaIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qAiPYZTubOXDLqm5lATnc8/VCFUAGnL4ea0yI3QzhLvsiNYj09AcVZr7HfUfUW0enRKOzRBjYPyDZYX3WoSMbW59/pFCJlWkSfIbA2qKEvvvkJ8l7kKiQGobA49E/UCYKhCLax5vEpG3obJcVvNPqHMz8xyIDjW0XsX+lCiFWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmDWfJGE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmDWfJGE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580523a0so29551095ad.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926529; x=1759531329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42bumNE8N4IRxbCUD5cCLsSZ8ehPkjDeVTwVG3twL7Y=;
        b=bmDWfJGEpbsb0Q5um13LyVp6HeALiKJ+Hvi6b2SbXUJH4EuNWjY2wTXKtXIbGxIaDo
         pJVkkrLei8ggiXkCAOzvsxHf4cbg77bMQVvUhovnMID3b/Mep94q3zuARGm2a5S3rYx5
         wjEdHrdUwfnl9T73OK/AfVgMGbwUYo9Uvm8oDqGprCcJraD89JQ+gDaglzs/lE4V34q+
         ExqZoXRFB6dMALEGbaF0KRXaC8i02LWDy7EpSqhwOimltGTNZXJdikBKDLumVVQLBVKf
         TM92yktEBHX8gT6q+4A0sfETluCw/bRE0fRTFdbJ3OK8mGl7GTryh5YXCf2wYpfwJZmu
         k+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926529; x=1759531329;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42bumNE8N4IRxbCUD5cCLsSZ8ehPkjDeVTwVG3twL7Y=;
        b=pvBEFiIQ8NDj9zbLgWAWCzBDaHa7qhbZoR7nX+nfdc1PMXNTuXvqm/zIrgZIQRaE/e
         W4xero3D/FLH8UN2rK0b170RYaXGwX60higwtnRmuO4mePHS00RXm16JFdcxmYaqrF8K
         Fkiy4jqcbzK6ES9qqLNAcE2dIQUidy+bMP6f++9pnTLc7MCx7nE5JGWqqQD7jTZ9gqwc
         7vS+cvxpKUDzNJEKLogouVclryVMJYwYgMmu7qelLy8ago9vSdYr+qsilw7R9tpS5gxx
         ZD+FDtae4JPJrpuJKVSXL8vWItxVSoO1AToo0GcrEqF2gStbto5v3yTttvpdAInAx37F
         LLZg==
X-Gm-Message-State: AOJu0Yz2rigFovCvfrw/y6Bw+Q7r3iYlvkMN8P+75WAS+j+9IA32Gd/H
	DqXyWzxpG99EcVQSXHhpW+hgNJhxa6AaOtkdrAZPCS2ozj5S7S0IYf88SLlBpBaH
X-Gm-Gg: ASbGncsDFBV9jIcVnrkqSQXaWgiEsFuDHOOxesbBpkPiOTeOF2VdTgpmZY6+ckIh3Fe
	yzn3nSiXsetPfpN7z2Io5NjJX8hSE1zrZicP5f9Dr0k4QKUaQ4zZc8xBc3w6rGPM57IH4+XOMqG
	HUNDBde1arOLaZNLM0ww7hhNkdbE20D4Ip11KVbhFxFJxhTJv7VxtE+tyVwlYWHBg06vfDr6QyY
	Af94n7wPLxdqD5HWRdcTppZDVv2+vroNzeRaG6F+vaU9j9htNF3B7lQBtLoLeyndGLRV0q2lmrs
	oKfsQqqaKkBSlId7jodCHjpOPJpUnk4AZEUjzLVTI32cJBHNWYXha+jcpNSRLiBqGv3mit+eIAf
	Wp2Rz5+kJolUl+IzuLCMeNou8Y1qj/j4QENQ=
X-Google-Smtp-Source: AGHT+IEFR/+0Jhyb27imfPwJI4kjsQ2HdbPcmF36jMfJr0VoubdtoVP6TrgQT/HSKYseiPd7bxYjjw==
X-Received: by 2002:a17:902:da89:b0:267:a5df:9b07 with SMTP id d9443c01a7336-27ed49b9e96mr105506605ad.12.1758926528821;
        Fri, 26 Sep 2025 15:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882160sm62709565ad.71.2025.09.26.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:08 -0700 (PDT)
Message-Id: <6dce41cd3d296e39c25e85c53d8642b87e12a1aa.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:53 +0000
Subject: [PATCH v6 06/12] xdiff: delete struct diffdata_t
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
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Every field in this struct is an alias for a certain field in xdfile_t.

diffdata_t.nrec   -> xdfile_t.nreff
diffdata_t.ha     -> xdfile_t.ha
diffdata_t.rindex -> xdfile_t.rindex
diffdata_t.rchg   -> xdfile_t.rchg

I think this struct existed before xdfile_t, and was kept for backward
compatibility reasons. I think xdiffi should have been refactored to
use the new (xdfile_t) struct, but was easier to alias it instead.

The local variables rchg* and rindex* don't shorten the lines by much,
nor do they really need to be there to make the code more readable.
Delete them.

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

