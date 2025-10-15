Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296692F5A2C
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563522; cv=none; b=HmaKIiF+laxDhCpRgLfcgUMokDGeUPYIX/+E3wNTbhgOKfgblC99KxciovlzXLXnO81TE3XTScPQItKCRPWiB2Q1Z/tte7jZt4OhS8IHcL3v990mx8WLWAEh+HsRfHZ7tnkhnRRUqxzSf9F3pKPurZSdqIysuo8HRafmtRC36us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563522; c=relaxed/simple;
	bh=ejYxa3CkPndT3jeqWZa0djpBNJlqCM+ueUcV0HRPGyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UU5ALC4GLhI2rn9h0JLKQScdZ2VAPOY9Be2KEPvNlwrjwOCsxM24QwdToXkwGxx6EDw51LhZfx7Ya6rDKPKPf08QITOQGA/PRsXJ4ZoQQ+5DIU0357ubIXjXAYBJLk18ixDGr+vdyUD/pIIF5QnFqLXALbz7EoqNsPKoShlCne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co8+KY02; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co8+KY02"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b472842981fso4260066b.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563518; x=1761168318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmh1G6waJFcVO+VM9BYbwz0MB6XQ2JFJXvjXLguImw4=;
        b=co8+KY02TsYwz4yBLn9HTLb6xHKrce0KPCMyGdv2ptYR/pUs5s60G7NlBN4K6fbTc0
         4Uz8u/6nW9oz8AnWAZoX1KawkpsYAhlHWMW+9fO93nThRPX4B+JRDOhSArG6CstnmH9E
         YDh96aaCOV7clpwAmVpaZrRkv1EC73sEIdYwQPRR7pb30XevkhCwrZAiREnlePT69D5V
         sqInzaehNi6Rc9eSjIDTQXdq+3D7qpZbiAGmniBmsm9q6tNvf4fEeVqas2SzlK9cLQtC
         40m8c68Vn5bRH3EAmv15OVUGrbi5zgz2q19Z358YNZ6CCBL8zNSDEsePhbZaXj62O0Hh
         aalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563518; x=1761168318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmh1G6waJFcVO+VM9BYbwz0MB6XQ2JFJXvjXLguImw4=;
        b=DHRKyCndt6XZpTo4PVqoFA/F2/s6K+0fzGUktBAgWaacnB8bpZpxcgQ/+PeCh/5Jke
         L+p/xIkIxa8woqLCI8WRiUL4GvbzDkM7clRY1wlAsDTE597dAGIctypTafB5ZFXfXTLD
         9xyhoco/UYAKztO91dFdS1mW+ndvnR1X95UKwjzEGpOthIR8N1564z2luqkqNTNkiQBf
         T4zkRmVFkMMF6QFtnzwNFZ7JAbwVyhxWzw04qO0I+1vcmXyAqd/Nkv27NeLXeWT30sA4
         VKK7D6fUJdMyzBnuIsOnRcZWqNW3VKO1FV8QtrIH7oRH0gWTiPvluyDMyVTVTNNc6m4g
         SpdQ==
X-Gm-Message-State: AOJu0Yzb2oH75tKl5l3nrGf7mbcBrLHZRcdSVkqjO2IGZEJxGHvBqO34
	OPBZQD2aMs55tN9wU0ZOJV8foVZxhcAoJp8zWbIRXuAA/YJMRE4+vHYDh3Yagw7/
X-Gm-Gg: ASbGncug9/3SbC1ZUsBx+FBWQ1qZd16llpNHHL499zaBGVKKJFX6vCkWuWxq9Heeybl
	UsbMH8XP4VC9odZxmaWHiWMfEHvXePsJIxw5DZtcQnsVf+OmFG6sos6JsghlBwqOVqVcujdV66Q
	BeWX00GdPiXLsg13lX0CjE2iNIktDv+Pdm/Ck+WdGQMpaTJVAmrTyD88q93pr1LTgfEwzAo812M
	iMP0V1xTRqllQ7/JZ3qDHfYLMFgXTKsRKoRICKy7NqzaEpmaZxP2RclsXbZOEj7amtNOdywBO2g
	eZ1Yvwu7PyhLtXBXao/1DmKidfvuifMYl74Y96FteNAGHDstXawcwnStR8cnBJ/Z/LoFYdcDVPI
	jOk1BQMnmJfhVpvIlXPxmcXe+pbnBScFElic8pSnlFankb14JJQ==
X-Google-Smtp-Source: AGHT+IEX0eOD3vjnKkkKfV2qviqXAJ2MAPTbzGTJTumvs5S1qNOGiUVREBoQ+jRh1BTWuYfFsHjvqw==
X-Received: by 2002:a17:907:7f17:b0:b45:c0cc:2fe9 with SMTP id a640c23a62f3a-b50ac8e5577mr3207117066b.46.1760563517984;
        Wed, 15 Oct 2025 14:25:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:980b:e8aa:7473:ef22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa082sm315854766b.50.2025.10.15.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:25:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 15 Oct 2025 23:25:06 +0200
Subject: [PATCH 1/4] refs: move to using the '.optimize' functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
In-Reply-To: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5653; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ejYxa3CkPndT3jeqWZa0djpBNJlqCM+ueUcV0HRPGyw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjwETuz7ku8UfS5S7MdJg2Yu3tqxd/o3ijQ4
 FWEKBG0Z7kAMokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo8BE7AAoJED7VnySO
 Rox/R40L+gIGljZqL68uaJlj/e9NiYwbiyK83hwByjoO7Q/KNROgLjomYt3/2moRKJRkBaJBFoq
 KDKZl5C4cLOtUf8uIMcsnTPWIH/GddzrUBv/JtMyOvkig7fiObdNdCtQIy2EltpgQgBS2hgsVda
 03Uoj2MK3XOSG0N2QcjoRIqCSYOoFrUrhUpIj4WzGTRgPD4pYxGchysAIfQjP/B4MFIc52qoMnM
 zixepmo+4ZISbgXKU+xOMw2LwFX2gfvSdBGF8cZlMzJmVst1qdMGLBP5biq5h6QzoUkrtlIjhRo
 2hMLo6u6QvzuPBCkhnWBj6DWNW46jdSQCO+Mc2WVOVN6n7+xhUgwm/uNvh3KTOcGD24YEC7QwZV
 BQopcIhlEDtPF0EAnAECuc/TcDQ1m7E8kw297VpoIKzsrCW6b4OxKzJPwN2rwADY98lkldaWn7q
 ectYtliAhV4/aDTP4CgRu9oR5RMREY3UnbtKUC8LpwHb8kiLuQwK9LMGDyRgCBuOcBjGTxy3Gn2
 9I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `struct ref_store` variable, exposes two ways to optimize a reftable
backend:

  1. pack_refs
  2. optimize

The former was specific to the 'files' + 'packed' refs backend. The
latter is more generic and covers all backends. While the naming is
different, both of these functions perform the same functionality.

In the following commit, we will consolidate this code to only maintain
the 'optimize' functions. In preparation, modify the backends so that
they exclusively implement the `optimize` callback, only. All users of
the refs subsystem already use the 'optimize' function so there is no
changes needed on the callee side.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            |  8 ++++----
 refs/files-backend.c    | 14 ++------------
 refs/packed-backend.c   |  6 +++---
 refs/reftable-backend.c | 13 +++----------
 4 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 01499b9033..40cd1d9c15 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -116,11 +116,11 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
+static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
-	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
+	int res = drefs->refs->be->optimize(drefs->refs, opts);
+	trace_printf_key(&trace_refs, "optimize: %d\n", res);
 	return res;
 }
 
@@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
 
-	.pack_refs = debug_pack_refs,
+	.optimize = debug_optimize,
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ed8a1729d6..92d90fc508 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1444,8 +1444,8 @@ static int should_pack_refs(struct files_ref_store *refs,
 	return 0;
 }
 
-static int files_pack_refs(struct ref_store *ref_store,
-			   struct pack_refs_opts *opts)
+static int files_optimize(struct ref_store *ref_store,
+			  struct pack_refs_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1512,15 +1512,6 @@ static int files_pack_refs(struct ref_store *ref_store,
 	return 0;
 }
 
-static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
-{
-	/*
-	 * For the "files" backend, "optimizing" is the same as "packing".
-	 * So, we just call the existing worker function for packing.
-	 */
-	return files_pack_refs(ref_store, opts);
-}
-
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3969,7 +3960,6 @@ struct ref_storage_be refs_be_files = {
 	.transaction_finish = files_transaction_finish,
 	.transaction_abort = files_transaction_abort,
 
-	.pack_refs = files_pack_refs,
 	.optimize = files_optimize,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1ab0c50393..20cf9fab18 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1773,8 +1773,8 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	return ret;
 }
 
-static int packed_pack_refs(struct ref_store *ref_store UNUSED,
-			    struct pack_refs_opts *pack_opts UNUSED)
+static int packed_optimize(struct ref_store *ref_store UNUSED,
+			   struct pack_refs_opts *pack_opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
@@ -2129,7 +2129,7 @@ struct ref_storage_be refs_be_packed = {
 	.transaction_finish = packed_transaction_finish,
 	.transaction_abort = packed_transaction_abort,
 
-	.pack_refs = packed_pack_refs,
+	.optimize = packed_optimize,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6bbfd5618d..43cc66a48e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1700,11 +1700,11 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	return ret;
 }
 
-static int reftable_be_pack_refs(struct ref_store *ref_store,
-				 struct pack_refs_opts *opts)
+static int reftable_be_optimize(struct ref_store *ref_store,
+				struct pack_refs_opts *opts)
 {
 	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "pack_refs");
+		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "optimize_refs");
 	struct reftable_stack *stack;
 	int ret;
 
@@ -1733,12 +1733,6 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_optimize(struct ref_store *ref_store,
-				struct pack_refs_opts *opts)
-{
-	return reftable_be_pack_refs(ref_store, opts);
-}
-
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2761,7 +2755,6 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_finish = reftable_be_transaction_finish,
 	.transaction_abort = reftable_be_transaction_abort,
 
-	.pack_refs = reftable_be_pack_refs,
 	.optimize = reftable_be_optimize,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,

-- 
2.51.0

