Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A743B585C
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286542; cv=none; b=u5RaruyjhDktAbqhahcKyGcKDHuTUQbfePB49flowMo87lD9pdyvLCDo2w3bgc5qIkuok6cDDy5pW+fYCFYawt/PDjvrXaLXCI+U6C4gGoV/8Z5B2F6P5xMHBOd7sEOi9kkkLVnStXdMVS0XPR1FIzRy740yY+Xzo/81mb92OyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286542; c=relaxed/simple;
	bh=DjGPZfaZHhlBhPSmVnMQffN59KerRbptcmiWjYSxL1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pb1TwGZzIfnvWy0M/7cOpZe5MZDaLMDd9M4HJL1ZXFpl7Rf7OlAnalJLUlLppYpQ1clhPQNNO9jLLnVCVu6Lz6eMNDxRLGlW8+l0afIsN4A6zWtkiAV4vsP05nFdQ8JP3pY5GUlhfMPEC91+Zr/f9JoTT9rfFs1cyO9naxUnzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrTIfwL0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrTIfwL0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so8350927f8f.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286539; x=1777891339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MDWY2GTkGqUB/2Zjz2KS6A/bkSFgekCpuaAbzoVLdE=;
        b=DrTIfwL0vB2ArNGU4R+NYTXpUFsVzZi9uSoCYXxmBqGg6ESEsEZyx6K/ayqMSHMrue
         GdFcUd428mlgi67P9rx/xIY6El45dL54gElKobeIN8Fz1wiq2hJkwQc4YhK19EUipE1N
         sGRm3cgTPHCGXBQwcLzPTALk3w4K1hAzQC6WeCWc9CrkM30sFepS3NfXy/rZAZoMQDcV
         KUwRkdOUNg+WUyu0myC4IpsiYcP8BiAmTSrmHK0+hmilLcrlhGZc9CTUxWwtgIB6O+fX
         2uKR4CPc+EK4IjwfKCVAhvCI3w9rHwCkKu3XkPJTTJn78D1/gNLyYzvPBy7KLOv2OrOR
         9uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286539; x=1777891339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+MDWY2GTkGqUB/2Zjz2KS6A/bkSFgekCpuaAbzoVLdE=;
        b=F/FYYevvzOwgk3N3KGILACjZ0Ckmq+WbEVpsLzoIUZSmDxu+qle2J+ep1Q6bfMoXQG
         0tMF2DbdT9vO1eDfGAEQTb8HwI1c/tntZNLeSCDOBZiGO+FYN168Lx3Kap6g0TvEIWps
         4AfmyBqCw0xVT8HqUda892Lvq2RZ2JjJ0Sr8ib9Ka8ZpHV2FrPPByeVpJFQ2qFBb9JzZ
         TmP1YKpTUaJLQzLJ/PBcdSbC33ewPeD5bu5cy5vTHVNPCfhEYirz8WauQm9lO+tAwpDc
         Eb8qSuMoAkesziheNqgI5zBe4cxNGCgEtU0obZve9k4yDp2nVFVYAVHuhyWH26U4alzP
         RZJg==
X-Gm-Message-State: AOJu0YxOHhl+C7KEbY6m5LNvM9gfRpfCvZtd70cs92GJV9+MDyljUMHf
	jBbT9s/fXOyzas5siMMPIqYpC5MjZSBc1ZDT/DMhHkdoC6weob+jS/XU1mVrdQ==
X-Gm-Gg: AeBDieuqnjT9jUvRkGpWfezBUPoNZN2rA8bUCl+WV6utsLQ+hy+qZj2tLp+sCzYqzfb
	XAXypgNjzLM1vEQufGyRrnC5whh8B1sUCIjeXZTQCyOwOO+c+Tcc8LnoUsYF1d/OpSbglPKAkz/
	B4VH8VfrKSvTFOleeUvwcr9XAotIJx2wR+LRbfWf7B3B8SRfMIv4Kpqvy/x0ZEYESywuXpjgG5F
	L0bUol3Gtw3B1E6zo7mFXvkHpbUEqVtR7sDf33ThKbbaZdFrDKN+0KfAwL+eaFpHgWBMq5+HICR
	kxjYXcMFH6le0MOZ9RGOHy/U9MzY9FPWxt0A1xQ4LyXMySm/x9Aq417QZyB8X/yWsBwXnqkoaBO
	Ju/oUQJAaPVx9weAgaOskGmJNk5OKXRSkcGU08PgZddJhNUnG9QxdYk1US00epkuQJU8IZuQmme
	vCR5Hni9pxZ3Z1GEkwQTCF3/x5ssknADT0yaG47tYP
X-Received: by 2002:a5d:5cc4:0:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-43fe3e13c5fmr48100571f8f.42.1777286538769;
        Mon, 27 Apr 2026 03:42:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:08 +0200
Subject: [PATCH v3 7/9] refs: move object parsing to the generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-7-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8409; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=DjGPZfaZHhlBhPSmVnMQffN59KerRbptcmiWjYSxL1M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPYB+Qo8BFnJk2eMMVSkXUmXG7giM2wBsP
 ZySBPCzumDMP4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z2AAAoJED7VnySO
 Rox/M4EL/jXaVpBCgUiQzmCfmflBmstA4EYLCkd2Hiu1j9+KiiJUYLsCq+PSY2S9JrWWizM5SbX
 YHVOXmvQRZ6FZ4vCuazzfPDmGM3yh2etYevNfAmaYUZQYcI9r/VVWKzWEBuOo7f5iQCmNYxU9kM
 mqgmgvEezdSALUD87wjZtTSYEVHBmpcEKGBel30R//SWPD24Ua3jEcc7kTL23YBVwnBNfPFiRO/
 jF1p/68LTwDARdEBU7KXYKH1RXkC1UhYTVTjtaUATkwSMK2rkYFcxbe+qAlaj9AyC6UyZIkWVja
 oxNgABpXUiP8fVVrmnT6CKYpqxXArDy2t++qH+WFy/G0N/qwJxOpjvtlUNCGMkKPm2eTT+n5XrC
 A7pGov8VLp+HdSY/Jg6hb1UkuzJ4jfE50BCZyIEhPxUPcEzpLDkwNfFSg/PQlIyj4IkCYrD7r1z
 6KDXSIBGRekRmUZ/NBjYKD8J6sRV8DQlyl9tbh8KODpW1EMcVOxnGH6PEEyLpYwr63tdAkIL7U3
 rc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Regular reference updates made via reference transactions validate that
the provided object ID exists in the object database, which is done by
calling 'parse_object()'. This check is done independently by the
backends which leads to duplicated logic.

Let's move this to the generic layer, ensuring the backends only have to
care about reference storage and not about validation of the object IDs.
With this also remove the 'REF_TRANSACTION_ERROR_INVALID_NEW_VALUE'
error type as its no longer used.

Since we don't iterate over individual references in
`ref_transaction_prepare()`, we add this check to
`ref_transaction_update()`. This means that the validation is done as
soon as an update is queued, without needing to prepare the
transaction. It can be argued that this is more ideal, since this
validation has no dependency on the reference transaction being
prepared.

It must be noted that the change in behavior means that this error
cannot be ignored even with usage of batched updates, since this happens
when the update is being added to the transaction. But since the caller
gets specific error codes, they can either abort the transaction or
continue adding other updates to the transaction.

Modify 'builtin/receive-pack.c' to now capture the error type so that
the error propagated to the client stays the same. Also remove two of
the tests which validates batch-updates with invalid new_oid.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c  | 22 +++++++++++++---------
 refs.c                  | 18 ++++++++++++++++++
 refs/files-backend.c    | 28 ++--------------------------
 refs/reftable-backend.c | 19 -------------------
 4 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 878aa7f0ed..376e755e97 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1641,8 +1641,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			ret = NULL; /* good */
 		}
 		strbuf_release(&err);
-	}
-	else {
+	} else {
+		enum ref_transaction_error tx_err;
 		struct strbuf err = STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si)) {
@@ -1650,14 +1650,18 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			goto out;
 		}
 
-		if (ref_transaction_update(transaction,
-					   namespaced_name,
-					   new_oid, old_oid,
-					   NULL, NULL,
-					   0, "push",
-					   &err)) {
+		tx_err = ref_transaction_update(transaction,
+						  namespaced_name,
+						  new_oid, old_oid,
+						  NULL, NULL,
+						  0, "push",
+						  &err);
+		if (tx_err) {
 			rp_error("%s", err.buf);
-			ret = "failed to update ref";
+			if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
+				ret = "failed to update ref";
+			else
+				ret = ref_transaction_error_msg(tx_err);
 		} else {
 			ret = NULL; /* good */
 		}
diff --git a/refs.c b/refs.c
index efa16b739d..662a9e6f9e 100644
--- a/refs.c
+++ b/refs.c
@@ -1416,6 +1416,24 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
+	if ((flags & REF_HAVE_NEW) && !new_target && !is_null_oid(new_oid) &&
+	    !(flags & REF_SKIP_OID_VERIFICATION) && !(flags & REF_LOG_ONLY)) {
+		struct object *o = parse_object(transaction->ref_store->repo, new_oid);
+
+		if (!o) {
+			strbuf_addf(err,
+				    _("trying to write ref '%s' with nonexistent object %s"),
+				    refname, oid_to_hex(new_oid));
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
+		}
+
+		if (o->type != OBJ_COMMIT && is_branch(refname)) {
+			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
+				    oid_to_hex(new_oid), refname);
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
+		}
+	}
+
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
 				   old_target, NULL, msg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b2faf4777..f20f580fbc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -19,7 +19,6 @@
 #include "../iterator.h"
 #include "../dir-iterator.h"
 #include "../lockfile.h"
-#include "../object.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
@@ -1589,7 +1588,6 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
 							struct ref_lock *lock,
 							const struct object_id *oid,
-							int skip_oid_verification,
 							struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
@@ -1737,7 +1735,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1755,7 +1753,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto rollbacklog;
 	}
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, REF_SKIP_CREATE_REFLOG, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1999,32 +1997,11 @@ static int files_log_ref_write(struct files_ref_store *refs,
 static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
 							struct ref_lock *lock,
 							const struct object_id *oid,
-							int skip_oid_verification,
 							struct strbuf *err)
 {
 	static char term = '\n';
-	struct object *o;
 	int fd;
 
-	if (!skip_oid_verification) {
-		o = parse_object(refs->base.repo, oid);
-		if (!o) {
-			strbuf_addf(
-				err,
-				"trying to write ref '%s' with nonexistent object %s",
-				lock->ref_name, oid_to_hex(oid));
-			unlock_ref(lock);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
-			strbuf_addf(
-				err,
-				"trying to write non-commit object %s to branch '%s'",
-				oid_to_hex(oid), lock->ref_name);
-			unlock_ref(lock);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-	}
 	fd = get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), refs->base.repo->hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
@@ -2828,7 +2805,6 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 		} else {
 			ret = write_ref_to_lockfile(
 				refs, lock, &update->new_oid,
-				update->flags & REF_SKIP_OID_VERIFICATION,
 				err);
 			if (ret) {
 				char *write_err = strbuf_detach(err, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 93374d25c2..444b0c24e5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1081,25 +1081,6 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		return 0;
 	}
 
-	/* Verify that the new object ID is valid. */
-	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
-	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
-	    !(u->flags & REF_LOG_ONLY)) {
-		struct object *o = parse_object(refs->base.repo, &u->new_oid);
-		if (!o) {
-			strbuf_addf(err,
-				    _("trying to write ref '%s' with nonexistent object %s"),
-				    u->refname, oid_to_hex(&u->new_oid));
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-
-		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
-			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
-				    oid_to_hex(&u->new_oid), u->refname);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-	}
-
 	/*
 	 * When we update the reference that HEAD points to we enqueue
 	 * a second log-only update for HEAD so that its reflog is

-- 
2.53.GIT

