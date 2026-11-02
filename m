Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618434;
	b=F4B0LcV63npoNzm/RtDCfLuAoEK+4OakcZ6NGIrHaGif52wrnXrsNd4c9sRVQ0awTsX7
	 71LjBUUJBkrgLzPoV5R13eKMIDFu0YSuls4xVPpICqHPNZ4sFHyaRQ8G1PXFt5uumE5iJ
	 0u+CjwcXJ9UT0h3xYyJSgo7ur4sdzKh7HKP27ONynCc4ETHemP4pUXChcxQL+XFCSo3am
	 0qdt7UbHMjeXmRjEVtghRwRY/4cKR+RX3N5EpzLQX6qg8hD+utsNClwyxwDOWO3CiSrZ7
	 7yBd5IGdjvrlKqILMXUqvVCO5qXY1t/fVe1KYp/Wvc7k6/MLYYWD8oy7dLJPByus1+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618434;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=kJ1itmscyDMz+puzj00NSwdJ2qrqmNXkXYsjogApl/Q=;
	b=F4/QDe29aRUocBLXMTgyNvQqiVmDFwFExU50GhcZTjU2gPRNr8sO6EsUhmF/RMQ7x8aS
	 DrAUwAaxItfDchkLiuM1iLxwKT2M1EsCllrV/aMPFzcsWz78v8hlrSrgb4XRTQSa3EVwX
	 zFGcl49qCfcpFjdENZWwY2yb1HamiJeiLLnKL5YQURkv1bTcer250ly25xEsbFHuqoNwO
	 UupN410Uy6Res5cQnHgB5HzBEAQWr/xwdeaXJuj/KOtdmtN7FaBOKas14iqwJ0SA1bZRc
	 xDKGFNFf+QxhGnk6t/hgCoun1muw6pMRGggtgHjFtc80zMNrMJo773PlBidnaBr5/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="c9H/dKZ6";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c18tr5Sz;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C34606A32E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C34606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=c9H/dKZ6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c18tr5Sz
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02F057A0201
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618432;
	 x=1793704832; bh=kJ1itmscyDMz+puzj00NSwdJ2qrqmNXkXYsjogApl/Q=; b=
	c9H/dKZ6pEhtNQCO/3pId/12X2EfUWcPjWOnwdInvc6XkX/vhBq5CnB87WdkbcVH
	o8lRT4RZ93u04SKBGUAuEhQf9Rm2kCbc3mOyj0KRjl7tw2X1qiwIlDZRyu5u5f8Q
	AxRCXvenWLCZMpu+LOhYpEzIwbgUJK/xTa292AO/aqqn7EpLrgER71YSN3+XtX9U
	iwDTVE9b96IUVorRZUtpahAWFSW95KIscTqkKSs6BOT82TKNDPbDhD1kpJT8iz0d
	JB5NxiM6YgVUTuPdrtjrGiN6fSahFUPgNsP/XVZLReeuMCO67NfMnY/j/ThHwrVK
	tS4DsCwdwQz9ZWk0TZ7c5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618432; x=
	1793704832; bh=kJ1itmscyDMz+puzj00NSwdJ2qrqmNXkXYsjogApl/Q=; b=c
	18tr5Sz/0Zbe9PTlKZ4YC9RK8vunMEfwVAF621wj1hOheezmTDaVy9zRbf+iQEGb
	tScKdFfTApD4ZaQaqekDOq9XJU5K8AZMNJCRULH1Cl6M4+RbKehrYX0ABgPRriZR
	rp3Ha5qPddmLDCCgU2hBkDmHowD8k35MakhgbdlhSHZgdUL/xf17Z8oSGszcMJ7z
	H/Ym+Fko8pg13HcoIA+MkMh1gfqYteE784UElqYr1UCQG4QW9dF+o42CadK/2KDG
	myHTzGgryncfDbcVr02ci/4XZq9/z3MAcsKu10LCTsxh8QdFsmK6Ngf/CCrdY8iV
	yb2p33ULp4FekBjDcs5Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618432; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NrfBW7SPsbQ/aduL0TWvf3pW2FkkCe59pN1/SWc12md/Hr5
	mD59wDvDyCN2CubZw8OgcjRNypds9XtQEntgsZoXJSCZ9kQVhcasTG6gcPC/Ee58
	Hrn51x4hxzOF0SkKnUO1xAWQzAYUyt+aCqwprKfsP3aJtEhK0JDyGm+1R2SwnxvP
	zSz28vqcLQHKnyO5iHVSTcN+0zaWJENLwOYvaQNsb4XiMaTuGL48qfW3rYvw6JBq
	kD0d6dHZYV4iK58mif0lfPIwcJKH6Q98TS/BfHV0YKorZ4dMplw4Q7f1iEMZO3cq
	iFOzqXwyk1HW6ltpOp5CqerF1F5xIuMI3RSu1zg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MjjD2kA4vSkvkcuExx/MM9IQjvddPMTwk+ndHeFAAKY=:6C/VYNBngJbbWZkZqqCEHlM3UNCQBdwpEL6IvQAWNuA=;
X-ME-Sender: <xms:AHLoagppe1M6dG2sC3Uf8S-MQ3yCBJ8d71OuPIYydYgDEOT1Gqj00Q>
    <xme:AHLoatnJwpPZBDFC1YiCjN3JVtbNOT-K253Gk_u47kGvZCkGtrCYW5NvfTJueni4q
    L49dSn3PsxVMBJ5Ko4KWM6WimE59xrPg-IjWSN74K8cuK0AAU0SC7Y>
X-ME-Received: <xmr:AHLoaq1Sd6nCx3XXRto1Dx1VqdtJvIZCsEWjLi0SYgzoKXtCqMCV3bsMeUl0_mTS1GZtfQ>
X-ME-Proxy-Cause: dmFkZTFmjoZME9HE3u2FhWOW93LgHNK2jOXSy8KSI2Ds1OqzKZFqUYOKZ4B1+3GD2EwvqX
    c0NwthNEyE/Nc95k4wpPTDNJumy9ygiYf2B9dzpzhflTI9GCeW3Lk12nJMlnySeAbjQWll
    aQqWOxMQz1mpijmu/11bUj26lhCpefnojaTrVKX4hZiset8hXkX++ENs5cKG1+TRNxiDQC
    G8/gOCe8/jtEExcnDQz0Rn6DLL8yFZq8jka8pVCZ04lkg3WdePdBzuJr3NN2MiqZ0Eayxn
    hqQvXYLdUO3I9/mCddciQnKH75kgN9ZSxSJuVUwYXibUPRJ23EJSgwAUqEz2hcAzbWLBJt
    UbnwPAyTjEG4dQYqVO5wUyNyP7YllZ9m5PLMHM9y/om97s1QN9cst1FCb3w2shnrpXeYUp
    HZsGgZtbTd5QxDaxaq3kn99ssX02zGiB1j2qSdqkpG5aikb1TmUfIePZh8xcjF0nDDk7og
    RAsYem5hZ9V+nJAvEl8Ux1qztldwZmZOhAdcVZAYMpDLWhIRPxU9nFupa8RmCSqVDWF9t7
    GHvfJnarIfmjLLnqDHfJ4EUn47XbTaexSdEac6cWyPqIpQibY3SGA71bgo23h41ebW5KVZ
    aeSqUMziwVFJbUVyNdMFRIyDOLNnqiCGOUKqzo4OK1S1APyCE7VDdL9LKNnw
X-ME-Proxy: <xmx:AHLoatAiBwJZbTFOJnY5P5Y7FUBW9K223VdVHyH2vmQWHY4lrotiEQ>
    <xmx:AHLoavynNV8mKYLxg2e4pSRq9c-YfheZcwxuY9wwxK2714r6umKvQg>
    <xmx:AHLoajnbv-SmDXfa5h8hLTCu5K--wc1arhkHD81ivVPvBdlIuSKtNw>
    <xmx:AHLoasGWMFoljPNYIBt1TKYAjH54V1Qb6ZWg_wFwr1Ie2R0HY2y_yQ>
    <xmx:AHLoakLGSboS1QLYAkqBNTHnOZDFqMT_0SqF90KuWGim9Q2_gqE0hSMJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0883389b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:20:17 +0100
Subject: [PATCH 1/6] object-file: move logic to read loose objects into
 backend
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pks-odb-loose-cleanups-v1-1-fbbc86c29693@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The logic to read loose objects is still contained in "object-file.c"
even though it's an implementation detail of the "loose" backend, and
that backend is nowadays also the only remaining caller.

Move the logic around and remove the accompanying declarations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 300 ---------------------------------------------------
 object-file.h      |  45 --------
 odb/source-loose.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 345 deletions(-)

diff --git a/object-file.c b/object-file.c
index 132aaab6f84..c1b78a25c9f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -151,179 +151,6 @@ int stream_object_signature(struct repository *r,
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-/*
- * Map and close the given loose object fd. The path argument is used for
- * error reporting.
- */
-static void *map_fd(int fd, const char *path, unsigned long *size)
-{
-	void *map = NULL;
-	struct stat st;
-
-	if (!fstat(fd, &st)) {
-		*size = xsize_t(st.st_size);
-		if (!*size) {
-			/* mmap() is forbidden on empty files */
-			error(_("object file %s is empty"), path);
-			close(fd);
-			return NULL;
-		}
-		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
-	}
-	close(fd);
-	return map;
-}
-
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz)
-{
-	int status;
-
-	/* Get the data stream */
-	memset(stream, 0, sizeof(*stream));
-	stream->next_in = map;
-	stream->avail_in = mapsize;
-	stream->next_out = buffer;
-	stream->avail_out = bufsiz;
-
-	git_inflate_init(stream);
-	obj_read_unlock();
-	status = git_inflate(stream, 0);
-	obj_read_lock();
-	if (status != Z_OK && status != Z_STREAM_END)
-		return ULHR_BAD;
-
-	/*
-	 * Check if entire header is unpacked in the first iteration.
-	 */
-	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-		return ULHR_OK;
-
-	/*
-	 * We have a header longer than MAX_HEADER_LEN.
-	 */
-	return ULHR_TOO_LONG;
-}
-
-void *unpack_loose_rest(git_zstream *stream,
-			void *buffer, unsigned long size,
-			const struct object_id *oid)
-{
-	size_t bytes = strlen(buffer) + 1, n;
-	unsigned char *buf = xmallocz(size);
-	int status = Z_OK;
-
-	n = stream->total_out - bytes;
-	if (n > size)
-		n = size;
-	memcpy(buf, (char *) buffer + bytes, n);
-	bytes = n;
-	if (bytes <= size) {
-		/*
-		 * The above condition must be (bytes <= size), not
-		 * (bytes < size).  In other words, even though we
-		 * expect no more output and set avail_out to zero,
-		 * the input zlib stream may have bytes that express
-		 * "this concludes the stream", and we *do* want to
-		 * eat that input.
-		 *
-		 * Otherwise we would not be able to test that we
-		 * consumed all the input to reach the expected size;
-		 * we also want to check that zlib tells us that all
-		 * went well with status == Z_STREAM_END at the end.
-		 */
-		stream->next_out = buf + bytes;
-		stream->avail_out = size - bytes;
-		while (status == Z_OK) {
-			obj_read_unlock();
-			status = git_inflate(stream, Z_FINISH);
-			obj_read_lock();
-		}
-	}
-
-	if (status != Z_STREAM_END) {
-		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
-		FREE_AND_NULL(buf);
-	} else if (stream->avail_in) {
-		error(_("garbage at end of loose object '%s'"),
-		      oid_to_hex(oid));
-		FREE_AND_NULL(buf);
-	}
-
-	return buf;
-}
-
-/*
- * parse_loose_header() parses the starting "<type> <len>\0" of an
- * object. If it doesn't follow that format -1 is returned. To check
- * the validity of the <type> populate the "typep" in the "struct
- * object_info". It will be OBJ_BAD if the object type is unknown. The
- * parsed <len> can be retrieved via "oi->sizep", and from there
- * passed to unpack_loose_rest().
- *
- * We used to just use "sscanf()", but that's actually way
- * too permissive for what we want to check. So do an anal
- * object header parse by hand.
- */
-int parse_loose_header(const char *hdr, struct object_info *oi)
-{
-	const char *type_buf = hdr;
-	size_t size;
-	int type, type_len = 0;
-
-	/*
-	 * The type can be of any size but is followed by
-	 * a space.
-	 */
-	for (;;) {
-		char c = *hdr++;
-		if (!c)
-			return -1;
-		if (c == ' ')
-			break;
-		type_len++;
-	}
-
-	type = type_from_string_gently(type_buf, type_len, 1);
-	if (oi->typep)
-		*oi->typep = type;
-
-	/*
-	 * The length must follow immediately, and be in canonical
-	 * decimal format (ie "010" is not valid).
-	 */
-	size = *hdr++ - '0';
-	if (size > 9)
-		return -1;
-	if (size) {
-		for (;;) {
-			unsigned long c = *hdr - '0';
-			if (c > 9)
-				break;
-			hdr++;
-			size = st_add(st_mult(size, 10), c);
-		}
-	}
-
-	if (oi->sizep)
-		*oi->sizep = size;
-
-	/*
-	 * The length must be followed by a zero byte
-	 */
-	if (*hdr)
-		return -1;
-
-	/*
-	 * The format is valid, but the type may still be bogus. The
-	 * Caller needs to check its oi->typep.
-	 */
-	return 0;
-}
-
 #define CHECK_COLLISION_DEST_VANISHED -2
 
 static int check_collision(const char *source, const char *dest)
@@ -1127,133 +954,6 @@ int for_each_loose_file_in_source(struct odb_source *source,
 	return r;
 }
 
-static int check_stream_oid(git_zstream *stream,
-			    const char *hdr,
-			    unsigned long size,
-			    const char *path,
-			    const struct object_id *expected_oid,
-			    const struct git_hash_algo *algop)
-{
-	struct git_hash_ctx c;
-	struct object_id real_oid;
-	unsigned char buf[4096];
-	unsigned long total_read;
-	int status = Z_OK;
-
-	git_hash_init(&c, algop);
-	git_hash_update(&c, hdr, stream->total_out);
-
-	/*
-	 * We already read some bytes into hdr, but the ones up to the NUL
-	 * do not count against the object's content size.
-	 */
-	total_read = stream->total_out - strlen(hdr) - 1;
-
-	/*
-	 * This size comparison must be "<=" to read the final zlib packets;
-	 * see the comment in unpack_loose_rest for details.
-	 */
-	while (total_read <= size &&
-	       (status == Z_OK ||
-		(status == Z_BUF_ERROR && !stream->avail_out))) {
-		stream->next_out = buf;
-		stream->avail_out = sizeof(buf);
-		if (size - total_read < stream->avail_out)
-			stream->avail_out = size - total_read;
-		status = git_inflate(stream, Z_FINISH);
-		git_hash_update(&c, buf, stream->next_out - buf);
-		total_read += stream->next_out - buf;
-	}
-
-	if (status != Z_STREAM_END) {
-		error(_("corrupt loose object '%s'"), oid_to_hex(expected_oid));
-		git_hash_discard(&c);
-		return -1;
-	}
-	if (stream->avail_in) {
-		error(_("garbage at end of loose object '%s'"),
-		      oid_to_hex(expected_oid));
-		git_hash_discard(&c);
-		return -1;
-	}
-
-	git_hash_final_oid(&real_oid, &c);
-	if (!oideq(expected_oid, &real_oid)) {
-		error(_("hash mismatch for %s (expected %s)"), path,
-		      oid_to_hex(expected_oid));
-		return -1;
-	}
-
-	return 0;
-}
-
-int read_loose_object(struct repository *repo,
-		      const char *path,
-		      const struct object_id *expected_oid,
-		      struct object_id *real_oid,
-		      void **contents,
-		      struct object_info *oi)
-{
-	int ret = -1;
-	int fd;
-	void *map = NULL;
-	unsigned long mapsize;
-	git_zstream stream;
-	char hdr[MAX_HEADER_LEN];
-	size_t *size = oi->sizep;
-
-	fd = git_open(path);
-	if (fd >= 0)
-		map = map_fd(fd, path, &mapsize);
-	if (!map) {
-		error_errno(_("unable to mmap %s"), path);
-		goto out;
-	}
-
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) != ULHR_OK) {
-		error(_("unable to unpack header of %s"), path);
-		goto out_inflate;
-	}
-
-	if (parse_loose_header(hdr, oi) < 0) {
-		error(_("unable to parse header of %s"), path);
-		goto out_inflate;
-	}
-
-	if (*oi->typep < 0) {
-		error(_("unable to parse type from header '%s' of %s"),
-		      hdr, path);
-		goto out_inflate;
-	}
-
-	if (*oi->typep == OBJ_BLOB &&
-	    *size > repo_settings_get_big_file_threshold(repo)) {
-		if (check_stream_oid(&stream, hdr, *size, path, expected_oid,
-				     repo->hash_algo) < 0)
-			goto out_inflate;
-	} else {
-		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
-		if (!*contents) {
-			error(_("unable to unpack contents of %s"), path);
-			goto out_inflate;
-		}
-		hash_object_file(repo->hash_algo,
-				 *contents, *size,
-				 *oi->typep, real_oid);
-		if (!oideq(expected_oid, real_oid))
-			goto out_inflate;
-	}
-
-	ret = 0; /* everything checks out */
-
-out_inflate:
-	git_inflate_end(&stream);
-out:
-	if (map)
-		munmap(map, mapsize);
-	return ret;
-}
-
 static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
 			       const char *keep_msg, struct tempfile **out)
 {
diff --git a/object-file.h b/object-file.h
index f44758c4f8b..65ab44542b0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,7 +21,6 @@ enum {
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-struct object_info;
 struct odb_source;
 
 /*
@@ -122,50 +121,6 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 int check_and_freshen_file(const char *fn, int freshen,
 			   const time_t *mtime);
 
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * use the "oi" argument to assert things about the object, or e.g. populate its
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(struct repository *repo,
-		      const char *path,
-		      const struct object_id *expected_oid,
-		      struct object_id *real_oid,
-		      void **contents,
-		      struct object_info *oi);
-
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-
-/**
- * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
- *
- * It will only parse up to MAX_HEADER_LEN bytes.
- */
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz);
-void *unpack_loose_rest(git_zstream *stream,
-			void *buffer, unsigned long size,
-			const struct object_id *oid);
-
-int parse_loose_header(const char *hdr, struct object_info *oi);
-
 struct odb_transaction;
 
 /*
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 50cb388c352..96fc2ed213f 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -64,6 +64,162 @@ static int quick_has_loose(struct odb_source_loose *loose,
 	return !!oidtree_contains(odb_source_loose_cache(loose, oid), oid);
 }
 
+enum unpack_loose_header_result {
+	ULHR_OK,
+	ULHR_BAD,
+	ULHR_TOO_LONG,
+};
+
+static enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+							   unsigned char *map,
+							   unsigned long mapsize,
+							   void *buffer,
+							   unsigned long bufsiz)
+{
+	int status;
+
+	/* Get the data stream */
+	memset(stream, 0, sizeof(*stream));
+	stream->next_in = map;
+	stream->avail_in = mapsize;
+	stream->next_out = buffer;
+	stream->avail_out = bufsiz;
+
+	git_inflate_init(stream);
+	obj_read_unlock();
+	status = git_inflate(stream, 0);
+	obj_read_lock();
+	if (status != Z_OK && status != Z_STREAM_END)
+		return ULHR_BAD;
+
+	/*
+	 * Check if entire header is unpacked in the first iteration.
+	 */
+	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+		return ULHR_OK;
+
+	/*
+	 * We have a header longer than MAX_HEADER_LEN.
+	 */
+	return ULHR_TOO_LONG;
+}
+
+static void *unpack_loose_rest(git_zstream *stream,
+			       void *buffer, unsigned long size,
+			       const struct object_id *oid)
+{
+	size_t bytes = strlen(buffer) + 1, n;
+	unsigned char *buf = xmallocz(size);
+	int status = Z_OK;
+
+	n = stream->total_out - bytes;
+	if (n > size)
+		n = size;
+	memcpy(buf, (char *) buffer + bytes, n);
+	bytes = n;
+	if (bytes <= size) {
+		/*
+		 * The above condition must be (bytes <= size), not
+		 * (bytes < size).  In other words, even though we
+		 * expect no more output and set avail_out to zero,
+		 * the input zlib stream may have bytes that express
+		 * "this concludes the stream", and we *do* want to
+		 * eat that input.
+		 *
+		 * Otherwise we would not be able to test that we
+		 * consumed all the input to reach the expected size;
+		 * we also want to check that zlib tells us that all
+		 * went well with status == Z_STREAM_END at the end.
+		 */
+		stream->next_out = buf + bytes;
+		stream->avail_out = size - bytes;
+		while (status == Z_OK) {
+			obj_read_unlock();
+			status = git_inflate(stream, Z_FINISH);
+			obj_read_lock();
+		}
+	}
+
+	if (status != Z_STREAM_END) {
+		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
+		FREE_AND_NULL(buf);
+	} else if (stream->avail_in) {
+		error(_("garbage at end of loose object '%s'"),
+		      oid_to_hex(oid));
+		FREE_AND_NULL(buf);
+	}
+
+	return buf;
+}
+
+/*
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown. The
+ * parsed <len> can be retrieved via "oi->sizep", and from there
+ * passed to unpack_loose_rest().
+ *
+ * We used to just use "sscanf()", but that's actually way
+ * too permissive for what we want to check. So do an anal
+ * object header parse by hand.
+ */
+static int parse_loose_header(const char *hdr, struct object_info *oi)
+{
+	const char *type_buf = hdr;
+	size_t size;
+	int type, type_len = 0;
+
+	/*
+	 * The type can be of any size but is followed by
+	 * a space.
+	 */
+	for (;;) {
+		char c = *hdr++;
+		if (!c)
+			return -1;
+		if (c == ' ')
+			break;
+		type_len++;
+	}
+
+	type = type_from_string_gently(type_buf, type_len, 1);
+	if (oi->typep)
+		*oi->typep = type;
+
+	/*
+	 * The length must follow immediately, and be in canonical
+	 * decimal format (ie "010" is not valid).
+	 */
+	size = *hdr++ - '0';
+	if (size > 9)
+		return -1;
+	if (size) {
+		for (;;) {
+			unsigned long c = *hdr - '0';
+			if (c > 9)
+				break;
+			hdr++;
+			size = st_add(st_mult(size, 10), c);
+		}
+	}
+
+	if (oi->sizep)
+		*oi->sizep = size;
+
+	/*
+	 * The length must be followed by a zero byte
+	 */
+	if (*hdr)
+		return -1;
+
+	/*
+	 * The format is valid, but the type may still be bogus. The
+	 * Caller needs to check its oi->typep.
+	 */
+	return 0;
+}
+
 static int read_object_info_from_path(struct odb_source_loose *loose,
 				      const char *path,
 				      const struct object_id *oid,
@@ -248,6 +404,29 @@ static int open_loose_object(struct odb_source_loose *loose,
 	return -1;
 }
 
+/*
+ * Map and close the given loose object fd. The path argument is used for
+ * error reporting.
+ */
+static void *map_fd(int fd, const char *path, unsigned long *size)
+{
+	void *map = NULL;
+	struct stat st;
+
+	if (!fstat(fd, &st)) {
+		*size = xsize_t(st.st_size);
+		if (!*size) {
+			/* mmap() is forbidden on empty files */
+			error(_("object file %s is empty"), path);
+			close(fd);
+			return NULL;
+		}
+		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+	}
+	close(fd);
+	return map;
+}
+
 static void *odb_source_loose_map_object(struct odb_source_loose *loose,
 					 const struct object_id *oid,
 					 unsigned long *size)
@@ -1015,6 +1194,133 @@ static void odb_source_loose_free(struct odb_source *source)
 	free(loose);
 }
 
+static int check_stream_oid(git_zstream *stream,
+			    const char *hdr,
+			    unsigned long size,
+			    const char *path,
+			    const struct object_id *expected_oid,
+			    const struct git_hash_algo *algop)
+{
+	struct git_hash_ctx c;
+	struct object_id real_oid;
+	unsigned char buf[4096];
+	unsigned long total_read;
+	int status = Z_OK;
+
+	git_hash_init(&c, algop);
+	git_hash_update(&c, hdr, stream->total_out);
+
+	/*
+	 * We already read some bytes into hdr, but the ones up to the NUL
+	 * do not count against the object's content size.
+	 */
+	total_read = stream->total_out - strlen(hdr) - 1;
+
+	/*
+	 * This size comparison must be "<=" to read the final zlib packets;
+	 * see the comment in unpack_loose_rest for details.
+	 */
+	while (total_read <= size &&
+	       (status == Z_OK ||
+		(status == Z_BUF_ERROR && !stream->avail_out))) {
+		stream->next_out = buf;
+		stream->avail_out = sizeof(buf);
+		if (size - total_read < stream->avail_out)
+			stream->avail_out = size - total_read;
+		status = git_inflate(stream, Z_FINISH);
+		git_hash_update(&c, buf, stream->next_out - buf);
+		total_read += stream->next_out - buf;
+	}
+
+	if (status != Z_STREAM_END) {
+		error(_("corrupt loose object '%s'"), oid_to_hex(expected_oid));
+		git_hash_discard(&c);
+		return -1;
+	}
+	if (stream->avail_in) {
+		error(_("garbage at end of loose object '%s'"),
+		      oid_to_hex(expected_oid));
+		git_hash_discard(&c);
+		return -1;
+	}
+
+	git_hash_final_oid(&real_oid, &c);
+	if (!oideq(expected_oid, &real_oid)) {
+		error(_("hash mismatch for %s (expected %s)"), path,
+		      oid_to_hex(expected_oid));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int read_loose_object(struct repository *repo,
+			     const char *path,
+			     const struct object_id *expected_oid,
+			     struct object_id *real_oid,
+			     void **contents,
+			     struct object_info *oi)
+{
+	int ret = -1;
+	int fd;
+	void *map = NULL;
+	unsigned long mapsize;
+	git_zstream stream;
+	char hdr[MAX_HEADER_LEN];
+	size_t *size = oi->sizep;
+
+	fd = git_open(path);
+	if (fd >= 0)
+		map = map_fd(fd, path, &mapsize);
+	if (!map) {
+		error_errno(_("unable to mmap %s"), path);
+		goto out;
+	}
+
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) != ULHR_OK) {
+		error(_("unable to unpack header of %s"), path);
+		goto out_inflate;
+	}
+
+	if (parse_loose_header(hdr, oi) < 0) {
+		error(_("unable to parse header of %s"), path);
+		goto out_inflate;
+	}
+
+	if (*oi->typep < 0) {
+		error(_("unable to parse type from header '%s' of %s"),
+		      hdr, path);
+		goto out_inflate;
+	}
+
+	if (*oi->typep == OBJ_BLOB &&
+	    *size > repo_settings_get_big_file_threshold(repo)) {
+		if (check_stream_oid(&stream, hdr, *size, path, expected_oid,
+				     repo->hash_algo) < 0)
+			goto out_inflate;
+	} else {
+		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
+		if (!*contents) {
+			error(_("unable to unpack contents of %s"), path);
+			goto out_inflate;
+		}
+		hash_object_file(repo->hash_algo,
+				 *contents, *size,
+				 *oi->typep, real_oid);
+		if (!oideq(expected_oid, real_oid))
+			goto out_inflate;
+	}
+
+	ret = 0; /* everything checks out */
+
+out_inflate:
+	git_inflate_end(&stream);
+out:
+	if (map)
+		munmap(map, mapsize);
+	return ret;
+}
+
 struct fsck_loose_data {
 	struct odb_source_loose *source;
 	struct odb_fsck_options *opts;

-- 
2.56.0.500.g5d06dc02cd.dirty

