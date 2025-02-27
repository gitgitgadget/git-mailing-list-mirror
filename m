Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED011E833D
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680976; cv=none; b=SFAAtyKk09D7AGdhJuL4ymTvRaikdgP8miD+fQ0UIowigh+MkkoKWxWm6MNvkP8vzc0B1cj43Vx2fTRlJ3QO3EZJWWD1DjFm6N3Gb19Biygj3oGuOrI8W5pF+q0W2Vc8C9acVwF3s+9b/fe6ZCksGruT4R0KRQRG6/sxdhL4b/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680976; c=relaxed/simple;
	bh=fe27Y2z6dqGnTk4/kj7b3KvIuMllgCCk5dZrO3RUYPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3TW1MThZIaWfMJIwcq5h53ESmwmoQ88xI85dhePJzeHIRI8Fwap9jHUNzFhbm10HFEfsDUn1blP7X+TOmPgZ94ZntaEsZzO865WgURaz/FP/yQkBIxAtlqJdynU16RjOTjJguE01hya+DET/ZoDHSiYF7Rc9cczlTcQ6TtKqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gKIZcHqw; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gKIZcHqw"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef60e500d7so11187967b3.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740680973; x=1741285773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiCyUUp8hYeKuLGz8c65JdRkoYi5T2z0mOnSvybiDVI=;
        b=gKIZcHqw3vA7Cnak3YnLgrC5slCagyCmlhsbAoOeuncmauO/aWTY6QGFnsJvfmZL3Y
         XD83nmuXSXnmCDtWey80sgD1WECYEyiQ2jSsGYRUxY/PKNMr3wbDI9sklgUzo2qocGX8
         5Ius85RwruWHw4oCqatBcA3syNhnbhuvPu225npbhBR4bZbTFdnQDgLHIrGBvcbkWGvT
         1N1Do8+OFN8JMPgiQFhK9tKkWUpHCOHFs+mDGvdZWb51PwFsRM3zhHFfbBaBF7HyhMhJ
         f8RLApbnAwdl8EHEJbys1jYpjG3MCmrTZ8jHGCOL9voggvg21gTvKAo8UUOKaxIp7wfz
         gBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680973; x=1741285773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiCyUUp8hYeKuLGz8c65JdRkoYi5T2z0mOnSvybiDVI=;
        b=jrVWRPHn4XWa63223soJDuWXd70vhFM7gkrmOccwt3eYOtuyey8A9bQXMX3SwEhJz7
         khuCHZ4zzyOwMBZXWHENnN+NbbUyIBg8GKbLgLJItCL/xzizi9SGmACl1nSG+uxN2+gn
         6mir1TqeokB1YiQpEzNMZzwNv+FKvJ0wZPxy/P6TYkkHk1lrNlDuloueY8/r6ZA6p2CS
         UhnvgHIylicELIc/QMiXiD7a4jHdKFuAJuJw+P5M5oyocd0kPloawjzwavCtHlR9F+q9
         XgtvGtg0yReB4Rs6N16wC4DuUzmNHrcinPXfRh1+ZOdZcZ86AdZL6RKBMDWr/NF8vum9
         33IQ==
X-Gm-Message-State: AOJu0YwiYxt6H/9OzzhiURDqpy/71ziJBjL5hN8GhgFay868+g4bL7we
	z+b1FcDDhIHd9VJqzervJYNLBoHhWUnTmHdgQk/IAtTTNEDrWvEtzZhs5Q/fUEy6TDFmAmGcEEV
	m
X-Gm-Gg: ASbGncvES5fSDGPTHkKSih6oFYTtjEBsd90mLXHwrXFfqkTX+P3Q8il1T0/Kj9Bql+i
	bBFpkelzLPyNdkq2EWs8WUrNwHlV/k9l81+EAdzRgQLrNfXausxdS8xkBXZOpa1IPD2kYtUA9sr
	IZ2GMEq5vcN2caoYdgJ+AUdl2gf4cBZ9h+eaibxmFzOAr+MjL6rzxG21xLsWBLDYsY8qf/eSR8G
	gohYtEskn7KECCcDVy76RMqgOBz+DQ2IXXog+PyV1m5YqbQO5BqvZenkYS+8PIBesA2jJwm3foj
	Idyqnpy6oAb19kUl8raETo1qemt/bURaZ+mUBycM4gbUtCDphm0KZhbPUiIbPj7eooUYoyS36Q=
	=
X-Google-Smtp-Source: AGHT+IGVXjUMmshOebV5lWxMpp43h+R9oL4a7xg3iA1XzfsC+xZNMFyxXcliPb4SbrAZEKlmW3nSLw==
X-Received: by 2002:a05:690c:648a:b0:6fd:47aa:c6ba with SMTP id 00721157ae682-6fd4a090311mr8586807b3.19.1740680972557;
        Thu, 27 Feb 2025 10:29:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb9dac4sm3911827b3.102.2025.02.27.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:29:32 -0800 (PST)
Date: Thu, 27 Feb 2025 13:29:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] builtin/pack-objects.c: freshen objects from existing
 cruft packs
Message-ID: <c0c926adde2b7c8f4b53b7a274d5b8c040f77e62.1740680964.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1740680964.git.me@ttaylorr.com>

Once an object is written into a cruft pack, we can only freshen it by
writing a new loose or packed copy of that object with a more recent
mtime.

Prior to 61568efa95 (builtin/pack-objects.c: support `--max-pack-size`
with `--cruft`, 2023-08-28), we typically had at most one cruft pack in
a repository at any given time. So freshening unreachable objects was
straightforward when already rewriting the cruft pack (and its *.mtimes
file).

But 61568efa95 changes things: 'pack-objects' now supports writing
multiple cruft packs when invoked with `--cruft` and the
`--max-pack-size` flag. Cruft packs are rewritten until they reach some
size threshold, at which point they are considered "frozen", and will
only be modified in a pruning GC, or if the threshold itself is
adjusted.

However, this process breaks down when we attempt to freshen an object
packed in an earlier cruft pack that is larger than the threshold and
thus will survive the repack.

When this is the case, it is impossible to freshen objects in cruft
pack(s) which are larger than the threshold. This is because we avoid
writing them in the new cruft pack entirely, for a couple of reasons.

 1. When enumerating packed objects via 'add_objects_in_unpacked_packs()'
    we pass the SKIP_IN_CORE_KEPT_PACKS, which is used to avoid looping
    over the packs we're going to retain (which are marked as kept
    in-core by 'read_cruft_objects()').

    This means that we will avoid enumerating additional packed copies
    of objects found in any cruft packs which are larger than the given
    size threshold. Thus there is no opportunity to call
    'create_object_entry()' whatsoever.

 2. We likewise will discard the loose copy (if one exists) of any
    unreachable object packed in a cruft pack that is larger than the
    threshold. Here our call path is 'add_unreachable_loose_objects()',
    which uses the 'add_loose_object()' callback.

    That function will eventually land us in 'want_object_in_pack()'
    (via 'add_cruft_object_entry()'), and we'll discard the object as it
    appears in one of the packs which we marked as kept in-core.

This means in effect that it is impossible to freshen an unreachable
object once it appears in a cruft pack larger than the given threshold.

Instead, we should pack an additional copy of an unreachable object we
want to freshen even if it appears in a cruft pack, provided that the
cruft copy has an mtime which is before the mtime of the copy we are
trying to pack/freshen. This is sub-optimal in the sense that it
requires keeping an additional copy of unreachable objects upon
freshening, but we don't have a better alternative without the ability
to make in-place modifications to existing *.mtimes files.

In order to implement this, we have to adjust the behavior of
'want_found_object()'. When 'pack-objects' is told that we're *not*
going to retain any cruft packs (i.e. the set of packs marked as kept
in-core does not contain a cruft pack), the behavior is unchanged.

But when there *is* at least one cruft pack that we're holding onto, it
is no longer sufficient to reject a copy of an object found in that
cruft pack for that reason alone. In this case, we only want to reject a
candidate object when copies of that object either:

 - exists in a non-cruft pack that we are retaining, regardless of that
   pack's mtime, or

 - exists in a cruft pack with an mtime more recent than the copy we are
   debating whether or not to pack, in which case freshening would be
   redundant.

To do this, keep track of whether or not we have any cruft packs in our
in-core kept list with a new 'ignore_packed_keep_in_core_has_cruft'
flag. When we end up in this new special case, we replace a call to
'has_object_kept_pack()' to 'want_cruft_object_mtime()', and only
reject objects when we have a copy in an existing cruft pack with a more
recent mtime (in which case "freshening" would be redundant).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
 packfile.c              |   3 +-
 packfile.h              |   2 +
 t/t7704-repack-cruft.sh |  64 ++++++++++++++++++++++
 4 files changed, 169 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b161262..79e1e6fb52b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -206,6 +206,7 @@ static int have_non_local_packs;
 static int incremental;
 static int ignore_packed_keep_on_disk;
 static int ignore_packed_keep_in_core;
+static int ignore_packed_keep_in_core_has_cruft;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
@@ -1502,8 +1503,60 @@ static int have_duplicate_entry(const struct object_id *oid,
 	return 1;
 }
 
+static int want_cruft_object_mtime(struct repository *r,
+				   const struct object_id *oid,
+				   unsigned flags, uint32_t mtime)
+{
+	struct packed_git **cache;
+
+	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
+		struct packed_git *p = *cache;
+		off_t ofs;
+		uint32_t candidate_mtime;
+
+		ofs = find_pack_entry_one(oid, p);
+		if (!ofs)
+			continue;
+
+		/*
+		 * We have a copy of the object 'oid' in a non-cruft
+		 * pack. We can avoid packing an additional copy
+		 * regardless of what the existing copy's mtime is since
+		 * it is outside of a cruft pack.
+		 */
+		if (!p->is_cruft)
+			return 0;
+
+		/*
+		 * If we have a copy of the object 'oid' in a cruft
+		 * pack, then either read the cruft pack's mtime for
+		 * that object, or, if that can't be loaded, assume the
+		 * pack's mtime itself.
+		 */
+		if (!load_pack_mtimes(p)) {
+			uint32_t pos;
+			if (offset_to_pack_pos(p, ofs, &pos) < 0)
+				continue;
+			candidate_mtime = nth_packed_mtime(p, pos);
+		} else {
+			candidate_mtime = p->mtime;
+		}
+
+		/*
+		 * We have a surviving copy of the object in a cruft
+		 * pack whose mtime is greater than or equal to the one
+		 * we are considering. We can thus avoid packing an
+		 * additional copy of that object.
+		 */
+		if (mtime <= candidate_mtime)
+			return 0;
+	}
+
+	return -1;
+}
+
 static int want_found_object(const struct object_id *oid, int exclude,
-			     struct packed_git *p)
+			     struct packed_git *p, uint32_t mtime)
 {
 	if (exclude)
 		return 1;
@@ -1553,12 +1606,29 @@ static int want_found_object(const struct object_id *oid, int exclude,
 		if (ignore_packed_keep_in_core)
 			flags |= IN_CORE_KEEP_PACKS;
 
-		if (ignore_packed_keep_on_disk && p->pack_keep)
-			return 0;
-		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
-			return 0;
-		if (has_object_kept_pack(p->repo, oid, flags))
-			return 0;
+		/*
+		 * If the object is in a pack that we want to ignore, *and* we
+		 * don't have any cruft packs that are being retained, we can
+		 * abort quickly.
+		 */
+		if (!ignore_packed_keep_in_core_has_cruft) {
+			if (ignore_packed_keep_on_disk && p->pack_keep)
+				return 0;
+			if (ignore_packed_keep_in_core && p->pack_keep_in_core)
+				return 0;
+			if (has_object_kept_pack(p->repo, oid, flags))
+				return 0;
+		} else {
+			/*
+			 * But if there is at least one cruft pack which
+			 * is being kept, we only want to include the
+			 * provided object if it has a strictly greater
+			 * mtime than any existing cruft copy.
+			 */
+			if (!want_cruft_object_mtime(p->repo, oid, flags,
+						     mtime))
+				return 0;
+		}
 	}
 
 	/*
@@ -1577,7 +1647,8 @@ static int want_object_in_pack_one(struct packed_git *p,
 				   const struct object_id *oid,
 				   int exclude,
 				   struct packed_git **found_pack,
-				   off_t *found_offset)
+				   off_t *found_offset,
+				   uint32_t found_mtime)
 {
 	off_t offset;
 
@@ -1593,7 +1664,7 @@ static int want_object_in_pack_one(struct packed_git *p,
 			*found_offset = offset;
 			*found_pack = p;
 		}
-		return want_found_object(oid, exclude, p);
+		return want_found_object(oid, exclude, p, found_mtime);
 	}
 	return -1;
 }
@@ -1607,10 +1678,11 @@ static int want_object_in_pack_one(struct packed_git *p,
  * function finds if there is any pack that has the object and returns the pack
  * and its offset in these variables.
  */
-static int want_object_in_pack(const struct object_id *oid,
-			       int exclude,
-			       struct packed_git **found_pack,
-			       off_t *found_offset)
+static int want_object_in_pack_mtime(const struct object_id *oid,
+				     int exclude,
+				     struct packed_git **found_pack,
+				     off_t *found_offset,
+				     uint32_t found_mtime)
 {
 	int want;
 	struct list_head *pos;
@@ -1625,7 +1697,8 @@ static int want_object_in_pack(const struct object_id *oid,
 	 * are present we will determine the answer right now.
 	 */
 	if (*found_pack) {
-		want = want_found_object(oid, exclude, *found_pack);
+		want = want_found_object(oid, exclude, *found_pack,
+					 found_mtime);
 		if (want != -1)
 			return want;
 
@@ -1636,7 +1709,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
 		struct pack_entry e;
 		if (fill_midx_entry(the_repository, oid, &e, m)) {
-			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset);
+			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
 		}
@@ -1644,7 +1717,7 @@ static int want_object_in_pack(const struct object_id *oid,
 
 	list_for_each(pos, get_packed_git_mru(the_repository)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset);
+		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
 			list_move(&p->mru,
 				  get_packed_git_mru(the_repository));
@@ -1674,6 +1747,15 @@ static int want_object_in_pack(const struct object_id *oid,
 	return 1;
 }
 
+static inline int want_object_in_pack(const struct object_id *oid,
+				      int exclude,
+				      struct packed_git **found_pack,
+				      off_t *found_offset)
+{
+	return want_object_in_pack_mtime(oid, exclude, found_pack, found_offset,
+					 0);
+}
+
 static struct object_entry *create_object_entry(const struct object_id *oid,
 						enum object_type type,
 						uint32_t hash,
@@ -3606,7 +3688,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			entry->no_try_delta = no_try_delta(name);
 		}
 	} else {
-		if (!want_object_in_pack(oid, 0, &pack, &offset))
+		if (!want_object_in_pack_mtime(oid, 0, &pack, &offset, mtime))
 			return;
 		if (!pack && type == OBJ_BLOB && !has_loose_object(oid)) {
 			/*
@@ -3680,6 +3762,8 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 		struct packed_git *p = item->util;
 		if (!p)
 			die(_("could not find pack '%s'"), item->string);
+		if (p->is_cruft && keep)
+			ignore_packed_keep_in_core_has_cruft = 1;
 		p->pack_keep_in_core = keep;
 	}
 }
diff --git a/packfile.c b/packfile.c
index 2d80d80cb38..9d09f8bc726 100644
--- a/packfile.c
+++ b/packfile.c
@@ -24,6 +24,7 @@
 #include "commit-graph.h"
 #include "pack-revindex.h"
 #include "promisor-remote.h"
+#include "pack-mtimes.h"
 
 char *odb_pack_name(struct repository *r, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext)
@@ -2107,7 +2108,7 @@ static void maybe_invalidate_kept_pack_cache(struct repository *r,
 	r->objects->kept_pack_cache.flags = 0;
 }
 
-static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
+struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 {
 	maybe_invalidate_kept_pack_cache(r, flags);
 
diff --git a/packfile.h b/packfile.h
index 00ada7a938f..25097213d06 100644
--- a/packfile.h
+++ b/packfile.h
@@ -197,6 +197,8 @@ int has_object_pack(struct repository *r, const struct object_id *oid);
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 			 unsigned flags);
 
+struct packed_git **kept_pack_cache(struct repository *r, unsigned flags);
+
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 5a76b541ddd..2b20d66333c 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -262,6 +262,70 @@ test_expect_success '--max-cruft-size with freshened objects (packed)' '
 	)
 '
 
+test_expect_success '--max-cruft-size with freshened objects (previously cruft)' '
+	git init max-cruft-size-threshold &&
+	(
+		cd max-cruft-size-threshold &&
+
+		test_commit base &&
+		foo="$(generate_random_blob foo $((2*1024*1024)))" &&
+		bar="$(generate_random_blob bar $((2*1024*1024)))" &&
+		baz="$(generate_random_blob baz $((2*1024*1024)))" &&
+
+		test-tool chmtime --get -100000 \
+			"$objdir/$(test_oid_to_path "$foo")" >foo.old &&
+		test-tool chmtime --get -100000 \
+			"$objdir/$(test_oid_to_path "$bar")" >bar.old &&
+		test-tool chmtime --get -100000 \
+			"$objdir/$(test_oid_to_path "$baz")" >baz.old &&
+
+		git repack --cruft -d &&
+
+		# Make a packed copy of object $foo with a more recent
+		# mtime.
+		foo="$(generate_random_blob foo $((2*1024*1024)))" &&
+		foo_pack="$(echo "$foo" | git pack-objects $packdir/pack)" &&
+		test-tool chmtime --get -100 \
+			"$packdir/pack-$foo_pack.pack" >foo.new &&
+		git prune-packed &&
+
+		# Make a loose copy of object $bar with a more recent
+		# mtime.
+		bar="$(generate_random_blob bar $((2*1024*1024)))" &&
+		test-tool chmtime --get -100 \
+			"$objdir/$(test_oid_to_path "$bar")" >bar.new &&
+
+		# Make a new cruft object $quux to ensure we do not
+		# generate an identical pack to the existing cruft
+		# pack.
+		quux="$(generate_random_blob quux $((1024)))" &&
+		test-tool chmtime --get -100 \
+			"$objdir/$(test_oid_to_path "$quux")" >quux.new &&
+
+		git repack --cruft --max-cruft-size=3M -d &&
+
+		for p in $packdir/pack-*.mtimes
+		do
+			test-tool pack-mtimes "$(basename "$p")" || return 1
+		done >actual.raw &&
+		sort actual.raw >actual &&
+
+		# Among the set of all cruft packs, we should see both
+		# mtimes for object $foo and $bar, as well as the
+		# single new copy of $baz.
+		sort >expect <<-EOF &&
+		$foo $(cat foo.old)
+		$foo $(cat foo.new)
+		$bar $(cat bar.old)
+		$bar $(cat bar.new)
+		$baz $(cat baz.old)
+		$quux $(cat quux.new)
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--max-cruft-size with pruning' '
 	git init max-cruft-size-prune &&
 	(
-- 
2.49.0.rc0.2.gc0c926adde2
