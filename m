Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A576382376
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379238; cv=none; b=qoy+dThJIRpd38b2TYqi5SQSZiqUwKYN8B6/WIsGi1SGiq8OJ8oZK+ULy3jfC/4Cle5MTY5XuKCr2gAWTTQt2RTPeL3iRU4BiyZ/hC4qHrUNA7Gp+7Au7+oJL2zcb5GMctl+ia9xrXft30lhIwAcDxt0oiXqbcQUU0K9/LzSvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379238; c=relaxed/simple;
	bh=eiUzVSyueaANtUszCYetmqEYlGzKuYY8xz7tEANU7IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJUXNoYDuLDHDfGxGTqHXtd6vUDM1NT5etu7XIsDN14bh5uVJWovuSmmuSZA6N2qfEOVdMdDaDt8mKDJxLODHG9n6HdWFJfE4UVEGHFsotJcsIz8T9b9RHj0xJf4L/F93eEu7TS42bMuC26BiubVgTBy6q3TOVcXpmhGiH4RpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TxrwEKN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JGUgC726; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TxrwEKN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JGUgC726"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A39F1D000BE;
	Thu, 25 Jun 2026 05:20:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 25 Jun 2026 05:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379232;
	 x=1782465632; bh=4PZM+fCV/8/JFCTnksmcFZroKvS2U449Fe08ye2w5Yg=; b=
	TxrwEKN2Gb34BlARnTLj9P3jnaVlH0sz+qsiz16EkFcW3BnjQ0t3tqPqmzqTFITx
	Rgt8TfCNJm6A8AH33dPSSM9gv8vqf/65LP6Iqg5n8nkQjHGlXrSi9YBUvT6j8kuw
	KUGIYDDrDm7uiP8ayZ9pU9kv9TElYNsZrWzBFC+oJnb4mvU76jqlrla8yU+cL44/
	uwZde5g9ZaK/hPvP4BInToXsig2YdbUFOL1iB2yWK3vwX5NJK0+FpTUBigK3ZG3G
	FKI3H8EC02Vec3JfdVIEO9Rp8kZrubvdYRHUPfTCK+/yYvTFs5bG0uN+rJkWvibv
	K2CVSh6JJIR/4c30uuzKqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379232; x=
	1782465632; bh=4PZM+fCV/8/JFCTnksmcFZroKvS2U449Fe08ye2w5Yg=; b=J
	GUgC726KdXGd6dcsCBY6s7xyY75q4aS+HwfS8U9K78Op26zESnPRc8mdZDOWxP97
	Z82klrg5ahwneSC3thWODm+8aDkT+RLnfSXu9citKsm+FzuKs8dkLE6fnjU+Cg5z
	N5AbJxpIdX5mlEC4LgmmwUL4fWY3Tx5fU0nCgrdPGlGpq5srEzycRJt7yZcTxpXG
	bTHpLFs4Jd1pgL7z479Xod0t8rgjk0sheyNa+0PLt/kXdR5V2vIrmrVxeY/sWOkk
	ToeHTlNzdumStnH970fACT3Y3kAc82GdUyt4H4qOA27E+9x/fF7ttaEDwFGsBm+R
	/N/GIFFlTuLP3zPpnPO5Q==
X-ME-Sender: <xms:4PI8agBNkpdsan5kYYxEbF4fMHeS1xXDdLCvmNB_Pdirf9RAOCZREQ>
    <xme:4PI8apiJp1nMHzHfaIcvfwJHqYOFIuIt9_UZIdtBHpr9wYLXJ7sf9u2jHMcAIAjKo
    ImGOjr-ks7zjjTxzP1GE8HEL8-z-puXfPACmzbUcoQW7dnstAycoQ>
X-ME-Received: <xmr:4PI8aokz_sdp6MhV4srUpsG5F8RhrL7l0v1BsXYD_EArhDRd7HIH0nMNpYZ1xrEaf0rf_c2VQKMDvXTK5-2jiZBrub6C24BirQzCdyEhfA>
X-ME-Proxy-Cause: dmFkZTFJny8F8bT1vobP8mT/gHA8dRfG54tdLYssF9mGrBAZ33fvzfK1eqPxa29sDtYAhN
    5tkjpw8eG7f8oUYXwWxFvXTfK5hurMwltmfD04NzD/ZqkQDnNm5LG5e+36110BPFzMSHq2
    HQfiw4sPCG9XizI+bbWfQ70k6NFeQGil+Q4g9AnIT5X8yKcTuUqmWhXByog3KGvZ/ni4kX
    k9V/L/9g4/bQonvKK8Brc7cK3ZOQt+0LqTZPmn4ByHyhrpuP3EGvOEGRCSWZpe6rchkvz9
    cVZP4E7MkYqSCORu71W7wFgpoNuZR9ZptCacni39b4NdZsabOObv28iAAOaljK7R002QmU
    2Jv7yL5oNMshmYJWk6Fd1LMkB0vK1YjszyAmdP7xQzB6hsmXuvxsIqtVGPjW+tMVWdtf6s
    MA6dV2TdhPWd0LNswdAE/w9pD05pDm3SL7EGItjZjJNK7GZKuBXijFcaev685SoggUpxz4
    imEBK3B2RoNDEqYhYzcEBZWY/dJjNMePEFej04QJTlIf1GuGrSyzxRSxSUZNmDSK3ONh7x
    Q/Dg9kgyU/aTJekqujQPk4EHEtwhMHj3J8PKCOxVtuUyG+gEgCK9z/2Y+/7u8YOkH0Auby
    savC6XwY4GHeM1QPV2M9rwwogcVoyhw6rzUVLljcbrFXX73UutrNBVj5tnKA
X-ME-Proxy: <xmx:4PI8aloV9bIZDse2DqvZMgcsz01cWf9GY-jfBHrf_qk7VmTA4oWN5g>
    <xmx:4PI8ahEpwstYflOJGSgB4JSc_0zQFYtsM-45ecexrdsZ1dOjQBZs7Q>
    <xmx:4PI8ahwQ0xqyIRmHAR4bWhSx7N4YkTrI-gVe2FK_xOErpjXzdBX-FA>
    <xmx:4PI8amoXErZ8mhVtmtXTDqq-ECx0QS3eM_umxiMKMANzaLutTWQh8A>
    <xmx:4PI8aooG5cJP7uBT3wr03qwWxNRWOGgbJGPkBw_ORtqnrbAkiDYERLv8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57db0672 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:07 +0200
Subject: [PATCH v6 09/11] reftable: split up write options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-9-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When initializing the reftable stack the caller may optionally pass some
write options. These write options mix up two different concerns though:

  - Of course, they allow the caller to configure how new reftables are
    being written.

  - But they also allow the caller to configure the stack itself, like
    its hash ID and the `on_reload` callback.

This is somewhat awkward, as it doesn't easily give the caller the
flexibility to for example write multiple reftables with different
options. Furthermore, this requires us to eagerly parse relevant
configuration when initializing the reftable backend.

Refactor the code by splitting out those options that configure the
stack itself. Creating a new stack will thus only require this limited
set of options, whereas the caller is expected to pass write options to
all functions that end up writing tables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c             |  29 +++---
 reftable/reftable-stack.h           |  30 +++++-
 reftable/reftable-writer.h          |  17 +---
 reftable/stack.c                    | 100 ++++++++++++-------
 reftable/stack.h                    |   2 +-
 reftable/writer.c                   |  21 ++--
 reftable/writer.h                   |   1 +
 t/helper/test-reftable.c            |   2 +-
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/lib-reftable.h         |   2 +
 t/unit-tests/u-reftable-merged.c    |   9 +-
 t/unit-tests/u-reftable-readwrite.c |  38 ++++++--
 t/unit-tests/u-reftable-stack.c     | 189 ++++++++++++++++--------------------
 t/unit-tests/u-reftable-table.c     |   8 +-
 14 files changed, 258 insertions(+), 198 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5115a3f4ce..608d71cf10 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -48,9 +48,9 @@ static void reftable_backend_on_reload(void *payload)
 
 static int reftable_backend_init(struct reftable_backend *be,
 				 const char *path,
-				 const struct reftable_write_options *_opts)
+				 const struct reftable_stack_options *_opts)
 {
-	struct reftable_write_options opts = *_opts;
+	struct reftable_stack_options opts = *_opts;
 	opts.on_reload = reftable_backend_on_reload;
 	opts.on_reload_payload = be;
 	return reftable_new_stack(&be->stack, path, &opts);
@@ -140,6 +140,7 @@ struct reftable_ref_store {
 	 * is populated lazily when we try to resolve `worktrees/$worktree` refs.
 	 */
 	struct strmap worktree_backends;
+	struct reftable_stack_options stack_options;
 	struct reftable_write_options write_options;
 
 	unsigned int store_flags;
@@ -190,7 +191,7 @@ static int backend_for_worktree(struct reftable_backend **out,
 
 	CALLOC_ARRAY(*out, 1);
 	store->err = ret = reftable_backend_init(*out, worktree_dir.buf,
-						 &store->write_options);
+						 &store->stack_options);
 	if (ret < 0) {
 		free(*out);
 		goto out;
@@ -404,10 +405,10 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	switch (repo->hash_algo->format_id) {
 	case GIT_SHA1_FORMAT_ID:
-		refs->write_options.hash_id = REFTABLE_HASH_SHA1;
+		refs->stack_options.hash_id = REFTABLE_HASH_SHA1;
 		break;
 	case GIT_SHA256_FORMAT_ID:
-		refs->write_options.hash_id = REFTABLE_HASH_SHA256;
+		refs->stack_options.hash_id = REFTABLE_HASH_SHA256;
 		break;
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
@@ -441,7 +442,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	}
 	strbuf_addstr(&path, "/reftable");
 	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
-					  &refs->write_options);
+					  &refs->stack_options);
 	if (refs->err)
 		goto done;
 
@@ -457,7 +458,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 		strbuf_addstr(&refdir, "/reftable");
 
 		refs->err = reftable_backend_init(&refs->worktree_backend, refdir.buf,
-						  &refs->write_options);
+						  &refs->stack_options);
 		if (refs->err)
 			goto done;
 	}
@@ -997,6 +998,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		struct reftable_addition *addition;
 
 		ret = reftable_stack_new_addition(&addition, be->stack,
+						  &refs->write_options,
 						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
@@ -1685,9 +1687,9 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 		stack = refs->main_backend.stack;
 
 	if (opts->flags & REFS_OPTIMIZE_AUTO)
-		ret = reftable_stack_auto_compact(stack);
+		ret = reftable_stack_auto_compact(stack, &refs->write_options);
 	else
-		ret = reftable_stack_compact_all(stack, NULL);
+		ret = reftable_stack_compact_all(stack, &refs->write_options, NULL);
 	if (ret < 0) {
 		ret = error(_("unable to compact stack: %s"),
 			    reftable_error_str(ret));
@@ -1721,8 +1723,8 @@ static int reftable_be_optimize_required(struct ref_store *ref_store,
 	if (opts->flags & REFS_OPTIMIZE_AUTO)
 		use_heuristics = true;
 
-	return reftable_stack_compaction_required(stack, use_heuristics,
-						  required);
+	return reftable_stack_compaction_required(stack, &refs->write_options,
+						  use_heuristics, required);
 }
 
 struct write_create_symref_arg {
@@ -1979,6 +1981,7 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
+				 &refs->write_options,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
@@ -2009,6 +2012,7 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
+				 &refs->write_options,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
@@ -2374,6 +2378,7 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 	arg.stack = be->stack;
 
 	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg,
+				 &refs->write_options,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
@@ -2446,6 +2451,7 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 	arg.stack = be->stack;
 
 	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg,
+				 &refs->write_options,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 	assert(ret != REFTABLE_API_ERROR);
@@ -2568,6 +2574,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		goto done;
 
 	ret = reftable_stack_new_addition(&add, be->stack,
+					  &refs->write_options,
 					  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 	if (ret < 0)
 		goto done;
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 5f7be573fa..11f9963f4f 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -26,11 +26,29 @@
  */
 struct reftable_stack;
 
+/* Options related to opening a stack. */
+struct reftable_stack_options {
+	/*
+	 * 4-byte identifier ("sha1", "s256") of the hash. Defaults to SHA1 if
+	 * unset.
+	 */
+	enum reftable_hash hash_id;
+
+	/*
+	 * Callback function to execute whenever the stack is being reloaded.
+	 * This can be used e.g. to discard cached information that relies on
+	 * the old stack's data. The payload data will be passed as argument to
+	 * the callback.
+	 */
+	void (*on_reload)(void *payload);
+	void *on_reload_payload;
+};
+
 /* open a new reftable stack. The tables along with the table list will be
  *  stored in 'dir'. Typically, this should be .git/reftables.
  */
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       const struct reftable_write_options *opts);
+		       const struct reftable_stack_options *opts);
 
 /* returns the update_index at which a next table should be written. */
 uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
@@ -52,6 +70,7 @@ enum {
  */
 int reftable_stack_new_addition(struct reftable_addition **dest,
 				struct reftable_stack *st,
+				const struct reftable_write_options *opts,
 				unsigned int flags);
 
 /* Adds a reftable to transaction. */
@@ -77,7 +96,9 @@ void reftable_addition_destroy(struct reftable_addition *add);
 int reftable_stack_add(struct reftable_stack *st,
 		       int (*write_table)(struct reftable_writer *wr,
 					  void *write_arg),
-		       void *write_arg, unsigned flags);
+		       void *write_arg,
+		       const struct reftable_write_options *opts,
+		       unsigned flags);
 
 struct reftable_iterator;
 
@@ -122,6 +143,7 @@ struct reftable_log_expiry_config {
 /* compacts all reftables into a giant table. Expire reflog entries if config is
  * non-NULL */
 int reftable_stack_compact_all(struct reftable_stack *st,
+			       const struct reftable_write_options *opts,
 			       struct reftable_log_expiry_config *config);
 
 /*
@@ -132,11 +154,13 @@ int reftable_stack_compact_all(struct reftable_stack *st,
  * compacted to maintain geometric progression.
  */
 int reftable_stack_compaction_required(struct reftable_stack *st,
+				       const struct reftable_write_options *opts,
 				       bool use_heuristics,
 				       bool *required);
 
 /* heuristically compact unbalanced table stack. */
-int reftable_stack_auto_compact(struct reftable_stack *st);
+int reftable_stack_auto_compact(struct reftable_stack *st,
+				const struct reftable_write_options *opts);
 
 /* delete stale .ref tables. */
 int reftable_stack_clean(struct reftable_stack *st);
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index a66db415c8..6ff4ddfc60 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -28,11 +28,6 @@ struct reftable_write_options {
 	/* how often to write complete keys in each block. */
 	uint16_t restart_interval;
 
-	/* 4-byte identifier ("sha1", "s256") of the hash.
-	 * Defaults to SHA1 if unset
-	 */
-	enum reftable_hash hash_id;
-
 	/* Default mode for creating files. If unset, use 0666 (+umask) */
 	unsigned int default_permissions;
 
@@ -60,15 +55,6 @@ struct reftable_write_options {
 	 * negative value will cause us to block indefinitely.
 	 */
 	long lock_timeout_ms;
-
-	/*
-	 * Callback function to execute whenever the stack is being reloaded.
-	 * This can be used e.g. to discard cached information that relies on
-	 * the old stack's data. The payload data will be passed as argument to
-	 * the callback.
-	 */
-	void (*on_reload)(void *payload);
-	void *on_reload_payload;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
@@ -114,7 +100,8 @@ struct reftable_writer;
 int reftable_writer_new(struct reftable_writer **out,
 			ssize_t (*writer_func)(void *, const void *, size_t),
 			int (*flush_func)(void *),
-			void *writer_arg, const struct reftable_write_options *opts);
+			void *writer_arg, enum reftable_hash hash_id,
+			const struct reftable_write_options *opts);
 
 /*
  * Set the range of update indices for the records we will add. When writing a
diff --git a/reftable/stack.c b/reftable/stack.c
index 1fba96ddb3..ab12926708 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -501,10 +501,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 }
 
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       const struct reftable_write_options *_opts)
+		       const struct reftable_stack_options *_opts)
 {
 	struct reftable_buf list_file_name = REFTABLE_BUF_INIT;
-	struct reftable_write_options opts = { 0 };
+	struct reftable_stack_options opts = { 0 };
 	struct reftable_stack *p;
 	int err;
 
@@ -629,6 +629,7 @@ int reftable_stack_reload(struct reftable_stack *st)
 struct reftable_addition {
 	struct reftable_flock tables_list_lock;
 	struct reftable_stack *stack;
+	struct reftable_write_options opts;
 
 	char **new_tables;
 	size_t new_tables_len, new_tables_cap;
@@ -657,6 +658,7 @@ static void reftable_addition_close(struct reftable_addition *add)
 
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,
+					const struct reftable_write_options *opts,
 					unsigned int flags)
 {
 	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
@@ -664,15 +666,17 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 
 	memset(add, 0, sizeof(*add));
 	add->stack = st;
+	if (opts)
+		add->opts = *opts;
 
 	err = flock_acquire(&add->tables_list_lock, st->list_file,
-			    st->opts.lock_timeout_ms);
+			    add->opts.lock_timeout_ms);
 	if (err < 0)
 		goto done;
 
-	if (st->opts.default_permissions) {
+	if (add->opts.default_permissions) {
 		if (chmod(add->tables_list_lock.path,
-			  st->opts.default_permissions) < 0) {
+			  add->opts.default_permissions) < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -702,12 +706,14 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 static int stack_try_add(struct reftable_stack *st,
 			 int (*write_table)(struct reftable_writer *wr,
 					    void *arg),
-			 void *arg, unsigned flags)
+			 void *arg,
+			 const struct reftable_write_options *opts,
+			 unsigned flags)
 {
 	struct reftable_addition add;
 	int err;
 
-	err = reftable_stack_init_addition(&add, st, flags);
+	err = reftable_stack_init_addition(&add, st, opts, flags);
 	if (err < 0)
 		goto done;
 
@@ -723,9 +729,11 @@ static int stack_try_add(struct reftable_stack *st,
 
 int reftable_stack_add(struct reftable_stack *st,
 		       int (*write)(struct reftable_writer *wr, void *arg),
-		       void *arg, unsigned flags)
+		       void *arg,
+		       const struct reftable_write_options *opts,
+		       unsigned flags)
 {
-	int err = stack_try_add(st, write, arg, flags);
+	int err = stack_try_add(st, write, arg, opts, flags);
 	if (err < 0) {
 		if (err == REFTABLE_OUTDATED_ERROR) {
 			/* Ignore error return, we want to propagate
@@ -810,7 +818,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (err)
 		goto done;
 
-	if (!add->stack->opts.disable_auto_compact) {
+	if (!add->opts.disable_auto_compact) {
 		/*
 		 * Auto-compact the stack to keep the number of tables in
 		 * control. It is possible that a concurrent writer is already
@@ -820,7 +828,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 		 * concurrent writer, which causes `REFTABLE_OUTDATED_ERROR`.
 		 * Both of these errors are benign, so we simply ignore them.
 		 */
-		err = reftable_stack_auto_compact(add->stack);
+		err = reftable_stack_auto_compact(add->stack, &add->opts);
 		if (err < 0 && err != REFTABLE_LOCK_ERROR &&
 		    err != REFTABLE_OUTDATED_ERROR)
 			goto done;
@@ -834,6 +842,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 
 int reftable_stack_new_addition(struct reftable_addition **dest,
 				struct reftable_stack *st,
+				const struct reftable_write_options *opts,
 				unsigned int flags)
 {
 	int err;
@@ -842,7 +851,7 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 	if (!*dest)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-	err = reftable_stack_init_addition(*dest, st, flags);
+	err = reftable_stack_init_addition(*dest, st, opts, flags);
 	if (err) {
 		reftable_free(*dest);
 		*dest = NULL;
@@ -862,7 +871,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	struct reftable_writer *wr = NULL;
 	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
 	struct fd_writer writer = {
-		.opts = &add->stack->opts,
+		.opts = &add->opts,
 	};
 	int err = 0;
 
@@ -883,9 +892,9 @@ int reftable_addition_add(struct reftable_addition *add,
 	err = tmpfile_from_pattern(&tab_file, temp_tab_file_name.buf);
 	if (err < 0)
 		goto done;
-	if (add->stack->opts.default_permissions) {
+	if (add->opts.default_permissions) {
 		if (chmod(tab_file.path,
-			  add->stack->opts.default_permissions)) {
+			  add->opts.default_permissions)) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -893,7 +902,7 @@ int reftable_addition_add(struct reftable_addition *add,
 
 	writer.fd = tab_file.fd;
 	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
-				  &writer, &add->stack->opts);
+				  &writer, add->stack->opts.hash_id, &add->opts);
 	if (err < 0)
 		goto done;
 
@@ -1066,13 +1075,14 @@ static int stack_write_compact(struct reftable_stack *st,
 static int stack_compact_locked(struct reftable_stack *st,
 				size_t first, size_t last,
 				struct reftable_log_expiry_config *config,
+				const struct reftable_write_options *opts,
 				struct reftable_tmpfile *tab_file_out)
 {
 	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
 	struct fd_writer writer=  {
-		.opts = &st->opts,
+		.opts = opts,
 	};
 	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
 	int err = 0;
@@ -1094,15 +1104,15 @@ static int stack_compact_locked(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	if (st->opts.default_permissions &&
-	    chmod(tab_file.path, st->opts.default_permissions) < 0) {
+	if (opts->default_permissions &&
+	    chmod(tab_file.path, opts->default_permissions) < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
 	writer.fd = tab_file.fd;
 	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
-				  &writer, &st->opts);
+				  &writer, st->opts.hash_id, opts);
 	if (err < 0)
 		goto done;
 
@@ -1150,6 +1160,7 @@ enum stack_compact_range_flags {
 static int stack_compact_range(struct reftable_stack *st,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *expiry,
+			       const struct reftable_write_options *opts,
 			       unsigned int flags)
 {
 	struct reftable_buf tables_list_buf = REFTABLE_BUF_INIT;
@@ -1175,7 +1186,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * Hold the lock so that we can read "tables.list" and lock all tables
 	 * which are part of the user-specified range.
 	 */
-	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
+	err = flock_acquire(&tables_list_lock, st->list_file, opts->lock_timeout_ms);
 	if (err < 0)
 		goto done;
 
@@ -1274,7 +1285,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * these tables may end up with an empty new table in case tombstones
 	 * end up cancelling out all refs in that range.
 	 */
-	err = stack_compact_locked(st, first, last, expiry, &new_table);
+	err = stack_compact_locked(st, first, last, expiry, opts, &new_table);
 	if (err < 0) {
 		if (err != REFTABLE_EMPTY_TABLE_ERROR)
 			goto done;
@@ -1286,13 +1297,13 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * "tables.list". We'll then replace the compacted range of tables with
 	 * the new table.
 	 */
-	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
+	err = flock_acquire(&tables_list_lock, st->list_file, opts->lock_timeout_ms);
 	if (err < 0)
 		goto done;
 
-	if (st->opts.default_permissions) {
+	if (opts->default_permissions) {
 		if (chmod(tables_list_lock.path,
-			  st->opts.default_permissions) < 0) {
+			  opts->default_permissions) < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -1513,10 +1524,16 @@ static int stack_compact_range(struct reftable_stack *st,
 }
 
 int reftable_stack_compact_all(struct reftable_stack *st,
+			       const struct reftable_write_options *opts,
 			       struct reftable_log_expiry_config *config)
 {
+	struct reftable_write_options opts_default = { 0 };
 	size_t last = st->merged->tables_len ? st->merged->tables_len - 1 : 0;
-	return stack_compact_range(st, 0, last, config, 0);
+
+	if (!opts)
+		opts = &opts_default;
+
+	return stack_compact_range(st, 0, last, config, opts, 0);
 }
 
 static int segment_size(struct segment *s)
@@ -1601,6 +1618,7 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
 }
 
 static int stack_segments_for_compaction(struct reftable_stack *st,
+					 const struct reftable_write_options *opts,
 					 struct segment *seg)
 {
 	int version = (st->opts.hash_id == REFTABLE_HASH_SHA1) ? 1 : 2;
@@ -1615,13 +1633,14 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
 		sizes[i] = st->tables[i]->size - overhead;
 
 	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
-					  st->opts.auto_compaction_factor);
+					  opts->auto_compaction_factor);
 	reftable_free(sizes);
 
 	return 0;
 }
 
 static int update_segment_if_compaction_required(struct reftable_stack *st,
+						 const struct reftable_write_options *opts,
 						 struct segment *seg,
 						 bool use_geometric,
 						 bool *required)
@@ -1638,7 +1657,7 @@ static int update_segment_if_compaction_required(struct reftable_stack *st,
 		return 0;
 	}
 
-	err = stack_segments_for_compaction(st, seg);
+	err = stack_segments_for_compaction(st, opts, seg);
 	if (err)
 		return err;
 
@@ -1647,27 +1666,40 @@ static int update_segment_if_compaction_required(struct reftable_stack *st,
 }
 
 int reftable_stack_compaction_required(struct reftable_stack *st,
+				       const struct reftable_write_options *opts,
 				       bool use_heuristics,
 				       bool *required)
 {
+	struct reftable_write_options opts_default = { 0 };
 	struct segment seg;
-	return update_segment_if_compaction_required(st, &seg, use_heuristics,
-						     required);
+
+	if (!opts)
+		opts = &opts_default;
+
+	return update_segment_if_compaction_required(st, opts, &seg,
+						     use_heuristics, required);
 }
 
-int reftable_stack_auto_compact(struct reftable_stack *st)
+int reftable_stack_auto_compact(struct reftable_stack *st,
+				const struct reftable_write_options *opts)
 {
+	struct reftable_write_options opts_default = { 0 };
 	struct segment seg;
 	bool required;
 	int err;
 
-	err = update_segment_if_compaction_required(st, &seg, true, &required);
+	if (!opts)
+		opts = &opts_default;
+
+	err = update_segment_if_compaction_required(st, opts, &seg, true,
+						    &required);
 	if (err)
 		return err;
 
 	if (required)
 		return stack_compact_range(st, seg.start, seg.end - 1,
-					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
+					   NULL, opts,
+					   STACK_COMPACT_RANGE_BEST_EFFORT);
 
 	return 0;
 }
@@ -1807,7 +1839,7 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 int reftable_stack_clean(struct reftable_stack *st)
 {
 	struct reftable_addition *add = NULL;
-	int err = reftable_stack_new_addition(&add, st, 0);
+	int err = reftable_stack_new_addition(&add, st, NULL, 0);
 	if (err < 0) {
 		goto done;
 	}
diff --git a/reftable/stack.h b/reftable/stack.h
index bc28f2998a..f7901e6c6f 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -20,7 +20,7 @@ struct reftable_stack {
 
 	char *reftable_dir;
 
-	struct reftable_write_options opts;
+	struct reftable_stack_options opts;
 
 	struct reftable_table **tables;
 	size_t tables_len;
diff --git a/reftable/writer.c b/reftable/writer.c
index 0133b64975..f850e9d599 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -80,9 +80,6 @@ static void options_set_defaults(struct reftable_write_options *opts)
 		opts->restart_interval = 16;
 	}
 
-	if (opts->hash_id == 0) {
-		opts->hash_id = REFTABLE_HASH_SHA1;
-	}
 	if (opts->block_size == 0) {
 		opts->block_size = DEFAULT_BLOCK_SIZE;
 	}
@@ -90,7 +87,7 @@ static void options_set_defaults(struct reftable_write_options *opts)
 
 static int writer_version(struct reftable_writer *w)
 {
-	return (w->opts.hash_id == 0 || w->opts.hash_id == REFTABLE_HASH_SHA1) ?
+	return (w->hash_id == 0 || w->hash_id == REFTABLE_HASH_SHA1) ?
 			     1 :
 			     2;
 }
@@ -107,7 +104,7 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 	if (writer_version(w) == 2) {
 		uint32_t hash_id;
 
-		switch (w->opts.hash_id) {
+		switch (w->hash_id) {
 		case REFTABLE_HASH_SHA1:
 			hash_id = REFTABLE_FORMAT_ID_SHA1;
 			break;
@@ -134,7 +131,7 @@ static int writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 	reftable_buf_reset(&w->last_key);
 	ret = block_writer_init(&w->block_writer_data, typ, w->block,
 				w->opts.block_size, block_start,
-				hash_size(w->opts.hash_id));
+				hash_size(w->hash_id));
 	if (ret < 0)
 		return ret;
 
@@ -147,7 +144,9 @@ static int writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 int reftable_writer_new(struct reftable_writer **out,
 			ssize_t (*writer_func)(void *, const void *, size_t),
 			int (*flush_func)(void *),
-			void *writer_arg, const struct reftable_write_options *_opts)
+			void *writer_arg,
+			enum reftable_hash hash_id,
+			const struct reftable_write_options *_opts)
 {
 	struct reftable_write_options opts = {0};
 	struct reftable_writer *wp;
@@ -162,6 +161,9 @@ int reftable_writer_new(struct reftable_writer **out,
 	if (opts.block_size >= (1 << 24))
 		return REFTABLE_API_ERROR;
 
+	if (!hash_id)
+		hash_id = REFTABLE_HASH_SHA1;
+
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
 	reftable_buf_init(&wp->scratch);
@@ -173,6 +175,7 @@ int reftable_writer_new(struct reftable_writer **out,
 	wp->write = writer_func;
 	wp->write_arg = writer_arg;
 	wp->opts = opts;
+	wp->hash_id = hash_id;
 	wp->flush = flush_func;
 	writer_reinit_block_writer(wp, REFTABLE_BLOCK_TYPE_REF);
 
@@ -367,7 +370,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
 		reftable_buf_reset(&w->scratch);
 		err = reftable_buf_add(&w->scratch, (char *)reftable_ref_record_val1(ref),
-				       hash_size(w->opts.hash_id));
+				       hash_size(w->hash_id));
 		if (err < 0)
 			goto out;
 
@@ -379,7 +382,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
 		reftable_buf_reset(&w->scratch);
 		err = reftable_buf_add(&w->scratch, reftable_ref_record_val2(ref),
-				       hash_size(w->opts.hash_id));
+				       hash_size(w->hash_id));
 		if (err < 0)
 			goto out;
 
diff --git a/reftable/writer.h b/reftable/writer.h
index 9f53610b27..c08fc413e1 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -27,6 +27,7 @@ struct reftable_writer {
 	uint64_t next;
 	uint64_t min_update_index, max_update_index;
 	struct reftable_write_options opts;
+	enum reftable_hash hash_id;
 
 	/* memory buffer for writing */
 	uint8_t *block;
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index b16c0722c8..fc49fafc34 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -174,7 +174,7 @@ static int dump_table(struct reftable_merged_table *mt)
 static int dump_stack(const char *stackdir, uint32_t hash_id)
 {
 	struct reftable_stack *stack = NULL;
-	struct reftable_write_options opts = { .hash_id = hash_id };
+	struct reftable_stack_options opts = { .hash_id = hash_id };
 	struct reftable_merged_table *merged = NULL;
 
 	int err = reftable_new_stack(&stack, stackdir, &opts);
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index fdb5b11a20..19a3ac8b80 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -25,11 +25,12 @@ static int strbuf_writer_flush(void *arg UNUSED)
 }
 
 struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
+						 enum reftable_hash hash_id,
 						 struct reftable_write_options *opts)
 {
 	struct reftable_writer *writer;
 	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
-				      buf, opts);
+				      buf, hash_id, opts);
 	cl_assert(!ret);
 	return writer;
 }
@@ -39,6 +40,7 @@ void cl_reftable_write_to_buf(struct reftable_buf *buf,
 			     size_t nrefs,
 			     struct reftable_log_record *logs,
 			     size_t nlogs,
+			     enum reftable_hash hash_id,
 			     struct reftable_write_options *_opts)
 {
 	struct reftable_write_options opts = { 0 };
@@ -66,7 +68,7 @@ void cl_reftable_write_to_buf(struct reftable_buf *buf,
 			min = ui;
 	}
 
-	writer = cl_reftable_strbuf_writer(buf, &opts);
+	writer = cl_reftable_strbuf_writer(buf, hash_id, &opts);
 	ret = reftable_writer_set_limits(writer, min, max);
 	cl_assert(!ret);
 
@@ -88,7 +90,7 @@ void cl_reftable_write_to_buf(struct reftable_buf *buf,
 		size_t off = i * (opts.block_size ? opts.block_size
 						  : DEFAULT_BLOCK_SIZE);
 		if (!off)
-			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
+			off = header_size(hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
 		cl_assert(buf->buf[off] == 'r');
 	}
 
diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
index d7e6d3136f..caf443d147 100644
--- a/t/unit-tests/lib-reftable.h
+++ b/t/unit-tests/lib-reftable.h
@@ -10,6 +10,7 @@ struct reftable_buf;
 void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
 
 struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
+						 enum reftable_hash hash_id,
 						 struct reftable_write_options *opts);
 
 void cl_reftable_write_to_buf(struct reftable_buf *buf,
@@ -17,4 +18,5 @@ void cl_reftable_write_to_buf(struct reftable_buf *buf,
 			     size_t nrecords,
 			     struct reftable_log_record *logs,
 			     size_t nlogs,
+			     enum reftable_hash hash_id,
 			     struct reftable_write_options *opts);
diff --git a/t/unit-tests/u-reftable-merged.c b/t/unit-tests/u-reftable-merged.c
index 54cb7fc2a7..21232c1e4f 100644
--- a/t/unit-tests/u-reftable-merged.c
+++ b/t/unit-tests/u-reftable-merged.c
@@ -34,7 +34,8 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	cl_assert(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
-		cl_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
+		cl_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0,
+					 REFTABLE_HASH_SHA1, &opts);
 		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_table_new(&(*tables)[i], &(*source)[i],
@@ -357,7 +358,8 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 	cl_assert(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
-		cl_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
+		cl_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i],
+					 REFTABLE_HASH_SHA1, &opts);
 		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_table_new(&(*tables)[i], &(*source)[i],
@@ -487,7 +489,8 @@ void test_reftable_merged__default_write_opts(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1, &opts);
 	struct reftable_ref_record rec = {
 		.refname = (char *) "master",
 		.update_index = 1,
diff --git a/t/unit-tests/u-reftable-readwrite.c b/t/unit-tests/u-reftable-readwrite.c
index 4d8c4be5f1..5794b460c6 100644
--- a/t/unit-tests/u-reftable-readwrite.c
+++ b/t/unit-tests/u-reftable-readwrite.c
@@ -48,7 +48,6 @@ static void write_table(char ***names, struct reftable_buf *buf, int N,
 {
 	struct reftable_write_options opts = {
 		.block_size = block_size,
-		.hash_id = hash_id,
 	};
 	struct reftable_ref_record *refs;
 	struct reftable_log_record *logs;
@@ -78,7 +77,7 @@ static void write_table(char ***names, struct reftable_buf *buf, int N,
 		logs[i].value.update.message = (char *) "message";
 	}
 
-	cl_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
+	cl_reftable_write_to_buf(buf, refs, N, logs, N, hash_id, &opts);
 
 	reftable_free(refs);
 	reftable_free(logs);
@@ -103,6 +102,7 @@ void test_reftable_readwrite__log_buffer_size(void)
 					   .message = (char *) "commit: 9\n",
 				   } } };
 	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
 							      &opts);
 
 	/* This tests buffer extension for log compression. Must use a random
@@ -143,6 +143,7 @@ void test_reftable_readwrite__log_overflow(void)
 		},
 	};
 	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
 							      &opts);
 
 	memset(msg, 'x', sizeof(msg) - 1);
@@ -157,6 +158,7 @@ void test_reftable_readwrite__log_write_limits(void)
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
 							      &opts);
 	struct reftable_log_record log = {
 		.refname = (char *)"refs/head/master",
@@ -202,7 +204,9 @@ void test_reftable_readwrite__log_write_read(void)
 	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
+							      &opts);
 	const struct reftable_stats *stats = NULL;
 	int N = 2, i;
 	char **names;
@@ -299,6 +303,7 @@ void test_reftable_readwrite__log_zlib_corruption(void)
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
 							      &opts);
 	const struct reftable_stats *stats = NULL;
 	char message[100] = { 0 };
@@ -531,6 +536,7 @@ static void t_table_refs_for(int indexed)
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
 							      &opts);
 	struct reftable_iterator it = { 0 };
 	int N = 50, j, i;
@@ -622,7 +628,9 @@ void test_reftable_readwrite__write_empty_table(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
+							      &opts);
 	struct reftable_block_source source = { 0 };
 	struct reftable_table *table = NULL;
 	struct reftable_ref_record rec = { 0 };
@@ -660,7 +668,9 @@ void test_reftable_readwrite__write_object_id_min_length(void)
 		.block_size = 75,
 	};
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
+							      &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
@@ -691,7 +701,9 @@ void test_reftable_readwrite__write_object_id_length(void)
 		.block_size = 75,
 	};
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
+							      &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
@@ -721,7 +733,9 @@ void test_reftable_readwrite__write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
+							      &opts);
 	struct reftable_ref_record ref = {
 		.refname = (char *) "",
 		.update_index = 1,
@@ -740,7 +754,9 @@ void test_reftable_readwrite__write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      REFTABLE_HASH_SHA1,
+							      &opts);
 	struct reftable_ref_record refs[2] = {
 		{
 			.refname = (char *) "b",
@@ -787,7 +803,8 @@ void test_reftable_readwrite__write_multiple_indices(void)
 	int i;
 	int err;
 
-	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
+	writer = cl_reftable_strbuf_writer(&writer_buf, REFTABLE_HASH_SHA1,
+					   &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i = 0; i < 100; i++) {
 		struct reftable_ref_record ref = {
@@ -861,7 +878,8 @@ void test_reftable_readwrite__write_multi_level_index(void)
 	struct reftable_table *table;
 	int err;
 
-	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
+	writer = cl_reftable_strbuf_writer(&writer_buf, REFTABLE_HASH_SHA1,
+					   &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (size_t i = 0; i < 200; i++) {
 		struct reftable_ref_record ref = {
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index b8110cdeee..e6c1635940 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -111,10 +111,9 @@ static int write_test_ref(struct reftable_writer *wr, void *arg)
 static void write_n_ref_tables(struct reftable_stack *st,
 			       size_t n)
 {
-	int disable_auto_compact;
-
-	disable_auto_compact = st->opts.disable_auto_compact;
-	st->opts.disable_auto_compact = 1;
+	struct reftable_write_options opts = {
+		.disable_auto_compact = 1,
+	};
 
 	for (size_t i = 0; i < n; i++) {
 		struct reftable_ref_record ref = {
@@ -128,10 +127,8 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		cl_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
 
 		cl_assert_equal_i(reftable_stack_add(st,
-						     &write_test_ref, &ref, 0), 0);
+						     &write_test_ref, &ref, &opts, 0), 0);
 	}
-
-	st->opts.disable_auto_compact = disable_auto_compact;
 }
 
 struct write_log_arg {
@@ -168,10 +165,10 @@ void test_reftable_stack__add_one(void)
 	struct stat stat_result = { 0 };
 	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
+	err = reftable_new_stack(&st, dir, NULL);
 	cl_assert(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref, 0);
+	err = reftable_stack_add(st, write_test_ref, &ref, &opts, 0);
 	cl_assert(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
@@ -210,7 +207,6 @@ void test_reftable_stack__add_one(void)
 
 void test_reftable_stack__uptodate(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL;
 	struct reftable_stack *st2 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
@@ -232,15 +228,15 @@ void test_reftable_stack__uptodate(void)
 	/* simulate multi-process access to the same stack
 	   by creating two stacks for the same directory.
 	 */
-	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
-	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref,
-					     &ref1, 0), 0);
+					     &ref1, NULL, 0), 0);
 	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
-					     &ref2, 0), REFTABLE_OUTDATED_ERROR);
+					     &ref2, NULL, 0), REFTABLE_OUTDATED_ERROR);
 	cl_assert_equal_i(reftable_stack_reload(st2), 0);
 	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
-					     &ref2, 0), 0);
+					     &ref2, NULL, 0), 0);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 	clear_dir(dir);
@@ -249,7 +245,6 @@ void test_reftable_stack__uptodate(void)
 void test_reftable_stack__transaction_api(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_addition *add = NULL;
 
@@ -261,11 +256,11 @@ void test_reftable_stack__transaction_api(void)
 	};
 	struct reftable_ref_record dest = { 0 };
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	reftable_addition_destroy(add);
 
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st, 0), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st, NULL, 0), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&ref), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -306,7 +301,7 @@ void test_reftable_stack__transaction_with_reload(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, 0), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, NULL, 0), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&refs[0]), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -317,9 +312,9 @@ void test_reftable_stack__transaction_with_reload(void)
 	 * create the addition and lock the stack by default, but allow the
 	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
 	 */
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, 0),
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL, 0),
 						      REFTABLE_OUTDATED_ERROR);
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st2,
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL,
 						      REFTABLE_STACK_NEW_ADDITION_RELOAD), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&refs[1]), 0);
@@ -342,12 +337,11 @@ void test_reftable_stack__transaction_with_reload(void)
 void test_reftable_stack__transaction_api_performs_auto_compaction(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = {0};
 	struct reftable_addition *add = NULL;
 	struct reftable_stack *st = NULL;
 	size_t n = 20;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	for (size_t i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -356,6 +350,9 @@ void test_reftable_stack__transaction_api_performs_auto_compaction(void)
 			.value.symref = (char *) "master",
 		};
 		char name[100];
+		struct reftable_write_options write_opts = {
+			.disable_auto_compact = (i != n),
+		};
 
 		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = name;
@@ -365,10 +362,8 @@ void test_reftable_stack__transaction_api_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->opts.disable_auto_compact = i != n;
-
 		cl_assert_equal_i(reftable_stack_new_addition(&add,
-							      st, 0), 0);
+							      st, &write_opts, 0), 0);
 		cl_assert_equal_i(reftable_addition_add(add,
 							write_test_ref, &ref), 0);
 		cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -398,15 +393,14 @@ void test_reftable_stack__auto_compaction_fails_gracefully(void)
 		.value_type = REFTABLE_REF_VAL1,
 		.value.val1 = {0x01},
 	};
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st;
 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref, 0), 0);
+					     &ref, NULL, 0), 0);
 	cl_assert_equal_i(st->merged->tables_len, 1);
 	cl_assert_equal_i(st->stats.attempts, 0);
 	cl_assert_equal_i(st->stats.failures, 0);
@@ -424,7 +418,7 @@ void test_reftable_stack__auto_compaction_fails_gracefully(void)
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
-	err = reftable_stack_add(st, write_test_ref, &ref, 0);
+	err = reftable_stack_add(st, write_test_ref, &ref, NULL, 0);
 	cl_assert(!err);
 	cl_assert_equal_i(st->merged->tables_len, 2);
 	cl_assert_equal_i(st->stats.attempts, 1);
@@ -443,7 +437,6 @@ static int write_error(struct reftable_writer *wr UNUSED, void *arg)
 void test_reftable_stack__update_index_check(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_ref_record ref1 = {
 		.refname = (char *) "name1",
@@ -458,11 +451,11 @@ void test_reftable_stack__update_index_check(void)
 		.value.symref = (char *) "master",
 	};
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref1, 0), 0);
+					     &ref1, NULL, 0), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref2, 0), REFTABLE_API_ERROR);
+					     &ref2, NULL, 0), REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
@@ -470,14 +463,13 @@ void test_reftable_stack__update_index_check(void)
 void test_reftable_stack__lock_failure(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	int i;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--)
 		cl_assert_equal_i(reftable_stack_add(st, write_error,
-						     &i, 0), i);
+						     &i, NULL, 0), i);
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -499,7 +491,7 @@ void test_reftable_stack__add(void)
 	size_t i, N = ARRAY_SIZE(refs);
 	int err = 0;
 
-	err = reftable_new_stack(&st, dir, &opts);
+	err = reftable_new_stack(&st, dir, NULL);
 	cl_assert(!err);
 
 	for (i = 0; i < N; i++) {
@@ -521,7 +513,7 @@ void test_reftable_stack__add(void)
 
 	for (i = 0; i < N; i++)
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &refs[i], 0), 0);
+						     &refs[i], &opts, 0), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -529,10 +521,10 @@ void test_reftable_stack__add(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, 0), 0);
+						     &arg, &opts, 0), 0);
 	}
 
-	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st, &opts, NULL), 0);
 
 	for (i = 0; i < N; i++) {
 		struct reftable_ref_record dest = { 0 };
@@ -584,7 +576,6 @@ void test_reftable_stack__add(void)
 
 void test_reftable_stack__iterator(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_ref_record refs[10] = { 0 };
@@ -593,7 +584,7 @@ void test_reftable_stack__iterator(void)
 	size_t N = ARRAY_SIZE(refs), i;
 	int err;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	for (i = 0; i < N; i++) {
 		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
@@ -613,7 +604,7 @@ void test_reftable_stack__iterator(void)
 
 	for (i = 0; i < N; i++)
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &refs[i], 0), 0);
+						     &refs[i], NULL, 0), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -622,7 +613,7 @@ void test_reftable_stack__iterator(void)
 		};
 
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, 0), 0);
+						     &arg, NULL, 0), 0);
 	}
 
 	reftable_stack_init_ref_iterator(st, &it);
@@ -669,9 +660,6 @@ void test_reftable_stack__iterator(void)
 
 void test_reftable_stack__log_normalize(void)
 {
-	struct reftable_write_options opts = {
-		0,
-	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_log_record input = {
@@ -693,15 +681,15 @@ void test_reftable_stack__log_normalize(void)
 		.update_index = 1,
 	};
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	input.value.update.message = (char *) "one\ntwo";
 	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-					     &arg, 0), REFTABLE_API_ERROR);
+					     &arg, NULL, 0), REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
 	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-					     &arg, 0), 0);
+					     &arg, NULL, 0), 0);
 	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
 						  &dest), 0);
 	cl_assert_equal_s(dest.value.update.message, "one\n");
@@ -709,7 +697,7 @@ void test_reftable_stack__log_normalize(void)
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
 	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-					     &arg, 0), 0);
+					     &arg, NULL, 0), 0);
 	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
 						  &dest), 0);
 	cl_assert_equal_s(dest.value.update.message, "two\n");
@@ -723,7 +711,6 @@ void test_reftable_stack__log_normalize(void)
 void test_reftable_stack__tombstone(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_ref_record refs[2] = { 0 };
 	struct reftable_log_record logs[2] = { 0 };
@@ -731,7 +718,7 @@ void test_reftable_stack__tombstone(void)
 	struct reftable_ref_record dest = { 0 };
 	struct reftable_log_record log_dest = { 0 };
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	/* even entries add the refs, odd entries delete them. */
 	for (i = 0; i < N; i++) {
@@ -760,7 +747,7 @@ void test_reftable_stack__tombstone(void)
 	}
 	for (i = 0; i < N; i++)
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &refs[i], 0), 0);
+						     &refs[i], NULL, 0), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -768,7 +755,7 @@ void test_reftable_stack__tombstone(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, 0), 0);
+						     &arg, NULL, 0), 0);
 	}
 
 	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
@@ -779,7 +766,7 @@ void test_reftable_stack__tombstone(void)
 						  &log_dest), 1);
 	reftable_log_record_release(&log_dest);
 
-	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL, NULL), 0);
 	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
 						  &dest), 1);
 	cl_assert_equal_i(reftable_stack_read_log(st, "branch",
@@ -799,7 +786,6 @@ void test_reftable_stack__tombstone(void)
 void test_reftable_stack__hash_id(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 
 	struct reftable_ref_record ref = {
@@ -808,15 +794,14 @@ void test_reftable_stack__hash_id(void)
 		.value.symref = (char *) "target",
 		.update_index = 1,
 	};
-	struct reftable_write_options opts32 = { .hash_id = REFTABLE_HASH_SHA256 };
+	struct reftable_stack_options opts32 = { .hash_id = REFTABLE_HASH_SHA256 };
 	struct reftable_stack *st32 = NULL;
-	struct reftable_write_options opts_default = { 0 };
 	struct reftable_stack *st_default = NULL;
 	struct reftable_ref_record dest = { 0 };
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref, 0), 0);
+					     &ref, NULL, 0), 0);
 
 	/* can't read it with the wrong hash ID. */
 	cl_assert_equal_i(reftable_new_stack(&st32, dir,
@@ -824,7 +809,7 @@ void test_reftable_stack__hash_id(void)
 
 	/* check that we can read it back with default opts too. */
 	cl_assert_equal_i(reftable_new_stack(&st_default, dir,
-					     &opts_default), 0);
+					     NULL), 0);
 	cl_assert_equal_i(reftable_stack_read_ref(st_default, "master",
 						  &dest), 0);
 	cl_assert(reftable_ref_record_equal(&ref, &dest,
@@ -855,7 +840,6 @@ void test_reftable_stack__suggest_compaction_segment_nothing(void)
 void test_reftable_stack__reflog_expire(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_log_record logs[20] = { 0 };
 	size_t i, N = ARRAY_SIZE(logs) - 1;
@@ -864,7 +848,7 @@ void test_reftable_stack__reflog_expire(void)
 	};
 	struct reftable_log_record log = { 0 };
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	for (i = 1; i <= N; i++) {
 		char buf[256];
@@ -885,18 +869,18 @@ void test_reftable_stack__reflog_expire(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, 0), 0);
+						     &arg, NULL, 0), 0);
 	}
 
-	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
-	cl_assert_equal_i(reftable_stack_compact_all(st, &expiry), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL, NULL), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL, &expiry), 0);
 	cl_assert_equal_i(reftable_stack_read_log(st, logs[9].refname,
 						  &log), 1);
 	cl_assert_equal_i(reftable_stack_read_log(st, logs[11].refname,
 						  &log), 0);
 
 	expiry.min_update_index = 15;
-	cl_assert_equal_i(reftable_stack_compact_all(st, &expiry), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL, &expiry), 0);
 	cl_assert_equal_i(reftable_stack_read_log(st, logs[14].refname,
 						  &log), 1);
 	cl_assert_equal_i(reftable_stack_read_log(st, logs[16].refname,
@@ -918,15 +902,14 @@ static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
 
 void test_reftable_stack__empty_add(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_stack *st2 = NULL;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_nothing,
-					     NULL, 0), 0);
-	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
+					     NULL, NULL, 0), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st2);
@@ -952,7 +935,7 @@ void test_reftable_stack__auto_compaction(void)
 	size_t i, N = 100;
 	int err;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -964,10 +947,10 @@ void test_reftable_stack__auto_compaction(void)
 		};
 		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, write_test_ref, &ref, 0);
+		err = reftable_stack_add(st, write_test_ref, &ref, &opts, 0);
 		cl_assert(!err);
 
-		err = reftable_stack_auto_compact(st);
+		err = reftable_stack_auto_compact(st, &opts);
 		cl_assert(!err);
 		cl_assert(i < 2 || st->merged->tables_len < 2 * fastlogN(i, 2));
 	}
@@ -989,7 +972,7 @@ void test_reftable_stack__auto_compaction_factor(void)
 	size_t N = 100;
 	int err;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	for (size_t i = 0; i < N; i++) {
 		char name[20];
@@ -1000,7 +983,7 @@ void test_reftable_stack__auto_compaction_factor(void)
 		};
 		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref, 0);
+		err = reftable_stack_add(st, &write_test_ref, &ref, &opts, 0);
 		cl_assert(!err);
 
 		cl_assert(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
@@ -1020,7 +1003,7 @@ void test_reftable_stack__auto_compaction_with_locked_tables(void)
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	write_n_ref_tables(st, 5);
 	cl_assert_equal_i(st->merged->tables_len, 5);
@@ -1042,7 +1025,7 @@ void test_reftable_stack__auto_compaction_with_locked_tables(void)
 	 * would in theory compact all tables, due to the preexisting lock we
 	 * only compact the newest two tables.
 	 */
-	err = reftable_stack_auto_compact(st);
+	err = reftable_stack_auto_compact(st, &opts);
 	cl_assert(!err);
 	cl_assert_equal_i(st->stats.failures, 0);
 	cl_assert_equal_i(st->merged->tables_len, 4);
@@ -1054,12 +1037,11 @@ void test_reftable_stack__auto_compaction_with_locked_tables(void)
 
 void test_reftable_stack__add_performs_auto_compaction(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 	size_t i, n = 20;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -1067,6 +1049,9 @@ void test_reftable_stack__add_performs_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
+		struct reftable_write_options write_opts = {
+			.disable_auto_compact = (i != n),
+		};
 		bool required = false;
 		char buf[128];
 
@@ -1075,20 +1060,18 @@ void test_reftable_stack__add_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->opts.disable_auto_compact = i != n;
-
 		snprintf(buf, sizeof(buf), "branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf;
 
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &ref, 0), 0);
+						     &ref, &write_opts, 0), 0);
 
 		/*
 		 * The stack length should grow continuously for all runs where
 		 * auto compaction is disabled. When enabled, we should merge
 		 * all tables in the stack.
 		 */
-		cl_assert_equal_i(reftable_stack_compaction_required(st, true, &required), 0);
+		cl_assert_equal_i(reftable_stack_compaction_required(st, NULL, true, &required), 0);
 		if (i != n) {
 			cl_assert_equal_i(st->merged->tables_len, i + 1);
 			if (i < 1)
@@ -1115,7 +1098,7 @@ void test_reftable_stack__compaction_with_locked_tables(void)
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	write_n_ref_tables(st, 3);
 	cl_assert_equal_i(st->merged->tables_len, 3);
@@ -1131,7 +1114,7 @@ void test_reftable_stack__compaction_with_locked_tables(void)
 	 * Compaction is expected to fail given that we were not able to
 	 * compact all tables.
 	 */
-	err = reftable_stack_compact_all(st, NULL);
+	err = reftable_stack_compact_all(st, &opts, NULL);
 	cl_assert_equal_i(err, REFTABLE_LOCK_ERROR);
 	cl_assert_equal_i(st->stats.failures, 1);
 	cl_assert_equal_i(st->merged->tables_len, 3);
@@ -1143,15 +1126,14 @@ void test_reftable_stack__compaction_with_locked_tables(void)
 
 void test_reftable_stack__compaction_concurrent(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
-	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	write_n_ref_tables(st1, 3);
 
-	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
-	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL, NULL), 0);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
@@ -1171,20 +1153,19 @@ static void unclean_stack_close(struct reftable_stack *st)
 
 void test_reftable_stack__compaction_concurrent_clean(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
-	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	write_n_ref_tables(st1, 3);
 
-	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
-	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL, NULL), 0);
 
 	unclean_stack_close(st1);
 	unclean_stack_close(st2);
 
-	cl_assert_equal_i(reftable_new_stack(&st3, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st3, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_clean(st3), 0);
 	cl_assert_equal_i(count_dir_entries(dir), 2);
 
@@ -1197,7 +1178,6 @@ void test_reftable_stack__compaction_concurrent_clean(void)
 
 void test_reftable_stack__read_across_reload(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
@@ -1205,17 +1185,17 @@ void test_reftable_stack__read_across_reload(void)
 	int err;
 
 	/* Create a first stack and set up an iterator for it. */
-	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	write_n_ref_tables(st1, 2);
 	cl_assert_equal_i(st1->merged->tables_len, 2);
 	reftable_stack_init_ref_iterator(st1, &it);
 	cl_assert_equal_i(reftable_iterator_seek_ref(&it, ""), 0);
 
 	/* Set up a second stack for the same directory and compact it. */
-	err = reftable_new_stack(&st2, dir, &opts);
+	err = reftable_new_stack(&st2, dir, NULL);
 	cl_assert(!err);
 	cl_assert_equal_i(st2->merged->tables_len, 2);
-	err = reftable_stack_compact_all(st2, NULL);
+	err = reftable_stack_compact_all(st2, NULL, NULL);
 	cl_assert(!err);
 	cl_assert_equal_i(st2->merged->tables_len, 1);
 
@@ -1244,7 +1224,6 @@ void test_reftable_stack__read_across_reload(void)
 
 void test_reftable_stack__reload_with_missing_table(void)
 {
-	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
@@ -1253,7 +1232,7 @@ void test_reftable_stack__reload_with_missing_table(void)
 	int err;
 
 	/* Create a first stack and set up an iterator for it. */
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	write_n_ref_tables(st, 2);
 	cl_assert_equal_i(st->merged->tables_len, 2);
 	reftable_stack_init_ref_iterator(st, &it);
@@ -1320,11 +1299,11 @@ void test_reftable_stack__invalid_limit_updates(void)
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_stack *st = NULL;
 
-	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 
 	reftable_addition_destroy(add);
 
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st, 0), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st, &opts, 0), 0);
 
 	/*
 	 * write_limits_after_ref also updates the update indexes after adding
diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index 14fae8b199..fae478ee04 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -22,7 +22,8 @@ void test_reftable_table__seek_once(void)
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
-	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0,
+				 REFTABLE_HASH_SHA1, NULL);
 	block_source_from_buf(&source, &buf);
 
 	ret = reftable_table_new(&table, &source, "name");
@@ -64,7 +65,7 @@ void test_reftable_table__reseek(void)
 	int ret;
 
 	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records),
-				 NULL, 0, NULL);
+				 NULL, 0, REFTABLE_HASH_SHA1, NULL);
 	block_source_from_buf(&source, &buf);
 
 	ret = reftable_table_new(&table, &source, "name");
@@ -147,7 +148,8 @@ void test_reftable_table__block_iterator(void)
 					     (uintmax_t) i);
 	}
 
-	cl_reftable_write_to_buf(&buf, records, nrecords, NULL, 0, NULL);
+	cl_reftable_write_to_buf(&buf, records, nrecords, NULL, 0,
+				 REFTABLE_HASH_SHA1, NULL);
 	block_source_from_buf(&source, &buf);
 
 	ret = reftable_table_new(&table, &source, "name");

-- 
2.55.0.rc1.745.g43192e7977.dirty

