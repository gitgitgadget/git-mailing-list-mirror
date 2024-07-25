Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125D198822
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900372; cv=none; b=Jb6r4AZyuolAZNENDJcuTmPr1nUN9b5TlRwTq9tHnMxB7EGlKL1dFWlxRPc1LdvtWYPjggd0bG6ORA46Gt7XkYPelknoxfPxo1x88a9RRLGbb3F/BUKEatXrDWuOauc09R2lSiC9p5j3KI858VbssFkm324qfq+F8STvSeKy1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900372; c=relaxed/simple;
	bh=hWXgMZ34iw7PGAEbfN9sMooQpaywW4W6Yp/28C6kGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgzT9x9ogQo+XYZTr3sZb51w8Q2jfr9K8KrqV+Dplyrq6CdiKR857GQ25QZ2dCzpFPwakgLt0boSJShX1bxmczkKdXk9hlIG/AF9GeQoTtFf6KKyJOct26QTVqFInWMLiRk1JCUZ3oY1n5wZv/baH7Se5ntlo+8kNNC5Tq4NR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYFblSCl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYFblSCl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc49c0aaffso5467425ad.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900370; x=1722505170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NuaX3k1wXTe8+nrMWrHgqNmNsBhzatJwf158k3A+PY=;
        b=GYFblSClC1S2IhHrlI7T57mFVpZTPbglqUkkZRC1+gra3p6P/6bTFQM9CRj3kT0IAc
         WkzWPllt9N/MrgSj2KqG8KOSMtqHRN3lTVnabD1zcmb7dNr3XKsjYotPiNbwlp/b74vY
         z/5lCTNxwxboZIS2lZGLa3sr1NjTHLQEC+gDD7TnrZcuj1HkA07BpMZwJWPhurO2Yt3E
         bJ21YFoIYypo7Vxf22F92915X5gmAPjBspg2HDkM8ZNReBMgAZ7d0hz0+LnGzsiihiwZ
         t3OvL0JPj5ms99tqkrZpOEgTgo8Tic23TU+LgXDv78bv3nWoGubD3w25nAfzbj0Gwvtv
         17pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900370; x=1722505170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NuaX3k1wXTe8+nrMWrHgqNmNsBhzatJwf158k3A+PY=;
        b=TP6RStvOxX4VwzfM+cFPzmnU5qM4StiVjr2cKXZmQ+vEVUVGyTho0N5LQvoRGS1/vg
         ybW4bXEfgN6h1r5ebaeRZ78ZyWSiwmUKkS133mqIA1M0fq6eSYSNIWH1bPuiGNSFjIXp
         R2WeF76jXUTaJpzq344SB4hSLD+fSZcdq9NsXKB3B6s+ryrxdiIqmQH09YTEq4pMJjEA
         VqbonP2VrgusclfFld579GRS7SYnzyjoh/y4HwfxAxCr/s37LCiAf2reC9o/OSxKMRL0
         6Na2ImcuYZJYOutLpzXrSJCKeQ7F5k6jmLmB5Pb0WQu8HD+HuQfUQcM37+0F3M0SZMrt
         XGXQ==
X-Gm-Message-State: AOJu0YxCP5ttmC439KeJ4iGsrraDGdbLX3JfPvOXyvk6x/JHIYrVPu6x
	yI61UWKSFKi1/61wV3fp4ebOyRnHsvShAvs8Jb5+wMvApSkwjjGbjeZZeQ==
X-Google-Smtp-Source: AGHT+IF4rzB5QDGHGIZ3FFQT2rAWeuvrBg+Frk+P4tOQNb8b4d+Mdtj+YZaD96y8OYtp4xlgslUt0g==
X-Received: by 2002:a17:902:e811:b0:1fd:8c25:415d with SMTP id d9443c01a7336-1fed9273b59mr14282005ad.36.1721900369665;
        Thu, 25 Jul 2024 02:39:29 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:29 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/7] reftable: remove unncessary curly braces in reftable/pq.c
Date: Thu, 25 Jul 2024 14:55:53 +0530
Message-ID: <20240725093855.4201-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240725093855.4201-1-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/CodingGuidelines, control-flow statements
with a single line as their body must omit curly braces. Make
reftable/pq.c conform to this guideline. Besides that, remove
unnecessary newlines and variable assignment.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 7fb45d8c60..1a180c5fa6 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -27,22 +27,16 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	pq->heap[0] = pq->heap[pq->len - 1];
 	pq->len--;
 
-	i = 0;
 	while (i < pq->len) {
 		int min = i;
 		int j = 2 * i + 1;
 		int k = 2 * i + 2;
-		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
+		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
 			min = j;
-		}
-		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
+		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
 			min = k;
-		}
-
-		if (min == i) {
+		if (min == i)
 			break;
-		}
-
 		SWAP(pq->heap[i], pq->heap[min]);
 		i = min;
 	}
@@ -60,12 +54,9 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 	i = pq->len - 1;
 	while (i > 0) {
 		int j = (i - 1) / 2;
-		if (pq_less(&pq->heap[j], &pq->heap[i])) {
+		if (pq_less(&pq->heap[j], &pq->heap[i]))
 			break;
-		}
-
 		SWAP(pq->heap[j], pq->heap[i]);
-
 		i = j;
 	}
 }
-- 
2.45.GIT

