Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675E318142
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295002; cv=none; b=M7/7ygwzu3ZZJYFNoXwrbISpvykgM4WXlDSBNr8YY0yIwrbnvjawgQvKs+xER9Sj2hapJLYm57hXKQK6nmpplIny7197HBhmLB5Nuc56mBaNi3leollG5Ibd1pWLexJjEIsS9rrR3kdIo7KSW9ki9jow7zWuNcoBvO9CBUBgHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295002; c=relaxed/simple;
	bh=WLIUa6ZrYvogYXTs4lcE9b+y7U2JWpT8EveqGDW3nXU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MOf0OCDWTik3bORtPl5jmIPJ5sF16iECLbf+TiAewMHEGuI90LEYphL0kq/ORex1Wu/ILz3Gn5tyONthya5Ch2RbMQuNsajh23WZHZiQRZCiMxMFQQmt22ui+uwnYTfXBGj/4B6ANTwM1kf46GUDKEHxWdy0AHUUlOEWiyJm5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XESAxnJm; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XESAxnJm"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4248746aabfso2752755ab.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758294999; x=1758899799; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnK1oxFLkKPc1cBSOhMfGPiE+2d1++QlFr7byHIsQts=;
        b=XESAxnJmmRFKjGycVDY6DsuG+dEI7zvl9+/sA3TWNT4KUExTnUwbR+GPtDhgYVB+nT
         BmOfFgrql0cm5CEbzghIP+LlHutcrflkdSbMGiGXJyTsWnhmHpmpZ0PIoj2mCe9CRllS
         PnW6RbJx0gvb0OMBJ/tlaPNITUJREPiz304jbbK+67WZkUN48grJKfUoi5pH+FsRcCOe
         kqDfdbJq5tbvkydu/F7dszvey8RVpK8xUwV7pOH729oG+wqCEC/t4YN42oKUdA9ZM/Uz
         uO/wwFgSrSp4llpLnEPdoIrdh0SfEx9C4Mwc6HLUvxyBPYB5EmPXIDvmFiDdpXWkFXgB
         MSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294999; x=1758899799;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnK1oxFLkKPc1cBSOhMfGPiE+2d1++QlFr7byHIsQts=;
        b=JdgkRXW3XHZqorrcBtvRbk0EDHRF6cRgKhTSsUQeaypVZ2lYRih2Fsv7JzCprulXnr
         bT5HRAMpQP/pIVzg58vqDzS1YigulI0nutyvyGBff9Yf+PmHdkyugCDfiOY3IJrxK1Vc
         UQvoKJR0joqh6WDmpPX4UjB/pzsKITvyhrrXcUCAzAYTkO/oOp3tLqVkZ9scCaY4vCAX
         x3Wa6ba4lhxNCSaeh08FwPcwtEu1ZoVi2bM55eq1hBoj6s/yGI1GFygmIx2O035948qm
         aooCZWTcBYck4Rn3akzEI1fWtoWXkc0KAOhv8rGGdXF3k5WyWz6VcgsTrIFRQFeT1gG/
         YGMA==
X-Gm-Message-State: AOJu0Yw6rY+vuzl9Mv8bqYrfd/9uCRifZ6/3f4BV09MRXxIa1bqDVVQg
	CE0LX5CEI8p8sCGZYuQIDJtI/r4NfjKjxgQFWJcaJhtDxjev8LKvCUVv9FmUsd7v
X-Gm-Gg: ASbGncuZAsP5tCXpAdu4HnudPhmFLmHxZIWCKE11qqoYBQJzsadES2yx7Hu9lvV3syL
	dnFjDU1fxy/m8geIBnTPUbnY/6x1UWu9gZmTFSicsqC4XBDuJKFVf0HJjHuvfvFUSnv3MPuKLjA
	R2QYi/ecSRlWuOmrDaNXK6S2v9awujRG01zUgFAsoXFUGjhipDjF3JfSq/Dl0w0sSwh6gp5lU5X
	zyg7uBHnkxwlTvmbIMkrFP2iixokMKgrHZ5JS0LKToh3Z0UQ/mmVH3MY+UWTM0efjJ8Z8AcEdDA
	fjZOiEntKIJvsOw7VdBe0b7biOj797vL4a5G9dRcy3Knm6uyITG/ttRcJAuDYNYYfHIuBe5tfnf
	DL1qmMHUlBQ6Id3D/78eAd/YnXw==
X-Google-Smtp-Source: AGHT+IGs47ok0hMHGUTvVsIPgrRbX0RH7Pz8TyBG+K86NPDmDRQBNZFBod7wkZdI97w9OrB/xKdntw==
X-Received: by 2002:a05:6e02:1487:b0:424:5da4:b9c2 with SMTP id e9e14a558f8ab-424819893c6mr49359835ab.24.1758294999392;
        Fri, 19 Sep 2025 08:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244b29c75asm22940875ab.35.2025.09.19.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:38 -0700 (PDT)
Message-Id: <2e8de5be03f7166059d735a99573520e35ff9a31.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:25 +0000
Subject: [PATCH v3 03/10] xdiff: delete unnecessary fields from xrecord_t and
 xdfile_t
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

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 15 ++-------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index fe02fd7925..7acca1cb38 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
@@ -126,17 +125,12 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static void xdl_free_ctx(xdfile_t *xdf)
 {
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
@@ -155,7 +149,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
-	xdf->rhash = NULL;
 	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -163,10 +156,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	xdf->hbits = xdl_hashbits((unsigned int) narec);
-	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
-		goto abort;
-
 	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -180,7 +169,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			xdf->recs[xdf->nrec++] = crec;
-			if (xdl_classify_record(pass, cf, xdf->rhash, xdf->hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436e..8b8467360e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,6 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	struct s_xrecord *next;
 	char const *ptr;
 	long size;
 	unsigned long ha;
@@ -48,8 +47,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	chastore_t rcha;
 	long nrec;
-	unsigned int hbits;
-	xrecord_t **rhash;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget

