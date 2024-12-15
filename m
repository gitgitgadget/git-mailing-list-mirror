Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A81922D7
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279959; cv=none; b=jilkwLgeRslCeeWEFAFoXd7sK5Ml32mJ87RyhQLtTLaJV1SpbusaQ+iN6O2lB5vb3VJt6t4EPh9Jmvcgkoortrky0EJmNXyOosoTPMu4oBaUXeT0k5HD4Lgz38hKh14x+r7PshAdYdIQrfpVPdH4Ic/1nF3bNGuOZK7FiYQwZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279959; c=relaxed/simple;
	bh=ERhO5bUagvCcVWd1ajCqhTTv/qHXvpyDSomL3moOTTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEWvxYzZC4ngY80RKvn9jNQy510Bl/Xg2+WyCy1gmc1p2Vm/CZefdL2eJB5Lpp5hsNrsm9joBRZPFwJh3Mtw9acjjivNAiuthNgulmH1j7EXmeuH8BehItkuoPILsTsZ2TiKSJIJNS2HNRErKfIdpkC1kpihi/0ZIShzYmzRYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AexyhYG3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AexyhYG3"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso6924791a12.0
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279955; x=1734884755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gNfOmPXL16KqA+CPu0YSmndFRynLUkndelIwKCAq4k=;
        b=AexyhYG3tRZXEXpV63hE7SLakyTOPywUWj7yClHCl/11qZ/Ri0t6jTcrTLSyc6p3lW
         gRkGrg+mqUYaLGk5ZU9ZUaHXMMor8mSgMJRKgq89mHB6XW3Y41GesfJDuyiHYZCX2JHL
         buUtWlahiMRQPay9or5Kopyys/cIXs47GS6Fs7Sj78MrOArIyFVWsxdNQMiJ9SUC/XAU
         wreil9dXmjXOo/NrtEj1Jn8d1kQKtGYa1pu8NcLrHOH7lL9Ktq15v958t0vY+XWtBtXp
         bk7tYS9rWRLr4UsBz3w3gwii4pOCHuvCFPj+/9Dzhl3wHv9KfnTqWI+q8d5pXFMLTzFB
         WmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279955; x=1734884755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gNfOmPXL16KqA+CPu0YSmndFRynLUkndelIwKCAq4k=;
        b=GljMd6i+sud7Gah1cg+VH7nnqGjve5bq4twH3xGyCfo/DhH/Vsx9mASq4HCklpZ6Pf
         H7EBnv44SAuinWVewqOKwxWRMR0Q/fdO1fTVrIfmZUbFCRWZjzb4+7DifXiIH/nNa37t
         llWlDHn8UW89SjN8ppHk6pz5fAuQKohE89lexWzwJ8X70giF86uDe0VYqb5D9D5/Zm60
         njmIgJbJFUWf9cVGFKmuda9BktyxRc2XdNhbGBFEzFNNVx+3ZHNVFcvSwV8OHcl6wYje
         YN7NFhWvVsz+TdLOZiEugZF0ui5+LyntTJXbyWg3Vi5zxzQu/I9OA2IaxWzET5JKAqd+
         eqrw==
X-Gm-Message-State: AOJu0YzTCWfP8kWM+7OTmM0yeunPFOMEVEZJHT2CgijazmjOLgQBx3U4
	h9Nt7JPRanx5daQ8u1hvATBv8lUOuKp2ktSBvCc1K0VVZE6A93FZ
X-Gm-Gg: ASbGncu2FLkN4k9xiIuEUSMo22K7KzZM3I4oWj5CDjohljMoTEavadq7TZedRISJdlE
	4YFhFvP4qg9V32gxoprBWKUdZSLKAL4aSVYqE8kQ+Y5nsPmhJO1wAWqxfWh/G+3iuUO2IqTSLjQ
	6UVAj3JjKQCTqBBML28rIoKFqyT/IuAFnaoKthwWxfSnANWQlv/y60GlFLRZInGwjYbZa3plz/w
	i3tUlp1BJDE6GB3/M0Nr61/Ch3mQ0Bg8giORUqpXeUm8vQyW+LgiKmqRHjLHJ8gfYqOXQ==
X-Google-Smtp-Source: AGHT+IGKxmZxRsH0dk7vo1ktlgWM2MkwGv77SSdjxhYqgeVNVJxxfAmCFXkgupcGBlWLmdESqY5RnQ==
X-Received: by 2002:a17:907:9491:b0:a9a:9df:5580 with SMTP id a640c23a62f3a-aab7792d75cmr840250966b.19.1734279955063;
        Sun, 15 Dec 2024 08:25:55 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:54 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:40 +0100
Subject: [PATCH v3 3/8] refs/files: add count field to ref_lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-3-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ERhO5bUagvCcVWd1ajCqhTTv/qHXvpyDSomL3moOTTM=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMOxxBE3KzCwxPHSm2GTWOF4FpR7q7tkcMQN
 gVL5pSyNiyJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDgAKCRA+1Z8kjkaM
 f1e6C/kBt6GPim/504m37VFnzi/cFOTdbmPihOzwOCnFyHH3Sau45sxfrAs73eEfLDB6OfeSG8K
 C+MZiDDDjTzooBkPDhz6XMEloGNjBM2LT1joiudXyxKh+wuvmmvsPCMOgGJRmaZJ8562JB+qIme
 KP8gL4K65KrY6sv/8/xGgtaTsfeQnELVD9HWZCqHek4K2npBdmjnb632tRv+Ka3iD2UGCMxlK3i
 xErdQxiz33Y0b9YRNsIcjwMGch+1uWiCZ9YR1mc8CWL6lvpguOimwN+CsYMWVMY1LGFtGTUON0n
 a5guYd7xvWV6p4oH9u7Ded8zMXqae2ipVNBBMlyozqigVBO9PSTgCBIloFj6ocX1dWG9i9qmOIJ
 2/gxsd+pgwR9pqHMX6L23wn+tFlyjUTYqgzwwwoj6lSAVtMGJ76YxmQFz1gTa+GpJS7X4SwwByd
 3DqgVsQAr7nuJCO1oC3JvNs4r0+zPJ+Ool/lBGi8J2U8POmdSYZ71iZTfr8TMTpvrCJo4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When refs are updated in the files-backend, a lock is obtained for the
corresponding file path. This is the case even for reflogs, i.e. a lock
is obtained on the reference path instead of the reflog path. This
works, since generally, reflogs are updated alongside the ref.

The upcoming patches will add support for reflog updates in ref
transaction. This means, in a particular transaction we want to have ref
updates and reflog updates. For a given ref in a given transaction there
can be at most one update. But we can theoretically have multiple reflog
updates for a given ref in a given transaction. A great example of this
would be when migrating reflogs from one backend to another. There we
would batch all the reflog updates for a given reference in a single
transaction.

The current flow does not support this, because currently refs & reflogs
are treated as a single entity and capture the lock together. To
separate this, add a count field to ref_lock. With this, multiple
updates can hold onto a single ref_lock and the lock will only be
released when all of them release the lock.

This patch only adds the `count` field to `ref_lock` and adds the logic
to increment and decrement the lock. In a follow up commit, we'll
separate the reflog update logic from ref updates and utilize this
functionality.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 58 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6078668c99ee254e794e3ba49689aa34e6022efd..02cb4907d8659e87a227fed4f60a5f6606be8764 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -71,6 +71,7 @@ struct ref_lock {
 	char *ref_name;
 	struct lock_file lk;
 	struct object_id old_oid;
+	unsigned int count; /* track users of the lock (ref update + reflog updates) */
 };
 
 struct files_ref_store {
@@ -638,9 +639,12 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 
 static void unlock_ref(struct ref_lock *lock)
 {
-	rollback_lock_file(&lock->lk);
-	free(lock->ref_name);
-	free(lock);
+	lock->count--;
+	if (!lock->count) {
+		rollback_lock_file(&lock->lk);
+		free(lock->ref_name);
+		free(lock);
+	}
 }
 
 /*
@@ -696,6 +700,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = CALLOC_ARRAY(lock, 1);
 
 	lock->ref_name = xstrdup(refname);
+	lock->count = 1;
 	files_ref_path(refs, &ref_file, refname);
 
 retry:
@@ -1169,6 +1174,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 
 	lock->ref_name = xstrdup(refname);
+	lock->count = 1;
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
 		unable_to_lock_message(ref_file.buf, errno, err);
@@ -2535,6 +2541,12 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 	return -1;
 }
 
+struct files_transaction_backend_data {
+	struct ref_transaction *packed_transaction;
+	int packed_refs_locked;
+	struct strmap ref_locks;
+};
+
 /*
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
@@ -2557,11 +2569,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = ref_update_expects_existing_old_ref(update);
+	struct files_transaction_backend_data *backend_data;
 	int ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
+	backend_data = transaction->backend_data;
+
 	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
 		update->flags |= REF_DELETING;
 
@@ -2572,18 +2587,25 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			goto out;
 	}
 
-	ret = lock_raw_ref(refs, update->refname, mustexist,
-			   affected_refnames,
-			   &lock, &referent,
-			   &update->type, err);
-	if (ret) {
-		char *reason;
+	lock = strmap_get(&backend_data->ref_locks, update->refname);
+	if (lock) {
+		lock->count++;
+	} else {
+		ret = lock_raw_ref(refs, update->refname, mustexist,
+				   affected_refnames,
+				   &lock, &referent,
+				   &update->type, err);
+		if (ret) {
+			char *reason;
+
+			reason = strbuf_detach(err, NULL);
+			strbuf_addf(err, "cannot lock ref '%s': %s",
+				    ref_update_original_update_refname(update), reason);
+			free(reason);
+			goto out;
+		}
 
-		reason = strbuf_detach(err, NULL);
-		strbuf_addf(err, "cannot lock ref '%s': %s",
-			    ref_update_original_update_refname(update), reason);
-		free(reason);
-		goto out;
+		strmap_put(&backend_data->ref_locks, update->refname, lock);
 	}
 
 	update->backend_data = lock;
@@ -2730,11 +2752,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	return ret;
 }
 
-struct files_transaction_backend_data {
-	struct ref_transaction *packed_transaction;
-	int packed_refs_locked;
-};
-
 /*
  * Unlock any references in `transaction` that are still locked, and
  * mark the transaction closed.
@@ -2767,6 +2784,8 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 		if (backend_data->packed_refs_locked)
 			packed_refs_unlock(refs->packed_ref_store);
 
+		strmap_clear(&backend_data->ref_locks, 0);
+
 		free(backend_data);
 	}
 
@@ -2796,6 +2815,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		goto cleanup;
 
 	CALLOC_ARRAY(backend_data, 1);
+	strmap_init(&backend_data->ref_locks);
 	transaction->backend_data = backend_data;
 
 	/*

-- 
2.47.1

