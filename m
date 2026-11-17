Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915551;
	b=I22o0XGOou6EYKyrNpVDkHibTia95y0dNKHCZGbQiIowBABlotXGls7iTQ2ZgRtZSJOz
	 u1kya2OKHFpPRDjJnxfKNIkvYh2eIhjtls6pVZRVQoPBuYKsvlSmbtTp0Og0PW67L4HG/
	 +Btt1P22y/CoIvbRMxI0Vvsy2W7NqB5m2UYEPFvmW+3JxJ2uwrihLosE/EMNDPEnQwlKs
	 LO8PK6qjPo1N8PWEJxJPOt3NbXKkeThbiHqVzkYfNVSisJtQn5pvVWBd+1bUwepESu5ZU
	 VxsxEGGWOCdNSf7lJc87V3AburfpnfQi+X5JNcLOGZ5sjJd5a4A0mfRkGNKY3Z3Oi0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wmob4ynlkdHJ2SuDD5rMprDSiranZR8ZgIZfiGX/OtE=;
	b=peqXui/mGtWV3ILKbL1AkBYuDBTycf2auUIQ1F8FHdRxidLpCgFw0gX3zWClShvj/6jl
	 Ut5FCGnkQSHhSB/LXJ+8XK9gNaWmO7JccvYqE7bLI2ns7iyci52Bg9aZzu+M7lkM1KIHY
	 tabuF2Nt7LlSnlrW7E/e/lW21NDhvtQxvRljjvPauKP4Q526A6R+OtyTfTRGsJGFAU7em
	 pIRpxibZAAw3vB7CyO4ivFyyw9lwyWiAiyvU06lV2oWkG2ZnA8JwDxc6d7JsFLZErB55e
	 R2yDf82iOyoC0cKbVY5IbhmLRzcjC4765PtDRJWO7o0FDpUSYtVl1oo6C0pKeehGpZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxfyLVO3;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C3606A332
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 885C3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxfyLVO3
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so5865795e9.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794915550; x=1795520350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmob4ynlkdHJ2SuDD5rMprDSiranZR8ZgIZfiGX/OtE=;
        b=HxfyLVO3PK+e6GQ+SDj5okY35sQH9bRyRPa2mcaiZtsMxtXRgAqiRmrxIGUtvuzfZI
         I+WNAOxDRuYBzvjIadJlRRlFQfmCO+fIyy030SLJqqEgvAkdomBUF8g+L+KjUoTjnaxB
         Beiv4xgUAZs8TfmN3dSGQiZpQF+NnjucLHXlofKEP1TZD9FDm481HZqzo6YSe+ItxcwL
         6qeS3SBVzbpuaw44bh9rcr63pJ55CupS03jkDTIvPSCbC3aGwfVvM8yP/ow6j+uArgID
         ArTnthOhl9K+0kyulppYAQ8eEgLaDimSlWSGwp1PoXisiw8k/Gg6z8ZXw5/3li1gEbyf
         LsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915550; x=1795520350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wmob4ynlkdHJ2SuDD5rMprDSiranZR8ZgIZfiGX/OtE=;
        b=QsbDS3JYD858v0WSRiD/BadFIqKoV1EDH9Wng7U140SRhnx8JotKhX0r49hKHH89aO
         Xqjmi/xPRJUdBDtVTZxJoSlggWuB7GHGeJtjq4DpXTsz4sJNrPlTye54OMQ1bxKF80wS
         EUuHX/qYNeYfRQRgsZb7NgNT0e9lkHAUXFqpJO57TUnErpApFmaYjIVH2/OThp3hT6zk
         2EuylHcQ1rjJjISiWrxaYFfoSJaf9kgoQwrndBxgb2kaVIkeE3tNT3WVXg7V7jKZP/qo
         witmZD4gLKkN3XK/6okHJZx66CFvU4Oj5QxoAC6aWX/qQZ4ndNxULUCbPF00ivQ5dCSf
         CoZQ==
X-Gm-Message-State: APuU4Z9MlvJLYAGxBI0p9GhcUKaPJm2HASqhG/NvZWLPS7zz/hS21TZY
	mFDx+hWipLTvr1mVYiurO7M3961ik0UZr3EWZSQJ5S4BOurfIymgZYW8ElVO3w==
X-Gm-Gg: AYBFou0f/JkWR7OuitGeVISKlFJBTrqk8sn3SfdPW2Rp7KIRN04rwaJTrI5Had0gZuM
	bn7z5LwrecawFFObGg3PMSszSO7cnGyz0VpxVPFg10CtTG6oOD/DXkJYUlzG23Pc+F9oAAHNi9D
	Xxc+jx5kiCBxOk6ykXO7z+SeLr42GK4H37rpVEdV2dfxhP0XwaV2gsOtLi9207xl8OTVpfG9dsp
	Ai6+sBMuikxjX9+TK7D3Gj2f0Gv6rQfRfsyNj94yYfgyKumHRSAbsiHXVIZwmPqyoQ+SfQmCpUY
	kUn08Do+iK+ulbNXtuoqszr1j5ysCLa/6l1b/xEygg60zG8ipv5Fun/Vd8b4vs1ICBrTtOlkF7+
	I3M7kHj50qHLF1e13VcZWBY16fAd3LZn7TMQAsSno9tylAM3wg/2MpLoBO9n9N3rZEP65TK8gT9
	8BB1JCC80IOUsUG/HlV7wRHR9m9NWGt4jsLn2m9RlxcZXc8zJBO+5UDE2UyS1hjVz+v6D/VbrAr
	jlSIj5QB3en19lx15rDYo/T0gkF6cCGYJRaAwEB3ns0T+FKfpM8FujDx7eKLZm+aKEJQ6dvmVh8
	Sc7vxNTLSiD2rPrpuAx0hhVxUo0s1ULo2km+UQeUVU4NPyd6vEnb2ZzZE7NQcDQ=
X-Received: by 2002:a05:600c:384e:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4bb78399c0bmr51027425e9.17.1794915549655;
        Tue, 17 Nov 2026 03:39:09 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm93555925e9.9.2026.11.17.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:39:08 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@fastmail.com>
Subject: [PATCH v2 2/5] object-file: use size_t for loose object sizes
Date: Tue, 17 Nov 2026 12:38:55 +0100
Message-ID: <eca5d3ddb88e03ae647a66d861a4c89a4c490fd7.1794914210.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794914210.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com> <cover.1794914210.git.gitter.spiros@gmail.com>
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

Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
APIs, 2026-06-15), parse_loose_header() reports the object size as a
size_t, but unpack_loose_rest() still takes it as an "unsigned long".
On 64-bit Windows, where "long" has 32 bits while size_t has 64, the
size is truncated on the way. A header claiming 4GiB + 5 bytes thus
makes us allocate a 6-byte buffer, the size check added by the
previous commit is happy because the stream really has 5 bytes, and
the caller gets that buffer back together with *oi->sizep set to
4GiB + 5. Any user of the object then reads far beyond the end of the
buffer; read_loose_object() already does so when it hashes the
contents.

Use size_t for the size in unpack_loose_rest() and check_stream_oid(),
and while at it for the size of the mapped file in map_fd(),
odb_source_loose_map_object() and unpack_loose_header(), so that the
whole loose object reading path agrees on the type.

There is no test, as the reader allocates a buffer of the size claimed
in the header before it can notice that the stream is short, so a test
would need 4GiB of memory. The problem can be reproduced on Windows
with the loose_obj() helper from the previous commit:

	printf short |
	loose_obj .git/objects commit $((4 * 1024 * 1024 * 1024 + 5))

followed by "git cat-file commit" on the resulting object ID.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 object-file.c      | 14 +++++++-------
 object-file.h      |  6 +++---
 odb/source-loose.c |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5d03ae94c7..779167f789 100644
--- a/object-file.c
+++ b/object-file.c
@@ -155,7 +155,7 @@ int stream_object_signature(struct repository *r,
  * Map and close the given loose object fd. The path argument is used for
  * error reporting.
  */
-static void *map_fd(int fd, const char *path, unsigned long *size)
+static void *map_fd(int fd, const char *path, size_t *size)
 {
 	void *map = NULL;
 	struct stat st;
@@ -176,9 +176,9 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned char *map,
-						    unsigned long mapsize,
+						    size_t mapsize,
 						    void *buffer,
-						    unsigned long bufsiz)
+						    size_t bufsiz)
 {
 	int status;
 
@@ -209,7 +209,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 }
 
 void *unpack_loose_rest(git_zstream *stream,
-			void *buffer, unsigned long size,
+			void *buffer, size_t size,
 			const struct object_id *oid)
 {
 	size_t hdrlen = strlen(buffer) + 1, bytes, n;
@@ -1136,7 +1136,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
-			    unsigned long size,
+			    size_t size,
 			    const char *path,
 			    const struct object_id *expected_oid,
 			    const struct git_hash_algo *algop)
@@ -1144,7 +1144,7 @@ static int check_stream_oid(git_zstream *stream,
 	struct git_hash_ctx c;
 	struct object_id real_oid;
 	unsigned char buf[4096];
-	unsigned long total_read;
+	size_t total_read;
 	int status = Z_OK;
 
 	git_hash_init(&c, algop);
@@ -1204,7 +1204,7 @@ int read_loose_object(struct repository *repo,
 	int ret = -1;
 	int fd;
 	void *map = NULL;
-	unsigned long mapsize;
+	size_t mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	size_t *size = oi->sizep;
diff --git a/object-file.h b/object-file.h
index f44758c4f8..a8da9dcd22 100644
--- a/object-file.h
+++ b/object-file.h
@@ -157,11 +157,11 @@ enum unpack_loose_header_result {
  */
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned char *map,
-						    unsigned long mapsize,
+						    size_t mapsize,
 						    void *buffer,
-						    unsigned long bufsiz);
+						    size_t bufsiz);
 void *unpack_loose_rest(git_zstream *stream,
-			void *buffer, unsigned long size,
+			void *buffer, size_t size,
 			const struct object_id *oid);
 
 int parse_loose_header(const char *hdr, struct object_info *oi);
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 50cb388c35..d77e93e7c4 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -73,7 +73,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 {
 	int ret;
 	int fd;
-	unsigned long mapsize;
+	size_t mapsize;
 	void *map = NULL;
 	git_zstream stream, *stream_to_end = NULL;
 	char hdr[MAX_HEADER_LEN];
@@ -250,7 +250,7 @@ static int open_loose_object(struct odb_source_loose *loose,
 
 static void *odb_source_loose_map_object(struct odb_source_loose *loose,
 					 const struct object_id *oid,
-					 unsigned long *size)
+					 size_t *size)
 {
 	const char *p;
 	int fd = open_loose_object(loose, oid, &p);
@@ -285,7 +285,7 @@ struct odb_loose_read_stream {
 		ODB_LOOSE_READ_STREAM_ERROR,
 	} z_state;
 	void *mapped;
-	unsigned long mapsize;
+	size_t mapsize;
 	char hdr[32];
 	int hdr_avail;
 	int hdr_used;
@@ -356,7 +356,7 @@ static int odb_source_loose_read_object_stream(struct odb_stream **out,
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct odb_loose_read_stream *st;
-	unsigned long mapsize;
+	size_t mapsize;
 	void *mapped;
 
 	mapped = odb_source_loose_map_object(loose, oid, &mapsize);
-- 
2.53.0

