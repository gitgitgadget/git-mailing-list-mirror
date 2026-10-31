Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445024;
	b=3PASFxI04ILs215Yx+P7zPR5bpnp6/pVsaeVakptD9h/H1b/ZpdvjyaAQcMDIQONRFkc
	 ddTpDJive545Mk4i9vrfY8EDeVRJ7358SHMjM5/WYqJiLfX6jRbUNpQHdd0omFKCOqm42
	 J+747uFg8obPckLartEBGpgT1YP4voqASBbObcLHFxSGc4YYGqoZsj+652Pd3V2qCV0ZP
	 gReu1+TAqvE+I+ssouA4+o1apsqIWIBYIw2DFnSUG2whH4JEIxPNuW/qrVcqTUW6S6EXw
	 MRXyC8y0+zYH0iNF2nMBQwcrjPg9m275A2VLBsRcXHjMyjIYXJNtMUN1R6ApNTMLZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PdIbgTrmoToirQZLTOLjUz9LYFQix5GErFDQ+YCwA6g=;
	b=xKHE7KnM1cEKeTWDkti5lwrieDobK9a0uT3taL+qHnpVe2XBsrP3wJ4dZdGBpWikNBpF
	 BJLLyGCRRghoZTbiq0DgLSGwYCqw3uRB6Yz1gu47uuxhCaPUihh+Z9kqmrUOBOpbmicBs
	 ws3R588aV4mynq3PaS2EDw61g02DS1eG4lnMkXp9B1QfH9sMyG5iacculJcYx3GOwqwW+
	 z/1YLHygpr2cZ669TMFWDm/PnxuDqPnvIBnuK/WbDgVafbWESVUh0TWNL9AhmSKwXDnu8
	 7jmVZ3wdvgNYHrxbex/28iOQiJN2POw5tTwN5IE3yXXDOaxmjAS/NHmtlRLTrUY335w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kGoMkpip;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD4606A31D
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BD4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kGoMkpip
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso922803f8f.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445022; x=1794049822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdIbgTrmoToirQZLTOLjUz9LYFQix5GErFDQ+YCwA6g=;
        b=kGoMkpipzKwsVNZQ66u8Ndyrn7fpAKMwh8ReR4rGXP4QYrIp4xiuDnUjmy7jmAC+I5
         j38OC86LndRSBTJeL+cH+lPP7bcWB+h+KOFR6PQsXWV/Qv+bYvNH4MzzJiM8Xmh7CRNm
         vmSogcpDpQAprYfz0xDUdcPjmV8Umi13uu20Q34E/ksQRb9ubll+nzjk9/kMewtBDwUb
         gPlmn8rROpLYbD/InulsQE2mqsfkoagMpAcVzU0qG6Mrenv+OS3sZQmyk5DCfRgW3bt9
         dhXTIOxchHNJwJUxZKn8uiTY6z1Za8bp5Zlv3oBP0XO+5WAlBvd2GDXG18G57kmbG0nw
         ltsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445022; x=1794049822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdIbgTrmoToirQZLTOLjUz9LYFQix5GErFDQ+YCwA6g=;
        b=Im4g06/d82ScrrhlPlvODWaOYy75uL/b7xtTmQLDq/sY02heq5K+R4HOy0Xq6q9M1Y
         b3XeakpRato/AVFvuv3YBFgCwIzq4VbO0cL4PRfKarIAKNJvmmyXgAduZ8s49OfQIbSC
         9ghelyb+n+Sz6wqel+4BUcLVKTO6AGWAtoqp6FMmFJQFIqH1qAbHIiECRUHwVn5Y2mwF
         8urqn2YYBfI4YwODHUGrD9eVVGntl42m7vF5Q3iDQy78ze0jSDJoLV8Bt2SEWQlRyvh4
         0uDCCPC5ZTvwxCWsAr9m9eHbfpzdR+MWL+dXf3i8qFBfaXPKQQZMzPRw2TFjcQ9e5faQ
         GVDg==
X-Gm-Message-State: AFq9FYI/vAd1hMpaHqnJmIlrsXamI7uJvlj7jZ7NLVwJRrvmgoUeUMxc
	X4XusboZJvyt7fXm0UBBTuyFJ0rLRDU1jkPKGSJZ767E5REq4KKMdE/yBTnuLjNM
X-Gm-Gg: AYBFou05lDMmFTKfruf8ry9AW3KY+w8WN8m/zsmzLLpJi2VFhrBvTfPCjgNdlDCGaKc
	3eBqpAoleh8S0KyLG6Vkm1PpFeehXqNXXevy8p4agoE2r8sKXTWfjA7kwELNjIbDYLKvVIlb8iv
	gfA54fL/Zc7BeYvz8iVpJl+NzBoX1keS3NT/7xAbPd6lRMpRSaehnEiccoiRnwAPoVS5Wl7VV0n
	oXopf2s74pazGMx+ygk9A4eo8lbWuQ9+Rl9IXVpJbKbmpdF3aKSnUzroIkkOBzSkg1l3azn9E9R
	TD1mw11yGGr8Q5XjilLnO9DPPRl3divU0b1+5t1W5i1CeXhKK5SWb88Spyh+eXOoDVyJTyvmpmw
	VGo8oCPjjOiXID6mXsCYzN7jPBu2lr6PU2UqiLUQy/axOSmzQxL+JkJpHKkCWrC8gGasZ1kCMZI
	8jRgErNuHM/xlJv9chwXio8KDE1ZE5VSEqb6rwWYgstaXnxm42gsw29Utu+/GaZUx8Z1kAaJrZG
	OY7Uq8C51dYjRk8Eg/+JGVURz1A7IGbD0nzWcH3PG+/87m3ZxHovvULQ4COlqA1eKBsK47tm4dM
	EHNrWI5GRhaLeTcuAlDevB+XhzOYPFTx9p6ZhrlQTnt0+2XWVMM4HTjuViz1MSM=
X-Received: by 2002:a05:6000:40dc:b0:48d:e61d:68da with SMTP id ffacd0b85a97d-48e6e2fa50dmr11400621f8f.20.1793445022398;
        Sat, 31 Oct 2026 04:10:22 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm8853670f8f.55.2026.10.31.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:21 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/4] object, commit, tag: use size_t when parsing object buffers
Date: Sat, 31 Oct 2026 12:09:59 +0100
Message-ID: <745c6d04d33dd118a1c8185d0b851d79d171ab98.1793444420.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>
References: <cover.1793444420.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions like parse_object_buffer(), parse_commit_buffer(),
parse_tag_buffer(), and decode_tree_entry_raw() take the buffer size as
an "unsigned long", while callers pass a size_t. On platforms where
"long" is 32 bits, this truncates the size for objects of 4GiB or more.

When parsing large objects on those platforms, only a prefix of the
buffer is parsed. For example, a signature placed at the end of a large
tag can be missed.

Use size_t for the size parameter across these parsing functions. For
set_commit_buffer(), the commit cache slab still stores "unsigned long"
sizes due to accessors like repo_get_commit_buffer() handing out the
size through an "unsigned long *" output parameter. Therefore,
set_commit_buffer() narrows the size with cast_size_t_to_ulong(), dying
on objects of 4GiB or more on 32-bit long platforms instead of caching a
truncated size, mirroring the behavior already implemented in
repo_get_commit_buffer().

parse_tree_buffer() is changed separately.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 commit.c              | 8 ++++----
 commit.h              | 6 +++---
 object-file-convert.c | 2 +-
 object.c              | 2 +-
 object.h              | 2 +-
 tag.c                 | 2 +-
 tag.h                 | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/commit.c b/commit.c
index ad26f0b40a..a94acf4e6f 100644
--- a/commit.c
+++ b/commit.c
@@ -366,12 +366,12 @@ void free_commit_buffer_slab(struct buffer_slab *bs)
 	free(bs);
 }
 
-void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, size_t size)
 {
 	struct commit_buffer *v = buffer_slab_at(
 		r->parsed_objects->buffer_slab, commit);
 	v->buffer = buffer;
-	v->size = size;
+	v->size = cast_size_t_to_ulong(size);
 }
 
 const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
@@ -513,7 +513,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph)
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, size_t size, int check_graph)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -1195,7 +1195,7 @@ int parse_signed_commit(const struct commit *commit,
 }
 
 int parse_buffer_signed_by_header(const char *buffer,
-				  unsigned long size,
+				  size_t size,
 				  struct strbuf *payload,
 				  struct strbuf *signature,
 				  const struct git_hash_algo *algop)
diff --git a/commit.h b/commit.h
index 1061ed791b..6a6ff25e12 100644
--- a/commit.h
+++ b/commit.h
@@ -92,7 +92,7 @@ struct commit *lookup_commit_reference_by_name_gently(const char *name,
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph);
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, size_t size, int check_graph);
 int repo_parse_commit_internal(struct repository *r, struct commit *item,
 			       int quiet_on_missing, int use_commit_graph);
 int repo_parse_commit_gently(struct repository *r,
@@ -131,7 +131,7 @@ void free_commit_buffer_slab(struct buffer_slab *bs);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffer, size_t size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
@@ -381,7 +381,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
-				  unsigned long size,
+				  size_t size,
 				  struct strbuf *payload,
 				  struct strbuf *signature,
 				  const struct git_hash_algo *algop);
diff --git a/object-file-convert.c b/object-file-convert.c
index 63ee18630b..ead88c1021 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -51,7 +51,7 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 
 static int decode_tree_entry_raw(struct object_id *oid, const char **path,
 				 size_t *len, const struct git_hash_algo *algo,
-				 const char *buf, unsigned long size)
+				 const char *buf, size_t size)
 {
 	uint16_t mode;
 	const unsigned hashsz = algo->rawsz;
diff --git a/object.c b/object.c
index 97f7fc0e87..541ac90dc6 100644
--- a/object.c
+++ b/object.c
@@ -258,7 +258,7 @@ enum peel_status peel_object(struct repository *r,
 	return peel_object_ext(r, name, oid, flags, &dummy);
 }
 
-struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
diff --git a/object.h b/object.h
index 46cade33fb..9bf23321a7 100644
--- a/object.h
+++ b/object.h
@@ -241,7 +241,7 @@ struct object *parse_object_or_die(struct repository *repo, const struct object_
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_p);
 
 /*
  * Allocate and return an object struct, even if you do not know the type of
diff --git a/tag.c b/tag.c
index 1a00ded6eb..414681c64f 100644
--- a/tag.c
+++ b/tag.c
@@ -127,7 +127,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, size_t size)
 {
 	struct object_id oid;
 	char type[20];
diff --git a/tag.h b/tag.h
index 534687c4ca..a5f0f06c82 100644
--- a/tag.h
+++ b/tag.h
@@ -12,7 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, size_t size);
 int parse_tag(struct repository *r, struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const char *, int);
-- 
2.53.0

