Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DA35AC31
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639444; cv=none; b=MeDFHcAbCDztqVYxJVbZq1EtQleDb1oPctEPJKtZzqGuFFNiYOx8ORWsdboZ2qxSGuar8E0u86RKFL96D0RuQI4f3PhV+vfrFRsypU+/W7QfiDxa6TLpeGzbvBVK9fNKa/PaQn4BCYaglZYE2fTE32txLkW7Mgl5EnsCmrHpYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639444; c=relaxed/simple;
	bh=k4uLdyHZqKaAeeWp3WO3RGZzr8jTPVOUsGjgmSPF6pA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n+eFyO0nx6FdlLR2XPmv0W7zmzzAe3S0ydqxSl8/4k7+p0r9eC+xdPOszwkQYqgdaKANhsEVafPApiz0Tzv2UJ0jJ0lZbAxAU9QehEYZSZ8mW10BKoS/smjMGg03jtAfvLvVdumpjSZce3HEnijARuw6TMK1dNTguux5Uw+M1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rB0z6/R9; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB0z6/R9"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c18af885c0so1196697eec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639442; x=1775244242; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtxzNIUeE66AU+UdJD+kcbXokCBdIABaUL0ow9yXbQM=;
        b=rB0z6/R9mwzR6G6984IM/DxewjkWpyw2c8X48dY8x62ZReU836/w8ei4gAX6nYe1Um
         BTfzF23s/FxCGpdOeu++xHTf0VrBniTrIDMmfMWPf58npg+s99wwMsBp4N9pTfmbYFKv
         aVljCjybTCyyR39892oIrssGvDHZoS8s83Hh2agszc9KPS0Q/N/jZx+AbsluK5SCwK97
         gcv988nppThZUhkfLrQ21miCNvzKqeKaEyAT8rUpD1gwhrMgCJY4F8WNYTQUnIcGJksC
         lXabYPnqLbGk1vPDDQTHlcvx+tcgzHJTgt2ZEwsN9CqbLlpUFHXzyvEt+TO6SYLQrxh/
         O8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639442; x=1775244242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtxzNIUeE66AU+UdJD+kcbXokCBdIABaUL0ow9yXbQM=;
        b=deblX9vxlZIQH+/W59BM5XrB/g9Ou51YjzJNY/QvUsAjz/dYQahW4rxHSNrQfrKrlR
         U9XXRYRp/0icZGRAqG3CI0eIP3inR/skWSvXMLYHFpOTM4t2oWmmBZ3tuCCqCoMn1aJC
         OGtItfDKNRkgq/8OiQ+DU01m5TqSQVe9s7yLaB8kVYfyOnrkFPrzAXyI5jWwhGEsNVrK
         VT5YxV+tVsWNfCWdUm7okq4C2j5xK5ButRoxkKqTjMfX1sVItZrOMG+D5KCWvVocPDFf
         MF9oeC7+REnKGXLizIBq/Y4sJMycYDvtATe2uYBIie1iBBCwxCMQAUN1adGp1+RO/Pds
         ETTA==
X-Gm-Message-State: AOJu0Yy1WWndVQwR0100jFWTLMUi7vkbudrWsT9UDHw7BH99M0HOFlWT
	iE6MqFkb1lSEmkJQjqTsqQ1KYNd7YKyktgVVb6qOyRoNuvtGJ3j5pZOWhI5AUQ==
X-Gm-Gg: ATEYQzz+6zhtDjGeOfuysa0wmXb4/QIZ+3GzNYr220oVYv/FTGIfB7ii9tebCincWpg
	beBNLB0G4bAg7mNUk9rrvyQ1yxd2TV860tFwYXm++lrLNV/a6iy6s3tH62cJtLbm995EfzevQjx
	dpFfl1V5LRlKHcv3gr6qWURHdUUbzApYEpGz1q/Mvt/KWx0LOT5KrigY1s6bA1igNHZhi3u7SEf
	TmETDDCk14fJ2iZUbjcbdxe2m9EG1CEHQkfsiSY37f2pOVHU/6I10crAcwkrMxr/G9Q1D6GxlYZ
	ruMKHn5g7Ivkyh6Z3wKmfNmDGAh36VY0xEIDcRU3F+DO+fNJIx0CvWR4guujcYbNh6cx/fxTipp
	pspJ1EWuEhsJChPuEc6Xetu9zeMBcy5S7sZ9CpH3pn224om2SO3HZnww9yv38mEUch05OauNM1m
	0BPEYDGmB+3kQIoYf3xLsb08CCUDA=
X-Received: by 2002:a05:7300:5b89:b0:2c1:5b21:ddd6 with SMTP id 5a478bee46e88-2c185e55550mr2119917eec.17.1774639442325;
        Fri, 27 Mar 2026 12:24:02 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c49a5b0fsm223103eec.11.2026.03.27.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:01 -0700 (PDT)
Message-Id: <86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:51 +0000
Subject: [PATCH v3 4/6] xdiff/xdl_cleanup_records: make limits more clear
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
 xdiff/xprepare.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 386668a92d..2cf1f8d1a8 100644
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

