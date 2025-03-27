Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764D4A21
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074018; cv=none; b=DYTOvAuq0odFBDIX+LLf3wx3Dl3RA9n8EMRiwHkBTPfJ/PJeG3FxP4LLE6obDqR3Nzu0oD1LpvhsxeiNWpLF7yks04ZSdPJcmgy3gY1FtvSxpLcm8mLqYTw4Ny2ivQwUF7kPQRHx3A5+amdGOMOXoYSTEer92GfNftvC1SFuzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074018; c=relaxed/simple;
	bh=KugYgqVhOB42WPdD8Fjy0RjLbeBP8bUvihQQSIHZoCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bv38okVyGEaoxh9uMCn6DEHiToosWGNEDfliSS2VNefj2U4ipBMiqwG8FEy0QCBRhoYqQmh9FLYPfpjrLGSydn61WOh7ynpgcJWMn3ePVAmNTw9YH2SCjcgReewAbXz+DHdIjTJymaB62DtEo0rNZSNqZ+PMvfSMPW5z/0t1cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7fxmKTW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7fxmKTW"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7430e27b2so162955966b.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074015; x=1743678815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GqDf86HKg2ruLApwr4gov30c8eCkiXU6dsYkhSUMR4=;
        b=Z7fxmKTWeJ84jr3aAZemiURMD7bCfsTby5JnfzY+MLW8Llz7GJwDRksHleDgtMlrD0
         2okX9eEZjUhYZxUYaGVNz2Z2sHpq0d+szrM/NWciMZP+ZwkHra/GjYAUoAiapk5gdf89
         mGKYO8VhMxSLowUaYnkPN3OJhvXicxYvftaaaFjJIPHu+gkI+nAcJdVf3Ah/PHbDUeQO
         kBvGAxwv3v3rqHPRaF+ZEgMb7yNV9zKc/9ikcMX52K4nw8WS6GpL9Nx7mr7A9MJ5nKNl
         7AQ4CaEW+YiSO7g3FXXIeUaDKxRncvkY2lYK5F4XFX2+xDkfQ8T3E7g4eeDM/98B0FMb
         mmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074015; x=1743678815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GqDf86HKg2ruLApwr4gov30c8eCkiXU6dsYkhSUMR4=;
        b=ikRhdfc0pslrrODYA1QLxvqHsBeQCZgenOc9i0nhRXODiC5mBYo1H2sTFf2go65zM1
         lZdfH/YGllOLI1VkZF8znzU83egi8s/CEleGoqqzN29Q51kbedFI08GrpzFasZ6oy9rQ
         YNAcyqAx7mhLyrIs+I8BNjCHfgzZgxi/uML9PDbLmbMMOXMxvwUQavuorx6tU56WGoT+
         4b9gHjS8oNaL7Rm2prA9q7hrYBQltAG9I89e9aedLFdH7G1BPGcaGMoF160GdiGBXTF6
         09KOBU06j9p8SrTlVR2aZzqS/4aEYy1AaG+rQw+O4TDQOqL1KBucAycPs818V/XmRJFk
         0jWQ==
X-Gm-Message-State: AOJu0YylhpH1WtOfkxjtrkHNEUdyPZVTmU602OGEUbR9/hgIp0wevg4k
	GR6b+vmVIowoN5rte2O/359u/H3mOaDs0h2xO2GNfunBxj6jUu4j
X-Gm-Gg: ASbGncvAlWOmrbhd4vOz5XpRRLLd+4szcwNVzVCk7oA9xZV3unZvBHsglRc99aLKzye
	ftbCjTd8GiWir8UL/+2RwiFMDn+N4lES7j2h5y/l5tfEia2R1uCvL7JrOFPgi/OhNN2OlJqbXG4
	ScL09IxY3ml4oKWizISViQqX5Cd6q//6+0DTsLZ864Y8Fn7r4/4oe5UyrokkI5ryO8Scq9Ld67S
	Zo0v2KysaM6i8PIiLTGZp5DLoX26w1Vvh6uxuzcknZWDUr3hrj6V/s6jRQQGqYE382NbUROsuwm
	bgVCfTtFfP7Ajm96v32O7hxML6DoPVTHq81p27Tbq+7Yo5U=
X-Google-Smtp-Source: AGHT+IEcvrFpHy9mp7SjnuFneAPS7W0ntrPwQcr7FlTvONXAMUcMzlJyqGooDboVM7oZthzVcIvBwQ==
X-Received: by 2002:a17:907:2d92:b0:ac3:bd68:24e4 with SMTP id a640c23a62f3a-ac6fb14c89cmr252891166b.53.1743074014457;
        Thu, 27 Mar 2025 04:13:34 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 27 Mar 2025 12:13:28 +0100
Subject: [PATCH v5 4/8] refs/reftable: extract code from the transaction
 preparation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-4-4db2a3e34404@gmail.com>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17439;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=KugYgqVhOB42WPdD8Fjy0RjLbeBP8bUvihQQSIHZoCU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMtmXWyjQUIzg+7/ThO87r9X+SeQqaCyWe
 ZJuWmhPiaUca4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLZAAoJED7VnySO
 Rox/LrYL/0n5DHuAvYd7X5SIJCwMfjNmKDnfQL77f2+HsrDesIYvvD+tJ5Ve4/cDvAZ9I9wciTn
 Z8WUrini96asphHsUny9XI7sPY0NUIZu3i4JOdeu3EYtAo/aUMIqEUKr0r2P19/t5DAmuvaazYf
 E/RJvGUpt9+97ys9gyDvWXqBTv7mDVyhjsMYcY8ZdVfjOWL08No/i8SBXe/1feL3EHuxFe1Xkig
 IT1BzPUgK19q4wHouz63LPMjUtakGr3nrPYyOmlJYNwJ3jipYpiMDpYLt3ymA7d1ZIzXbm6+h9Z
 CFu/4rAoGPvgMsNMFG0/fNssR5xm7dGsNkVgkVk9iUR9gdtzeC877qaUqei5H/mbm2Xi0G5SO9u
 tc4aly9PmjFYceZ69D5iHrKvcyjXXkL5aWNiPWsB1HzjLIQx6cKSh+NVfZnMKVj1O6Ze61oRMVs
 2zoR38R9SurVzt9N+3AaJmspH6pVHJKCF9irtRt3Zc8OwsyulcmAw+W3Kxr/nzsaPT1u33LD1l9
 5w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Extract the core logic for preparing individual reference updates from
`reftable_be_transaction_prepare()` into `prepare_single_update()`. This
dedicated function now handles all validation and preparation steps for
each reference update in the transaction, including object ID
verification, HEAD reference handling, and symref processing.

The refactoring consolidates all reference update validation into a
single logical block, which improves code maintainability and
readability. More importantly, this restructuring lays the groundwork
for implementing batched reference update support in the reftable
backend, which will be introduced in a followup commit.

No functional changes are included in this commit - it is purely a code
reorganization to support future enhancements.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 463 +++++++++++++++++++++++++-----------------------
 1 file changed, 237 insertions(+), 226 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a92c9a2f4f..786df11a03 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1069,6 +1069,239 @@ static int queue_transaction_update(struct reftable_ref_store *refs,
 	return 0;
 }
 
+static int prepare_single_update(struct reftable_ref_store *refs,
+				 struct reftable_transaction_data *tx_data,
+				 struct ref_transaction *transaction,
+				 struct reftable_backend *be,
+				 struct ref_update *u,
+				 struct string_list *refnames_to_check,
+				 unsigned int head_type,
+				 struct strbuf *head_referent,
+				 struct strbuf *referent,
+				 struct strbuf *err)
+{
+	struct object_id current_oid = {0};
+	const char *rewritten_ref;
+	int ret = 0;
+
+	/*
+	 * There is no need to reload the respective backends here as
+	 * we have already reloaded them when preparing the transaction
+	 * update. And given that the stacks have been locked there
+	 * shouldn't have been any concurrent modifications of the
+	 * stack.
+	 */
+	ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
+	if (ret)
+		return ret;
+
+	/* Verify that the new object ID is valid. */
+	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
+	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
+	    !(u->flags & REF_LOG_ONLY)) {
+		struct object *o = parse_object(refs->base.repo, &u->new_oid);
+		if (!o) {
+			strbuf_addf(err,
+				    _("trying to write ref '%s' with nonexistent object %s"),
+				    u->refname, oid_to_hex(&u->new_oid));
+			return -1;
+		}
+
+		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
+			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
+				    oid_to_hex(&u->new_oid), u->refname);
+			return -1;
+		}
+	}
+
+	/*
+	 * When we update the reference that HEAD points to we enqueue
+	 * a second log-only update for HEAD so that its reflog is
+	 * updated accordingly.
+	 */
+	if (head_type == REF_ISSYMREF &&
+	    !(u->flags & REF_LOG_ONLY) &&
+	    !(u->flags & REF_UPDATE_VIA_HEAD) &&
+	    !strcmp(rewritten_ref, head_referent->buf)) {
+		/*
+		 * First make sure that HEAD is not already in the
+		 * transaction. This check is O(lg N) in the transaction
+		 * size, but it happens at most once per transaction.
+		 */
+		if (string_list_has_string(&transaction->refnames, "HEAD")) {
+			/* An entry already existed */
+			strbuf_addf(err,
+				    _("multiple updates for 'HEAD' (including one "
+				      "via its referent '%s') are not allowed"),
+				    u->refname);
+			return TRANSACTION_NAME_CONFLICT;
+		}
+
+		ref_transaction_add_update(
+			transaction, "HEAD",
+			u->flags | REF_LOG_ONLY | REF_NO_DEREF,
+			&u->new_oid, &u->old_oid, NULL, NULL, NULL,
+			u->msg);
+	}
+
+	ret = reftable_backend_read_ref(be, rewritten_ref,
+					&current_oid, referent, &u->type);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
+		/*
+		 * The reference does not exist, and we either have no
+		 * old object ID or expect the reference to not exist.
+		 * We can thus skip below safety checks as well as the
+		 * symref splitting. But we do want to verify that
+		 * there is no conflicting reference here so that we
+		 * can output a proper error message instead of failing
+		 * at a later point.
+		 */
+		string_list_append(refnames_to_check, u->refname);
+
+		/*
+		 * There is no need to write the reference deletion
+		 * when the reference in question doesn't exist.
+		 */
+		if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
+			ret = queue_transaction_update(refs, tx_data, u,
+						       &current_oid, err);
+			if (ret)
+				return ret;
+		}
+
+		return 0;
+	}
+	if (ret > 0) {
+		/* The reference does not exist, but we expected it to. */
+		strbuf_addf(err, _("cannot lock ref '%s': "
+
+
+				   "unable to resolve reference '%s'"),
+			    ref_update_original_update_refname(u), u->refname);
+		return -1;
+	}
+
+	if (u->type & REF_ISSYMREF) {
+		/*
+		 * The reftable stack is locked at this point already,
+		 * so it is safe to call `refs_resolve_ref_unsafe()`
+		 * here without causing races.
+		 */
+		const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, 0,
+							       &current_oid, NULL);
+
+		if (u->flags & REF_NO_DEREF) {
+			if (u->flags & REF_HAVE_OLD && !resolved) {
+				strbuf_addf(err, _("cannot lock ref '%s': "
+						   "error reading reference"), u->refname);
+				return -1;
+			}
+		} else {
+			struct ref_update *new_update;
+			int new_flags;
+
+			new_flags = u->flags;
+			if (!strcmp(rewritten_ref, "HEAD"))
+				new_flags |= REF_UPDATE_VIA_HEAD;
+
+			if (string_list_has_string(&transaction->refnames, referent->buf)) {
+				strbuf_addf(err,
+					    _("multiple updates for '%s' (including one "
+					      "via symref '%s') are not allowed"),
+					    referent->buf, u->refname);
+				return TRANSACTION_NAME_CONFLICT;
+			}
+
+			/*
+			 * If we are updating a symref (eg. HEAD), we should also
+			 * update the branch that the symref points to.
+			 *
+			 * This is generic functionality, and would be better
+			 * done in refs.c, but the current implementation is
+			 * intertwined with the locking in files-backend.c.
+			 */
+			new_update = ref_transaction_add_update(
+				transaction, referent->buf, new_flags,
+				u->new_target ? NULL : &u->new_oid,
+				u->old_target ? NULL : &u->old_oid,
+				u->new_target, u->old_target,
+				u->committer_info, u->msg);
+
+			new_update->parent_update = u;
+
+			/*
+			 * Change the symbolic ref update to log only. Also, it
+			 * doesn't need to check its old OID value, as that will be
+			 * done when new_update is processed.
+			 */
+			u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
+			u->flags &= ~REF_HAVE_OLD;
+		}
+	}
+
+	/*
+	 * Verify that the old object matches our expectations. Note
+	 * that the error messages here do not make a lot of sense in
+	 * the context of the reftable backend as we never lock
+	 * individual refs. But the error messages match what the files
+	 * backend returns, which keeps our tests happy.
+	 */
+	if (u->old_target) {
+		if (!(u->type & REF_ISSYMREF)) {
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "expected symref with target '%s': "
+					   "but is a regular ref"),
+				    ref_update_original_update_refname(u),
+				    u->old_target);
+			return -1;
+		}
+
+		if (ref_update_check_old_target(referent->buf, u, err)) {
+			return -1;
+		}
+	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
+		if (is_null_oid(&u->old_oid)) {
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "reference already exists"),
+				    ref_update_original_update_refname(u));
+			return TRANSACTION_CREATE_EXISTS;
+		}
+		else if (is_null_oid(&current_oid))
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "reference is missing but expected %s"),
+				    ref_update_original_update_refname(u),
+				    oid_to_hex(&u->old_oid));
+		else
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "is at %s but expected %s"),
+				    ref_update_original_update_refname(u),
+				    oid_to_hex(&current_oid),
+				    oid_to_hex(&u->old_oid));
+		return TRANSACTION_NAME_CONFLICT;
+	}
+
+	/*
+	 * If all of the following conditions are true:
+	 *
+	 *   - We're not about to write a symref.
+	 *   - We're not about to write a log-only entry.
+	 *   - Old and new object ID are different.
+	 *
+	 * Then we're essentially doing a no-op update that can be
+	 * skipped. This is not only for the sake of efficiency, but
+	 * also skips writing unneeded reflog entries.
+	 */
+	if ((u->type & REF_ISSYMREF) ||
+	    (u->flags & REF_LOG_ONLY) ||
+	    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid)))
+		return queue_transaction_update(refs, tx_data, u,
+					       &current_oid, err);
+
+	return 0;
+}
+
 static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					   struct ref_transaction *transaction,
 					   struct strbuf *err)
@@ -1133,234 +1366,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	ret = 0;
 
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *u = transaction->updates[i];
-		struct object_id current_oid = {0};
-		const char *rewritten_ref;
-
-		/*
-		 * There is no need to reload the respective backends here as
-		 * we have already reloaded them when preparing the transaction
-		 * update. And given that the stacks have been locked there
-		 * shouldn't have been any concurrent modifications of the
-		 * stack.
-		 */
-		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
+		ret = prepare_single_update(refs, tx_data, transaction, be,
+					    transaction->updates[i],
+					    &refnames_to_check, head_type,
+					    &head_referent, &referent, err);
 		if (ret)
 			goto done;
-
-		/* Verify that the new object ID is valid. */
-		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
-		    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
-		    !(u->flags & REF_LOG_ONLY)) {
-			struct object *o = parse_object(refs->base.repo, &u->new_oid);
-			if (!o) {
-				strbuf_addf(err,
-					    _("trying to write ref '%s' with nonexistent object %s"),
-					    u->refname, oid_to_hex(&u->new_oid));
-				ret = -1;
-				goto done;
-			}
-
-			if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
-				strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
-					    oid_to_hex(&u->new_oid), u->refname);
-				ret = -1;
-				goto done;
-			}
-		}
-
-		/*
-		 * When we update the reference that HEAD points to we enqueue
-		 * a second log-only update for HEAD so that its reflog is
-		 * updated accordingly.
-		 */
-		if (head_type == REF_ISSYMREF &&
-		    !(u->flags & REF_LOG_ONLY) &&
-		    !(u->flags & REF_UPDATE_VIA_HEAD) &&
-		    !strcmp(rewritten_ref, head_referent.buf)) {
-			/*
-			 * First make sure that HEAD is not already in the
-			 * transaction. This check is O(lg N) in the transaction
-			 * size, but it happens at most once per transaction.
-			 */
-			if (string_list_has_string(&transaction->refnames, "HEAD")) {
-				/* An entry already existed */
-				strbuf_addf(err,
-					    _("multiple updates for 'HEAD' (including one "
-					    "via its referent '%s') are not allowed"),
-					    u->refname);
-				ret = TRANSACTION_NAME_CONFLICT;
-				goto done;
-			}
-
-			ref_transaction_add_update(
-				transaction, "HEAD",
-				u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-				&u->new_oid, &u->old_oid, NULL, NULL, NULL,
-				u->msg);
-		}
-
-		ret = reftable_backend_read_ref(be, rewritten_ref,
-						&current_oid, &referent, &u->type);
-		if (ret < 0)
-			goto done;
-		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
-			/*
-			 * The reference does not exist, and we either have no
-			 * old object ID or expect the reference to not exist.
-			 * We can thus skip below safety checks as well as the
-			 * symref splitting. But we do want to verify that
-			 * there is no conflicting reference here so that we
-			 * can output a proper error message instead of failing
-			 * at a later point.
-			 */
-			string_list_append(&refnames_to_check, u->refname);
-
-			/*
-			 * There is no need to write the reference deletion
-			 * when the reference in question doesn't exist.
-			 */
-			 if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
-				 ret = queue_transaction_update(refs, tx_data, u,
-								&current_oid, err);
-				 if (ret)
-					 goto done;
-			 }
-
-			continue;
-		}
-		if (ret > 0) {
-			/* The reference does not exist, but we expected it to. */
-			strbuf_addf(err, _("cannot lock ref '%s': "
-				    "unable to resolve reference '%s'"),
-				    ref_update_original_update_refname(u), u->refname);
-			ret = -1;
-			goto done;
-		}
-
-		if (u->type & REF_ISSYMREF) {
-			/*
-			 * The reftable stack is locked at this point already,
-			 * so it is safe to call `refs_resolve_ref_unsafe()`
-			 * here without causing races.
-			 */
-			const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, 0,
-								       &current_oid, NULL);
-
-			if (u->flags & REF_NO_DEREF) {
-				if (u->flags & REF_HAVE_OLD && !resolved) {
-					strbuf_addf(err, _("cannot lock ref '%s': "
-						    "error reading reference"), u->refname);
-					ret = -1;
-					goto done;
-				}
-			} else {
-				struct ref_update *new_update;
-				int new_flags;
-
-				new_flags = u->flags;
-				if (!strcmp(rewritten_ref, "HEAD"))
-					new_flags |= REF_UPDATE_VIA_HEAD;
-
-				if (string_list_has_string(&transaction->refnames, referent.buf)) {
-					strbuf_addf(err,
-						    _("multiple updates for '%s' (including one "
-						    "via symref '%s') are not allowed"),
-						    referent.buf, u->refname);
-					ret = TRANSACTION_NAME_CONFLICT;
-					goto done;
-				}
-
-				/*
-				 * If we are updating a symref (eg. HEAD), we should also
-				 * update the branch that the symref points to.
-				 *
-				 * This is generic functionality, and would be better
-				 * done in refs.c, but the current implementation is
-				 * intertwined with the locking in files-backend.c.
-				 */
-				new_update = ref_transaction_add_update(
-					transaction, referent.buf, new_flags,
-					u->new_target ? NULL : &u->new_oid,
-					u->old_target ? NULL : &u->old_oid,
-					u->new_target, u->old_target,
-					u->committer_info, u->msg);
-
-				new_update->parent_update = u;
-
-				/*
-				 * Change the symbolic ref update to log only. Also, it
-				 * doesn't need to check its old OID value, as that will be
-				 * done when new_update is processed.
-				 */
-				u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-				u->flags &= ~REF_HAVE_OLD;
-			}
-		}
-
-		/*
-		 * Verify that the old object matches our expectations. Note
-		 * that the error messages here do not make a lot of sense in
-		 * the context of the reftable backend as we never lock
-		 * individual refs. But the error messages match what the files
-		 * backend returns, which keeps our tests happy.
-		 */
-		if (u->old_target) {
-			if (!(u->type & REF_ISSYMREF)) {
-				strbuf_addf(err, _("cannot lock ref '%s': "
-					   "expected symref with target '%s': "
-					   "but is a regular ref"),
-					    ref_update_original_update_refname(u),
-					    u->old_target);
-				ret = -1;
-				goto done;
-			}
-
-			if (ref_update_check_old_target(referent.buf, u, err)) {
-				ret = -1;
-				goto done;
-			}
-		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			if (is_null_oid(&u->old_oid)) {
-				strbuf_addf(err, _("cannot lock ref '%s': "
-						   "reference already exists"),
-					    ref_update_original_update_refname(u));
-				ret = TRANSACTION_CREATE_EXISTS;
-			}
-			else if (is_null_oid(&current_oid))
-				strbuf_addf(err, _("cannot lock ref '%s': "
-						   "reference is missing but expected %s"),
-					    ref_update_original_update_refname(u),
-					    oid_to_hex(&u->old_oid));
-			else
-				strbuf_addf(err, _("cannot lock ref '%s': "
-						   "is at %s but expected %s"),
-					    ref_update_original_update_refname(u),
-					    oid_to_hex(&current_oid),
-					    oid_to_hex(&u->old_oid));
-			goto done;
-		}
-
-		/*
-		 * If all of the following conditions are true:
-		 *
-		 *   - We're not about to write a symref.
-		 *   - We're not about to write a log-only entry.
-		 *   - Old and new object ID are different.
-		 *
-		 * Then we're essentially doing a no-op update that can be
-		 * skipped. This is not only for the sake of efficiency, but
-		 * also skips writing unneeded reflog entries.
-		 */
-		if ((u->type & REF_ISSYMREF) ||
-		    (u->flags & REF_LOG_ONLY) ||
-		    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid))) {
-			ret = queue_transaction_update(refs, tx_data, u,
-						       &current_oid, err);
-			if (ret)
-				goto done;
-		}
 	}
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,

-- 
2.48.1

