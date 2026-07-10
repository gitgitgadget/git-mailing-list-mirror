Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017E43B4BE
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701455; cv=none; b=jB4uOtk12N9lFUcFP6NqmaCnBfyV1Qt2lAVlctUUpWKPwlfaIeBshvhYFv72TV/lueUcl1P5r1WidpExwQ0qLPfT4GSLYAYfylSCW9ujlMO3nmAnBjLfaYWNFIGhbzSXAyu599EoF0lDUbFnuesiVkp/109T0KrzTAlKBS0hUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701455; c=relaxed/simple;
	bh=uZBzM+8gjGVgw/A3Say04SA085ysXNDTTdfP5SSUJts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qH1usLdbmbooEfZIlus5/A05N8uPuzd3IEWJswc9qm/8BotzrK1xRclIlC8Q9N5zjbwdJ/RLNmvrj/X+mRXLeEnICCu+v3wwMUKvq7L0FHwv3YWxyE9aud/rx/MIQ0OSZgkz56CqxWS7aeq+I8fPifHIcvJPcKWshdwmA0rYDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcOxlqTm; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcOxlqTm"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso1022776a34.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701453; x=1784306253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g++5dVzCjxxggTyxhY66LGpErAqFtz5yR90wDHmzQzg=;
        b=fcOxlqTm8/lzWoXmuYBQABpvjYD0EsrcfYrF1QeXXgR7onGsBkclqS2qCGlOHkdCiT
         pa74TMcG7CUrVdSmpzHQlvLtqEO308b/3rLqV7/jJVE5G4aIR7BWCBvWS98jafK0o+hr
         xtOytqoxmw0NiVSZTBWiQxVDU6xIfNHUEcIcdXbb+BiJ0yGnS8yV0A1NRgLR6J1UcPTd
         SZjlLexX5iFjnh+kU66YhEwAbuZ1JmC748fTWVDrrXnmCyUgomY5NHnc8kCp4uCUttGr
         vCkZnaErJQ2XCVSL+tNPSmexeFwaTgj9WWAVPca2aUOAGCrm0EVpHhi8gukt0gbOMKqX
         ioIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701453; x=1784306253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g++5dVzCjxxggTyxhY66LGpErAqFtz5yR90wDHmzQzg=;
        b=rA2iP9t7Ap3/UNKlaiBthELSrFuLKhYheFksjFhw4XT1xRf4Ze8LDofRropqpQcXRX
         bsdu3zvk2qV2Q4uGYJ/+P//m98S1nDCXkL1VFhSZdOtmmHFbb7/hePsHLsWqytoeV8uO
         47YWE8hN/098+e7oxrmjJIUeNIPO7Zf+yPHOGY128ULU6SmjvN3CnSTThe5POss1iTGY
         8R+zferDHBiSicyoXickFJJXDTAgD4jyITGtjS9lMrOP0gFLR6zDZ1GLD87c2/4ci7iY
         PB+w6g8Y3ue3Be0oFfiJu15t2Yg3NB+UVyVuvfYZ9e54Kt3aAE9KQ1Sx4RU5bnbc9z5k
         aLbQ==
X-Gm-Message-State: AOJu0Yx7sI5007kEXppwn6tRU953RTmsF600rW28++6icKB/iq6XMLsB
	hAwK0+4HlHY/8DBnW4bkPho+6QZN3MTmMej/B7Jk8V5gl9WKafL0+1luGdR85g==
X-Gm-Gg: AfdE7cmShkHzkYRTK8B7YMpLrJgWhRNvpbhSpT4lBmZ83VQz8iYwHGe/bRwL4LmYh2t
	9/xovM4PmsqXG51ifxwe/sbQDMOhkp/buoDl5pTIr8B2mmTrcY3CgVNK9GqNWqO+bjdFvFUU4t8
	tYYI3cjDkBjRABJt8K+BiyPYTODq+bVJzteYsaSu0ytbnxULkxuPN+WsjIl7Xk1o4XzL3dZaDWX
	nbU0U3OBpLXD+vQSILkhNyrGfL8qGmAa9L+jIWbP3iBGoCq7vJ+ibBPzFOVwl2MPr2CUz9dbL08
	rK6Qa/6gSDASdnocDrYHIEJlCdTNzfKl9gWKvlDUMP0XwH4GJQ1Vmv7AUHvL7dHSMtvis4gxlgt
	imuPZ0DgYN4OLt5ZUXQYVBKtudUxfN9PPUiy+VDSr4EH72vdoqNb3Ijir4D7hwI2mf3zs9iBFpt
	2DI2DM8bc8tFKlEb9prvVB8N+GsjQANLU=
X-Received: by 2002:a05:6830:6aaa:b0:7e6:d003:929b with SMTP id 46e09a7af769-7ebf2c5636amr2197385a34.1.1783701452976;
        Fri, 10 Jul 2026 09:37:32 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 07/11] odb/transaction: propagate commit errors
Date: Fri, 10 Jul 2026 11:37:18 -0500
Message-ID: <20260710163722.2962278-8-jltobler@gmail.com>
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

When `odb_transaction_commit()` is invoked, the return value of the
backend commit callback is silently discarded. A backend has no way
to signal that committing failed, such as when the "files" backend
cannot migrate its temporary object directory into the permanent
ODB.

In a subsequent commit, git-receive-pack(1) starts using ODB transaction
to stage objects and consequently cares about such failures so it can
handle the error appropriately. Change the commit callback signature to
return an int error code and have `odb_transaction_commit()` forward it
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 odb/transaction.c | 10 +++++++---
 odb/transaction.h |  7 ++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index b6da4a3942..249ef4d9b7 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -18,19 +18,23 @@ int odb_transaction_begin(struct object_database *odb,
 	return ret;
 }
 
-void odb_transaction_commit(struct odb_transaction *transaction)
+int odb_transaction_commit(struct odb_transaction *transaction)
 {
+	int ret;
+
 	if (!transaction)
-		return;
+		return 0;
 
 	/*
 	 * Ensure the transaction ending matches the pending transaction.
 	 */
 	ASSERT(transaction == transaction->source->odb->transaction);
 
-	transaction->commit(transaction);
+	ret = transaction->commit(transaction);
 	transaction->source->odb->transaction = NULL;
 	free(transaction);
+
+	return ret;
 }
 
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
diff --git a/odb/transaction.h b/odb/transaction.h
index f5c43187c9..3b0a5a78e5 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -54,10 +54,11 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
 }
 
 /*
- * Commits an ODB transaction making the written objects visible. If the
- * specified transaction is NULL, the function is a no-op.
+ * Commits an ODB transaction making the written objects visible. Returns 0 on
+ * success, a negative error code otherwise. Note that, if the specified
+ * transaction is NULL, the function is a no-op and no error is returned.
  */
-void odb_transaction_commit(struct odb_transaction *transaction);
+int odb_transaction_commit(struct odb_transaction *transaction);
 
 /*
  * Writes the object in the provided stream into the transaction. The resulting
-- 
2.55.0.122.gf85a7e6620

