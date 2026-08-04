Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698D4252BB
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828355; cv=none; b=u2amh/pry214I37/Ixk/2wKzQ0r/m6zOsVQ+QgMz3bS806YfDuUmxQzQweviU1nf7p6yeuOLkAOI2disXpQX1zVqm3CYPJyf0wdcx3cMjaj3ngJswITfwqxY6VM5fB44CXy2xgUjQjbGThQFevFp1N6rkHabEujKnXmfYTS6MYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828355; c=relaxed/simple;
	bh=mOzQ3nWm/rrPUiGxatADZ++z4gwghxw3RNNbMnULzNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a4Gttp3uo4zb9OfR4ueCrbiHLQFitGFHGGhpSWqM6FnHtZ+0mUc+dmfYSDEIrSbcVfwf/yovd/JYIcmLNwjjDOJoeEhWjrS3qAMWNpPLfCVO5vbAb0bz2y4TArFRtuhjtLU8qtR3h5p+IYOmCNJCm1662Pkmp6vhKCgBkfCOCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oZCwmA81; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EeaZdWoW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oZCwmA81";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EeaZdWoW"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31DCF7A014A
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:25:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 04 Aug 2026 03:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785828353;
	 x=1785914753; bh=ZQnVTMY8ILVA1MZzFkYrLbtK2wW+WTEDvoekTUgn48Y=; b=
	oZCwmA81xVc9wzohSLXlQBTHPpStrpC5AbKZwOBFLE4HJZyVUMXInPNk8Q2u9cF4
	jVGRZI3MD9z7jBHcQsKKnub395bAsNbZ8K1LYFDd80v+LIRYvhrgDHr09s/AoRp3
	WA658p7kB91+R/5VX1u2Y9PXiV3e5stuIRzsq2b4I0e0k/jU+c3OsKRwNNRNWx4y
	me0vrAVOider1AP2mB9DxGNAKTeuasTLTeAIqFTv+duZNyqic2VBZbmfMx7+0ph3
	RaIBb4sJ279RtK+8sg1mMMfh+rIUlRp8L7JR07PM8DbJnQjvMsTDp9li8BDPjZFw
	xZbTHOGSnoDOh8GVbuoyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785828353; x=
	1785914753; bh=ZQnVTMY8ILVA1MZzFkYrLbtK2wW+WTEDvoekTUgn48Y=; b=E
	eaZdWoW0e2H3CXqy5FlLIew9Qu0Ln8Xw9dKdmoKOvXLRBAEMbcFfAM5wjnseOqf8
	PC7m+LHLA9viVSDgwOO0o6rsZTwJHar2unte0Bc7mW30U/vUP2ApSnatcPBseSYt
	oo3pKoH3CA7BEp4IlS4wpF3K6dZMU+PfaQJ/wzBjZ2fqxud54WVUUEe189dXnPix
	p9YcXNp3iNTLs+c7zbPpIPNxhwOSPAzqzexhZwfphc8DN7SKK3NYGWKrxhNTV+qD
	w5+fKvD57FChIcQQNqxsE1uxQ847yH9V8TzoAn3Bsv5a+LLDq6TdH42ZdBOOwzPu
	+btiw4SiM2GNfb7hjoFKw==
X-ME-Sender: <xms:AJRxarh_f_pEU2qv27x1na6F88tDvCi8qKofwvnG33OWrkzA80oQtg>
    <xme:AJRxau_FSCnCMXv6TPjtQmTIPSLHoAQrJMCT_TZKtXNSmkI6T54DsZCxzuFtg4dLh
    JSgUbq3sxGoSBFu3LLkFjOumLF_qXHpTbBTnmViu42sUxQZ3fNo8w>
X-ME-Received: <xmr:AJRxagtsRyxoDtp_DJgut77vyCXo3T_2aT-z5EFFlAup0jdGqfUs1kYoae7PCRfMR4I_AlR8nlx8KwyWzjx7nn2un9CK01SOFr5QXTqk>
X-ME-Proxy-Cause: dmFkZTGJA/hd69o6AiEEnltmxxNPL/iz2JXYj1ZUCV9O8/iM3GIVZKb1NAe3PBzTWzWtB+
    O4CAqSBZES2dh/iHdrp95HkrzL3i2X/F9QiW1doHWb6x6GaLIXzJBuTNRp2y4lqMTv2GPB
    strxDCbZ/EYeXFpjwhGxsag30tHIR0f3Iac3xcq5uCaTWL6TQOZY6GBfzmgt06EFd2/PEV
    tiG3bIE1zpEvoMZ2EaS4OunWnPZ2CH/1Nsq1PgNvH5S47PGjbE4jcG6Ukz0+bMhrbt9Hsg
    HQqHiZld24lnD8uXrgPpPeulB5cTahmBAqH+Z2fisxWNmmWeJQiJh/a7h3YqjBCF/CcKT+
    TcUiJsRk1bViyjHrC6m9nhJWdbMnxIfT7fHEhdmW6mPtKRrCFhih7uUjcjEvnlWVxCmhjD
    w2SG7jcKQmzBMx6vPPnOZOPdSc78BZrapF8MChM7uQ7HTFvN6uo3fnLi+VYFWxg+7CmaFZ
    o7Un9vUKyaXCocy8V44Uxc63Ap2eT0qnK9OAQ+lirabbfYQId9bKxAaxdOKgG1XVepnQSV
    APfpBB/F/2pv5AAL1oTfJ/1r9oh4vXts675Z50pa7x2wb18nl2HfoUdBB1/XtZaq+03s2t
    rUtNI+KNdq3RL93ru3esviCSIvpC7QTBwD+vjCZagrAxK/tLZpi9OfArh/og
X-ME-Proxy: <xmx:AJRxatZjFJITCKPZeqE0HnqaB8ocDMwDnsGrMejSQfs50NM_4g4Hpw>
    <xmx:AJRxaoq7zcIhvKMe3-aM1NEQiMGIXYHLLQhvdt95lat1cm5p2TslvQ>
    <xmx:AJRxaq_C-Rg_ZHi_C7RWAmqx2UQlzwtZYLlPQu-jbepwKqaZUwl3Uw>
    <xmx:AJRxav8nlFEMhrVB-pcPp9_-gbY_E_CPxB8l-KsV7eIX5zJ8Pj_DIA>
    <xmx:AZRxashU4R5e2MN95t4hAsRdiFHa__zvxoKIULNq1fcYkdAPgbaLaG9W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 4 Aug 2026 03:25:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3607dfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 4 Aug 2026 07:25:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 09:25:31 +0200
Subject: [PATCH 3/7] odb/streaming: support streaming arbitrary object
 types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
In-Reply-To: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The object database supports the ability to write object streams into
it. This functionality is used when we encounter a blob that is larger
than "core.bigFileThreshold" so that we don't have to soak large files
into memory.

As we only ever write large files, the infrastructure doesn't support
specifying any other object type than "blob". This limitation is quite
artificial though: there is no reason why we shouldn't support writing
arbitrary large objects with a stream. While it's very unlikely that we
encounter a huge object other than a blob, users are known to be
creative and sometimes like to inflict pain on themselves by creating
commits or trees that are huge.

Extend the infrastructure to support streaming arbitrary object types.
For now we don't use this functionality anywhere, but it brings us a bit
closer to unify `struct odb_read_stream` and `struct odb_write_stream`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c      |  1 +
 object-file.c                 | 31 +++++++++++++++----------------
 odb/source-inmemory.c         |  2 +-
 odb/source-loose.c            |  2 +-
 odb/streaming.c               |  3 ++-
 odb/streaming.h               |  3 ++-
 t/unit-tests/u-odb-inmemory.c |  7 +++++--
 7 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index b7c486ea94..7439ec53be 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -393,6 +393,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 		.read = feed_input_zstream,
 		.data = &data,
 		.size = size,
+		.type = OBJ_BLOB,
 	};
 	struct obj_info *info = &obj_list[nr];
 
diff --git a/object-file.c b/object-file.c
index 317c09dff8..699a6a008c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -702,9 +702,9 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 		die_errno("unable to write pack header");
 }
 
-static int hash_blob_stream(struct odb_write_stream *stream,
-			    const struct git_hash_algo *hash_algo,
-			    struct object_id *result_oid)
+static int hash_stream(struct odb_write_stream *stream,
+		       const struct git_hash_algo *hash_algo,
+		       struct object_id *result_oid)
 {
 	unsigned char buf[16384];
 	struct git_hash_ctx ctx;
@@ -712,7 +712,7 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 	size_t bytes_hashed = 0;
 
 	header_len = format_object_header((char *)buf, sizeof(buf),
-					  OBJ_BLOB, stream->size);
+					  stream->type, stream->size);
 	git_hash_init(&ctx, hash_algo);
 	git_hash_update(&ctx, buf, header_len);
 
@@ -740,9 +740,9 @@ static int hash_blob_stream(struct odb_write_stream *stream,
  * Read the contents from the stream provided, streaming it to the
  * packfile in state while updating the hash in ctx.
  */
-static void stream_blob_to_pack(struct transaction_packfile *state,
-				struct git_hash_ctx *ctx,
-				struct odb_write_stream *stream)
+static void stream_to_pack(struct transaction_packfile *state,
+			   struct git_hash_ctx *ctx,
+			   struct odb_write_stream *stream)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -755,7 +755,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 
 	git_deflate_init(&s, cfg->pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, stream->size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), stream->type, stream->size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -764,7 +764,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 			ssize_t rsize = odb_write_stream_read(stream, ibuf,
 							      sizeof(ibuf));
 			if (rsize < 0)
-				die("failed to read blob data");
+				die("failed to read object data");
 			if (!rsize)
 				is_finished = true;
 
@@ -797,7 +797,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 	}
 
 	if (bytes_read != stream->size)
-		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
+		die("read %" PRIuMAX " bytes of object data, but expected %" PRIuMAX " bytes",
 		    (uintmax_t)bytes_read, (uintmax_t)stream->size);
 
 	git_deflate_end(&s);
@@ -868,7 +868,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * result, which we need to know beforehand when writing a git object.
  * Since the primary motivation for trying to stream from the working
  * tree file and to avoid mmaping it in core is to deal with large
- * binary blobs, they generally do not want to get any conversion, and
+ * objects, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
 static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
@@ -886,7 +886,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	struct pack_idx_entry *idx;
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, stream->size);
+					  stream->type, stream->size);
 	git_hash_init(&ctx, transaction->base.source->odb->repo->hash_algo);
 	git_hash_update(&ctx, obuf, header_len);
 
@@ -911,7 +911,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, stream);
+	stream_to_pack(state, &ctx, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -953,7 +953,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 				 type, path, flags);
 	} else {
 		struct odb_write_stream stream;
-		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
+		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size), OBJ_BLOB);
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
@@ -968,8 +968,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			if (!inflight)
 				odb_transaction_commit(transaction);
 		} else {
-			ret = hash_blob_stream(&stream,
-					       the_repository->hash_algo, oid);
+			ret = hash_stream(&stream, the_repository->hash_algo, oid);
 		}
 
 		odb_write_stream_release(&stream);
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 01bb81c63c..4f76db5496 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -293,7 +293,7 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
 
 	ret = odb_source_inmemory_write_object(source, data, stream->size,
-					       OBJ_BLOB, oid, NULL, NULL, 0);
+					       stream->type, oid, NULL, NULL, 0);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 361b4e2a2a..5681a38f03 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -868,7 +868,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
-	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, in_stream->size);
+	hdrlen = format_object_header(hdr, sizeof(hdr), in_stream->type, in_stream->size);
 
 	/*
 	 * Common steps for write_loose_object and stream_loose_object to
diff --git a/odb/streaming.c b/odb/streaming.c
index 912e75e682..0918cad426 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -324,7 +324,7 @@ static ssize_t read_object_fd(struct odb_write_stream *stream,
 }
 
 void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
-			      size_t size)
+			      size_t size, enum object_type type)
 {
 	struct read_object_fd_data *data;
 
@@ -335,4 +335,5 @@ void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
 	stream->data = data;
 	stream->read = read_object_fd;
 	stream->size = size;
+	stream->type = type;
 }
diff --git a/odb/streaming.h b/odb/streaming.h
index 5e8e6e532e..3c8ed55129 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -56,6 +56,7 @@ struct odb_write_stream {
 	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
 	void *data;
 	size_t size;
+	enum object_type type;
 };
 
 /*
@@ -92,6 +93,6 @@ int odb_stream_blob_to_fd(struct object_database *odb,
  * Sets up an ODB write stream that reads from an fd.
  */
 void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
-			      size_t size);
+			      size_t size, enum object_type type);
 
 #endif /* STREAMING_H */
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 4437140ed0..1ab07af6d6 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -297,8 +297,11 @@ void test_odb_inmemory__write_object_stream(void)
 	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
 	const char data[] = "foobar";
 	struct membuf_write_stream stream = {
-		.base.read = membuf_write_stream_read,
-		.base.size = strlen(data),
+		.base = {
+			.read = membuf_write_stream_read,
+			.size = strlen(data),
+			.type = OBJ_BLOB,
+		},
 		.buf = data,
 	};
 	struct object_id written_oid;

-- 
2.55.0.679.g6767b8d81c.dirty

