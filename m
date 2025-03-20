Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE52221549
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471060; cv=none; b=IcEZZTvV1PEoCHCLECauVF/jEOR2AFcFxqEhxMLnQQj5iwgswlXmaBdv/IOudLgEnug2ix/fv5qVZTV3TtWyTOpg/FxlGaLi9LKABeMEk5Z+3F7Wvv1vTtD+cg68srJjo7ewhQnmiZC478jr3N1flLTt+rSjti8tz43z6rqtQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471060; c=relaxed/simple;
	bh=8ZsMujaDpjPPaYMES2lU+Ru+MkbZzLrRLtuL2oGfSgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qo2YszIRCFFh94jmSeXV+3hNZRQQilCw+6M0AmlAURDizZja4Ly/Ssj5hZo5pd+qsdRe8u1RAdykENa1fpkUVluZFyUh6SiscN2xRANUk0NE2ExT5p68vhkJRSRBmzoi8DOeVSSXD3RSduA40bqMR+o8Y7C30NHoJoDO3FG1cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj869yxD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj869yxD"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25520a289so120301666b.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471055; x=1743075855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqFFZzl+ofbhCJL7ptR/8r3QeKnWpYZEu8TTk8lHIzc=;
        b=bj869yxDdkFtTCwEWIYciw/AwPpP+cjTvq0M5hKNQ807eq/+SqF/xgLCKH67673Oyc
         JS0W8asuFBzBQEVC4j2lci+y6EgfGXvNqTSJhlzIIF3iocZdLB6O6jeD1KObXfTC1eza
         XTom1U6O5zUfLmCBIDrIFTNscVPNovvMBvAv4+3X3toaizat9eKa1Z3TwRBsbchfPAia
         NyUEUto1Eec89OixWugw0Cx/8nIOyhPzRLf7WGlLNm22zXuujmxycdWwfQqq+zKUayU1
         N7s2M5aYJUAWniLHq9vzA54Y85boZfQIOj+CcEv7HSMqggxIUqdo/OpSXYcg1jIRy7fK
         7q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471055; x=1743075855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqFFZzl+ofbhCJL7ptR/8r3QeKnWpYZEu8TTk8lHIzc=;
        b=QHiEnttuX7OCaxf4FA+oI0sDzAO42OCkmZEh3meOQhkTAVI8anb3kzZV+7fLVo+5lu
         krJrz4sjxFNiUe10ITT8qv8ynf4ec/xGX6FXDVbOlX1kCueqFjH9x22ypHqGv5w2Zz7U
         lvOkJLlUiEzyIuXJGksur5ofxIYwhA/PbvdM4Vgm8ZTWSaUauYMiVBKrzkH03wGMULdz
         OJlTe5cE0x2JA4mxaUvjAPGzVLoQKb54H4N818rB76jspfptsMTrapIe3fQBI/XYP5CA
         PyudjUGjM9EkM67kOTAHVn3MPb/tE94sHc38wU+AU8XwErVpEfgk8jl2T2FQXlU1YBgz
         mBFw==
X-Gm-Message-State: AOJu0YzAlXCdjoHlqu3TOcV6ghmmUIi+5vCSKdlPXepA1OUNHSBbVse3
	Vt+M3BSf4lHA2VdxLeJYLw3mCbqpFRxl0tQ3Lrw4lpVx9/0ohxe14QqVsv8Z
X-Gm-Gg: ASbGnctBvLMq44pZ3vn3MCwtVC9owFDb8mXuacboxKcxtGPG/Gj3POBF3FxyiORzHQV
	bHeaeeKUmfAVQJNGqWimQ2HNvY4eekWteT+N62d8cU1F/sQ0vH9DCeKurXTMJ24ytJ1tm9pRH0l
	eetJKDie6HANRDdBszqIFQmtJOJPwDQwcC/CkQFkCfSFbh8WXndVbGhc8eDWg4HwjrN330VlOY8
	p1q4NUN99k4cloD01k2XW/NImuSeoNRc7KKYrC0PDlqPpVMeq87jdbLV+fTQsCN/JX5Od55UIE8
	BN19F2kLdZPaPtUofFbD7XDDkGLatoo2it6OiAqA2LcKtlmdq3A=
X-Google-Smtp-Source: AGHT+IGug1xnEKSSp5IIcfHBIXGgsDkYhx1C9zJKyDvBSZOHNWtpeJSVYUWUOtHUCRHGYr9flux9yA==
X-Received: by 2002:a17:907:7ba8:b0:ac1:fa91:2b98 with SMTP id a640c23a62f3a-ac3cdfaf938mr337787866b.14.1742471055287;
        Thu, 20 Mar 2025 04:44:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b4f3:1c64:be3f:2632])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1167298866b.93.2025.03.20.04.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 20 Mar 2025 12:44:02 +0100
Subject: [PATCH v4 7/8] refs: support rejection in batch updates during F/D
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-245-partially-atomic-ref-updates-v4-7-3dcc1b311dc9@gmail.com>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12629;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=8ZsMujaDpjPPaYMES2lU+Ru+MkbZzLrRLtuL2oGfSgQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfb/4gQ4kUs4VfFJeYYmmiJHkpLc9KpfCrfG
 bvoc8nQWOQ3w4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn2/+IAAoJED7VnySO
 Rox/bk0L/RhfHSTmaQXI3IVegUeazTVdi6NBk6uel4ah0UGX2UJlIM5+Xh8oxpcRzELo3eK9Jx8
 Fyu7kQWuCLhXCiv7/lz2hCVtp9pSCwKqIHqyA3gG2qIaijyTY96qkgngopepJEqElnAyRkSiiJv
 Ry4tYjdq+KzQjY/8hfZkJ765QISh9wcebBCCkOh2MsmfHAxytljznlg3a7ab6SC2pyEy/D7a8x0
 GpyvOJu5pfV+ocWuisZ66DAMdcjDaYEDm+AzSDlBl6AA4Fb+EA0MkIw88MUPXKhj6YAjpnl7wPi
 uyZTxrOmzGxtVKXAbyb2d/kCeVXK8k3urFRjwI++GL+a+tqY9qX6HfP6KJhhls7tcOtdh4rY+w4
 PrWlKz6Me503/MBWWQJnpfLt51DWRSK26dgJvDkhc4czzaztq3QQ6Brk6YV0QkDMd3CMm+vLJVC
 rGHfp55apA9U9w6iTVEkLB+uwUp2zwXFJfNSYtj19YFQ3sf/q3Q3p0fzpYP49PJEpQE//UERqb7
 IA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `refs_verify_refnames_available()` is used to batch check refnames
for F/D conflicts. While this is the more performant alternative than
its individual version, it does not provide rejection capabilities on a
single update level. For batched updates, this would mean a rejection of
the entire transaction whenever one reference has a F/D conflict.

Modify the function to call `ref_transaction_maybe_set_rejected()` to
check if a single update can be rejected. Since this function is only
internally used within 'refs/' and we want to pass in a `struct
ref_transaction *` as a variable. We also move and mark
`refs_verify_refnames_available()` to 'refs-internal.h' to be an
internal function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 28 +++++++++++++++++++++++++++-
 refs.h                  | 12 ------------
 refs/files-backend.c    | 27 ++++++++++++++++++---------
 refs/refs-internal.h    | 16 ++++++++++++++++
 refs/reftable-backend.c | 11 ++++++++---
 5 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index b34ec198f5..f719046f47 100644
--- a/refs.c
+++ b/refs.c
@@ -2540,6 +2540,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  const struct string_list *refnames,
 					  const struct string_list *extras,
 					  const struct string_list *skip,
+					  struct ref_transaction *transaction,
 					  unsigned int initial_transaction,
 					  struct strbuf *err)
 {
@@ -2560,6 +2561,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 	strset_init(&dirnames);
 
 	for_each_string_list_item(item, refnames) {
+		const size_t *update_idx = (size_t *)item->util;
 		const char *refname = item->string;
 		const char *extra_refname;
 		struct object_id oid;
@@ -2599,12 +2601,26 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 			if (!initial_transaction &&
 			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
 					       &type, &ignore_errno)) {
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					strset_remove(&dirnames, dirname.buf);
+					continue;
+				}
+
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 					    dirname.buf, refname);
 				goto cleanup;
 			}
 
 			if (extras && string_list_has_string(extras, dirname.buf)) {
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					strset_remove(&dirnames, dirname.buf);
+					continue;
+				}
+
 				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
 					    refname, dirname.buf);
 				goto cleanup;
@@ -2637,6 +2653,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 				    string_list_has_string(skip, iter->refname))
 					continue;
 
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
+					continue;
+
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 					    iter->refname, refname);
 				goto cleanup;
@@ -2648,6 +2669,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 		if (extra_refname) {
+			if (transaction && ref_transaction_maybe_set_rejected(
+				    transaction, *update_idx,
+				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
+				continue;
+
 			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
 				    refname, extra_refname);
 			goto cleanup;
@@ -2679,7 +2705,7 @@ enum ref_transaction_error refs_verify_refname_available(
 	};
 
 	return refs_verify_refnames_available(refs, &refnames, extras, skip,
-					      initial_transaction, err);
+					      NULL, initial_transaction, err);
 }
 
 struct do_for_each_reflog_help {
diff --git a/refs.h b/refs.h
index 591b703d59..1e7ab2532f 100644
--- a/refs.h
+++ b/refs.h
@@ -147,18 +147,6 @@ enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
 						 unsigned int initial_transaction,
 						 struct strbuf *err);
 
-/*
- * Same as `refs_verify_refname_available()`, but checking for a list of
- * refnames instead of only a single item. This is more efficient in the case
- * where one needs to check multiple refnames.
- */
-enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
-					  const struct string_list *refnames,
-					  const struct string_list *extras,
-					  const struct string_list *skip,
-					  unsigned int initial_transaction,
-					  struct strbuf *err);
-
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index be758ffff5..1d50d4013c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -677,16 +677,18 @@ static void unlock_ref(struct ref_lock *lock)
  * - Generate informative error messages in the case of failure
  */
 static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
-					       const char *refname,
+					       struct ref_update *update,
+					       size_t update_idx,
 					       int mustexist,
 					       struct string_list *refnames_to_check,
 					       const struct string_list *extras,
 					       struct ref_lock **lock_p,
 					       struct strbuf *referent,
-					       unsigned int *type,
 					       struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	const char *refname = update->refname;
+	unsigned int *type = &update->type;
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
@@ -785,6 +787,8 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 
 	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
 			       type, &failure_errno)) {
+		struct string_list_item *item;
+
 		if (failure_errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
@@ -864,7 +868,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 		 * make sure there is no existing packed ref that conflicts
 		 * with refname. This check is deferred so that we can batch it.
 		 */
-		string_list_append(refnames_to_check, refname);
+		item = string_list_append(refnames_to_check, refname);
+		item->util = xmalloc(sizeof(update_idx));
+		memcpy(item->util, &update_idx, sizeof(update_idx));
 	}
 
 	ret = 0;
@@ -2547,6 +2553,7 @@ struct files_transaction_backend_data {
  */
 static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
 						      struct ref_update *update,
+						      size_t update_idx,
 						      struct ref_transaction *transaction,
 						      const char *head_ref,
 						      struct string_list *refnames_to_check,
@@ -2575,9 +2582,9 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	if (lock) {
 		lock->count++;
 	} else {
-		ret = lock_raw_ref(refs, update->refname, mustexist,
+		ret = lock_raw_ref(refs, update, update_idx, mustexist,
 				   refnames_to_check, &transaction->refnames,
-				   &lock, &referent, &update->type, err);
+				   &lock, &referent, err);
 		if (ret) {
 			char *reason;
 
@@ -2849,7 +2856,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		ret = lock_ref_for_update(refs, update, transaction,
+		ret = lock_ref_for_update(refs, update, i, transaction,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
@@ -2905,7 +2912,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 * So instead, we accept the race for now.
 	 */
 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
-					   &transaction->refnames, NULL, 0, err)) {
+					   &transaction->refnames, NULL, transaction,
+					   0, err)) {
 		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
 	}
@@ -2951,7 +2959,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 cleanup:
 	free(head_ref);
-	string_list_clear(&refnames_to_check, 0);
+	string_list_clear(&refnames_to_check, 1);
 
 	if (ret)
 		files_transaction_cleanup(refs, transaction);
@@ -3097,7 +3105,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	}
 
 	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
-					   &affected_refnames, NULL, 1, err)) {
+					   &affected_refnames, NULL, transaction,
+					   1, err)) {
 		packed_refs_unlock(refs->packed_ref_store);
 		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 73a5379b73..f868870851 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -806,4 +806,20 @@ enum ref_transaction_error ref_update_check_old_target(const char *referent,
  */
 int ref_update_expects_existing_old_ref(struct ref_update *update);
 
+/*
+ * Same as `refs_verify_refname_available()`, but checking for a list of
+ * refnames instead of only a single item. This is more efficient in the case
+ * where one needs to check multiple refnames.
+ *
+ * If using batched updates, then individual updates are marked rejected,
+ * reference backends are then in charge of not committing those updates.
+ */
+enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
+					  const struct string_list *refnames,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  struct ref_transaction *transaction,
+					  unsigned int initial_transaction,
+					  struct strbuf *err);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ed65225763..f5429c918b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1074,6 +1074,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 							struct ref_transaction *transaction,
 							struct reftable_backend *be,
 							struct ref_update *u,
+							size_t update_idx,
 							struct string_list *refnames_to_check,
 							unsigned int head_type,
 							struct strbuf *head_referent,
@@ -1149,6 +1150,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 	if (ret < 0)
 		return REF_TRANSACTION_ERROR_GENERIC;
 	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
+		struct string_list_item *item;
 		/*
 		 * The reference does not exist, and we either have no
 		 * old object ID or expect the reference to not exist.
@@ -1158,7 +1160,9 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		 * can output a proper error message instead of failing
 		 * at a later point.
 		 */
-		string_list_append(refnames_to_check, u->refname);
+		item = string_list_append(refnames_to_check, u->refname);
+		item->util = xmalloc(sizeof(update_idx));
+		memcpy(item->util, &update_idx, sizeof(update_idx));
 
 		/*
 		 * There is no need to write the reference deletion
@@ -1368,7 +1372,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 
 	for (i = 0; i < transaction->nr; i++) {
 		ret = prepare_single_update(refs, tx_data, transaction, be,
-					    transaction->updates[i],
+					    transaction->updates[i], i,
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
 		if (ret) {
@@ -1384,6 +1388,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
 					     &transaction->refnames, NULL,
+					     transaction,
 					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
 					     err);
 	if (ret < 0)
@@ -1402,7 +1407,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	}
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
-	string_list_clear(&refnames_to_check, 0);
+	string_list_clear(&refnames_to_check, 1);
 
 	return ret;
 }

-- 
2.48.1

