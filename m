Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446786;
	b=wvbS7Hi4DK3mM+P1zEoPtrymw6puWD0mn6BqDtiCtHlquYx34BQ/rvBuYUQHStTQRxW5
	 sQjIZCvMMW6Dkk3wjSQL3pAMEG9IM2LvkNeDUUuQ+Oe05oZZVyMcychVhjwaCYWfopOme
	 7QC/OKFQE0T1GiF3q2i7E/O77CSIN70Z2VDF7fcVjKrMzZYBMBAk4C3sEaTrAcMqZ+f/c
	 nLfXxPFbLtrmGVIYN+mDbd9lzxou5iYWgGtgJq1OB7HLewiFGFFNESK3szl2SppIq0JaE
	 +awixrKAEnrKdWwew23gjtXpWwQj39lc5c4K9OUM/GldigRj4sji8pePcK8SfsgkhHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AA5TjU0i2VptWU2CIiZhFzdqAC8AHwpJKD5JJh+9tl8=;
	b=L47tt0v4y/gzYexFHzvq3VXqTZ0y+nzz7UvuxGU+7SgLFT35YxdjGhBD7daziZ5YzMPC
	 KjyHRoNiq0jkGK8iWAQ2cOw+ZaU4cgFC3yqacioPq75NtZ/9q1q94pgH0cDGvvU4/geom
	 sgcf33ZLc90psMEJljFjC0/kLd+jrkjBY3NnNkAoG/aZUIkHcTfu3tg8fe9TIEMCDGViA
	 mUJYNirs9MkZmJ9Cf7izHot8o/emOEhwe6+OyV+Z8jsGHOmC9BRERhLneAj23/4xHk387
	 7RQJoBqDjXL6km75XjOFc/6gXHv+D5A27HI7O2UXgtpsZDMKBCif94sdPtzH+LHsERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0d3kzaR6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74688606A320
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74688606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0d3kzaR6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso11633305e9.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446785; x=1794051585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AA5TjU0i2VptWU2CIiZhFzdqAC8AHwpJKD5JJh+9tl8=;
        b=0d3kzaR6IfQ5zd2ELiT6tg90r0/ZKr0HXJ8voE6fmVICtAHNbGAgs84I+E4elDMOX1
         TuiEnMyeQpLtal/fJSt4YWqX2tdcs3nFgMhsS9CrKhLLlgdTzQreiiSOiO2+Zw2hDipI
         BBhw3biOBym+t9XoaxfSvoQcimZJaaZYJIbo+q2zKn4ThKQLfr0bgunraZYZFGTTdrOh
         YKZ5STbxXNbJDVirGoyD0l+CQaEv3laQ5L2VTFyMwjrqfQHzQLkuPmuhOJmViwAYwzJg
         2on731CiBDyTg6a1fH5d+vU707E6ZIIMeqhPzZUjgF5Dxo1XbiDP4vVc5KPAfY572lap
         /WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446785; x=1794051585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AA5TjU0i2VptWU2CIiZhFzdqAC8AHwpJKD5JJh+9tl8=;
        b=GV+hjvQIWa/b735EGhaDJ+0YotAdjkrSCoM1E1RJaeTA+gPOKc3alycX+BVbxJFbrr
         TITZ+UexWJOezHdM0FqxX3uH3jmwsKwSj5TOWZixtrtENFfhfUF6OkgLPpPPg0SuX0bG
         bN4cic7BHUmifYlbM4A7gaVRkB2rG/bdH4xgggwxLCqvugAVTLInlcW/9oCWJcuaZdKS
         CilKP9YWhjR9PY5weH1kWpSGt7ZiXyeLGH094y/wQLge4FR9bpUJuRRv7kGDXmulTo81
         UZXVVh8rhZ2Dowz1t7IeVvcZG/H1ilqIhnT3mCzZPfaUPoXKscxVtw5CW6753NJVhg3y
         au5w==
X-Gm-Message-State: AFq9FYKd7bkcl/glNoqJINz760mp2SkgUcIyqDPykeOqw8IUm++8fshR
	LX1o6oIej5ChIFPBf9J9s8h8MUuVy8VxZtlDS/UjAd7+N7fhRJcsWDum9r1TzxHt
X-Gm-Gg: AYBFou08wRzJGeSErJmYnVxC3mnAexLKKdNpog3f6oKWx9Fw5zqEmFMIGnXI0cNd6Fu
	Bv4sh1pIZEl0iZvGyglI8W4L3EIROoJnM1eKFPgstsrbGdWuKieFTiziegsc4CgWC39YtZRB3+8
	3NGr5yQKqgPvP8YOE7v8bG03Th9BLPEZiMjAlojbcuIWeDkFsJ/0G0n98OrBG7g13IDlHtSGQrX
	elztsW7ejO0YpLJkHH0lPXgC8/GWk8+IscjF/4ExLONC6huBWtKw5h4C0nxVrtSURxj8YnWLn9Z
	B9IjvOE4au1pgYmhej89cXnpGaW7Xdd4RHWO0vDPdCoN6fzPjaqnBRecFF/aGKrTsBtlNzdEETh
	Rjd8U0TqdA/Ztwu8HXlan9xuvs1PbPW9NAE4hIrjMdloDvccm+YHUbT2NaNzqGOtWNPJVW/x213
	v5tz25QxSnvXzDd7EM5tVFJ3loq2tIP8YTP5xV2NadoiZA9nqy+BDteQAUYEGlaoHhfjk4Q/7ZA
	dtlfsIrq4jBJlod7bHlPwM984sh9X6NkwUGnP+9+/OJ78V7FcWqWjQFBzkdfrATqU9Xwe4RDIsq
	0HRwEOYbKNaq4FiN1u6rrCd02bBV7bvGt/VuPNmm29AC5qlulBaqrsJ3yLLHUmY=
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr112844105e9.9.1793446784746;
        Sat, 31 Oct 2026 04:39:44 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm8345366f8f.23.2026.10.31.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:39:44 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 1/4] unpack-objects: use size_t for object sizes
Date: Sat, 31 Oct 2026 12:39:35 +0100
Message-ID: <f259eeb6a6432e20a541e94d8496f9f8299d7bdd.1793446357.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793446357.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
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

builtin/unpack-objects.c uses "unsigned long" to track object sizes
throughout the file, while sizes read from packs are handled as size_t.
On platforms where "long" is 32 bits, this truncates the size for
objects of 4GiB or more.

When handling large objects on those platforms, unpack-objects fails
rather than corrupting data. For instance, streaming large blobs
(exceeding core.bigFileThreshold) passes a truncated size to
stream_blob(), causing the stream write to fail with an error.

Use size_t across the board in builtin/unpack-objects.c and remove the
now-unnecessary size cast in unpack_delta_entry(). Downstream consumers
like odb_write_object() and fsck_object() are updated separately.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/unpack-objects.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 351948724a..6c830a606f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -40,7 +40,7 @@ static struct progress *progress;
  */
 struct obj_buffer {
 	char *buffer;
-	unsigned long size;
+	size_t size;
 };
 
 static struct decoration obj_decorate;
@@ -50,7 +50,7 @@ static struct obj_buffer *lookup_object_buffer(struct object *base)
 	return lookup_decoration(&obj_decorate, base);
 }
 
-static void add_object_buffer(struct object *object, char *buffer, unsigned long size)
+static void add_object_buffer(struct object *object, char *buffer, size_t size)
 {
 	struct obj_buffer *obj;
 	CALLOC_ARRAY(obj, 1);
@@ -114,10 +114,10 @@ static void use(int bytes)
  * allocated buffer which is reused to hold temporary zstream output
  * and return NULL instead of returning garbage data.
  */
-static void *get_data(unsigned long size)
+static void *get_data(size_t size)
 {
 	git_zstream stream;
-	unsigned long bufsize = dry_run && size > 8192 ? 8192 : size;
+	size_t bufsize = dry_run && size > 8192 ? 8192 : size;
 	void *buf = xmallocz(bufsize);
 
 	memset(&stream, 0, sizeof(stream));
@@ -161,7 +161,7 @@ struct delta_info {
 	struct object_id base_oid;
 	unsigned nr;
 	off_t base_offset;
-	unsigned long size;
+	size_t size;
 	void *delta;
 	struct delta_info *next;
 };
@@ -170,7 +170,7 @@ static struct delta_info *delta_list;
 
 static void add_delta_to_list(unsigned nr, const struct object_id *base_oid,
 			      off_t base_offset,
-			      void *delta, unsigned long size)
+			      void *delta, size_t size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
 
@@ -261,7 +261,7 @@ static void write_rest(void)
 }
 
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size);
+			 void *data, size_t size);
 
 /*
  * Write out nr-th object from the list, now we know the contents
@@ -269,7 +269,7 @@ static void added_object(unsigned nr, enum object_type type,
  * to be checked at the end.
  */
 static void write_object(unsigned nr, enum object_type type,
-			 void *buf, unsigned long size)
+			 void *buf, size_t size)
 {
 	if (!strict) {
 		if (odb_write_object(the_repository->objects, buf, size, type,
@@ -310,8 +310,8 @@ static void write_object(unsigned nr, enum object_type type,
 }
 
 static void resolve_delta(unsigned nr, enum object_type type,
-			  void *base, unsigned long base_size,
-			  void *delta, unsigned long delta_size)
+			  void *base, size_t base_size,
+			  void *delta, size_t delta_size)
 {
 	void *result;
 	size_t result_size;
@@ -330,7 +330,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
  * resolve all the deltified objects that are based on it.
  */
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size)
+			 void *data, size_t size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -349,7 +349,7 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type type, unsigned long size,
+static void unpack_non_delta_entry(enum object_type type, size_t size,
 				   unsigned nr)
 {
 	void *buf = get_data(size);
@@ -386,7 +386,7 @@ static ssize_t zlib_stream_read(struct odb_stream *in_stream,
 	return buf_len - zstream->avail_out;
 }
 
-static void stream_blob(unsigned long size, unsigned nr)
+static void stream_blob(size_t size, unsigned nr)
 {
 	git_zstream zstream = { 0 };
 	struct zlib_stream in_stream = {
@@ -420,7 +420,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
-				void *delta_data, unsigned long delta_size)
+				void *delta_data, size_t delta_size)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
@@ -435,12 +435,11 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 	return 1;
 }
 
-static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
+static void unpack_delta_entry(enum object_type type, size_t delta_size,
 			       unsigned nr)
 {
 	void *delta_data, *base;
-	unsigned long base_size;
-	size_t base_size_st = 0;
+	size_t base_size = 0;
 	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
@@ -517,8 +516,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		return;
 
 	base = odb_read_object(the_repository->objects, &base_oid,
-			       &type, &base_size_st);
-	base_size = cast_size_t_to_ulong(base_size_st);
+			       &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
-- 
2.53.0

