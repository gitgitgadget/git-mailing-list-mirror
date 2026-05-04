Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA23AA4F8
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903600; cv=none; b=s7CJmQgtzjdoTxwD/P3Ji5v4du3sh13dSeF45ITustC7Hb+km9GqpCYMHSGc1jZZVzk6xgnVm+0raBtHgdP7aytoYEB9Cb//jKes+E7iAkvHSEPdgjAxSv5urfxhEg1fLGRlyliklCaAT97R6GUdqDsJcpVGJWjTItyllDVCXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903600; c=relaxed/simple;
	bh=NSIm18TuqP+InoCXKMWJeUz1rYZaCOrLAWqC7kbnPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3zXI4lJn8/VqQZ177WILo4yH76jSDRJSfAoY8zxqPPE9IDSEEcPZYrZrfOJQBgx+Eshnd9/XwJtjOAehyxM/JTEDOZi2pszP/a5VCnQ+GT3QpuOsIcI1dwfJSJFo/lv9OKOLn6O3XVC3pw4RzRO12NOeV8MtHNlRjl3vN+lATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REJtmfo5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REJtmfo5"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so67070395e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903597; x=1778508397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYWLzCuyVt7KEQTtPXaPghqn+Y6fAVVRA0BZyLxFCZI=;
        b=REJtmfo5OeNeDYdkAFN+NDEltArG+NwlmjG7A2kMjxAFPssonxiedfKlzS8CtQoCL2
         V3PSe7q1NhpEZEbkaon2Ye0M41bs4Or+LVQfZbIulnur+ZROPae12yw6wtJYJG/ZXYvU
         Lz2jYkN7iM628qewxMFtS15h+sB1yEAQf0R+gSXP6em9yWMUIP1qQY5ajz6ZQpBVp2xs
         QBEQ42YoQ/KAiGZxsrcdKHcg18Oad4BNjheroEsVsWcebMclS9tU+/qHatW2/UdNuEry
         Ccmp/niXPojdpOTAtDzVwSSgHPNPbc7Da5QyRuK1IO+1ng2/0DX0fU7k4d6vs1dTzlQR
         80UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903597; x=1778508397;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYWLzCuyVt7KEQTtPXaPghqn+Y6fAVVRA0BZyLxFCZI=;
        b=el/2JS7SJ0fi+2UO/aU5GywV0riT2j/zW1NQeWy1BrFf1VXOkulFqxWtDVoihge28u
         CTC4VRfFl3KwZDTNMMlBeKc4OrOPZPiPBNRlNubPdZuMet3suJUmCF4KkBY/lBMHp0MV
         uNzI/snMQEiV/Oc4oohM+XzVQe7Osp8luknemA9l+Q1hAN8V9Nel0jBPhg+9cZ2Au7qR
         29r5whp0C4a2rGk8WtM2ldRJswpXPMBFzQ7E9k+VCKRMjpv+yNblftR/mxgOSL1SrJPH
         eN/ALni7HOrhZD3kDyBlUJGhkjoEEE9HGkcBoiMrQVOvEqbOpXHmiq0bsEEiAYxBrVf8
         NPJw==
X-Gm-Message-State: AOJu0Yz08qAcBHQolVFpTYTLvnwW8A5AnC7a7IInF94NAw707n0anNqx
	x2ALV0jqjfBuX6qIgPorMXSn1nrNn35p0f/MKYUX9l40evM7Qzcg/mvmbOHkFg==
X-Gm-Gg: AeBDietUaxVfk5UUrOtm65zm64245IfjFBiLHJsgTT0EUdEcCh1wBvN/9rlivgaS9R7
	YdMuwVpGG5ckahgbELUCGzD9iTvU88WaR6XQkB2ONsxKK4s8k+HFvF/YjyCv4UCjudZMWe++6Q9
	CmZ8ZFVhhH+/UnC94mCYq41iBWXut7UVjSOn/WVFPB+fgu9vWUhZufPwGcv7A2VRnqNEdFdo88M
	zWNZAeOfFu9uyPU8jXGCiVxMcxJP2/5KvU7RWdQwfBXoux1x1b/KaklHGDMQGNyadh3j57hgHUU
	WX+23FOkLEvH6uBDgjUH3BHg1nURVC00Vv1cf7lW9q9C2w7BJ0foXeIw2VIyRhuZbmvNpMo/Pcs
	i6bl56ojMXXLFloY/7LMzAkd1WSq5Zf4vfJyASdEzawi9aR1qcf4lswWExY0IYFcf+NXC4aauiL
	ggkzcz01+S7mJQkxryi/UjAe7oNMgMKtU6KSW8vVE=
X-Received: by 2002:a05:600c:a30a:b0:488:b187:3c with SMTP id 5b1f17b1804b1-48a9865d905mr121214835e9.14.1777903597010;
        Mon, 04 May 2026 07:06:37 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm390520555e9.3.2026.05.04.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:06:36 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/4] xdiff: reduce size of action arrays
Date: Mon,  4 May 2026 15:06:18 +0100
Message-ID: <ec692cabfec0cb463ddc9efcbb89f43cf1f3ef02.1777903579.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1777903579.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk> <cover.1777903579.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the myers algorithm is selected the input files are pre-processed
to remove any common prefix and suffix. Then any lines that appear
only in one side of the diff are marked as changed and frequently
occurring lines are marked as changed if they are adjacent to a
changed line. This step requires a couple of temporary arrays. As as
the common prefix and suffix have already been removed, the arrays
only need to be big enough to hold the lines between them, not the
whole file. Reduce the size of the arrays and adjust the loops that
use them accordingly while taking care to keep indexing the arrays
in xdfile_t with absolute line numbers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index beef711067b..3b6bae0d158 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -273,16 +273,19 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 	int ret = 0;
+	ptrdiff_t off = xdf1->dstart;
+	ptrdiff_t len1 = xdf1->dend - off + 1;
+	ptrdiff_t len2 = xdf2->dend - off + 1;
 
 	/*
 	 * Create temporary arrays that will help us decide if
 	 * changed[i] should remain false, or become true.
 	 */
-	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
+	if (!XDL_CALLOC_ARRAY(action1, len1)) {
 		ret = -1;
 		goto cleanup;
 	}
-	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
+	if (!XDL_CALLOC_ARRAY(action2, len2)) {
 		ret = -1;
 		goto cleanup;
 	}
@@ -298,8 +301,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		if (mlim1 > XDL_MAX_EQLIMIT)
 			mlim1 = XDL_MAX_EQLIMIT;
 	}
-	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
+	for (i = 0; i < len1; i++) {
+		size_t mph1 = xdf1->recs[i + off].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
 		if (nm == 0)
@@ -318,8 +321,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		if (mlim2 > XDL_MAX_EQLIMIT)
 			mlim2 = XDL_MAX_EQLIMIT;
 	}
-	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
+	for (i = 0; i < len2; i++) {
+		size_t mph2 = xdf2->recs[i + off].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
 		if (nm == 0)
@@ -335,42 +338,42 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * false, or become true.
 	 */
 	xdf1->nreff = 0;
-	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
+	for (i = 0; i < len1; i++) {
 		uint8_t action = action1[i];
 
 		if (action == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
 				action = KEEP;
 			else
 				action = DISCARD;
 		}
 
 		if (action == KEEP) {
-			xdf1->reference_index[xdf1->nreff++] = i;
+			xdf1->reference_index[xdf1->nreff++] = i + off;
 			/* changed[i] remains false */
 		} else if (action == DISCARD) {
-			xdf1->changed[i] = true;
+			xdf1->changed[i + off] = true;
 		} else {
 			BUG("Illegal state for action");
 		}
 	}
 
 	xdf2->nreff = 0;
-	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+	for (i = 0; i < len2; i++) {
 		uint8_t action = action2[i];
 
 		if (action == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
 				action = KEEP;
 			else
 				action = DISCARD;
 		}
 
 		if (action == KEEP) {
-			xdf2->reference_index[xdf2->nreff++] = i;
+			xdf2->reference_index[xdf2->nreff++] = i + off;
 			/* changed[i] remains false */
 		} else if (action == DISCARD) {
-			xdf2->changed[i] = true;
+			xdf2->changed[i + off] = true;
 		} else {
 			BUG("Illegal state for action");
 		}
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

