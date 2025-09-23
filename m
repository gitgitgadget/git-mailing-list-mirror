Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4730F930
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662687; cv=none; b=l2KgORqKzw3F3dGkIhO2rZ0KwSjhFAV2JKSovbAFUIaVeDPj+i0M2Hqx4Nz1hVFsnCDg8DYkPNvLArRmAY5Py/r/2mVP8xyfNOaBYurVuGLY+gGYFf0IbhZJ/8yxRkzy3Koi1y94aKLChjEVIAsDYqhYHqCw4O6o81l7US13Ap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662687; c=relaxed/simple;
	bh=dSoSDFjP1yoh4ARvQxehL/Cx+cSqROXi9gm4WGq5CFo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GBl0gEAlfbFrMUVihlrzCR30Ysfjgc/hESLqn9Lx95h6ezGOBCjhXJ+9H3U0tKQGlj83SEC38TDeZQ8ngoG2wQ3UIi0QOIrxHgJHRAqYl6b/2aO2tkbZ7WSWO6nNgoTmkrIiuI+6GNf5W/EDAs7zRE9vQcSV/AYriDKawdSTR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlK8JSAz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlK8JSAz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77e87003967so2408465b3a.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662685; x=1759267485; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m86ynlxOihQxCNGqHvdWkwGvoEOQ/pZFact7JnS0EAg=;
        b=ZlK8JSAz+QL9PAoV//CW8ElB5WQePyZZKXl1HBX7wwe6EuEP9zQg2yaYVlRVErZVHZ
         b8gupgae2gWItWGSPRFTki/PwIEcPoc4/Jnp2Wd09ITV7e8UjF5l/BgOdaQ+KdP00TwF
         8tRwzHJvDEGeihU81jgqpNgQ81sy3t3yakabZx7pb8WjCGCEWY/1q80x+rZUktGRZrxM
         08LlhdhD1+3orvl+O+MJcnry6pb4Ql96zl2Axm0Lqc9hVeSS0lsed1Ro6FC0fvGwvrKu
         5U4tc1bcEz4UjWE4E/8hXiOPljlk8cN6wJRss1+xh9droC1SLTl3mwkHem3J3Wu8LNIg
         4HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662685; x=1759267485;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m86ynlxOihQxCNGqHvdWkwGvoEOQ/pZFact7JnS0EAg=;
        b=ji4VQRVdF0bEK7kPZgQqTtnOg7Qlr/lWN/z6Rc4BE4NU8YpG35p6PUSKzN6QOUhXF7
         J4vXIfXkomIaSPU+vCJwj7iPGQS4TZaOkpFaFLIVrRQVcoRC4LuD73NFbBapEWeIx0Yf
         W3528Pjv/IrR7Rp9lTDBzI7kM0OYTUwEfiPw7b3g9bS+AOnn/UOugJuDwV0PlIRfC0+u
         UznKbzJ6kReJdKueFI95yna4tTX2S1U0mXMayGmhB0ZIXL+4tcQ+7am1hCVSs0XWOrW1
         w8zc8Kzhc9s9OAkjU7AyEfaHhZgC+hroQ2R00mDLLd4VikViyxxylY0Okyk9AmSlIt5d
         OYRA==
X-Gm-Message-State: AOJu0YwdY2Noja+4YaE/0Pm7P/2+YErKGbCJgEduKAKSSMp9xoKho1PE
	MwUxwqWTEiDn1Qh22nmjF2DV+L17YmggCrRLnkclfQNeJxA2dzoPk/LV3QF/AQsH
X-Gm-Gg: ASbGncvdV8N0ssTufwD5EmhEOus3RLDR0Bg9XbPOKwIvLYlgMHlt042C9FBRang1Jp/
	t36FQZc8LFkCyyl3tUvMMou/+oZhaLAFIIzYYyGq3U+h9lWSXvS0vapQFnug3KqX+SxS8y/Ze1h
	0awndDvaDTgHVyO9/9KjANxFfXX67H0hKDAMbEQLzABNxAYCG6K8vOogdW+OSAgWuVpcUp/IY7V
	3W66FDTDffUFFRLM27/zCzIpJ4IjzuBDfP9ZmbAxT9jS8MGBUxElqle/h4vAurCq7HA99tLNbxh
	0W9DSw5WE8C+ps5C3vm4M4NP5gB/zERhY66BvR7rCo0EfmPHYeIiebgpJ0p9sNrsCWAIZ0vcrq5
	0sCLGA4jXRva1w4ezrtPibcXnkw==
X-Google-Smtp-Source: AGHT+IGt3BoMqfA2tqErI/UBBSsR812zThJa3ifdmX8TzXG4meyJfJGh9gPO3H7hG+1mOw55wpMFmw==
X-Received: by 2002:a05:6a20:2447:b0:24e:2cee:9598 with SMTP id adf61e73a8af0-2cfd9eba1fbmr6082325637.13.1758662684775;
        Tue, 23 Sep 2025 14:24:44 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f43773f99sm5504529b3a.45.2025.09.23.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:44 -0700 (PDT)
Message-Id: <21bf4b5a20273e2639826cdf014b8f6da98c044a.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:25 +0000
Subject: [PATCH v5 08/13] xdiff: delete fields ha, line, size in xdlclass_t in
 favor of an xrecord_t
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

The fields from xdlclass_t are aliases of xrecord_t:
xdlclass_t.line -> xrecord_t.ptr
xdlclass_t.size -> xrecord_t.size
xdlclass_t.ha   -> xrecord_t.ha

xdlclass_t carries a copy of the data in xrecord_t, but instead of
embedding xrecord_t it duplicates the individual fields. A future
commit will change the types used in xrecord_t so embed it in
xdlclass_t first, so we don't have to remember to change the types
here as well.

Best-viewed-with: --color-words
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 22c44f0683..e6e2c0e1c0 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,9 +32,7 @@
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
-	char const *line;
-	long size;
+	xrecord_t rec;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -93,14 +91,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
-	char const *line;
 	xdlclass_t *rcrec;
 
-	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->ha == rec->ha &&
-				xdl_recmatch(rcrec->line, rcrec->size,
+		if (rcrec->rec.ha == rec->ha &&
+				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
 					rec->ptr, rec->size, cf->flags))
 			break;
 
@@ -113,9 +109,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
-		rcrec->line = line;
-		rcrec->size = rec->size;
-		rcrec->ha = rec->ha;
+		rcrec->rec = *rec;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
-- 
gitgitgadget

