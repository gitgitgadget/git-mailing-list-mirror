Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CE23314B
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913830; cv=none; b=Y6R23h6IOsGX516ZpWSqKhVYjbPsAuv4QqSvjdbYIXnAhId/pVfmiOOWkIvouoUfaJ9M/LY5UcUvNn35SrPYiVf142FiuJkF07gc3hucjsGTI0ww/4uJMFLvGWefUP6+XE46Bl+094t8YZ5acYaVxMO6/r+5tL+Ru/5pQnVJSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913830; c=relaxed/simple;
	bh=ZIn7CMRwDia1Tkipj9WqcC9yYE0tbSEAKUBDbq3a61c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEnMUZf+r/3wQ44bgqsMdLOCEiUJw++EZroaP728Mg6cNYiMBUB7u2scSOjaG6CX3Q5X+58flyvg4Oz3FflcLyE912kXYbmXPYtCRYANlsV2+e1ISYOwcZnOb9qSRo58cd1FniMpJhS0lHP8uaqKH7s2BFSW+SopEIsP+xDN+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAiAlWoO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAiAlWoO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f0c4275a1so26933655ad.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913827; x=1739518627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFM+6CxvGV+3T3C+TJ8HHpHfPfbBXHVjHURFNp3xsAY=;
        b=LAiAlWoOWtW8AoltGTHLHf4aV3iue/nPqWvjbenl5WIlMyyQYvls1s7a6Xqmt6UUSn
         IPQEK0Z57EzpcbW3mn7SihIJTqWXF0JTpMU94MtH3Qjg6/LEgyF5PU+NwNSPhOkIYmWO
         SbW/Mqs73rLGzgpRuL8lJrqogzrmfVriMtFclpW3+Fq+J5mQySwNJ+pHmrWW3AW+TOTa
         fRsPGbq2mY5Nfu4zcn2VvhzcyGBBJ4okqr38Zwjcq6/7Wc205WpvDVdFZHeimG4Hm9ps
         WEAo/1E2pEZNyy9v7Uzh5S+SzQIZ2aLqqtJk8H+/A7R9xU3FlTYiCKDw+rsiqDaIO36N
         Waxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913827; x=1739518627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFM+6CxvGV+3T3C+TJ8HHpHfPfbBXHVjHURFNp3xsAY=;
        b=U96hcf7a9gPeHzDk1KlyE1AVhLki8WpYCOg8i9XuX8GUIMF4HHbfiLhBz0Al5b3W8J
         O+CzmMaT4OyzoPdl6uoIMPCYQMwd/FKwzoSGICIiNMc2OCtv67pRUTBk1AyDYhx+yuqr
         POFNpmownstP8MM2sDtcjT7qW2cEILv2/SwFMSrt7918MsuRV3tjRQOib5kFbQgBI6y3
         sV3e4q8hMuSUJCoznMWTNQlHhBFBoNNK+uaMO3KGAjr6rQYWAMrSfr7Dk6OWqcevsA0U
         SSK/49rPzPBvRtJ01EX6+l7MncFTzCHCBk0N8Aw6OXlmFqWOb5wqMM7+hzgItKLZbGa3
         e3pw==
X-Gm-Message-State: AOJu0Yx3QWykY/NkrMZHbhH6ItP8E4awvTclJM5GW90vXyCrnNeDDMOs
	fVPJ/MHOjB9luqXWegVLg/rZ20PY7Kze0YD0CUi2Hv8yDT0qT7ly+6jPixfj
X-Gm-Gg: ASbGncubEL5gdxjgNjR6E9kkghjEbocKNkkIGmdpg+n/amulOZLUBmQaHCCpJotIFpJ
	Fg1GVUkevAYnfX22ZA/2ayVr6GyjxWqcn8zFuY35bZ+/7bb4vhIpIBugSPhUY9BqrpzXWZdiTKq
	CyguhTVsxacJkLjSyCw1bctt9hZTNO3q6xqTcKXQqCik71c66rtpbEFwxJPad0jsClsK98OTu2f
	XyJPQDnZgzc9+8soT65OjUdN9QtgToRNcJ0RypQpeHxq+yMzPEw2cw2GvyxsB2wogtNn45kGC4j
	LHtGd5e9cAbAY54u2mbVKg==
X-Google-Smtp-Source: AGHT+IEvc+2DpKfvxJnjZTYbGcoTMMzfI0XPfMfRfAFoJX8gAwrx98dRNpA/nKaYAMoWWCmyokBjgg==
X-Received: by 2002:a17:903:240f:b0:216:69ca:7714 with SMTP id d9443c01a7336-21f4e6a106emr40330535ad.11.1738913826516;
        Thu, 06 Feb 2025 23:37:06 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 08:34:37 +0100
Subject: [PATCH 2/6] refs: move duplicate refname update check to generic
 layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-2-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19275;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=ZIn7CMRwDia1Tkipj9WqcC9yYE0tbSEAKUBDbq3a61c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBq5L72fE0kuwEz9mXT6TmjjfqsGObL5+
 ycMFjmIZDve54kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgaAAoJED7VnySO
 Rox/o7UMAIs3XdvETmpJ8FCvkrx3JBtWrhHikFk1P3cnc9ZsyD1vl0WCYMmtTJGHcghjjsA6+MM
 p1go2C/2kK3THSLapBDosY27o1XN/8cFAvdhI+5MxRL23OBLUHypGvJmvcaa3B00W3Q4G1ZdIFG
 UE/SWFNNrWQ57mEVUUjuAqmaPPUBjpFiZtxqSrO43xp5tHEcBTgUz60O9tgD2iQydV0508KTA1i
 WRmzRZncBXR/q6M7wXV3BglAkghwQPVqtvU66R4tPgQwYU79g+qL9iBVqgTMeipXik4RT/pz+gr
 TYxsP93r4KLMBPGQslVrbEtJGjhVcCRIADHyTnvFi03R1XkDc0Gw2zPe4Jw8SNEzqzM2gPWzn+4
 tfBi1oSWQ9coswEYE4PL5CugukHzWARUF/uMzuWfM9bx3SLHbYiKyUHgaVp+RUBu8y36p3ltcx7
 90F8XKBHRnoLHHxS4RIhiVDKKf4E/NeZMOwEH0e8v+Oo9aBeOTQ85zivKZlMo8UMtA9B5DRTKI5
 Yo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Move the tracking of refnames in `affected_refnames` from individual
backends into the generic layer in 'refs.c'. This centralizes the
duplicate refname detection that was previously handled separately by
each backend.

Make some changes to accommodate this move:

  - Add a `string_list` field `refnames` to `ref_transaction` to contain
    all the references in a transaction. This field is updated whenever
    a new update is added.

  - Modify the backends to use this field internally as needed. The
    backends need to check if an update for refname already exists when
    splitting symrefs or adding an update for 'HEAD'.

  - In the reftable backend, in `reftable_be_transaction_prepare()`,
    move the instance of `string_list_has_string()` above
    `ref_transaction_add_update()` to check before the reference is
    added.

This helps reduce duplication of functionality between the backends and
makes it easier to make changes in a more centralized manner.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 17 ++++++++++++
 refs/files-backend.c    | 69 ++++++++++---------------------------------------
 refs/packed-backend.c   | 25 +-----------------
 refs/refs-internal.h    |  2 ++
 refs/reftable-backend.c | 53 ++++++++++++-------------------------
 5 files changed, 50 insertions(+), 116 deletions(-)

diff --git a/refs.c b/refs.c
index f4094a326a9f88f979654b668cc9c3d27d83cb5d..4c9b706461977995be1d55e7667f7fb708fbbb76 100644
--- a/refs.c
+++ b/refs.c
@@ -1175,6 +1175,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
 	tr->flags = flags;
+	string_list_init_dup(&tr->refnames);
 	return tr;
 }
 
@@ -1205,6 +1206,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
+	string_list_clear(&transaction->refnames, 0);
 	free(transaction->updates);
 	free(transaction);
 }
@@ -1218,6 +1220,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *committer_info,
 		const char *msg)
 {
+	struct string_list_item *item;
 	struct ref_update *update;
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
@@ -1245,6 +1248,16 @@ struct ref_update *ref_transaction_add_update(
 		update->msg = normalize_reflog_message(msg);
 	}
 
+	/*
+	 * This list is generally used by the backends to avoid duplicates.
+	 * But we do support multiple log updates for a given refname within
+	 * a single transaction.
+	 */
+	if (!(update->flags & REF_LOG_ONLY)) {
+		item = string_list_append(&transaction->refnames, refname);
+		item->util = update;
+	}
+
 	return update;
 }
 
@@ -2397,6 +2410,10 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		return -1;
 	}
 
+	string_list_sort(&transaction->refnames);
+	if (ref_update_reject_duplicates(&transaction->refnames, err))
+		return TRANSACTION_GENERIC_ERROR;
+
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
 		return ret;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c6a3f6d6261a894e1c294bb1329fdf8079a39eb4..18da30c3f37dc5c09f7d81a9083d6b41d0463bd5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2383,9 +2383,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
  */
 static int split_head_update(struct ref_update *update,
 			     struct ref_transaction *transaction,
-			     const char *head_ref,
-			     struct string_list *affected_refnames,
-			     struct strbuf *err)
+			     const char *head_ref, struct strbuf *err)
 {
 	struct ref_update *new_update;
 
@@ -2403,7 +2401,7 @@ static int split_head_update(struct ref_update *update,
 	 * transaction. This check is O(lg N) in the transaction
 	 * size, but it happens at most once per transaction.
 	 */
-	if (string_list_has_string(affected_refnames, "HEAD")) {
+	if (string_list_has_string(&transaction->refnames, "HEAD")) {
 		/* An entry already existed */
 		strbuf_addf(err,
 			    "multiple updates for 'HEAD' (including one "
@@ -2425,7 +2423,6 @@ static int split_head_update(struct ref_update *update,
 	 */
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
-	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2441,7 +2438,6 @@ static int split_head_update(struct ref_update *update,
 static int split_symref_update(struct ref_update *update,
 			       const char *referent,
 			       struct ref_transaction *transaction,
-			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
 	struct ref_update *new_update;
@@ -2453,7 +2449,7 @@ static int split_symref_update(struct ref_update *update,
 	 * size, but it happens at most once per symref in a
 	 * transaction.
 	 */
-	if (string_list_has_string(affected_refnames, referent)) {
+	if (string_list_has_string(&transaction->refnames, referent)) {
 		/* An entry already exists */
 		strbuf_addf(err,
 			    "multiple updates for '%s' (including one "
@@ -2491,15 +2487,6 @@ static int split_symref_update(struct ref_update *update,
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
 	update->flags &= ~REF_HAVE_OLD;
 
-	/*
-	 * Add the referent. This insertion is O(N) in the transaction
-	 * size, but it happens at most once per symref in a
-	 * transaction. Make sure to add new_update->refname, which will
-	 * be valid as long as affected_refnames is in use, and NOT
-	 * referent, which might soon be freed by our caller.
-	 */
-	string_list_insert(affected_refnames, new_update->refname);
-
 	return 0;
 }
 
@@ -2561,9 +2548,7 @@ struct files_transaction_backend_data {
 static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct ref_update *update,
 			       struct ref_transaction *transaction,
-			       const char *head_ref,
-			       struct string_list *affected_refnames,
-			       struct strbuf *err)
+			       const char *head_ref, struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = ref_update_expects_existing_old_ref(update);
@@ -2579,8 +2564,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
-		ret = split_head_update(update, transaction, head_ref,
-					affected_refnames, err);
+		ret = split_head_update(update, transaction, head_ref, err);
 		if (ret)
 			goto out;
 	}
@@ -2590,7 +2574,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		lock->count++;
 	} else {
 		ret = lock_raw_ref(refs, update->refname, mustexist,
-				   affected_refnames,
+				   &transaction->refnames,
 				   &lock, &referent,
 				   &update->type, err);
 		if (ret) {
@@ -2646,9 +2630,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * of processing the split-off update, so we
 			 * don't have to do it here.
 			 */
-			ret = split_symref_update(update,
-						  referent.buf, transaction,
-						  affected_refnames, err);
+			ret = split_symref_update(update, referent.buf,
+						  transaction, err);
 			if (ret)
 				goto out;
 		}
@@ -2803,7 +2786,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
@@ -2821,12 +2803,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	transaction->backend_data = backend_data;
 
 	/*
-	 * Fail if a refname appears more than once in the
-	 * transaction. (If we end up splitting up any updates using
-	 * split_symref_update() or split_head_update(), those
-	 * functions will check that the new updates don't have the
-	 * same refname as any existing ones.) Also fail if any of the
-	 * updates use REF_IS_PRUNING without REF_NO_DEREF.
+	 * Fail if any of the updates use REF_IS_PRUNING without REF_NO_DEREF.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2834,16 +2811,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
 			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
-
-		if (update->flags & REF_LOG_ONLY)
-			continue;
-
-		string_list_append(&affected_refnames, update->refname);
-	}
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
 	}
 
 	/*
@@ -2884,7 +2851,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		ret = lock_ref_for_update(refs, update, transaction,
-					  head_ref, &affected_refnames, err);
+					  head_ref, err);
 		if (ret)
 			goto cleanup;
 
@@ -2957,7 +2924,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 cleanup:
 	free(head_ref);
-	string_list_clear(&affected_refnames, 0);
 
 	if (ret)
 		files_transaction_cleanup(refs, transaction);
@@ -3021,7 +2987,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 {
 	size_t i;
 	int ret = 0;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct ref_transaction *packed_transaction = NULL;
 	struct ref_transaction *loose_transaction = NULL;
 
@@ -3030,13 +2995,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < transaction->nr; i++)
-		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
-			string_list_append(&affected_refnames,
-					   transaction->updates[i]->refname);
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
+	string_list_sort(&transaction->refnames);
+	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
@@ -3054,7 +3014,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	 * that we are creating already exists.
 	 */
 	if (refs_for_each_rawref(&refs->base, ref_present,
-				 &affected_refnames))
+				 &transaction->refnames))
 		BUG("initial ref transaction called with existing refs");
 
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
@@ -3072,7 +3032,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			BUG("initial ref transaction with old_sha1 set");
 
 		if (refs_verify_refname_available(&refs->base, update->refname,
-						  &affected_refnames, NULL, 1, err)) {
+						  &transaction->refnames, NULL, 1, err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
@@ -3132,7 +3092,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (packed_transaction)
 		ref_transaction_free(packed_transaction);
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e35f897f619c540cbc600bbd888bc67..6e7acb077e81435715a1ca3cc928550147c8c56a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1604,8 +1604,6 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 struct packed_transaction_backend_data {
 	/* True iff the transaction owns the packed-refs lock. */
 	int own_lock;
-
-	struct string_list updates;
 };
 
 static void packed_transaction_cleanup(struct packed_ref_store *refs,
@@ -1614,8 +1612,6 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 	struct packed_transaction_backend_data *data = transaction->backend_data;
 
 	if (data) {
-		string_list_clear(&data->updates, 0);
-
 		if (is_tempfile_active(refs->tempfile))
 			delete_tempfile(&refs->tempfile);
 
@@ -1640,7 +1636,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
 	struct packed_transaction_backend_data *data;
-	size_t i;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	/*
@@ -1653,34 +1648,16 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	 */
 
 	CALLOC_ARRAY(data, 1);
-	string_list_init_nodup(&data->updates);
 
 	transaction->backend_data = data;
 
-	/*
-	 * Stick the updates in a string list by refname so that we
-	 * can sort them:
-	 */
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item =
-			string_list_append(&data->updates, update->refname);
-
-		/* Store a pointer to update in item->util: */
-		item->util = update;
-	}
-	string_list_sort(&data->updates);
-
-	if (ref_update_reject_duplicates(&data->updates, err))
-		goto failure;
-
 	if (!is_lock_file_locked(&refs->lock)) {
 		if (packed_refs_lock(ref_store, 0, err))
 			goto failure;
 		data->own_lock = 1;
 	}
 
-	if (write_with_updates(refs, &data->updates, err))
+	if (write_with_updates(refs, &transaction->refnames, err))
 		goto failure;
 
 	transaction->state = REF_TRANSACTION_PREPARED;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index aaab711bb96844755dfa600d37efdb25b30a0765..f43766e1f00443eb689685cf4df0fa0b80018a03 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -3,6 +3,7 @@
 
 #include "refs.h"
 #include "iterator.h"
+#include "string-list.h"
 
 struct fsck_options;
 struct ref_transaction;
@@ -198,6 +199,7 @@ enum ref_transaction_state {
 struct ref_transaction {
 	struct ref_store *ref_store;
 	struct ref_update **updates;
+	struct string_list refnames;
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d39a14c5a469d7d219362e9eae4f578784d65a5b..dd2099d94948a4f23fd9f7ddc06bf3d741229eba 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1068,7 +1068,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
 	struct reftable_backend *be;
 	struct object_id head_oid;
@@ -1092,10 +1091,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 						 transaction->updates[i], err);
 		if (ret)
 			goto done;
-
-		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
-			string_list_append(&affected_refnames,
-					   transaction->updates[i]->refname);
 	}
 
 	/*
@@ -1107,17 +1102,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		tx_data->args[i].updates_alloc = tx_data->args[i].updates_expected;
 	}
 
-	/*
-	 * Fail if a refname appears more than once in the transaction.
-	 * This code is taken from the files backend and is a good candidate to
-	 * be moved into the generic layer.
-	 */
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto done;
-	}
-
 	/*
 	 * TODO: it's dubious whether we should reload the stack that "HEAD"
 	 * belongs to or not. In theory, it may happen that we only modify
@@ -1185,14 +1169,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		    !(u->flags & REF_LOG_ONLY) &&
 		    !(u->flags & REF_UPDATE_VIA_HEAD) &&
 		    !strcmp(rewritten_ref, head_referent.buf)) {
-			struct ref_update *new_update;
-
 			/*
 			 * First make sure that HEAD is not already in the
 			 * transaction. This check is O(lg N) in the transaction
 			 * size, but it happens at most once per transaction.
 			 */
-			if (string_list_has_string(&affected_refnames, "HEAD")) {
+			if (string_list_has_string(&transaction->refnames, "HEAD")) {
 				/* An entry already existed */
 				strbuf_addf(err,
 					    _("multiple updates for 'HEAD' (including one "
@@ -1202,12 +1184,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				goto done;
 			}
 
-			new_update = ref_transaction_add_update(
-					transaction, "HEAD",
-					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, NULL, NULL, NULL,
-					u->msg);
-			string_list_insert(&affected_refnames, new_update->refname);
+			ref_transaction_add_update(
+				transaction, "HEAD",
+				u->flags | REF_LOG_ONLY | REF_NO_DEREF,
+				&u->new_oid, &u->old_oid, NULL, NULL, NULL,
+				u->msg);
 		}
 
 		ret = reftable_backend_read_ref(be, rewritten_ref,
@@ -1225,7 +1206,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * at a later point.
 			 */
 			ret = refs_verify_refname_available(ref_store, u->refname,
-							    &affected_refnames, NULL,
+							    &transaction->refnames, NULL,
 							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
 							    err);
 			if (ret < 0)
@@ -1277,6 +1258,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				if (!strcmp(rewritten_ref, "HEAD"))
 					new_flags |= REF_UPDATE_VIA_HEAD;
 
+				if (string_list_has_string(&transaction->refnames, referent.buf)) {
+					strbuf_addf(err,
+						    _("multiple updates for '%s' (including one "
+						    "via symref '%s') are not allowed"),
+						    referent.buf, u->refname);
+					ret = TRANSACTION_NAME_CONFLICT;
+					goto done;
+				}
+
 				/*
 				 * If we are updating a symref (eg. HEAD), we should also
 				 * update the branch that the symref points to.
@@ -1301,16 +1291,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
 				u->flags &= ~REF_HAVE_OLD;
-
-				if (string_list_has_string(&affected_refnames, new_update->refname)) {
-					strbuf_addf(err,
-						    _("multiple updates for '%s' (including one "
-						    "via symref '%s') are not allowed"),
-						    referent.buf, u->refname);
-					ret = TRANSACTION_NAME_CONFLICT;
-					goto done;
-				}
-				string_list_insert(&affected_refnames, new_update->refname);
 			}
 		}
 
@@ -1391,7 +1371,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			strbuf_addf(err, _("reftable: transaction prepare: %s"),
 				    reftable_error_str(ret));
 	}
-	string_list_clear(&affected_refnames, 0);
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
 

-- 
2.47.0

