Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABE36B05C
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986849; cv=none; b=QxqDtVPTPn7rybGsElIB7BogzjX1bLsN08TGyErkq9MNwimsr5Tmmm3Tm9gyaNdPWU2UWiK3yLc+avpoBiZdVBaT4tkPTOc993rFwNW+LNR0B9IC41sTcvEN98QSbgqFc+7EtjPl8RIbZz5Zd87rI7sjjfLpijPP8PS9oepxTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986849; c=relaxed/simple;
	bh=Ctlfv42v6OSpdBt/qo3r7aJhW0Q/Inc76Pw7mEYYG0M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pGkLLJz4piRMrw6XWh1A/tJ1px0RvZP74SZyrpcgGxO+DvJLRXGegfnq5aQFZeypvQyU9hrOhifVMSoLQjoA0PUXfbOd7U6vQUeCoK+WSeeB06aFP9YRqCWB1Q+yll1sBxxbb4Dla/BW0KLj9GmJukOhrv+uXnAv4IV5TaCod/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXsu/3Tx; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXsu/3Tx"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4e1568932so2101470a34.2
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787986845; x=1788591645; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dX1YbqWc+70j8SZa/5tzr7AmyOjHvlb91fOxo+GLkbY=;
        b=jXsu/3Txzed8b3ViSJ8oUMngfy97nTmugfNqcbkoCclrQls4G8J+m409hv7nVGCqvS
         PNAXg8JNxJfoO7+5nHJgGjvj9zmMTS+5MY8ml5hk8+QU0MSI7gBso0vCNnT4Qc5nugyI
         6FW2dKZnDmva7WFxF2dpYAIa436p1p00bgWzVcryy87NtyeGRy6mfuwtcE1pzbi1xLrv
         UNfEvpXa31ja780bGh/z+K0BQEmgyXYbTVhKzvt/4YYnu5sDl/bzy1aWFMpUMr24FWSL
         sJ0ITG3gfSDFESEqfFpIIR0letpt+/tMoEohTbrDoKnFNi7a2rIf0lW2ru6WmiqIrr8E
         VJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787986845; x=1788591645;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dX1YbqWc+70j8SZa/5tzr7AmyOjHvlb91fOxo+GLkbY=;
        b=d49OLqfWwl4WMyWdgu59YVdq/FmGS4VS8gm04KsQQJnQ8cKOUFPYGiTL+g4F6dOibI
         PJ1yhz5qHivh9fcdW9Iv3sg4ujd6qvUr7Wvm/gKo1m95BTvnhxazMY7WcjXW6Q3zCYgP
         iEqWmgJwLZtahA74lsF4LtXGx9DGSGJ+Gkgas/9YjR31uqx0mTgAiGSy7+F0ex4zpTwj
         /oi+h7W9C5vFWCKz8H6YkwjKKYLV0mEd8ZCWvA2uTZ8hmG1IWROiqKaJ9XAORmuP7NJN
         gd9MKmcq0Agp0ITGLXmY6QLn+yUoGZvxPI4wzkfUgss9UFc/rTIp4MDzhQBNHBzPJC+6
         ZxOQ==
X-Gm-Message-State: AFuF++kMAfDNLLMpGpheeohPtd1CLFxPuJ5wHFqRbRNgCkemSXKkUjwp
	vJMxZOrphPry3QgSUzIt5r6B4fFSJfmK44/sDd60fcZCWc+XRTr6GUx3/d7YqY16
X-Gm-Gg: AR+sD11Sz8BDmb/9heyrGlj2IoK6Jy0HJXjlJ5yjN7wPPQCWHK+uk1H1c3t/WjPtnZ9
	GFYDw3Orh7fUPE6rtfU/hutlep7bXVGYNHwt97BXUyvnD8uUZfhLhxat4BH0GPrN61Cw4C1hl4t
	ZzBcqPNXXqM3QuIn2KAJE0xinxUdNI0OSj9AaLY2yh688Q7sod4DYxCObqhTv1ywbxGwpXz/KQO
	VMlkC42ayKHtkc8KFNNLtLmw5wagn8s3xyZwuaMy+3etgRqzW9nUm8dDRt2a+lyQ9oWYAHpX+uh
	llfpKi6QRNuwC/KCBUVPaoaNydAdaPK1550N5oVr+nXI+jOvzNp9h99PVm2NmpKknZIdApTAof9
	tidfObMA7ghDvD8G7bOyBXN4essDAu8E4TJhr2PEkBZdLYLbhMMZfqadKFr6atJtivHwlYgYfjV
	RYlYgk+6n6x1tUld2ixkhrhlk5BG7KOWqfaYHU8jq2w7Ed7d0KiAOtRzECqKq9QaOuWumU/gvb
X-Received: by 2002:a05:6820:a58e:b0:6b1:51fa:3562 with SMTP id 006d021491bc7-6b1c67a0d39mr9560138eaf.34.1787986844527;
        Sat, 29 Aug 2026 00:00:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.5.228])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce3c487fsm3799809eaf.15.2026.08.29.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:00:43 -0700 (PDT)
Message-Id: <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Aug 2026 07:00:31 +0000
Subject: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

A geometric repack writes a new pack and multi-pack-index and then
deletes the packs the new one subsumes.  A process still using the
previous MIDX keeps seeing a removed pack listed as the owner of some
objects.  Since a MIDX attributes each object to exactly one pack, such
an object is served only through its recorded owner; if that owner was
just removed, find_pack_entry() cannot serve it -- the MIDX lookup routes
to the missing pack, and the regular pack fallback deliberately skips
every MIDX-covered pack, so a surviving copy in another covered pack
(e.g. a kept base pack) is never consulted.

Unlike the ordinary "a pack's .idx is mapped but its .pack is gone"
race, the second read does not rescue us.  Reloading the on-disk pack set
does not reload the borrowed, cached MIDX (freeing it under the code that
caches the "struct multi_pack_index *" would be a use-after-free), so the
stale MIDX keeps routing to the removed pack and the surviving copy stays
hidden behind the covered-pack skip.  cat-file, rev-list and pack-objects
can thus all spuriously fail with "unable to read object".

Teach find_pack_entry() to recover.  The MIDX lookup now returns a
tri-state, distinguishing an object absent from the MIDX from one it owns
via a pack that can no longer be opened; in the latter case, once the
regular fallback has also missed, scan the MIDX's packs directly for a
surviving copy.  Because the return value is no longer a boolean, rename
fill_midx_entry() to midx_fill_entry() so callers must reckon with the
new enum rather than silently treat MIDX_FILL_OWNER_UNAVAILABLE as a hit.

Do the scan only on the second read (OBJECT_INFO_SECOND_READ): by then
the cheaper on-disk reload has run, so an object merely relocated into a
new (uncovered) pack has already been found by the regular fallback, and
only a genuine hidden duplicate reaches the rescan.  A QUICK caller that
skips the second read simply accepts the false negative, as QUICK is
designed to.

Reloading the stale MIDX would be a more complete fix but is much more
involved (the borrowers above need proper invalidation), so leave that
for later.

Assisted-by: Claude Opus 4.8 & GPT-5.6 Sol
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pack-objects.c      |  2 +-
 midx.c                      | 20 +++++++++---------
 midx.h                      | 21 +++++++++++++++++--
 odb/source-packed.c         | 42 ++++++++++++++++++++++++++++++++-----
 t/helper/test-read-midx.c   |  2 +-
 t/t5319-multi-pack-index.sh | 40 +++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 399acd0f22..751d5d3449 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1786,7 +1786,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
 		struct pack_entry e;
 
-		if (m && fill_midx_entry(m, oid, &e, NULL)) {
+		if (m && midx_fill_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/midx.c b/midx.c
index 37f082dbdd..6d1c548e3d 100644
--- a/midx.c
+++ b/midx.c
@@ -589,23 +589,23 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
-int fill_midx_entry(struct multi_pack_index *m,
-		    const struct object_id *oid,
-		    struct pack_entry *e,
-		    struct packed_git **bad_pack)
+enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
+				      const struct object_id *oid,
+				      struct pack_entry *e,
+				      struct packed_git **bad_pack)
 {
 	uint32_t pos;
 	uint32_t pack_int_id;
 	struct packed_git *p;
 
 	if (!bsearch_midx(oid, m, &pos))
-		return 0;
+		return MIDX_FILL_MISS;
 
 	midx_for_object(&m, pos);
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
 	if (prepare_midx_pack(m, pack_int_id))
-		return 0;
+		return MIDX_FILL_OWNER_UNAVAILABLE;
 	p = m->packs[pack_int_id - m->num_packs_in_base];
 
 	/*
@@ -616,19 +616,19 @@ int fill_midx_entry(struct multi_pack_index *m,
 	* loaded!
 	*/
 	if (!is_pack_valid(p))
-		return 0;
+		return MIDX_FILL_OWNER_UNAVAILABLE;
 
 	if (oidset_size(&p->bad_objects) &&
 	    oidset_contains(&p->bad_objects, oid)) {
 		if (bad_pack && !*bad_pack)
 			*bad_pack = p;
-		return 0;
+		return MIDX_FILL_MISS;
 	}
 
 	e->offset = nth_midxed_offset(m, pos);
 	e->p = p;
 
-	return 1;
+	return MIDX_FILL_HIT;
 }
 
 /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
@@ -1032,7 +1032,7 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
 
-		if (!fill_midx_entry(m, &oid, &e, NULL)) {
+		if (midx_fill_entry(m, &oid, &e, NULL) != MIDX_FILL_HIT) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
 				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
diff --git a/midx.h b/midx.h
index 1f2f2d5321..4b768769b9 100644
--- a/midx.h
+++ b/midx.h
@@ -117,8 +117,25 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
-int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid,
-		    struct pack_entry *e, struct packed_git **bad_pack);
+/*
+ * Result of looking an object up in a multi-pack-index.  MIDX_FILL_HIT means
+ * "e was filled in"; the two miss variants distinguish an object the midx does
+ * not know about (MIDX_FILL_MISS) from one it does know about but whose owning
+ * pack we can no longer open (MIDX_FILL_OWNER_UNAVAILABLE -- the signature of a
+ * concurrent repack having removed that pack).  A known-bad (corrupt) object
+ * reports MIDX_FILL_MISS but also sets *bad_pack, if provided, to the owning
+ * pack so the caller can tell "corrupt" apart from "absent".
+ */
+enum midx_fill_result {
+	MIDX_FILL_MISS = 0,
+	MIDX_FILL_HIT,
+	MIDX_FILL_OWNER_UNAVAILABLE,
+};
+
+enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
+				      const struct object_id *oid,
+				      struct pack_entry *e,
+				      struct packed_git **bad_pack);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_layer_contains_pack(struct multi_pack_index *m,
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1a12a605db..90d88c0a12 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -17,13 +17,18 @@
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
 			   struct pack_entry *e,
+			   enum object_info_flags flags,
 			   struct packed_git **bad_pack)
 {
 	struct packfile_list_entry *l;
+	enum midx_fill_result midx_result = MIDX_FILL_MISS;
 
 	odb_source_prepare(&store->base, 0);
-	if (store->midx && fill_midx_entry(store->midx, oid, e, bad_pack))
-		return 1;
+	if (store->midx) {
+		midx_result = midx_fill_entry(store->midx, oid, e, bad_pack);
+		if (midx_result == MIDX_FILL_HIT)
+			return 1;
+	}
 
 	for (l = store->packs.head; l; l = l->next) {
 		struct packed_git *p = l->pack;
@@ -35,6 +40,33 @@ static int find_pack_entry(struct odb_source_packed *store,
 		}
 	}
 
+	/*
+	 * Recovery for a concurrent-repack race: a stale MIDX may still name a
+	 * vanished owning pack even though the object survives in another pack
+	 * the same MIDX covers.  The regular fallback above skips MIDX-covered
+	 * packs, and repreparing the on-disk pack set does not reload the
+	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
+	 *
+	 * Do this only on the second read, by which point repreparing packs has
+	 * already had a chance to find an object merely relocated into a new,
+	 * uncovered pack; only a genuine hidden duplicate reaches here.
+	 */
+	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
+	    (flags & OBJECT_INFO_SECOND_READ)) {
+		struct multi_pack_index *m = store->midx;
+		uint32_t i;
+
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
+			struct packed_git *p;
+
+			if (prepare_midx_pack(m, i))
+				continue;
+			p = nth_midxed_pack(m, i);
+			if (p && packfile_fill_entry(p, oid, e, bad_pack))
+				return 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -57,7 +89,7 @@ static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
 	if (flags & OBJECT_INFO_SECOND_READ)
 		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
 
-	if (!find_pack_entry(packed, oid, &e, &bad_pack)) {
+	if (!find_pack_entry(packed, oid, &e, flags, &bad_pack)) {
 		/*
 		 * The lookup may have failed because the object is known to be
 		 * corrupt in one of the packfiles. Report the object as
@@ -105,7 +137,7 @@ static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 	struct pack_entry e;
 
-	if (!find_pack_entry(packed, oid, &e, NULL))
+	if (!find_pack_entry(packed, oid, &e, 0, NULL))
 		return -1;
 
 	return packfile_read_object_stream(out, oid, e.p, e.offset);
@@ -611,7 +643,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 		timesp = &times;
 	}
 
-	if (!find_pack_entry(packed, oid, &e, NULL))
+	if (!find_pack_entry(packed, oid, &e, 0, NULL))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 27a05da957..9c5e308761 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -82,7 +82,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		for (i = 0; i < m->num_objects; i++) {
 			nth_midxed_object_oid(&oid, m,
 					      i + m->num_objects_in_base);
-			fill_midx_entry(m, &oid, &e, NULL);
+			midx_fill_entry(m, &oid, &e, NULL);
 
 			printf("%s %"PRIu64"\t%s\n",
 			       oid_to_hex(&oid), e.offset, e.p->pack_name);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..2b8ff6f3ed 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1393,4 +1393,44 @@ test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
 	)
 '
 
+test_expect_success 'lookup recovers object whose midx-owning pack was removed' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# "keep" ends up only in the big pack; "dup" is deliberately
+		# placed in two packs so the midx has to choose an owner.
+		test_commit keep &&
+		echo duplicated-content >dup &&
+		git add dup &&
+		git commit -m dup &&
+		dup_oid=$(git rev-parse HEAD:dup) &&
+
+		# Roll every object, including dup, into a single big pack.
+		git repack -adq &&
+
+		# Build a second, "moderate" pack that also contains dup, so dup
+		# now lives in two packs that the midx will cover.
+		moderate=$(echo "$dup_oid" |
+			git pack-objects --quiet $objdir/pack/pack) &&
+
+		# Attribute dup to the moderate pack in the midx.
+		git multi-pack-index write \
+			--preferred-pack="pack-$moderate.idx" &&
+
+		# Simulate a concurrent "git repack" retiring the moderate pack:
+		# its files disappear, but the now-stale midx still names it as
+		# the owner of dup.  A valid copy of dup survives in the big pack.
+		rm -f $objdir/pack/pack-$moderate.* &&
+
+		# The midx routes the lookup to the deleted pack, and the regular
+		# pack fallback skips midx-covered packs, so without recovery dup
+		# would appear missing even though it is physically present.
+		echo blob >expect &&
+		git cat-file -t "$dup_oid" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget
