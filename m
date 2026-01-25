Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8842F3622
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381568; cv=none; b=OA0kUW6BbcNZ0fP3S/kllvjyu95hgu3jAQE3PtjOiT8zqLnm91Njb/lWMtQo7rjs4PvJHOyvFPcx++nSLvXakOX1Vj6qMy3acRTjw9fm9DNOLWcXcQmImhTFg+UmvkIjMD31/2FznHzNDoPvCuuyf4HkRiNWUYsE4r9cxYNzxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381568; c=relaxed/simple;
	bh=mUw0osWrauMoRV2LbT2u4ai1pjyKhjNkBR86WXKflnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3z23i+z0HNFOvsPsWT2x3ogNvaQXYxE894FtsMPcuNXfI/j3F7phTDwMzSd0BETo5T0IFAE24S4kA4EEVnn5XfIkdQhj3pL1/dVRjY1XP8saAfBWMHxSuEYaJ7R1E3TWqDW57vO42aVtT/q9FSU5GGhQYTe5k+f5UkDcRMfX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaZ/1D2j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaZ/1D2j"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so41584725e9.2
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381565; x=1769986365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyfcSpEP9FGiFI/wolCmRFJytAQUEBDX0gITcSUj2g4=;
        b=JaZ/1D2jLuRIxpqWo6xpW84CGX/UVZmpxQkCDZxZQT9Pas2L/DxMCgiqPjO7twowkj
         uQ0Kz5TUy8Z5YirxzMcCwiKmXsOgH55+m73vZ8ftCgPeWVI2Tnx3gFsuUVbVEUYCqUxB
         4mflJ8Tlph0z+HgeEis6Soknzh1Q3ZpuL6K9sTkkPLtX4WXgufFOkq5polE7KZ61rIen
         vQl0aPao7XEhU+Rhen6yn6QO8N5zIvAs09647vrTKuMyCOF7nh/3qq9vSD6VNqcF1Y6p
         hO1W+h24j7e1k2Fb3XPhCEzYVvRmnMMkGmG1MKtQJUMeAvMB/pp/xDNjpXxEzsMCXkil
         8P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381565; x=1769986365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyfcSpEP9FGiFI/wolCmRFJytAQUEBDX0gITcSUj2g4=;
        b=FaeklxER8qKOwIQfPwN+QEIaBPLGzMHqqQlwDeiYlLYxogpDTN8Nt5mAUwSvQkCgyb
         o0VW7iNzM2vfZBEBZ6o9bNoU84lgP5QzJOvY6HhPZIiuUWd8Bq/4vxrxZvk7PyXwIli8
         6dU9KOEVO/c3Dq63ncSbXhgRwZsUvpwgYK2Kgu1e167uUQ91PT08gOW0T4ZRG9vwAjmq
         gBy4Ndh6WM+3WNRViXNAI1jjKtJpKe96hCUqj0kGfDHaiaZQTCeqqBMc36Uuta+az08z
         Yr/KJ/7q4TVrP6ei4gEMfcVrkoMurFvvU1Mtwpmrsw3OE4EsTdHzM1YpOBBOjcpCbWXz
         p7Kw==
X-Gm-Message-State: AOJu0Yw8ZYl9GrvrW/MdOluE5O65l/ps5NWsNnynkOeyGNdS84J72aK/
	lnQ81XOXDKOvY6mDsBaRmtxgCA7yPEF4/OK8q+39QISn3o1y7za95Onl
X-Gm-Gg: AZuq6aJDAEgYtEfBvpG2j9HFMFBtJUDyCkFhvRP9Pmg2gZc+e5rC+YfvkkqQyGBEgQc
	FbVBSOzVrlcvCEvf2k5O74JvG86we22xG097HF/m4XmYYM16fwUQQS0rvTLvKEVYCcZC89koQCh
	cW42rbItwMYbwI97eU5K2NN1etA0hVLNoCQVm5Av41Vvg64855hkY/OmlQq1t7WYj7VS6El8hSz
	cXzS5oN23dJ+XZZcvqAg998Xf58BJgACN+m/GzbP7JwFKr894Gy//3ErnQ0azwaGPfMSCLQQKul
	8MV97eiB9TnXtTtVs/lTom5/TkJPR6S+VI25UDLKkTWzXwT9LxRt6y4xp3SFC7gTf8ltz9jjs/N
	VVfoRxYGn0QSgGobQElTyV6kLDLp/bavk+TX9Tc3K6J+jhhgtUktKCIMS2Ug6Db4D9JcsFMilPP
	q6AhXC9m1VX9xC3Erh3g==
X-Received: by 2002:a05:600c:6343:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-4805fb0164bmr16333815e9.13.1769381564400;
        Sun, 25 Jan 2026 14:52:44 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:43 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 25 Jan 2026 23:52:36 +0100
Subject: [PATCH v5 1/6] refs: skip to next ref when current ref is rejected
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-1-d58f3a9edf98@gmail.com>
References: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
In-Reply-To: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8568; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mUw0osWrauMoRV2LbT2u4ai1pjyKhjNkBR86WXKflnY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nrd9hC3eR4TGdyc42hu/tash7tvORTziO
 lbY40d19zrcH4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp63AAoJED7VnySO
 Rox/nUsMAJwht6j21h2nDhfK9qB8TEpmKx4CmjoltqwFFW+0vTNZHKSuOpl0/d1XTynwUd3p+2o
 VUFlxn09IDvcjCayb+fGq4jVHGNJL2MCvRfjASK6NBC3Gz8UT7b8IH9lRS1x/r3zogLrt2CZr7d
 uced63HxnBpLn1dZtwpZp4r8njs4Rd6OHxCEIta2F/XuT6g054OVqWTeC9UNCPaB201OpmmCc2x
 mXlGycUifXFFHknn4HPiKwvsCTwp5lLd8uFkfCvTTe3b0PUOmdRuyLc4hQ+6IDVlvCAZq9uo+ZG
 S2bYSpzDmWkzuX8Gfk26XSDSCqtXQBI/jMa4sVxVa94Sr+QxJxSgUsmhg632mL+XRUrxB1DOEaP
 WHUK5eYOB/1zhAPd9Ff0uLTzekPJTvHXzlU1SNzAZvHcOFZYoB4aU2kzD2wwieslmmkwNvJWWsN
 B2/QG88K7qwigbbNfE+iDxXA0n6zrdqjG1/1V9M3PCfwdohrS4Dta0Lcly44a/CG54r2vs5qQC7
 3w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In `refs_verify_refnames_available()` we have two nested loops: the
outer loop iterates over all references to check, while the inner loop
checks for filesystem conflicts for a given ref by breaking down its
path.

With batched updates, when we detect a filesystem conflict, we mark the
update as rejected and execute 'continue'. However, this only skips to
the next iteration of the inner loop, not the outer loop as intended.
This causes the same reference to be repeatedly rejected. Fix this by
using a goto statement to skip to the next reference in the outer loop.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 44 ++++++++++++++++++++++++++------------------
 refs/files-backend.c    |  5 ++---
 refs/packed-backend.c   | 12 ++++++------
 refs/refs-internal.h    |  4 +++-
 refs/reftable-backend.c |  5 ++---
 5 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index e06e0cb072..53919c3d22 100644
--- a/refs.c
+++ b/refs.c
@@ -1224,6 +1224,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
+		free((char *)transaction->updates[i]->rejection_details);
 		free(transaction->updates[i]);
 	}
 
@@ -1238,7 +1239,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
-				       enum ref_transaction_error err)
+				       enum ref_transaction_error err,
+				       struct strbuf *details)
 {
 	if (update_idx >= transaction->nr)
 		BUG("trying to set rejection on invalid update index");
@@ -1264,6 +1266,7 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 			   transaction->updates[update_idx]->refname, 0);
 
 	transaction->updates[update_idx]->rejection_err = err;
+	transaction->updates[update_idx]->rejection_details = strbuf_detach(details, NULL);
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
 		   transaction->rejections->alloc);
@@ -2659,30 +2662,33 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
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
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err)) {
 					strset_remove(&dirnames, dirname.buf);
 					strset_add(&conflicting_dirnames, dirname.buf);
-					continue;
+					goto next_ref;
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
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err)) {
 					strset_remove(&dirnames, dirname.buf);
-					continue;
+					goto next_ref;
 				}
 
-				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-					    refname, dirname.buf);
 				goto cleanup;
 			}
 		}
@@ -2712,14 +2718,14 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 				if (skip &&
 				    string_list_has_string(skip, iter->ref.name))
 					continue;
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    iter->ref.name, refname);
 
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-					continue;
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err))
+					goto next_ref;
 
-				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    iter->ref.name, refname);
 				goto cleanup;
 			}
 
@@ -2729,15 +2735,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 		if (extra_refname) {
+			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+				    refname, extra_refname);
+
 			if (transaction && ref_transaction_maybe_set_rejected(
 				    transaction, *update_idx,
-				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-				continue;
+				    REF_TRANSACTION_ERROR_NAME_CONFLICT, err))
+				goto next_ref;
 
-			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-				    refname, extra_refname);
 			goto cleanup;
 		}
+next_ref:;
 	}
 
 	ret = 0;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f6f76a8d8..6790d8bf53 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2983,10 +2983,9 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
-			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-				strbuf_reset(err);
+			if (ref_transaction_maybe_set_rejected(transaction, i,
+							       ret, err)) {
 				ret = 0;
-
 				continue;
 			}
 			goto cleanup;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..59b3ecb9d6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1437,8 +1437,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    update->refname);
 					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
 
-					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-						strbuf_reset(err);
+					if (ref_transaction_maybe_set_rejected(transaction, i,
+									       ret, err)) {
 						ret = 0;
 						continue;
 					}
@@ -1452,8 +1452,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    oid_to_hex(&update->old_oid));
 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 
-					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-						strbuf_reset(err);
+					if (ref_transaction_maybe_set_rejected(transaction, i,
+									       ret, err)) {
 						ret = 0;
 						continue;
 					}
@@ -1496,8 +1496,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 					    oid_to_hex(&update->old_oid));
 				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 
-				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-					strbuf_reset(err);
+				if (ref_transaction_maybe_set_rejected(transaction, i,
+								       ret, err)) {
 					ret = 0;
 					continue;
 				}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..191a25683f 100644
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
+				       struct strbuf *details);
 
 /*
  * Add a ref_update with the specified properties to transaction, and
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4319a4eacb..0e2648e36c 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1401,10 +1401,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
 		if (ret) {
-			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-				strbuf_reset(err);
+			if (ref_transaction_maybe_set_rejected(transaction, i,
+							       ret, err)) {
 				ret = 0;
-
 				continue;
 			}
 			goto done;

-- 
2.52.0

