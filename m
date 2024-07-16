Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD64207D
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116647; cv=none; b=o1na7weMIT6NArMOWEUXk1t6Tt8zbVBg2ro2+/S26oca+APrIo1kyaTKYy1VY9pdLUlimTQIwZzQRlDnAkLLgpu1o9/TxR3cMX92CqWZfIqiI4gOrbzE9N+SycD1ORpT6njhyIC+LkBWcX7VNlGT8l++R0CBZhxEJzWi0l1yt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116647; c=relaxed/simple;
	bh=6dcZwXz7GFp7iAldfAYFiGDg1AfVonu0hu3Z6u9wQN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hntI3lpPNXDirFLndct2vY04DPhFNnmyaSdY7dHDDZF7LbP5rAXqvB75SlY3P+XqIzgT4DlV0yZ0qtSi4n48jvCBwUGrJQ0sElAcR2XepZtRthy8+HUGcFc6VFPa4oyZQG3K28LZw4yFFOW6EzmKFeyYUQnyuVn9FSASoCoi2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9T50/mm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9T50/mm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so38553885ad.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116644; x=1721721444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=b9T50/mmU5jvqcQJ85Nct9FCVNMjHnvd02uvdtxeCTMTvG4Axsxr40+4ZfmrJ/d0QS
         2f2DJ+HajXMqs0PTIhYJYfaTFZ8oCiDhTzqJt06OHgGLcn3Zvzjud5uCEWiJAvCFTSvo
         mbtecv/Vua70fckrAu8+Ye8SXnccOy4mX+STRatiTv+iSEKPkNqw+ivB5UDY2dxb17SM
         icwbAoz3yKKSbzyiD5FLjUrrUVre8mWZIyhkvC70xh34Nq50hRsrVIBEcgGY3ar0qkng
         5yE39YFBzHn7CyJjkyCXMW8fET5HssBiIMTmLzQ0kqHe7wFLiRiAI30Z48GYMA8YmNGy
         rt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116644; x=1721721444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIDjQDvcxNu4l7Bz0MrT/RMIwMtJCJpsOd0bgbZFxZ8=;
        b=SrxyU+Uz2iHgUYNp58qDfHqi+Oz5UJfbCLaCYseQdw3z2FIO2TYK0jCGGbBoxeAtzc
         o5jEae/WH+F4ZimNCTAYlfNiLCsBW6QSs7ewdVZAdErFh9CLHf9SgB8w8mNckDQnY8qY
         2NJegj3wSEiohDJj2sRT0QHjxCrkzAVou0wvaJvYAu/ex7YVHowqG+TYXXbjDwuGFOWK
         Yu3KRnxEi8mesSAf8Z+6njTwY9v4rP4cLX1YJkNP6yNrmnpIs5Ub9oNmbMk5eLSUutyq
         UeFADso+phLyFaitgpu8Wor4eDzVF42qnsi5m7SA1Dl/tT0nc1/WmZtzuB+uRmLwmDhI
         /I0w==
X-Gm-Message-State: AOJu0Yz/I1HocL0oQdTuEmNUigWJnL/dX3GX5NMwsakXb5f94NoqBN4k
	603AWLOxMN7GLAWqOL5H1ELShhqI3QMs1PHOp6EQOkbRcukEik2Lx22z7bjc
X-Google-Smtp-Source: AGHT+IFUdft4meGVkH9ZbLvR2RQRCyJrVo4jY20TJpGrhfXwptQE/40nWSgiL24uKD0Iao/+p5CM1A==
X-Received: by 2002:a17:903:2285:b0:1fb:7b96:8467 with SMTP id d9443c01a7336-1fc3cc980e4mr13862035ad.63.1721116644474;
        Tue, 16 Jul 2024 00:57:24 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc3a599sm53691435ad.232.2024.07.16.00.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:57:24 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 1/5] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Tue, 16 Jul 2024 13:18:13 +0530
Message-ID: <20240716075641.4264-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/CodingGuidelines, single-line control-flow
statements must omit curly braces (except for some special cases).
Make reftable/tree.c adhere to this guideline.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/tree.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/reftable/tree.c b/reftable/tree.c
index 528f33ae38..5ffb2e0d69 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -39,25 +39,20 @@ struct tree_node *tree_search(void *key, struct tree_node **rootp,
 void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
 		void *arg)
 {
-	if (t->left) {
+	if (t->left)
 		infix_walk(t->left, action, arg);
-	}
 	action(arg, t->key);
-	if (t->right) {
+	if (t->right)
 		infix_walk(t->right, action, arg);
-	}
 }
 
 void tree_free(struct tree_node *t)
 {
-	if (!t) {
+	if (!t)
 		return;
-	}
-	if (t->left) {
+	if (t->left)
 		tree_free(t->left);
-	}
-	if (t->right) {
+	if (t->right)
 		tree_free(t->right);
-	}
 	reftable_free(t);
 }
-- 
2.45.GIT

