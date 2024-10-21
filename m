Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039661E7C0E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504702; cv=none; b=KplJZzS+0vueseeFmttmkoB9Snk4z4opGxdCG0Xm1dP0VbjK3kjqzQ4RBHIPvfKb+lbrsY848y8fw+Dpjj6dPfLfXTQGriIDmPcUhGNUIWl0BpTPepQW0jlMyWQfiHyUqsbXUr6pG8dy+01U//FnJ+nWqZWnNzxV+Z/vJDVgZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504702; c=relaxed/simple;
	bh=OP5PdLOiJKObcb1c8Y4K0E2ET6ylfdk5Gj1R0F5ECmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaVW7vkPYdORPjOWPf8np7AO67j8tg9BKCXoESZ2vZKKwK9fds6dsfcRlNC/eLXG27k/whbfXfqnWpG6N4PDUXjYTL1HUilCHxuEAiiSwrrT35MVzJ+0Pgm1SRk/z9TfY21jYfFdGkgywoPHfm5YAOhlh1lE8fDIJ1fpGMhLSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JliATXhz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JliATXhz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a5b2f2026so489994366b.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504698; x=1730109498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVYF4wTFpxLK9O+hKpd9LkTZxCJB0xdX+iu2VPTrzCI=;
        b=JliATXhzb3C1htG7x2oh0RYr8KRaEF4dwCHH7VCbNRQRmDwX1JfTkCYnXVg+TUB0lQ
         YBWMe/6JFjSMZsxBw/LYUkEOCKNG1tCFYYp3mzLcQqBW66paHK996URM4WRImTsbDMap
         YwO8nVH5L6vd4jHF6JL0SS14Tzsox4aJ1rBvjgtlAKNna9/gQOrz8XVGSDCrcm1A6QCT
         Kzm7Y2Fs7ierjS4BiKeJTbJJMBCdRH0DcSB431EmnJyzaPxsPUszLdMPgG+kIE2OCR34
         A+a1qAoin3slNyb2J0tWK0WfCUIkPzSuvAerqLVGobmLJfoD3LgwhqT9bMvOzLct6OYA
         r+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504698; x=1730109498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVYF4wTFpxLK9O+hKpd9LkTZxCJB0xdX+iu2VPTrzCI=;
        b=DTKT70wPFsyPEbbunUXIV93NAAsoyxtRNyW6HQqUcUky/QdWMa7lT1WWzEvhFjrnTN
         ISy9ltI3cuh1f+SOy6j69MO2XJ3WqlQ2oX/RMQclPmJG+Ec0b8v7Omg2G/nUvoTh6bBj
         UInRRSkRWI5JcyMqA6zaBKvSmf9K1WUfF4Pv16g2DYTT7SAcS2Bz4ax6phRvKub6VJE2
         uw9qSfoyePrD9qV8/qltpeoWGlMnZU46usB34iFmNguvAapC1fbAM0oMJH3/O46hGzze
         8zJDyl1hTv5spiuiHZZZPNN0WBKDCI0oP+i16jUnhmb2uY7yYECQDle6W2zUvD5qkPfu
         Xuvg==
X-Gm-Message-State: AOJu0Yw5V0ryFNbPbPBMjijAVo5+iLcHCrRgW8p5qUVcsoqPWYTeMJY0
	EBg4PjZ8U2/K0Ofugt1bimlrzH39iKM8wYj89/11+Pn5L+p6qrrTPsSxi4zY
X-Google-Smtp-Source: AGHT+IF9W0XCVRBcfWgRzeH7Qp4dbzuCrrBjkc0cYWhloTQbjE+UgIv2brYp+T4gfFEoX+QY9zRmLw==
X-Received: by 2002:a17:906:6a14:b0:a9a:8674:1739 with SMTP id a640c23a62f3a-a9a867417bbmr792187166b.53.1729504697952;
        Mon, 21 Oct 2024 02:58:17 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 15/20] object-store: pass down repository to `each_packed_object_fn`
Date: Mon, 21 Oct 2024 11:57:58 +0200
Message-ID: <db8815ece434b7200a4ab651988d15824951b2f9.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `each_packed_object_fn` defines the type of the function called for
each packed object. In some of the implementations, we require the
repository state. So let's modify the function type to also include a
repository object and modify all implementations to receive the object
and utilize that instead of global state.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c     | 6 ++++--
 builtin/fsck.c         | 6 ++++--
 builtin/pack-objects.c | 6 ++++--
 builtin/repack.c       | 5 +++--
 commit-graph.c         | 3 ++-
 object-store-ll.h      | 3 ++-
 packfile.c             | 9 +++++----
 reachable.c            | 5 +++--
 revision.c             | 3 ++-
 9 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f6afe67bef..e5d774b097 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -600,7 +600,8 @@ static int collect_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-static int collect_packed_object(const struct object_id *oid,
+static int collect_packed_object(struct repository *repo UNUSED,
+				 const struct object_id *oid,
 				 struct packed_git *pack UNUSED,
 				 uint32_t pos UNUSED,
 				 void *data)
@@ -631,7 +632,8 @@ static int batch_unordered_loose(const struct object_id *oid,
 	return batch_unordered_object(oid, NULL, 0, data);
 }
 
-static int batch_unordered_packed(const struct object_id *oid,
+static int batch_unordered_packed(struct repository *repo UNUSED,
+				  const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9c4e0622b5..0e4b7ec3af 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -250,7 +250,8 @@ static int mark_loose_unreachable_referents(const struct object_id *oid,
 	return 0;
 }
 
-static int mark_packed_unreachable_referents(const struct object_id *oid,
+static int mark_packed_unreachable_referents(struct repository *repo UNUSED,
+					     const struct object_id *oid,
 					     struct packed_git *pack UNUSED,
 					     uint32_t pos UNUSED,
 					     void *data UNUSED)
@@ -861,7 +862,8 @@ static int mark_loose_for_connectivity(const struct object_id *oid,
 	return 0;
 }
 
-static int mark_packed_for_connectivity(const struct object_id *oid,
+static int mark_packed_for_connectivity(struct repository *repo UNUSED,
+					const struct object_id *oid,
 					struct packed_git *pack UNUSED,
 					uint32_t pos UNUSED,
 					void *data UNUSED)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 16e7f5d4ec..bfe0197d12 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3361,7 +3361,8 @@ static int git_pack_config(const char *k, const char *v,
 static int stdin_packs_found_nr;
 static int stdin_packs_hints_nr;
 
-static int add_object_entry_from_pack(const struct object_id *oid,
+static int add_object_entry_from_pack(struct repository *repo UNUSED,
+				      const struct object_id *oid,
 				      struct packed_git *p,
 				      uint32_t pos,
 				      void *_data)
@@ -3901,7 +3902,8 @@ static void show_edge(struct commit *commit)
 	add_preferred_base(&commit->object.oid);
 }
 
-static int add_object_in_unpacked_pack(const struct object_id *oid,
+static int add_object_in_unpacked_pack(struct repository *repo UNUSED,
+				       const struct object_id *oid,
 				       struct packed_git *pack,
 				       uint32_t pos,
 				       void *data UNUSED)
diff --git a/builtin/repack.c b/builtin/repack.c
index 96a4fa234b..de03a3ecfc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -321,7 +321,8 @@ static void prepare_pack_objects(struct child_process *cmd,
  * Write oid to the given struct child_process's stdin, starting it first if
  * necessary.
  */
-static int write_oid(const struct object_id *oid,
+static int write_oid(struct repository *repo,
+		     const struct object_id *oid,
 		     struct packed_git *pack UNUSED,
 		     uint32_t pos UNUSED, void *data)
 {
@@ -332,7 +333,7 @@ static int write_oid(const struct object_id *oid,
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
-	if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+	if (write_in_full(cmd->in, oid_to_hex(oid), repo->hash_algo->hexsz) < 0 ||
 	    write_in_full(cmd->in, "\n", 1) < 0)
 		die(_("failed to feed promisor objects to pack-objects"));
 	return 0;
diff --git a/commit-graph.c b/commit-graph.c
index 8c72c3ac10..96d55f8885 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1487,7 +1487,8 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	return 0;
 }
 
-static int add_packed_commits(const struct object_id *oid,
+static int add_packed_commits(struct repository *repo UNUSED,
+			      const struct object_id *oid,
 			      struct packed_git *pack,
 			      uint32_t pos,
 			      void *data)
diff --git a/object-store-ll.h b/object-store-ll.h
index 710130cd06..a9904687d6 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -538,7 +538,8 @@ int for_each_loose_object(each_loose_object_fn, void *,
  * Each pack is visited in an unspecified order. By default, objects within a
  * pack are visited in pack-idx order (i.e., sorted by oid).
  */
-typedef int each_packed_object_fn(const struct object_id *oid,
+typedef int each_packed_object_fn(struct repository *repo,
+				  const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
diff --git a/packfile.c b/packfile.c
index 1867c2d844..831d2c2c74 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2199,7 +2199,7 @@ int for_each_object_in_pack(struct repository *repo,
 			return error("unable to get sha1 of object %u in %s",
 				     index_pos, p->pack_name);
 
-		r = cb(&oid, p, index_pos, data);
+		r = cb(repo, &oid, p, index_pos, data);
 		if (r)
 			break;
 	}
@@ -2237,7 +2237,8 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	return r ? r : pack_errors;
 }
 
-static int add_promisor_object(const struct object_id *oid,
+static int add_promisor_object(struct repository *repo,
+			       const struct object_id *oid,
 			       struct packed_git *pack UNUSED,
 			       uint32_t pos UNUSED,
 			       void *set_)
@@ -2246,12 +2247,12 @@ static int add_promisor_object(const struct object_id *oid,
 	struct object *obj;
 	int we_parsed_object;
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(repo, oid);
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object(the_repository, oid);
+		obj = parse_object(repo, oid);
 	}
 
 	if (!obj)
diff --git a/reachable.c b/reachable.c
index ecf7ccf504..f8dc2731d6 100644
--- a/reachable.c
+++ b/reachable.c
@@ -274,7 +274,8 @@ static int add_recent_loose(const struct object_id *oid,
 	return 0;
 }
 
-static int add_recent_packed(const struct object_id *oid,
+static int add_recent_packed(struct repository *repo,
+			     const struct object_id *oid,
 			     struct packed_git *p,
 			     uint32_t pos,
 			     void *data)
@@ -285,7 +286,7 @@ static int add_recent_packed(const struct object_id *oid,
 	if (!want_recent_object(data, oid))
 		return 0;
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(repo, oid);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
diff --git a/revision.c b/revision.c
index df1037dcaa..97f5e59258 100644
--- a/revision.c
+++ b/revision.c
@@ -3603,7 +3603,8 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
 }
 
-static int mark_uninteresting(const struct object_id *oid,
+static int mark_uninteresting(struct repository *repo UNUSED,
+			      const struct object_id *oid,
 			      struct packed_git *pack UNUSED,
 			      uint32_t pos UNUSED,
 			      void *cb)
-- 
2.47.0

