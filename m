Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57033202C5C
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648701; cv=none; b=o3kNwosz1qZKjs8tEMZmB3Q+Hx0acaigluDIi61cv9+2ZKKeWeNDkp/F1w/cgp9Y19jWUetdZefcdNDNTf4/1HQtiiN830WMx6VC9olEdfJX1xXSohVeB0UoBpWQvNEdMIqN708cyuidw9MM6ye6Odi/XlnuA5T0iiFul5wezx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648701; c=relaxed/simple;
	bh=abyBqfybBCnH7UU8keEbMrkjS2R1G1iKu6KpY6Wf2qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6EmcVkJpeSVAFw3g6f4RdL358U+iO8Md+BHToLq9dzwcsfzM42glBv1ImWgzu6NtBQwkfG4cnXUUGU54PuaRSDOJrJfUlcoDeOGAUnJStD7RNBWuE8NKm7QBDNiGRMrLGs7On60Z8ZsJWlqb8Aa5yDEH79VXUNUMgOSzsrDhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL3gIiBd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL3gIiBd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so45199015e9.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747648697; x=1748253497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj9eQDX3sobCZCyoVfkvwTuMrelUWg1pTogGh57NZWI=;
        b=GL3gIiBdGOANR4hTZYsdzkraAJqIADCiEF+KgjPpTQ1vFLSypKAfU7dpXfRNN+S3Hh
         PeArgn3AkloCOAXSTYJ2FLf4iqNP4Saaaq+C73P2eq9GJHqVLyjp20yAtQAzfyRFe1fO
         nZ89Nqe4Wfmzh0qBEuV9cXt2vekayU/IefKdes1IPfVq8w9PzpLcEMfGG7N458nuCnyT
         +2pmbG2A+VWKywJsFEqA5xmuSRYGoWib4+hp7wFvIpo21+ie4dELuNEnO9TDbu3GVW5Z
         4XdVShTFwRoscV2wBLdV2Zayi9xhuQl5zCNw6I9qNZRninbC12rcguXqXYxnNkMTFEPu
         panA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648697; x=1748253497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj9eQDX3sobCZCyoVfkvwTuMrelUWg1pTogGh57NZWI=;
        b=rwQhxXrhxtcHt7dQr4aEI0xfErbh1m9DbLX/D25st32q3DoW6hVcZH+FOIXzmzc1Mi
         ZkFcDPOQ0iB2LxYFU5iQa7oUv1Ap8DW7ljVmVwtzeLgyy9lAghJVW5C5gOJq0P00TP9i
         9Nf2GH75SFKGrIjKeoHZ+AvI7H3iFAYwyflI1oYhjH3ShZ/nwWL98Q+iTw1nxKTmO7fi
         juNzw7FfZeGo+sc3Bfp37yjlIGP/WHvNwq1ofDsR0O70FDvbp2x7NdTElKOaDkBPV/VA
         hnGHOGEFOaLr1tXvC9Pajoujsln1fVd8Fe5xv6PSaIQdCO5NvPeygXJvYjH0y3KKttLw
         pKmw==
X-Gm-Message-State: AOJu0YwTZ67D5JfECmhsYVVgesTUlwi1OabrzVN8hPIsvJJ/+opGmypP
	nBMFH4tgs+fbAOeNhdUY/UfqkBnl9IJKFU9mLiAUgpka1STyD2DlJdpz
X-Gm-Gg: ASbGncvnwVAFCKTfpt7c/NSJuPph16AURhYrHTaezE22LhvRxUVKuS9ilMnPyigYynM
	pZww5ZvnRecfpOKYrvyT7qpE4Y2X6TN5d/TbehkJQRaSsKL4m+a5CSk/SEV5cxvEp3FOGOOcv6W
	yreOzRxNit9glEJIEYZi3iyZ3NzfkkKsQ2MJZy8GGyut7j+q+XXicEPP53cqMsBu2M5tMhPcivG
	mm8S2FUX+vlKe1iU0nqCqWXhT7ReGAafKoTDuWVQFngglRxU68zL2fey0BEZSZDbnUkarPCCbON
	qA5y8ojizbCbiaQCg0/TIAXKtd302Dpo64c=
X-Google-Smtp-Source: AGHT+IHuIyL9ztMuowx/zFHG+ZyJOY1o7cgdHO1kVT86WMOggPgWshcs4MHWP1Wrec29Wrg3k1ddXQ==
X-Received: by 2002:a05:6000:2af:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-3a35c835b52mr9875565f8f.34.1747648697357;
        Mon, 19 May 2025 02:58:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b2fc:6161:a86b:8382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm152811285e9.13.2025.05.19.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 19 May 2025 11:58:07 +0200
Subject: [PATCH v3 2/4] fetch: use batched reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-2-6cdfd4f769b9@gmail.com>
References: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
In-Reply-To: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 gitster@pobox.com, peff@peff.net
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10017;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=abyBqfybBCnH7UU8keEbMrkjS2R1G1iKu6KpY6Wf2qg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgrALX6R+MjH5C5TMyXOZw9B8tFHcs9QKSl2
 JXdklevZDwZHokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoKwC1AAoJED7VnySO
 Rox/svUL/jY+LuPjmb57EqeND4HIY8XFONxsBz31aQQDlwqhmiDnnBf5dTbqZTlOIq8AQAIyJhC
 C6K28JqGyxN2j6PTB8J+LKEvqJw2KaMNm1y/cX1a0jxM52rSTbqUHBWkX9wwaEJRe6T8DQ9YLKb
 le6IvFEITpsvKFRyP0vEzJCh/QXQ3Qdh8L268iOHe6BW/1SdZpWOgKsZwkjgjGv1jUvzygjD+1c
 iRVKG3IcLo3gcEjJfhiDeFv/Pwg1dfmS6poEuzPwkhwVFwjgcka4dI1tZyUnLyPAFAUb76eARXQ
 X/qDu9itS+hyOJLUJKYQXgLTmAFEK6Lx2yXDAwTUisqMH0SjdSQ9l2GOEIR5PwXBApNmEIZg15l
 Wdg3/+5HYR8yqhIvF+pOlvFTHFNOd0bUnelfFdOmJlDbrUPIAk4YD36H3uk5m3Kt+lzAaFAAjh7
 aUfRFyEMDkDulph7XW6KP+Wqh6ocpF2uRuMYPYhCTHcCChNxrmfngwI6x33ivza1/H5hr0ScYS5
 P0=
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
 builtin/fetch.c | 127 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 54 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5279997c96..f200194f77 100644
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
-
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
@@ -1688,6 +1644,36 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 	return result;
 }
 
+struct ref_rejection_data {
+	int *retcode;
+	int conflict_msg_shown;
+	const char *remote_name;
+};
+
+static void ref_transaction_rejection_handler(const char *refname,
+					      const struct object_id *old_oid UNUSED,
+					      const struct object_id *new_oid UNUSED,
+					      const char *old_target UNUSED,
+					      const char *new_target UNUSED,
+					      enum ref_transaction_error err,
+					      void *cb_data)
+{
+	struct ref_rejection_data *data = cb_data;
+
+	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+		error(_("some local refs could not be updated; try running\n"
+			" 'git remote prune %s' to remove any old, conflicting "
+			"branches"), data->remote_name);
+		data->conflict_msg_shown = 1;
+	} else {
+		const char *reason = ref_transaction_error_msg(err);
+
+		error(_("fetching ref %s failed: %s"), refname, reason);
+	}
+
+	*data->retcode = 1;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1808,6 +1794,24 @@ static int do_fetch(struct transport *transport,
 			retcode = 1;
 	}
 
+	/*
+	 * If not atomic, we can still use batched updates, which would be much
+	 * more performant. We don't initiate the transaction before pruning,
+	 * since pruning must be an independent step, to avoid F/D conflicts.
+	 *
+	 * TODO: if reference transactions gain logical conflict resolution, we
+	 * can delete and create refs (with F/D conflicts) in the same transaction
+	 * and this can be moved above the 'prune_refs()' block.
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
@@ -1839,16 +1843,31 @@ static int do_fetch(struct transport *transport,
 		free_refs(tags_ref_map);
 	}
 
-	if (transaction) {
-		if (retcode)
-			goto cleanup;
+	if (retcode)
+		goto cleanup;
 
-		retcode = ref_transaction_commit(transaction, &err);
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
+
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

