Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB394391E73
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679999; cv=none; b=SKdwy5Lgyzk+E1WrYUqUQX3EHpv6bo/sdIeZmXkliviqS0w3rJbd9T2qsYBJBf4cel/irMGwRbRKyB7rXkla7aLQTqWTlpk8nv6o+EiI+mdL04qKnJrgKsXQR7x721NTdlX9ll9CZQKCO6dA8G6UZnAZBO7e79w5wXSMh3fKkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679999; c=relaxed/simple;
	bh=FFuhpmWurBjKOyq7ATY2jDO3nPkj+6D15TG+n68Zw7o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jm46KbOW1V6uPOeKsrsap1Wvx+7ZFbbpBlen2S5QeX8Ef7aX7prC42xTHkdsU/FKyDbwhdKShGtWwayojAlGkVpL5on4a05ogZ6/sJTIqCPQxb6wD2fQpNemYK6RhQ2MwJzbWMXuSrIZTzua40Xe6X+w1hd/wD0HWh+l1tbJbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljKb2AUw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljKb2AUw"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso130922a91.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679997; x=1776284797; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhRbJUEFrw3P/J0Ivta4Wcfd37QkbrMiHe8YvmCL7tM=;
        b=ljKb2AUwyvUVTGgnHV6Zt8KhlPi/BtRl78BzZ0FUmSALqHLA73yrm7EmABudNyCdO/
         SaHcBTS8Q6cMQtLEZXlisjiK8/FRvkuaz85RYXgfPNcRvcc78LI4lV7ozBFMTFhdHbNA
         UHhRE73y6xP/Kk1f+W8I65UuWqDXOo6isrKNX8DbEZzj6D6fOajBzHbJEg9dhxZTdFv3
         Bmjc8A+iycC/SpEgtR3FZvBdOub6DqmexKrR/B3t7e2e6aNKr4qEJL2Sd0NXp9bPpYpe
         lG46dAoAgIuBCo5OODs31vH22wAKgsqAhltaeBW5ZpclxsuZVVbUKSxUUIT/01tOUxSE
         rp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679997; x=1776284797;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhRbJUEFrw3P/J0Ivta4Wcfd37QkbrMiHe8YvmCL7tM=;
        b=H1vwjYiWHnjYm6mDBRP5WpSvmchqWORvwSjiiAXaW8+Etd84elnllErCFNWGOWVdVe
         qDESV6Vumk8/coJ5NiDAZHGiDRtZFq60/sF6RZYhDktUvIIyZoIpJhf0p8LbppiUBtlw
         tLvyWza8qrokl2MEl2LY9k7/7juFUzTpjryQpps2EsnGmDy5vtIsZbu56V6WhOrvfW6n
         kPIYyQM73PNGMxiycPzix0W/KgRUFP9JgKyMeXjnSupK3WWtqJDO/4rN86eSLPNgYu/I
         vvD4DY1zRCXUn8jNjXLJtqQ++1wQZIAWkAoaaOA7PvWNeDxXFGOqX0b9Hv05zBelP/Dl
         8oog==
X-Gm-Message-State: AOJu0YyQfQEJXm4scblQbtavqVEImxCXyjhkWALnUTjjBmVVVfrUf7oq
	nMsYpZ1TRZ3d+U94iUI5s7e9gSRxquosFJcSNgS/3kaRLwmR2A+JIIvyqiQU7A==
X-Gm-Gg: AeBDieupNmGO4W/Ce2RsYxp2h9s6t4ygVYz0ne8/jNLnlznH8VGAotZtWIzt9UjsR25
	d50TX2APx1aycewuhFkDXBnMeh23lHqBiOW2mtS9m7pP8bK1G2NbeJ2xM9xyeJK+yHyUMncNTmj
	l+44anQfyh5RnIpk6UzE26cjOzqfd9r7JFZ+aNTJSJBX0Rky2yIrdCyAw9IclDxUCJpKP6stIL2
	e2AWS9kY8UW62toRIU1McJOpYheW3FCd+DPThAFXvtG9V7HXHePhoAzmsefDCfvIWBhhiLPwP9t
	BCES/QS3LfszGuA9KjcvHBqBK7L3hzw91HlvN+KklmflpNI0PGKnkY9FLnI3ZK/Tt4m/uAtHsla
	YGVyNYctfqo7aYsvYq4lP60u98080CdsaySLkWYWG4eb7DT+ysPbaxMeBhPlOBbCrYIYCoHMDf7
	QKTQoWnESpfq+/F9VNczKfDKBCWT6T
X-Received: by 2002:a05:7300:8186:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2d40c20b8damr536648eec.2.1775679997302;
        Wed, 08 Apr 2026 13:26:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df8942sm28617173eec.2.2026.04.08.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:36 -0700 (PDT)
Message-Id: <fec2b0f38ae30deceda104ec140fa4d404324103.1775679988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:26 +0000
Subject: [PATCH v5 4/6] xdiff/xdl_cleanup_records: make limits more clear
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

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 386668a92d..bd8baf214d 100644
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
@@ -287,25 +287,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		goto cleanup;
 	}
 
+	if (need_min) {
+		/* i.e. infinity */
+		mlim1 = PTRDIFF_MAX;
+		mlim2 = PTRDIFF_MAX;
+	} else {
+		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
+		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
+	}
+
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
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

