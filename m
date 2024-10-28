Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61B1DD539
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123034; cv=none; b=Eg0uYCMrbEL1FxerANrzC9cOm2DAGMEUco0BRm5DYtisPLPFHKUj+/07AhJ3LLgpKEi9qCluJlYpZJvId74PHcP8Bgq2cOTfw3JGUPrjzKTSMQ6no2aWM9CDueFCWbQVsc+gJ1xmzwqBIpoNFQqj8/4jLIqso9ydOiF6mvlr9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123034; c=relaxed/simple;
	bh=z19Oq4pnZz7ppxOBH38zLkvw77SaE17qbsAQu1uI+5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTSQXUtuWWjmHs3xuCRixr72LDI39JIG8CPcY2Ny16xn9bm0L7SsDN+3lvIDCpDS85qehoqCuqkWNbjpbDq0pxbXB4Ryk3GEbzMI+IzR+pX4Ty9pzlcOz24C3TbUcGvE/wo2RJ0TlbMEn4f9z/J/lht7dDdQ0f4RD028pWSlJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn597m42; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn597m42"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so642337766b.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123030; x=1730727830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAuvSPeqFzuf7N0J+GgrXDDctr3GZBniB+C01KKKdUI=;
        b=gn597m4224YwcM527/7ER12oahKcNgpPISlt5owJez4aB/2vuRxHxbwku5k0A5AttF
         0YWV9hWIUbgle+LEpqlmfV8+y8R6zvt/ilcHAlLZ33Hjv7D007ufNLgdtrF7soWlVold
         viqiWHNeee3bBbz+m5a73ufNRkDJVJdrJp7uLyOgI8GnKGKWQI+aUY0yrbPNU9/Q0ahb
         048K2Zo5UDfCclVPqEnuG40LWIqaOPif0lxWFmxfEYONYwdktqfV0tVA94boEQGYfF8L
         71C2FgYoEaINbTCTOtuBEmz1GxK3RYAoDvx2qMz/fCAElEhCT3QrvQ/fOKSlvQ6nnhsZ
         Hebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123030; x=1730727830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAuvSPeqFzuf7N0J+GgrXDDctr3GZBniB+C01KKKdUI=;
        b=dtohpzDQXbE5dT/qgyidHHn39IcZz1oaOKpkfVqRnshVtxriZlJ2mr0tnWJ7e2RXo3
         6B19584pBHlxkPSWy5r34VO6Awkjlf5pzcp/gkjGwkIrYwG56KUhGSIF+E50Yz6X3aSs
         N7+mH8QwhmxjocF8951pP355fKmiXk8u9e4u2EfM0kbuHuCg03SP6eUkz9QbDkmdrKGG
         8DbcFdwN46qfTXoUc/WVhiEO/wzBxIbVPrwm7rkET16TrHl3bfv46SVlcZNJBj0Fb1R6
         5DL2tNXWh3sSupcF9LUUuShqvN27UjfJ1BDHss3YyMVJO9wNZkmg4AQg43QPKWl5LPpJ
         M9lA==
X-Gm-Message-State: AOJu0Ywmy7sA9qDqmshLksYobxa1zVQhXgVZpfpUlQZMTzYuEYPPqml9
	RmY2rSf2cMmA266qrWMET2n/aa7F02BaUiwQDZ78RjqMYtfVermf
X-Google-Smtp-Source: AGHT+IF/mJ13dNVDm7lYLagy+00KxThs9ay03kuUi2IE+cP0O4GTCD4PO2ejYPz7wTBt3EfrvFK5qQ==
X-Received: by 2002:a17:907:980e:b0:a9a:a5a:1d47 with SMTP id a640c23a62f3a-a9de5cfc5e3mr684653266b.2.1730123029882;
        Mon, 28 Oct 2024 06:43:49 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 1/8] packfile: add repository to struct `packed_git`
Date: Mon, 28 Oct 2024 14:43:39 +0100
Message-ID: <26d2461cc349c14b05d2713ee411bb058251f45f.1730122499.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730122499.git.karthik.188@gmail.com>
References: <cover.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct `packed_git` holds information regarding a packed object
file. Let's add the repository variable to this object, to represent the
repository that this packfile belongs to. This helps remove dependency
on the global `the_repository` object in `packfile.c` by simply using
repository information now readily available in the struct.

We also modify `alloc_packed_git` to ensure that the repository is added
to newly created `packed_git` structs. This requires modifying the
function and all its callee to pass the repository object down the
levels.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c |  3 ++-
 builtin/index-pack.c  |  6 ++++--
 commit-graph.c        |  2 +-
 connected.c           |  3 ++-
 http.c                |  2 +-
 midx-write.c          |  2 +-
 midx.c                |  2 +-
 object-store-ll.h     |  5 +++++
 packfile.c            | 15 +++++++++------
 packfile.h            |  6 ++++--
 10 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f14..ffee7d3abd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -765,6 +765,7 @@ static void start_packfile(void)
 
 	p->pack_fd = pack_fd;
 	p->do_not_close = 1;
+	p->repo = the_repository;
 	pack_file = hashfd(pack_fd, p->pack_name);
 
 	pack_data = p;
@@ -888,7 +889,7 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
+		new_p = add_packed_git(the_repository, idx_name, strlen(idx_name), 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9d23b41b3a..be2f99625e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1552,7 +1552,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (do_fsck_object) {
 		struct packed_git *p;
-		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
+		p = add_packed_git(the_repository, final_index_name,
+				   strlen(final_index_name), 0);
 		if (p)
 			install_packed_git(the_repository, p);
 	}
@@ -1650,7 +1651,8 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 
 static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 {
-	struct packed_git *p = add_packed_git(pack_name, strlen(pack_name), 1);
+	struct packed_git *p = add_packed_git(the_repository, pack_name,
+					      strlen(pack_name), 1);
 
 	if (!p)
 		die(_("Cannot open existing pack file '%s'"), pack_name);
diff --git a/commit-graph.c b/commit-graph.c
index 5bd89c0acd..83dd69bfeb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1914,7 +1914,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		struct packed_git *p;
 		strbuf_setlen(&packname, dirlen);
 		strbuf_addstr(&packname, pack_indexes->items[i].string);
-		p = add_packed_git(packname.buf, packname.len, 1);
+		p = add_packed_git(ctx->r, packname.buf, packname.len, 1);
 		if (!p) {
 			ret = error(_("error adding pack %s"), packname.buf);
 			goto cleanup;
diff --git a/connected.c b/connected.c
index a9e2e13995..3099da84f3 100644
--- a/connected.c
+++ b/connected.c
@@ -54,7 +54,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
 			   base_len);
 		strbuf_addstr(&idx_file, ".idx");
-		new_pack = add_packed_git(idx_file.buf, idx_file.len, 1);
+		new_pack = add_packed_git(the_repository, idx_file.buf,
+					  idx_file.len, 1);
 		strbuf_release(&idx_file);
 	}
 
diff --git a/http.c b/http.c
index 510332ab04..7e5be05207 100644
--- a/http.c
+++ b/http.c
@@ -2437,7 +2437,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	if (!tmp_idx)
 		return -1;
 
-	new_pack = parse_pack_index(sha1, tmp_idx);
+	new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
 	if (!new_pack) {
 		unlink(tmp_idx);
 		free(tmp_idx);
diff --git a/midx-write.c b/midx-write.c
index b3a5f6c516..c57726ef94 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -154,7 +154,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-		p = add_packed_git(full_path, full_path_len, 0);
+		p = add_packed_git(the_repository, full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
diff --git a/midx.c b/midx.c
index e82d4f2e65..8edb75f51d 100644
--- a/midx.c
+++ b/midx.c
@@ -464,7 +464,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 					strhash(key.buf), key.buf,
 					struct packed_git, packmap_ent);
 	if (!p) {
-		p = add_packed_git(pack_name.buf, pack_name.len, m->local);
+		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
 		if (p) {
 			install_packed_git(r, p);
 			list_add_tail(&p->mru, &r->objects->packed_git_mru);
diff --git a/object-store-ll.h b/object-store-ll.h
index 53b8e693b1..8b31072b09 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -4,6 +4,7 @@
 #include "hashmap.h"
 #include "object.h"
 #include "list.h"
+#include "repository.h"
 #include "thread-utils.h"
 #include "oidset.h"
 
@@ -135,6 +136,10 @@ struct packed_git {
 	 */
 	const uint32_t *mtimes_map;
 	size_t mtimes_size;
+
+	/* repo dentoes the repository this packed file belongs to */
+	struct repository *repo;
+
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 };
diff --git a/packfile.c b/packfile.c
index 9560f0a33c..45f300e5e1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -217,11 +217,12 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
 	return ntohl(level1_ofs[value]);
 }
 
-static struct packed_git *alloc_packed_git(int extra)
+static struct packed_git *alloc_packed_git(struct repository *repo, int extra)
 {
 	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
 	memset(p, 0, sizeof(*p));
 	p->pack_fd = -1;
+	p->repo = repo;
 	return p;
 }
 
@@ -233,11 +234,12 @@ static char *pack_path_from_idx(const char *idx_path)
 	return xstrfmt("%.*s.pack", (int)len, idx_path);
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
+struct packed_git *parse_pack_index(struct repository *repo,
+				    unsigned char *sha1, const char *idx_path)
 {
 	char *path = pack_path_from_idx(idx_path);
 	size_t alloc = st_add(strlen(path), 1);
-	struct packed_git *p = alloc_packed_git(alloc);
+	struct packed_git *p = alloc_packed_git(repo, alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	free(path);
@@ -703,7 +705,8 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
+struct packed_git *add_packed_git(struct repository *repo, const char *path,
+				  size_t path_len, int local)
 {
 	struct stat st;
 	size_t alloc;
@@ -721,7 +724,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	 * the use xsnprintf double-checks that)
 	 */
 	alloc = st_add3(path_len, strlen(".promisor"), 1);
-	p = alloc_packed_git(alloc);
+	p = alloc_packed_git(repo, alloc);
 	memcpy(p->pack_name, path, path_len);
 
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
@@ -877,7 +880,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 
 		/* Don't reopen a pack we already have. */
 		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
-			p = add_packed_git(full_name, full_name_len, data->local);
+			p = add_packed_git(data->r, full_name, full_name_len, data->local);
 			if (p)
 				install_packed_git(data->r, p);
 		}
diff --git a/packfile.h b/packfile.h
index 08f88a7ff5..344da905c2 100644
--- a/packfile.h
+++ b/packfile.h
@@ -46,7 +46,8 @@ const char *pack_basename(struct packed_git *p);
  * and does not add the resulting packed_git struct to the internal list of
  * packs. You probably want add_packed_git() instead.
  */
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(struct repository *repo,
+				    unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
 				      const char *file_name, void *data);
@@ -113,7 +114,8 @@ void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+struct packed_git *add_packed_git(struct repository *repo, const char *path,
+				  size_t path_len, int local);
 
 /*
  * Unlink the .pack and associated extension files.
-- 
2.47.0

