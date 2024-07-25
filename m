Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE3198822
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900375; cv=none; b=EZRlESOCkKsgnKTofd1SV6SbUClmC6+bE3a0X5RJSZckDH5xIDFLwchSCRiciUULrcXA18dxOW2k1zjizy8hXxS9sO8XpCSCrPGT+/82GpyjUi7Xh/Rjt5BEUB+MEqK3PPZIbUqvRp+dofpA3VzDXJSg4qE+N0N+Rslm3i1EiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900375; c=relaxed/simple;
	bh=7fe8b1Q8Pk/pmk9PSJwbpwxLZnOxvrkFTJnvVqloIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk2DuQzPxZ06M2LImdp/YjECnEJLYWzIoAhgRJiHPC57upmxvmzzG7KyzCCqgnWZImF8T9OlNOU4W7coPgupjW9ocyC/ZmvrwtpJjo6VJity3tn/DKTcUaoMxtsoJ+NHdzcsdn39op0Vr0/cK6dGjyZSq+ArPRFGawxaPReIgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff3UGbNt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff3UGbNt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd78c165eeso6240315ad.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900373; x=1722505173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylQ+xgFjJ2e2nKDrWOjwE4C50vKRhEy7qTSwCzeQ9JE=;
        b=ff3UGbNtkHwmtASs1DZx9ywHJeNS3/EViS6r21IATpaFEcqDGrOAtVfuGiTZu1WJZH
         5cHt5VLLrN0AnSwPwM0ynYWVjsU6fPfj3wYPqnVP4N7Ly31On307AUuq63N4EN+RzmCM
         YYxK6abt4W6JGKGBIGcrgSUR4kSE1pPXBx2gKoDyRaSr92mFV+ir6T3rzsfqVvOv9j+a
         GzVL70TW+vu8Qlwg7XBavRounJnQqhBjqr++qbzakITkwQlIDQlr3suKBXbv2thh+IXO
         eI5mUqlpqIcbuMZOThDOYLkl98IM0l3DNIO39Df6FGjCFBSVYHuwWYYrdZ9aZT0aSxOg
         KJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900373; x=1722505173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylQ+xgFjJ2e2nKDrWOjwE4C50vKRhEy7qTSwCzeQ9JE=;
        b=dRbUOeHFpmVMDsMzfXvQuT66KRQj6yEVJWZUSTvkQ23Y7p/EbNOFwjxYv1ZbdRGmCq
         MryImNbhuI6ZMzu5AD9BOKNzgFr0GIALoBLNReoj0LkNWm7yerAAd2O5+pL2faQIj2mj
         4xzRdtMDWvcH5dHZwdNN0Yskjzr7I3OMsjmp1Yt0modtXM/HjvcmdW5+Bwg0tnJU9qqJ
         alU7FCUwFPdwrbWxrMdUNv9TRwSBBoUlehNFokc+76WR4H4OVfTXke+rDkdYH/PoXlbY
         /6o1+0cofn5Ziu6CnCA8Jz0D0iqJFUSbZ4PaP+cPN6iuDQeVVwLYb2QtvFd+UIajdk3e
         7EfQ==
X-Gm-Message-State: AOJu0YxkEJX0sUalK8/cfSg+mz/awanbTBf7je2eGRuvU2ZR8+4YrUmf
	sqnpcFF6F8ZoP7G3QZg14DdqcyjbzEZSzCf65mA7iU14nbN2FjkI9pTmzw==
X-Google-Smtp-Source: AGHT+IHX4LyDCEtVF1kcRJ+BBvt1+RP+IlbHW59i3pp6nyNLPj4nKscN9YePdquhgdoOP8RsHYBYEA==
X-Received: by 2002:a17:902:fb04:b0:1fc:6a81:c590 with SMTP id d9443c01a7336-1fed9225cfemr11203595ad.27.1721900372563;
        Thu, 25 Jul 2024 02:39:32 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:32 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 2/7] reftable: change the type of array indices to 'size_t' in reftable/pq.c
Date: Thu, 25 Jul 2024 14:55:54 +0530
Message-ID: <20240725093855.4201-3-chandrapratap3519@gmail.com>
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

The variables 'i', 'j', 'k' and 'min' are used as indices for
'pq->heap', which is an array. Additionally, 'pq->len' is of
type 'size_t' and is often used to assign values to these
variables. Hence, change the type of these variables from 'int'
to 'size_t'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 1a180c5fa6..2b5b7d1c0e 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -22,15 +22,15 @@ int pq_less(struct pq_entry *a, struct pq_entry *b)
 
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 {
-	int i = 0;
+	size_t i = 0;
 	struct pq_entry e = pq->heap[0];
 	pq->heap[0] = pq->heap[pq->len - 1];
 	pq->len--;
 
 	while (i < pq->len) {
-		int min = i;
-		int j = 2 * i + 1;
-		int k = 2 * i + 2;
+		size_t min = i;
+		size_t j = 2 * i + 1;
+		size_t k = 2 * i + 2;
 		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
 			min = j;
 		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
@@ -46,14 +46,14 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
-	int i = 0;
+	size_t i = 0;
 
 	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
 	pq->heap[pq->len++] = *e;
 
 	i = pq->len - 1;
 	while (i > 0) {
-		int j = (i - 1) / 2;
+		size_t j = (i - 1) / 2;
 		if (pq_less(&pq->heap[j], &pq->heap[i]))
 			break;
 		SWAP(pq->heap[j], pq->heap[i]);
-- 
2.45.GIT

