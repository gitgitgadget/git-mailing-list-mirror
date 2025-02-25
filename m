Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58C260A59
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475775; cv=none; b=iY5IgLc1BfrUfi4GHzTJbdSzWboRWvBpoUtiG/sB9NAB1N7Pg4vNA/iiGIbhCWOujc+fCzQ6tFsaHx3RscXwdg4dVCiYqucy7mIsYii4QvgD1QsMOaHn31GfXjk7Wk/6dh5QWIa96GPiYvUEDtZMzfYoS/Mw5D9+nUAKe2zIbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475775; c=relaxed/simple;
	bh=DN70+vYSDtjptifCa7oXfyKza6QGPF8ufmZBzATYN8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uU2KQOp6W4HOVUopkurAgV05rLsmj/yKOCDWY3D+55QCSWzUydC6wgdDXKkTeIpfu5rIv05ITZ2tA2i9RQQ1Bv/tAEcJZ6DkvKaW9JDJgEUqAFMWjR1ctdY/aFxD/pl2c7TPTPAl/As5jGrMfJfzwAf6VMVo/eAZN91fGgO04cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5KjLCXv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5KjLCXv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso833528966b.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475772; x=1741080572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoP6RitNuKick9A8qDS3ASkRk+rVaR8PtrVuE6dpStQ=;
        b=d5KjLCXvE8HbHsS9W7LGqQQyD6QIXNL8cNqS+zZxI115cakweTLSFF6WlR8snbs1sn
         +b8B5vOifDQKClpSfnpwcCOqXJzhsA4JxQob/OwKvniv/i6RIlQRybQuPxai/bihQMxI
         8QBsD8HHcImXrMSCBcWECXXUSxjD8RQAfRghkO4dvGf0q/bU7spDWAuT1cJMFo01UlVS
         hqPw7wH4Cx/OUSR8Mf0psfUSvLiSq9qtS32Jia+KwGBf0sabaBghvqu9ljROsOT4s/x0
         uasFz/nD3pZ+izuKmDUcrEUQmxsfFglpcW3Cx3+rJGf3ByzY7ISVFvvd4OVwGzzShqfX
         qkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475772; x=1741080572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoP6RitNuKick9A8qDS3ASkRk+rVaR8PtrVuE6dpStQ=;
        b=Bmj9hn1t4W7bVlZOFrljeQRPefc4Q/n6LdxXIQEVRsqqMF//mZ6A+3PffvKqO49hb5
         2mFH0Ap7DgZBuNuHwKKhaTrMcIZvOORQuyQr30XgYqroJqAjN79WHelDY7FU6Nk4Xy5a
         LDVgcuTMb/wYR9KF7eBXF8MRo3zLj4uQ8T+mGyUFibd0Op4F+tjWlz3/r8i5CGmQ2LkZ
         ihchBGc8hsXkiXeppd19z7aS1J4kRNijvR20p0ZwfdMI3EdQA/yV52g2SqR5qMXvKEzC
         EsPaph/VppwKvheATea0kVQA7vLfeoOSND8926QSZK4pY2QPRenrCZ9Nu1OpvTSUr6cs
         3OXw==
X-Gm-Message-State: AOJu0YwkdVLlNNpWL5vdoFpZfRMsB3S2FMOBAF8dpE/Nu3niM42cWvyn
	y4XKVTbavrtbzWnkrFUpWirMFAlGGL6WSde3/gbKduGFTvSDdi/M
X-Gm-Gg: ASbGnctKVhqPQIiCdBdn65/SGgV9IHP0ArNGy7Gi8pw4yBR5z/Pi+pqFSO6zgTtORFP
	ASj1Grw1BbuR1+IK4c7Cgl0I6aFhL/0IJpSKnIKPXt7HYEbp/UbcuNxFu9ZemIUH1lc4rTYBnbx
	4hMgLg74//cccd2Yl4hWqoJJ+ZrYo0vhuEm5IcAJc0OYFCp17GeqOFLPfV7KUoZuE76FhOawHxj
	6O5YSXr/QI2SQXqchOg1UZ5uxz+iZSSlPB8FFjzItaqhihNzIyhFIBGHeAaKjZ97sDyjEnZCPut
	UCL5KWH+xsx5EPFTpdcO8weVtPeEyHl1
X-Google-Smtp-Source: AGHT+IFRT9SIjtFNhRV1gPOf6odNM+mn39s4k2IBfd3lSYFfvIA8jEWnHrsP+BzfTI4Nal+Ix8uSTg==
X-Received: by 2002:a17:906:3152:b0:ab7:d87f:665b with SMTP id a640c23a62f3a-abc0de4a2cemr1487877866b.48.1740475771423;
        Tue, 25 Feb 2025 01:29:31 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:30 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 25 Feb 2025 10:29:07 +0100
Subject: [PATCH v2 4/7] refs/reftable: extract code from the transaction
 preparation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-4-cfa3236895d7@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17407;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=DN70+vYSDtjptifCa7oXfyKza6QGPF8ufmZBzATYN8U=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXUdMkoQVh8V757ahCS1bIm9NA1P1r9Hn
 PvkrN3qJMblbYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY11AAoJED7VnySO
 Rox/eJUL/jV8Bi0E7VS/zkoM8Vv5+Vej/aAzA7Nz0sIFOVhYtNe/sARMgtnxNuPRaw0vB6gqrMR
 yuBuvOWY0vZwsWCnn5c2DxfMYsID1opIUXFxQGXrI+5hy7T5Z8fKXKa3aaEqLFVPeT7rxghkZoB
 CHiKW8zGN9xVuBNtHqJxSvvCNoJ0dZskJF5i/Z7c4sYYufeUl+dkvjJ5p/JPxc9/YlmXlmKDBmF
 P6s++UTMnLfYmu5WiC+1Wb/hxEfilCm0rUrNyByCoux5/hjjFDkpmxDrTsZjKSVpH4LJ9YevpJD
 /8uuiGAtQTIARWHpCCDU9OvruhXE9Ew5l9v6VidJ/YSHNXPccYfvmEGXkCyy3lYSZkFL6mb6GPb
 obeaFV0ST4zmQ8mrHvEwym/lqlKy2dc/4aScZy+r9GYfewGasKJtH4i5020FdsxydPtdWywLR6L
 yPl/faNbJeYs/bRb9dirw92ByD6LFPJiNftWA1X4XqqW1IJOWHC9IhhOSkySmDH5NBNV5P+6RZ7
 08=
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
for implementing partial transaction support in the reftable backend,
which will be introduced in the following commit.

No functional changes are included in this commit - it is purely a code
reorganization to support future enhancements.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 463 +++++++++++++++++++++++++-----------------------
 1 file changed, 237 insertions(+), 226 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f616d9aabe..2c1e2995de 100644
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
 
 	string_list_sort(&refnames_to_check);

-- 
2.47.2

