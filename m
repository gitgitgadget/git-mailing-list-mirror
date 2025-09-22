Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAB31B11A
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570719; cv=none; b=CavqH6wHRhH90uIUQifsxqDcm7dWSNoyuNXW9P7stPc7c88zip5bYefhlYBw/mmkGNP3BKchhPZZ57ZIKq+3+kjfEZdGjfWKKIF1AmHUCJeITg9Wv8I+iajL/gHfWZ27qWSj/OAmNTtDS3vaV4mSqpUm3gvo+ikbSLVouXDHXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570719; c=relaxed/simple;
	bh=dSoSDFjP1yoh4ARvQxehL/Cx+cSqROXi9gm4WGq5CFo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iK/DpDBGyCnf13PR0t37NjwpLKjOjjYBmPappcMHG+8lPCiqQcvCFkFIbEgi48GOCYgQLNagtrfowWM/jhX4P1c/NG7F3yGPRHtpLryPdNiimxYAiDVEt1mst2YfOGu2VkhyNSjgzx0ozAPk0n41ltz4D7Vc8/A+2XD0+UhJdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdFTKGf2; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdFTKGf2"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-424d3c1256fso16133455ab.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570717; x=1759175517; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m86ynlxOihQxCNGqHvdWkwGvoEOQ/pZFact7JnS0EAg=;
        b=SdFTKGf2nVMg9e0Q3VoKqAM1a/JQH3jlPfIZPi8EoDyBX5aajvylJ4q0hAnmo+N1yg
         W0ZioFr1NF8P81/Q4K0rEwRrAynPn2n4U+gbQL70j/NxrLO/lMLgZquSQ8497v0xxg5V
         zMDJsNz5o2Kh2nXlqY/DLULvJhh8mMnoVuZ7z54KMgbgEaFQdH1wZlaTBM6eX1GpF2pF
         A5j6wPOJG1paCTlRO9CqeeWanX9A/rxRd97P9iBSs0Eex92Wrg6Uylb4h/6OgGm3qad7
         A5aC0YgMdxr5DzQqpJ6nrsA29mbkM4uFGTFdcjdMLyyApvCPSKxjK6kWxJpGQmX8D6gy
         adnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570717; x=1759175517;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m86ynlxOihQxCNGqHvdWkwGvoEOQ/pZFact7JnS0EAg=;
        b=ZzY0dgGntUX6MlM10h/YT0mDHgR8SXfJJbzHWFgx75vNxGZbg0O3kklMgPMn9DCQcs
         uKAM87pu5wvTGw0MA5qC8nMBj74xjunMGDoTPUBN+H4UZk3HsXSqrV+G6JYe/LM4hH9Q
         8qWtSzF4PV6oyo96CZUzhF3a6TW4rkJVDzbG+3wwApp+4gnIh+DkLSIa+w8UyeJO73Gp
         OQWBef+63AE67ZHlyBViUpgKEhhvdWJ0gHoNMLw8zLcZW0OBuUoDIItlUL4qIt+46xGc
         5Ul0R6kms5huq5DkbKAfzCfxaIZyBVY+bjxfJaWyg4rbZunN0vJAS/ts+eaPhDhlSikY
         erkQ==
X-Gm-Message-State: AOJu0YzoKqEHXwA4oRZ4c8EoREB8v4z0IFwlJkTrakmJ6+X9Zqlr7qmx
	pgu0D82TiJ01SCq3u3aigTXKaEltCEDioIf0MoTdIhK8INRBj6QX+Mk8f5bxqw==
X-Gm-Gg: ASbGncsGEi5I1TAqInXCdL9C7eClTBjSyDqxq2/97cjnIXYVE4NqWMVLLk8qL4rRf1x
	1DV6mclQqTlC4p9KrYdbhFXDHzhLemFUPMwAgliCSclacq+bZAfSXQsp2tp1BeHVCnNX/ab5j/Y
	8TzAnq6iIFhat0kQnU3uCksZ9sX4WBhWXCkQ9ekYWm4ltth+EgnCd9EsonZoaMHnxGpxdK/kCjs
	bZZVr18Jl337KIBsiwoMsPG+72GVs6cTOOdGLRSukBmCqX69LY/vWqkaPg3YA6y+uaQvc3Ela9Y
	ulWazoNiPUadl9wB/IcxRex8j1V5uGitDi6o3sWgicgRoYJ0yeBUzRDpwQm6Awy5buobhzdws9R
	gwTZl5X1Y9hIjf3c2Bh/pcDSE/g==
X-Google-Smtp-Source: AGHT+IH927KUwJa94joLcyvwsoQk8UWip454KDFtQGNoRDlshRBXebneF3Y2HAUKcUFjcCZ8p0LqsQ==
X-Received: by 2002:a05:6e02:ef4:b0:423:4ff6:aad3 with SMTP id e9e14a558f8ab-424416da9fdmr219512015ab.7.1758570716667;
        Mon, 22 Sep 2025 12:51:56 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3a590fcfsm5937994173.11.2025.09.22.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:56 -0700 (PDT)
Message-Id: <3b6c2127c47f583d3c3b16e961043211349edf3c.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:37 +0000
Subject: [PATCH v4 08/12] xdiff: delete fields ha, line, size in xdlclass_t in
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

