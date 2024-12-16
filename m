Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727A207DF1
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367481; cv=none; b=VZZ9D3yTMFYA9OYNEuTbd/Y9gjZDO1A/TbMpXRbyYpEHfpdsMi3lneo7Uc4g5/S0S47XPie+U5KjkJxNvRFi2F3NBSZodVOHB9TfLw8oBkNf7TdP+v21fqdKO0VPVNiMGqPA1A2OClPGj8ohTWc7E+9aeSvT69o6pEOudNz4dS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367481; c=relaxed/simple;
	bh=ERhO5bUagvCcVWd1ajCqhTTv/qHXvpyDSomL3moOTTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlfW4hc7nRY0nizM2kqWek2jki4K+dB3XMpHiP/S5U+o0fSvMG3qoW1Jgsaj4Bn9BWrZPJvfAfolfH7EkJDooRKL0Tuvcgy48OooPhaPnt91kgIlUxOz2IwBqtdpPrjNm+//Eu9pr/qQ6+ct5abg/o2ykHzBVunJWIc3f4vOSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ5N1k0k; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ5N1k0k"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e8522445dso881754966b.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367478; x=1734972278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gNfOmPXL16KqA+CPu0YSmndFRynLUkndelIwKCAq4k=;
        b=XQ5N1k0kAM4v3Syq4hsqah1jDAcOidl+Yv5RqBwaVhwXgdTfMSTsxTe3AJh8Tik60k
         i33sP2HyxhD+wpb2yJuMAXi07k6pKr1Ukfo3c5WnTqi1QKxo1tmje9aDt+lHCP9o/l06
         pGsLDUjTWLk1/OfG9prhqMS3e169vb8xc2ce5MZLJnUQrbFBrFFSkmzCFP1Ph84sDUl5
         6Xc7fWmmp5uEEufbj4ctVu+Tp1hwG6jMkyy9VVEORoEAvG27hNR8Kno7mGhpQ9NIZ6k6
         MqgiaPagdukT3ia7u2HLN/0Z8UQiJzFXjR1LJfRlA8UapsZQubt5gF6RzLE4teFYMA4P
         gurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367478; x=1734972278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gNfOmPXL16KqA+CPu0YSmndFRynLUkndelIwKCAq4k=;
        b=AYivDwyCaeJ56SHsqbGjNHOavfYWZVmK7zAd/2N0Sb29zx74xB+jdufogqlqfIDwnL
         fevjtrl/TmROaat7so+gGkAdrbUIMJ+ddtu3juYKCw+nx9W4mXWfRBiYRDsJFmn/sUe+
         Hj8nQqpEgiZSr11wvTlUfN3EGPa9Gt/okuCiIL62tl3GF2yVWrjSV614B8BM/X1iTnhm
         KvEMAc0U7mH49reBVBZLYOg3tc1p+P/71pyqTdeHHdTzWclMC/dmJdeEvivquw1cppRi
         WpH6BN+11PhQJu4kYXJBPKG97//dwAyowtGEftxdPxzSv5CyIFwou1WOTIor7E0mi6sX
         2KWg==
X-Gm-Message-State: AOJu0Yz8UZQGEPp+BMWsLS/cgeyyvk3M2MOezTOPykJuLZIhKoAdV08q
	ba/cZV0NMN1e3JcaPkbxX/dG09xzl6QPm9U25Y3Zx0bxAFCjmZ0wcOX9JvL6
X-Gm-Gg: ASbGnctnWOrL9LTUiYWnfreV7UowEmasiEMQ61STk3AGnDQIwXswG7zAJq8ULCCsmjD
	+PEJV6sU4h/KCmPgteF+odH00ZpyOGwPwQkR9IuHHG6IKVAkZg+tj8KmxsH6GAxDsF7FS3Tjnj+
	xcir1GLaSPlaWLJNyZCVidGijvE1p1gBc5rTv6DeGKNgUiZUpztFBxMUp0GNhqbEM50DHPk6D0t
	CsZJbT8M14Gj2qcieE0qXbHZG1KNsyYl20MgaGuwrMAsXA1wANo/sTK7to=
X-Google-Smtp-Source: AGHT+IFA9qXAzllvbSArLN8cs6ZnI6rZIBWJfQDxk29LLtPv4xtlt/y1g1sjhIADmvTuBCXdyhaX4w==
X-Received: by 2002:a17:907:6d16:b0:aa6:8f71:1645 with SMTP id a640c23a62f3a-aab77ed35abmr1328044866b.55.1734367477373;
        Mon, 16 Dec 2024 08:44:37 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:36 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:28 +0100
Subject: [PATCH v4 3/8] refs/files: add count field to ref_lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-3-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ERhO5bUagvCcVWd1ajCqhTTv/qHXvpyDSomL3moOTTM=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwyVryaUgb+HLymh3pJc+6LHCjlUZ54L06Z
 EePezgdKy6JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 f2znC/0bk2EBNO6tvIKJxG5exJFEIZOzOVC0VndJSiLk5K5oYOdXxw/DkZ4SxkhDO0y8aB7nBrU
 3H1lqIoOusdI5BM0nOWD1YaAYbBoq0i33lutPiP8t10vwJ6OdWZ//s/dHbVmUl1VF57IF3lWBnr
 iqtJQ1jInjo3oDJRfjTNhNFECPNApfF//2FD8zJ94jy9iDvNFbPVlS5WvpDPO7992Pgob0ydsH+
 0KjGXcl6TFtBKvtdGmYusO9+bdHHxLGJkeiur8TU02sW+NtbosrYZH/TYQpSHfmGw1/w8ARZVuf
 eOO8ta7SGfvb8JFcbhzjXf303kf3DUWsKVtRs5DncXetVWn07mr8Rf3cgrRIXo4zyRZFT9DBi3S
 PO96J+KKVRqR3wEHaPOSzyDRHDWoNzkm/7PccjL8Rctu8G1c9IA0qKxlggjPvQ1AgfFqH1kmOOP
 iWVD2HXpfLXxi8DPNSzCILDvO8T+dKejHwzqureW8E6Fc8Zpicu3N9iYnxIHtwSFj+NPo=
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

