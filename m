Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD4332907
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473072; cv=none; b=iBU1EthCe5xoCYmuY387NTFVQNEhKArk1MrCKI8vnFyQzHYaRvl8+6v6QT2FM4XDbJu/v/xDv2uWMsGX9SAMDdT7XMQo9MLkkzGS6rqHr2DLb+jjQ4mwWR6+o4iuu+XUg4gzY8dSliqnYsWnURqHpodB8cgAsxX4ragUcZmEQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473072; c=relaxed/simple;
	bh=OJr+qNv2N/s+Ji9GYDWJn1LBljAze1aUpLAzC3B2mgM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YfZDwvdfgb0hbM6YtjbAw4/ez/o85q4scT2FDQlkPpxFmev4RHQdizi+IhXqGrq2nK0T0mJzy9KxQnn74o85BMe1PiQ6aqbtwvenAjyNXq4gD2zHFIgu6reXiPSHMne/IZ0Mu0jqo28ykUZIBuh7C9/ACe9i3EIoug73tPlqbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIWXo9V2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIWXo9V2"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4670464029eso144775b6e.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473070; x=1775077870; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEymzSHXhf84OkNcxVo+YDkT3gLePFwlnDuMU4NsRGM=;
        b=nIWXo9V2rO2u0clZ58LloWuNWD146oEgXeKEjmZkme3swBlSSDb7fYda0kH2fpE89H
         lV0AubB43eTr17S1UR+ilaCwXwJH83BhdzahC64KsPBrDjyhAh3BCWHfEqg8oxWJeChr
         0t142scFAs4bpl8c+oQva72+uEKDbDNESxI+nQ/NaDYjGB7z5FZa+WhF2J+5qxn4/HUp
         1Wvf6kGDFnl+hX7Hjto3CFxNO/+q2CLNZbfsbTFqhMyTuy4nxcdwioc1x8JwAd5akli/
         R0IbNTfkQurWOhOpyMJgrN9SnZBRCKPgK3CsOE5mb8mAlSRE140Eccs/T5zlNEf+LbMl
         14eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473070; x=1775077870;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEymzSHXhf84OkNcxVo+YDkT3gLePFwlnDuMU4NsRGM=;
        b=tLVhOiywhEuj0jb3d+5kKiuFaDaLOotYZnN8NQnDriQCeNlEWf5oHYuVnDB8BJffb2
         +p11KbQiWElBoQ8M/xqqKlBMbOCnw12Zvs4FgpT7nKm9NmEwXun+JxtuQG2iCta4E9tn
         qvE0sgDYxDa6Bp65ZJBHs3riwoYpbDpOUfqk+lstl2SRc3k9jDmCnNjJ0yLjqBnhiBqb
         3d6nZj2dIMz7RuvQeGvvSx13oWXOiw9dSH+XLMca99mZIcAdQNx5DAJNnocD7/+fbsDQ
         OGvksi3dBsbkTUHxnCsiYBdkDiHIP0LLYgZEOO9SQY0kO43FQNHvVKenS/wO1IINU/uK
         UvcA==
X-Gm-Message-State: AOJu0Yx10mMeRZKTA9aGvom55QJZ80B+7GloyaoTtk7kaHgA6hHu5Zzk
	nGOzbPSaSgZARA9yK8w2Pl7rB7fyK4ehU7D47u3SKPTHQDRv30cQ9mo9aW1ojw==
X-Gm-Gg: ATEYQzzt5dHBiOeRFFmn+3Fr3EhuWGVb+ccjQyrWN0j1uQb+t1UgPFSfromz6PwEHHT
	GX/Aiou4BctV/u71MEsYfBDSQMoxixRSx8AxXpZuWMhmwjxtKeb/WcpnhlEA14K9btqjoXXZ5Dr
	l3QU+7ap8dQX5Kz9+2ERwaL/wJIqd2C5zgjmo/+rPMOx6VCJ04DzPAMJjWYtD5/ghnk+iUhIFG2
	v/IhHU1zcubFFtGwT0rGYm/+MEzEUTJhkmW8UFdTfnVrZlJepm3VnTV9pceUg4AId8v/zke7VJK
	fVe6fi32mxjBQF7qftcDjltOiOweysl+45+QQ0GRq56GDdFuX+kvqshp5WKvDeoO/PN4rU2QusL
	/ZbBXvIKPH5l39n1WEnB0siaNv1W823DmRFkpKdOTu9otkok56b4lpOSGaJQxGs205iXKyF8TEf
	cppqQWmNyTJMg5+xG3Ii5/U+ovXw==
X-Received: by 2002:a54:4383:0:b0:467:4939:967f with SMTP id 5614622812f47-46a5c796784mr1874585b6e.48.1774473069933;
        Wed, 25 Mar 2026 14:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.176])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc7ad3444sm586445fac.12.2026.03.25.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:09 -0700 (PDT)
Message-Id: <62adaa8e5a5aed585a4b4214c34ece74757d54c7.1774473065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 21:11:02 +0000
Subject: [PATCH v2 2/5] xdiff/xdl_cleanup_records: make limits more clear
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
 xdiff/xprepare.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d6e1901d2d..756a5b8dcc 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -268,7 +268,8 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, mlim;
+	long i, nm;
+	size_t mlim1, mlim2;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -287,25 +288,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		goto cleanup;
 	}
 
+	if (need_min) {
+		/* i.e. infinity */
+		mlim1 = SIZE_MAX;
+		mlim2 = SIZE_MAX;
+	} else {
+		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
+		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
+	}
+
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
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

