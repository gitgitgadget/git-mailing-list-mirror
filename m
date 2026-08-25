Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAC3CA49A
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684462; cv=none; b=B1WKJa6yhHULZX/b9VehVXJT8aCFSIkKYUrwhZqHd/IDOpG8PjgVqMTTaaXLVXorvs7AQKwtjTd0GQir4ZnSbzcuqoAjc2EHWGpeipv0GYD1faWo7nZAJAqT0crkZwaAlXchuhyKdHVuxC9H+ugbCXEnS1v4yiPlET8fAPg/lPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684462; c=relaxed/simple;
	bh=MyAd0kuYtCEyVifeZq5LrSLdUSRXPdPP2Lzsb/l9Ey0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MNg1a+r1j8frDkX3jh9YqGnQUa6F3X//ot1ny5GpZ0RUND45icjqWfjj0F8qpLDvTIAmx7uglYRSB+jVDuqreQcM29HZIvqdmduCHx34GAgk0G8T20E9cw9r/oLay5hMTZ9/Y+JDTNCXukTEZ7/JxywJs/GYjyut/5/Q5Lvn5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNWpsj8r; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNWpsj8r"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93695893ac1so4867285a.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684441; x=1788289241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vk31NgWsDnwCeQmS9ug0Wm4hyB3S55TPl4W5MqdIcbQ=;
        b=lNWpsj8rjSbINoV1wj2tTAAKQ/sHwOkpZ5NzXgfj+WTudLyRdRpV6+7VNa5DvlIDUB
         AszPjbajWn02X/oOhx13haCtBwsQMmW8SUnr4wjCBpvgU0517gL79hMYsdwzacmZd4xw
         VE7UoqRxODHdKX1gfjqrnop7IG8E0p0P4m2DFPZd1lCygXzzBEGWsAcH+A4MbiwYOJH2
         QfqroBbK3oWtnUqBbSybTNY55QnRYaGFxPGMJH1gjYFTMt+Ecr3VKpcXz7EuUf0IkIkY
         ZA2qLUqaj1bECXoYDPnARKujve7NLC0EMfGvdwjSwDcDCaB95tNM7I2IrRAfr33Q63TM
         mL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684441; x=1788289241;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vk31NgWsDnwCeQmS9ug0Wm4hyB3S55TPl4W5MqdIcbQ=;
        b=NRNUjZ20lV6ROlZ+t2ojiXfVZRaSFRgDuS30hyYj6Kl82jx4p3bdDRs5EUPlm80xRG
         gFP2qmZq1bJcIZpMftGn/uCApN40IoaJ+wCaN3c2o5AU6s9kFKChkjfDL2laEcbT6xPG
         aWNXvL/MiKlVJn+R2EBfxqPxRNyP+zPlSMEWcfZakV5rd0Ggofd0N00/BUTzCuFxH94x
         fFrs5pv6OIzKopXRcqgNMCkgExn1WI72s9tGBMoNFIzZn52sQs9JkipXY73o+Q2Vh7/x
         CKT1u40oAh7g4V0Ec+LZge6Y4/qHJ4MYa2AuHNVCuVKVt9JG9aBB6515chvy61dMj33Q
         CKVg==
X-Gm-Message-State: AFuF++lUuxvMhuyTHVa9f274iZtN9jEVVd/jrzYM1a/bbHWpLEtsSKNp
	Kh5I5N/TNJgW5BijdJEY3MtR+Pa55kAV2xLMyFUQvonjMiQeuhLJySl0Dw70s3CN
X-Gm-Gg: AR+sD12Qnvy8f9TRUxouJQS6oqcRNGYciPUCWkzJod1+pUKtMS4LFdZJKWLV2CF3TB1
	zhZbyzr66iR9ZFrAM3TJu+V2L3amk/6q9aCBeDuoobyV/SlgoGbXCAByv/MTfR2oqLX/dWZ4/TI
	XX3eJWReG6dgPKODc2VCU7z+dq460H/HPj2QJr8t6cUS+Ql3EZGkzFnBBW/ugh+vMISdUvCgpQK
	lYw7uZhCjynlbg742Wx8Iyn4q5NL5MO5A2X5yLnekDTV6o1DbIznY6wWfACtq2EaMnFcv+4E4fb
	wsk3ApzWqt8ooLdskXxJOYikKskHRV7hSHlvfgNEnh2HgYOykHRcCP7yPK+bYg6NhNP+w0GeAgn
	+uCigYegK/nigEVYvRjA+DCJPd5y86Ebgt6rnZ4E8sJBbeaFtKViS6gT+klgbbIOuH34TF23XdN
	qhSla06HcZKIKPfnjAauahQCGRUtQ3lR71SzLxjjk7n+1Wdxv2dIJ053yp3H/J2MGN
X-Received: by 2002:a05:620a:a805:b0:937:6771:e7e7 with SMTP id af79cd13be357-937803e0f4amr60405785a.30.1787684435445;
        Tue, 25 Aug 2026 12:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.245.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f0ab844sm31977485a.45.2026.08.25.12.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:00:34 -0700 (PDT)
Message-Id: <eacf6ba4b11e366466da18b7b668e65793c532a9.1787684429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 19:00:29 +0000
Subject: [PATCH v2 4/4] packfile: recover when a multi-pack-index names a
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
just removed, find_pack_entry() cannot serve it -- fill_midx_entry()
routes to the missing pack, and the regular pack fallback deliberately
skips every MIDX-covered pack, so a surviving copy in another covered
pack (e.g. a kept base pack) is never consulted.

Unlike the ordinary "a pack's .idx is mapped but its .pack is gone"
race, the second read does not rescue us -- and not only for
OBJECT_INFO_QUICK callers.  Reloading the on-disk pack set does not
reload the borrowed, cached MIDX (freeing it under the code that caches
the "struct multi_pack_index *" would be a use-after-free), so the stale
MIDX keeps routing to the removed pack and the surviving copy stays
hidden behind the covered-pack skip.  cat-file, rev-list and pack-objects
can thus all spuriously fail with "unable to read object".

Teach find_pack_entry() to recover.  fill_midx_entry() now returns a
tri-state, distinguishing "absent from the MIDX" from "present but the
owning pack is unavailable"; in the latter case, once the regular
fallback has also missed, scan the MIDX's packs directly for a surviving
copy.

Do the scan only on the second read (OBJECT_INFO_SECOND_READ): by then
the cheaper on-disk reload has run, so an object merely relocated into a
new (non-covered) pack has already been found by the regular fallback,
and only a genuine hidden duplicate reaches the rescan.  QUICK callers
that would skip the second read are steered into it by the preceding
commit's stale_packs_detected flag, which prepare_midx_pack() sets when
it cannot open the owning pack.

Reloading the stale MIDX would be a more complete fix but is much more
involved (the borrowers above need proper invalidation), so leave that
for later.

Assisted-by: Claude Opus 4.8 & GPT-5.6 Sol
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pack-objects.c      |  2 +-
 midx.c                      | 38 ++++++++++--------
 midx.h                      | 21 +++++++++-
 odb/source-packed.c         | 42 ++++++++++++++++---
 t/t5319-multi-pack-index.sh | 80 +++++++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+), 25 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 399acd0f22..30ad7d822c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1786,7 +1786,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
 		struct pack_entry e;
 
-		if (m && fill_midx_entry(m, oid, &e, NULL)) {
+		if (m && fill_midx_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/midx.c b/midx.c
index 942505ac41..6b585f3c1a 100644
--- a/midx.c
+++ b/midx.c
@@ -595,46 +595,50 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
-int fill_midx_entry(struct multi_pack_index *m,
-		    const struct object_id *oid,
-		    struct pack_entry *e,
-		    struct packed_git **bad_pack)
+enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
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
+		goto owner_unavailable;
 	p = m->packs[pack_int_id - m->num_packs_in_base];
 
-	/*
-	* We are about to tell the caller where they can locate the
-	* requested object.  We better make sure the packfile is
-	* still here and can be accessed before supplying that
-	* answer, as it may have been deleted since the MIDX was
-	* loaded!
-	*/
+	/* Make sure the pack is still present before pointing at it. */
 	if (!is_pack_valid(p))
-		return 0;
+		goto owner_unavailable;
 
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
+
+owner_unavailable:
+	/*
+	 * Re-arm stale_packs_detected on every such lookup, not just the
+	 * first: prepare_midx_pack() caches the failure, so without this a
+	 * later lookup of the same vanished pack would leave the flag clear
+	 * and a QUICK reader would skip its recovering second read.
+	 */
+	m->source->base.odb->stale_packs_detected = 1;
+	return MIDX_FILL_OWNER_UNAVAILABLE;
 }
 
 /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
@@ -1038,7 +1042,7 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
 
-		if (!fill_midx_entry(m, &oid, &e, NULL)) {
+		if (fill_midx_entry(m, &oid, &e, NULL) != MIDX_FILL_HIT) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
 				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
diff --git a/midx.h b/midx.h
index 1f2f2d5321..52fe9c81e9 100644
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
+enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
+				      const struct object_id *oid,
+				      struct pack_entry *e,
+				      struct packed_git **bad_pack);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_layer_contains_pack(struct multi_pack_index *m,
diff --git a/odb/source-packed.c b/odb/source-packed.c
index b6c1d8fdf4..ae4c4bac40 100644
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
+		midx_result = fill_midx_entry(store->midx, oid, e, bad_pack);
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
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..4041805807 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1393,4 +1393,84 @@ test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
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
+test_expect_success 'repeated QUICK lookups recover after owning pack removed' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Two blobs, each duplicated across packs so the midx must pick
+		# an owning pack, and each attributed to the same moderate pack.
+		echo one >f1 &&
+		echo two >f2 &&
+		git add f1 f2 &&
+		git commit -m dups &&
+		d1=$(git rev-parse HEAD:f1) &&
+		d2=$(git rev-parse HEAD:f2) &&
+
+		# Roll every object, including d1 and d2, into one big pack,
+		# then build a moderate pack that also holds both blobs.
+		git repack -adq &&
+		moderate=$(printf "%s\n%s\n" "$d1" "$d2" |
+			git pack-objects --quiet $objdir/pack/pack) &&
+
+		git multi-pack-index write \
+			--preferred-pack="pack-$moderate.idx" &&
+
+		# Retire the moderate pack; the stale midx still names it as the
+		# owner of both blobs, each of which survives in the big pack.
+		rm -f $objdir/pack/pack-$moderate.* &&
+
+		# One resident QUICK reader ("git mktree --batch") resolves both
+		# blobs.  The first lookup recovers d1 and caches the owning
+		# packs failure; unless that failure keeps re-arming the second
+		# read, the lookup of d2 skips its recovering read and the reader
+		# dies reporting d2 as missing.
+		printf "100644 blob %s\tf1\n\n100644 blob %s\tf2\n\n" \
+			"$d1" "$d2" |
+			git mktree --batch >trees &&
+		test_line_count = 2 trees
+	)
+'
+
 test_done
-- 
gitgitgadget
