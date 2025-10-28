Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDF3090C1
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649745; cv=none; b=ZJM7DVoPR/8Nr3ju1L932A0jZRURfwffTaCbDmv636OaYsx8hB4mFMUzmrzW+QWVuvyLNNe/ZMcU83ZCMnbmC3Lx2M7ZdBzAOMVMfo7+FZsA8FC21sbgtB+gNHC3VZqSxTFWabhZKhYPOeNrYQ4P+VSuevJTCIVo89BpDJUt5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649745; c=relaxed/simple;
	bh=U4Wfj+ycvl6SXLZ5u1F/biMm6worSB0uAYbhkthtqqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GENnwHUPa1dFgO4uJVM6DJBMy33mOPBePWNBWiDNTAXnE73Z2N7FgLcQDvAJ2zCN9ZBEp6kKSMbYlHdTviscyq7lIJhqvLloL/FOf7lp3o5DcYO5/8eWaQtKtQ0E/xYiyc9LIekopPOr3NkVsWFP9rOZLAWqjFtFMqxRZ10UKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QFyuW8Gd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwUmzUx2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QFyuW8Gd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwUmzUx2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAC141400361;
	Tue, 28 Oct 2025 07:09:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 28 Oct 2025 07:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761649742;
	 x=1761736142; bh=oK8zC+z4jdHr1aPfwC+GH0pOb10e0LMrxRIEOIx/4uM=; b=
	QFyuW8Gde5XVmjUKWEfPvRQntqPCXQgDZdVTNMBmlZkrEn0H6f7I6U72JAg9L4vO
	kyEbErQ/dL263I9eq0etw7z0QRL/PLeJPIf9Esc5UFaQ/pKAnpEkKDyX7HZu4/7r
	7K5gpW7gNgQ0IZD1tjt+//UYUBnAF6bxT24lsrScdmDkddR1P8OL28fIwyzk4cnY
	lyP+DyeW5i9e12ExIqJoqQwP3PVBodmX7VbhOIV9Q4I9U2cprYpMHlBPCEy4yDZG
	OnTTQs9+b9Q6QhTfWC62B7fwDAV2Ko0x4RkRfAl5kvSKZqtXxUvcO11YxSx8YDQt
	ddArwos7llzMoEh/ohFyAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761649742; x=
	1761736142; bh=oK8zC+z4jdHr1aPfwC+GH0pOb10e0LMrxRIEOIx/4uM=; b=O
	wUmzUx2p9prSofKgDAxKqVf3epCVmbVUsHdICVBqF3ciQTzzcTNMeYJLJqApW3IN
	Cp+G2piyzwrfXf5yvcjF7yw4U/mOJUWLMcbunVRoVIwMIXHr1sbBJSSf8yXv7U/I
	2kBwJqKyVk5iCAgPK3uNzzqOlM9VD9f8lf8lNdHWoFF+Trks/RItZpei/R6yMfzf
	VLPu0lt6Ustz8xtqeGNUwRQttOsU7zlRv0qa9nM95xwcMRJWzhC4HBwXg8P3ND8H
	nQSXMYlUMsCWXh0IZv/OwnCDJVjOLfxud00te0QtpjrI+JumwX/HHgmiivpSm7YW
	p0qgOqjKBLDc5c3leovDw==
X-ME-Sender: <xms:TqQAaQNp85xsKm4TjD6O8CL1nOxIxoPBH3qAAm35KbdmGYF-fmO7hQ>
    <xme:TqQAaeZfkp45aB3cA2PSPfe41X5_smFMYkNHjzI7r78PEzFd65aCN4kuCKfNEDMki
    D0gpLxXlcZHhD8O-EqAW--lzwzbA8eTCAjKMoIjnlR7qAZPnTL7>
X-ME-Received: <xmr:TqQAaUqBAReb0GfpatdQcYwDxt3dmFl87vjSAFgTZNYAot5scqSANS-1Ca5rRNyLIqY1Q8OYrynJ59-Gdq_kJ39ERTMSHVPExW_7pK6l7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:TqQAaSYMz2rYaMRWDqxVKniK5eFrd_2lDXJHuxOELenbrU5HanhDhQ>
    <xmx:TqQAacTLexB9vIC9xj0tu5Mw3Cb37JDPlmkpwfqtMBpDD_-9IQ-vkA>
    <xmx:TqQAaZ5bCRl4AqgqpJXGy-u2cgLJLHRRDGlfc0L-kTf9coHeboxIeg>
    <xmx:TqQAaRwAx_hu9A_Vvu8s45TRRA-vQ-s4FMMZ12Jm5K7-zdbx5a_t0w>
    <xmx:TqQAaUQO6SNwRHKLrhxJ6CZ9Y5gs0HhbC_lkigrMG4Rw81aJodNjuVER>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:09:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6927627 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:09:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Oct 2025 12:08:38 +0100
Subject: [PATCH 8/8] packfile: track packs via the MRU list exclusively
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-8-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We track packfiles via two different lists:

  - `struct packfile_store::packs` is a list that sorts local packs
    first. In addition, these packs are sorted so that younger packs are
    sorted towards the front.

  - `struct packfile_store::mru` is a list that sorts packs so that
    most-recently used packs are at the front.

The reasoning behind the ordering in the `packs` list is that younger
objects stored in the local object store tend to be accessed more
frequently, and that is certainly true for some cases. But there are
going to be lots of cases where that isn't true. Especially when
traversing history it is likely that one needs to access many older
objects, and due to our housekeeping it is very likely that almost all
of those older objects will be contained in one large pack that is
oldest.

So whether or not the ordering makes sense really depends on the use
case at hand. A flexible approach like our MRU list addresses that need,
as it will sort packs towards the front that are accessed all the time.
Intuitively, this approach is thus able to satisfy more use cases more
efficiently.

This reasoning casts some doubt on whether or not it really makes sense
to track packs via two different lists. It causes confusion, and it is
not clear whether there are use cases where the `packs` list really is
such an obvious choice.

Merge these two lists into one most-recently-used list.

Note that there is one important edge case: `for_each_packed_object()`
uses the MRU list to iterate through packs, and then it lists each
object in those packs. This would have the effect that we now sort the
current pack towards the front, thus modifying the list of packfiles we
are iterating over, with the consequence that we'll see an infinite
loop. This edge case is worked around by introducing a new field that
allows us to skip updating the MRU.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  4 ++--
 packfile.c             | 27 +++++++--------------------
 packfile.h             | 27 +++++++++++++++++----------
 3 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 861fef3f38a..3b73ab9f614 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1748,11 +1748,11 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	for (e = the_repository->objects->packfiles->mru.head; e; e = e->next) {
+	for (e = the_repository->objects->packfiles->packs.head; e; e = e->next) {
 		struct packed_git *p = e->pack;
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
-			packfile_list_prepend(&the_repository->objects->packfiles->mru, p);
+			packfile_list_prepend(&the_repository->objects->packfiles->packs, p);
 		if (want != -1)
 			return want;
 	}
diff --git a/packfile.c b/packfile.c
index 79d2b27c42c..8785e397104 100644
--- a/packfile.c
+++ b/packfile.c
@@ -870,9 +870,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	packfile_list_prepend(&store->packs, pack);
-	packfile_list_append(&store->mru, pack);
-
+	packfile_list_append(&store->packs, pack);
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
@@ -1077,14 +1075,6 @@ static int sort_pack(const struct packfile_list_entry *a,
 	return -1;
 }
 
-static void packfile_store_prepare_mru(struct packfile_store *store)
-{
-	packfile_list_clear(&store->mru);
-
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
-		packfile_list_append(&store->mru, e->pack);
-}
-
 void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
@@ -1103,7 +1093,6 @@ void packfile_store_prepare(struct packfile_store *store)
 		if (!e->next)
 			store->packs.tail = e;
 
-	packfile_store_prepare_mru(store);
 	store->initialized = true;
 }
 
@@ -1128,12 +1117,6 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 	return store->packs.head;
 }
 
-struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store)
-{
-	packfile_store_prepare(store);
-	return store->mru.head;
-}
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -2134,11 +2117,12 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	if (!r->objects->packfiles->packs.head)
 		return 0;
 
-	for (l = r->objects->packfiles->mru.head; l; l = l->next) {
+	for (l = r->objects->packfiles->packs.head; l; l = l->next) {
 		struct packed_git *p = l->pack;
 
 		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			packfile_list_prepend(&r->objects->packfiles->mru, p);
+			if (!r->objects->packfiles->skip_mru_updates)
+				packfile_list_prepend(&r->objects->packfiles->packs, p);
 			return 1;
 		}
 	}
@@ -2270,6 +2254,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
+	repo->objects->packfiles->skip_mru_updates = true;
 	repo_for_each_pack(repo, p) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
@@ -2290,6 +2275,8 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 		if (r)
 			break;
 	}
+	repo->objects->packfiles->skip_mru_updates = false;
+
 	return r ? r : pack_errors;
 }
 
diff --git a/packfile.h b/packfile.h
index d95275e666c..27ba607e7c5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -79,8 +79,8 @@ struct packfile_store {
 	struct object_database *odb;
 
 	/*
-	 * The list of packfiles in the order in which they are being added to
-	 * the store.
+	 * The list of packfiles in the order in which they have been most
+	 * recently used.
 	 */
 	struct packfile_list packs;
 
@@ -98,9 +98,6 @@ struct packfile_store {
 		unsigned flags;
 	} kept_cache;
 
-	/* A most-recently-used ordered version of the packs list. */
-	struct packfile_list mru;
-
 	/*
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.
@@ -112,6 +109,21 @@ struct packfile_store {
 	 * packs.
 	 */
 	bool initialized;
+
+	/*
+	 * Usually, packfiles will be reordered to the front of the `packs`
+	 * list whenever an object is looked up via them. This has the effect
+	 * that packs that contain a lot of accessed objects will be located
+	 * towards the front.
+	 *
+	 * This is usually desireable, but there are exceptions. One exception
+	 * is when the looking up multiple objects in a loop for each packfile.
+	 * In that case, we may easily end up with an infinite loop as the
+	 * packfiles get reordered to the front repeatedly.
+	 *
+	 * Setting this field to `true` thus disables these reorderings.
+	 */
+	bool skip_mru_updates;
 };
 
 /*
@@ -171,11 +183,6 @@ void packfile_store_add_pack(struct packfile_store *store,
  */
 struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
 
-/*
- * Get all packs in most-recently-used order.
- */
-struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store);
-
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a

-- 
2.51.2.997.g839fc31de9.dirty

