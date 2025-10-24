Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1230DEDC
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299786; cv=none; b=VwdX3P4UBeoESTw/kQeb2tnPwwHCF8+5KjrGag38hFrOn40GBX/inorGjcXRrZrcw6nUMsfQyIkgeLHye8i7wDjDb5W7i0F5DZGJFvs0KtYZlGArJL5gW2fRTd1YSN9ZgQrpXfzBxbYBvZNSCl3RxZdnkAwaLAGQ0zbaiTO5HIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299786; c=relaxed/simple;
	bh=WoyiOhfCHuwfaZzWFx+Lopk13qG4cL7Q4kaYE++GwiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmYhR7HUcZX5D3L6D+X7IWYQlVIAsIC0AyRqMKCtx3xJ6/wBsAViDd4GvdKHTyEJlRTqV8awf8r28Mz21B9AKoqr3L7DNX2hvFvWYhIYwo96I2bCuvpCNwDgZrpLWbYiRILRSDpAw75Hj83tv7LdO9/9xpxjrxlEtBkZd65rhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZBcAfY/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8pajkLB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZBcAfY/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8pajkLB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA804140016D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 05:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299783;
	 x=1761386183; bh=e3jMuf7DNHL+mr43KcTi4OH13do8S4+esnGP1A8upTU=; b=
	ZBcAfY/g9YpnnbC7eTGLgKYmP+R6QrKcIOT1lJeF8cvOQc3vOILKRoalm5Hq+orW
	LvSnuUSijVQtHfsWOdlYd52LbU3IXSAkEFPwqCFdweN71e+UeNYZIi7a1eCexQlN
	MiDvo5PM3MCQUtXffLMBrDwB/YOlmMIHdzmpdzfsTkXOwaz8ZttR/W5lYIz6kLD7
	vMY7heWKflZb7megEwriG7eGwZt0+UG+YV4Ny/JI99Uj/SJzTUShExDmI0kzMyOO
	ArlTHXGWfZ2HCu9OwGG/NuypHFcENEAvHUhtmBzepMtCjiuflkbcBB/Q21Qv+BIW
	pdhBb8KRFICw0K8V9oCr9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299783; x=
	1761386183; bh=e3jMuf7DNHL+mr43KcTi4OH13do8S4+esnGP1A8upTU=; b=K
	8pajkLBFVxBC+PHN4UYvik1NBktGU5bMvRxb0pasN/Mpl0SD5dfQZus4brCh7Nqb
	pb5gABMw1V1yF4Ro83t9MbHm6ergqmcfwYfqIt4N6xSH73RzAnb0g3WCg4+++eOc
	iks9mabaWtjziAVdmgMW5abi1BPw/DdVDM+K25Sf6X6nC0q5hx950Kgcysp4FMku
	qXhDyMHHAkwPp/nAWlYZ7EuoZvhdlAXinnuOgbCERwDz9VUn5elT11stGkxDZmXI
	Fukyw5hnhVr0Td9WQJP0h4ytlm61p4VSldqWRY63AJCevR4sAMeJeo+p6KtcN5/y
	9P/oSNSMpPwGF7MPh/Ndg==
X-ME-Sender: <xms:R037aP-nhAkovPV_1K5pdKCKuktAujJgu4tmXlw_Jrs16vonpLWDww>
    <xme:R037aCq2HuToUXsmht1ECP8oWDTGw9bhcJVKRRa_mloyWF1L3jjIZBcH6Z7Kq61Uu
    qE5q1OCt4-KnHP8WdPxOof9piJ9l37byNfK-0X0BLZe0b-TRPwcoA>
X-ME-Received: <xmr:R037aCq3l48T3fF9138KD6tf8su04lLQuRR7N1IrXPUhTZzeTpPASlx08oxbUEIro94B2_2QQLISlfkaAn4cEJn6zNrGQpoFS6HkO7kGCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:R037aAk6ViGU-wdwM3fiymuuqYC1FoWIWD8RACGE-GPxSAN75w5e_Q>
    <xmx:R037aEHBS5lY9WQo1fRTLQ-CEsAYHfjoHotAVpeJEvsa0dUIoiR7lA>
    <xmx:R037aJqbeJwESW7oLTWewAcTjzu5jUTRFUAucMkuSeEOdKkDBg6SLg>
    <xmx:R037aA6mHQgxJGV7QuAEQECeaLNiVC1nzbz18zPY8uPjvhX80H9MkA>
    <xmx:R037aLsdYTEA27LFDX6e8_aCAO4niIZ29UJBoHpQuEqhKvwvSUAtDx67>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b13347eb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:05 +0200
Subject: [PATCH 06/13] object-file: move loose object cache into loose
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-6-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Our loose objects use a cache that (optionally) stores all objects for
each of the opened sharding directories. This cache is located in the
`struct odb_source`, but now that we have `struct odb_loose_source` it
makes sense to move it into the latter structure so that all state that
relates to loose objects is entirely self-contained.

Do so. While at it, rename corresponding functions to have a prefix that
relates to `struct odb_loose_source`.

Note that despite this prefix, the functions still accept a `struct
odb_source` as input. This is done intentionally: once we introduce
pluggable object databases, we will continue to accept this struct but
then do a cast inside these functions to `struct odb_loose_source`. This
design is similar to how we do it for our ref backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c       |  9 +++++----
 object-file.c | 35 +++++++++++++++++++----------------
 object-file.h | 16 ++++++++++++++--
 object-name.c |  2 +-
 odb.c         |  1 -
 odb.h         | 12 ------------
 6 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/loose.c b/loose.c
index e8ea6e7e24b..8cc7573ff2b 100644
--- a/loose.c
+++ b/loose.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "hash.h"
 #include "path.h"
+#include "object-file.h"
 #include "odb.h"
 #include "hex.h"
 #include "repository.h"
@@ -54,7 +55,7 @@ static int insert_loose_map(struct odb_source *source,
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(source->loose_objects_cache, compat_oid);
+		oidtree_insert(source->loose->cache, compat_oid);
 
 	return inserted;
 }
@@ -66,9 +67,9 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source
 
 	if (!source->loose_map)
 		loose_object_map_init(&source->loose_map);
-	if (!source->loose_objects_cache) {
-		ALLOC_ARRAY(source->loose_objects_cache, 1);
-		oidtree_init(source->loose_objects_cache);
+	if (!source->loose->cache) {
+		ALLOC_ARRAY(source->loose->cache, 1);
+		oidtree_init(source->loose->cache);
 	}
 
 	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
diff --git a/object-file.c b/object-file.c
index 38e09262e42..d7c6b1316cc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -223,7 +223,7 @@ static int quick_has_loose(struct repository *r,
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		if (oidtree_contains(odb_loose_cache(source, oid), oid))
+		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -1802,44 +1802,44 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_loose_cache(struct odb_source *source,
-				const struct object_id *oid)
+struct oidtree *odb_loose_source_cache(struct odb_source *source,
+				       const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(source->loose_objects_subdir_seen[0]);
+	size_t word_bits = bitsizeof(source->loose->subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
 	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    (size_t) subdir_nr >= bitsizeof(source->loose_objects_subdir_seen))
+	    (size_t) subdir_nr >= bitsizeof(source->loose->subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &source->loose_objects_subdir_seen[word_index];
+	bitmap = &source->loose->subdir_seen[word_index];
 	if (*bitmap & mask)
-		return source->loose_objects_cache;
-	if (!source->loose_objects_cache) {
-		ALLOC_ARRAY(source->loose_objects_cache, 1);
-		oidtree_init(source->loose_objects_cache);
+		return source->loose->cache;
+	if (!source->loose->cache) {
+		ALLOC_ARRAY(source->loose->cache, 1);
+		oidtree_init(source->loose->cache);
 	}
 	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    source->odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,
-				    source->loose_objects_cache);
+				    source->loose->cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return source->loose_objects_cache;
+	return source->loose->cache;
 }
 
 void odb_clear_loose_cache(struct odb_source *source)
 {
-	oidtree_clear(source->loose_objects_cache);
-	FREE_AND_NULL(source->loose_objects_cache);
-	memset(&source->loose_objects_subdir_seen, 0,
-	       sizeof(source->loose_objects_subdir_seen));
+	oidtree_clear(source->loose->cache);
+	FREE_AND_NULL(source->loose->cache);
+	memset(&source->loose->subdir_seen, 0,
+	       sizeof(source->loose->subdir_seen));
 }
 
 static int check_stream_oid(git_zstream *stream,
@@ -2006,5 +2006,8 @@ struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
 
 void odb_loose_source_free(struct odb_loose_source *source)
 {
+	if (!source)
+		return;
+	odb_clear_loose_cache(source->source);
 	free(source);
 }
diff --git a/object-file.h b/object-file.h
index aa84fc2a752..9ecb26a4b35 100644
--- a/object-file.h
+++ b/object-file.h
@@ -20,6 +20,18 @@ struct odb_source;
 
 struct odb_loose_source {
 	struct odb_source *source;
+
+	/*
+	 * Used to store the results of readdir(3) calls when we are OK
+	 * sacrificing accuracy due to races for speed. That includes
+	 * object existence with OBJECT_INFO_QUICK, as well as
+	 * our search for unique abbreviated hashes. Don't use it for tasks
+	 * requiring greater accuracy!
+	 *
+	 * Be sure to call odb_load_loose_cache() before using.
+	 */
+	uint32_t subdir_seen[8]; /* 256 bits */
+	struct oidtree *cache;
 };
 
 struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
@@ -29,8 +41,8 @@ void odb_loose_source_free(struct odb_loose_source *source);
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oidtree *odb_loose_cache(struct odb_source *source,
-				const struct object_id *oid);
+struct oidtree *odb_loose_source_cache(struct odb_source *source,
+				       const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct odb_source *source);
diff --git a/object-name.c b/object-name.c
index f6902e140dd..77e33e693aa 100644
--- a/object-name.c
+++ b/object-name.c
@@ -116,7 +116,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	struct odb_source *source;
 
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_loose_cache(source, &ds->bin_pfx),
+		oidtree_each(odb_loose_source_cache(source, &ds->bin_pfx),
 				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
diff --git a/odb.c b/odb.c
index f1b250ceffe..5a5e770dcd0 100644
--- a/odb.c
+++ b/odb.c
@@ -370,7 +370,6 @@ static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_loose_source_free(source->loose);
-	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
 	free(source);
 }
diff --git a/odb.h b/odb.h
index f7e1bf87803..ad57193c66a 100644
--- a/odb.h
+++ b/odb.h
@@ -51,18 +51,6 @@ struct odb_source {
 	/* Private state for loose objects. */
 	struct odb_loose_source *loose;
 
-	/*
-	 * Used to store the results of readdir(3) calls when we are OK
-	 * sacrificing accuracy due to races for speed. That includes
-	 * object existence with OBJECT_INFO_QUICK, as well as
-	 * our search for unique abbreviated hashes. Don't use it for tasks
-	 * requiring greater accuracy!
-	 *
-	 * Be sure to call odb_load_loose_cache() before using.
-	 */
-	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
-	struct oidtree *loose_objects_cache;
-
 	/* Map between object IDs for loose objects. */
 	struct loose_object_map *loose_map;
 

-- 
2.51.1.930.gacf6e81ea2.dirty

