Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C918950A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510329; cv=none; b=px7jV5uZ07GV5LoVwLsBZ3whj4tFS5OYuhx4NXa9KT7yuQZdmPdrcLNbUpXxLgi04Se3bipIiJ4X/AJ0EQ9uaxDwkdH3mq+UkGNvuIQ1HfXW3lPMZ+wFtKmWNkXbCjfvTHBoCdZsDQnT78wMTLM84AxUfgoiZalqyeWxDlhvqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510329; c=relaxed/simple;
	bh=7fe8b1Q8Pk/pmk9PSJwbpwxLZnOxvrkFTJnvVqloIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fu0/pQKe8VDkmwmBn+QAgAMEaWiVaIOMrhfy/T/Nr9ACNjrT9sC1XdABA0QCMiBh3aV+sfyJVZqTJ6yIF9FIbUkrx0/SiaehOz5sezSkRhIjS7sscd76r0ZTJfmSXZdZDw0DFVm31ruCMd244pRL9kmMNKjtnuQHAJc07R8G5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9SohPGR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9SohPGR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc49c0aaffso51052195ad.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510326; x=1723115126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylQ+xgFjJ2e2nKDrWOjwE4C50vKRhEy7qTSwCzeQ9JE=;
        b=I9SohPGRea/7BQM4x8X+TlcP2+NX6AWd3JXOwqhJH9xGpdOSol2OYqVO8afyFlfptL
         DN0DBpbAEB4/4RKXIrJI7T7scinWLzbKt5/bVgb6uDgoiwCvQYZEHQL9F+aMtRez5j9g
         jJtvImngrFvPLl/PEQJGXhDWsx6cwEs0OnX8HW9ftzo3L50KVoZRxFcaFRqxbYGjAars
         caWapeeXMkspA9zWVgtyaK1b5Iskiq35mhFY67K7TdUrFlnSE75Ya4np5ihtCSuby9EC
         xj/QYGDzsgKp65+2JLxXOozBRI0iAwmdYCIv0x7iZINMfowQFnInSaA1NtR9YwUsaSDy
         k/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510326; x=1723115126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylQ+xgFjJ2e2nKDrWOjwE4C50vKRhEy7qTSwCzeQ9JE=;
        b=aISmSnsVh6Pd8PMLgxOiyegHa5TzwHF/LOWBKrsDEWz7dE0Fc/UiMimm2oBp6R+8K8
         +pLTImZJQCoNxeImP0jbNIe8FvuZ5abBqj8p+0CdLeSxOTLhePeZlx0J/kcp5GH0eiTW
         cxoSnqzQ/kouZaEIo+hDNSkZtzBonhHlraIz4X4OWXFywld8TCWNHYldOP2tCAB0/u8p
         GFHcEGUL7FFAxV0duJJOweYsFen6GqoXHRhKOdRQvAwTNzkgE5I55gb/jprHNr2nrDer
         sCPnr81Fb1L3Brj+pavim+6WrWkrXdle1IKQIhIk7+ZTeL9WlUT89i/p5b3Be36j+oql
         MWHg==
X-Gm-Message-State: AOJu0Yyt0RSBSX1Co8jHYla8J1xrpYch/ZeL6YchiRAiuMHs1ymgMnAy
	FRyG9tPC52CnV9xhmbbguWa2o6AzBweORb0etTQ1/ug7EFWnY+H+mWVhWA==
X-Google-Smtp-Source: AGHT+IHCBWD1wn3Nu+Xw7glsT3oMmTLVuaTzk4h2VxC+V8xkJFVDVk5hyjpc9ROcxHSrz7zedztNpg==
X-Received: by 2002:a17:902:d487:b0:1fd:67c2:f97f with SMTP id d9443c01a7336-1ff4cea5d79mr236995ad.28.1722510325973;
        Thu, 01 Aug 2024 04:05:25 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:25 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 2/7] reftable: change the type of array indices to 'size_t' in reftable/pq.c
Date: Thu,  1 Aug 2024 16:29:43 +0530
Message-ID: <20240801110453.5087-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240801110453.5087-1-chandrapratap3519@gmail.com>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240801110453.5087-1-chandrapratap3519@gmail.com>
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

