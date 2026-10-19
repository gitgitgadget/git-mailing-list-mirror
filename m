Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442122;
	b=4kArkk6+x9XofKhe9qauq9PfmH9gm+U14/QlSHaa55iLCUJ/LWYDAMNOIvXBx/3ba0on
	 O7WOiPAG6uenlTm80f409VjZRnfdqHwhygSrLNA11I3slXgF/zIBNSv9+rEMNLp4f0Q1b
	 Z+txm14Qj/aNKGbJr1uf7W/g2DhQCvXf1JJKMzfQUybNU62IfuV51kjxFIN2KTsVlckgg
	 ULpXxY1FmhwiNknvVkdboj3dyymmu3hjPCbyaG12sYPi+FlCNxxLpxnQcOnej5ju0Rq/L
	 waHwM5BFCrPnXGIad7Pi7zOrtprlkXKjTsyCk3e+6I3VNpt2+NpfidtUDSEYYNW5S1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dmCgBygX1112R2/upalx04ZMNnTsGsLgDULjfAzTtSE=;
	b=LpBw8QEpvLOyx2Mi+E0RVX/eIlrirpUsC/Xo6B4Odwta0sSBbxS/uR66P/JN8/G9MHIw
	 2zI+PDtn2wJeByuEORHrtLIpq89jmORgiSGh5QthOxNGzsA+iImy2QIELWI2DgpuaWvms
	 GpBuHOH/ax5o6hYX5+xhI3ubtufWgkPrpzttJaqAk03WTuaeuKfsy6phodYnXJpF/V3L8
	 AniMnTgBXKSSoKH7p4ZtB1vMcXW8Mi0sATF1UVZsRtIqqPLl2CvIu0GTi95o0p9e0vKAp
	 qyjFfF0k+FFAjaGBQ1i/+C9cKaqOkcRnQP6xZXeegurmYRIVhjlxtwolLaiHqW36G5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b+nSLebr;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02031606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02031606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b+nSLebr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so55265f8f.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442120; x=1793046920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmCgBygX1112R2/upalx04ZMNnTsGsLgDULjfAzTtSE=;
        b=b+nSLebr6NT6OMepfcEV3pku+D5ozCVwumQeX0mNs6y8RmEU8+c1pojnNvznCrh2Mx
         kPfMGu15MN+ggN0MJOtRrvl4cbVkSSj2J6wMCfaFHK78A8ijaKeYkbfl2nCshXYNPAqX
         ESp4yfDmcq+JraLfSKE1sFRJBcdZZiQCd1o34SXyhnkM7lCyw6bXBdQF1EbESReSl1JL
         921Nh3c5hhTkE3EqbQxmex7aNto2wboNMe9IbVY5BnjA1ttOQ/GrOaB1wZc+qcU41tCG
         RJ05PWIGolp9FkT0mKdPc8xB/B62J6QehBflNWte9WnKbnknCTKroGYgHYoY8UTFUIsB
         pC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442120; x=1793046920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmCgBygX1112R2/upalx04ZMNnTsGsLgDULjfAzTtSE=;
        b=z22iG1A+6eHSMNcq27UmvuZ9ky/H0AeCbpV3gERchBAk0AEzSUp5BSqUzzbWJnJBNs
         +4VYpzyZNrKE/x69GQLOt1iJY/CvWoF1Xw08ATC5Pd27tDoX5wo1ZVFBgzf5m0lk4sA5
         FhjZapS9uN0vg2JVRZsIgb0o4bvcNlq1cQfqfzQtMvRZsjM5mtLmkBWdThWQcvoQm+Br
         e26pSqvbytPDnl/IzSZWEQMZK1jk5FCou88QweN68KrWZmhXegvxXSYWFt0gERgN9AcI
         YBxI/q9+0f5j7jwoY0m4MJ7xw8tDZHvBDdR7OgWhQ+i2imLXj1UscjJhGjd9/A638AFE
         C7JA==
X-Gm-Message-State: AFq9FYJofIr3q0FnRmD/BIIj+eiDh6leTzRHUT6ZP+rEizOxdyF/J90w
	aLXPJYpxjo8VDulq+n1PY3IpN8BCARgxwAFH0WkVpaJoFct1PhNaNgszxuApAqqm
X-Gm-Gg: AYBFou1NhMHG0Cz9yWbcQtI9WUnnKI+cec+cW0LNvD2I8ygh3WeUUOWSaSpnb/ofAuD
	huJqhQcy0E6L/yC8/lJaNBzsz03Abqj0sQ3VT5Pl9qQlR6M5L+rFjzP12/Nd6QoAx94Sar6fnWY
	pyLbnUuHhlf9BJbDoQj+ylXZkSHtU9SG6p5Vdpj9ZSKQ3OHQqAFTHCdWmLfTTbY7XWr7LGVjtnk
	6SADrO/Ub94SuK1ZGqKgISmXF/13hzDY7GkCdF5vOvdxF6vDoLgfuhitSR2fWwUGPwgepFnN614
	pUaRmWbo7gLyk0TWTNJCHwREfesIMSCe3/vnHxcN62L+Fk2pbtr5SI2/zGyZN/uUqMw7IlSArwE
	kgTp9W5W98fzpDbvv/jFJiOKilxI6Z8EHryQyZwVpgqkvTArFqdU6yK9I40gppkOFq996Eu0YTp
	NCZih90w9IRxS7pL91O64jryjl2KSRfPtzmb4iGoDBgarTeRM7o8Hsy+1bIaHUKUew0bZTY+s9Y
	7EImEBIDSqI5vwMeWiXpmQrN6u9PnSYmKNqlCGImo7P3XCQx2CTIdwI1Rjirr1n3Wg=
X-Received: by 2002:a05:6000:2890:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48e1e6f85e8mr578976f8f.0.1792442120044;
        Mon, 19 Oct 2026 13:35:20 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80f9b3sm1164486f8f.20.2026.10.19.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:35:19 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3] refs/files: keep root refs out of loose ref cache
Date: Mon, 19 Oct 2026 21:34:20 +0100
Message-ID: <20261019203427.2637569-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014153208.2194727-1-andy.koppe@gmail.com>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the files backend, root refs such as HEAD or ORIG_HEAD are only
added to the loose ref cache if REFS_FOR_EACH_INCLUDE_ROOT_REFS is
passed when the cache is created. If the cache has already been created
for an earlier ref iterator, root refs are silently omitted. Conversely,
once they have been added, any later iterator also yields them, whether
or not they were requested. This has been the case since d0f00c1ac1
(refs: introduce `refs_for_each_include_root_refs()`, 2024-02-23).

For example, `git for-each-ref --include-root-refs --merged=main` omits
root refs that are merged into main, because looking up the given commit
loads the replace refs, which populates the loose ref cache first. The
reftable backend is not affected, as it filters root refs for each
iterator rather than caching them.

Fix this by keeping the root refs out of the loose ref cache. Instead,
read them into a separate, temporary ref cache whenever an iterator is
requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS, and overlay an iterator
over that cache on the loose ref iterator. The cache is freed along with
the iterator.

Alternatively, the root refs could always be added to the loose ref
cache and skipped during iteration unless requested. But that would mean
reading them in every command that uses the loose ref cache, even though
only two call sites actually request them. Also, keeping the root ref
cache for reuse by later iterators is not worthwhile, because those two
call sites only request the root refs once per command.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
Changes from v1:
- Amend commit message for clarity and to discuss alternatives.
- Move new create_root_ref_cache() below get_loose_ref_cache() because
  its comment references the loose ref cache and because it makes for
  a cleaner diff. Tighten up the comment.

Changes from v2:
- Drop fixes to documentation of REFS_FOR_EACH_INCLUDE_ROOT_REFS and
  --include-root-refs added in v2. I'll create a separate patch with
  those as well as other fixes for outdated uses of "pseudoref".

The range diff shows the changes from v1, because they're of more
interest than dropping the documentation changes I'd added in v2.

 refs/files-backend.c           | 37 ++++++++++++++++++++++++++--------
 t/t6302-for-each-ref-filter.sh | 12 +++++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 71628550f2..9d1e527114 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -481,8 +481,7 @@ static void add_root_refs(struct files_ref_store *refs,
 	for_each_root_ref(refs, fill_root_ref, &data);
 }
 
-static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
-					     unsigned int flags)
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		struct ref_dir *dir;
@@ -499,9 +498,6 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
 
 		dir = get_ref_dir(refs->loose->root);
 
-		if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_root_refs(refs, dir);
-
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
 		 * lazily):
@@ -511,6 +507,19 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
 	return refs->loose;
 }
 
+/*
+ * Root refs are kept out of the loose ref cache because ref iterators must
+ * only include them when requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS.
+ */
+static struct ref_cache *create_root_ref_cache(struct files_ref_store *refs)
+{
+	struct ref_cache *cache = create_ref_cache(&refs->base, NULL);
+
+	cache->root->flag &= ~REF_INCOMPLETE;
+	add_root_refs(refs, get_ref_dir(cache->root));
+	return cache;
+}
+
 static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 			     struct object_id *oid, struct strbuf *referent,
 			     unsigned int *type, int *failure_errno, int skip_packed_refs)
@@ -1004,6 +1013,7 @@ struct files_ref_iterator {
 	struct ref_iterator base;
 
 	struct ref_iterator *iter0;
+	struct ref_cache *root_refs;
 	struct repository *repo;
 	unsigned int flags;
 };
@@ -1053,6 +1063,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
 	ref_iterator_free(iter->iter0);
+	free_ref_cache(iter->root_refs);
 }
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
@@ -1068,6 +1079,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
+	struct ref_cache *root_refs = NULL;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -1094,9 +1106,17 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * disk, and re-reads it if not.
 	 */
 
-	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
+	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
 					      prefix, ref_store->repo, 1);
 
+	if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS) {
+		root_refs = create_root_ref_cache(refs);
+		loose_iter = overlay_ref_iterator_begin(
+				cache_ref_iterator_begin(root_refs, prefix,
+							 ref_store->repo, 0),
+				loose_iter);
+	}
+
 	/*
 	 * The packed-refs file might contain broken references, for
 	 * example an old version of a reference that points at an
@@ -1118,6 +1138,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
 	iter->iter0 = overlay_iter;
+	iter->root_refs = root_refs;
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
@@ -1490,7 +1511,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	if (limit < 16)
 		limit = 16;
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
 					refs->base.repo, 0);
 	while ((ret = ref_iterator_advance(iter)) == ITER_OK) {
 		if (should_pack_ref(refs, &iter->ref, opts))
@@ -1530,7 +1551,7 @@ static int files_optimize(struct ref_store *ref_store,
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
 					refs->base.repo, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..a2fc257f98 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -96,6 +96,18 @@ test_expect_success '--include-root-refs omits dangling symrefs' '
 	)
 '
 
+test_expect_success '--include-root-refs with --merged' '
+	cat >expect <<-\EOF &&
+	HEAD
+	ORIG_HEAD
+	EOF
+	test_when_finished "git update-ref -d ORIG_HEAD" &&
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" --include-root-refs \
+		--merged=main "*HEAD" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main

Range-diff against v1:
1:  5db169a16e ! 1:  49f2b11aad refs/files: keep root refs out of loose ref cache
    @@ Commit message
     
         With the files backend, root refs such as HEAD or ORIG_HEAD are only
         added to the loose ref cache if REFS_FOR_EACH_INCLUDE_ROOT_REFS is
    -    passed to the iteration that creates the cache. If the cache has already
    -    been created by an earlier iteration, root refs are silently omitted.
    -    Conversely, once they have been added, any later iteration also yields
    -    them, whether or not it asked for them. This has been the case since
    -    d0f00c1ac17 (refs: introduce `refs_for_each_include_root_refs()`).
    +    passed when the cache is created. If the cache has already been created
    +    for an earlier ref iterator, root refs are silently omitted. Conversely,
    +    once they have been added, any later iterator also yields them, whether
    +    or not they were requested. This has been the case since d0f00c1ac1
    +    (refs: introduce `refs_for_each_include_root_refs()`, 2024-02-23).
     
         For example, `git for-each-ref --include-root-refs --merged=main` omits
         root refs that are merged into main, because looking up the given commit
         loads the replace refs, which populates the loose ref cache first. The
    -    reftable backend is not affected.
    +    reftable backend is not affected, as it filters root refs for each
    +    iterator rather than caching them.
     
    -    Fix this by keeping the root refs out of the shared loose ref cache.
    -    Instead, read them into a separate ref cache whenever an iteration asks
    -    for them, and overlay its iterator on the loose ref iterator. The cache
    -    is freed when the iteration finishes.
    +    Fix this by keeping the root refs out of the loose ref cache. Instead,
    +    read them into a separate, temporary ref cache whenever an iterator is
    +    requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS, and overlay an iterator
    +    over that cache on the loose ref iterator. The cache is freed along with
    +    the iterator.
    +
    +    Alternatively, the root refs could always be added to the loose ref
    +    cache and skipped during iteration unless requested. But that would mean
    +    reading them in every command that uses the loose ref cache, even though
    +    only two call sites actually request them. Also, keeping the root ref
    +    cache for reuse by later iterators is not worthwhile, because those two
    +    call sites only request the root refs once per command.
     
         Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
     
    @@ refs/files-backend.c: static void add_root_refs(struct files_ref_store *refs,
      
     -static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
     -					     unsigned int flags)
    -+/*
    -+ * Create a separate ref cache containing only the root refs. These are kept
    -+ * out of the loose ref cache, which may already exist and is shared by
    -+ * iterations that should not include them.
    -+ */
    -+static struct ref_cache *create_root_ref_cache(struct files_ref_store *refs)
    -+{
    -+	struct ref_cache *cache = create_ref_cache(&refs->base, NULL);
    -+
    -+	cache->root->flag &= ~REF_INCOMPLETE;
    -+	add_root_refs(refs, get_ref_dir(cache->root));
    -+	return cache;
    -+}
    -+
     +static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
      {
      	if (!refs->loose) {
    @@ refs/files-backend.c: static struct ref_cache *get_loose_ref_cache(struct files_
      		/*
      		 * Add an incomplete entry for "refs/" (to be filled
      		 * lazily):
    +@@ refs/files-backend.c: static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
    + 	return refs->loose;
    + }
    + 
    ++/*
    ++ * Root refs are kept out of the loose ref cache because ref iterators must
    ++ * only include them when requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS.
    ++ */
    ++static struct ref_cache *create_root_ref_cache(struct files_ref_store *refs)
    ++{
    ++	struct ref_cache *cache = create_ref_cache(&refs->base, NULL);
    ++
    ++	cache->root->flag &= ~REF_INCOMPLETE;
    ++	add_root_refs(refs, get_ref_dir(cache->root));
    ++	return cache;
    ++}
    ++
    + static int read_ref_internal(struct ref_store *ref_store, const char *refname,
    + 			     struct object_id *oid, struct strbuf *referent,
    + 			     unsigned int *type, int *failure_errno, int skip_packed_refs)
     @@ refs/files-backend.c: struct files_ref_iterator {
      	struct ref_iterator base;
      
-- 
2.56.0

