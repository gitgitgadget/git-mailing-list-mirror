Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340F30CD89
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598841; cv=none; b=cevCR4nBjsbBalWTk0/YngQMO3ojEtqxIotO5JVUBm4yu2HRev6UUeUdJC9Pkx5OuVX5g9ion36bA/u6rKCFEAX74LP6OFj4za4GOrTceizr1ID/iWNEdu+jhaGR5GkMjfQBu6zxi5+B0FS+386SjyoJ5ELL+wn+nvEwiNggarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598841; c=relaxed/simple;
	bh=nOYdmH5uy6KmIRSwkH2MDogFfhRAksImNJvjAvYyZpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4VydluECJyIk0uHjD//yA9A4g0RmL0vnCDciAZrpSpav1yWQjrtXzjWEhCRWM6rLpefZFTzClOQmx8r6g9Lrr2UyB7yJzARwNRhhDQihvqmb3MxhE+hc8Hw8W5gELzMcSG7iHLDNJwvUnXQHkay6kS1Y+d91NHakgncImbALPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ0DdbUp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ0DdbUp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so15797685e9.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598838; x=1769203638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMFyMmIpxlAv2D94CsqNbW0boKJaqPwtknFFlYUk0sM=;
        b=JZ0DdbUpa5hzPWnBbeK0h49ptN4V4WWrvSL2ZP6E/aH+5wlOZLAVFw3Y+R4iwNidF8
         vt882lm9AJNNP4eeW6BIRZbKEGCI4Ccm0yYR54UpreH67t1LQV0CBnZq+9AHbg3mQvPj
         ufQtyQu0dy1OyP0yqzvbv30bY4zYY4g1C3ep2RA+EEe7vWQcd4A6B3vW8RHcUBvPaV4+
         oStUiWXhuIa9gD+QrC6tZjrJqVIvY1a1ahFz3BvzGpyPje4H6mcQMwyFX6wM8/c2fHa8
         giNoyNiW9+Sj3ujDbPYI4JSyKmuGStqdYjN6Xw4zktot8sehLIUrpKYzmT1o9tYXzqGD
         29UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598838; x=1769203638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IMFyMmIpxlAv2D94CsqNbW0boKJaqPwtknFFlYUk0sM=;
        b=Ugy6GLU+soKe0qVpAwMtG5s57arovW9Yrzo+6s9E6ladtbJtSfIQ21cJN2ytZM0KE/
         d34ywKqWm2ULI29f/d3s/MZIBtxChtXU73k/xwIYYXyUgjr9B/jwkRQ8oVj00QNstOAb
         dXwpYNwAcg/eH2Lyzgux534lCThbY+2IYJwWN79q9/fa/8/sHlqrVm/CXojORN7vwYAn
         lMOdF+nlaOsOIJO2meyopbP/AaN9fA+lFumvabq6Y5WKSNTZdORIO4PbfFq9klngLXpu
         JQnrXwvagbn9kpFI/UfyTlHutbLoFTUGGkBPbRegmCNBs/MpAegnbMBrtUvM0Rg3pf/X
         ThGg==
X-Gm-Message-State: AOJu0YwQLR10pyUFS0AMugT3FpTc7uWTR3HOS/2D2ohZNEDtrNZCN69O
	1bPO5mUyzpCinWQA3/rL2b4mjbPaP9xcdwG+voEPto2wopxcffOgBZLM
X-Gm-Gg: AY/fxX72+knATv/Sdkqhcri5mErMPkbhVTvlmi5/zf6iE7LKirgmU6njTZ/ekx5s/VI
	gpKC9rccph74K7MU/uFvgWF2uj/2sd9D7PYnzu9L3PCSkfXOnRYL0I66WYpxNguX7TV68CAuTlf
	90P4KUilZoXHUf2TNtnORC5rlSnAw7ukRne0lAFdf6LOKlMqsO/yiG9R5lokQ2zlzVzMeh+qdih
	IRXtCWAwwvkbD23G1fsNZv2bg9ZjyyrgQPc9d59st16WjmFGNvYkXvy2rdsiIp/PrjcaWKEI5cR
	Xiu7xRVwOPXe5RnDB2MO4TBQ7/6TSpfTL+bWAK8EUzvVdOb1d/W9k5lrTSTQOG5S0mIuRqg4y36
	5/DgMOb6k5eKeGivNVW1Rv9lmUObGi8z/mbj862SBb9hrtqkeSlWnEhNc1caLGRlnsCf3XrCztk
	22dyr6FqXSx8klFI1ZHR8=
X-Received: by 2002:a05:600c:548c:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-4801e342fbemr57284735e9.27.1768598838065;
        Fri, 16 Jan 2026 13:27:18 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:17 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:12 +0100
Subject: [PATCH v2 7/7] fetch: delay user information post committing of
 transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-7-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18419;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=nOYdmH5uy6KmIRSwkH2MDogFfhRAksImNJvjAvYyZpE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrS0eRzJ3rAyh04PfmvvT/F3q1+PrRYHBp
 OdBDpIQqhy+iYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0tAAoJED7VnySO
 Rox/vrkMAIS5vO7wFwS4ieTr1jHPgMuJZFSb0CHMYFIvTpWWm3JuJGVS5La94XKQkPKWbJUWipk
 z3GUu0PhkNBDVbR3SbfS7A6Y8isT11hcgPgaPRydqtPiDfKVeFa7j8PLC3IZ2Ksdr329Wmo/RgM
 px2WC0jKJJq/uQ7e/NxVhqZXJhNciRPIkEzliMdkqjJ5acoFilTIDkW+0B6ZifZvrZ5pBPbBW83
 j3MQsBHf0w6lwkuvYrnChXRC9zk1JWWwgW4mOxrFNuwLCM4vy7AQlT8tnoXYVTJK9Cf6Ng3JxTv
 yhumyhJDzR78vSaZRfTQXLOrUBANKkBVjua6rmA6PYbNj/uVNRl4rFe146sMo6nn9R8U1sIXpTr
 4ZnXavN5juGCkZHSEghaio+hbI17ievH+8E86GzX9Dl+OcHOAw5Esm0AOprGEsvIOIoav02FprM
 b9TtNL4InTsH2jEkwAhDgkHeAO3i0pZq+ROML/xZ/4ZeZTHRvXhMhUsUdJ/tEqzAa1y+2POy7x9
 Ik=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In Git 2.50 and earlier, we would display failure codes and error
message as part of the status display:

  $ git fetch . v1.0.0:refs/heads/foo
    error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
    From .
     ! [new tag]               v1.0.0     -> foo  (unable to update local ref)

With the addition of batched updates, this information is no longer
shown to the user:

  $ git fetch . v1.0.0:refs/heads/foo
    From .
     * [new tag]               v1.0.0     -> foo
    error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'

Since reference updates are batched and processed together at the end,
information around the outcome is not available during individual
reference parsing.

To overcome this, collate and delay the output to the end. Introduce
`ref_update_display_info` which will hold individual update's
information and also whether the update failed or succeeded. This
finally allows us to iterate over all such updates and print them to the
user. While this brings back the functionality, it does change the order
of the output. Modify the tests to reflect this.

Using an strmap does add some overhead to 'git-fetch(1)', but from
benchmarking this seems to be not too bad:

  Benchmark 1: fetch: many refs (refformat = files, refcount = 1000, revision = master)
    Time (mean ± σ):      51.9 ms ±   2.5 ms    [User: 15.6 ms, System: 36.9 ms]
    Range (min … max):    47.4 ms …  58.3 ms    41 runs

  Benchmark 2: fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
    Time (mean ± σ):      53.0 ms ±   1.8 ms    [User: 17.6 ms, System: 36.0 ms]
    Range (min … max):    49.4 ms …  57.6 ms    40 runs

  Summary
    fetch: many refs (refformat = files, refcount = 1000, revision = master) ran
      1.02 ± 0.06 times faster than fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)

Another approach would be to move the status printing logic to be
handled post the transaction being committed. That however would require
adding an iterator to the ref transaction that tracks both the outcome
(success/failure) and the original refspec information for each update,
which is more involved infrastructure work compared to the strmap
approach here.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c         | 179 ++++++++++++++++++++++++++++++++++++++++--------
 t/t5516-fetch-push.sh   |   1 +
 t/t5574-fetch-output.sh |  16 ++---
 3 files changed, 161 insertions(+), 35 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 49495be0b6..afe5d321d1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -861,12 +861,77 @@ static void display_ref_update(struct display_state *display_state, char code,
 	fputs(display_state->buf.buf, f);
 }
 
+struct ref_update_display_info {
+	bool failed;
+	char success_code;
+	char fail_code;
+	const char *summary;
+	const char *fail_detail;
+	const char *success_detail;
+	const char *remote;
+	const char *local;
+	struct object_id old_oid;
+	struct object_id new_oid;
+};
+
+static struct ref_update_display_info *ref_update_display_info_new(
+						char success_code,
+						char fail_code,
+						const char *summary,
+						const char *success_detail,
+						const char *fail_detail,
+						const char *remote,
+						const struct object_id *old_oid,
+						const struct object_id *new_oid)
+{
+	struct ref_update_display_info *info;
+	CALLOC_ARRAY(info, 1);
+
+	info->success_code = success_code;
+	info->fail_code = fail_code;
+	info->summary = xstrdup(summary);
+	info->success_detail = xstrdup_or_null(success_detail);
+	info->fail_detail = xstrdup_or_null(fail_detail);
+	info->remote = xstrdup(remote);
+
+	oidcpy(&info->old_oid, old_oid);
+	oidcpy(&info->new_oid, new_oid);
+
+	return info;
+}
+
+static void ref_update_display_info_set_failed(struct ref_update_display_info *info)
+{
+	info->failed = true;
+}
+
+static void ref_update_display_info_free(struct ref_update_display_info *info)
+{
+	free((char *)info->summary);
+	free((char *)info->success_detail);
+	free((char *)info->fail_detail);
+	free((char *)info->remote);
+}
+
+static void ref_update_display_info_display(struct ref_update_display_info *info,
+					    struct display_state *display_state,
+					    const char *refname, int summary_width)
+{
+	display_ref_update(display_state,
+			   info->failed ? info->fail_code : info->success_code,
+			   info->summary,
+			   info->failed ? info->fail_detail : info->success_detail,
+			   info->remote, refname, &info->old_oid,
+			   &info->new_oid, summary_width);
+}
+
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    struct display_state *display_state,
 			    const struct ref *remote_ref,
 			    int summary_width,
-			    const struct fetch_config *config)
+			    const struct fetch_config *config,
+			    struct strmap *delayed_ref_display)
 {
 	struct commit *current = NULL, *updated;
 	int fast_forward = 0;
@@ -900,12 +965,19 @@ static int update_local_ref(struct ref *ref,
 	if (!is_null_oid(&ref->old_oid) &&
 	    starts_with(ref->name, "refs/tags/")) {
 		if (force || ref->force) {
+			struct ref_update_display_info *info;
 			int r;
+
 			r = s_update_ref("updating tag", ref, transaction, 0);
-			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
-					   r ? _("unable to update local ref") : NULL,
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+
+			info = ref_update_display_info_new('t', '!', _("[tag update]"), NULL,
+							   _("unable to update local ref"),
+							   remote_ref->name, &ref->old_oid,
+							   &ref->new_oid);
+			if (r)
+				ref_update_display_info_set_failed(info);
+			strmap_put(delayed_ref_display, ref->name, info);
+
 			return r;
 		} else {
 			display_ref_update(display_state, '!', _("[rejected]"),
@@ -921,6 +993,7 @@ static int update_local_ref(struct ref *ref,
 	updated = lookup_commit_reference_gently(the_repository,
 						 &ref->new_oid, 1);
 	if (!current || !updated) {
+		struct ref_update_display_info *info;
 		const char *msg;
 		const char *what;
 		int r;
@@ -941,10 +1014,15 @@ static int update_local_ref(struct ref *ref,
 		}
 
 		r = s_update_ref(msg, ref, transaction, 0);
-		display_ref_update(display_state, r ? '!' : '*', what,
-				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_new('*', '!', what, NULL,
+						   _("unable to update local ref"),
+						   remote_ref->name, &ref->old_oid,
+						   &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+		strmap_put(delayed_ref_display, ref->name, info);
+
 		return r;
 	}
 
@@ -960,6 +1038,7 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (fast_forward) {
+		struct ref_update_display_info *info;
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
 
@@ -967,23 +1046,36 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r = s_update_ref("fast-forward", ref, transaction, 1);
-		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
-				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_new(' ', '!', quickref.buf, NULL,
+						   _("unable to update local ref"),
+						   remote_ref->name, &ref->old_oid,
+						   &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+		strmap_put(delayed_ref_display, ref->name, info);
+
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
+		struct ref_update_display_info *info;
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
+
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r = s_update_ref("forced-update", ref, transaction, 1);
-		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
-				   r ? _("unable to update local ref") : _("forced update"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_new('+', '!', quickref.buf,
+						   _("forced update"),
+						   _("unable to update local ref"),
+						   remote_ref->name, &ref->old_oid,
+						   &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+		strmap_put(delayed_ref_display, ref->name, info);
+
 		strbuf_release(&quickref);
 		return r;
 	} else {
@@ -1103,7 +1195,8 @@ static int store_updated_refs(struct display_state *display_state,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head,
-			      const struct fetch_config *config)
+			      const struct fetch_config *config,
+			      struct strmap *delayed_ref_display)
 {
 	int rc = 0;
 	struct strbuf note = STRBUF_INIT;
@@ -1219,7 +1312,8 @@ static int store_updated_refs(struct display_state *display_state,
 
 			if (ref) {
 				rc |= update_local_ref(ref, transaction, display_state,
-						       rm, summary_width, config);
+						       rm, summary_width, config,
+						       delayed_ref_display);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1300,7 +1394,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
 				  struct fetch_head *fetch_head,
-				  const struct fetch_config *config)
+				  const struct fetch_config *config,
+				  struct strmap *delayed_ref_display)
 {
 	int connectivity_checked = 1;
 	int ret;
@@ -1322,7 +1417,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret = store_updated_refs(display_state, connectivity_checked,
-				 transaction, ref_map, fetch_head, config);
+				 transaction, ref_map, fetch_head, config,
+				 delayed_ref_display);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
 
 out:
@@ -1493,7 +1589,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
-			 const struct fetch_config *config)
+			 const struct fetch_config *config,
+			 struct strmap *delayed_ref_display)
 {
 	int retcode, cannot_reuse;
 
@@ -1515,7 +1612,7 @@ static int backfill_tags(struct display_state *display_state,
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
 	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
-					 fetch_head, config);
+					 fetch_head, config, delayed_ref_display);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1641,6 +1738,7 @@ struct ref_rejection_data {
 	bool conflict_msg_shown;
 	bool case_sensitive_msg_shown;
 	const char *remote_name;
+	struct strmap *delayed_ref_display;
 };
 
 static void ref_transaction_rejection_handler(const char *refname,
@@ -1653,6 +1751,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
+	struct ref_update_display_info *info;
 
 	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
 	    !data->case_sensitive_msg_shown) {
@@ -1681,6 +1780,10 @@ static void ref_transaction_rejection_handler(const char *refname,
 			      refname, ref_transaction_error_msg(err));
 	}
 
+	info = strmap_get(data->delayed_ref_display, refname);
+	if (info)
+		ref_update_display_info_set_failed(info);
+
 	*data->retcode = 1;
 }
 
@@ -1690,6 +1793,7 @@ static void ref_transaction_rejection_handler(const char *refname,
  */
 static int commit_ref_transaction(struct ref_transaction **transaction,
 				  bool is_atomic, const char *remote_name,
+				  struct strmap *delayed_ref_display,
 				  struct strbuf *err)
 {
 	int retcode = ref_transaction_commit(*transaction, err);
@@ -1701,6 +1805,7 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
 			.conflict_msg_shown = 0,
 			.remote_name = remote_name,
 			.retcode = &retcode,
+			.delayed_ref_display = delayed_ref_display,
 		};
 
 		ref_transaction_for_each_rejected_update(*transaction,
@@ -1729,6 +1834,10 @@ static int do_fetch(struct transport *transport,
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
 	int do_set_head = 0;
+	struct strmap delayed_ref_display = STRMAP_INIT;
+	int summary_width = 0;
+	struct strmap_entry *e;
+	struct hashmap_iter iter;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1853,7 +1962,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
-				   &fetch_head, config)) {
+				   &fetch_head, config, &delayed_ref_display)) {
 		retcode = 1;
 		goto cleanup;
 	}
@@ -1876,7 +1985,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config))
+					  &fetch_head, config, &delayed_ref_display))
 				retcode = 1;
 		}
 
@@ -1886,8 +1995,12 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
+	if (verbosity >= 0)
+		summary_width = transport_summary_width(ref_map);
+
 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
-					 transport->remote->name, &err);
+					 transport->remote->name,
+					 &delayed_ref_display, &err);
 	/*
 	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
 	 * continue to fetch head and perform other post-fetch operations.
@@ -1965,7 +2078,17 @@ static int do_fetch(struct transport *transport,
 	 */
 	if (retcode && !atomic_fetch && transaction)
 		commit_ref_transaction(&transaction, false,
-				       transport->remote->name, &err);
+				       transport->remote->name,
+				       &delayed_ref_display, &err);
+
+	/*
+	 * Clear any pending information that needs to be shown to the user.
+	 */
+	strmap_for_each_entry(&delayed_ref_display, &iter, e) {
+		struct ref_update_display_info *info = e->value;
+		ref_update_display_info_display(info, &display_state, e->key, summary_width);
+		ref_update_display_info_free(info);
+	}
 
 	if (retcode) {
 		if (err.len) {
@@ -1980,6 +2103,8 @@ static int do_fetch(struct transport *transport,
 
 	if (transaction)
 		ref_transaction_free(transaction);
+
+	strmap_clear(&delayed_ref_display, 1);
 	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 45595991c8..29e2f17608 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1893,6 +1893,7 @@ test_expect_success 'pushing non-commit objects should report error' '
 
 		tagsha=$(git rev-parse test^{tag}) &&
 		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
+		test_grep "! \[remote rejected\] $tagsha -> branch (invalid new value provided)" err &&
 		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
 	)
 '
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 5883839a04..22bfc0c74d 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -40,8 +40,8 @@ test_expect_success 'fetch aligned output' '
 		grep -e "->" actual | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
-	main                 -> origin/main
 	looooooooooooong-tag -> looooooooooooong-tag
+	main                 -> origin/main
 	EOF
 	test_cmp expect actual
 '
@@ -55,8 +55,8 @@ test_expect_success 'fetch compact output' '
 		grep -e "->" actual | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
-	main       -> origin/*
 	extraaa    -> *
+	main       -> origin/*
 	EOF
 	test_cmp expect actual
 '
@@ -103,15 +103,15 @@ do
 		cat >expect <<-EOF &&
 		- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
 		- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
-		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
 		! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
+		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
+		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
 		* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
 		  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
-		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
-		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
 		  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
-		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
-		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
 		EOF
 
 		# Change the URL of the repository to fetch different references.
@@ -179,8 +179,8 @@ test_expect_success 'fetch porcelain overrides fetch.output config' '
 	new_commit=$(git rev-parse HEAD) &&
 
 	cat >expect <<-EOF &&
-	  $old_commit $new_commit refs/remotes/origin/config-override
 	* $ZERO_OID $new_commit refs/tags/new-commit
+	  $old_commit $new_commit refs/remotes/origin/config-override
 	EOF
 
 	git -C porcelain -c fetch.output=compact fetch --porcelain >stdout 2>stderr &&

-- 
2.51.2

