Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C22222DE
	for <git@vger.kernel.org>; Wed, 14 May 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213441; cv=none; b=f6KsErNdgYy5Rj77dXO+XXgwwZH0xIMqlH3FL3k5StUshFZ9VJeCoji9xMlpLfNWQTFS/6NP/4rtjgvWplsXdWhURJwbVbsI4dP0po5Ec74X3pUnGFKwAeWT0ZoVZRu31+ZKZ+biSyrTDVBPO9W4NJ/S8qSzLyLrO+aqPjOsjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213441; c=relaxed/simple;
	bh=QVh52cAM+IYC9QFzruzYsnXVLKhVbQ6MTZ8dp999Mic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sot61hp/EJyAKykijD56uO8M5AhhtwfjF4g/4cThA7+qVm73qsYgJm53RMdyQnFeDPzVPDsM7F1XZk7if/ecpOPA75rgBmLzcYPzC3eOWVMfsLEhqiG0tqI4leireV/F8L0K1UZCEeJdSOpw95N13FGhUX9ps0kbE4W4sOkx9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrahUhtt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrahUhtt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso3762762f8f.2
        for <git@vger.kernel.org>; Wed, 14 May 2025 02:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747213437; x=1747818237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2BzvWOE1XutJuU1REbqOGDynVw00Lk+ZTGf98igzdA=;
        b=OrahUhttW8BAmIuak6cnzPu25nJj4cXlikkC48iqhwQz5aMgQtWkEXVoI8H1RTvTAs
         WFG26rcnl1x/zAkLIDYj2A+EeGeUP4PBJXFz7csPw6qD8WSZnh1QpVw9YLVfUIdP7aFB
         ImibSLnTNi7W1FptWYnvfXQZ907jubOPzT6d3kMpL06Ih4IaH7jL6JPBqw2zbc28PO13
         zIUZRTSPwcvGS65CVcdBLta0l/OQLrbTlkXPhAFuGytUwOGl4HL62tjtKhiZG+x+iJcf
         aPNGxPuFWlliMseXSsetiiheazSflUqOfjVX63jDgIYrRbA9C7/bxWSSV+Y3yy86H951
         eEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747213437; x=1747818237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2BzvWOE1XutJuU1REbqOGDynVw00Lk+ZTGf98igzdA=;
        b=v6OyrrHrwogTC464WJ5KTTasf9NoXQo146P9uN/7JrLsdAlXnHA6KBpN9vApW+HGvf
         JWdpkVp++ra3vULpChrT9ALImrADoyPdqtdWLbN8RmVsB1eHA7MSsS9RX+rInOsRWSDZ
         rb1jUhyvO3jm2vLCBYqGREE79zcC5RddmWHlz3pOUn7xMcXcsjPsRgqyhmYzFvuOQ86h
         A6lKxfuAVVfHx4pVCW1wK6xgD/sABj3qzx4o/l2n6pOtEQdqQpNR7pI7A/D3onpVdod4
         KsoYHkogiQiLC4QcYLwwA+x6noDumKEvNJ/3BRbZVRS10fgjj6PF/uK1RLWS7b4hGth7
         JJdA==
X-Gm-Message-State: AOJu0YwtFOsqnjtL/xcdlKkAN5reiVPh7qiHs1GrZu7JBO/Yr4sFamg0
	9RxIw77fzufPLHYw9XWmWin3gB6QNCxSkEjc8HSk5Nvl8RlCfaeI
X-Gm-Gg: ASbGncu/dOOFx5z2QOJoAYNLHNHRVjKysdQhifpjtnJqQ3pdfdS+EboakrsmzKmdbTp
	4K+Xm/C2hyaF9J44kge6oQnao3q5O46yX9Znqcf5z4DpvVZ5UYrWE0n4xaQcHHUTHklzTjg4EFI
	5TUsiKhymcFca5QNg/ak7qjkEbWHAv8JbUE2IfqoqRkcydsizDxlxb+Sabv8nrOLsLKlm1pA7lR
	BWfEx5zt+kHVw60EKkWlcNq0GNSOc51TRoUnP+HQmyIYMGp3lq+2bRaGqC7zioNlD5Dy1Vts4Wo
	swAMQXkxO6dlA0/wr2v0dazqx03Oid8R+CkQv0gvn0SRhXe57dSxUO7xTeAQpfNwGy2H
X-Google-Smtp-Source: AGHT+IGpAcrC+h1H8Nr8EInnVqVlr6zGgfdO73ufCAYwliioFNKkm0fmhi8nAG9lS2B0KISD0sZ+4Q==
X-Received: by 2002:a05:6000:2dc2:b0:3a1:fd74:4248 with SMTP id ffacd0b85a97d-3a349694826mr1981379f8f.5.1747213437077;
        Wed, 14 May 2025 02:03:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:768c:74a5:aa9f:b39e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm19084461f8f.91.2025.05.14.02.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 02:03:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 May 2025 11:03:47 +0200
Subject: [PATCH 1/3] fetch: use batched reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9701; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QVh52cAM+IYC9QFzruzYsnXVLKhVbQ6MTZ8dp999Mic=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgkXHsuOx89I+/cDyy882ekOS/myOy2hWPts
 gZ8pBViqLcHsokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJFx7AAoJED7VnySO
 Rox/QPAL/iSb9ZB/jQuWdlWT4Tm3yzYoTHHSd/v2VVnVKErfLUu1i5mehmsBc+SjaRLPmm5u1W9
 9eyYvjmtYzHK4H+rrPx8yoKZyGo/z+aZyS6pmSSSKH51HKlcKG52F/tNaqOeQbYAzNlpjmYafsn
 tUabhVnIRkYIig3U+YiRB8T8/DSxCduL/bP6vH31+7bGe4Q5DqXGh+XM3RPk6J+EGW0H9G3F+qG
 NrsxAj4KTj2zyXaYaBDll/PWuwm4LZ+CaF8yNBrQih23utTdtlj4i3Bx/05CIIm4+pzgttQuvkx
 oIcbeYTCe+XmVU/oksMHU5IEtnd82xiRw9cD5M73tcVSsCHZGDYowHQCsBaWT28dgyUr7w11dY9
 op0ZsGpGJ+n8/P9/sAuMne2DDs2sblyHEbzm+xPKBBKn3R66UIKof7kFKMhJ2KSErDgytMQxZXl
 d/KFcVo8ewM5XFEEDrsonCCKCcbkVTJpg3sCzKFXacw3SB8RKBNPENSDlBBqZmCDjbPMw9VGJB5
 B4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference updates performed as a part of 'git-fetch(1)', take place
one at a time. For each reference update, a new transaction is created
and committed. This is necessary to ensure we can allow individual
updates to fail without failing the entire command. The command also
supports an '--atomic' mode, which uses a single transaction to update
all of the references. But this mode has an all-or-nothing approach,
where if a single update fails, all updates would fail.

In 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08), we introduced a new mechanism to batch reference updates.
Under the hood, this uses a single transaction to perform a batch of
reference updates, while allowing only individual updates to fail.
Utilize this newly introduced batch update mechanism in 'git-fetch(1)'.
This provides a significant bump in performance, especially when dealing
with repositories with large number of references.

Adding support for batched updates is simply modifying the flow to also
create a batch update transaction in the non-atomic flow.

With the reftable backend there is a 22x performance improvement, when
performing 'git-fetch(1)' with 10000 refs:

  Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = master)
    Time (mean ± σ):      3.403 s ±  0.775 s    [User: 1.875 s, System: 1.417 s]
    Range (min … max):    2.454 s …  4.529 s    10 runs

  Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
    Time (mean ± σ):     154.3 ms ±  17.6 ms    [User: 102.5 ms, System: 56.1 ms]
    Range (min … max):   145.2 ms … 220.5 ms    18 runs

  Summary
    fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
     22.06 ± 5.62 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = master)

In similar conditions, the files backend sees a 1.25x performance
improvement:

  Benchmark 1: fetch: many refs (refformat = files, refcount = 10000, revision = master)
    Time (mean ± σ):     605.5 ms ±   9.4 ms    [User: 117.8 ms, System: 483.3 ms]
    Range (min … max):   595.6 ms … 621.5 ms    10 runs

  Benchmark 2: fetch: many refs (refformat = files, refcount = 10000, revision = HEAD)
    Time (mean ± σ):     485.8 ms ±   4.3 ms    [User: 91.1 ms, System: 396.7 ms]
    Range (min … max):   477.6 ms … 494.3 ms    10 runs

  Summary
    fetch: many refs (refformat = files, refcount = 10000, revision = HEAD) ran
      1.25 ± 0.02 times faster than fetch: many refs (refformat = files, refcount = 10000, revision = master)

With this we'll either be using a regular transaction or a batch update
transaction. This helps cleanup some code which is no longer needed as
we'll now always have some type of 'ref_transaction' object being
propagated.

One big change is that earlier, each individual update would propagate a
failure. Whereas now, the `ref_transaction_for_each_rejected_update`
function is called at the end of the flow to capture the exit status for
'git-fetch(1)' and also to print F/D conflict errors. This does change
the order of the errors being printed, but the behavior stays the same.

Since transaction errors are now explicitly defined as part of
76e760b999 (refs: introduce enum-based transaction error types,
2025-04-08), utilize them and get rid of custom errors defined within
'builtin/fetch.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c | 119 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 54 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5279997c96..1558f6d1e8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -641,9 +641,6 @@ static struct ref *get_ref_map(struct remote *remote,
 	return ref_map;
 }
 
-#define STORE_REF_ERROR_OTHER 1
-#define STORE_REF_ERROR_DF_CONFLICT 2
-
 static int s_update_ref(const char *action,
 			struct ref *ref,
 			struct ref_transaction *transaction,
@@ -651,7 +648,6 @@ static int s_update_ref(const char *action,
 {
 	char *msg;
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *our_transaction = NULL;
 	struct strbuf err = STRBUF_INIT;
 	int ret;
 
@@ -661,43 +657,10 @@ static int s_update_ref(const char *action,
 		rla = default_rla.buf;
 	msg = xstrfmt("%s: %s", rla, action);
 
-	/*
-	 * If no transaction was passed to us, we manage the transaction
-	 * ourselves. Otherwise, we trust the caller to handle the transaction
-	 * lifecycle.
-	 */
-	if (!transaction) {
-		transaction = our_transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-									    0, &err);
-		if (!transaction) {
-			ret = STORE_REF_ERROR_OTHER;
-			goto out;
-		}
-	}
-
 	ret = ref_transaction_update(transaction, ref->name, &ref->new_oid,
 				     check_old ? &ref->old_oid : NULL,
 				     NULL, NULL, 0, msg, &err);
-	if (ret) {
-		ret = STORE_REF_ERROR_OTHER;
-		goto out;
-	}
 
-	if (our_transaction) {
-		switch (ref_transaction_commit(our_transaction, &err)) {
-		case 0:
-			break;
-		case REF_TRANSACTION_ERROR_NAME_CONFLICT:
-			ret = STORE_REF_ERROR_DF_CONFLICT;
-			goto out;
-		default:
-			ret = STORE_REF_ERROR_OTHER;
-			goto out;
-		}
-	}
-
-out:
-	ref_transaction_free(our_transaction);
 	if (ret)
 		error("%s", err.buf);
 	strbuf_release(&err);
@@ -1139,7 +1102,6 @@ N_("it took %.2f seconds to check forced updates; you can use\n"
    "to avoid this check\n");
 
 static int store_updated_refs(struct display_state *display_state,
-			      const char *remote_name,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head,
@@ -1277,11 +1239,6 @@ static int store_updated_refs(struct display_state *display_state,
 		}
 	}
 
-	if (rc & STORE_REF_ERROR_DF_CONFLICT)
-		error(_("some local refs could not be updated; try running\n"
-		      " 'git remote prune %s' to remove any old, conflicting "
-		      "branches"), remote_name);
-
 	if (advice_enabled(ADVICE_FETCH_SHOW_FORCED_UPDATES)) {
 		if (!config->show_forced_updates) {
 			warning(_(warn_show_forced_updates));
@@ -1366,9 +1323,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 	}
 
 	trace2_region_enter("fetch", "consume_refs", the_repository);
-	ret = store_updated_refs(display_state, transport->remote->name,
-				 connectivity_checked, transaction, ref_map,
-				 fetch_head, config);
+	ret = store_updated_refs(display_state, connectivity_checked,
+				 transaction, ref_map, fetch_head, config);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
 
 out:
@@ -1688,6 +1644,32 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 	return result;
 }
 
+struct ref_rejection_data {
+	int *retcode;
+	int conflict_msg_shown;
+	const char *remote_name;
+};
+
+static void ref_transaction_rejection_handler(const char *refname UNUSED,
+					      const struct object_id *old_oid UNUSED,
+					      const struct object_id *new_oid UNUSED,
+					      const char *old_target UNUSED,
+					      const char *new_target UNUSED,
+					      enum ref_transaction_error err,
+					      void *cb_data)
+{
+	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
+
+	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+		error(_("some local refs could not be updated; try running\n"
+			" 'git remote prune %s' to remove any old, conflicting "
+			"branches"), data->remote_name);
+		data->conflict_msg_shown = 1;
+	}
+
+	*data->retcode = 1;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1808,6 +1790,20 @@ static int do_fetch(struct transport *transport,
 			retcode = 1;
 	}
 
+	/*
+	 * If not atomic, we can still use batched updates, which would be much
+	 * more performent. We don't initiate the transaction before pruning,
+	 * since pruning must be an independent step, to avoid F/D conflicts.
+	 */
+	if (!transaction) {
+		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+							  REF_TRANSACTION_ALLOW_FAILURE, &err);
+		if (!transaction) {
+			retcode = -1;
+			goto cleanup;
+		}
+	}
+
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
 				   &fetch_head, config)) {
 		retcode = 1;
@@ -1839,16 +1835,31 @@ static int do_fetch(struct transport *transport,
 		free_refs(tags_ref_map);
 	}
 
-	if (transaction) {
-		if (retcode)
-			goto cleanup;
+	if (retcode)
+		goto cleanup;
+
+	retcode = ref_transaction_commit(transaction, &err);
+	if (retcode) {
+		/*
+		 * Explicitly handle transaction cleanup to avoid
+		 * aborting an already closed transaction.
+		 */
+		ref_transaction_free(transaction);
+		transaction = NULL;
+		goto cleanup;
+	}
 
-		retcode = ref_transaction_commit(transaction, &err);
+	if (!atomic_fetch) {
+		struct ref_rejection_data data = {
+			.retcode = &retcode,
+			.conflict_msg_shown = 0,
+			.remote_name = transport->remote->name,
+		};
+
+		ref_transaction_for_each_rejected_update(transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
 		if (retcode) {
-			/*
-			 * Explicitly handle transaction cleanup to avoid
-			 * aborting an already closed transaction.
-			 */
 			ref_transaction_free(transaction);
 			transaction = NULL;
 			goto cleanup;

-- 
2.49.0

