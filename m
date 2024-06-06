Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583413C683
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660643; cv=none; b=ke+kDqlAHLtrYDEbBrCj1hOOqVYQeE0DknxnN5B4gxbz5ZTfHJFSiuDewwGQljEIscdlSOaCIU8hyNfze/q9wnpD/OcHH7yPErVVfNG3h/o+FSdR4vfmJcfOcoKRRaOpGaFa9OiBW9FOW+/gqsyKSCJdNcM7IHmNAihlS6Sh0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660643; c=relaxed/simple;
	bh=AVJ2GuvNLpH7T/7ly4HBkvLXnnV91MIswR3YTjrl5WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arGPEUCdJEXcCRfFg5GOIhkwhC9JB6czbH4V8qLB0qbhmvThr5tkgfnFu8/CSsXCxVaiw00vW3Md7sqn/mjTxG1i7eIndEzkub1uPQ9lpHKyK4eykFQVnyUkpMt8df86XyZwqWBP/E5Xum4Jz0bujyyOjZ3S8uEHXnM3WJPogMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OajWtOjF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OajWtOjF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f68834bfdfso5463995ad.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660641; x=1718265441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSddJ1yM2eHM1sv7NU+XFejcF0lHK8KOHxU46kroeK8=;
        b=OajWtOjFH6sCTCy8pCS0OpLQWOgiap8wXeob1slVp/ag/GTeairEeQELYpirkpoohH
         KFkSAZ6boMfCs2uEz03Zc7NE4nxBJ0PPLP/YUsXVEu7I+jr1DNCAj7o0HX6BW+bn/Aww
         +CLsfXV4igBU4ksiPChe8Qu3KvoyF2X1VG9TXVSTvYkYnevFxnTbgbCya0gVaDRSCRRn
         hw00F9Au3YZUUMSSjSdOzctVk5oPI+q+lT5Va4AJtpeNnLjN1T+qXJvtBKuTF1iO095J
         OEDXF1/eARCQyi53OYfMoVB7SAW3+DD2K3ymNDjFHIGuiVAbyB1XGJXHFPCN0wRQmpQW
         9anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660641; x=1718265441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSddJ1yM2eHM1sv7NU+XFejcF0lHK8KOHxU46kroeK8=;
        b=Lgo4Thg7/hBfbGLV4G/3I/ROeLzOEAvyn4rBfbH+qQCsHMNN8docn3vxx5GmktjGKx
         rIbZzz8hxc/Ehfc/MPIXnQF4ESymE7/JlHrpc2+aTVVhmlNavkhe5OR8JRYRqc9UiHLv
         e3fgJKpJi5KzgxY/eyWeTW6xSWgsDWALjxeEff6r5lge4aMO4QIgrCSuWV8945k7j2Ab
         ngHIEJCVwmLDF6TCdzm3zuUCCYt8w0Q12c6vFP/Hu96F+8N7yuwGGoRiVEDYrR0QY1Fi
         joxucI4BP/Mr6Yso3kcAVTkUC+cThj4XK1Jd/0T3fsUMSSdX4bg3lhj8GCodp84PUrdZ
         p3lw==
X-Gm-Message-State: AOJu0YyIV//PzoVp7ao/3V0dVGoal5mTOCqPElUo/snICC7BOYvIVumC
	jhhXtSnk3Oi4qUSabTTs9I1a52LWhk0RnrWx/l3PLjFhBUrEKtXOJSC5MK0u
X-Google-Smtp-Source: AGHT+IGmfylLgJPZMUAGd/leaUihX3qrpR55NM2fcFCI7x/TM8xgKViBqZFBCZmG+42uQuMVu3+m5A==
X-Received: by 2002:a17:902:d2c5:b0:1f3:83d:ee82 with SMTP id d9443c01a7336-1f6a5a1043cmr57341715ad.25.1717660640749;
        Thu, 06 Jun 2024 00:57:20 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:20 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH 3/6] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Thu,  6 Jun 2024 13:10:47 +0530
Message-ID: <20240606075601.6989-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606075601.6989-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merged_iter_pqueue_check() is a function previously defined in
reftable/pq_test.c (now t/unit-tests/t-reftable-pq.c) and used in
the testing of a priority queue as defined by reftable/pq.{c, h}.
As such, this function is only called by reftable/pq_test.c and it
makes little sense to expose it to non-testing code via reftable/pq.h.

Hence, make this function static and remove its prototype from
reftable/pq.h.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.h                | 1 -
 t/unit-tests/t-reftable-pq.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index f796c23179..707bd26767 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,7 +22,6 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index dcde73de66..5c5a4ecdc5 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,7 +10,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
 	for (int i = 1; i < pq.len; i++) {
 		int parent = (i - 1) / 2;
-- 
2.45.2.404.g9eaef5822c

