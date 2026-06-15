Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08032221FB4
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524359; cv=none; b=bSvDNW2DVjCKDW3DXQEwypTIQKjsgwRmd7bj/S9MOqYN6pHeYwHopXslWYXo3z9aU5lhsZMPYfxczd4EhhlgEt4XSOfNEyWOIQFEzCJdbuflwEpgUUbWrZQpyqSSzKBK/GsjSy2f8iJ2g2U6i+vCqYXvNQdJRLwHV9yxEQbUSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524359; c=relaxed/simple;
	bh=dyVNR+V2gM+vFetpKUlbK4VdPnpreMjpIaurnXdWTso=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OJ7h3aYqZ5O2ZUIMe2TFdA8CGr4Z0ovrZau3JkMNzTjsEIKJS/58Iv68HlhkXWBLmJcqlERPOcB/A3A5WnqgJTlFw2FGdRJvcQkuKlpFGi7nLRj1EiqiBBfqxYXMcz1nrZwx2SjyLAHnG/FiZ9xfTJ8i5flCEaiLEEKqu/gXxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoa1Yfxd; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoa1Yfxd"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccedaf0b54so22863066d6.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524357; x=1782129157; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMa0Nd3W8HH5T9A7ZPAtp4QkMilAyxUsm4kBqBMDqJM=;
        b=hoa1Yfxd2Y4AURXJ02qJVY0/Vwrl+7dmaAKzPh5PgBGc14HgToEEqeu6r5IMs0q2EG
         b28OZP97oNjKQ2CsCsoZHORtgYBMBevcG6C67RKigh+cnaofoVlc2+4wbk2NOcUaJACD
         8JCzq8cuARwvOH8/H0dk3CMsAzi45VKKxm9HA8HXv9Iq3qW8846zHF3VYoC5f53KUvLf
         h8eP8++qv1sENvT5L+4PVgfa/J8aZL2ssCzIXLYVXAyfLiX4vXZOA3htZto6y7yrTZro
         /0JJpP6QARXkAkmJ+4juVaV39gKXEF0oEXN9MYSR46bH1krIhvl6EgRQprhANEVQCxus
         8fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524357; x=1782129157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMa0Nd3W8HH5T9A7ZPAtp4QkMilAyxUsm4kBqBMDqJM=;
        b=FxILZhsiUTdgSApkdXTW0DXeWGRl637mxS3y6P1pZvPXWalBrcLE7e5iNddU3xyJ0R
         bTmQhE/fPmIO625HYsbZtHZrbbW4qIcQ3fB9aaEwOybaMrCnjLi/Bl/iab37pmCrcniX
         tzBJaom8KOBrjGPDDcryB332NyBQg+53LPVa83FHUDCwThV/8eBOFky7E6OuKjrr/bIf
         nE+r5rLz1y4coHZRpAH/GOtRuhrz4zKqlvooWJsNoQgaQjPnNJLJ+Kvec4VRYuvBb4/l
         Sjue3zOJb/FcqEH2NqETYjEdcnGKHcmymfM60IMsBHtfdHlHS2A/9hX70x1VlC2+ZtwT
         ItuQ==
X-Gm-Message-State: AOJu0YwFOyq6Ee1bv4/qzZx+7D/CIul8rj2DiAoqUqcSO8SmP0sB6Bsi
	sG/9AsrJ6OcGb2lg3RRdiD/Asopwq4foc5VzqSR2MXW+ZB8iNJIYGZH59frgxw==
X-Gm-Gg: Acq92OHOUUgalYPgoNQ0TNZtAGFHmjrGGTOgThZXRqnR76ySYIEvuFHihAqPpg//3Iy
	iPArfhuOX6BWelxR2BjGU30vmYDt6BjQ91ruXcBxTSbkFckmo9kn9LfEctuSf5e8hs3mt2aTLam
	sPET9K5JAsT1I8QjKXq64fze+hg14uxCmHhU8wBtDwWpKby/Gh9C7jwo7EP3gZ/xGhtVWgr55i7
	fBgQgcACiK0CyoGR6l1sjeiUrNyIafaVhfFhsw44KbpN2Tr2+BDp2T429S44dFIEi28CcyEpl/Z
	4N9nEiVQm8xynHZnebUbTZbjmb0vsGnZnjBhRJHq7Pgbf5o/aY1359uB7vTTHnzkkiH5s9JN6pW
	PBEbFH0TxWnmtWF6Hi9JBiiT8jC+/R6qx9MwPgXWzyYaDArpSwPfySFTTJkWflPQE8XQEJbwdO7
	UZ1TNO84Am7eSLjdEzCLgIT/YTUkA=
X-Received: by 2002:a05:6214:226b:b0:8d1:8cfd:b00c with SMTP id 6a1803df08f44-8d32e21550amr239881936d6.31.1781524356889;
        Mon, 15 Jun 2026 04:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30105fd9csm113783806d6.10.2026.06.15.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:36 -0700 (PDT)
Message-Id: <5c329535df4bed84f16223ca2e1ffbf2854ba42a.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:26 +0000
Subject: [PATCH v2 4/7] packfile: widen unpack_entry()'s size out-parameter to
 size_t
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The topic `js/objects-larger-than-4gb-on-windows` widened the streaming,
index-pack and unpack-objects paths to `size_t` but deliberately stopped
at the in-memory `unpack_entry()` cascade, which still hands back the
unpacked size through `unsigned long *`.  On Windows that boundary
truncates above 4 GiB because that data type is only 32 bits wide on
that platform.

Widen the code path. Except `packed_object_info_with_index_pos()`: It
cannot yet pass `oi->sizep` directly because the field is still
`unsigned long *`; bridge it with a `size_t` temporary that narrows
back, and let a later commit drop the bridge once the field is wide
too. `gfi_unpack_entry()` keeps its narrow signature because fast-import
tracks sizes through `unsigned long` everywhere it crosses subsystem
boundaries, keeping its signature allows the scope of this commit to be
somewhat reasonable, still.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-import.c |  7 ++++++-
 pack-check.c          |  5 ++---
 packfile.c            | 28 +++++++++++++++++-----------
 packfile.h            |  3 ++-
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 82bc6dcc00..3dff898c43 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1239,6 +1239,8 @@ static void *gfi_unpack_entry(
 	unsigned long *sizep)
 {
 	enum object_type type;
+	size_t size_st = 0;
+	void *data;
 	struct packed_git *p = all_packs[oe->pack_id];
 	if (p == pack_data && p->pack_size < (pack_size + the_hash_algo->rawsz)) {
 		/* The object is stored in the packfile we are writing to
@@ -1260,7 +1262,10 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + the_hash_algo->rawsz;
 	}
-	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
+	data = unpack_entry(the_repository, p, oe->idx.offset, &type, &size_st);
+	if (sizep)
+		*sizep = cast_size_t_to_ulong(size_st);
+	return data;
 }
 
 static void load_tree(struct tree_entry *root)
diff --git a/pack-check.c b/pack-check.c
index 2792f34d25..5adfb3f272 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,9 +143,8 @@ static int verify_packfile(struct repository *r,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			unsigned long sz;
-			data = unpack_entry(r, p, entries[i].offset, &type, &sz);
-			size = sz;
+			data = unpack_entry(r, p, entries[i].offset, &type,
+					    &size);
 			data_valid = 1;
 		}
 
diff --git a/packfile.c b/packfile.c
index e202f48837..dab0a9b16d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1454,7 +1454,7 @@ struct delta_base_cache_entry {
 	struct delta_base_cache_key key;
 	struct list_head lru;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 };
 
@@ -1525,7 +1525,7 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 }
 
 static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
-				   off_t base_offset, unsigned long *base_size,
+				   off_t base_offset, size_t *base_size,
 				   enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1558,8 +1558,8 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-				 void *base, unsigned long base_size,
-				 unsigned long delta_base_cache_limit,
+				 void *base, size_t base_size,
+				 size_t delta_base_cache_limit,
 				 enum object_type type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1614,10 +1614,13 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset, oi->sizep,
-						      &type);
+		size_t size_st = 0;
+		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset,
+						      &size_st, &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
+		else if (oi->sizep)
+			*oi->sizep = cast_size_t_to_ulong(size_st);
 	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
@@ -1735,7 +1738,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-				    unsigned long size)
+				    size_t size)
 {
 	int st;
 	git_zstream stream;
@@ -1790,11 +1793,11 @@ int do_check_packed_object_crc;
 struct unpack_entry_stack_ent {
 	off_t obj_offset;
 	off_t curpos;
-	unsigned long size;
+	size_t size;
 };
 
 void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
-		   enum object_type *final_type, unsigned long *final_size)
+		   enum object_type *final_type, size_t *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
@@ -1911,7 +1914,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		void *delta_data;
 		void *base = data;
 		void *external_base = NULL;
-		unsigned long delta_size, base_size = size;
+		size_t delta_size, base_size = size;
 		int i;
 		off_t base_obj_offset = obj_offset;
 
@@ -1928,6 +1931,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			struct object_id base_oid;
 			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
 				struct object_info oi = OBJECT_INFO_INIT;
+				unsigned long bsz_ul = 0;
 
 				nth_packed_object_id(&base_oid, p,
 						     pack_pos_to_index(p, pos));
@@ -1938,11 +1942,13 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 				mark_bad_packed_object(p, &base_oid);
 
 				oi.typep = &type;
-				oi.sizep = &base_size;
+				oi.sizep = &bsz_ul;
 				oi.contentp = &base;
 				if (odb_read_object_info_extended(r->objects, &base_oid,
 								  &oi, 0) < 0)
 					base = NULL;
+				else
+					base_size = bsz_ul;
 
 				external_base = base;
 			}
diff --git a/packfile.h b/packfile.h
index 49d6bdecf6..0b5ae3f9fc 100644
--- a/packfile.h
+++ b/packfile.h
@@ -455,7 +455,8 @@ off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int is_pack_valid(struct packed_git *);
-void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
+void *unpack_entry(struct repository *r, struct packed_git *, off_t,
+		   enum object_type *, size_t *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
-- 
gitgitgadget

