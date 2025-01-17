Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE901F6687
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100764; cv=none; b=UIGFbvdthlVjvGQ8p9oHiPNPA5FTILeCNY7m2yOo5OCyZtdSAAedEK8Ti7jSYugpWpHHqP0tQWo3s2Fk6NKt/7fVSD9Y/Ho2D6rKBSXkKAPfUkz4Y4IsIGQYlGybR5VnVkZzKsWW3voc47Z+M7o4p2NTYHuV0zbTSLjsvoaQxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100764; c=relaxed/simple;
	bh=TSPCf+j0k7VuAkz15xovC0Wqa5yky68vfuH+QEhBLng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0JGF5Ay/aqTxd8uo/rfUlxHetL4I0OsEx2ECnaWoPqMjUIWmJjNJbNO6UCm9IQ8qwaBHiMiXwgHgEaQA2eWksxRvCpjkTLphjKP9ioB2vOM+NDASAP4Y17r3bp8dwzDkNGTH4gEqLPEzNkNGX9vmFSPKis2rtm9AJzEAaewHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adbFFcfh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adbFFcfh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216395e151bso25381745ad.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 23:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737100762; x=1737705562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EqMzg1mu6ESTNsAg3uvLylxRV938uaovsWvPTAPeiI=;
        b=adbFFcfhWtM+j/JQXmS/try8cKFk0c5vGgRE5c3+WQe7H/Z2zJbor/WcugRgjZgXep
         9geuMAzFawvc11JCXPmn7K4eg9zBqi0whg5G81euGI6oqNPfiK492Fu6kOHM4zb5ok+l
         /MTBTZFrPJxkv3g3kejfaWOimpwL+2FPLcNm9n7v3e7GKzAT2NGwg6Js76m+bLPPT2hD
         ldVmgLY0EIpVfe/65+ovysZfJogKk6u4uEihvnyhHhJD44ClLegBrcGdWq7xOTJaDbFJ
         gjj5SA7ZCem5sgz9PuAsUElZa+UgNkfgTWPHtvd83JSpvRnzO+O7opiCBNse0L6TygQg
         L+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737100762; x=1737705562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EqMzg1mu6ESTNsAg3uvLylxRV938uaovsWvPTAPeiI=;
        b=VS67vXPvEZI4K815mPMbu9sTPgggKGenPSZCvqDdmWXibXQ0zTyjir4YhP7gGsL4Qd
         Ofm+SlCcvy8LBtUfBOYUeDWojZztKfsMaZNTfPuaEwdrRL4pT7Qgy8asuIkXcJ+PPf9G
         L+jVQguej21ItkxvzM/avpeNHmbYQSU4L7M1QF/Ln1JyixjUuSr2aLq+qjF55JhJBZz6
         cBiX6nsqzB4u1CmryU17QF1KoPY/R9WZVp4wHII2a4OKEdShPWnzxe+xFoFhJsZCwgJw
         JzMzuZxe4GRyXTMxkURHW+FiJeSN6+0NQ3sWaBfPTxEA2BbfdSzdSQtf8ayl445XtzaF
         O/4g==
X-Gm-Message-State: AOJu0Yy02GQTBLwFqvQwa6SMouwq+D3jRoqSAEQdH4X3ef2ic9sED+D0
	uz+4Bvr8ziWVfd1GjFYr6ZJkVXoNX/lMomQAEv8MAV72FWbZq95t
X-Gm-Gg: ASbGncvCcRVj1vC0T/AFjRVekVy4eVTzaLdRFgHqdYXhDnVO1AigeqQv2Qz1SVpjjjD
	r6gYGTRLZot3a0wPr1IxwemZ2cGBT2mQqfA+R0TPvP+bkuA5ekMIemVpLXf6dffo3bHxu2T9bmW
	ztqvh63LmMMYaLGCb/UkCPJjhAzdR+NDdlRlvACcwUTLbnYk1ZMEgx8lIFL1WEkp7n8KJpXpv/u
	g1dVCm9eJNfdCJRhUCBp71iRVp7u1m60Vxq5hslIA3xdZlwDtW0OZFlrcg=
X-Google-Smtp-Source: AGHT+IHN+yptneG/Y+7GfLvJ2cml5m75QY+CZJcM1iwzoFXFBAq56vXDHtdneDbeEExG73RjUwgmhA==
X-Received: by 2002:a17:902:cf11:b0:216:84f0:e33c with SMTP id d9443c01a7336-21bf0cc04ddmr167486155ad.20.1737100762318;
        Thu, 16 Jan 2025 23:59:22 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4025f4sm10517595ad.204.2025.01.16.23.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:59:22 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 08:59:12 +0100
Subject: [PATCH 1/3] refs: mark `ref_transaction_update_reflog()` as static
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-461-corrupted-reftable-followup-v1-1-70ee605ae3fe@gmail.com>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
In-Reply-To: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, sandals@crustytoothpaste.net, 
 gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TSPCf+j0k7VuAkz15xovC0Wqa5yky68vfuH+QEhBLng=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKDdU0iujZxq+oY/6wYMoIlfQPb9jVc2yKE
 Ld9FHBNtciokokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnig3VAAoJED7VnySO
 Rox/TlsL/iS1BXnCdYC0C6tZDVavkdbj5Ynrz6debyEbZWxkRkJ+LU/RB6ABp073FULQbULTFct
 6BiqzJhYc1SfBNnVu2dZb8DMHt0w1i+cza7ZyWKeL1T6wfHW1tb7UiQDcPShDeHPJDuPgJ3eTNo
 vuGhQ6pCyG98/dLyX0nbyBvt/896Ma5Xpar7iZRBzw+4dYYDlhXgC1wKdTQ84QDbLkE6T9XNjLh
 DrglQ/yZcCELW2tMO5aE/4+ps6wbxKh6qeLWoveCACaUuEnOExJNiX2YWjupdqyDToNJ+fwWaqz
 33T0VkGiGOVmPbfvUgxIovfiu0BV38cRZOxdlFz0C2tiFLfH5eBRTe9jOTwJF5aLDtQ/Dbi/p/j
 Mkfy7BRKaOMXLBvFyP9LhcUBSpWzykyNEaz3mK9tNblAHef0cC0srrWvS8dL8ZQAxFiA4vLVKa1
 PJ/o9vqik/SqHJF+l1vmL5LqpiAi/A7H/T1hzHNJTrqo6kfiuVCla0mrO/TWcjJN5eVSgAkqII6
 K4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update_reflog()` function is only used within
'refs.c', so mark it as static.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 16 +++++++++-------
 refs.h | 14 --------------
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index f7b6f0f897eb58665e10a2efd3eb53c3f72abe61..1bb6f0356d5c5cae8bea9d6f4d5ff35164a03c64 100644
--- a/refs.c
+++ b/refs.c
@@ -1318,13 +1318,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_update_reflog(struct ref_transaction *transaction,
-				  const char *refname,
-				  const struct object_id *new_oid,
-				  const struct object_id *old_oid,
-				  const char *committer_info, unsigned int flags,
-				  const char *msg, unsigned int index,
-				  struct strbuf *err)
+static int ref_transaction_update_reflog(struct ref_transaction *transaction,
+					 const char *refname,
+					 const struct object_id *new_oid,
+					 const struct object_id *old_oid,
+					 const char *committer_info,
+					 unsigned int flags,
+					 const char *msg,
+					 unsigned int index,
+					 struct strbuf *err)
 {
 	struct ref_update *update;
 
diff --git a/refs.h b/refs.h
index a0cdd99250e8286b55808b697b0a94afac5d8319..09be47afbee51e99f4ae49588cd65596ccfcb07e 100644
--- a/refs.h
+++ b/refs.h
@@ -771,20 +771,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
-/*
- * Similar to`ref_transaction_update`, but this function is only for adding
- * a reflog update. Supports providing custom committer information. The index
- * field can be utiltized to order updates as desired. When not used, the
- * updates default to being ordered by refname.
- */
-int ref_transaction_update_reflog(struct ref_transaction *transaction,
-				  const char *refname,
-				  const struct object_id *new_oid,
-				  const struct object_id *old_oid,
-				  const char *committer_info, unsigned int flags,
-				  const char *msg, unsigned int index,
-				  struct strbuf *err);
-
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be

-- 
2.47.0

