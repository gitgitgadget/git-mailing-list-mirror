Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35041FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097351; cv=none; b=iHI0NHoxltVtH/7ZpPJakuLeMsR1/2hMJJAL1+kf68eS2RV/GRc0eEgXaxBLSP554B7gbXsE7kAM15H/tGc0DkAyacvQFQSda1a8xyU7/bbM/qFeKyWv9UCVHCsA0epKGaQkq0qpLugGAxcHlB0X9eV0aZC7vsMmj7JwBemjs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097351; c=relaxed/simple;
	bh=lNHml25KEOx7t1lyHqUS8200/NTw2BY4+F0TCMIyc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6rdVZZLv4HS3GOYnoWqULLEVdple/SPOq6wYDNk7SoQfq8ZxZMmRkOojIgx2mATO+GC99wfzrVx6h7PeJmEB8iby4r+ydF+HEyoNvgog7hcYM06LvkXxHUavZzAfmCeRU2BLW7a0ik+Pjh0b+3oSWxwXD5MvZZYAl9wyPSYuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=O8re/Y10; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="O8re/Y10"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-635355713d9so3017111d50.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097349; x=1759702149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyAEzYvI99Tbu4d1/m/tJfnO5KVW+KnAFoqTDngwlG4=;
        b=O8re/Y10yBAJ/2HqsZLRGLIO/d7fD6quJI70fKnDMctdM/YnVHChR/epwgGQCpIf4F
         p/D0Qu+MLAQPhjaYbNZJaf/44svlDXltFQs4sEgbDZ0TcUwnmzDuc3yWnasdVTe4So0H
         9pmLH8Kr92z3xfuOJTz2p82PO7QApbun93gANL6PusjKmiTn9h8XMGbblrwJcqjPNUSr
         TMT708QzN+mI07vO42uyU7Aq6Gr43AdRTvd6kVtBYNWQZnxhu7AaqIl392F6Z+viY10Y
         +5eQt743kaGyu6LQ1aEp3WXNWOjOgsaCyiE2OHLamIH524Zk9DGhU6+aXvBnzpRhww1h
         OW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097349; x=1759702149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyAEzYvI99Tbu4d1/m/tJfnO5KVW+KnAFoqTDngwlG4=;
        b=r5JuhgXLjN6loiv+YeDWdO4mslNZxFWUPxGLHlTH32TqzUuYtmpSyaXBXA60JX5jAl
         cH1wtSfQC0kEeaQVzvp4etDIRHsAsdXS7mkIlP0e0I1mqbCxaMfcmg0HXnN0QhTVrhrl
         xxnDtpvj2bREclo1B3DrKTiqqBWda+T4y9AIDwgv+FLCnzug4eMnnqGfirlD1YtlLFTj
         X1EKA0ToUIk8/JQP3UoO41ZQVxWwNJz43tqUEH7nal/4tSdUQ+80Q5galJey6HMw9UxC
         ARyhId8jAnYGSiA7U6Qbq5Q3y9TbDrJhtOPwwleocw2vQUJG5UwnFxxgfh0iZ9KEDIf4
         Tjsw==
X-Gm-Message-State: AOJu0YxPGR98X51e53BhmGLPOQu83vJrDwC+lwYChe1Q1NtHFf6NXX5V
	0LbuZN9+Cup+Yf5ZuHK+aNy7EUIwOsQR6mEayZHPuzjGRsxIzLuVgDASDBNKaMjgqOHm3QQX9ea
	Njqk7+02M7Q==
X-Gm-Gg: ASbGncthCvM9QHx1poKFoxo+NhglfOeaO2HxsNxh0+OVPV8Nfk3FfaFbzXiESYPPrAE
	BD2zlxnVyrbMyoxppoFyr4oibMmn9hxreOkmNS4znCbBISIUwhKqmBeH2yKau97gmekMyn/dz0J
	vmerHWK0IGUqbzfnSzUL5cb6E9ffHW37vLVsnNOQYV/1eTlB5azNH5KSePOZ+smABb6gLx8ek05
	dv2JlH91544bcqD3vv074d0nfoWLXyRHvDhq17o70OhSXm6fF4KZm0zdaq5wmDAEhLmeK7Pj8rH
	rqtdc3LXzg1KxjwWLdCEd+goaCJChS0XU6ZMVr1irmqB7U5uBxjBlQvoJVRoyLY8IunzbsJI2ML
	nzNVEI2KJIRk0jRx0hI6Lds1lPM8VK/YINP1HePjbD5vJp5dvXiDC4nlEEyOMrs383ZSXTSk8Oe
	6k71vy8xBgpbgYxRMsmDKOVPrPuw==
X-Google-Smtp-Source: AGHT+IFUZEfhbVsfbVF1lklSbFYNlVzo+xkz9uJvzgfgwqmHUvEdQVpONbOeTZwsy4yEJg7B1SVT9g==
X-Received: by 2002:a05:690e:4291:10b0:636:d1b:aa3c with SMTP id 956f58d0204a3-6361fe5e3camr13753071d50.10.1759097348552;
        Sun, 28 Sep 2025 15:09:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38384d7aesm2950585276.4.2025.09.28.15.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:08 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 30/49] repack: remove pack_geometry API from the builtin
Message-ID: <54a2feaea9a88c66aeffe1fa0146ed5a811ae737.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Now that the pack_geometry API is fully factored and isolated from the
rest of the builtin, declare it within repack.h and move its
implementation to "repack-geometry.c" as a separate component.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile          |   1 +
 builtin/repack.c  | 235 ----------------------------------------------
 meson.build       |   1 +
 repack-geometry.c | 233 +++++++++++++++++++++++++++++++++++++++++++++
 repack.h          |  20 ++++
 5 files changed, 255 insertions(+), 235 deletions(-)
 create mode 100644 repack-geometry.c

diff --git a/Makefile b/Makefile
index 0a73f8adaf..a6da12a326 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
diff --git a/builtin/repack.c b/builtin/repack.c
index 9e2523d948..b49e2dab9a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -107,241 +107,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-struct pack_geometry {
-	struct packed_git **pack;
-	uint32_t pack_nr, pack_alloc;
-	uint32_t split;
-
-	int split_factor;
-};
-
-static uint32_t pack_geometry_weight(struct packed_git *p)
-{
-	if (open_pack_index(p))
-		die(_("cannot open index for %s"), p->pack_name);
-	return p->num_objects;
-}
-
-static int pack_geometry_cmp(const void *va, const void *vb)
-{
-	uint32_t aw = pack_geometry_weight(*(struct packed_git **)va),
-		 bw = pack_geometry_weight(*(struct packed_git **)vb);
-
-	if (aw < bw)
-		return -1;
-	if (aw > bw)
-		return 1;
-	return 0;
-}
-
-static void pack_geometry_init(struct pack_geometry *geometry,
-			       struct existing_packs *existing,
-			       const struct pack_objects_args *args,
-			       int pack_kept_objects)
-{
-	struct packfile_store *packs = existing->repo->objects->packfiles;
-	struct packed_git *p;
-	struct strbuf buf = STRBUF_INIT;
-
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
-		if (args->local && !p->pack_local)
-			/*
-			 * When asked to only repack local packfiles we skip
-			 * over any packfiles that are borrowed from alternate
-			 * object directories.
-			 */
-			continue;
-
-		if (!pack_kept_objects) {
-			/*
-			 * Any pack that has its pack_keep bit set will
-			 * appear in existing->kept_packs below, but
-			 * this saves us from doing a more expensive
-			 * check.
-			 */
-			if (p->pack_keep)
-				continue;
-
-			/*
-			 * The pack may be kept via the --keep-pack
-			 * option; check 'existing->kept_packs' to
-			 * determine whether to ignore it.
-			 */
-			strbuf_reset(&buf);
-			strbuf_addstr(&buf, pack_basename(p));
-			strbuf_strip_suffix(&buf, ".pack");
-
-			if (string_list_has_string(&existing->kept_packs, buf.buf))
-				continue;
-		}
-		if (p->is_cruft)
-			continue;
-
-		ALLOC_GROW(geometry->pack,
-			   geometry->pack_nr + 1,
-			   geometry->pack_alloc);
-
-		geometry->pack[geometry->pack_nr] = p;
-		geometry->pack_nr++;
-	}
-
-	QSORT(geometry->pack, geometry->pack_nr, pack_geometry_cmp);
-	strbuf_release(&buf);
-}
-
-static void pack_geometry_split(struct pack_geometry *geometry)
-{
-	uint32_t i;
-	uint32_t split;
-	off_t total_size = 0;
-
-	if (!geometry->pack_nr) {
-		geometry->split = geometry->pack_nr;
-		return;
-	}
-
-	/*
-	 * First, count the number of packs (in descending order of size) which
-	 * already form a geometric progression.
-	 */
-	for (i = geometry->pack_nr - 1; i > 0; i--) {
-		struct packed_git *ours = geometry->pack[i];
-		struct packed_git *prev = geometry->pack[i - 1];
-
-		if (unsigned_mult_overflows(geometry->split_factor,
-					    pack_geometry_weight(prev)))
-			die(_("pack %s too large to consider in geometric "
-			      "progression"),
-			    prev->pack_name);
-
-		if (pack_geometry_weight(ours) <
-		    geometry->split_factor * pack_geometry_weight(prev))
-			break;
-	}
-
-	split = i;
-
-	if (split) {
-		/*
-		 * Move the split one to the right, since the top element in the
-		 * last-compared pair can't be in the progression. Only do this
-		 * when we split in the middle of the array (otherwise if we got
-		 * to the end, then the split is in the right place).
-		 */
-		split++;
-	}
-
-	/*
-	 * Then, anything to the left of 'split' must be in a new pack. But,
-	 * creating that new pack may cause packs in the heavy half to no longer
-	 * form a geometric progression.
-	 *
-	 * Compute an expected size of the new pack, and then determine how many
-	 * packs in the heavy half need to be joined into it (if any) to restore
-	 * the geometric progression.
-	 */
-	for (i = 0; i < split; i++) {
-		struct packed_git *p = geometry->pack[i];
-
-		if (unsigned_add_overflows(total_size, pack_geometry_weight(p)))
-			die(_("pack %s too large to roll up"), p->pack_name);
-		total_size += pack_geometry_weight(p);
-	}
-	for (i = split; i < geometry->pack_nr; i++) {
-		struct packed_git *ours = geometry->pack[i];
-
-		if (unsigned_mult_overflows(geometry->split_factor,
-					    total_size))
-			die(_("pack %s too large to roll up"), ours->pack_name);
-
-		if (pack_geometry_weight(ours) <
-		    geometry->split_factor * total_size) {
-			if (unsigned_add_overflows(total_size,
-						   pack_geometry_weight(ours)))
-				die(_("pack %s too large to roll up"),
-				    ours->pack_name);
-
-			split++;
-			total_size += pack_geometry_weight(ours);
-		} else
-			break;
-	}
-
-	geometry->split = split;
-}
-
-static struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
-{
-	uint32_t i;
-
-	if (!geometry) {
-		/*
-		 * No geometry means either an all-into-one repack (in which
-		 * case there is only one pack left and it is the largest) or an
-		 * incremental one.
-		 *
-		 * If repacking incrementally, then we could check the size of
-		 * all packs to determine which should be preferred, but leave
-		 * this for later.
-		 */
-		return NULL;
-	}
-	if (geometry->split == geometry->pack_nr)
-		return NULL;
-
-	/*
-	 * The preferred pack is the largest pack above the split line. In
-	 * other words, it is the largest pack that does not get rolled up in
-	 * the geometric repack.
-	 */
-	for (i = geometry->pack_nr; i > geometry->split; i--)
-		/*
-		 * A pack that is not local would never be included in a
-		 * multi-pack index. We thus skip over any non-local packs.
-		 */
-		if (geometry->pack[i - 1]->pack_local)
-			return geometry->pack[i - 1];
-
-	return NULL;
-}
-
-static void pack_geometry_remove_redundant(struct pack_geometry *geometry,
-					   struct string_list *names,
-					   struct existing_packs *existing,
-					   const char *packdir)
-{
-	const struct git_hash_algo *algop = existing->repo->hash_algo;
-	struct strbuf buf = STRBUF_INIT;
-	uint32_t i;
-
-	for (i = 0; i < geometry->split; i++) {
-		struct packed_git *p = geometry->pack[i];
-		if (string_list_has_string(names, hash_to_hex_algop(p->hash,
-								    algop)))
-			continue;
-
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, pack_basename(p));
-		strbuf_strip_suffix(&buf, ".pack");
-
-		if ((p->pack_keep) ||
-		    (string_list_has_string(&existing->kept_packs, buf.buf)))
-			continue;
-
-		repack_remove_redundant_pack(existing->repo, packdir, buf.buf);
-	}
-
-	strbuf_release(&buf);
-}
-
-static void pack_geometry_release(struct pack_geometry *geometry)
-{
-	if (!geometry)
-		return;
-
-	free(geometry->pack);
-}
-
 static int midx_has_unknown_packs(char **midx_pack_names,
 				  size_t midx_pack_names_nr,
 				  struct string_list *include,
diff --git a/meson.build b/meson.build
index ca5603b456..c929ad6f7e 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'repack.c',
+  'repack-geometry.c',
   'repack-promisor.c',
   'replace-object.c',
   'repo-settings.c',
diff --git a/repack-geometry.c b/repack-geometry.c
new file mode 100644
index 0000000000..a879f2fe49
--- /dev/null
+++ b/repack-geometry.c
@@ -0,0 +1,233 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "git-compat-util.h"
+#include "repack.h"
+#include "hex.h"
+#include "packfile.h"
+
+static uint32_t pack_geometry_weight(struct packed_git *p)
+{
+	if (open_pack_index(p))
+		die(_("cannot open index for %s"), p->pack_name);
+	return p->num_objects;
+}
+
+static int pack_geometry_cmp(const void *va, const void *vb)
+{
+	uint32_t aw = pack_geometry_weight(*(struct packed_git **)va),
+		 bw = pack_geometry_weight(*(struct packed_git **)vb);
+
+	if (aw < bw)
+		return -1;
+	if (aw > bw)
+		return 1;
+	return 0;
+}
+
+void pack_geometry_init(struct pack_geometry *geometry,
+			struct existing_packs *existing,
+			const struct pack_objects_args *args,
+			int pack_kept_objects)
+{
+	struct packfile_store *packs = existing->repo->objects->packfiles;
+	struct packed_git *p;
+	struct strbuf buf = STRBUF_INIT;
+
+	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		if (args->local && !p->pack_local)
+			/*
+			 * When asked to only repack local packfiles we skip
+			 * over any packfiles that are borrowed from alternate
+			 * object directories.
+			 */
+			continue;
+
+		if (!pack_kept_objects) {
+			/*
+			 * Any pack that has its pack_keep bit set will
+			 * appear in existing->kept_packs below, but
+			 * this saves us from doing a more expensive
+			 * check.
+			 */
+			if (p->pack_keep)
+				continue;
+
+			/*
+			 * The pack may be kept via the --keep-pack
+			 * option; check 'existing->kept_packs' to
+			 * determine whether to ignore it.
+			 */
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+
+			if (string_list_has_string(&existing->kept_packs, buf.buf))
+				continue;
+		}
+		if (p->is_cruft)
+			continue;
+
+		ALLOC_GROW(geometry->pack,
+			   geometry->pack_nr + 1,
+			   geometry->pack_alloc);
+
+		geometry->pack[geometry->pack_nr] = p;
+		geometry->pack_nr++;
+	}
+
+	QSORT(geometry->pack, geometry->pack_nr, pack_geometry_cmp);
+	strbuf_release(&buf);
+}
+
+void pack_geometry_split(struct pack_geometry *geometry)
+{
+	uint32_t i;
+	uint32_t split;
+	off_t total_size = 0;
+
+	if (!geometry->pack_nr) {
+		geometry->split = geometry->pack_nr;
+		return;
+	}
+
+	/*
+	 * First, count the number of packs (in descending order of size) which
+	 * already form a geometric progression.
+	 */
+	for (i = geometry->pack_nr - 1; i > 0; i--) {
+		struct packed_git *ours = geometry->pack[i];
+		struct packed_git *prev = geometry->pack[i - 1];
+
+		if (unsigned_mult_overflows(geometry->split_factor,
+					    pack_geometry_weight(prev)))
+			die(_("pack %s too large to consider in geometric "
+			      "progression"),
+			    prev->pack_name);
+
+		if (pack_geometry_weight(ours) <
+		    geometry->split_factor * pack_geometry_weight(prev))
+			break;
+	}
+
+	split = i;
+
+	if (split) {
+		/*
+		 * Move the split one to the right, since the top element in the
+		 * last-compared pair can't be in the progression. Only do this
+		 * when we split in the middle of the array (otherwise if we got
+		 * to the end, then the split is in the right place).
+		 */
+		split++;
+	}
+
+	/*
+	 * Then, anything to the left of 'split' must be in a new pack. But,
+	 * creating that new pack may cause packs in the heavy half to no longer
+	 * form a geometric progression.
+	 *
+	 * Compute an expected size of the new pack, and then determine how many
+	 * packs in the heavy half need to be joined into it (if any) to restore
+	 * the geometric progression.
+	 */
+	for (i = 0; i < split; i++) {
+		struct packed_git *p = geometry->pack[i];
+
+		if (unsigned_add_overflows(total_size, pack_geometry_weight(p)))
+			die(_("pack %s too large to roll up"), p->pack_name);
+		total_size += pack_geometry_weight(p);
+	}
+	for (i = split; i < geometry->pack_nr; i++) {
+		struct packed_git *ours = geometry->pack[i];
+
+		if (unsigned_mult_overflows(geometry->split_factor,
+					    total_size))
+			die(_("pack %s too large to roll up"), ours->pack_name);
+
+		if (pack_geometry_weight(ours) <
+		    geometry->split_factor * total_size) {
+			if (unsigned_add_overflows(total_size,
+						   pack_geometry_weight(ours)))
+				die(_("pack %s too large to roll up"),
+				    ours->pack_name);
+
+			split++;
+			total_size += pack_geometry_weight(ours);
+		} else
+			break;
+	}
+
+	geometry->split = split;
+}
+
+struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
+{
+	uint32_t i;
+
+	if (!geometry) {
+		/*
+		 * No geometry means either an all-into-one repack (in which
+		 * case there is only one pack left and it is the largest) or an
+		 * incremental one.
+		 *
+		 * If repacking incrementally, then we could check the size of
+		 * all packs to determine which should be preferred, but leave
+		 * this for later.
+		 */
+		return NULL;
+	}
+	if (geometry->split == geometry->pack_nr)
+		return NULL;
+
+	/*
+	 * The preferred pack is the largest pack above the split line. In
+	 * other words, it is the largest pack that does not get rolled up in
+	 * the geometric repack.
+	 */
+	for (i = geometry->pack_nr; i > geometry->split; i--)
+		/*
+		 * A pack that is not local would never be included in a
+		 * multi-pack index. We thus skip over any non-local packs.
+		 */
+		if (geometry->pack[i - 1]->pack_local)
+			return geometry->pack[i - 1];
+
+	return NULL;
+}
+
+void pack_geometry_remove_redundant(struct pack_geometry *geometry,
+				    struct string_list *names,
+				    struct existing_packs *existing,
+				    const char *packdir)
+{
+	const struct git_hash_algo *algop = existing->repo->hash_algo;
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
+
+	for (i = 0; i < geometry->split; i++) {
+		struct packed_git *p = geometry->pack[i];
+		if (string_list_has_string(names, hash_to_hex_algop(p->hash,
+								    algop)))
+			continue;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if ((p->pack_keep) ||
+		    (string_list_has_string(&existing->kept_packs, buf.buf)))
+			continue;
+
+		repack_remove_redundant_pack(existing->repo, packdir, buf.buf);
+	}
+
+	strbuf_release(&buf);
+}
+
+void pack_geometry_release(struct pack_geometry *geometry)
+{
+	if (!geometry)
+		return;
+
+	free(geometry->pack);
+}
diff --git a/repack.h b/repack.h
index 19dc4fd738..cea7969ae4 100644
--- a/repack.h
+++ b/repack.h
@@ -78,4 +78,24 @@ void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
 			     struct string_list *names, const char *packtmp);
 
+struct pack_geometry {
+	struct packed_git **pack;
+	uint32_t pack_nr, pack_alloc;
+	uint32_t split;
+
+	int split_factor;
+};
+
+void pack_geometry_init(struct pack_geometry *geometry,
+			struct existing_packs *existing,
+			const struct pack_objects_args *args,
+			int pack_kept_objects);
+void pack_geometry_split(struct pack_geometry *geometry);
+struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry);
+void pack_geometry_remove_redundant(struct pack_geometry *geometry,
+				    struct string_list *names,
+				    struct existing_packs *existing,
+				    const char *packdir);
+void pack_geometry_release(struct pack_geometry *geometry);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

