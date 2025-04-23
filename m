Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50D266B71
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394513; cv=none; b=fHt19jUkQ+me2HTtpOSQ4YmMK2JxmZzXUEF6YugTwg2f5wBrZJJqI3v1T8QtedEQi1HpIFhQ+oOrX19Lzz4zc0+A4viTYNmcEaNKsUM0oxO7AkBciYwLlZWqSrbxjQTkQIIEKq10tR9AljV9GaIDZK8SMiCJnB2LLat4qEbhlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394513; c=relaxed/simple;
	bh=cFfMVXk+0+To1NJDxQxyjUeg6mj9sRJYRLPIKLzrc3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHoN/OMKKb405rV2e6VLVvU3D+rLsH9W1WdC9ZGIMGOxlv7qVVoVtPJJlL1OtYJ8E3G1FsnyWB/0tBPKgM00kns+XlT6Ch0gjSQMa/0TApoDucBkXfOu44NB7xPcYxhUhqSqCZQW4KOwqTWGQgjIA+OfLGkKtI8Z2pveSHQyM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TJ4HxXBk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TI1c/l50; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TJ4HxXBk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TI1c/l50"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F95F13804ED
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Apr 2025 03:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394509;
	 x=1745480909; bh=lhzUNYuxxs2AnxcTs2Vmh2AvVrkEFlGwzPz6ZEAS0Uo=; b=
	TJ4HxXBkMuIDqqtjkwFEFVM24i85iWDUFy9bok6R2pslJc+T9A7sSZv1aESLFSLs
	REEkQPKvqz9lXYap4oEtvyGoburHzM/uzXsWCjGCDJ0WdTRyPTPg/4yDUCLPTwb2
	gH4PJ1cEFTc0oDfo/jX5Be7qCROAslbSBCEQKS3up4QUw0vdDs438AC8nMCf0o/t
	T18ik439Xum4uGvm2QAMVg7nFbq/6Plv5qgaYaQ6P3GLxFRXmre7nOtnwdxrO1YV
	xSBchlWK5ykYSVSNgkfMyH/r+zs6ZTYGYO7kAU/0Cw8iwYPWBrQlX4NIQE2yA5TU
	Gfq85pBz/cIIepe45begWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394509; x=
	1745480909; bh=lhzUNYuxxs2AnxcTs2Vmh2AvVrkEFlGwzPz6ZEAS0Uo=; b=T
	I1c/l507ni3zffdP7gE1+EaS+0S8sQHxwuBGSgsh0yoSTtUl+DLA0TkNSeJIAg4E
	XCVjjRQg9l7wDlm/SNQP0B+VuJoxbn/F1GIuXYZcbPvW7hODckssgvXUMabxTrXI
	ZOMx++OoKTtFK+V+rtFEDi/nrj1OfV0MY9gWm7YwDYQuYcDbTMJVwqI3aOjrZ6/q
	PVKwZBdKORXYeeEn+TUuHdfrNVTOzf7IDyGupOUaYfsi6/Wvuq1BbYwuXa1l5pWK
	bhccnshg7Li2klcQqi/Zda8yOM7xzY4qqIEO0QP9EfWDpaVrFEg8+/rw6Bq8lIUL
	W4+l1V0Zx2uN3IRXJC7oA==
X-ME-Sender: <xms:TJsIaGXeQfdG4sYwNR-wFkUhGgUQl_LyW7KYhUIA-GJYWCMv4Q8Ygg>
    <xme:TJsIaCmL7FfePcMimk-r5uxX4pJyfRkc1SwCtiMuE1tKtha8-Kr8FGFDcVq2ATwN8
    lxSTKj1KZEFtNI-5g>
X-ME-Received: <xmr:TJsIaKZu6sOZoRnyn4xx44xVOX_bmC8v6Nw-n96H__NKjnYcnJpc1Y9ygXsG9mKFiKIVBF9UMyv28xgTgGL5xbuTUeeGMDpBNQxEnUTXqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TJsIaNWsJURmDWGNq7OusCcXBrUEiy4ETt3OQ93ogFijuaKD3Xbu5Q>
    <xmx:TJsIaAm58SNPMcZNthZbLkissSftXp4ZZF6nUwIj-2v06J9GE3ioRQ>
    <xmx:TJsIaCd7XF3b25wR2D0OV9YINZuKt2lPNONMevEKoXsRMj1C6chiuA>
    <xmx:TJsIaCELl6Mdhmn8GWZxEbAEYlnewWT0ChwK9FIMeH9S7uMwn9jybg>
    <xmx:TZsIaNisg-YPBBBOQmW3RHb44w43g-VRGJN_w1-Ecu1VSepoBXMvw_Bx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae58f869 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:16 +0200
Subject: [PATCH 06/13] treewide: trivial conversions of
 `repo_has_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-6-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

As the comment of `repo_has_object_file()` and its `_with_flags()`
variant tells us, these functions are considered to be deprecated in
favor of `has_object()`. The benefit of the replacement is better
defaults: it doesn't fetch missing objects via promisor remotes, and
neither does it reload packfiles if an object wasn't found by default.

Start sunsetting the functions by replacing trivial callsites of it with
`has_object()`:

  - `repo_has_object_file(...)` is equivalent to
    `has_object(..., HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)`.

  - `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT)`
    is equivalent to `has_object(..., 0)`.

  - `repo_has_object_file_with_flags(..., OBJECT_INFO_SKIP_FETCH_OBJECT)`
    is equivalent to `has_object(..., HAS_OBJECT_RECHECK_PACKED)`.

While converting callsites to use `HAS_OBJECT_FETCH_PROMISOR` retains
the current behaviour, it is not entirely clear whether all of them
really should be fetching promised objects. A subset of such callsites
where it is obvious that they really shouldn't fetch objects has been
left out of this commit and will be adapted over the next couple of
commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c       |  3 ++-
 builtin/clone.c          |  4 +---
 builtin/fetch.c          | 15 +++++++--------
 builtin/receive-pack.c   |  4 +++-
 builtin/remote.c         |  3 ++-
 builtin/unpack-objects.c |  3 ++-
 cache-tree.c             | 13 +++++++++----
 fetch-pack.c             |  7 +++----
 http-push.c              | 11 +++++++----
 notes.c                  |  3 ++-
 object-store.c           |  2 +-
 reflog.c                 |  3 ++-
 remote.c                 |  2 +-
 send-pack.c              |  5 +----
 shallow.c                |  9 ++++++---
 upload-pack.c            |  3 +--
 walker.c                 |  3 ++-
 17 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0e3f10a9467..3914a2a3f61 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -169,7 +169,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		goto cleanup;
 
 	case 'e':
-		ret = !repo_has_object_file(the_repository, &oid);
+		ret = !has_object(the_repository, &oid,
+				  HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR);
 		goto cleanup;
 
 	case 'w':
diff --git a/builtin/clone.c b/builtin/clone.c
index 6b1d11a3ed2..b498b81a043 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -504,9 +504,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (ends_with(ref->name, "^{}"))
 			continue;
-		if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid,
-						     OBJECT_INFO_QUICK |
-						     OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!has_object(the_repository, &ref->old_oid, 0))
 			continue;
 		refs_update_ref(get_main_ref_store(the_repository), msg,
 				ref->name, &ref->old_oid, NULL, 0,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95589b49948..aadcf49a5b4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -337,7 +337,6 @@ static void find_non_local_tags(const struct ref *refs,
 	struct string_list_item *remote_ref_item;
 	const struct ref *ref;
 	struct refname_hash_entry *item = NULL;
-	const int quick_flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
 
 	refname_hash_init(&existing_refs);
 	refname_hash_init(&remote_refs);
@@ -367,9 +366,9 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !repo_has_object_file_with_flags(the_repository, &ref->old_oid, quick_flags) &&
+			    !has_object(the_repository, &ref->old_oid, 0) &&
 			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
-			    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
+			    !has_object(the_repository, &item->oid, 0) &&
 			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
@@ -383,7 +382,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
+		    !has_object(the_repository, &item->oid, 0) &&
 		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
@@ -404,7 +403,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
+	    !has_object(the_repository, &item->oid, 0) &&
 	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
@@ -911,7 +910,8 @@ static int update_local_ref(struct ref *ref,
 	struct commit *current = NULL, *updated;
 	int fast_forward = 0;
 
-	if (!repo_has_object_file(the_repository, &ref->new_oid))
+	if (!has_object(the_repository, &ref->new_oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
@@ -1330,8 +1330,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * we need all direct targets to exist.
 	 */
 	for (r = rm; r; r = r->next) {
-		if (!repo_has_object_file_with_flags(the_repository, &r->old_oid,
-						     OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!has_object(the_repository, &r->old_oid, HAS_OBJECT_RECHECK_PACKED))
 			return -1;
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e82..c92e57ba188 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1506,7 +1506,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 	}
 
-	if (!is_null_oid(new_oid) && !repo_has_object_file(the_repository, new_oid)) {
+	if (!is_null_oid(new_oid) &&
+	    !has_object(the_repository, new_oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", oid_to_hex(new_oid));
 		ret = "bad pack";
diff --git a/builtin/remote.c b/builtin/remote.c
index b4baa34e665..0d6755bcb71 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -454,7 +454,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 			info->status = PUSH_STATUS_UPTODATE;
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
-		else if (repo_has_object_file(the_repository, &ref->old_oid) &&
+		else if (has_object(the_repository, &ref->old_oid,
+				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
 			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 661be789f13..e905d5f4e19 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -449,7 +449,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		delta_data = get_data(delta_size);
 		if (!delta_data)
 			return;
-		if (repo_has_object_file(the_repository, &base_oid))
+		if (has_object(the_repository, &base_oid,
+			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
 					      delta_data, delta_size))
diff --git a/cache-tree.c b/cache-tree.c
index c0e1e9ee1d4..fa3858e2829 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -238,7 +238,9 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	int i;
 	if (!it)
 		return 0;
-	if (it->entry_count < 0 || !repo_has_object_file(the_repository, &it->oid))
+	if (it->entry_count < 0 ||
+	    has_object(the_repository, &it->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -289,7 +291,9 @@ static int update_one(struct cache_tree *it,
 		}
 	}
 
-	if (0 <= it->entry_count && repo_has_object_file(the_repository, &it->oid))
+	if (0 <= it->entry_count &&
+	    has_object(the_repository, &it->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return it->entry_count;
 
 	/*
@@ -395,7 +399,8 @@ static int update_one(struct cache_tree *it,
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
 			!must_check_existence(ce);
 		if (is_null_oid(oid) ||
-		    (!ce_missing_ok && !repo_has_object_file(the_repository, oid))) {
+		    (!ce_missing_ok && !has_object(the_repository, oid,
+						   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
@@ -443,7 +448,7 @@ static int update_one(struct cache_tree *it,
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &oid);
-		if (repo_has_object_file_with_flags(the_repository, &oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (has_object(the_repository, &oid, HAS_OBJECT_RECHECK_PACKED))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 210dc30d50f..fa4231fee74 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -769,9 +769,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (!commit) {
 			struct object *o;
 
-			if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid,
-							     OBJECT_INFO_QUICK |
-							     OBJECT_INFO_SKIP_FETCH_OBJECT))
+			if (!has_object(the_repository, &ref->old_oid, 0))
 				continue;
 			o = parse_object(the_repository, &ref->old_oid);
 			if (!o || o->type != OBJ_COMMIT)
@@ -1985,7 +1983,8 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
-			if (repo_has_object_file(the_repository, &oid[i]))
+			if (has_object(the_repository, &oid[i],
+				       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 				oid_array_append(&extra, &oid[i]);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
diff --git a/http-push.c b/http-push.c
index 32e37565f4e..f9e67cabd4b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1446,7 +1446,9 @@ static void one_remote_ref(const char *refname)
 	 * Fetch a copy of the object if it doesn't exist locally - it
 	 * may be required for updating server info later.
 	 */
-	if (repo->can_update_info_refs && !repo_has_object_file(the_repository, &ref->old_oid)) {
+	if (repo->can_update_info_refs &&
+	    !has_object(the_repository, &ref->old_oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		obj = lookup_unknown_object(the_repository, &ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
@@ -1651,14 +1653,14 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Remote HEAD symrefs too deep");
 		if (is_null_oid(&head_oid))
 			return error("Unable to resolve remote HEAD");
-		if (!repo_has_object_file(the_repository, &head_oid))
+		if (!has_object(the_repository, &head_oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", oid_to_hex(&head_oid));
 
 		/* Remote branch must resolve to a known object */
 		if (is_null_oid(&remote_ref->old_oid))
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
-		if (!repo_has_object_file(the_repository, &remote_ref->old_oid))
+		if (!has_object(the_repository, &remote_ref->old_oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
@@ -1879,7 +1881,8 @@ int cmd_main(int argc, const char **argv)
 		if (!force_all &&
 		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
-			if (!repo_has_object_file(the_repository, &ref->old_oid) ||
+			if (!has_object(the_repository, &ref->old_oid,
+					HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
 			    !ref_newer(&ref->peer_ref->new_oid,
 				       &ref->old_oid)) {
 				/*
diff --git a/notes.c b/notes.c
index d9645c4b5dc..0a128f1de98 100644
--- a/notes.c
+++ b/notes.c
@@ -794,7 +794,8 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	struct note_delete_list **l = (struct note_delete_list **) cb_data;
 	struct note_delete_list *n;
 
-	if (repo_has_object_file(the_repository, object_oid))
+	if (has_object(the_repository, object_oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
diff --git a/object-store.c b/object-store.c
index 0d873868a6d..2db34804e8f 100644
--- a/object-store.c
+++ b/object-store.c
@@ -847,7 +847,7 @@ int pretend_object_file(struct repository *repo,
 	char *co_buf;
 
 	hash_object_file(repo->hash_algo, buf, len, type, oid);
-	if (repo_has_object_file_with_flags(repo, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	if (has_object(repo, oid, 0) ||
 	    find_cached_object(repo->objects, oid))
 		return 0;
 
diff --git a/reflog.c b/reflog.c
index c6c534dfad4..2db1cc81d01 100644
--- a/reflog.c
+++ b/reflog.c
@@ -152,7 +152,8 @@ static int tree_is_complete(const struct object_id *oid)
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
-		if (!repo_has_object_file(the_repository, &entry.oid) ||
+		if (!has_object(the_repository, &entry.oid,
+				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
 		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
diff --git a/remote.c b/remote.c
index 9fa3614e7a3..4099183cacd 100644
--- a/remote.c
+++ b/remote.c
@@ -1702,7 +1702,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
+			else if (!has_object(the_repository, &ref->old_oid, HAS_OBJECT_RECHECK_PACKED))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
diff --git a/send-pack.c b/send-pack.c
index 5005689cb55..86592ce526d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -45,10 +45,7 @@ int option_parse_push_signed(const struct option *opt,
 static void feed_object(struct repository *r,
 			const struct object_id *oid, FILE *fh, int negative)
 {
-	if (negative &&
-	    !repo_has_object_file_with_flags(r, oid,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT |
-					     OBJECT_INFO_QUICK))
+	if (negative && !has_object(r, oid, 0))
 		return;
 
 	if (negative)
diff --git a/shallow.c b/shallow.c
index 2f82ebd6e3f..faeeeb45f98 100644
--- a/shallow.c
+++ b/shallow.c
@@ -310,7 +310,8 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & QUICK) {
-		if (!repo_has_object_file(the_repository, &graft->oid))
+		if (!has_object(the_repository, &graft->oid,
+				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return 0;
 	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
@@ -476,7 +477,8 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (size_t i = 0; i < sa->nr; i++) {
-		if (repo_has_object_file(the_repository, sa->oid + i)) {
+		if (has_object(the_repository, sa->oid + i,
+			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
 						    &sa->oid[i]);
@@ -513,7 +515,8 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		if (repo_has_object_file(the_repository, oid + info->theirs[i]))
+		if (has_object(the_repository, oid + info->theirs[i],
+			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			dst++;
 	}
 	info->nr_theirs = dst;
diff --git a/upload-pack.c b/upload-pack.c
index 30e4630f3a1..956da5b061a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -509,8 +509,7 @@ static int got_oid(struct upload_pack_data *data,
 {
 	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!repo_has_object_file_with_flags(the_repository, oid,
-					     OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
+	if (!has_object(the_repository, oid, 0))
 		return -1;
 	return do_got_oid(data, oid);
 }
diff --git a/walker.c b/walker.c
index 4fedc19f346..b470d43e54d 100644
--- a/walker.c
+++ b/walker.c
@@ -150,7 +150,8 @@ static int process(struct walker *walker, struct object *obj)
 		return 0;
 	obj->flags |= SEEN;
 
-	if (repo_has_object_file(the_repository, &obj->oid)) {
+	if (has_object(the_repository, &obj->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	}

-- 
2.49.0.901.g37484f566f.dirty

