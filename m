Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51C55820F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991958; cv=none; b=D2FfFWL9RU8oiB582fvZgebkGhSlqbTDZ9uhnsc/HWM0PYLjp+qZg+Xehavxgq1WFyZpjDEit2rL+LL68wZQxbFaBtNqdrGbLSTqA2lo3PlpCwMWKlVU1jDa1Du4GU1o63HBcYTYc70tDC/HGrSyxM1V8IzrYkT0MM/9XcQyk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991958; c=relaxed/simple;
	bh=Uk4ZsTSuU/zHwGPRvvJofXc7tDVNOQ6+bwUVHtganSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsQwGGJfbxX0DJ8veW9kxjxr4f45i94aY3Z1XMlSkyNeK0/AvY4lFHY5rngGfD55xWntPoBObD9dUAlzicYIRfO4MS+GSSMXe/Zxfk1NOBBc1NzO8BIHyReXURvJD5n6Y8dHUO3bXkMnT5/XrN5yQJRxIzAgOtEdvkKJJNRdtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8A++Rqo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8A++Rqo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so34588905e9.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791991954; x=1792596754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPKhv1lH4GEHzSPz7Uwtfx7sImRc6TwR5ybM9CD6Nf8=;
        b=P8A++RqoBZ622rov8Mf3hxeb41/sJZA+iuxlKoQq48oDw2ehyoIaL+PbWmBcSRQIg6
         LEJZi35mnRTuNKmEUACgqIvf9kc7gAYobq6JKEKhWo7OayEsxmQYXzAdle5YVBzLtxZd
         uy1ro9zxE6ta3b48A/GAXX3/7yrknjiuFwK8AapJtDnmew3F5o09PQFTTVsbVkz1iqxg
         TZUmd+bGzXoUfO4rtnRF8FK5dcN7zBc1e/k5nIKK0K5u2fDxcTNRBwPUz8gf85s3guU5
         R0gbwRBDmfGAgzLbkoZspS85RE8wzWRpgOC+v1/weovIYwQiduwQ9XRfluWL2KFlpL19
         IqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991954; x=1792596754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPKhv1lH4GEHzSPz7Uwtfx7sImRc6TwR5ybM9CD6Nf8=;
        b=rTZ6HujRlLIRT0u31ZifCdfBTNpgqq+gHfthGdJ2aj7rjrT5leuiK4jYkgpTgByYsM
         +9Yq77OJnxSl+ERViIJNMmDGrin/b5Wd1zQQG0MdA+fos+614iemKiIEwRY6HCBu1xLS
         XvVeasqEF19uZZ8ZxJBp2oxh6npzQqVUrli509mSnqsEfp5hIkjsm034dxffSWpDPmo1
         6r+qogWMejZbFPEXsXrqlHHJEQfsw6pyqSRC0Anh2znZnIZygBQwT5lZvmbK5+eDJZTP
         zGjm3EIEv2dImmzTLUS5xhDSeG8+k5izL4ex6COG4nSABvFk407LqBXQq2LjnJ4o+3af
         T7kA==
X-Gm-Message-State: AFq9FYKObLS4cGIivqiI0RyW5walcw1W1w0uQjUTSxR0NZSCtDAHL13j
	c4wb69jzhxIAqTo9SYhRw4+bQ1l2bXpAdEOZgBlPhDEL7hIB5kdi5+AQ0t692VPv
X-Gm-Gg: AYBFou0s+y/rmUAwh+vG4Olp1iGNvTVBbRbAThmS7yzxzBfov5S2JReWruzr2J839xT
	p/VbMS8eCo+yY5NapxVxpyKRfa3snFPIld7tgOf3yA9MqoeVy4o1+pOwOtp88oLOvoeak7Ds6TK
	yXFpjWvMnT07AnIt9esSmlZb5C4YDOO0zEpRl2ZSKAjGtWd+FZ1I0Qg3NIcTWRMC4pkUFfoNW9r
	6L/ht0Kscv9i+tydW/ONOyRRhXPSKC+IZnnGve8fkntYXrzS5vMCkB3TckCbSnv4+MoX5LntOoc
	Vd9dOE1Bjng5F7HIbBqm1kFTxLtIwpmCHftJpR5T9MJlnt22+hQMwobbPTuQhCtTMHAiixblLPK
	R/gPH0SWGke9mhhNu8zAqRQ627w5CHnKrjyLh6AJqg0Atf/Lg4WHxtqT9yDcUpvJZPIUHL9lx3i
	6ey3IiCjo6fzE4zslAvKyw6x858VRWEsmXfFi0jHs4CWR4KIeBiArMYDa9AEG5NbFicieqiRla8
	XkBW5CPW8dlSymwjVSDw85hM7mKF6ZlaYh0bZr3npZlveJgRHwdY3/rug==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr321528115e9.26.1791991953710;
        Wed, 14 Oct 2026 08:32:33 -0700 (PDT)
Received: from u.ad.analog.com (dynamic-078-054-209-001.78.54.pool.telefonica.de. [78.54.209.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd1a0d2esm5775495e9.10.2026.10.14.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:32:33 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] refs/files: keep root refs out of loose ref cache
Date: Wed, 14 Oct 2026 16:32:08 +0100
Message-ID: <20261014153208.2194727-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the files backend, root refs such as HEAD or ORIG_HEAD are only
added to the loose ref cache if REFS_FOR_EACH_INCLUDE_ROOT_REFS is
passed to the iteration that creates the cache. If the cache has already
been created by an earlier iteration, root refs are silently omitted.
Conversely, once they have been added, any later iteration also yields
them, whether or not it asked for them. This has been the case since
d0f00c1ac17 (refs: introduce `refs_for_each_include_root_refs()`).

For example, `git for-each-ref --include-root-refs --merged=main` omits
root refs that are merged into main, because looking up the given commit
loads the replace refs, which populates the loose ref cache first. The
reftable backend is not affected.

Fix this by keeping the root refs out of the shared loose ref cache.
Instead, read them into a separate ref cache whenever an iteration asks
for them, and overlay its iterator on the loose ref iterator. The cache
is freed when the iteration finishes.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 refs/files-backend.c           | 38 +++++++++++++++++++++++++++-------
 t/t6302-for-each-ref-filter.sh | 12 +++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 71628550f2..74409878b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -481,8 +481,21 @@ static void add_root_refs(struct files_ref_store *refs,
 	for_each_root_ref(refs, fill_root_ref, &data);
 }
 
-static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
-					     unsigned int flags)
+/*
+ * Create a separate ref cache containing only the root refs. These are kept
+ * out of the loose ref cache, which may already exist and is shared by
+ * iterations that should not include them.
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
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		struct ref_dir *dir;
@@ -499,9 +512,6 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
 
 		dir = get_ref_dir(refs->loose->root);
 
-		if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_root_refs(refs, dir);
-
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
 		 * lazily):
@@ -1004,6 +1014,7 @@ struct files_ref_iterator {
 	struct ref_iterator base;
 
 	struct ref_iterator *iter0;
+	struct ref_cache *root_refs;
 	struct repository *repo;
 	unsigned int flags;
 };
@@ -1053,6 +1064,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
 	ref_iterator_free(iter->iter0);
+	free_ref_cache(iter->root_refs);
 }
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
@@ -1068,6 +1080,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
+	struct ref_cache *root_refs = NULL;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -1094,9 +1107,17 @@ static struct ref_iterator *files_ref_iterator_begin(
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
@@ -1118,6 +1139,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
 	iter->iter0 = overlay_iter;
+	iter->root_refs = root_refs;
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
@@ -1490,7 +1512,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	if (limit < 16)
 		limit = 16;
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
 					refs->base.repo, 0);
 	while ((ret = ref_iterator_advance(iter)) == ITER_OK) {
 		if (should_pack_ref(refs, &iter->ref, opts))
@@ -1530,7 +1552,7 @@ static int files_optimize(struct ref_store *ref_store,
 
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
-- 
2.56.0

