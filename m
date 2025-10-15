Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A30DEDA
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567332; cv=none; b=C0wxwCgrmUzQi6eVFODeIzDGNB5U8BNKqtcGvCocHGO1tJnIaT4sh6a4/U3o7W5pNbOV6fp0uS4WoAN8k+FdsmXNaeljDpiDHx2tIk+KI/ToT/crLHm+W6x6zob29qCKT5xYCPO1T4Y72tsTp8AlFx9ZN8eVzNZvA+8//KW2crU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567332; c=relaxed/simple;
	bh=DGiq22DESV5UvXwpqdgtAY85WTmilr7nMPGz3gVMS28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZXQZ4j13aupOZyd7HdczUr1YcMK2RkTSlqHncgR8neRcOTRYBGDqhsMzBgaEfi/ZPZPDMKanS+r/Ha194W2JD8Ic8uz334pmiMPJE2A7TvUUsHkvsomiFD2xCw+xvKPOQOHrzNJnmmo61rpge/10BkQ2owAdJErgRuyHQrDl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=U1tlqVLh; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="U1tlqVLh"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63bc1aeb427so126341d50.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567329; x=1761172129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COo6IQgQujcy+qcEpO1W1xBY1cF7IfmWQOPWM1YhGYY=;
        b=U1tlqVLh0arwUfqdbf2wiS/qYsfHNrD0Pwj/L+Xe0fa8Toz/6eIsWPzy5sX1YuvICq
         /MB3M3Hsghq4Q+DuQEOfbCqVC0Lq9FJI0Mo9ikmmpbc6v0bnlGVEoYrm3+zXMsOK38t1
         Ku9QDnSYkF2JvGvEYT+IGMjycCom0rJTTfoKghe/JB/rIPppSHwrTkpd5m7KvBq8IXqV
         PGXYFxStgUeRrC3WlAdiJgLhydZG/rMq6KElmyIsqF76asYLNvpNVAv5nr3kjQsO5NoK
         ll83r4kcKkPPtRleCqmcxyVFPZfJg7t3xTMbiO5oiUm2Jg48BkfUrotFzfgQgYDScHBY
         CqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567329; x=1761172129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COo6IQgQujcy+qcEpO1W1xBY1cF7IfmWQOPWM1YhGYY=;
        b=fR9og7O+FOv275gv9f1xnMd21k7s1dCg0KveigvRXj08MCYQG61s52dWqeeEcIx1jl
         YPbJ1k7skQ963xjoP8VhgcbZwZZ2J6iiTwBPeAllfNzWFkGX504yH4/CJZtJqlGVAXM0
         SBD+9LYH0VgRCJRXs3cTNJLsWPhcdSANlBF5PozfA9ITs3Nirbjqo9++PMfj4G8U/5ar
         K2+OpmxKNhIJSkEEO9Gd1qZjQiaNUWpUI0RsijrE5o6RHZfJz7retW/w/Taf9L5wzD8V
         a+heHHjT/+MH6cxF8CpnCKxc5GCr2bNIdmjTBPUhJboMSvJHq/z/439Fxo0CJLYPTCSb
         q0Eg==
X-Gm-Message-State: AOJu0YyAe2s4FnbKswWJ8tc4HTSAfhziopHS7sOikJRCyLrhey891d9m
	Q1IHRQDGBLo80VehGUc1+iaXt+7eAEbBSpU5bHY11VRyjMc8DefSgxDN6FippEdrIH2A7NHg5/8
	SUhD6J1wHJg==
X-Gm-Gg: ASbGncthf/DQ6NLib3SdPQ8Iw+ExfGZgpUhFFQMzKbAPLsHctpU16acpIOQhAkf//nd
	2Q5Jhfa97ag7JOre3Fz44EJMgKVTRVqHwxQZxI2qIl42r03uXsBz6wo+4uO4Fb7tsyVfU7uOaBv
	vmyzxrRF+YgR1UAoyIA00gp860TSPt9fG1Vuc5o2oV2NowEdu55OlIw578C4L2p9o3e1oS/+gWU
	5+TQOIrYf3HFm7XcIPzUhBmsXbGFaPiZQULztlIVwg3SN5fyb9q9rZuaUFRFyEo2UzKUnpB+ZaA
	xLJAavfhFdVey5Yw+QksNxqqUWb4WtZVH7Ilbxd0wH7DX+IvMSyXmXV+uqa8U+flFAxtbB5Jhim
	1F4OZOZib15nCZa7u+VEU9CeLnrqaTjd/QMjtv3bAe2zotzXmoXqX1MN6JB1I3a5B2noD4p+BN9
	ROfg5S6IOWnFU8LkZ9oKoaA3wl+jatzWG3CAY5TtffdEec2eQuWlmgRGt4JHYgpgTTnE1+jdjA0
	2wA63PSsz/jfi1PTg==
X-Google-Smtp-Source: AGHT+IETpKO5EWzZSgWFTaP2XGhk/iB3L850Soj/rCUe8IIo3Nv6J/xpkGl/LPR5kKF57bLs1jPBvg==
X-Received: by 2002:a05:690e:155a:20b0:63c:ee51:5cf6 with SMTP id 956f58d0204a3-63cee516112mr14774627d50.15.1760567328686;
        Wed, 15 Oct 2025 15:28:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d2c2adesm2763557b3.14.2025.10.15.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:48 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 30/49] repack: remove pack_geometry API from the builtin
Message-ID: <9172e9a515084a1b513b004d71acefcf3fb68dda.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Now that the pack_geometry API is fully factored and isolated from the
rest of the builtin, declare it within repack.h and move its
implementation to "repack-geometry.c" as a separate component.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile          |   1 +
 builtin/repack.c  | 235 ----------------------------------------------
 meson.build       |   1 +
 repack-geometry.c | 234 +++++++++++++++++++++++++++++++++++++++++++++
 repack.h          |  20 ++++
 5 files changed, 256 insertions(+), 235 deletions(-)
 create mode 100644 repack-geometry.c

diff --git a/Makefile b/Makefile
index 01597af359..a1ccac235d 100644
--- a/Makefile
+++ b/Makefile
@@ -1250,6 +1250,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
diff --git a/builtin/repack.c b/builtin/repack.c
index f6d04b33a7..e2313c80c3 100644
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
index b37e3d192d..9afd45ea45 100644
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
index 0000000000..f58f1fc7f0
--- /dev/null
+++ b/repack-geometry.c
@@ -0,0 +1,234 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "git-compat-util.h"
+#include "repack.h"
+#include "repository.h"
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
2.51.0.540.ga7423965ad8

