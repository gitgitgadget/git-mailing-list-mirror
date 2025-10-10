Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191072EF660
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092042; cv=none; b=KBO7ecuA5lfQp7eC7urbuIkmV9nyLthce9m0lA7K2t+VyTj4caDhwgrsYGlnKfjg8k0apZb1pmaYEXUAKgCMpjnkHdPyZbGCQh9YTy/Jwvbmq2vTwojGsgkzQuE//J9pAQ0U5gIeAkrdsrhQixuTCMVgaZMIXDPF6xlVMJ8sbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092042; c=relaxed/simple;
	bh=yBapounfaHriFAonPWQVkSnVRcyq2PN0yBF8U8pIOs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obensan+nfNW6T56oLCV3UykCMOPpgsXFat8TOKV2RCNiAop/Zt7v/IaOwRMCW7Cx/pjoZ2aF8Uv921Dlz8u/RYjkd9d8yB0W/C5CFdy0L8iF2kBVHkUJL8TZx0bco7420k6n7nKIWWv97Lt8G0yzzAoqA3gyf5iXdv9UF/0ITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drkH3Kch; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drkH3Kch"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso2734765a12.2
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092039; x=1760696839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgVwZJGC0V+rej/8EOdvcLTusFmqCGvcYVUfT3AucEM=;
        b=drkH3Kchr5kcI6/MrEEY0wobXjO+2gmC+U6574GyfaIgo23liVhNbnHJXeZLv1DDJi
         DT36oFDcf6/pAYnyun7XsRJveNnK1HdOHPaH96G3VqeBJrvnm5qrLzoxFJClUvT4wuUZ
         RwUGuU9bQy9UgC6ZTHFcyCXghib+QQ6CayDTSWnRGdneha1SyTCAuxFgkfmTy5p2opNy
         WuRV9h1FrLOLiZM5LyIxeWaQedcJbtez/PkmU/+DSPLysc249CZjqpSLyzd7P/gcquDO
         M5D3Y/2fECQn1Xrvp8twO6vwk+K5bkQmIz5KF3OT5eI6blQM43pWY0wl2u6xSg/5Ye8K
         DTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092039; x=1760696839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgVwZJGC0V+rej/8EOdvcLTusFmqCGvcYVUfT3AucEM=;
        b=rOZSkQm68AsDwhd6ThcvYjAQqzHSo28A+XQqq4/q3K1l6fbtn0NrQuCCB5KlI5ZNZS
         fuhFF7ry6dOjdLSMcCivCK6hv04qAN9IXcA7iwnu3qzsd1jkp1tFNvW5TXahqgyHv9ZB
         VGUBwR6cEZ1jdXv5g6bs4iN7WUDnp388tmHSB34Rm+KGzWQ0ZlhvHUY0T5G6XBI62V9M
         h+DvCctTII5l5KRIRiypZYdbJksK2WP+PlZ3//erfIWExc9pQWUWkw71edpFk5szHvII
         SzK+2n1rfZI6xuIgS0dzU7wheQNE7gggkCy+9pKxGoUErxemSUXan6Br+Aqcid5d30IS
         c/nQ==
X-Gm-Message-State: AOJu0YyAreaBTD2pxyoYaWGp5NcPTMf825fmXbksl33ttd0Gst4AlNAs
	czecYQQIaetzMI7iEaOfSFqqyxRA1jRp+HdUcfILwzsBxxFv7xrFXMk3y5w1t466
X-Gm-Gg: ASbGnct5cLRU9NzKX63uxE8D5Ro5/fMB+BMdqiJIxl/ejqv6p3bBNvf5C/VhyXrH4NS
	u69MF/61ZpRk4YvmqijeA5MbYaVPFA2ibUxT+Zznt3Vw4rzF/stp1z0CtEMI+7JiR9Y3ELIMzFa
	PBkw0Bz2sx4mbULmWA82OvG0mZEACsGZALea9blhtiUA+RMT9MXbfytlQdrfZzOV1MMXyOpcwyx
	4s3adjerAykXvSxw7rZ7Wc9JZvH1ZzkqGQQUG4B8Z0zN6s721SlPtvpliFcrscTT0mM3n8zaNc+
	MniVs281D7OplgDUylnJVBwAzBLxgPZCixH6c9TPVkO0CC6k4h8h6eSg+f9bXnksjRPZg4Frk0/
	6JyyN6il8z89y5w+GVxfNC8xf6Tc8l9FZq4VOdsroGCMW+OI=
X-Google-Smtp-Source: AGHT+IEVS2qtHYNn9DhB9DQYnPySAkYbTYg5waA/DVqYN66GrtI9S7ks9U9DXjA8c+p3bTef6nvOHw==
X-Received: by 2002:a05:6402:26c5:b0:637:e74e:8d00 with SMTP id 4fb4d7f45d1cf-639d5c4c2f0mr10896864a12.27.1760092038908;
        Fri, 10 Oct 2025 03:27:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:12 +0200
Subject: [PATCH 8/9] refs: add a `optimize_required` field to `struct
 ref_storage_be`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-8-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5789; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=yBapounfaHriFAonPWQVkSnVRcyq2PN0yBF8U8pIOs0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo34BDGdBNCqQnOoqy0yUg5OGqpX1lLzsQg
 AVriVkhJ9tF6YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N+AAAoJED7VnySO
 Rox/BLwMAJzTNCwBZZZinCFjz063q6Mhy8iW1wWEC2UZKkQPcBTNcYmEUjvUSTGwj16OfRR4jYh
 mRReOPKiLRYaSA3IKiPX0rRNsZfPn2CB3zf36NupdiGwU/xtsta+n1XsC/0xkp8Hb2wMr87RncS
 njMoEr/B2lrVSQRKcHEeVEw9TBXiyCvqizJ+9AdzENLUpJULVBngIkboClLynN/4xrmmqtHLRuo
 OmqAy+33mGEBcu9Yt9PpaAbC6aDnpnU7ji67rIypsLBVVpSe2tDL5Q+DI4h1hH6bUYx1FhNedrp
 rw2WPt+/E+/v0OErAf2CLIPJTw9nGeSxx7GbwykoARZ6PcV/NiWBFEnXGtXSY++qDGNTo8no9HW
 F9I+oJB851oVFgtHjccOOhDOpMUpOWEwQrM/KirwNEb7kIschh3axtd/sFs3DHKjjPxK5gCLCGY
 Dl1LNwqaYMFkJJlbensI4CUkDqMd5HlTILMPEwhEiXEo2Av07MqAs3WRUuuKZt4SDhJzS3pSC54
 To=
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
 refs/debug.c            | 13 +++++++++++++
 refs/files-backend.c    | 11 +++++++++++
 refs/packed-backend.c   | 13 +++++++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c | 25 +++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/refs/debug.c b/refs/debug.c
index 260d7457db..71031c8326 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -125,6 +125,17 @@ static int debug_optimize(struct ref_store *ref_store, struct optimize_refs_opts
 	return res;
 }
 
+static int debug_optimize_required(struct ref_store *ref_store,
+				   struct optimize_refs_opts *opts,
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
@@ -432,6 +443,8 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_abort = debug_transaction_abort,
 
 	.optimize = debug_optimize,
+	.optimize_required = debug_optimize_required,
+
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1c37899006..c262ae1a7b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1513,6 +1513,16 @@ static int files_optimize(struct ref_store *ref_store,
 	return 0;
 }
 
+static int files_optimize_required(struct ref_store *ref_store,
+				   struct optimize_refs_opts *opts,
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
@@ -3964,6 +3974,7 @@ struct ref_storage_be refs_be_files = {
 	.transaction_abort = files_transaction_abort,
 
 	.optimize = files_optimize,
+	.optimize_required = files_optimize_required,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index acaa5a6e57..c94948f618 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1784,6 +1784,17 @@ static int packed_optimize(struct ref_store *ref_store UNUSED,
 	return 0;
 }
 
+static int packed_optimize_required(struct ref_store *ref_store UNUSED,
+				    struct optimize_refs_opts *opts UNUSED,
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
index 4ef2422729..5c49567560 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -424,6 +424,11 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct optimize_refs_opts *opts);
+
+typedef int optimize_required_fn(struct ref_store *ref_store,
+				 struct optimize_refs_opts *opts,
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
index d77714366a..df39fe9b38 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1732,6 +1732,29 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_optimize_required(struct ref_store *ref_store,
+					 struct optimize_refs_opts *opts,
+					 bool *required)
+{
+	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, REF_STORE_READ,
+							       "optimize_refs_required");
+	struct reftable_stack *stack;
+
+	if (refs->err)
+		return refs->err;
+
+	stack = refs->worktree_backend.stack;
+	if (!stack)
+		stack = refs->main_backend.stack;
+
+	if (opts->flags & OPTIMIZE_REFS_AUTO)
+		return reftable_stack_compaction_required(stack, required);
+	else
+		*required = true;
+
+	return 0;
+}
+
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2710,6 +2733,8 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_abort = reftable_be_transaction_abort,
 
 	.optimize = reftable_be_optimize,
+	.optimize_required = reftable_be_optimize_required,
+
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 

-- 
2.51.0

