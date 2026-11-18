Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985007;
	b=4cMaV2WQ8LWseQ72pOSUcY3otrOjGWEqnC+2Jfj36Yr8oofiZl5WS802tNscxjsdHVNK
	 oe3rN5bTFjjNXgQfCT+4ndFNJbJcwX4PwU3Cx+C7gZKOihrwhr57Mo2TNIpPu5eI9f+fv
	 /7/2VbtkWXUi9D71n8zDpwy00btjw9Z0VlGC3AnNyDb7sFEQ4QHs2Dy3m84ehE2h/vv0b
	 z/rP3durxIi/UUgtcDoJsqz4g3dGFnTELGxpvb79xExPUd5incvD17FDeq4yL+q57HR+f
	 gw3enjJzP7FfFYWPW4pjn4Z3g/vAvmpMIgdHu7pTcdn/96OQRuI0Ie02KPi/nY2QvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2F6fzWHzA+gPK95D94UOTohXtcF6WKgjQ50XkhPNm/I=;
	b=w3BcpjnWFmG6kiKybzbpwrKM1tsHSK5fSzMmHWvlZZp1N2OQNtbmtlTS1FC/Bn8YLsue
	 7/8c8UWQUflNaAWr0p7qcpGjYCVoi46IUzP0gqSUs662JKg43zCgDgUv2Tt9AcbWDOI+s
	 WI7O5A9YRsHbo1/PBb/GrOUETDvMCEsW34rN+tIQ6BlOPg27Ad/Ipc8EiMjhNy3+p8Ey/
	 TefZgWOm1NPX2yHrHv67uaSJRLWViXFPWW0VcF7VIRhNw6MSAjFFIUr82relIGPuE0lHJ
	 AVtPpu8ze44nhU0uNC55aEeFGVPrtBIDFO/1hxBLaY5VZ6IQ7F/rqxw3da6CHP+4+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFWgPU9p;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6D606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFWgPU9p
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49d64a88222so1045993f8f.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794985005; x=1795589805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2F6fzWHzA+gPK95D94UOTohXtcF6WKgjQ50XkhPNm/I=;
        b=AFWgPU9pJ/XdBMftBRIaPUM4JRUhm0ofJdxlemD9OB2L6cHQLjp611q8S85TU4Dawr
         +ErgrFO0rbZjR3xeHQPHQOPKi73GEJ5WnqEtW+5brkLHAH0Xnl0bhhqiIpcFObwZP4gz
         dRkiKpySGnpwpGh5b8kaB8DXoSOBqitbznXEuCXGxmuqYsYKF8SIV93nu4LQNFbz1fqx
         YddG13oiSVc6NcQ1nRQE4QLvLBIVoklQvBbrqK4khT6ZLZCdCfYQFdOvFbrxnvdn3Wxy
         EV8p2kO0J2spxDKQZAsBmSsPeEyF0vBnrvbr10N5xf2Vz1h2SsnGcH47Wb2VmWjud1oW
         Jigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794985005; x=1795589805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2F6fzWHzA+gPK95D94UOTohXtcF6WKgjQ50XkhPNm/I=;
        b=W9FokhFaJ9Y5onOMjr6AJOOBLAAQVLS4taItLKWv+gBHZGSpMoApHn91znHbCNmuU0
         +6UCVjzFsbTqfy6RMEwN1NMSCGkTkMMBM5ph4ELvG/AH2QjfsPeQMe81Z3zlEPvgWHyF
         Y5LLBoryQgb8JDDgrLRevdn0F7jpX41u6WBwpJF/ERTJODxM13vn15odHboaIlESihqD
         tUmggZej3rbqLtPEiAJ8yU0NjvEGsRhdeOpITRlGranBlJHNuI1C2O47r3mRdS+2wPy2
         B7UglFJH5yGQbdviGPr3Jfw4lYHpDKehqpro6jdkxammMryKAJdgDoLE9B8Ez/nJozQO
         XXyQ==
X-Gm-Message-State: APuU4Z9Y9IPlqj3/L6Y+l4piV8gayKlNDdj7NfyBWk97QRGWxkiTmume
	mh9/8Fsfp2Y4WqsLuIBSMw7gwGiZZ17XPZWetZ1JIdTGm/zAhHqQYuYAIHDz0w==
X-Gm-Gg: AYBFou38Lj9rKFRraO6dK7D1YNlm78rxRDaczE8wJrz1fhu+G/PTtnTlcvhkdcu3OSc
	gjwQU6Vxh45anhoNWWze5pt7LXNd+D5BycSXbLUexKGTQF66MDlh08U3TG4V4yYz+KCdG8+iFEI
	BN0OW0sX3DnhIXWNEwS3wDPx1h8Xui1FZwNGvXQLZLrxEp9PsTjZprILUN6Q7API7xKEfSKVU7m
	R+u/UrjGorqoygDqwfoBcoIbUBRiCmdWWIe/2r6gHjEfgNNxEwb4jcJ4AvGbq0D9MyPkJ9iqD2P
	7yuB5hs734vEOpkkf/6dNuhWp/AINFyyR3z34oPGiLcFFgByGvgeJ6QYNImMlHAc1g70frSpFih
	XQs5nF6IbQdHSxg8htih+oEVNp0/ItIzr5sCdDlB87OfGU9ue9i2++Cw6LTkVMnA0lSN86+COX4
	czSVQ/5p8DFCzlzoPMC9XxIRjfGStdcZdSHv7hN68GYIxTxDWYRmuo83M3u0KTY4EhaA1yn3c8I
	YKXlt6Apf2ah8HzVw/P4FvEDWXDRX2UQcD1CjjSLx6edxUOfNa9Zd8RTYNbGGCQGP8xsTEPWnMs
	tJRodC98edFDj0XYlbe+ETNk6VHQt7J0crFojHU60s7J7lufe4DNintlxRzL+pQ=
X-Received: by 2002:a05:600c:6708:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb7da267f5mr28680845e9.13.1794985004766;
        Tue, 17 Nov 2026 22:56:44 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm222311235e9.3.2026.11.17.22.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:56:43 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: [PATCH v2 0/4] use size_t when receiving and verifying packs
Date: Wed, 18 Nov 2026 07:56:34 +0100
Message-ID: <cover.1794984184.git.gitter.spiros@gmail.com>
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

This series fixes object sizes that are truncated when receiving and
verifying packs. Most of them are kept in an "unsigned long", which is
a problem where "long" is 32 bits while size_t is 64, such as on 64-bit
Windows; 2/4 is about an "unsigned int", which is 32 bits everywhere.

 1/4 unpack-objects fails with "inflate returned -5" on an object of
     4GiB or more that is not streamed, dies on a delta base that
     large, and silently writes a truncated object for a delta result
     that large. With 1/4, "unpack-objects -n" and large delta bases
     work, and writing such an object, unless it is streamed, dies
     with a clear error.

 2/4 "index-pack --fix-thin" with a local base of 4GiB or more
     compresses only part of it and dies later with "serious inflate
     inconsistency" (all platforms).

 3/4 index-pack reports a false "SHA1 COLLISION FOUND" for a large
     object that already exists locally.

 4/4 "git fsck" checks only a prefix of large objects in packs.

None of them comes with a test, as each needs an object of 4GiB or
more; 1/4 and 2/4 describe how I checked them with the size truncated
to 16 bits.

Changes since v1:

 - Rebased onto master at e1ec09b23c (The 22nd batch). v1's 1/4 no
   longer applied: e07ac16d1c (unpack-objects: pass the size of a
   streamed blob as size_t, 2026-11-06) by Kristofer Karlsson, now in
   master, makes the same change to stream_blob(). 1/4 drops that hunk;
   Kristofer is Cc'd.

 - The message of 1/4 used stream_blob() as its only example, so it is
   rewritten around the paths that are still affected: objects that
   are not streamed, all blobs with "git unpack-objects -n", and
   deltas.

 - 1/4 no longer drops the cast_size_t_to_ulong() in
   unpack_delta_entry(), but moves it to write_object(), where the size
   is passed to odb_write_object() and parse_object_buffer(). v1 let
   objects of 4GiB or more reach these functions and be written
   truncated.

 - 4/4 says that parse_object_buffer() and fsck_object() still see a
   truncated size until they take a size_t.

 - The messages of 1/4, 3/4 and 4/4 now say that the problem is "long"
   being 32 bits while size_t is 64. The code of 2/4, 3/4 and 4/4 is
   unchanged.

There were no comments on v1.

v1 left pack-objects for a later series. That fix has since been
merged as ep/pack-objects-streamed-large-blobs-fix (ed0aed1e17); it
covers the streamed path and explains why the other truncations in
pack-objects cannot be reached.

The callees odb_write_object(), parse_object_buffer() and
fsck_object() still take an "unsigned long" on master. They are changed
by two other series of mine, which are not queued yet:

  https://lore.kernel.org/git/cover.1793444420.git.gitter.spiros@gmail.com/
  https://lore.kernel.org/git/cover.1793439137.git.gitter.spiros@gmail.com/

The series is based on master at e1ec09b23c.

Elia Pinto (4):
  unpack-objects: use size_t for object sizes
  index-pack: use size_t in write_compressed()
  index-pack: use size_t for object sizes
  pack-check: use size_t for the size passed to verify callbacks

 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     | 14 +++++++-------
 builtin/unpack-objects.c | 42 ++++++++++++++++++++--------------------
 odb.h                    |  2 +-
 pack.h                   |  2 +-
 5 files changed, 31 insertions(+), 31 deletions(-)

Range-diff against v1:
1:  f259eeb6a6 ! 1:  b2c3d349a4 unpack-objects: use size_t for object sizes
    @@ Metadata
      ## Commit message ##
         unpack-objects: use size_t for object sizes
     
    -    builtin/unpack-objects.c uses "unsigned long" to track object sizes
    -    throughout the file, while sizes read from packs are handled as size_t.
    -    On platforms where "long" is 32 bits, this truncates the size for
    -    objects of 4GiB or more.
    +    Since f2063855fb (index-pack, unpack-objects: use size_t for object
    +    size, 2026-05-08), unpack_one() decodes the size of an object into a
    +    size_t, and e07ac16d1c (unpack-objects: pass the size of a streamed
    +    blob as size_t, 2026-11-06) passes it on as such to stream_blob(),
    +    which handles blobs larger than core.bigFileThreshold. The rest of
    +    builtin/unpack-objects.c still takes the size as an "unsigned long":
     
    -    When handling large objects on those platforms, unpack-objects fails
    -    rather than corrupting data. For instance, streaming large blobs
    -    (exceeding core.bigFileThreshold) passes a truncated size to
    -    stream_blob(), causing the stream write to fail with an error.
    +     - unpack_non_delta_entry() and get_data(), used for commits, trees,
    +       tags and blobs below core.bigFileThreshold, and for all blobs with
    +       "git unpack-objects -n", which never streams;
     
    -    Use size_t across the board in builtin/unpack-objects.c and remove the
    -    now-unnecessary size cast in unpack_delta_entry(). Downstream consumers
    -    like odb_write_object() and fsck_object() are updated separately.
    +     - unpack_delta_entry() and the functions that keep and resolve
    +       deltas;
     
    -    Triggering this requires processing 4GiB or more of input on a platform
    -    where "long" is 32 bits, so no test is added.
    +     - struct obj_buffer, which keeps objects around for --strict.
    +
    +    On platforms where "long" is 32 bits while size_t is 64, such as 64-bit
    +    Windows, the size of an object of 4GiB or more is therefore truncated:
    +
    +     - For an object that is not streamed, get_data() allocates a buffer
    +       of the truncated size, inflate runs out of room in it, and
    +       unpack-objects fails with "inflate returned -5". Truncating the
    +       size to 16 bits in get_data() and unpack_non_delta_entry()
    +       reproduces this with a pack holding a 70000-byte blob, both with
    +       and without -n.
    +
    +     - unpack_delta_entry() reads the base of a delta through
    +       cast_size_t_to_ulong(), so a base of 4GiB or more makes it die even
    +       when the result would be smaller.
    +
    +     - The result of a delta reaches write_object() as a size_t, but
    +       write_object() takes it as an "unsigned long". A result of 4GiB or
    +       more is silently truncated there, and an object with the wrong
    +       contents, hence the wrong name, is written.
    +
    +    Use size_t across builtin/unpack-objects.c. The functions that
    +    write_object() hands objects to, odb_write_object() and
    +    parse_object_buffer(), still take an "unsigned long", as does
    +    fsck_object(); they are updated separately. Until then, move the size
    +    cast from unpack_delta_entry() to write_object(), where the size is
    +    passed to them. fsck_object() only sees objects that went through
    +    parse_object_buffer() first, and so does write_cached_object(), which
    +    writes them out later; neither needs a cast of its own.
    +
    +    As a result, on those platforms:
    +
    +     - "git unpack-objects -n" handles objects of any size;
    +
    +     - a delta with a base of 4GiB or more and a smaller result is
    +       resolved;
    +
    +     - an object of 4GiB or more that is not streamed and has to be
    +       written, including the result of a delta, makes unpack-objects die
    +       with "object too large to read on this platform" instead of failing
    +       with "inflate returned -5" or being written truncated.
    +
    +    Truncating the size to 16 bits where write_object() passes it on
    +    confirms the last point for a 70000-byte blob: with the cast,
    +    unpack-objects dies with "object too large to read on this platform:
    +    70000 is cut off to 4464"; without it, it exits with 0 and writes a
    +    truncated blob under another name.
    +
    +    Triggering this requires processing an object of 4GiB or more on a
    +    platform where "long" is 32 bits while size_t is 64, so no test is
    +    added.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +			 void *buf, size_t size)
      {
      	if (!strict) {
    - 		if (odb_write_object(the_repository->objects, buf, size, type,
    +-		if (odb_write_object(the_repository->objects, buf, size, type,
    ++		if (odb_write_object(the_repository->objects, buf,
    ++				     cast_size_t_to_ulong(size), type,
    + 				     &obj_list[nr].oid) < 0)
    + 			die("failed to write object");
    + 		added_object(nr, type, buf, size);
    +@@ builtin/unpack-objects.c: static void write_object(unsigned nr, enum object_type type,
    + 		obj_list[nr].obj = NULL;
    + 	} else if (type == OBJ_BLOB) {
    + 		struct blob *blob;
    +-		if (odb_write_object(the_repository->objects, buf, size, type,
    ++		if (odb_write_object(the_repository->objects, buf,
    ++				     cast_size_t_to_ulong(size), type,
    + 				     &obj_list[nr].oid) < 0)
    + 			die("failed to write object");
    + 		added_object(nr, type, buf, size);
    +@@ builtin/unpack-objects.c: static void write_object(unsigned nr, enum object_type type,
    + 				 &obj_list[nr].oid);
    + 		added_object(nr, type, buf, size);
    + 		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
    +-					  type, size, buf,
    ++					  type, cast_size_t_to_ulong(size), buf,
    + 					  &eaten);
    + 		if (!obj)
    + 			die("invalid %s", type_name(type));
     @@ builtin/unpack-objects.c: static void write_object(unsigned nr, enum object_type type,
      }
      
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      				   unsigned nr)
      {
      	void *buf = get_data(size);
    -@@ builtin/unpack-objects.c: static ssize_t zlib_stream_read(struct odb_stream *in_stream,
    - 	return buf_len - zstream->avail_out;
    - }
    - 
    --static void stream_blob(unsigned long size, unsigned nr)
    -+static void stream_blob(size_t size, unsigned nr)
    - {
    - 	git_zstream zstream = { 0 };
    - 	struct zlib_stream in_stream = {
    -@@ builtin/unpack-objects.c: static void stream_blob(unsigned long size, unsigned nr)
    +@@ builtin/unpack-objects.c: static void stream_blob(size_t size, unsigned nr)
      }
      
      static int resolve_against_held(unsigned nr, const struct object_id *base,
2:  438f7c6ba2 = 2:  9952f0fb10 index-pack: use size_t in write_compressed()
3:  0258282745 ! 3:  e66860d274 index-pack: use size_t for object sizes
    @@ Commit message
         Functions like sha1_object() and append_obj_to_pack() in
         builtin/index-pack.c take object sizes as an "unsigned long", even
         though struct object_entry already tracks them as size_t. On platforms
    -    where "long" is 32 bits, this truncates the size for objects of 4GiB or
    -    more.
    +    where "long" is 32 bits while size_t is 64, such as 64-bit Windows,
    +    this truncates the size of objects of 4GiB or more.
     
         When receiving, on those platforms, a large object that already exists
         locally, sha1_object() compares the real size (size_t) against the
    @@ Commit message
         Use size_t for the size parameter across these functions.
     
         Triggering this requires processing 4GiB or more of input on a platform
    -    where "long" is 32 bits, so no test is added.
    +    where "long" is 32 bits while size_t is 64, so no test is added.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
4:  87b0d2bd96 ! 4:  00939c7f1b pack-check: use size_t for the size passed to verify callbacks
    @@ Commit message
         replicated in struct odb_fsck_options (odb.h) and implemented by
         fsck_obj_buffer() in builtin/fsck.c.
     
    -    On platforms where "long" is 32 bits, running "git fsck" on packs with
    -    objects of 4GiB or more passes a truncated size to fsck_obj_buffer(),
    -    causing parse_object_buffer() and fsck_object() to inspect only a
    -    prefix.
    +    On platforms where "long" is 32 bits while size_t is 64, such as
    +    64-bit Windows, running "git fsck" on packs with objects of 4GiB or
    +    more passes a truncated size to fsck_obj_buffer(), causing
    +    parse_object_buffer() and fsck_object() to inspect only a prefix.
     
         Use size_t for the size parameter in verify_fn,
         struct odb_fsck_options.object_cb, and fsck_obj_buffer().
    +    parse_object_buffer() and fsck_object() themselves still take an
    +    "unsigned long"; until they are updated separately, they keep
    +    inspecting only a prefix.
     
         Triggering this requires processing objects of 4GiB or more on a
    -    platform where "long" is 32 bits, so no test is added.
    +    platform where "long" is 32 bits while size_t is 64, so no test is
    +    added.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.53.0

