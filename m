Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145343B3CB
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701453; cv=none; b=S9/8B/00WOPAuNKJyJm0o5tQf58uM0Ypo1YiUEZSITWdHWHuC4X7rtL/uOFUl5lNsX9FW4NXwPJ6Sx7IlM2yvwWNd1+RmUxxouoWMoaHtNfra2SpG59aVdzRvNxXCQuBnZ+j/oBKqX7iZ1WhFHWSjxMKDbjqs2nWgNhvw66Dzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701453; c=relaxed/simple;
	bh=LgJOvA37/dn989m/9nA4etAmFKnNL4+6BPFhTkQDyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVnhF4Q03PxY2JT6Uwi4nna+xUyNz6K3mR3XmN5oAoMSgSwqBnyk+AwF9TFaX14fvj5I8aOdFtVzFNw1RG5+asn+V2fvHNYVtkqN+JvZsiOd0nsM6DuyBgwbrCRAAUCgbhSs8gH/k5FsUwmhMhSDAdliM8a0WgFNoqHfV3TtF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPV9hI7s; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPV9hI7s"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9f5637634so757295a34.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701451; x=1784306251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDSOP+3BniZFgdUwWWr+Ikn6OeyHKX1hklh3zV0kIh8=;
        b=jPV9hI7sailqwsgv9+Hr0LNwrTMV3rxcGUezJw0GdUWLbamWnSCH4uZaLBsFZN+k0C
         D7oxHTP92eNXMWP4HVMUrxVjEO9R04QVoRWbc5v/TLmqyxOELvNpLOofTk1euI9cFX4n
         A57RwSMo06gcU2IP3FmjTe8Fimr0n6twimo01FspDfFOcFEOdlIyM3xP7fIpmzV0dHBg
         rLhLJjd/I229SFtadBQBbjmX34Jdmm64T/C8N+NN6PraNfSw7JquAjZXJ7Wgp8ErlQVa
         gaQHW+Rek1BPtne+L41+l9Ijxw1pa6rGHS85aRQmE5m9wUg+kp941KC2aACB5WrFP47r
         Jdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701451; x=1784306251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDSOP+3BniZFgdUwWWr+Ikn6OeyHKX1hklh3zV0kIh8=;
        b=g6HE4iOP90mEaCO7aZG8SiLQ/IB4fm5uHeGEBexHs/Ml1RMk8Izc/2lyK+RnjtXqoq
         aBPcSDCz6oCXN1xiinFpeinjoEunRyHrcXygFADS/nemDiWXEc8BdjyaR/OqyFQv5Z2e
         yLAv86WXo2hLqzFJzbQoZl5yetHNytrop6tXIuM71ADKt+weBcq6kaPe9uTMQ8I9NDyd
         O8h0LoqJgc2cVNHFEY/yle83SJi4F7u0G3RMbkinIHFaO2oI5H/ziaBBvHLrPMW8r+4A
         Lkj5ykqALC6FZr7bgJVmZRwX19hI4hBCrvd7+/DG6u+/h/Y/lWQhGMYC+cKafB31B1HJ
         /XRw==
X-Gm-Message-State: AOJu0Yy+h5Pg2bpF50nrxFqp6NA7VaPiaXGKReF0AAIrgAvq8WSMEerH
	ruubbaplLwY1JJ2yQdC++/CTEHwQdftqSpnMwfTmoK93tNpG9J6ndfVRV7GK9A==
X-Gm-Gg: AfdE7cm3zDH7WMsFD5jmS0jXqx2n+QJbIT7uuyn/llryJ8PfMnoab05vnXnJOPdOIn4
	SwT1GR5SwnGYe4wJzGXI27ezPom9qzt1DMeA5nN5kC8s6Ox10B/kBbOz763z6mAQyRhC0D6S5i2
	R3FFqskdyBq3DvuEatevfhu4U14aNbDyPg25urzxqdLM+zfK6CA8CoqtxYls99Fpo4ucCqz8TlA
	WMT2q/0inMfBEzBXJdmSJlay7HTa7kfmCZfYBpr+Eu8QZLupfFOucegsyOjyy8ecD0kH801zPp4
	fT7A8Yrd4Oblr8bAQTzjUJZf7MrQBoOkCVWUJJ1iMJ10NhM79kSPo+BKZogeidXXoVEPIV9Rjf8
	ytRB1Z2phjcNkufAqjgWOHIBizxqRVcnS164iScZZufLmXVWHlMGPuE5VkPaxErY0ZOmwn8BrFa
	IzOgEWJkr970gcoHkOrTyVHZMFe/90OjI=
X-Received: by 2002:a05:6830:8389:b0:7e6:e162:915 with SMTP id 46e09a7af769-7ebcfe54156mr8328109a34.5.1783701450712;
        Fri, 10 Jul 2026 09:37:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 04/11] object-file: drop check for inflight transactions
Date: Fri, 10 Jul 2026 11:37:15 -0500
Message-ID: <20260710163722.2962278-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ODB transactions are started via `odb_transaction_begin()` and contain
validation to avoid starting multiple transactions at the same time. The
"files" backend also has the same logic, but is redundant due to the
generic layer already handling it. Drop this validation from the "files"
backend accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 4 ----
 object-file.h | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 33bd6c6810..e51389833a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1678,10 +1678,6 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 {
 	struct odb_transaction_files *transaction;
-	struct object_database *odb = source->odb;
-
-	if (odb->transaction)
-		return NULL;
 
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
diff --git a/object-file.h b/object-file.h
index 528c4e6e69..ea43d818f0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -194,8 +194,7 @@ struct odb_transaction;
 /*
  * Tell the object database to optimize for adding
  * multiple objects. odb_transaction_files_commit must be called
- * to make new objects visible. If a transaction is already
- * pending, NULL is returned.
+ * to make new objects visible.
  */
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
 
-- 
2.55.0.122.gf85a7e6620

