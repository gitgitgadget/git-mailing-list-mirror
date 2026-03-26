Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB232DECA1
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532389; cv=none; b=LL0NerOKcVw4geHfjwVxQ5eofAq4JMW+U7mgJDvgO2pHcB86BJjSQ/b7NATDrH8Pa62dVzAqaQuWz545WvXZszzog4sos9iidKqfKAn3KGhvm3SdwT0/+YEnk5Rbu+sgsuHiJMVmUX+KmKllzT2Q/RCmiao9Fc7bchJHkvhV1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532389; c=relaxed/simple;
	bh=QxU8dowQqAAi/K30rDrsqWw2OZHkHcPdsK3RdOwLUsQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XGfqpHyg9xVf5vHAioXvUMpuVfgY1/nS7RuC+v7PmW6MQrpjiYLSLZ+4vAgwsol3XFzRiXr/Rd9JwvF92TsiozjqKkVup/Qvb7URbGwuS0cKR/l5PH4hx66ceDp/G3Eqk40fmgMiN3fnhqBRT3i9tA+FWooncMV1aSJ32zwuCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEHnc8Gz; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEHnc8Gz"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c160308a54so2500391eec.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774532385; x=1775137185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yTIG3BdS8wF5jUZH2vML44sxZbFLgwFF8sgRz3Co3E=;
        b=YEHnc8GzTKbRl6p07HvbqHw6miPpGTpt96JkphzggmbkZ3uCg8F4I5/+xCCWG+lp6r
         FMkxS/Igt4dOvsBXOMFK/R9l2LvulMWCrMW9FcMkPf5IDSzBUMg7uNfiShDOkIsckhGX
         rYRea4xJryxTvVlV6nvkW4gZyAod4e0/cR1hIf6w5yVndimI8MHT5rFdz7wIQUua1c0a
         e4S0k9/GaDVR+98JVGGZKTRbpr0YHQx3POCLkdR0rx6yIMe4yQ0HAUWfE3jF5+NAO8kC
         x4+1Z1uUMebyO42ni3r/qN7U7LVGwU1q3u87RTMKfHAvp/vGUCohWKS9Ld2JzqzlExGe
         p6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774532385; x=1775137185;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yTIG3BdS8wF5jUZH2vML44sxZbFLgwFF8sgRz3Co3E=;
        b=eM5AQPX6i+YsTW1kjjyuYotYBsjL2HFhAijoX3T35MZH4J5EZA/lEVf/TNSIkGfdGz
         5WDf9mx8p2ALgjLkO3P6t6ySVFFuDCuqsW5ANPYQj5+rjR4f1sbybocTsOCBlNdavqeG
         oq46dUBoCQD76jLWWOM0TbXxzCysJbZPE3Q0q37F+LmFSfQi0KAzu/7ROapd72WhFy60
         AqL86lMlH8Sv7Hc6SkMhZJq4NMGLt6J4mhDt7usuzM48BLbM+1tzmweH8KNCcz3nYhFN
         gxOxVuXq5Y9pQEShCaWQbNw5NlKKDLsiKIcBjOGIF74lSPyJz97Gt2Gd3fHMoIT0mg6H
         rU3g==
X-Gm-Message-State: AOJu0YyebaE64uZgk3hV03yPYM1mE33fhWsZs+6kfDZ6Vy690D2V35nL
	/BCW7hyH5jzKRPzb5lywdiLxfwjJtBg6oq87FEPpPow3kmchEaHlA/1I4C6ZgQ==
X-Gm-Gg: ATEYQzzcHFOtUu0Kg4aMKdTos4gTa/0sKm+3vRwQhIRn7i5rOXBR/s7ohU6XnJGo8Gu
	gjZdz/c71U8qghym21CRxP3rs80NA2VOVoN6d1uE3Tt5qptZOQl3Cg47154H9yycuHwHtY7bStH
	c9vc46d2x0176rMWqXhJQx+Axtlq6JcfCv7+hd+i69w0x1/Q3m4HLBwiS+MTnxv4NG/liOX/8n1
	rRHBvUj9vcpxmp8Jj2JpHjpZIcBvrTrehKaN5EuJpjqH2AfcToVMN7DDlvOIVZfLDBp98v+M/Uw
	xPO9BVBBLyHRa6tF1YYrQn538IYAQ8YG0AOsaGpXK1Kopx91PRiPOq4jHnvxhSE35V78nL5xUfw
	eg8sBXjATZbVoKcTEH1tcA2qyxagijq7n0LjbXY6FwJ8Xc0PCX4gVTvstEzvftR/5DePY1y24d8
	tDxNEKFVPUW7bMxxGl/F5gmjo6885oN52jVJ0=
X-Received: by 2002:a05:7022:78e:b0:11b:9b9f:426b with SMTP id a92af1059eb24-12a96ed357fmr3991514c88.20.1774532384919;
        Thu, 26 Mar 2026 06:39:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.45.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6513e9bsm4632550c88.0.2026.03.26.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:39:44 -0700 (PDT)
Message-Id: <pull.2074.v2.git.1774532383055.gitgitgadget@gmail.com>
In-Reply-To: <pull.2074.git.1774530437562.gitgitgadget@gmail.com>
References: <pull.2074.git.1774530437562.gitgitgadget@gmail.com>
From: "Aaron Paterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 13:39:43 +0000
Subject: [PATCH v2] odb: add write_packfile, for_each_unique_abbrev,
 convert_object_id
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
Cc: Aaron Paterson <apaterson@pm.me>,
    Aaron Paterson <apaterson@pm.me>

From: Aaron Paterson <apaterson@pm.me>

Add three vtable methods to odb_source that were not part of the
recent ps/odb-sources and ps/object-counting series:

 - write_packfile: ingest a pack from a file descriptor. The files
   backend chooses between index-pack (large packs) and
   unpack-objects (small packs below fetch.unpackLimit). Options
   cover thin-pack fixing, promisor marking, fsck, lockfile
   capture, and shallow file passing.

 - for_each_unique_abbrev: iterate objects matching a hex prefix
   for disambiguation. Searches loose objects via oidtree, then
   multi-pack indices, then non-MIDX packs.

 - convert_object_id: translate between hash algorithms using the
   loose object map. Used during SHA-1 to SHA-256 migration.

Also add ODB_SOURCE_HELPER to the source type enum, preparing for
the helper backend in the next commit.

The write_packfile vtable method replaces the pattern where callers
spawn index-pack/unpack-objects directly. fast-import already uses
odb_write_packfile() and this allows non-files backends to handle
pack ingestion through their own mechanism.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
    odb: add write_packfile, for_each_unique_abbrev, convert_object_id
    
    This adds three ODB source vtable methods that were not part of the
    recent ps/odb-sources and ps/object-counting series, plus caller routing
    for object-name.c and fast-import.c.
    
    New vtable methods:
    
     * write_packfile: Ingest a pack from a file descriptor. The files
       backend chooses between index-pack (large packs) and unpack-objects
       (small packs below fetch.unpackLimit). Options cover thin-pack
       fixing, promisor marking, fsck, lockfile capture, and shallow file
       passing. Non-files backends can handle pack ingestion through their
       own mechanism.
    
     * for_each_unique_abbrev: Iterate objects matching a hex prefix for
       disambiguation. The files backend searches loose objects via oidtree,
       multi-pack indices, then non-MIDX packs.
    
     * convert_object_id: Translate between hash algorithms using the loose
       object map. Used during SHA-1 to SHA-256 migration.
    
    Caller routing:
    
     * object-name.c: The abbreviation and disambiguation paths
       (find_short_object_filename, find_abbrev_len_packed, and
       find_short_packed_object) directly access files-backend internals
       (loose cache, pack store, MIDX). These are converted to dispatch
       through the for_each_unique_abbrev vtable method, so that non-files
       backends participate through proper abstraction rather than being
       skipped.
    
     * fast-import.c: end_packfile() replaced direct pack indexing,
       registration, and odb_source_files_downcast() with a call to
       odb_write_packfile(). gfi_unpack_entry() falls back to
       odb_read_object() when the pack slot is NULL (non-files backends
       ingest packs without registering them on disk).
    
    This addresses Patrick's feedback on the previous submission [1]: the
    correct fix for downcast sites is proper vtable abstraction, not
    skipping non-files backends.
    
    Additional:
    
     * ODB_SOURCE_HELPER added to the source type enum
     * odb/source-type.h extracted to avoid circular includes with
       repository.h
     * OBJECT_INFO_KEPT_ONLY flag for backends that track kept status
     * self_contained_out output field on odb_write_packfile_options
    
    Motivation: These methods are needed by the local helper backend series
    (Series 2) [2], which delegates object and reference storage to external
    git-local- helper processes. sqlite-git [3] is a working proof of
    concept that stores objects, refs, and reflogs in a single SQLite
    database with full worktree support.
    
    CC: Junio C Hamano gitster@pobox.com, Patrick Steinhardt ps@pks.im
    
    [1] https://github.com/gitgitgadget/git/pull/2068.patch [2]
    https://github.com/gitgitgadget/git/compare/master...MayCXC:git:ps/series-2-helpers-v3.patch
    [3] https://github.com/MayCXC/sqlite-git

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2074%2FMayCXC%2Fps%2Fseries-1-vtable-v3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2074/MayCXC/ps/series-1-vtable-v3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2074

Range-diff vs v1:

 1:  146c7ed0b2 ! 1:  5b3e9a8298 odb: add write_packfile, for_each_unique_abbrev, convert_object_id
     @@ Commit message
      
          Signed-off-by: Aaron Paterson <apaterson@pm.me>
      
     + ## builtin/fast-import.c ##
     +@@ builtin/fast-import.c: static void end_packfile(void)
     + 	running = 1;
     + 	clear_delta_base_cache();
     + 	if (object_count) {
     +-		struct odb_source_files *files = odb_source_files_downcast(pack_data->repo->objects->sources);
     +-		struct packed_git *new_p;
     + 		struct object_id cur_pack_oid;
     +-		char *idx_name;
     + 		int i;
     + 		struct branch *b;
     + 		struct tag *t;
     +@@ builtin/fast-import.c: static void end_packfile(void)
     + 					 object_count, cur_pack_oid.hash,
     + 					 pack_size);
     + 
     +-		if (object_count <= unpack_limit) {
     +-			if (!loosen_small_pack(pack_data)) {
     +-				invalidate_pack_id(pack_id);
     +-				goto discard_pack;
     +-			}
     +-		}
     ++		if (lseek(pack_data->pack_fd, 0, SEEK_SET) < 0)
     ++			die_errno(_("failed seeking to start of '%s'"),
     ++				  pack_data->pack_name);
     + 
     +-		close(pack_data->pack_fd);
     +-		idx_name = keep_pack(create_index());
     ++		if (odb_write_packfile(the_repository->objects,
     ++				       pack_data->pack_fd, NULL))
     ++			die(_("failed to ingest pack"));
     + 
     +-		/* Register the packfile with core git's machinery. */
     +-		new_p = packfile_store_load_pack(files->packed, idx_name, 1);
     +-		if (!new_p)
     +-			die(_("core Git rejected index %s"), idx_name);
     +-		all_packs[pack_id] = new_p;
     +-		free(idx_name);
     ++		/*
     ++		 * Non-files backends do not register a pack on disk,
     ++		 * so NULL out the slot to prevent use-after-free in
     ++		 * gfi_unpack_entry.
     ++		 */
     ++		all_packs[pack_id] = NULL;
     + 
     + 		/* Print the boundary */
     + 		if (pack_edges) {
     +-			fprintf(pack_edges, "%s:", new_p->pack_name);
     ++			fprintf(pack_edges, "pack-%s:",
     ++				hash_to_hex(pack_data->hash));
     + 			for (i = 0; i < branch_table_sz; i++) {
     + 				for (b = branch_table[i]; b; b = b->table_next_branch) {
     + 					if (b->pack_id == pack_id)
     +@@ builtin/fast-import.c: static void *gfi_unpack_entry(
     + {
     + 	enum object_type type;
     + 	struct packed_git *p = all_packs[oe->pack_id];
     ++	if (!p) {
     ++		/*
     ++		 * Pack was ingested by a non-files backend via
     ++		 * odb_write_packfile() and is no longer on disk.
     ++		 * Read the object back through the ODB instead.
     ++		 */
     ++		enum object_type type;
     ++		enum object_type odb_type;
     ++		return odb_read_object(the_repository->objects,
     ++				       &oe->idx.oid, &odb_type, sizep);
     ++	}
     + 	if (p == pack_data && p->pack_size < (pack_size + the_hash_algo->rawsz)) {
     + 		/* The object is stored in the packfile we are writing to
     + 		 * and we have modified it since the last time we scanned
     +
       ## object-name.c ##
      @@
       #include "packfile.h"
     @@ odb.c: int odb_write_object_stream(struct object_database *odb,
       				const char *secondary_sources)
      
       ## odb.h ##
     -@@ odb.h: enum object_info_flags {
     - 	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
     - 	 */
     - 	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
     -+
     -+	/*
     -+	 * Only consider objects marked as "kept" (surviving GC). Used by
     -+	 * helper backends that track kept status per object. Backends that
     -+	 * do not support kept tracking should return -1 (not found).
     -+	 */
     -+	OBJECT_INFO_KEPT_ONLY = (1 << 5),
     - };
     - 
     - /*
      @@ odb.h: int odb_write_object_stream(struct object_database *odb,
       			    struct odb_write_stream *stream, size_t len,
       			    struct object_id *oid);


 builtin/fast-import.c |  43 ++++---
 object-name.c         |  79 ++++++++++---
 odb.c                 |  26 +++++
 odb.h                 |  19 ++++
 odb/source-files.c    | 259 ++++++++++++++++++++++++++++++++++++++++++
 odb/source.h          | 108 ++++++++++++++++++
 6 files changed, 498 insertions(+), 36 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9fc6c35b74..160495d9b1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -876,10 +876,7 @@ static void end_packfile(void)
 	running = 1;
 	clear_delta_base_cache();
 	if (object_count) {
-		struct odb_source_files *files = odb_source_files_downcast(pack_data->repo->objects->sources);
-		struct packed_git *new_p;
 		struct object_id cur_pack_oid;
-		char *idx_name;
 		int i;
 		struct branch *b;
 		struct tag *t;
@@ -891,26 +888,25 @@ static void end_packfile(void)
 					 object_count, cur_pack_oid.hash,
 					 pack_size);
 
-		if (object_count <= unpack_limit) {
-			if (!loosen_small_pack(pack_data)) {
-				invalidate_pack_id(pack_id);
-				goto discard_pack;
-			}
-		}
+		if (lseek(pack_data->pack_fd, 0, SEEK_SET) < 0)
+			die_errno(_("failed seeking to start of '%s'"),
+				  pack_data->pack_name);
 
-		close(pack_data->pack_fd);
-		idx_name = keep_pack(create_index());
+		if (odb_write_packfile(the_repository->objects,
+				       pack_data->pack_fd, NULL))
+			die(_("failed to ingest pack"));
 
-		/* Register the packfile with core git's machinery. */
-		new_p = packfile_store_load_pack(files->packed, idx_name, 1);
-		if (!new_p)
-			die(_("core Git rejected index %s"), idx_name);
-		all_packs[pack_id] = new_p;
-		free(idx_name);
+		/*
+		 * Non-files backends do not register a pack on disk,
+		 * so NULL out the slot to prevent use-after-free in
+		 * gfi_unpack_entry.
+		 */
+		all_packs[pack_id] = NULL;
 
 		/* Print the boundary */
 		if (pack_edges) {
-			fprintf(pack_edges, "%s:", new_p->pack_name);
+			fprintf(pack_edges, "pack-%s:",
+				hash_to_hex(pack_data->hash));
 			for (i = 0; i < branch_table_sz; i++) {
 				for (b = branch_table[i]; b; b = b->table_next_branch) {
 					if (b->pack_id == pack_id)
@@ -1239,6 +1235,17 @@ static void *gfi_unpack_entry(
 {
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
+	if (!p) {
+		/*
+		 * Pack was ingested by a non-files backend via
+		 * odb_write_packfile() and is no longer on disk.
+		 * Read the object back through the ODB instead.
+		 */
+		enum object_type type;
+		enum object_type odb_type;
+		return odb_read_object(the_repository->objects,
+				       &oe->idx.oid, &odb_type, sizep);
+	}
 	if (p == pack_data && p->pack_size < (pack_size + the_hash_algo->rawsz)) {
 		/* The object is stored in the packfile we are writing to
 		 * and we have modified it since the last time we scanned
diff --git a/object-name.c b/object-name.c
index e5adec4c9d..8f503b985f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -20,6 +20,7 @@
 #include "packfile.h"
 #include "pretty.h"
 #include "object-file.h"
+#include "odb/source.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
@@ -111,13 +112,28 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
 	return ds->ambiguous ? CB_BREAK : CB_CONTINUE;
 }
 
+static int disambiguate_cb(const struct object_id *oid,
+			   struct object_info *oi UNUSED, void *data)
+{
+	struct disambiguate_state *ds = data;
+	update_candidates(ds, oid);
+	return ds->ambiguous ? 1 : 0;
+}
+
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct odb_source *source;
 
-	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
-				&ds->bin_pfx, ds->len, match_prefix, ds);
+	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
+		if (source->for_each_unique_abbrev) {
+			odb_source_for_each_unique_abbrev(
+				source, &ds->bin_pfx, ds->len,
+				disambiguate_cb, ds);
+		} else {
+			oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
+					&ds->bin_pfx, ds->len, match_prefix, ds);
+		}
+	}
 }
 
 static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
@@ -208,15 +224,23 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 
 	odb_prepare_alternates(ds->repo->objects);
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
-		if (m)
-			unique_in_midx(m, ds);
+		if (source->for_each_unique_abbrev) {
+			odb_source_for_each_unique_abbrev(
+				source, &ds->bin_pfx, ds->len,
+				disambiguate_cb, ds);
+		} else {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				unique_in_midx(m, ds);
+		}
 	}
 
-	repo_for_each_pack(ds->repo, p) {
-		if (ds->ambiguous)
-			break;
-		unique_in_pack(p, ds);
+	if (!ds->repo->objects->sources->for_each_unique_abbrev) {
+		repo_for_each_pack(ds->repo, p) {
+			if (ds->ambiguous)
+				break;
+			unique_in_pack(p, ds);
+		}
 	}
 }
 
@@ -796,19 +820,38 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	mad->init_len = mad->cur_len;
 }
 
-static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+static int abbrev_len_cb(const struct object_id *oid,
+			 struct object_info *oi UNUSED, void *data)
 {
-	struct packed_git *p;
+	struct min_abbrev_data *mad = data;
+	extend_abbrev_len(oid, mad);
+	return 0;
+}
 
+static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+{
 	odb_prepare_alternates(mad->repo->objects);
-	for (struct odb_source *source = mad->repo->objects->sources; source; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
-		if (m)
-			find_abbrev_len_for_midx(m, mad);
+
+	for (struct odb_source *source = mad->repo->objects->sources;
+	     source; source = source->next) {
+		if (source->for_each_unique_abbrev) {
+			mad->init_len = 0;
+			odb_source_for_each_unique_abbrev(
+				source, mad->oid, mad->cur_len,
+				abbrev_len_cb, mad);
+			mad->init_len = mad->cur_len;
+		} else {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				find_abbrev_len_for_midx(m, mad);
+		}
 	}
 
-	repo_for_each_pack(mad->repo, p)
-		find_abbrev_len_for_pack(p, mad);
+	if (!mad->repo->objects->sources->for_each_unique_abbrev) {
+		struct packed_git *p;
+		repo_for_each_pack(mad->repo, p)
+			find_abbrev_len_for_pack(p, mad);
+	}
 }
 
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
diff --git a/odb.c b/odb.c
index 350e23f3c0..3032d5492c 100644
--- a/odb.c
+++ b/odb.c
@@ -981,6 +981,32 @@ int odb_write_object_stream(struct object_database *odb,
 	return odb_source_write_object_stream(odb->sources, stream, len, oid);
 }
 
+int odb_write_packfile(struct object_database *odb,
+		       int pack_fd,
+		       struct odb_write_packfile_options *opts)
+{
+	return odb_source_write_packfile(odb->sources, pack_fd, opts);
+}
+
+int odb_for_each_unique_abbrev(struct object_database *odb,
+			       const struct object_id *oid_prefix,
+			       unsigned int prefix_len,
+			       odb_for_each_object_cb cb,
+			       void *cb_data)
+{
+	int ret;
+
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		ret = odb_source_for_each_unique_abbrev(source, oid_prefix,
+							prefix_len, cb, cb_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 struct object_database *odb_new(struct repository *repo,
 				const char *primary_source,
 				const char *secondary_sources)
diff --git a/odb.h b/odb.h
index 9aee260105..b7f1a24006 100644
--- a/odb.h
+++ b/odb.h
@@ -570,6 +570,25 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
 			    struct object_id *oid);
 
+/*
+ * Ingest a pack from a file descriptor into the primary source.
+ * Returns 0 on success, a negative error code otherwise.
+ */
+struct odb_write_packfile_options;
+int odb_write_packfile(struct object_database *odb,
+		       int pack_fd,
+		       struct odb_write_packfile_options *opts);
+
+/*
+ * Iterate over all objects across all sources whose ID starts with
+ * the given prefix. Used for object name disambiguation.
+ */
+int odb_for_each_unique_abbrev(struct object_database *odb,
+			       const struct object_id *oid_prefix,
+			       unsigned int prefix_len,
+			       odb_for_each_object_cb cb,
+			       void *cb_data);
+
 void parse_alternates(const char *string,
 		      int sep,
 		      const char *relative_base,
diff --git a/odb/source-files.c b/odb/source-files.c
index c08d8993e3..e450c87f91 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,14 +1,21 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "config.h"
 #include "gettext.h"
 #include "lockfile.h"
+#include "loose.h"
+#include "midx.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
+#include "pack-objects.h"
 #include "packfile.h"
+#include "run-command.h"
 #include "strbuf.h"
+#include "strvec.h"
+#include "oidtree.h"
 #include "write-or-die.h"
 
 static void odb_source_files_reparent(const char *name UNUSED,
@@ -232,6 +239,255 @@ out:
 	return ret;
 }
 
+static int odb_source_files_write_packfile(struct odb_source *source,
+					   int pack_fd,
+					   struct odb_write_packfile_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	int fsck_objects = 0;
+	int use_index_pack = 1;
+	int ret;
+
+	if (opts && opts->nr_objects) {
+		int transfer_unpack_limit = -1;
+		int fetch_unpack_limit = -1;
+		int unpack_limit = 100;
+
+		repo_config_get_int(source->odb->repo, "fetch.unpacklimit",
+				    &fetch_unpack_limit);
+		repo_config_get_int(source->odb->repo, "transfer.unpacklimit",
+				    &transfer_unpack_limit);
+		if (0 <= fetch_unpack_limit)
+			unpack_limit = fetch_unpack_limit;
+		else if (0 <= transfer_unpack_limit)
+			unpack_limit = transfer_unpack_limit;
+
+		if (opts->nr_objects < (unsigned int)unpack_limit &&
+		    !opts->from_promisor && !opts->lockfile_out)
+			use_index_pack = 0;
+	}
+
+	cmd.in = pack_fd;
+	cmd.git_cmd = 1;
+
+	if (!use_index_pack) {
+		strvec_push(&cmd.args, "unpack-objects");
+		if (opts && opts->quiet)
+			strvec_push(&cmd.args, "-q");
+		if (opts && opts->pack_header_version)
+			strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
+				     opts->pack_header_version,
+				     opts->pack_header_entries);
+		repo_config_get_bool(source->odb->repo, "transfer.fsckobjects",
+				     &fsck_objects);
+		repo_config_get_bool(source->odb->repo, "receive.fsckobjects",
+				     &fsck_objects);
+		if (fsck_objects)
+			strvec_push(&cmd.args, "--strict");
+		if (opts && opts->max_input_size)
+			strvec_pushf(&cmd.args, "--max-input-size=%lu",
+				     opts->max_input_size);
+		ret = run_command(&cmd);
+		if (ret)
+			return error(_("unpack-objects failed"));
+		return 0;
+	}
+
+	strvec_push(&cmd.args, "index-pack");
+	strvec_push(&cmd.args, "--stdin");
+	strvec_push(&cmd.args, "--keep=write_packfile");
+
+	if (opts && opts->pack_header_version)
+		strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
+			     opts->pack_header_version,
+			     opts->pack_header_entries);
+
+	if (opts) {
+		if (opts->use_thin_pack)
+			strvec_push(&cmd.args, "--fix-thin");
+		if (opts->from_promisor)
+			strvec_push(&cmd.args, "--promisor");
+		if (opts->check_self_contained)
+			strvec_push(&cmd.args, "--check-self-contained-and-connected");
+		if (opts->max_input_size)
+			strvec_pushf(&cmd.args, "--max-input-size=%lu",
+				     opts->max_input_size);
+		if (opts->shallow_file)
+			strvec_pushf(&cmd.env, "GIT_SHALLOW_FILE=%s",
+				     opts->shallow_file);
+		if (opts->report_end_of_input)
+			strvec_push(&cmd.args, "--report-end-of-input");
+		if (opts->fsck_objects)
+			fsck_objects = 1;
+	}
+
+	if (!fsck_objects) {
+		repo_config_get_bool(source->odb->repo, "transfer.fsckobjects",
+				     &fsck_objects);
+		repo_config_get_bool(source->odb->repo, "fetch.fsckobjects",
+				     &fsck_objects);
+	}
+	if (fsck_objects)
+		strvec_push(&cmd.args, "--strict");
+
+	if (opts && opts->lockfile_out) {
+		cmd.out = -1;
+		ret = start_command(&cmd);
+		if (ret)
+			return error(_("index-pack failed to start"));
+		*opts->lockfile_out = index_pack_lockfile(source->odb->repo,
+							  cmd.out, NULL);
+		close(cmd.out);
+		ret = finish_command(&cmd);
+	} else {
+		ret = run_command(&cmd);
+	}
+
+	if (ret)
+		return error(_("index-pack failed"));
+
+	if (opts && opts->check_self_contained)
+		opts->self_contained_out = 1;
+
+	packfile_store_reprepare(files->packed);
+	return 0;
+}
+
+static int match_hash_prefix(unsigned len, const unsigned char *a,
+			     const unsigned char *b)
+{
+	while (len > 1) {
+		if (*a != *b)
+			return 0;
+		a++; b++; len -= 2;
+	}
+	if (len)
+		if ((*a ^ *b) & 0xf0)
+			return 0;
+	return 1;
+}
+
+struct abbrev_cb_data {
+	odb_for_each_object_cb cb;
+	void *cb_data;
+	int ret;
+};
+
+static enum cb_next abbrev_loose_cb(const struct object_id *oid, void *data)
+{
+	struct abbrev_cb_data *d = data;
+	d->ret = d->cb(oid, NULL, d->cb_data);
+	return d->ret ? CB_BREAK : CB_CONTINUE;
+}
+
+static int odb_source_files_for_each_unique_abbrev(struct odb_source *source,
+						   const struct object_id *oid_prefix,
+						   unsigned int prefix_len,
+						   odb_for_each_object_cb cb,
+						   void *cb_data)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct multi_pack_index *m;
+	struct packfile_list_entry *entry;
+	unsigned int hexsz = source->odb->repo->hash_algo->hexsz;
+	unsigned int len = prefix_len > hexsz ? hexsz : prefix_len;
+
+	/* Search loose objects */
+	{
+		struct oidtree *tree = odb_source_loose_cache(source, oid_prefix);
+		if (tree) {
+			struct abbrev_cb_data d = { cb, cb_data, 0 };
+			oidtree_each(tree, oid_prefix, prefix_len, abbrev_loose_cb, &d);
+			if (d.ret)
+				return d.ret;
+		}
+	}
+
+	/* Search multi-pack indices */
+	m = get_multi_pack_index(source);
+	for (; m; m = m->base_midx) {
+		uint32_t num, i, first = 0;
+
+		if (!m->num_objects)
+			continue;
+
+		num = m->num_objects + m->num_objects_in_base;
+		bsearch_one_midx(oid_prefix, m, &first);
+
+		for (i = first; i < num; i++) {
+			struct object_id oid;
+			const struct object_id *current;
+			int ret;
+
+			current = nth_midxed_object_oid(&oid, m, i);
+			if (!match_hash_prefix(len, oid_prefix->hash, current->hash))
+				break;
+			ret = cb(current, NULL, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Search packs not covered by MIDX */
+	for (entry = packfile_store_get_packs(files->packed); entry; entry = entry->next) {
+		struct packed_git *p = entry->pack;
+		uint32_t num, i, first = 0;
+
+		if (p->multi_pack_index)
+			continue;
+		if (open_pack_index(p) || !p->num_objects)
+			continue;
+
+		num = p->num_objects;
+		bsearch_pack(oid_prefix, p, &first);
+
+		for (i = first; i < num; i++) {
+			struct object_id oid;
+			int ret;
+
+			nth_packed_object_id(&oid, p, i);
+			if (!match_hash_prefix(len, oid_prefix->hash, oid.hash))
+				break;
+			ret = cb(&oid, NULL, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int odb_source_files_convert_object_id(struct odb_source *source,
+					      const struct object_id *src,
+					      const struct git_hash_algo *to,
+					      struct object_id *dest)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct loose_object_map *map;
+	kh_oid_map_t *hash_map;
+	khiter_t pos;
+
+	if (!files->loose || !files->loose->map)
+		return -1;
+
+	map = files->loose->map;
+
+	if (to == source->odb->repo->compat_hash_algo)
+		hash_map = map->to_compat;
+	else if (to == source->odb->repo->hash_algo)
+		hash_map = map->to_storage;
+	else
+		return -1;
+
+	pos = kh_get_oid_map(hash_map, *src);
+	if (pos == kh_end(hash_map))
+		return -1;
+
+	oidcpy(dest, kh_value(hash_map, pos));
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -256,6 +512,9 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.begin_transaction = odb_source_files_begin_transaction;
 	files->base.read_alternates = odb_source_files_read_alternates;
 	files->base.write_alternate = odb_source_files_write_alternate;
+	files->base.write_packfile = odb_source_files_write_packfile;
+	files->base.for_each_unique_abbrev = odb_source_files_for_each_unique_abbrev;
+	files->base.convert_object_id = odb_source_files_convert_object_id;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 96c906e7a1..8b898f80ed 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -13,12 +13,42 @@ enum odb_source_type {
 
 	/* The "files" backend that uses loose objects and packfiles. */
 	ODB_SOURCE_FILES,
+
+	/* An external helper process (git-local-<name>). */
+	ODB_SOURCE_HELPER,
 };
 
 struct object_id;
 struct odb_read_stream;
 struct strvec;
 
+/*
+ * Options for write_packfile. When NULL is passed, the backend
+ * uses sensible defaults.
+ */
+struct odb_write_packfile_options {
+	unsigned int nr_objects;
+	uint32_t pack_header_version;
+	uint32_t pack_header_entries;
+	int use_thin_pack;
+	int from_promisor;
+	int fsck_objects;
+	int check_self_contained;
+	unsigned long max_input_size;
+	int quiet;
+	int show_progress;
+	int report_end_of_input;
+	const char *shallow_file;
+	char **lockfile_out;
+
+	/*
+	 * Output: set to 1 by the backend if the ingested pack was
+	 * verified as self-contained (all referenced objects present).
+	 * Used by the transport layer to skip connectivity checks.
+	 */
+	int self_contained_out;
+};
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -237,6 +267,45 @@ struct odb_source {
 	 */
 	int (*write_alternate)(struct odb_source *source,
 			       const char *alternate);
+
+	/*
+	 * Ingest a pack from a file descriptor. Each backend chooses
+	 * its own ingestion strategy:
+	 *
+	 *   - The files backend spawns index-pack (large packs) or
+	 *     unpack-objects (small packs), then registers the result.
+	 *
+	 *   - Non-files backends may parse the pack and write each
+	 *     object individually through write_object.
+	 *
+	 * Returns 0 on success, a negative error code otherwise.
+	 */
+	int (*write_packfile)(struct odb_source *source,
+			      int pack_fd,
+			      struct odb_write_packfile_options *opts);
+
+	/*
+	 * Iterate over all objects whose object ID starts with the
+	 * given prefix. Used for object name disambiguation.
+	 *
+	 * Returns 0 on success, a negative error code in case
+	 * iteration has failed, or a non-zero value from the callback.
+	 */
+	int (*for_each_unique_abbrev)(struct odb_source *source,
+				      const struct object_id *oid_prefix,
+				      unsigned int prefix_len,
+				      odb_for_each_object_cb cb,
+				      void *cb_data);
+
+	/*
+	 * Translate an object ID from one hash algorithm to another
+	 * using the source's internal mapping (for SHA-1/SHA-256
+	 * migration). Returns 0 on success, -1 if no mapping exists.
+	 */
+	int (*convert_object_id)(struct odb_source *source,
+				 const struct object_id *src,
+				 const struct git_hash_algo *to,
+				 struct object_id *dest);
 };
 
 /*
@@ -442,4 +511,43 @@ static inline int odb_source_begin_transaction(struct odb_source *source,
 	return source->begin_transaction(source, out);
 }
 
+/*
+ * Ingest a pack from a file descriptor into the given source. Returns 0 on
+ * success, a negative error code otherwise.
+ */
+static inline int odb_source_write_packfile(struct odb_source *source,
+					    int pack_fd,
+					    struct odb_write_packfile_options *opts)
+{
+	return source->write_packfile(source, pack_fd, opts);
+}
+
+/*
+ * Iterate over all objects in the source whose ID starts with the given
+ * prefix. Used for object name disambiguation.
+ */
+static inline int odb_source_for_each_unique_abbrev(struct odb_source *source,
+						    const struct object_id *oid_prefix,
+						    unsigned int prefix_len,
+						    odb_for_each_object_cb cb,
+						    void *cb_data)
+{
+	return source->for_each_unique_abbrev(source, oid_prefix, prefix_len,
+					      cb, cb_data);
+}
+
+/*
+ * Translate an object ID between hash algorithms using the source's mapping.
+ * Returns 0 on success, -1 if no mapping exists.
+ */
+static inline int odb_source_convert_object_id(struct odb_source *source,
+					       const struct object_id *src,
+					       const struct git_hash_algo *to,
+					       struct object_id *dest)
+{
+	if (!source->convert_object_id)
+		return -1;
+	return source->convert_object_id(source, src, to, dest);
+}
+
 #endif

base-commit: 41688c1a2312f62f44435e1a6d03b4b904b5b0ec
-- 
gitgitgadget
