Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B722D8DAA
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948323; cv=none; b=m/hM3/GGX6hueuRiPlYzbdTymNPu1iFM1t5qmWluYMuVBgQ7MDqeqvnT9t2JlDu9ztYA77BCjjvXKlM6iTmwPfESAJr4pX+RFVh4kca6TPJHOl9ZcFk6hkog5Ztuumbcvq1A04n8aCYoBcg+wjtPEOffSGuRiNl8RyacZQ9MYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948323; c=relaxed/simple;
	bh=Bm+yNbm8UDFh6wlBZu59C1wGh8qpdoz2FysO7L9SL/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq9rO6qoAENHjs3OPKsQYsYrffx6MCEi02ttqSHIERst5rOzdU4jR9u8pKQ/kb14yRmmxPh2FELj8rVvuJtt6XPYPoQlmKTMe9jHHhqduyYgS1ZlcKRG9vbGkHZWDhUgJ9QvVdp2T+v/LcWg4HWX2anPaDvouP4mTIOb1enhpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSh/mmM3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSh/mmM3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso710662366b.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948319; x=1761553119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDvzjMN6jp2oItRTIgB1ixdA6PMcBOm1XTA9xkMb4lU=;
        b=CSh/mmM3a3c79r2hYdK5+mi3X+39cBV7sLEFU6HD8b7dwD/nOr2l1Pz53MlfZYqMO6
         ugb+COuunUUfjxB2FtiKWQR0loD13qSHvqInD9D31z6uG8bpT++OFNxQmQuphjJ8/Wk+
         Z9fv4lZiRzrvLBd4/ijBP+6bXqMR6Ux4Dcu0kbPko784ARDXnHT77tZ1kBED/qeSnzu9
         JfusaE21KM2bv6TSi07mt1h94WFtuKchzhgux88eAzdL2u6EbGh5NWmiSmpUdJE0wb3K
         6Wuk6GB5yJXX1pG8j3oby1KdrzOmch3oxgNRFnk4Cnr3FhCY1QKdmpywcME/G6aqWIzD
         pMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948319; x=1761553119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDvzjMN6jp2oItRTIgB1ixdA6PMcBOm1XTA9xkMb4lU=;
        b=w+THk3aHqZ2HvjXDzZaBTXWhJf8aN99UKAVxDUCwBdSTf2DEbbXrbXpVUbC4Lnh053
         Dcb69cdf0wHbhEtUdIQA6fQe0NhtIQo6RwEqBRnvkwTs9VoTSjMA2B9ZnsewN7s07Hjs
         TvpfUp/7o2tBAEFFSNzmPVJX1FS1hxY5HcgaWkGXFj/7paWUM6J+JJTuG+BJcb+f3KdM
         ZZo0TknWyrYsrXka5uKKhJCx/k8Xh9cseOqewioCecz3/pH5g3Bblpf3oBm1fie1AXoJ
         nsvwFSrW4BJqp7tfVj3/rCghf5GQiiLtJ92g0mk3qX+ulGTYExvso0eKH8AxK8/FVTNt
         3Wiw==
X-Gm-Message-State: AOJu0Yww2BHihsK/Ug0stlwVIYwxwNKUBiorE6TAJQGUa+bAiQ4fVq7H
	8Zbb6jCFIYxpVfgkbff5J+pcO/TeW+W4wE8kbWH1lb29oH/i5R8rCJl2bV40fnLY
X-Gm-Gg: ASbGnctAQeY6akxBvzeBu/nVB+4ZYnfC0VkJMocAxSyoUwdLTHDD6mkKycXtzSRaTgK
	6kngW3V0H4cKUDqoda7OTFj/yvrdrkKrfhA30tMaFUYAZI7wexQNwAcl8G7ivZer8CL/fP400lj
	HVoR0ikr2bYKvmoJvI/myw4DqbSwSYx+4654Hxe54In0M1O9qIiMAbwcBoXdbZtdWenuazEg7ia
	844laTfS1XcR4OrSeioPxSG7kpGLgKDZRdKQHoxy2PXv2Vx9B/bRscR4q24cPlbzUT9CP2JxV0z
	uozi7gmQYJ/g5xZCxZApolseX25/VL9qtrx627+V8iQzBKZ/vWVUodicdflH/mv9iXc7VGZAYc5
	a+b3Rt21GJXGSkQe4flkumWPEVEOGrWH3RjdlIG+7KwmJHtnj4kXka3AMPTHGGZp777dAAFlddU
	1/tYQcaxZ5
X-Google-Smtp-Source: AGHT+IH7IBmC3jwD5R6L6XkZrSI7vf4n3E3EitdbHIj1cebLIi1d1MUcHmeSDM2YUiYA1AXcKZ1jaA==
X-Received: by 2002:a17:907:1c85:b0:b3e:5f20:888d with SMTP id a640c23a62f3a-b647304516amr1634359166b.27.1760948318957;
        Mon, 20 Oct 2025 01:18:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5fd9:4a3c:9f89:6c65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc42bc5sm716186066b.76.2025.10.20.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Oct 2025 10:18:30 +0200
Subject: [PATCH v2 2/3] refs: rename 'pack_refs_opts' to
 'refs_optimize_opts'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-refs-code-cleanup-v2-2-f5349ed0f6a5@gmail.com>
References: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
In-Reply-To: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9207; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Bm+yNbm8UDFh6wlBZu59C1wGh8qpdoz2FysO7L9SL/w=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGj18FsBzdToIs/Y/+bCKuuxJefV2di2S7GGQ
 EK3LN1qGis+RYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo9fBbAAoJED7VnySO
 Rox/n+IMAIWPHozWlutiI1Ve4d+gV5/FBcF+eoCqp2+pkF7JPN08wicdjRErvKVXIKnu61qbmJj
 6Fc1m7xBXqMV88BCuPE2n6GXtQIlDc7fntj3GBrf91dJrPdSDMSiJdX7iKve9WLgCMBXHJAD9sc
 gfShR0pWoTAMspGo6mdpgU/6gxL7vxoRXZ/OyylUXIMg1guigqNV/PYpoxMLPxC94EvPR3QScqX
 Dax2qoCthaN9pQ6cdBlUvtPAiaIiTjTkxCeKzcvGQrwbWdTAq0bNIPhxf7Q3xyJvhm5hK5N1V0h
 NeIEErtcRBj9M8rOWS7A4LYkDMWx84kCut2HcXRkV0XMvW11VNmZ1IdG7U1LIGn1oE4YqHc1c5d
 md1AHi3ySBMXxi5NRmOvK4NiT/2w2IWOkRQ/xYLiCTAuxWgIz7BsMYAhZCg3i5bheAuU10sk2Z9
 n7lErw6MjjTqwE6ywHSBnzRByFay5hseLtHSC6uyTFep+nvb7TUT3xpSz0Wbptg2Fm5IS7JES16
 h4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit removed all references to 'pack_refs()' within
the refs subsystem. Continue this cleanup by also renaming
'pack_refs_opts' to 'refs_optimize_opts' and the respective flags
accordingly. Keeping the naming consistent will make the code easier to
maintain.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-refs.c             | 20 ++++++++++----------
 refs.c                  |  2 +-
 refs.h                  | 18 +++++++++---------
 refs/debug.c            |  2 +-
 refs/files-backend.c    | 10 +++++-----
 refs/packed-backend.c   |  2 +-
 refs/refs-internal.h    |  2 +-
 refs/reftable-backend.c |  4 ++--
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 1a5e07d8b8..eb6b2ba2c2 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -14,10 +14,10 @@ int pack_refs_core(int argc,
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts = {
+	struct refs_optimize_opts optimize_opts = {
 		.exclusions = &excludes,
 		.includes = &included_refs,
-		.flags = PACK_REFS_PRUNE,
+		.flags = REFS_OPTIMIZE_PRUNE,
 	};
 	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
@@ -26,9 +26,9 @@ int pack_refs_core(int argc,
 
 	struct option opts[] = {
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
-		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
-		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
-		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
+		OPT_BIT(0, "prune", &optimize_opts.flags, N_("prune loose refs (default)"), REFS_OPTIMIZE_PRUNE),
+		OPT_BIT(0, "auto", &optimize_opts.flags, N_("auto-pack refs as needed"), REFS_OPTIMIZE_AUTO),
+		OPT_STRING_LIST(0, "include", optimize_opts.includes, N_("pattern"),
 			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
 			N_("references to exclude")),
@@ -39,15 +39,15 @@ int pack_refs_core(int argc,
 		usage_with_options(usage_opts, opts);
 
 	for_each_string_list_item(item, &option_excluded_refs)
-		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
+		add_ref_exclusion(optimize_opts.exclusions, item->string);
 
 	if (pack_all)
-		string_list_append(pack_refs_opts.includes, "*");
+		string_list_append(optimize_opts.includes, "*");
 
-	if (!pack_refs_opts.includes->nr)
-		string_list_append(pack_refs_opts.includes, "refs/tags/*");
+	if (!optimize_opts.includes->nr)
+		string_list_append(optimize_opts.includes, "refs/tags/*");
 
-	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
+	ret = refs_optimize(get_main_ref_store(repo), &optimize_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
diff --git a/refs.c b/refs.c
index b9a4a60646..0d0831f29b 100644
--- a/refs.c
+++ b/refs.c
@@ -2313,7 +2313,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 	refs->gitdir = xstrdup(path);
 }
 
-int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
+int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts)
 {
 	return refs->be->optimize(refs, opts);
 }
diff --git a/refs.h b/refs.h
index 6edb633eb6..d2630af97f 100644
--- a/refs.h
+++ b/refs.h
@@ -499,16 +499,16 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const struct string_list *refnames);
 
 /*
- * Flags for controlling behaviour of pack_refs()
- * PACK_REFS_PRUNE: Prune loose refs after packing
- * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
- *                 result are decided by the ref backend. Backends may ignore
- *                 this flag and fall back to a normal repack.
+ * Flags for controlling behaviour of refs_optimize()
+ * REFS_OPTIMIZE_PRUNE: Prune loose refs after packing
+ * REFS_OPTIMIZE_AUTO: Pack refs on a best effort basis. The heuristics and end
+ *                     result are decided by the ref backend. Backends may ignore
+ *                     this flag and fall back to a normal repack.
  */
-#define PACK_REFS_PRUNE (1 << 0)
-#define PACK_REFS_AUTO  (1 << 1)
+#define REFS_OPTIMIZE_PRUNE (1 << 0)
+#define REFS_OPTIMIZE_AUTO  (1 << 1)
 
-struct pack_refs_opts {
+struct refs_optimize_opts {
 	unsigned int flags;
 	struct ref_exclusions *exclusions;
 	struct string_list *includes;
@@ -518,7 +518,7 @@ struct pack_refs_opts {
  * Optimize the ref store. The exact behavior is up to the backend.
  * For the files backend, this is equivalent to packing refs.
  */
-int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
+int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts);
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/debug.c b/refs/debug.c
index 40cd1d9c15..2defd2d465 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -116,7 +116,7 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
+static int debug_optimize(struct ref_store *ref_store, struct refs_optimize_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = drefs->refs->be->optimize(drefs->refs, opts);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 92d90fc508..2f60395cd2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1355,7 +1355,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
  */
 static int should_pack_ref(struct files_ref_store *refs,
 			   const struct reference *ref,
-			   struct pack_refs_opts *opts)
+			   struct refs_optimize_opts *opts)
 {
 	struct string_list_item *item;
 
@@ -1383,7 +1383,7 @@ static int should_pack_ref(struct files_ref_store *refs,
 }
 
 static int should_pack_refs(struct files_ref_store *refs,
-			    struct pack_refs_opts *opts)
+			    struct refs_optimize_opts *opts)
 {
 	struct ref_iterator *iter;
 	size_t packed_size;
@@ -1391,7 +1391,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	size_t limit;
 	int ret;
 
-	if (!(opts->flags & PACK_REFS_AUTO))
+	if (!(opts->flags & REFS_OPTIMIZE_AUTO))
 		return 1;
 
 	ret = packed_refs_size(refs->packed_ref_store, &packed_size);
@@ -1445,7 +1445,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 }
 
 static int files_optimize(struct ref_store *ref_store,
-			  struct pack_refs_opts *opts)
+			  struct refs_optimize_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1488,7 +1488,7 @@ static int files_optimize(struct ref_store *ref_store,
 			    iter->ref.name, err.buf);
 
 		/* Schedule the loose reference for pruning if requested. */
-		if ((opts->flags & PACK_REFS_PRUNE)) {
+		if ((opts->flags & REFS_OPTIMIZE_PRUNE)) {
 			struct ref_to_prune *n;
 			FLEX_ALLOC_STR(n, name, iter->ref.name);
 			oidcpy(&n->oid, iter->ref.oid);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 20cf9fab18..10062fd8b6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1774,7 +1774,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 }
 
 static int packed_optimize(struct ref_store *ref_store UNUSED,
-			   struct pack_refs_opts *pack_opts UNUSED)
+			   struct refs_optimize_opts *opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc5149df5b..dee42f231d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -423,7 +423,7 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int optimize_fn(struct ref_store *ref_store,
-			struct pack_refs_opts *opts);
+			struct refs_optimize_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 43cc66a48e..c23c45f3bf 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1701,7 +1701,7 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 }
 
 static int reftable_be_optimize(struct ref_store *ref_store,
-				struct pack_refs_opts *opts)
+				struct refs_optimize_opts *opts)
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "optimize_refs");
@@ -1715,7 +1715,7 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 	if (!stack)
 		stack = refs->main_backend.stack;
 
-	if (opts->flags & PACK_REFS_AUTO)
+	if (opts->flags & REFS_OPTIMIZE_AUTO)
 		ret = reftable_stack_auto_compact(stack);
 	else
 		ret = reftable_stack_compact_all(stack, NULL);

-- 
2.51.0

