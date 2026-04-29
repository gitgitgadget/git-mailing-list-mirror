Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECA426D14
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500505; cv=none; b=SZIVcRdCWpdgA5uVtXqlNcUU9hJ+ZgUS6bPeTwVs7oyoerIDHQZsOad4mfD4WRqmT1bTN9WNJ3h1mIkmFn+UvAZLPkm1QpyrElLS+zMhSSJOBip0tcIv9ww0FGcELQgPUK4Pgsig0uSdtTVjIYKCucdjKiFlyZ+BODVT7WOMJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500505; c=relaxed/simple;
	bh=GXJ6qMnIBFuKciwNoZdOoHGyQKPBfiZWcEo+Zx1X/m8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WNQCZcX1XHY0L/c1PaDdBEDiPqJEHZE9AXnN/MS9Nk8YfuTSvOBoCDK6qSQzX+5f+cyGLfDnpqKA6vdkD8SDubUvS/40rJ7q4l3IOnkWjnyPTbL8nwt94++p92xHQ0VWhdJj6fcoc/MZWGVlsh7UL9h2AcMLhgzXJ4nuzBTh0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7osgRwU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7osgRwU"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b038a00370so2763616d6.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500502; x=1778105302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5I+D1OGjjWITvtrNBOf07CPcXUcwBOjnRH7y4BrTmg=;
        b=l7osgRwUczBM8Z0KSwh+jgQ5IfrRqt/wGCZIZaM914ZmPsi4msaOvpK6Svi/bk0ig1
         Uz/aCmDJf2hU/28Hh1aQNGUNT7xosXATbWlkyJbU5TIq/DXDUaTEGSHdYqmbo2SAAtKD
         Yk2pKTQFtK9qH8eg+uu9jyvTFN6up1u4544caaU4/VRKtZ534EJRE/PQFzQkwCDp0IfL
         Ig2LiZBWA4Ad+p/z9TaWHDWEQIggzMfpjSH7y+dhvdHxkUv8KTOShBMkeIeSymZa681A
         QHXgcd4OPKeakv7aPeCm6Gw7ChlJr2hvnQgO1mGoyXYMbO/3CNvehwYSx+zafNtJCNuq
         0eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500502; x=1778105302;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5I+D1OGjjWITvtrNBOf07CPcXUcwBOjnRH7y4BrTmg=;
        b=RfDjjEyOyfXM0gxAVL/B/WUKKqh+A59JAtujGzXsr9ktO6bJlkOhjC0kp+9gWUyEWv
         iEhqbC9rtrk06RP+vn7mS2VNT0H2el8oGt0iRLTQcYeeGEmauFaYwPKhfApmJk/yo842
         yESCJdQPmTXZ3lU0gSd0TmR1aNzRIqTIf1lY1RaWix84iwaUEGOVf7se2eteX6f1Orxr
         NZU95AwJI2UcEMAOh06Ox6lONV40b7i4YkUoQC2BT2BZh0+PgXMbNV401GmCgnNwPSkH
         85cd8A1BdFLuz4AyJWAY4IjxhMpNWvXMZb5UT2pqbzjNhKeygKu9b8WAq65FPAnSZ42j
         oQNw==
X-Gm-Message-State: AOJu0Yz3J4inkNiCi8pJGEYUjS/Fkb2ETascXvtKZpOHYg10w30TE88A
	CZrdq1dAhxFCD7GOlcvVP5ruwVlrzmyHwlFhSUFpmtJylAVuyKfEk2lGFjVbMw==
X-Gm-Gg: AeBDies94TY0S7mRVraNS1y3kBxI3ZnM1sbhLF5un8rG8fUu6U0WHBtYSshQe3NmTTv
	dJnlFre7UJI5SeylpkqqcaaohQwd7rRjLOecyjueBgo13dv/eUK1Wv5PMhsqrhISzOX1BS37Pkz
	c5mcd4hdP1V+48GdV7NnlUB3R60hDw+gjur8Dsn4eecHyW+abJWi6Qtmf5uM0g+AQ8OXUOO8Z5z
	fQTgET4LNk7pDBvIBbgaL4+zPWsynUQSW87S4zzAKobm5Jj/eI92iemVUb+aRpY0ig75U5w63LM
	gRhMkwdOqzq/MsQuemUahN2UJXp9Rkz7YHkTQVUgRS34qg0hH8eazfzlWi1p6fJAKAz+No/Zjle
	dmcimF1Rzcz7L2yTHwOxytZsVVasovkLVeNNnyJFU2Eo/zx4ZMAtveCyuRAasV0K4PwZdTzZ1rg
	3C8GTahGntCNC6usTxoiuzzdHJTuYQLNjQ2zcMsGI=
X-Received: by 2002:ad4:5ccc:0:b0:8ae:5fcc:ebb5 with SMTP id 6a1803df08f44-8b3ff014e46mr3745386d6.47.1777500501657;
        Wed, 29 Apr 2026 15:08:21 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff307a48sm1281326d6.8.2026.04.29.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:21 -0700 (PDT)
Message-Id: <51c62ed454cd66e884fdbbf3635603ca66966bc8.1777500495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:13 +0000
Subject: [PATCH v6 4/6] xdiff/xdl_cleanup_records: make limits more clear
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Make the handling of per-file limits and the minimal-case clearer.
  * Use explicit per-file limit variables (mlim1, mlim2) and initialize
    them.
  * The additional condition `!need_min` is redudant now, remove it.
Best viewed with --color-words.

Helped-by: Phillip Wood
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 386668a92d..7141dbc058 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	ptrdiff_t i, nm, mlim;
+	ptrdiff_t i, nm, mlim1, mlim2;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -290,22 +290,34 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
+	if (need_min) {
+		/* i.e. infinity */
+		mlim1 = PTRDIFF_MAX;
+	} else {
+		mlim1 = xdl_bogosqrt((uint64_t)xdf1->nrec);
+		if (mlim1 > XDL_MAX_EQLIMIT)
+			mlim1 = XDL_MAX_EQLIMIT;
+	}
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
+	if (need_min) {
+		/* i.e. infinity */
+		mlim2 = PTRDIFF_MAX;
+	} else {
+		mlim2 = xdl_bogosqrt((uint64_t)xdf2->nrec);
+		if (mlim2 > XDL_MAX_EQLIMIT)
+			mlim2 = XDL_MAX_EQLIMIT;
+	}
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
-		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
 	}
 
 	/*
-- 
gitgitgadget

