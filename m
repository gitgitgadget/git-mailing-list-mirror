Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A434F46F
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465285; cv=none; b=AdxlOaFb1m8Y6xuFqc8bSPUtMouGksM0Qwxj/z2hFUbTfiPnkc/SjS3VfFqXJ71VBABmsIMLmrqZWg5b4ppuOYHUavHkGjEYPSotZunI7ELPhHCQ2NE+a4JsDhlsvxZHCnGjQHh4DZ06gnAhSvbiifT3ujGcpTDy90NcGFUn8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465285; c=relaxed/simple;
	bh=Be7uem3/wLq9XQtY6b5prSrinVeC5ZbQos2T4aVnzLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEUb0Oe5BL6nkZdvyx6LEQtXwArSvqNbENyaP7Wk6g0CDbKVEwXuQA0MKuVbA4NuT66RDcTcm0XlQN6BawmiDNyhi8jWFdPcwEONdOp+pVpLBkllVd/mT+JQ0lLQMu5gSZlk+KvXG20um+WUgW87vwt7eG4TmobyWLY/1vK/8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/UOAL8E; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/UOAL8E"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b737502f77bso474732266b.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 03:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465282; x=1764070082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1MvPK8lBRV2R11IKy26P5zITc66GZs3/BkgS01Dva8=;
        b=Y/UOAL8EPGJViwXWtd8VqGVroLYG+q91XWZK8UYmigvzeKXOsy6XmEekO4GG23GBk4
         NTls1QSPQyrOTp8P/kQ047fdH+jsQoGRXr1zUBxz8wo0KyPqbYx0uzX/Y+t6NpUr5X/w
         otzVnjCwsZeHL3r7UzMbwSxSSGBxKF6hbWfU0TLoAQFsrIilHSQhToAJZNNWVdHZOY8p
         fIzwYNHvnMDSZvYTCm39E8pJTU/jA2ww8/kkZ/AJeq3MskMsj3xRVGQ8gaAcDKI7HXjc
         UR30suae9FOP83WEV3G3Jt8qk1TwZ94u+3z/rB3LrbLmOIoB2fVbeWKekTMBHOwEVpTz
         8B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465282; x=1764070082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1MvPK8lBRV2R11IKy26P5zITc66GZs3/BkgS01Dva8=;
        b=YgVARi2OPewLe4eL28b9lhiS/oYEFcrHg7SlKsqCaFVXhSLx5P6KpUWqUYL0nl213r
         GpoeE0TCXMVbpS5TxBPnd3BWdsl51EI9LXjPryJgSw3qFQu1eckRRA6qEY0TkiCcw0p2
         RwF2KfckGs4uoXbuVHxUAr7VpuhOv0u+Wre5kC2bR7/abCNBaSO3Fz7j7Jeqg2iIcs4d
         wmjKmgEyPHZsC+RKgoTQhum/I+CiMIFeovSK1KgQsPa/+AOrOslsLJyNO3t65ZSjfOzK
         3/U0H3hJCwI2qvnnYk0GM2EJTRUprFO0zJToN6AIonsSBdW6nxJ2e6N037zGclgFv7QG
         E7GA==
X-Gm-Message-State: AOJu0YzJxClThOE8hzcj827GTR8D9LcTuySYoxc2XSXTiOf0PgHFx7Du
	ro+p78gwEa36uyVPu72EiAUE0yga+ChbOoRyCUi0hG/pMcpYXEoAlZ9c
X-Gm-Gg: ASbGncsb+Du+UR7z+kubB35ocx6xQ4nv1GhQ45XC7j7tI7bc1eTupudWjhQw765NwXM
	PBV0e6WR/mPD5uAXUm3QW1GUdJgr34raeCZThttjtODH+brQMqg8DqPAIM3jLxNVHbHsL5D95TY
	xCZvYabSwuhbgwCurWssS2d+PmhXUis59ezX8sNrk2pMbaqkV73WG/vhsb3FmSYLjU6lmw2zH/u
	+lTxyw/zP3xlvzJnDrop8uqGyRG5gAmuIjSMHfk+vpGW1cBuMl+EhZ27QVSL2XsAt+hHb/0cVeN
	Qe0ldwYdkiApJRfBLnzETNqFKPg+3RpbiND6quwkjC3cb1YpJX9FPHfcgKRoaMKnFJbsZXAOvSD
	dzOxrdayiRULl6rUPM1GSjytBcKKKpGHtKSprFg2tNnNkgu4PaB0Kiq3xxQKWrHrSsbI4ckiPZ5
	5T/1suX1mC65eXI1Y=
X-Google-Smtp-Source: AGHT+IHf5x+ZokMNxUc19W9AUESZ91QYwBEs0DiAnC75JSEak9uexn6WuLJRpd+baXGW1B+860IKnA==
X-Received: by 2002:a17:907:c1c:b0:b6d:4df9:68bc with SMTP id a640c23a62f3a-b73677ed6cemr1756837766b.1.1763465282040;
        Tue, 18 Nov 2025 03:28:02 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:118:b28a:3b78:ce56:def6:5cf8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73718fec4csm1005451066b.39.2025.11.18.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:28:01 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 18 Nov 2025 12:27:55 +0100
Subject: [PATCH v6 1/3] fetch: extract out reference committing logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-fix-tags-not-fetching-v6-1-2a2f15fc137e@gmail.com>
References: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
In-Reply-To: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Be7uem3/wLq9XQtY6b5prSrinVeC5ZbQos2T4aVnzLc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkcWD3KyZull8/IcHCq6uDC+fwZ430Ruu8rq
 lIlgTExsSbJYYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHFg9AAoJED7VnySO
 Rox/i7QL/0+KdpgABkKrXu8X+AnQ+MxpnIviZVf/Wk8RFgrImnVaPzvdUYXgCGfktLNdj23uVjc
 1EJaUUJpWuskS9fqVKbM/4f939CtdDIUzGzLL/BTUwqhI8p6gNgGbUTfTsSk0wuw34reEjrgRPB
 XbJfDdroWbcc2sUqHcR2wQ1YPCxcSvUqmCvIg8Lx9Dh7gvtLN1BDY9Fdg9aqTl02RZRU+kxLcT7
 Zv4d8ZXCbkyiigM1feJcKtgiVfomPEB64Ro71UP/PZyUqysMIgZjz6TBrUK3wgWikdWDGlybmVQ
 y63G9cEtmTjCddhpy99xxByB/BUOc4NPmPOaqDCbiUyUQ/mzg5qdreVacIyTW5W0hRnJTTONR2y
 gpXkhWD6B5j8FhkH0QmVRnuhuh0VwlXoR/D4o0cqSgVlEScoFB7yuUlBGuqpiv5tJsStPWupmnI
 xykmTdbHS+ti+g/lalbQ5yls2KhegWrokaTxkAe8v1MYTTOj7SyYyGHl/wzczVKMSc86AXhSis6
 0E=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `do_fetch()` function contains the core of the `git-fetch(1)` logic.
Part of this is to fetch and store references. This is done by

  1. Creating a reference transaction (non-atomic mode uses batched
     updates).
  2. Adding individual reference updates to the transaction.
  3. Committing the transaction.
  4. When using batched updates, handling the rejected updates.

The following commit, will fix a bug wherein fetching tags with
conflicts was causing other reference updates to fail. Fixing this
requires utilizing this logic in different regions of the function.

In preparation of the follow up commit, extract the committing and
rejection handling logic into a separate function called
`commit_ref_transaction()`.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c | 59 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..f90179040b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,36 @@ static void ref_transaction_rejection_handler(const char *refname,
 	*data->retcode = 1;
 }
 
+/*
+ * Commit the reference transaction. If it isn't an atomic transaction, handle
+ * rejected updates as part of using batched updates.
+ */
+static int commit_ref_transaction(struct ref_transaction **transaction,
+				  bool is_atomic, const char *remote_name,
+				  struct strbuf *err)
+{
+	int retcode = ref_transaction_commit(*transaction, err);
+	if (retcode)
+		goto out;
+
+	if (!is_atomic) {
+		struct ref_rejection_data data = {
+			.conflict_msg_shown = 0,
+			.remote_name = remote_name,
+			.retcode = &retcode,
+		};
+
+		ref_transaction_for_each_rejected_update(*transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
+	}
+
+out:
+	ref_transaction_free(*transaction);
+	*transaction = NULL;
+	return retcode;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1858,33 +1888,10 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
-	retcode = ref_transaction_commit(transaction, &err);
-	if (retcode) {
-		/*
-		 * Explicitly handle transaction cleanup to avoid
-		 * aborting an already closed transaction.
-		 */
-		ref_transaction_free(transaction);
-		transaction = NULL;
+	retcode = commit_ref_transaction(&transaction, atomic_fetch,
+					 transport->remote->name, &err);
+	if (retcode)
 		goto cleanup;
-	}
-
-	if (!atomic_fetch) {
-		struct ref_rejection_data data = {
-			.retcode = &retcode,
-			.conflict_msg_shown = 0,
-			.remote_name = transport->remote->name,
-		};
-
-		ref_transaction_for_each_rejected_update(transaction,
-							 ref_transaction_rejection_handler,
-							 &data);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
-			goto cleanup;
-		}
-	}
 
 	commit_fetch_head(&fetch_head);
 

-- 
2.51.2

