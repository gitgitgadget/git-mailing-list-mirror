Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2811F667A
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237052; cv=none; b=iOD5+n45UrrcIXi0BGZPyTz3GNtIYmtzW/gw4sGRv7s0UJS5qX77ny6Ob8oT8mm3UtDO1O/efOEN/SmiIrypiD936qa8g5t4nzzb49BgkxykZZP9jjh5zqen7l4cnibK9ammaBLqKTARRUoyGZdGLydEGO4wTjHsYxaVi0EEsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237052; c=relaxed/simple;
	bh=n3CrN93rlONgAiVeEaO44TriyQzBlHDw7ECL9VlofKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIaq83g8IwiMAQ15EHEnMVk84HJVeCrw7b2lprfYTLeLo5auvRa0FXvbIuGJTaI1H0U4uvO6jZi8a2sZufUb4kC24MqPUCeWN/CoibUijX+aY4lT2GSG8AN0ux07vtK/45sQf7HwJQYCahN33JSpYoGCf86ns0oNsj8nNLBk21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSFc9CDQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSFc9CDQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so7017761a12.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237048; x=1733841848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y7CAg3qHYqC6uwPqgfWsVKX6SAPEjbJ92SMNAXBrgc=;
        b=bSFc9CDQVpgwGf9sDyJtKisHrh6BQYiKOBd5ZlErVShVFh/YOOr9pRJaeJ3b/VsN8k
         RmagDuiTDd4DooIvvWhHbB7dXRcXNJmhTYRE+ZPjW4ZnfvweuBEb6+X/bgebXclZgZDC
         JaA/QGKZFV2uH4GdKh09ufheqXgks6+KF9q1KY2S5T/gz/dmzQpwIbSQxZp5oJx4N+pa
         npNzyTYQEVMu1ZffmWnixTYZTDdcWFOYbmQAXrvQ/R9+RtgcTle5cvbJf9RJiLwNw6N5
         VO1HoG2OdfDRte7xptIfQL2Bghkl9uMRpUR4VrN3KdvlObHnjrZC651WWSFaQJYKey4X
         Pe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237048; x=1733841848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y7CAg3qHYqC6uwPqgfWsVKX6SAPEjbJ92SMNAXBrgc=;
        b=Kl864J8L5UFgLiJ2+SCwvrcksVLDmphoCPBFs/+GOuyEWIzDIJJQBZjcONdNYQ0pwN
         dsyY5G0j3DowQSm+h8TRafgTbOCBSiT1VrgL0o3yHFVwgExMXdlsSenYus7HVfmlZtqZ
         bxvltkPFyMuqYuvDCs3RYJkn9l/7J+wbCNuoCW5XQhNzFP0H9FGkQTlFWBsGwUviqqBv
         U1INyd/81TpBOr5nyHN4oqV8/qIOjNKgEaKnjvVQLfbz7UyA2hxPMDT4fucwyxEuOrzS
         FfErlHvK/3W34Y7si0r6zURDj0Kobe7ZsTYimyfw05LT6e09aIMaPzjqyWENGGshA3B/
         2AGw==
X-Gm-Message-State: AOJu0YydWMsBy1GRzAy/DLkYhnSnEUm35s4i0rnPGWKR9jKsHwkEod9G
	lNR0YGaSFJ5P0rXe4UBvTuFLzTqLl/W7V3m6AUepR0J+0paoluEu
X-Gm-Gg: ASbGncuFIRa4JSNIWLM3y/wHxNNsSA1MvVESINjCYHBsEO6afc68JxWy+xQwtdn4/Rz
	HOddxioz0qeD5ZUHKhS5lmgXBrEmlunanHzCobFLBavxpmpZdhhvld0fM+PpsrS5WJ6MTP9avn2
	hyRW06DQhpdco2wuzqDx/yKh82Yg5IZQvNrXnmzvgRSYkUT86IoXOKwYFIvsEigSYmOLv/Q9sC6
	bq7O88uYj6hbry5Y+H56igASTlI4XG1wG9WqVDyPWR7uPRCYBd1QcZx3j80KVbxNfkP
X-Google-Smtp-Source: AGHT+IEQRmQczUbn4wnts3zh51VMzsTKVwByij4gTyC1jRaV4s9ySJEp2Vk7/Xfh5l8BO8m5Fz5t+Q==
X-Received: by 2002:a17:906:23f1:b0:aa1:dd58:aebc with SMTP id a640c23a62f3a-aa5f7f0065bmr198872366b.39.1733237048033;
        Tue, 03 Dec 2024 06:44:08 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v10 01/10] packfile: add repository to struct `packed_git`
Date: Tue,  3 Dec 2024 15:43:55 +0100
Message-ID: <d6d571c58ec833a57c812a35f60f445d196b0749.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
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

We do need to consider that a packfile could be part of the alternates
of a repository, but considering that we only have one repository struct
and also that we currently anyways use 'the_repository', we should be
OK with this change.

We also modify `alloc_packed_git` to ensure that the repository is added
to newly created `packed_git` structs. This requires modifying the
function and all its callee to pass the repository object down the
levels.

Helped-by: Taylor Blau <me@ttaylorr.com>
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
index 76d5c20f14..da7e2d613b 100644
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
+		new_p = add_packed_git(pack_data->repo, idx_name, strlen(idx_name), 1);
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
index 58242b9d2d..6744e18409 100644
--- a/http.c
+++ b/http.c
@@ -2439,7 +2439,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
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
index 53b8e693b1..d46cd0e654 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -10,6 +10,7 @@
 struct oidmap;
 struct oidtree;
 struct strbuf;
+struct repository;
 
 struct object_directory {
 	struct object_directory *next;
@@ -135,6 +136,10 @@ struct packed_git {
 	 */
 	const uint32_t *mtimes_map;
 	size_t mtimes_size;
+
+	/* repo denotes the repository this packfile belongs to */
+	struct repository *repo;
+
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 };
diff --git a/packfile.c b/packfile.c
index 9560f0a33c..6058eddf35 100644
--- a/packfile.c
+++ b/packfile.c
@@ -217,11 +217,12 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
 	return ntohl(level1_ofs[value]);
 }
 
-static struct packed_git *alloc_packed_git(int extra)
+static struct packed_git *alloc_packed_git(struct repository *r, int extra)
 {
 	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
 	memset(p, 0, sizeof(*p));
 	p->pack_fd = -1;
+	p->repo = r;
 	return p;
 }
 
@@ -233,11 +234,12 @@ static char *pack_path_from_idx(const char *idx_path)
 	return xstrfmt("%.*s.pack", (int)len, idx_path);
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
+struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
+				    const char *idx_path)
 {
 	char *path = pack_path_from_idx(idx_path);
 	size_t alloc = st_add(strlen(path), 1);
-	struct packed_git *p = alloc_packed_git(alloc);
+	struct packed_git *p = alloc_packed_git(r, alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	free(path);
@@ -703,7 +705,8 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
+struct packed_git *add_packed_git(struct repository *r, const char *path,
+				  size_t path_len, int local)
 {
 	struct stat st;
 	size_t alloc;
@@ -721,7 +724,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	 * the use xsnprintf double-checks that)
 	 */
 	alloc = st_add3(path_len, strlen(".promisor"), 1);
-	p = alloc_packed_git(alloc);
+	p = alloc_packed_git(r, alloc);
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
index 08f88a7ff5..aee69d1a0b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -46,7 +46,8 @@ const char *pack_basename(struct packed_git *p);
  * and does not add the resulting packed_git struct to the internal list of
  * packs. You probably want add_packed_git() instead.
  */
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
+				    const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
 				      const char *file_name, void *data);
@@ -113,7 +114,8 @@ void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+struct packed_git *add_packed_git(struct repository *r, const char *path,
+				  size_t path_len, int local);
 
 /*
  * Unlink the .pack and associated extension files.
-- 
2.47.1

