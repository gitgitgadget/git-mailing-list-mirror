Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0042668B
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500501; cv=none; b=gPJZBqPt8rgPap2I49IQiSZkPPnwUo4WA/wFL0sK5Y26RsrVD4r0OMXLmlmAdkAHJ/MUoCvB0ORYCRFwWdnmKp3tvh7HxJF9zIOtzLanOoxXSWfX8gC27dapvizmw+v0zrwITjSGTNJk1R0wqPJxTYLwQAlpgNNpb8lExgRslpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500501; c=relaxed/simple;
	bh=Y0cyDhxL8l2KKDiWsH76aKyoj7SjddV5KFro/r4n4M4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qc0cD3KoZEFrZVPa5oBgLocChlE0jruLBLguaq4M2HtnNgxwEJ9hXx8Tqva2oWyoL5lLm629RnsYM1sJjNGnYBCZZC5ZZVLdUdNxfL19r8VxBU4tKO5IKZHm7LAG30EhIhWjJQw+fCbXj8YCXV3SecTR0TBvZ5TfmcnvJpiqcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af6KAMCV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af6KAMCV"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a5db525cso2127216d6.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500498; x=1778105298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=Af6KAMCV1HQOh3KvSSCRBo2ObDMHJOrapYGCY8bFRnYJSboAMp4AJA7eolrg+l0tNy
         OBRNxBLgB13Dk+808/Ls+vFM0Md4Buw73Vnq6ZYfzKn0jAAcVBxBu9iqQQj3lp8xRTkA
         JN5aLtEIbkIX8wJ0tVCyxaOLE4DCpeHz1Cp9g4HmVVP0oFGKWHvKbbkzWxopLVkiKHES
         1oKGm2RFZHqJr30auXaMPIOivLWR/S5Jn0Dc3RfKy5ubrDEkGxgfHPjxpQnVcd0TxyvI
         5SBRTlOWDnwPJ25OL3VLBXs/M82xDyjTLTVDOhw6f/dPPzPXVFbREcM8ivX3zTo7yYCL
         Fc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500498; x=1778105298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=UCwAKN3hDvitntNae+OX2AXwtmG5ee2FfWXcWEriSwDQ/6daxCSKoID9kZH4mm/YEc
         uMjiOQ+Mlt3DXdMH7ACrNt7XWBobrMFLGN5e/g5waxV+6bw8pY6rmneyxxNkr/BuTWIj
         YGhi/LPhqpboeo6XGUF9BZwYcQQOH1ERiqLd8HZ7Ne4bhIWcoQWKJlz50Ru/JwPgEvEN
         cu0uYNujnMSH+LvQUs/Z/O4V6OTVmDy2mrUIxNsUl7i+z7qk37PxUzKoBQuuHVq0yJM1
         y9s6X7dDM49ZP+F1bBiDXiDroGP37bNHiBBKuxvLz/fUOdqGwaswPBCMscbpDFXZHlVA
         KRig==
X-Gm-Message-State: AOJu0Yy7zq5tm4aowGLTzRTLCezNvY9zr1TNfC82MoDspqHqF4btjZTd
	vGqNg5wbZuXCVuETzdAeENzRxVdeIS5uNmnevzuzRxdYRb0Bvgm+mKEuEO/D1A==
X-Gm-Gg: AeBDietCEJNWsYPshdypVQ47bUog1Ww/KVc4fGght9SfcsBElf113EMDuV4C+1Oh2+/
	Dc9mq9zpls79otrQtyEXUzCdl4oCEwWU8H5mUq74Ihie+lxyptsQrFds4NpALkKdaHEzyMRTey3
	oQ8otXd8Ll9D0ASfiMain86UDCpfWHUic+Gvl7Y2CVzyREhgghuXoBLmsbjhCTHrPsJUYZS8dpa
	M3PQn+n1sc0lrAo4sUCWlHeGW5srjnUVpO8sUDdgHxZ8vrFkoMM5bhetSsSNxCz81Vjxf0S2Avy
	NnLimMF727PoSLvf5CGZ2633Et3qau4ueYQGfiLdjzpW4HxaKSOV7K/Jn1EnQom6VrhJ9ogEZMF
	urpWorKe6CzK65jLWpCZ6uFyQ/0YxoO7JkgU7gZFcPT88x1+TuxfSl6N3QCDrZwvUPhkV2u12U2
	Aat3EeozXUBsGX749VbLeF40u3oXHIi9tjctkW+zk=
X-Received: by 2002:a05:6214:459e:b0:8a4:db54:b3a4 with SMTP id 6a1803df08f44-8b3fe6e6661mr5063076d6.7.1777500498376;
        Wed, 29 Apr 2026 15:08:18 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff43aa8asm977096d6.30.2026.04.29.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:17 -0700 (PDT)
Message-Id: <b31924a94966686883079feff5dcbff071bc57e1.1777500495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:10 +0000
Subject: [PATCH v6 1/6] xdiff/xdl_cleanup_records: delete local recs pointer
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

Simplify the first 2 for loops by directly indexing the xdfile.recs.
recs is unused in the last 2 for loops, remove it. Best viewed with
--color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index cd4fc405eb..d6e1901d2d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -269,7 +269,6 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, mlim;
-	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -293,16 +292,18 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
+		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
 	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -312,8 +313,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * false, or become true.
 	 */
 	xdf1->nreff = 0;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
-	     i <= xdf1->dend; i++, recs++) {
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->reference_index[xdf1->nreff++] = i;
@@ -324,8 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	}
 
 	xdf2->nreff = 0;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
-	     i <= xdf2->dend; i++, recs++) {
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-- 
gitgitgadget

