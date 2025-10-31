Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D04345CD4
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920550; cv=none; b=rRQzz7EBVOWUxobQrAaQpjL0FOD/g+0GWk3u37Lb6UZIxvasx9WzHdK/mfk6YPXaHwPOsCAEm/bkqwo65sBuFSeaCmEAIAvCJBsUImTaaEY0M+wgqHSGN6Oraymn9IRS4lt+ebRAfQIoD75LDlgXNaAvneHgcrfg7jmknsq4yRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920550; c=relaxed/simple;
	bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1864ZP9629qhRyp9nkjfXFJF8Km5AVn0MzacDCFPS+tg8TJ7Pi/OLy5jlglCuJoW/hXhqR7AM2j2WP/3pCCqdTziTmEUaLHasBoE5Q0sdkWMz2CbyykldRhFQBBkVAUHRJkhA0spfB78MTAomr3d84zYGQsNGe/SIkVg3N0eWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwQxsdjz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwQxsdjz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-474975af41dso17164595e9.2
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920546; x=1762525346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=PwQxsdjzFfUqBsmn9Wv9OU0qYn/D29RlCnA3ExtmyOLhDjrOUEIjtQZq84EEdtVh1p
         lFX5TS/B0c70HAhfsKWSkwqadprUcOnIG/gNh8W/XKOgBdZjQW/cDHbDlOWAuHPUlfxC
         z4Ipr8/j3b4bAHJmoZxfaVHxdgm0XXmGGPURBWHnZ/P63hBqAQki6vHo3K6lmFWe9CYQ
         99PFTI7ZNGragBL/2fYAoff3Q4XT7BkXVTjJwZ4gr2LpQ/2WWtySDFEG4rk8B9Lz7/UW
         Fd9lDPYK7UogzKZuhIk4SmxOJ8C/8pl3qVrkxJ42UnFPAJen2oSQEtHpOLzUSPeZQLTV
         pbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920546; x=1762525346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=pAfnC7Dy3zdzaJFGO+9exFUe2aadJ9AneEV1P3UsjvX4jZxq+oL7qXMiZhjsUsqGQu
         mq0VdWcpZGSQjZDCt08dSVm8YKj9cHiCIgP8gECfXzB+TSec7qHWKBOSkiTCdmyhpVZn
         JKe4O5tiMmjeFW6NTQQpEv57Pbi7KHw5azcpqiCkvOuA0V97M9Bv1TJSjVIKZOLr8Gaz
         4Pk+hrpHu0xAKQs6N0w72PVqV7ROhc/PGOs9a+TTT4Lc7+zr3HUuIkTK5WpA9I+P+DoX
         uTOdDGfmTtxvjOLIjbatAsCGSNne5Sp9sEic7AFHCnKwPWx9SIkRB2Lbc9MMo51LgD/V
         zhqQ==
X-Gm-Message-State: AOJu0Yx2Xry1Y/fPVsJoJuU/dJ7hlUgSow9qHrl1tSF06GZ2rfj4OQsI
	z/2/slokNphsY25XHtHqg+E4h10vnFZrV+t1GJbhtnorW1/jRGKnrkKVOfgrmsq1
X-Gm-Gg: ASbGnct7kxiRbTw03a6WNPawmFrIkgfeuhCu9PX2hMisHvxrmYPtIhMDcf28g3MEj8b
	NiTZWmFEh1ZNjMLie7I+cWXCAYpVyqH/Dp0zmVAx7fBSZcfOcSpJpPqN2kaDUoJptonz1srN8NO
	g43i8h00Sg2Eib9C8zXlE4eMUbJ5KaV9jajv3f2k/GFM5Mh0qa2nMpeXVm7wW6p2G1cY1ZjMNfg
	c/b8NlLibfVum1uOydeHYnSmFYkjNOcbBNJMGuF/1c1hXYyF0WTUdIFMrjo39QB7vIkD5wCuvUb
	8dyZM0SMy8setpWxdyLgwzr3g68QWh0rKsRkaqWlFiHAj2Pdk2YVDksHTOMwmWlHxijSmjNZWfO
	TW8afzb0RU9fJEtha7Ztzj1XWJHJhfQA+agdWNID2YEZWlmjaJA0gydddupkOArNLWbuYJKWwaa
	ZnoSs=
X-Google-Smtp-Source: AGHT+IGJQEHqzHYDFpFy8cf8EAao6jCbyhjn4rJ1Xo4WSqqdl0SHxqcS45YM+1TWmFPUEdh1i4TGkA==
X-Received: by 2002:a05:600c:4ed1:b0:471:13fc:4ad3 with SMTP id 5b1f17b1804b1-47730793c1fmr40914925e9.2.1761920545824;
        Fri, 31 Oct 2025 07:22:25 -0700 (PDT)
Received: from [127.0.0.2] ([213.61.187.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2eae9csm570435e9.1.2025.10.31.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:25 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 31 Oct 2025 15:22:23 +0100
Subject: [PATCH 3/5] refs: add a `optimize_required` field to `struct
 ref_storage_be`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-3-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6999; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkExh5CTwQM3Eyab0gAWLpVbnm2JW3XyAJI1
 jI7YTTjVLR354kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpBMYeAAoJED7VnySO
 Rox/BEcMAIG98QRTBpadCpblmozbRHNLGffZ6AUtr6R1A5nfurimROFzTodJmuJqn+Fcjoud6pg
 tHf12DAwsyuEZ9fuC65Ay882mzRXrfGdGnrgknuC5WPnE4WiH6IDpM0UQpYXNmQ7m6OVLtM4v6L
 rH8rWh/YlM7iq1l90PgM1W58Uoilu9qmg+FkQC4E0XIISDuN5Xc9ITg2AmhmiAWCdYfFJsstBuf
 Lh/F1ivcEDx4wTisdKDChBfSq2Jrk8d5D7upzJXLmdlnBcAIwkKfUBqOHk5OZ7R9ec4gIBrKoJn
 rwGZ+nfCw+Xwsa4h5bO8doikia3e3LBYPM4Vzg5IT2a9Xy0/hHKd66QcDCSlmLBZyp4xQYrK1uj
 l7HOjWH9eVLzu14ZG6b1I0BxQuH+XHe4vNqmjriqWHV4aOKhITq6LhKPNl3Jk8+FO4Ylgc5B4wR
 LVigNaeM5mmc9mkiSqRCVyDJs0SZ3CO37SLvzawIQenAMxq3713V195GwvFObz0UuyzZ99TCu76
 xA=
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

