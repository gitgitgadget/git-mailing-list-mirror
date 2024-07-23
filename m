Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6106139D1A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745202; cv=none; b=ctjJw1Y7MGGAvjd16XNDXCxGT7ULhH9WPdr3ehHOqWdpzNpvfXnWN5wLmhP8RiDmppTVyEoZIS/0tsZyBjXWE9NXFAoQFO6Y8O7/mVof/K8nMc+68lASBN6FN4+cPz4n2y2h/H00kcj8fRPd57nMGkX5zo7tjGoaeEPqkqkspyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745202; c=relaxed/simple;
	bh=/4OTsqp7/0XagHHoHG87U3Cq8P4orhehoCjdV+Ws0UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmQwoD+DHkU81hl4HEvu4qz36xxijCfF5myoNW/wRPj/bC3MRQXP+sawJPby+NFVBI2qlWWc4VECIrCVhCw08w0BJ2RVxyab9yH344/A5IYUfZgriRV4svL4pC6Wy6nhyzb3tf9MifBwOO9AqLdhqVY1Cy0beGIfXagyODBtfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me7Ui/Nv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me7Ui/Nv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso4422225ad.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745199; x=1722349999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c6I6L2UI6Z07sVX/I4RZEpVOj4WiiO0O3zVyC+4ckQ=;
        b=Me7Ui/NvrQOqlIkdqJF+ZO2zRLKKIdCofOY+hj1MldVfjzP7xqkCROMBjBYhUHuYY/
         1ieWzIIdYS4ijDCIYTDz5nhqgdNv/TJw46taPuYXsvuunYGgZTz1CQDCdSVFqIHHE+Ee
         gqjw8RUbVQf087iPBFnufXercFx5BKq/UmIXgRcNrEtJMmaFjgtXC6YBlk2wutAeXHFF
         agP0MemQ0xr8+wVijrkvmiBjYaRyqUKyUn34ozJtjrGJI+Hg/OlEECeuCzQoriHSRLLX
         4/ADkWpnXdqvuDpxG2/bH8uVmq1latiZzW1ublnf1r73MOBBWZN9EjT1vICzdkKP7Crn
         VcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745199; x=1722349999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0c6I6L2UI6Z07sVX/I4RZEpVOj4WiiO0O3zVyC+4ckQ=;
        b=Kyin+P0MbO1i/A3B1YyKCO0IORP80RK6RgNrzL408qx3LrfRP+YeQMmsUVRgqmfeyw
         Ol63XKUXleId+8Hw24IkiPB9yoHOd2mRBrztm3q2ZAe6QXe+rdQtIYJbQh1790Iib9p/
         d7ipVx4Y3AtRx66MqlL9oH/6EmGKVsk4gGCh1OnR6A/kMzNiZQB2llV8zNLATTFgP9sa
         3Z5qoXu3mSxC+OvkNBE8shoqzzCha8ANrltwe2u1e4ItM10pJTP1a484pquuDly6QA4a
         XCQFT2jE1lBXlnK5Ed/BxtReOhWX15MX1LYbeeCxc0lDFYjVVJGR5R9Cph+mnUXIEHT9
         aaZA==
X-Gm-Message-State: AOJu0Ywv8prcpQ9T70A9zoFMmS/Bvt+5K3t/lxbf06XQbx7zLHO0QZCL
	uZFssA6K5GEP7tNCh0ObjqhjiYc8Do9MgS24oGgcrD+XNoI9VMsfecoh7KwN1F0=
X-Google-Smtp-Source: AGHT+IH3yDDroAWCO2nAn2bk/Xz30qlC/K7i0bmvzKJKdGa7i4LsCYjpCU2/5kn14jerTWm4UaKDhg==
X-Received: by 2002:a17:903:2444:b0:1fd:69e0:a8e5 with SMTP id d9443c01a7336-1fd7462187amr109237625ad.41.1721745199437;
        Tue, 23 Jul 2024 07:33:19 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:19 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/7] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Tue, 23 Jul 2024 19:47:14 +0530
Message-ID: <20240723143032.4261-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240723143032.4261-1-chandrapratap3519@gmail.com>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
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
index a78aba9e71..220e82be19 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,7 +10,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
 	for (size_t i = 1; i < pq.len; i++) {
 		size_t parent = (i - 1) / 2;
-- 
2.45.GIT

