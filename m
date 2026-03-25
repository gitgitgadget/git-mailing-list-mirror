Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863C3126C4
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473071; cv=none; b=FYPgN3Dz+AwD7REDHulhWVcf2+oUcMOb9uxcbfTMxtP6fyzobeF7jYcyIs0h4+zUIt7am+p1DTg989t4oiR2bPiAW74MV5oS29LCWWJGf7ydruM9KVqfGL/fzgyUrx5q+Hvce8SzMKMoq68n15M+XrgYf9Ny3M23ctMUM8ar8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473071; c=relaxed/simple;
	bh=Y0cyDhxL8l2KKDiWsH76aKyoj7SjddV5KFro/r4n4M4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C+8E92DCuKHeImRTEKAVbQgkqGmpGsCtWosKL0aDJdtyrnGE3mc+0R9bkWTDief0A1IhgDQZGNktiMhha7zVE9PTXakLrDEEFVQJOmCBMBnaFutW0IMGOOzTZ4ZkVs3X/LBRc5DL2gaS/eHCl86LV7gH2C6+Glv+9AdrzsijvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeOZth0h; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeOZth0h"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-46708149af2so159682b6e.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473069; x=1775077869; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=FeOZth0hXOt1PyPO6fZvmsNEvknH5qLy93A928z/x8zHHfjxUSxJt/jIFG7JilJfgL
         6pOm8Fr4LnexiaWqNggKLE43bse/QKAlxqHNe8Yl3CJHoGJIch++AGK8vSO40hmYVQzC
         D6wV/7HfZFDsK2JYrGhVLHkbmfyJFUevlbgPJJg172p7ESlvYA9im7Bsx41VJwpegiUu
         JhQZFdq1Fi1PV+YfSwAeYPkuXp132pUpw/78v+rYykFU/4cXKMx938sOYZSoM1xNl4A0
         JcmOENCIjbzf8EvqDb5cDu4Wy+UkmCMHa2E94NiS0LVy67u3tFfLdcwXIpFq6zse/o93
         ASKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473069; x=1775077869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=SiHppvv61dBuF+rFHtP3WjUVJOpUO4JQB+eGKtzy2bHS5SD51tPgsgzZa1TeDlxCMn
         x0FF0JxuPqjCLgQL9rMe5lWV+qV6S1R6fdnjQIGTUUhfkpq93PVqHLSbRBGpjE0TxiFo
         Pl6TCnfmynjHSkdFoY0qzMuas3RGmfu4K/UWXo8lXcFZZZ4BoKBGVrIEkmmesqPhQj3/
         G+Pe5mQo2BjLm/DkMewxQDJkfuCLiGmIiHjgLlLNNg/7ywEyJRAoDs/IQB1oq3v2nb0l
         L6Sb8s7Urc9zgdoR9mA/UE8mRs35oUaFDmSd1EgX4bw/AQngTIH9My7QyxecJh48bfAL
         +sgQ==
X-Gm-Message-State: AOJu0YwbSNkkJsVh4huW6V8EyfZCggNzhXfZ0qdRNtzEdeCwy4BCh2g0
	sB2i4ZfMG83zSj23THLLmgRpXCNKKFLWLiw3Q+awspS3Ildpt4FvyoGK3ASVZQ==
X-Gm-Gg: ATEYQzyn0yCRaX3t7V8pfpAZYy84tmlobjjUDMCJq0lxA6aqf+1vOyC7HyHpK0hdzjL
	L6R7rI/SupjyR8ZzcijthbB73Z6+pG59Xz2QHsQYTTCbnkwNp3EnggiTDG4B4E75kQ+gktWf00E
	o7yhsQQ+7jR5e+n5hhz5AVFrUF5zoVAGWxZwfPAbyR+W1GGRP1UxH1w/7XORw+n5f+INaLAHeCW
	TOXg7F4hthKMabQUr1XUyZXhe0yasM8w5cQtZjEUmPhSnPcuPyjY+4s4qiCAXmrKZVGXdhRRLL9
	56IYXfbIomiI6FM2LcXlabNK+Rfdjk46k7XAXpuKfXrCnXdNMDXfaVuqRYRPKMALnnB1bxgYiS/
	LQz13L6ckkMu/q7cToy642or/6fqeCpifyE77Dc8RN2y5/tYlPmF47ZIVw0JzBM0a9prXa+P3Kh
	27sKbIFKjyr9goyKMQ1unJCsiDJrrOsHFmG+/V
X-Received: by 2002:a05:6808:f8a:b0:464:3d5d:d9d4 with SMTP id 5614622812f47-46a5c74de18mr2292467b6e.39.1774473068734;
        Wed, 25 Mar 2026 14:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a7094243csm424129b6e.12.2026.03.25.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:08 -0700 (PDT)
Message-Id: <8f9165d477ca1dcd2c1915623740a53093b1c258.1774473065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 21:11:01 +0000
Subject: [PATCH v2 1/5] xdiff/xdl_cleanup_records: delete local recs pointer
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

