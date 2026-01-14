Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3D30EF6F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405270; cv=none; b=B9A173k442cHv3sEOv9yAAzLdLqtUGAUlqpVkeygqw/0Xi0uWpOM3eqUcZd8MJX5sNzWMypCbaSGcOYv38lfoVqwE9431moSpsjmym+5c52R3n5hPEGGNn4z4b4f39cJauLyY56rMPMJozaJLrXK+kQaA4WQuh+eUX1v86vq2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405270; c=relaxed/simple;
	bh=QVBnIOTdSDFH/RQ5xMs0LvwUdZ+iWMR1dDVtSn105NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwid0CN8oRZusB+QVKdpG4N8feVANQWY9BnsD3vGxpyIa7B5cvqYN6yI8iZj8lMdwQeEF+o+jPh/oGvO//AOFCj0t+or4Rl7pl7PciM5z45SL9p2KzTSRJfeNuFJTW+bg9LrZaCSp005IwLMxL0dmEJG4tsuiP69J3o+tvd/Ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1cUNtaI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1cUNtaI"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8707005183so592909466b.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405267; x=1769010067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHYprR4AostEQEEpUMkEmt7Jk9d/UbTBelrGOxVfF/s=;
        b=l1cUNtaIddMZqHGtdd1T6GRlsrVfhtmdCb4GXCh0VqYCXS0E3bbrE7UhJBX+7D5ALb
         1EMo2c0x94Uw9gR/fFvEESnc15xSJ/S3AahJ0ymts+HAwgn70diCgiTFyy09MBlKb9bi
         IOtxlVb2zugPOKx4GxGh3dYyF976UQSChXNyoQB1nyfM+iymqi/2KSgNBwP3R87xk58G
         IppfHRJpBMEJCU/ChS5opGwxZ1mq505R8GiXT5pXQJj+DSQS93xmdqWyYYSjFCubwpN6
         J3dXDhW5fBLP3mpaz9lZ9EOTRsm/X0BCp1cbzh2bva9rmzo5BzVp15+KYvmJ4WDXgx81
         kCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405267; x=1769010067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHYprR4AostEQEEpUMkEmt7Jk9d/UbTBelrGOxVfF/s=;
        b=DritFZRdO3TSjDFNG/qIz1VaBdA9wkF9B2EGXNqupW8JKycYcgDaKHRpkMBm4RK2DW
         jppgSBhr9gy3N1IueV22WZ78LrYYnmBez+LVGtvwUicyesoo2Hw8/6WCkTrInNEUj7po
         W8k5ONws2eyt10BG9LMMahFwFQZU8OZABCYZdyoAR2bHNI9dXMh16NZKNKDLKWoUKFGV
         cYKF/tpyVwjDikLzokvjif6/4EO/wn7WsrsWBw/5u8PW345iGLYMD1b48TkcqDeMGGlG
         bFXB4EsJXCvoh6d1nD04kkZAedIYMf8R9JnmlUUeVPqD/Jt+nkkoeKFQjzMUhsXoTF4A
         Z0PQ==
X-Gm-Message-State: AOJu0Yw00elVqLgxH/PEfWlBBnhUa4pPL9b/mgv/686C3vwObo9wgwxO
	L9qxqVV88MSnHHcbuknatjNqWQN1qNxr6tqk/50QNIWkqC9DRo5fjGVM
X-Gm-Gg: AY/fxX7UuhavBpfkYWNLpTVrwnrO9iTnuks+iYDdHkScYETZ/FWdyALxEdIXiEHbpPB
	mpy5QbE6JyNKElfkhCHSZCz7s+SxnRhLLsXiUE3DeO76DpmVAlrQBFO0tGbzAxM0u3sY/HPiAza
	7f99K/bR3VgJrY4WIFperlZXRDQLWYcvjmArmW5Zz6hCahKUtjHNgB6UpddtjI8y1G4DQhhtMGp
	Klu2Dmxd88P04wNsf4uu7DLShth189EXyu4ZAes3DC6M0oCnlQ0ayJFiOq/cDPuk5FW1Fhq4R8W
	iFOornclQwq2oMc23kKtEuHhanWMhowJXWhG7xYPnkqFJQ9yQzJ0amY1Q4viahcRQi/bqHN8zfz
	X/IARV6EGlsZnzXXgYawO6efPkS1sjp9pV8lJJBcxin8DIukpUo3lffclpuD9MUpvcSCw86DbAS
	TkR4UEr6YqWDSqtN0VFJM=
X-Received: by 2002:a17:906:7312:b0:b79:f8ae:a893 with SMTP id a640c23a62f3a-b87612c0de9mr230533166b.49.1768405266998;
        Wed, 14 Jan 2026 07:41:06 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Jan 2026 16:40:43 +0100
Subject: [PATCH 2/6] refs: attach rejection details to updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-2-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8874; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QVBnIOTdSDFH/RQ5xMs0LvwUdZ+iWMR1dDVtSn105NQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuQ+Ys6XycvGaY5NoKTbgD6aGCXyCczK9j
 JcGt2r+XMo0kIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kPAAoJED7VnySO
 Rox/IO8MAIhgk1VNwErX84OTIwKbJRpULRydfnAFTkzg6ObNHoEyO6lEJWpqUSx3QbPopx4F0yw
 VbS+fn0nAAc1ZCe6RAbcaLXOZsMsEVydOO0Mv/ANhhbnPyzL6ZBP5Kqy50cQVE+wN8c6Gw2b0hv
 GToGOD2KAyD3W3ojzVRAluineBjytZG8maWIYRGU760jcGuTDIGW8tNx430P7afyU3/FWiD8Fkr
 EbntSjxrrY038cQQouwBqmo90xEUe89TjJp/HwouaCqH0+smZMbFEP29zhBu5MrmHFIljNjdUje
 wtwioGybTuD35d8MoGC9SlXG7SRkaYpakz02TfeNGW5EkwHl5gAQ6ac5vt/FeystTWdGXmS3oj8
 xAV68d1GtZk248qSqz9/InrIOhmJ4um2bJU9QnskvkTlbSqsrAe15tsHUbL7OkvrVaKiZWfR5UH
 GJmQCgHlQzhqIhjMR0OGjIsOnb/62V8LaeQiEVqR2I7hlo2j+WEf+wq+WUQ2oBLAjobiYdMF9g4
 OY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The implementation of batched updates in 23fc8e4f61 (refs: implement
batch reference update support, 2025-04-08) added rejection error codes
to each reference update. This allowed batching of updates, however
while each rejection is linked to a rejection code, the already present
user readable error message is simply dropped.

Make necessary changes to ensure that the rejection detail is also added
to the reference update. In upcoming commits, we'll utilize this field
to provide better error message to users, namely in:

  - git update-ref --batch-updates
  - git fetch
  - git receive-pack

We move the error message creation right above
`ref_transaction_maybe_set_rejected()`, so that the error message is
available and also reset the error message if utilized to avoid
un-expected concatination.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 52 ++++++++++++++++++++++++++++++++-----------------
 refs/files-backend.c    |  3 ++-
 refs/packed-backend.c   |  9 ++++++---
 refs/refs-internal.h    |  4 +++-
 refs/reftable-backend.c |  3 ++-
 5 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 965b232a06..991bd8e6ee 100644
--- a/refs.c
+++ b/refs.c
@@ -1222,6 +1222,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
+		free((char *)transaction->updates[i]->rejection_details);
 		free(transaction->updates[i]);
 	}
 
@@ -1236,7 +1237,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
-				       enum ref_transaction_error err)
+				       enum ref_transaction_error err,
+				       const char *details)
 {
 	if (update_idx >= transaction->nr)
 		BUG("trying to set rejection on invalid update index");
@@ -1262,6 +1264,8 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 			   transaction->updates[update_idx]->refname, 0);
 
 	transaction->updates[update_idx]->rejection_err = err;
+	if (details)
+		transaction->updates[update_idx]->rejection_details = xstrdup(details);
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
 		   transaction->rejections->alloc);
@@ -2657,30 +2661,35 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 			if (!initial_transaction &&
 			    (strset_contains(&conflicting_dirnames, dirname.buf) ||
 			     !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
-						       &type, &ignore_errno))) {
+						&type, &ignore_errno))) {
+
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    dirname.buf, refname);
+
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
 					strset_remove(&dirnames, dirname.buf);
 					strset_add(&conflicting_dirnames, dirname.buf);
-					continue;
+					strbuf_reset(err);
+					goto next;
 				}
 
-				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    dirname.buf, refname);
 				goto cleanup;
 			}
 
 			if (extras && string_list_has_string(extras, dirname.buf)) {
+				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+					    refname, dirname.buf);
+
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
 					strset_remove(&dirnames, dirname.buf);
-					continue;
+					strbuf_reset(err);
+					goto next;
 				}
 
-				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-					    refname, dirname.buf);
 				goto cleanup;
 			}
 		}
@@ -2711,13 +2720,16 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 				    string_list_has_string(skip, iter->ref.name))
 					continue;
 
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    iter->ref.name, refname);
+
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-					continue;
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
+					strbuf_reset(err);
+					goto next;
+				}
 
-				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    iter->ref.name, refname);
 				goto cleanup;
 			}
 
@@ -2727,15 +2739,19 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 		if (extra_refname) {
+			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+				    refname, extra_refname);
+
 			if (transaction && ref_transaction_maybe_set_rejected(
 				    transaction, *update_idx,
-				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-				continue;
+				    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
+				strbuf_reset(err);
+				goto next;
+			}
 
-			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-				    refname, extra_refname);
 			goto cleanup;
 		}
+next:;
 	}
 
 	ret = 0;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f6f76a8d8..8d22a2e8e3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2983,7 +2983,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
-			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+			if (ref_transaction_maybe_set_rejected(transaction, i,
+							       ret, err->buf)) {
 				strbuf_reset(err);
 				ret = 0;
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..535200db01 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1437,7 +1437,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    update->refname);
 					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
 
-					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+					if (ref_transaction_maybe_set_rejected(transaction, i,
+									       ret, err->buf)) {
 						strbuf_reset(err);
 						ret = 0;
 						continue;
@@ -1452,7 +1453,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    oid_to_hex(&update->old_oid));
 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 
-					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+					if (ref_transaction_maybe_set_rejected(transaction, i,
+									       ret, err->buf)) {
 						strbuf_reset(err);
 						ret = 0;
 						continue;
@@ -1496,7 +1498,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 					    oid_to_hex(&update->old_oid));
 				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 
-				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+				if (ref_transaction_maybe_set_rejected(transaction, i,
+								       ret, err->buf)) {
 					strbuf_reset(err);
 					ret = 0;
 					continue;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..60d9f015cf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -128,6 +128,7 @@ struct ref_update {
 	 * was rejected.
 	 */
 	enum ref_transaction_error rejection_err;
+	const char *rejection_details;
 
 	/*
 	 * If this ref_update was split off of a symref update via
@@ -153,7 +154,8 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
  */
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
-				       enum ref_transaction_error err);
+				       enum ref_transaction_error err,
+				       const char *details);
 
 /*
  * Add a ref_update with the specified properties to transaction, and
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4319a4eacb..a9c9ceebf3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1401,7 +1401,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
 		if (ret) {
-			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+			if (ref_transaction_maybe_set_rejected(transaction, i,
+							       ret, err->buf)) {
 				strbuf_reset(err);
 				ret = 0;
 

-- 
2.51.2

