Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985008;
	b=js+6+KkI3M7SHV7BjWuNPMC8hCVz05Nf6BsD1pXYeaqnS6CZ3Tery6RiKDxmb38G1kTZ
	 B79ZJYYAe4mtAJK9KSUpGX7KYcyXJFJrgO2qQiTY834AhvO5LiVj1P++ZaJwL7eSj2TpW
	 PoWhwsw2fwX00NkRtWI3TVhn3Bm5+qRgiHhUnSkfgy4fSuDqnm/BM+wwvItTESa7pyuhP
	 reFn6X51h//kH4xNUQ5m9wEXlSEN4TdWDYiVqoJ4vQYRGWnJ1TNpPNQZIQX+mp+JkNOU2
	 oQE+ifwYFVl1PPfjqqOaI9MCXrYnUDLEVL4MEPxy2iVRfphNbubIzOrb8kK9lXBtZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EG/FjE0NIvYUh8L+hen96J0lBc/GuACk/O8oj+cJeBI=;
	b=EZMfls26qvy8ZlaRoBjy+eGeHN6R1ZGT6E/ckuD3ARxw5vd2yzxLAdIoBMpHKAMLWdXg
	 HjGA372iEKxItnIYTN/TL4HgUHAXHihlXnoQBAqBI9MIm0XcKWJsSCRcfH9syOaqu8mrW
	 hdUbcAL3Ta08pTsn4OaD3Rz6VpgBt+weiKkX7xIexnOD5bERyZ5xxhqPhhmzL3m9FxTD6
	 rAupqIThZ+omAKV9hPUsZqJvcZXlkuFcVb2Wma1qYPNvg7POLk8qW1sl3bOgpq1Uw812j
	 LADSsvcgjVzvrDLznVsfWqqDjTlsS03iLS/XZm2Ze+euuCjue2pBhhbPrJkx8x/t/tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bk0/Chtv";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B48606A331
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B48606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bk0/Chtv
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so6867455e9.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794985006; x=1795589806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EG/FjE0NIvYUh8L+hen96J0lBc/GuACk/O8oj+cJeBI=;
        b=bk0/Chtvyu/CRCQM42yfSJg1zir6JX9BNR8TGgrmbHLW/cx5pG6FNQpq3rIDxQFFAJ
         NK3SnbNB70PnwmjIIAW6mgKUZPuvuecpWqurdNMCycLthUgC6Ocqx8YcmTdwpfYhQ7Xn
         9PHBoTI2Je6X/nu//Q8Ka2x4NpUzVq8eonjbFB8auzLb4zIX5PfuYQ2IpDDaUH6CRxjl
         /VLflJ4XhkamDQh4JdVLJhzRwCAJw0hmdwTyi7b1REySyTv6IeTluv2XqoO/FOXYoEu3
         2LY4zxj2he1vLKkQPjBzYuPTJaVknI+HawnTujmdWLICVVkqvU+82U4m6zfYZKkbivUZ
         ZBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794985006; x=1795589806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EG/FjE0NIvYUh8L+hen96J0lBc/GuACk/O8oj+cJeBI=;
        b=UrDthLDsxTCAcbiMK8JimzaUKrdPE2BwddsnJyUr//m6WbFq7iAdU5oi5vXkIMiheN
         m8KOcKxzRy1AZA3NFOph698Bo3KeiGbkoDgWQG4bX5X5Vkhg0lm2gcShUXEW/Jg2EAME
         QpEXzyRYjVGAsV1gozJqdy315m5pLc5ggjeiQ8gS/v0WBpgoKqd1MmGoA+EJwh2OfIGR
         /EF8YiWqi+lmd5Lz2w+oPKlEsNNYV9hxN7oZe2apjDZb0Fiy4MhjBOfaFtlUZ6CGrUoT
         jabcpxbzpaXr2be05lt8tl/kfFhpPWh8X+8Kh9oFbzocJ9JUow2jDcquVrSt13y9zVd8
         iwiQ==
X-Gm-Message-State: APuU4Z8Wd94TRrMwrVVjmJflXZpkGK0kF53+Htew9ERiavbVbJ2ig1AA
	WJe5I11l12e2nIZkP6O8EeDhrzJjKi2IyHQrhE3IKrjP4RJxd5s5vrkmK/3Ttw==
X-Gm-Gg: AYBFou0gMa9c9HjuHrEsJNL/+1vkPHXldlh46mAWdXvG6FZa9Fx6f0TILLgJHkF89Mh
	fX0GWf83Ls9/78vHNQv9xUOQraYYfLmMsxwJI5ZzrIxKLnv2o9ejDvM47AemXTk7peY36GB/QtJ
	RCFWJTABdJ0cCQSf3XsTtaf0xonnfDokqCsUneYoGlZ+7eYnfujh4FJalAXIQVjakY6ey/6K3or
	4niBhPeSFL6iTmwNmBfbsBD0OP27APZN0EFSgJf4cWMI2PVUtUNckMBaX+ffyouoIhSSUIQUxOx
	DNQ9XuuVD+hEfwyvfoiZsr7ez8Gp0T58AvCr2MaLXyXU5nT5sSRfUFJ7bMZIHb9XSQ7+U9aDn79
	EFx51gJfoCzLAO/lnXo1UqCguCrRNkUa86aCt9rTU39eorkfPk+3kHVZpHHfQp/5pgR+4TM/Szj
	bV0tN1T+SI3InEasK7RG+07pbr6Kro2c4MyDvpx9KlBDas20588SD6US9O4/AaPsy/tJL/scFXV
	Bbvdgfjts6hjk2mpE+IiQ6tlBMWwgfmQ1a9DN92wARr1G4I7iG/onmRqCsmCZ+7DN23ENpnIbm3
	ZANJK8/Pfgk0KXoApse9XYTX1NseuOVzOEZ7fHEgu138o5gCpvssTWAwUqf8hqk=
X-Received: by 2002:a05:600c:3b84:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb7da2243fmr31689945e9.9.1794985006256;
        Tue, 17 Nov 2026 22:56:46 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm222311235e9.3.2026.11.17.22.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:56:45 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
Date: Wed, 18 Nov 2026 07:56:35 +0100
Message-ID: <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794984184.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com>
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

Since f2063855fb (index-pack, unpack-objects: use size_t for object
size, 2026-05-08), unpack_one() decodes the size of an object into a
size_t, and e07ac16d1c (unpack-objects: pass the size of a streamed
blob as size_t, 2026-11-06) passes it on as such to stream_blob(),
which handles blobs larger than core.bigFileThreshold. The rest of
builtin/unpack-objects.c still takes the size as an "unsigned long":

 - unpack_non_delta_entry() and get_data(), used for commits, trees,
   tags and blobs below core.bigFileThreshold, and for all blobs with
   "git unpack-objects -n", which never streams;

 - unpack_delta_entry() and the functions that keep and resolve
   deltas;

 - struct obj_buffer, which keeps objects around for --strict.

On platforms where "long" is 32 bits while size_t is 64, such as 64-bit
Windows, the size of an object of 4GiB or more is therefore truncated:

 - For an object that is not streamed, get_data() allocates a buffer
   of the truncated size, inflate runs out of room in it, and
   unpack-objects fails with "inflate returned -5". Truncating the
   size to 16 bits in get_data() and unpack_non_delta_entry()
   reproduces this with a pack holding a 70000-byte blob, both with
   and without -n.

 - unpack_delta_entry() reads the base of a delta through
   cast_size_t_to_ulong(), so a base of 4GiB or more makes it die even
   when the result would be smaller.

 - The result of a delta reaches write_object() as a size_t, but
   write_object() takes it as an "unsigned long". A result of 4GiB or
   more is silently truncated there, and an object with the wrong
   contents, hence the wrong name, is written.

Use size_t across builtin/unpack-objects.c. The functions that
write_object() hands objects to, odb_write_object() and
parse_object_buffer(), still take an "unsigned long", as does
fsck_object(); they are updated separately. Until then, move the size
cast from unpack_delta_entry() to write_object(), where the size is
passed to them. fsck_object() only sees objects that went through
parse_object_buffer() first, and so does write_cached_object(), which
writes them out later; neither needs a cast of its own.

As a result, on those platforms:

 - "git unpack-objects -n" handles objects of any size;

 - a delta with a base of 4GiB or more and a smaller result is
   resolved;

 - an object of 4GiB or more that is not streamed and has to be
   written, including the result of a delta, makes unpack-objects die
   with "object too large to read on this platform" instead of failing
   with "inflate returned -5" or being written truncated.

Truncating the size to 16 bits where write_object() passes it on
confirms the last point for a 70000-byte blob: with the cast,
unpack-objects dies with "object too large to read on this platform:
70000 is cut off to 4464"; without it, it exits with 0 and writes a
truncated blob under another name.

Triggering this requires processing an object of 4GiB or more on a
platform where "long" is 32 bits while size_t is 64, so no test is
added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/unpack-objects.c | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index d2f25bed49..9bd355b2c4 100644
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
@@ -269,10 +269,11 @@ static void added_object(unsigned nr, enum object_type type,
  * to be checked at the end.
  */
 static void write_object(unsigned nr, enum object_type type,
-			 void *buf, unsigned long size)
+			 void *buf, size_t size)
 {
 	if (!strict) {
-		if (odb_write_object(the_repository->objects, buf, size, type,
+		if (odb_write_object(the_repository->objects, buf,
+				     cast_size_t_to_ulong(size), type,
 				     &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
@@ -280,7 +281,8 @@ static void write_object(unsigned nr, enum object_type type,
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (odb_write_object(the_repository->objects, buf, size, type,
+		if (odb_write_object(the_repository->objects, buf,
+				     cast_size_t_to_ulong(size), type,
 				     &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
@@ -299,7 +301,7 @@ static void write_object(unsigned nr, enum object_type type,
 				 &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
-					  type, size, buf,
+					  type, cast_size_t_to_ulong(size), buf,
 					  &eaten);
 		if (!obj)
 			die("invalid %s", type_name(type));
@@ -310,8 +312,8 @@ static void write_object(unsigned nr, enum object_type type,
 }
 
 static void resolve_delta(unsigned nr, enum object_type type,
-			  void *base, unsigned long base_size,
-			  void *delta, unsigned long delta_size)
+			  void *base, size_t base_size,
+			  void *delta, size_t delta_size)
 {
 	void *result;
 	size_t result_size;
@@ -330,7 +332,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
  * resolve all the deltified objects that are based on it.
  */
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size)
+			 void *data, size_t size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -349,7 +351,7 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type type, unsigned long size,
+static void unpack_non_delta_entry(enum object_type type, size_t size,
 				   unsigned nr)
 {
 	void *buf = get_data(size);
@@ -420,7 +422,7 @@ static void stream_blob(size_t size, unsigned nr)
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
-				void *delta_data, unsigned long delta_size)
+				void *delta_data, size_t delta_size)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
@@ -435,12 +437,11 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
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
@@ -517,8 +518,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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

