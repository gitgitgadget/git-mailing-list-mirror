Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECF1BFE03
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086217; cv=none; b=Gsq8qo/m5BnLO8GAkrDl3wEcbI6b/7DDWFtDHCqhuMt+bBvgsXBFTrfiejBuqbz2Wp/ave4dyalPZmmBQsprACAnco6FJXZY5dGhnEbGju2tGTGeFvPaS/xluaDw/wnooHPU3CnWVWJr3fHfotZXfbm8c34Tb90QPWQ8JGv4WZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086217; c=relaxed/simple;
	bh=ERhO5bUagvCcVWd1ajCqhTTv/qHXvpyDSomL3moOTTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHB9eLmwEOeETdqwJ5IBO848cAr6FHVAu1c/5s3LSC2oEw/BSmochdvi9u8BMJGry7W6L1Ha2PYEm/2dAsTS45rBXOTJFZvm6mMWuJLIc1LjfCu4MnuPUxgbOoudtVlKkxeWa4GnqvVELRZRLOdHoaWLBBae5/7oUsh2qlJI9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6/LZF24; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6/LZF24"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so5218822a12.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086213; x=1734691013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gNfOmPXL16KqA+CPu0YSmndFRynLUkndelIwKCAq4k=;
        b=g6/LZF24eZZOfJrx7j7rlSwID3hngJJZnjPoU7YemcQQLR1pABEmSkm/QQ/shmQYEy
         jopQSPy6sprioPSj7QXgVET6dJZfQ9H7bmXWzl5Wm51f4yTHfP7o1b9Ji/rTgngaWNkW
         n8pBM2cokOqMPvjrmSmFMUeSKHbdbm7+84wM3UgF9j3smHg6Hmcmi+gHR3e0YExz/oRO
         bngZ9Ds1DRoCSNZEBL32QPTZAas6aJul8PZ5HS+5VDJWqwBHU8dT69QNvzP+IP5WJ10k
         i8717yEZjlcboP9/YXOdsByA2ylvc/XuH4NYNpRMzr8QkUGWi2dfNLvEhket4GLH7c5A
         mxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086213; x=1734691013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gNfOmPXL16KqA+CPu0YSmndFRynLUkndelIwKCAq4k=;
        b=reERBam5+VfFShSPEh7etaQJMlUuh44cC7C32Xz9ESdDOjLEOrNe48dggd1SVYUUVK
         hpR+aCVOtYiK2y4Fq6ma60Tp6e+v16vkOfP0QazK6LmaEXpV4dXlOBBHnCe1tkqPhomw
         GEno2zdgktowDpuHnS9+s+2OupcfchbZhkWb9RzI+/yojvALAoOfB2tgHsmKjq/zfcxy
         JbrwD6Zpa3UmxWY/bPEjcVuTeuGRlghveGA+fJh3spaLLGgUimKOCxdEDTanFN6YWq7+
         C8259IwG5VhSdbje3ywYjP3RKwmLgeYnlr0CTDypc86vNPYYQ4dQetesfbv/IjsMd5Lk
         AUiQ==
X-Gm-Message-State: AOJu0YwhLORCWZrT8kayhHxyyM72zgjOP6WIVU4tiq4hRkMR5qaMDaiF
	ozuAyPKZHDiOncI1YpfruZ8YkTrglV2oJctDTqK33pDMU8wRmiXU
X-Gm-Gg: ASbGnctzefEMirD0ygKo8hZpaXWSzTpIveKsPag657J8faTaSeI59r9OyDdzbTuISuU
	gh2GNzbqAXyKKfXt9m6qdAdKiQHVDVKTJ/TXHPpQK3WqLnTzXHUDmvw4GRTstTXrGutp8/RRPIM
	VLkote1AfExfy1uArZy67uJPaM+0yi6pvSy4LM2TrieSwzlzvtSe9JNMKn0nrRyNJas8aCMtZ/n
	jbuH8owtx14aMgW6xHQsXwU0CjD8VRH0voh+5etulW/EDsICRm3kvIWk2c8yc5lrG74Gg==
X-Google-Smtp-Source: AGHT+IFqGOv8SgIjyhXFKeUndVDGplwQvUWhqgL5D9EIrZETyhjsw2DFSBhZRqZu3bkh8u9umWcVlg==
X-Received: by 2002:a17:907:7e92:b0:aa6:a9fe:46de with SMTP id a640c23a62f3a-aab7b777564mr189714966b.19.1734086213335;
        Fri, 13 Dec 2024 02:36:53 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:53 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:48 +0100
Subject: [PATCH v2 3/8] refs/files: add count field to ref_lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-3-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ERhO5bUagvCcVWd1ajCqhTTv/qHXvpyDSomL3moOTTM=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5AtUAbbN803ICOyPKDnHQBP9z8G5c0kFS5h
 L0aDzeDtuKJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQAAKCRA+1Z8kjkaM
 f4PPC/4oxeHHeFFzbQdmjvLnIzINPSJXSL4PfzIvZq6lZbZVw1mHwV+54w98e0DASm08wFNkBOM
 DEspVSEANdUVwiJCtX0QX62DLnawkgsVp6aiYoK7CDjG63opmsDtkiINNWuWpY7NwNNt7M0mREs
 eUYefblq+/oRss3hFpdkU6msfdVxJRXMGrz4uQDTURtwn10yd8ZcQn8tc5E/5YnQ4/ivuiBy7Xe
 akkXHFfskr/c3XuAB3ZW9QmBpJlnPlNUeMsdDtc7TNnOLLDrBrVfmP6Zgl/p3eCJS67DruEDzJ/
 FMLfudwCMYMz+JoHQXQhxtnaXAUJuxW1GYjkghjqklxRhNAKS7s8UYBLB+e6VpdiLZns3vdbCUN
 hfy9X4XZTC4aNFHUDlrb7vdLLmJG8GB+5au9UYMVWBiy3/F9tvWziaMB0deh0l8CdnB0S+cFOld
 knn2ft/XGsGjpslCtpRK5gudwxgQF05yF64NA3WQffGX6a9EOHsAoOJENRSDmzNURlZ10=
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

