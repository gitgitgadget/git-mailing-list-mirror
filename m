Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F038D004
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642015; cv=none; b=U2hLlgMr3Y97Kf9mHEU0GTWQzXUSont8BNDfTPHi89joCGdRuvMV01x7nR/tro9hHgwItnAjkMFeaWh3K2wmPNCZkzhXY7ComWJ9E/gRtH3DiGY3Av1H06VTv6qre6dev2Vp04Hn0gbAYGECjeUvIrjiJmVX3zBi47lKeHz+rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642015; c=relaxed/simple;
	bh=PyZFIHkFlEN0yL7Q0Nt5q+9CX5iQdkOdteOMKC05tjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5/IgfmI1JIkRHRHJx7ZhzGRDC9blxbI1svXB46tb2zXxGx4eNHhYSj4kcH8AMkhY0RrifjFelUOcW6DivriOmC48jUn58OH3Eo9UD/eOkOlX1eDw/oUUeNEIUSOdweXdZP6vhuOxLaLgRjIQD79hfh18ef428ZBUhVqktZuUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BiBA5ZHk; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BiBA5ZHk"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79a8e873ca1so43393287b3.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774642013; x=1775246813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejZZmMRqJeHMDKw02H23Pf8QhZA3aS2rrx8A7KdqHsI=;
        b=BiBA5ZHk+kZPhFQczy+O5trusmcPWg9nzSDnLeZy2ZB1URh2D/vUktq+Wfq8YzUo7F
         u4gWvwnIDbgtJyYFa9W2qNBKtRZRZ67c2HTSn8rz05TJz/+wetW33FDnsVu3dYgJsIOr
         SHu9jSi9FgV1ELBlTucdhoKv+ZdWs+OzCUKcfbLcUJEsySBh9rva9oZ/ALrM3rMP/1h0
         K7vt25+uoXt9cRBttnmJJeeZIol+Iw83vmMaOR0gZtPQs9JecmflrltDT1jVqRVAS3Ft
         4CSo6A1qz3FuO3HfL+KiCJLSZLiQNT6+4F4ye7vL9dS9pyX35mTAamnBMBBAhl9rpiG5
         XsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642013; x=1775246813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejZZmMRqJeHMDKw02H23Pf8QhZA3aS2rrx8A7KdqHsI=;
        b=clYSBYbVEPfl5W3UFhBx31OFTCqjSmCgJkVHS2oTzUNZPOWCoJMSjzsKcA79xF3ulh
         SdbabMaVWx3q/FQ/Xc268FT2kCdNe/XnzvY64wIR2RwG8YukqxeIW0VCQgPZVKyIEbQf
         vEoOaJkautNrPAr4xUBDprtOlrNlyTJn9ONG4XMn0GbkQEAgESDohYWI2pAKayDe0KxH
         H0q57WqUQd61cVpOGE0pDG6+ZxdKRRlAirXnlRJ+iS0MKwy9g7uiRg7+i3qVtTB146vN
         7y+/z7Qv7Tfuh7QKvvH7OfM8RV3ozgSgW4PfLlq4JTjD74MmnzB+kB2h79sxOiri4wHQ
         S38Q==
X-Gm-Message-State: AOJu0Yw3eimcESURcs+xXtONSkwzV84F0joTnE1FBeC2ZHWxyA7BPqxy
	h3xmHUjCuN8W0gIVo6//Jyj7oQu7Knxk03THuyQ3sj9PiAsbUrOpjrHyRNksuUSotnscxWG5Dwn
	17iy6piVLGOp9
X-Gm-Gg: ATEYQzyVRZfMl6LSPSY7KBRvklvTQUoyXm3opwI52z524JtBP6lYF8Szt5ck2BiEpgh
	AKMLOO0nm+eXa5zShasbT5J4GuwHXZvObNxcjL9fLTbFEaZCFQ5qyx+jQ7IEtY5c0TBQX8aKc3s
	dfR2wgqmTOk+v7vYYrvUy3nhdiprX3914N3+JXs4fZ6XLwX90NK03LI8PEjHBD5ng45KvZNj4N2
	x9JnebgVEOjqrweafxRULLPETZEHiwVo31a1SegT2KdFLDmJ4VAiA0r85BN9g84F3Df2df6H8vX
	FgR1OqhYfFbrZs4XMlzraIjFBn5f1m/922lsmRLY+BE/tQMiaDtrcHDsb4IFNZkyROCFxGs90I0
	3s0NFGVImtKE08kbybxQmPQO3oqpTf/Ui7jM1lnvMStKYSlqlIO11A8hr4uGbLGnJnh675HuFyG
	Mo8ykv7IHQzTxHmABDrEPSOy9U24VdDGqGQR+HLP7I2407GSFz5CVaDHnc1DXG0Fy8p4VX5TV8D
	WkuzazHXOoO1zVtuua3GsxvKkomEg==
X-Received: by 2002:a05:690c:d85:b0:79a:c9c1:eb29 with SMTP id 00721157ae682-79bde51e12fmr33308217b3.19.1774642012935;
        Fri, 27 Mar 2026 13:06:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7721b82sm155127b3.15.2026.03.27.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:06:52 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:06:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 4/5] pack-objects: support excluded-open packs with
 --stdin-packs
Message-ID: <efba1ab93d8a15036661b112ded34e229101f6d6.1774641999.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774641999.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774641999.git.me@ttaylorr.com>

In cd846bacc7d (pack-objects: introduce '--stdin-packs=follow',
2025-06-23), pack-objects learned to traverse through commits in
included packs when using '--stdin-packs=follow', rescuing reachable
objects from unlisted packs into the output.

When we encounter a commit in an excluded pack during this rescuing
phase we will traverse through its parents. But because we set
`revs.no_kept_objects = 1`, commit simplification will prevent us from
showing it via `get_revision()`. (In practice, `--stdin-packs=follow`
walks commits down to the roots, but only opens up trees for ones that
do not appear in an excluded pack.)

But there are certain cases where we *do* need to see the parents of an
object in an excluded pack. Namely, if an object is rescue-able, but
only reachable from object(s) which appear in excluded packs, then
commit simplification will exclude those commits from the object
traversal, and we will never see a copy of that object, and thus not
rescue it.

This is what causes the failure in the previous commit during repacking.
When performing a geometric repack, packs above the geometric split that
weren't part of the previous MIDX (e.g., packs pushed directly into
`$GIT_DIR/objects/pack`) may not have full object closure.  When those
packs are listed as excluded via the '^' marker, the reachability
traversal encounters the sequence described above, and may miss objects
which we expect to rescue with `--stdin-packs=follow`.

Introduce a new "excluded-open" pack prefix, '!'. Like '^'-prefixed
packs, objects from '!'-prefixed packs are excluded from the resulting
pack. But unlike '^', commits in '!'-prefixed packs *are* used as
starting points for the follow traversal, and the traversal does not
treat them as a closure boundary.

In order to distinguish excluded-closed from excluded-open packs during
the traversal, introduce a new `pack_keep_in_core_open` bit on
`struct packed_git`, along with a corresponding `KEPT_PACK_IN_CORE_OPEN`
flag for the kept-pack cache.

In `add_object_entry_from_pack()`, move the `want_object_in_pack()`
check to *after* `add_pending_oid()`. This is necessary so that commits
from excluded-open packs are added as traversal tips even though their
objects won't appear in the output. As a consequence, the caller
`for_each_object_in_pack()` will always provide a non-NULL 'p', hence we
are able to drop the "if (p)" conditional.

The `include_check` and `include_check_obj` callbacks on `rev_info` are
used to halt the walk at closed-excluded packs, since objects behind a
'^' boundary are guaranteed to have closure and need not be rescued.

The following commit will make use of this new functionality within the
repack layer to resolve the test failure demonstrated in the previous
commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  25 ++++--
 builtin/pack-objects.c              | 116 ++++++++++++++++++++++------
 packfile.c                          |   3 +-
 packfile.h                          |   2 +
 t/t5331-pack-objects-stdin.sh       | 105 +++++++++++++++++++++++++
 5 files changed, 218 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 71b9682485c..b78175fbe1b 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -94,13 +94,24 @@ base-name::
 	included packs (those not beginning with `^`), excluding any
 	objects listed in the excluded packs (beginning with `^`).
 +
-When `mode` is "follow", objects from packs not listed on stdin receive
-special treatment. Objects within unlisted packs will be included if
-those objects are (1) reachable from the included packs, and (2) not
-found in any excluded packs. This mode is useful, for example, to
-resurrect once-unreachable objects found in cruft packs to generate
-packs which are closed under reachability up to the boundary set by the
-excluded packs.
+When `mode` is "follow" packs may additionally be prefixed with `!`,
+indicating that they are excluded but not necessarily closed under
+reachability.  In addition to objects in included packs, the resulting
+pack may include additional objects based on the following:
++
+--
+* If any packs are marked with `!`, then objects reachable from such
+  packs or included ones via objects outside of excluded-closed packs
+  will be included. In this case, all `^` packs are treated as closed
+  under reachability.
+* Otherwise (if there are no `!` packs), objects within unlisted packs
+  will be included if those objects are (1) reachable from the
+  included packs, and (2) not found in any excluded packs.
+--
++
+This mode is useful, for example, to resurrect once-unreachable
+objects found in cruft packs to generate packs which are closed under
+reachability up to the boundary set by the excluded packs.
 +
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ab7ca98a55..d0203e72d68 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -218,6 +218,7 @@ static int have_non_local_packs;
 static int incremental;
 static int ignore_packed_keep_on_disk;
 static int ignore_packed_keep_in_core;
+static int ignore_packed_keep_in_core_open;
 static int ignore_packed_keep_in_core_has_cruft;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
@@ -1633,7 +1634,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 	/*
 	 * Then handle .keep first, as we have a fast(er) path there.
 	 */
-	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
+	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core ||
+	    ignore_packed_keep_in_core_open) {
 		/*
 		 * Set the flags for the kept-pack cache to be the ones we want
 		 * to ignore.
@@ -1647,6 +1649,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			flags |= KEPT_PACK_ON_DISK;
 		if (ignore_packed_keep_in_core)
 			flags |= KEPT_PACK_IN_CORE;
+		if (ignore_packed_keep_in_core_open)
+			flags |= KEPT_PACK_IN_CORE_OPEN;
 
 		/*
 		 * If the object is in a pack that we want to ignore, *and* we
@@ -1658,6 +1662,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 				return 0;
 			if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 				return 0;
+			if (ignore_packed_keep_in_core_open && p->pack_keep_in_core_open)
+				return 0;
 			if (has_object_kept_pack(p->repo, oid, flags))
 				return 0;
 		} else {
@@ -3757,6 +3763,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 				      void *_data)
 {
 	off_t ofs;
+	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type = OBJ_NONE;
 
 	display_progress(progress_state, ++nr_seen);
@@ -3764,29 +3771,34 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	if (have_duplicate_entry(oid, 0))
 		return 0;
 
+	stdin_packs_found_nr++;
+
 	ofs = nth_packed_object_offset(p, pos);
+
+	oi.typep = &type;
+	if (packed_object_info(p, ofs, &oi) < 0) {
+		die(_("could not get type of object %s in pack %s"),
+		    oid_to_hex(oid), p->pack_name);
+	} else if (type == OBJ_COMMIT) {
+		struct rev_info *revs = _data;
+		/*
+		 * commits in included packs are used as starting points
+		 * for the subsequent revision walk
+		 *
+		 * Note that we do want to walk through commits that are
+		 * present in excluded-open ('!') packs to pick up any
+		 * objects reachable from them not present in the
+		 * excluded-closed ('^') packs.
+		 *
+		 * However, we'll only add those objects to the packing
+		 * list after checking `want_object_in_pack()` below.
+		 */
+		add_pending_oid(revs, NULL, oid, 0);
+	}
+
 	if (!want_object_in_pack(oid, 0, &p, &ofs))
 		return 0;
 
-	if (p) {
-		struct object_info oi = OBJECT_INFO_INIT;
-
-		oi.typep = &type;
-		if (packed_object_info(p, ofs, &oi) < 0) {
-			die(_("could not get type of object %s in pack %s"),
-			    oid_to_hex(oid), p->pack_name);
-		} else if (type == OBJ_COMMIT) {
-			struct rev_info *revs = _data;
-			/*
-			 * commits in included packs are used as starting points for the
-			 * subsequent revision walk
-			 */
-			add_pending_oid(revs, NULL, oid, 0);
-		}
-
-		stdin_packs_found_nr++;
-	}
-
 	create_object_entry(oid, type, 0, 0, 0, p, ofs);
 
 	return 0;
@@ -3847,12 +3859,18 @@ static void show_commit_pack_hint(struct commit *commit, void *data)
  *  - STDIN_PACK_EXCLUDE_CLOSED: objects in any packs with this flag
  *    bit set should be excluded from the output pack.
  *
- * Objects in packs whose 'kind' bits include STDIN_PACK_INCLUDE are
- * used as traversal tips when invoked with --stdin-packs=follow.
+ *  - STDIN_PACK_EXCLUDE_OPEN: objects in any packs with this flag
+ *    bit set should be excluded from the output pack, but are not
+ *    guaranteed to be closed under reachability.
+ *
+ * Objects in packs whose 'kind' bits include STDIN_PACK_INCLUDE or
+ * STDIN_PACK_EXCLUDE_OPEN are used as traversal tips when invoked
+ * with --stdin-packs=follow.
  */
 enum stdin_pack_info_kind {
 	STDIN_PACK_INCLUDE = (1<<0),
 	STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
+	STDIN_PACK_EXCLUDE_OPEN = (1<<2),
 };
 
 struct stdin_pack_info {
@@ -3877,6 +3895,17 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
+static int stdin_packs_include_check_obj(struct object *obj, void *data UNUSED)
+{
+	return !has_object_kept_pack(to_pack.repo, &obj->oid,
+				     KEPT_PACK_IN_CORE);
+}
+
+static int stdin_packs_include_check(struct commit *commit, void *data)
+{
+	return stdin_packs_include_check_obj((struct object *)commit, data);
+}
+
 static void stdin_packs_add_pack_entries(struct strmap *packs,
 					 struct rev_info *revs)
 {
@@ -3903,7 +3932,19 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 	for_each_string_list_item(item, &keys) {
 		struct stdin_pack_info *info = item->util;
 
-		if (info->kind & STDIN_PACK_INCLUDE)
+		if (info->kind & STDIN_PACK_EXCLUDE_OPEN) {
+			/*
+			 * When open-excluded packs ("!") are present, stop
+			 * the parent walk at closed-excluded ("^") packs.
+			 * Objects behind a "^" boundary are guaranteed to
+			 * have closure and should not be rescued.
+			 */
+			revs->include_check = stdin_packs_include_check;
+			revs->include_check_obj = stdin_packs_include_check_obj;
+		}
+
+		if ((info->kind & STDIN_PACK_INCLUDE) ||
+		    (info->kind & STDIN_PACK_EXCLUDE_OPEN))
 			for_each_object_in_pack(info->p,
 						add_object_entry_from_pack,
 						revs,
@@ -3913,7 +3954,8 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 	string_list_clear(&keys, 0);
 }
 
-static void stdin_packs_read_input(struct rev_info *revs)
+static void stdin_packs_read_input(struct rev_info *revs,
+				   enum stdin_packs_mode mode)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strmap packs = STRMAP_INIT;
@@ -3928,6 +3970,8 @@ static void stdin_packs_read_input(struct rev_info *revs)
 			continue;
 		else if (*key == '^')
 			kind = STDIN_PACK_EXCLUDE_CLOSED;
+		else if (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
+			kind = STDIN_PACK_EXCLUDE_OPEN;
 
 		if (kind != STDIN_PACK_INCLUDE)
 			key++;
@@ -3974,6 +4018,20 @@ static void stdin_packs_read_input(struct rev_info *revs)
 			p->pack_keep_in_core = 1;
 		}
 
+		if (info->kind & STDIN_PACK_EXCLUDE_OPEN) {
+			/*
+			 * Marking excluded open packs as kept in-core
+			 * (open) for the same reason as we marked
+			 * exclude closed packs as kept in-core.
+			 *
+			 * Use a separate flag here to ensure we don't
+			 * halt our traversal at these packs, since they
+			 * are not guaranteed to have closure.
+			 *
+			 */
+			p->pack_keep_in_core_open = 1;
+		}
+
 		info->p = p;
 	}
 
@@ -4017,7 +4075,15 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
-	stdin_packs_read_input(&revs);
+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+		/*
+		 * In '--stdin-packs=follow' mode, additionally ignore
+		 * objects in excluded-open packs to prevent them from
+		 * appearing in the resulting pack.
+		 */
+		ignore_packed_keep_in_core_open = 1;
+	}
+	stdin_packs_read_input(&revs, mode);
 	if (rev_list_unpacked)
 		add_unreachable_loose_objects(&revs);
 
diff --git a/packfile.c b/packfile.c
index d4de9f3ffe8..269e420c3b9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2244,7 +2244,8 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *st
 			struct packed_git *p = e->pack;
 
 			if ((p->pack_keep && (flags & KEPT_PACK_ON_DISK)) ||
-			    (p->pack_keep_in_core && (flags & KEPT_PACK_IN_CORE))) {
+			    (p->pack_keep_in_core && (flags & KEPT_PACK_IN_CORE)) ||
+			    (p->pack_keep_in_core_open && (flags & KEPT_PACK_IN_CORE_OPEN))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
 				packs[nr++] = p;
 			}
diff --git a/packfile.h b/packfile.h
index a16ec3950d2..dd37fc1512e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -28,6 +28,7 @@ struct packed_git {
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 pack_keep_in_core:1,
+		 pack_keep_in_core_open:1,
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1,
@@ -266,6 +267,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 enum kept_pack_type {
 	KEPT_PACK_ON_DISK = (1 << 0),
 	KEPT_PACK_IN_CORE = (1 << 1),
+	KEPT_PACK_IN_CORE_OPEN = (1 << 2),
 };
 
 /*
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 7eb79bc2cdb..c74b5861af3 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -415,4 +415,109 @@ test_expect_success '--stdin-packs=follow tolerates missing commits' '
 	stdin_packs__follow_with_only HEAD HEAD^{tree}
 '
 
+test_expect_success '--stdin-packs=follow with open-excluded packs' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		git branch -M main &&
+
+		# Create the following commit structure:
+		#
+		#   A <-- B <-- D     (main)
+		#         ^
+		#          \
+		#           C        (other)
+		test_commit A &&
+		test_commit B &&
+		git checkout -B other &&
+		test_commit C &&
+		git checkout main &&
+		test_commit D &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		D="$(echo B..D | git pack-objects --revs $packdir/pack)" &&
+
+		C_ONLY="$(git rev-parse other | git pack-objects $packdir/pack)" &&
+
+		git prune-packed &&
+
+		# Create a pack using --stdin-packs=follow where:
+		#
+		#  - pack D is included,
+		#  - pack C_ONLY is excluded, but open,
+		#  - pack B is excluded, but closed, and
+		#  - packs A and C are unknown
+		#
+		# The resulting pack should therefore contain:
+		#
+		#  - objects from the included pack D,
+		#  - A.t (rescued via D^{tree}), and
+		#  - C^{tree} and C.t (rescued via pack C_ONLY)
+		#
+		# , but should omit:
+		#
+		#  - C (excluded via C_ONLY),
+		#  - objects from pack B (trivially excluded-closed)
+		#  - A and A^{tree} (ancestors of B)
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <<-EOF
+		pack-$D.pack
+		!pack-$C_ONLY.pack
+		^pack-$B.pack
+		EOF
+		) &&
+
+		{
+			objects_in_packs $D &&
+			git rev-parse A:A.t "C^{tree}" C:C.t
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs with !-delimited pack without follow' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		!pack-$A.pack
+		pack-$B.pack
+		pack-$C.pack
+		EOF
+
+		# Without --stdin-packs=follow, we treat the first
+		# line of input as a literal packfile name, and thus
+		# expect pack-objects to complain of a missing pack
+		test_must_fail git pack-objects --stdin-packs --stdout \
+			>/dev/null <in 2>err &&
+		test_grep "could not find pack .!pack-$A.pack." err &&
+
+		# With --stdin-packs=follow, we treat the second line
+		# of input as indicating pack-$A.pack is an excluded
+		# open pack, and thus expect pack-objects to succeed
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <in) &&
+
+		objects_in_packs $B $C >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.53.0.724.gb20b077944a

