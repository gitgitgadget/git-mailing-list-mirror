Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B1287505
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638733; cv=none; b=Oup+URCBy5vpinvGOvPgIkdofuxHtFj/8uH5/+gVGRb4Eays3+w6hIDZcDpL5+0bxybFO+yWpOaChGCwk11ye/k/MH+PoOy5jm9z3kJkKKCyBM0XS2Y5a73bYoUWPONt3THX7KMhPnij/sRuS3tWmTMmGXD5U46MC1rtRA3Ions=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638733; c=relaxed/simple;
	bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+B0Ood7MZmWDmmH9DUTpSegIr8d7EIWctePjMUEJCVoX/vs0AZtMPMWkDIyt7cu/AGYhk7ybpFvjLBa/WhLIQx2GQrpD4agtL+nZp/Ft6PwhQVB+JKIPFGmBGIEXuAuPOpYBgtkFf1EBBVi1Gr5b0yEYyX6Q3oEaoAInsiZiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFWiWug2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFWiWug2"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso470559a12.3
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762638730; x=1763243530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=dFWiWug2ZfvRVf7f+epoPgsoRlO06yPpEAEYKB0kW/0yH6orjqLpe13O37TPQNkHbq
         GLoWdPL6VIK2WgHI3FH3kIs/6qgMmm3A21fx3E8IFJzQLiTSHONLu2crLc3Bbs2fOQ89
         1bWlmd8nU5RSlW/FRSlStEiRpn4gkBryAsXD+M4yzAa1zF3IZNHId/onpsB3GTuwL01k
         fPjrvHLfxvuHncyhfCZ8B7tz/SbcZHhxUTCWQJh5t1M3jpdBUhwUsPmhgdV58x9fqL4u
         xJjzqSjDVYiSZZNFi9xbLVjW+QR/k4W96wPrKoT7LSGQ+EK75uk/KLYAaiRWXEu9V3D3
         2mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638730; x=1763243530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=nxjIXKruZMWVYQk18pseM5pmPLE72lEaa5e0RfJRKkwLfnAUJxOg1O9CQ+VJY/we0V
         qpFfrfZF2knpCwyty3VDKB3EkVFB+2W8AGpEEKgTdbWN/83sTD6ljaGU41A2y1RsTKk5
         XMB2dOP65mYO8khaB77bj6aShcXsshX2L1MaHJRl++nIfPUF9VIju1xIc+jAA/J8wGTh
         G+kukuPz4KmJOPvE5kDlw9CqqqqQA84fUKopIfEO1CUe4lwlts4C/V2F0OkEeGS/oHKX
         YQr6Ps1+Up/t/LBd/XmXeI1uocvls2qnHEkacqPkdug5v0/PG8vqNxKQ2GTyhCqtd+8c
         HFgw==
X-Gm-Message-State: AOJu0Yxtwv3OpWlYBsNRVmWuBwyT3LLst3mjpVp48NR/xyGt8kLM1Nay
	I8N2CLreteemhMidVDF/78bc8HFKL4qbqYSkigpJ1oSMh7HVZBQ3VD0Ag0Cbv/Jn
X-Gm-Gg: ASbGncsb/s5NTXfEKKTxDV5lftrbKTf3Jul3R5ApbIBSHKhnJBw5e8hKJf/Ul7W6mDz
	PHnr60cyQ09JNjp0TghYg+asjs/qIxbM1m2UhETnXoLO7PykVj5ocjsYUbfHCeLUKA1zyEdd0cz
	1McfU1a4d+8e7EpQDiW4u9so844s5g4erPNNuhL18weZJ+3kZLZ6CgiNqKEfFC+I1HW9AUxeCGr
	oC3GvaqjM/jPAX6wZoyT2KkUNQDc0APDtnrzFht40jqMdQ+epzvXyMaFTt1ogDRjUT2toy86hs9
	sBn/cJGC8fqGUu2GprWGumb8Xm+cVzyJfhrldBgu1kYrYqIp9rbxkqyTOxSc6rmVpoKpvP12Dhj
	9mveaf++DH429F0uhw96b2nxOd5QIpgrq9vaHPtQtxlGwhSuWKs7lB71D2IKj5+bkGAfE0CTocL
	8z/QFo9AoNNuhem0Y=
X-Google-Smtp-Source: AGHT+IHzywnJO6/7X4jEnPDBcq0io5NL1wOClR5xdRqAIsjd/AIumu/PnTGAU9YWrDsHDX/GC5sO8A==
X-Received: by 2002:a05:6402:1e8a:b0:640:ae02:d7ac with SMTP id 4fb4d7f45d1cf-6415e6d74b4mr2629851a12.14.1762638730047;
        Sat, 08 Nov 2025 13:52:10 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm3056371a12.23.2025.11.08.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:52:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:51:55 +0100
Subject: [PATCH v4 3/5] refs: add a `optimize_required` field to `struct
 ref_storage_be`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-3-a90f229b6023@gmail.com>
References: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
In-Reply-To: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6999; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPu4EZ2lhM3wZU+C4vnU60H7P3IxUa8xCtw
 I5z/ZP47+qe7okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7uBAAoJED7VnySO
 Rox/KNwMAJwtIkUqqbeWk4ynrs6yEyUXg5+GS5LKdPAvIFaE4GCMorz1LXcU8cBCMAR6qKy56wQ
 g7HiuRBWu8DSFM5V97mcHSoR6eLvKwV3A5wiW65dlrvPNVmhfdan2wQneX0beT9L8CspCO22ovN
 hwd2IUu81j+qyWi7lkLyilZIg4pV9l+0AbhHwAdCjaQ+eBdEhFuxMVKtmrVGIwrGDorkXbjy+ZF
 fsnzst/aDXpTIyWnT0w29inokiiuX6hxmoGjd+mVPsrC4f118sMgVxm7y/mgJsQzjCbmxtSAFyq
 mByhmTQiJtKGLurDx3p1sp0Rc8MwP6c+jAJbxZ8lz0Z2x17/I4Bf9JKRGAeFxu9yzzEDcxcmxhx
 hJKtLWVminobEZKz/8htiMfO38YsGhLMS912oDdeqrL4Nn7jcJeSh4a1brMvtu5pMjG77YhGIDP
 R3HBUwgBNOHBdXDJp9aTw+PEzQU+wta7rPWkmxt31Q2fISyAfGwRV++VRIQhtSXEUYOhkj40sF5
 fc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To allow users of the refs namespace to check if the reference backend
requires optimization, add a new field `optimize_required` field to
`struct ref_storage_be`. This field is of type `optimize_required_fn`
which is also introduced in this commit.

Modify the debug, files, packed and reftable backend to implement this
field. A following commit will expose this via 'git pack-refs' and 'git
refs optimize'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  7 +++++++
 refs.h                  |  7 +++++++
 refs/debug.c            | 13 +++++++++++++
 refs/files-backend.c    | 11 +++++++++++
 refs/packed-backend.c   | 13 +++++++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c | 25 +++++++++++++++++++++++++
 7 files changed, 82 insertions(+)

diff --git a/refs.c b/refs.c
index 0d0831f29b..5583f6e09d 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,6 +2318,13 @@ int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts)
 	return refs->be->optimize(refs, opts);
 }
 
+int refs_optimize_required(struct ref_store *refs,
+			   struct refs_optimize_opts *opts,
+			   bool *required)
+{
+	return refs->be->optimize_required(refs, opts, required);
+}
+
 int reference_get_peeled_oid(struct repository *repo,
 			     const struct reference *ref,
 			     struct object_id *peeled_oid)
diff --git a/refs.h b/refs.h
index 6b05bba527..d9051bbb04 100644
--- a/refs.h
+++ b/refs.h
@@ -520,6 +520,13 @@ struct refs_optimize_opts {
  */
 int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts);
 
+/*
+ * Check if refs backend can be optimized by calling 'refs_optimize'.
+ */
+int refs_optimize_required(struct ref_store *ref_store,
+			   struct refs_optimize_opts *opts,
+			   bool *required);
+
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
diff --git a/refs/debug.c b/refs/debug.c
index 2defd2d465..36f8c58b6c 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -124,6 +124,17 @@ static int debug_optimize(struct ref_store *ref_store, struct refs_optimize_opts
 	return res;
 }
 
+static int debug_optimize_required(struct ref_store *ref_store,
+				   struct refs_optimize_opts *opts,
+				   bool *required)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->optimize_required(drefs->refs, opts, required);
+	trace_printf_key(&trace_refs, "optimize_required: %s, res: %d\n",
+			 required ? "yes" : "no", res);
+	return res;
+}
+
 static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
 			    const char *newref, const char *logmsg)
 {
@@ -431,6 +442,8 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_abort = debug_transaction_abort,
 
 	.optimize = debug_optimize,
+	.optimize_required = debug_optimize_required,
+
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a1e70b1c10..6e0c9b340a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1512,6 +1512,16 @@ static int files_optimize(struct ref_store *ref_store,
 	return 0;
 }
 
+static int files_optimize_required(struct ref_store *ref_store,
+				   struct refs_optimize_opts *opts,
+				   bool *required)
+{
+	struct files_ref_store *refs = files_downcast(ref_store, REF_STORE_READ,
+						      "optimize_required");
+	*required = should_pack_refs(refs, opts);
+	return 0;
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3982,6 +3992,7 @@ struct ref_storage_be refs_be_files = {
 	.transaction_abort = files_transaction_abort,
 
 	.optimize = files_optimize,
+	.optimize_required = files_optimize_required,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 10062fd8b6..19ce4d5872 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1784,6 +1784,17 @@ static int packed_optimize(struct ref_store *ref_store UNUSED,
 	return 0;
 }
 
+static int packed_optimize_required(struct ref_store *ref_store UNUSED,
+				    struct refs_optimize_opts *opts UNUSED,
+				    bool *required)
+{
+	/*
+	 * Packed refs are already optimized.
+	 */
+	*required = false;
+	return 0;
+}
+
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store UNUSED)
 {
 	return empty_ref_iterator_begin();
@@ -2130,6 +2141,8 @@ struct ref_storage_be refs_be_packed = {
 	.transaction_abort = packed_transaction_abort,
 
 	.optimize = packed_optimize,
+	.optimize_required = packed_optimize_required,
+
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dee42f231d..c7d2a6e50b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -424,6 +424,11 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct refs_optimize_opts *opts);
+
+typedef int optimize_required_fn(struct ref_store *ref_store,
+				 struct refs_optimize_opts *opts,
+				 bool *required);
+
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -549,6 +554,7 @@ struct ref_storage_be {
 	ref_transaction_abort_fn *transaction_abort;
 
 	optimize_fn *optimize;
+	optimize_required_fn *optimize_required;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c23c45f3bf..a3ae0cf74a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1733,6 +1733,29 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_optimize_required(struct ref_store *ref_store,
+					 struct refs_optimize_opts *opts,
+					 bool *required)
+{
+	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, REF_STORE_READ,
+							       "optimize_refs_required");
+	struct reftable_stack *stack;
+	bool use_heuristics = false;
+
+	if (refs->err)
+		return refs->err;
+
+	stack = refs->worktree_backend.stack;
+	if (!stack)
+		stack = refs->main_backend.stack;
+
+	if (opts->flags & REFS_OPTIMIZE_AUTO)
+		use_heuristics = true;
+
+	return reftable_stack_compaction_required(stack, use_heuristics,
+						  required);
+}
+
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2756,6 +2779,8 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_abort = reftable_be_transaction_abort,
 
 	.optimize = reftable_be_optimize,
+	.optimize_required = reftable_be_optimize_required,
+
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 

-- 
2.51.0

