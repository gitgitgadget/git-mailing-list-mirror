Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68919D8A2
	for <git@vger.kernel.org>; Thu, 15 May 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318055; cv=none; b=T2mOvgcJKh7NAqhVVi1Lgbuf2uM5/wvx6lA7kBWLp5lq6XtFv0G/QTk0dSe4BPaSbJdW3r+R4uGtQTxiT6KuTkXEYK0dZ8b/38aWjUrB698Y/5tn8bb1UgLGoUD2rlJIPiTF3OQj1gKwyuf1Ree5OH+++cCi1zoOUeN9pgRySdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318055; c=relaxed/simple;
	bh=LFBMfkY7e/1KRBm4dwYlyuGwxrRktwmdyNSYzQ2f8wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CF+KGYU7mis10sltlqqt+6G9KhEfgAmW1wYcu8K/3ogaXa29kZ++YZEeZSCVTEe7CavJENi3Zt0hzaNRs+ZNU7+bPq56DwL7BiRU/grursBGxwMadRk0oCvkFlEoRoy6xc1tGze7P+gOLkC95SnOOYvjEFm6+ntnuBqVNTDnXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i43mA4Wz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i43mA4Wz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fc3f0a5506so1996333a12.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318051; x=1747922851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Glp4dkxY//D0impps8BXbvQlVelctE+n+E1I3HRTUuM=;
        b=i43mA4Wz0+Ib/IMCEujche8wjBwjGUMsX9gANUIQRhbJzJBV5jw8XULTiFsVud5Ozg
         GNgpAtPJ5rhOxHz97j/OabP3Jp1xI8yqq1C/lN9y16hZ43PbZyQqtoVJJDO3OchVHIdI
         S+XVAquPi1pMw4etmPTjuOv/l8OuRIq2YX8hFSgXnhdu3XFhOstm0Z9eIy1tf0ObdGFt
         ji7MWn45nq9nYgQDU0Vq9/jU2q/C7P5W+BoLqVG8k9OSHTqxUUJQnJim07yJxcED3ELe
         JbWpysC3QBMb5ZUDoUE1rPJQ/5eC3/n95fsGaB27xCFEWMOZkvfJCcaXGZ/kw5+IV9EP
         t8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318051; x=1747922851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Glp4dkxY//D0impps8BXbvQlVelctE+n+E1I3HRTUuM=;
        b=My/TFJinErM8RqF7lPFQ4bQ8arIu8ty7C6VYYpXrauO71vln9ylwlXl7UpC+HyIXcl
         2PFj0iKjrF5vZvbVB+GWW6tezAsBdFVGiIyCfgsXBQb8byUxwxhNqgrgEjRRE2OS+2bM
         6QOLa+IGaqZRj5PVpNiNUZbbKV7WkEhRGvFl8/6JIz4200KH2HNLRgKwez/spEe67Djn
         qpRjKfep+9AFX5CmWFQgUOxtXo2eX5Knjj2QofQEI5Z2u4oE8+p4CSN9wDU3dCgR1wSa
         gWBhHEvFNhyyv4OZd0T3oXGbldlwWAxC+rdB09POChezM+ir7PEUFXG0DLOjCcxJp0rR
         JIkw==
X-Gm-Message-State: AOJu0YxFgedgyINZSaVmzzZI5/nRuQf25M0B/Ojm3euuM9KhGsC3OHf7
	nSK9CJ/HXCrYbWMNqofnlvPx3YTi4YYRcK0pAUs29SWegsp702QD
X-Gm-Gg: ASbGncuDqda6Ht23NPF962GHNFhHjLvpeT15NF/OOnNsmk3qdmKI8NhklVzMYNVDyRT
	fansbvhKMx3pHiR0dD6W64k+k0mWTX5wEgwT/TNloIocXUIslR34W0Urh26lHO7sEmyRH3EMVO9
	/PMfWPY5azlJlzsLYARMDebQZF3a4Bfrt/u473Md3gmqkhlcQFUA5T4AiGGE4kkqpsglckIkema
	mPTgUDN0il1fOlgV1DuaRAvCiIejvWZpJ1yG+XlTBpLrL213EY/kM5My09R0k/tekxo/II+gzgZ
	+WzgRYNxR7kq33M20Kz5hSFb2JTk8LtYCknpvcTS6VCXz2PMeFKDEeqQL3KZIQ==
X-Google-Smtp-Source: AGHT+IH02NCjWw1pd3ikQ0DjigQnW+5UuMrU5qyb6I4M4ZE0SD8QcqGbh3vUW09wrFxrcLxKozUasA==
X-Received: by 2002:a05:6402:2811:b0:5fb:f708:2667 with SMTP id 4fb4d7f45d1cf-5ff988dd222mr6638298a12.33.1747318050356;
        Thu, 15 May 2025 07:07:30 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70e296sm10259434a12.75.2025.05.15.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:07:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 15 May 2025 16:07:26 +0200
Subject: [PATCH v2 2/4] fetch: use batched reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-2-80cbaaa55d2e@gmail.com>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10058;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=LFBMfkY7e/1KRBm4dwYlyuGwxrRktwmdyNSYzQ2f8wo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgl9R/zrBYVuGYFrj+ZOxpmJjgDfUmn3+Row
 JmIW0sMl+z4CIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJfUfAAoJED7VnySO
 Rox/1N4MAJF/8reMRCsYk08GxLGtd0L9Lfl9XQs9rT2vhlViqpS5KXh8TZU/SP8p8zBlScMwWCl
 xcn2Drp25TrBxI2WO5KT7t4e7/W6YVzal9Ve0rEVM0T6lbWgcDL4XI0AQqUUtScEvjcP29AW1i/
 vbnps2TmyCaSA5n/3UCNkQjvZZpe9m7QNKb8tlNuO5Np6kVaLSZIiraNdTLq5pZy2NeptxxCAwW
 kTK8eqBLQncJhGtYaFi+FwTn3s6zw5UEutbQevMs9Kzt587hZOpKbzpN05r7YLnPGozdOhs8lej
 gJZ1oxOKNJxbNS8+uGWL9IU6OlmkfI1ti/bAGDsDHzq5TTpgpGKJvZA0pegQcQ+9/m/oNgFLyIx
 HjSORi7UKBcKVpmgB1G69JyALtzNitbNxAdjIN8mHg9oEdYz3peIWhUs3BA/qsdGjO+Dm4hFMx2
 0ZS/VO7jG1FOE9MjyLlFhwJkSdvOiPiNIqHxoBx2pl6vEPTX/HES13cE4HY01w9OLvOA2EfKNo4
 KE=
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
 builtin/fetch.c | 128 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 54 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5279997c96..15eac2b1c2 100644
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
@@ -1688,6 +1644,37 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
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
+	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
+
+	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+		error(_("some local refs could not be updated; try running\n"
+			" 'git remote prune %s' to remove any old, conflicting "
+			"branches"), data->remote_name);
+		data->conflict_msg_shown = 1;
+	} else {
+		char *reason = ref_transaction_error_msg(err);
+
+		error(_("fetching ref %s failed: %s"), refname, reason);
+		free(reason);
+	}
+
+	*data->retcode = 1;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1808,6 +1795,24 @@ static int do_fetch(struct transport *transport,
 			retcode = 1;
 	}
 
+	/*
+	 * If not atomic, we can still use batched updates, which would be much
+	 * more performant. We don't initiate the transaction before pruning,
+	 * since pruning must be an independent step, to avoid F/D conflicts.
+	 *
+	 * TODO: if reference transactions gain logical conflict resolution, we
+	 * can delete and create refs (with F/D conflicts) in the same transaction
+	 * and this can be moved about the 'prune_refs()' block.
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
@@ -1839,16 +1844,31 @@ static int do_fetch(struct transport *transport,
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

