Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356129;
	b=u7FV6+YmtTZVNhQQTQOM18JvxUWgvl7QWYK1OiMGhkm2RnsC3RA+TRN7u/dBs30TLwle
	 6NoXUSFrenGNBHoFA/Tb+DEN1R7xrAsn3Ct4qybikUNLswr5JdTAaevSPLmchpNto+zCH
	 23aZd/su1rvmuG3CFY3//kuV0mrax46voSdaAxhp15d5HNOYs7iqAF5Qys21l4WLJ06WN
	 q9fk7ZPMGI4VOrNs3UndKmsRkM1+CAioy1biowvYD87LbIZCko0U5Ns0tzoI/AJVrCgt5
	 0CxPsckRdo7hYiaC/dNh5bMpdNIRudnrVcj5Q9h4CbI3532NQRrTlsRMcPmlnya3JDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=62LH6tXgHkNXNQFKVS3eAj0D0bjF39cfuYXq447uUT0=;
	b=44+87qsTc3JYTbaNy1T7Lo7rbdNCTeuBkhgfEm3OYt4nLC+9Dd4nf9vS7xspsBDYXbTy
	 Eid4aJ2x1eb8Y7qUSMklNFJcMQyVeAgX1Lu3Y7E2r/WaR/259YbXWQkD4Qe2StNRZ59e/
	 Calr3WTL2MuZZJWiaI/W1oiFKUSGQhY7WvipRF/vW8fmc6CukV/x7G1D9MXAWK1qAv4M9
	 5tIvekhd2ys6KQVycTeLPeRhqCq8m+oSIJnoAaWaV0ECpzWMdFvwNeGghacUpSX4l9e3x
	 59+gTq/NdvEiozhp8k4hOfgGkqaxFqjdtiGnjRoUlafWLTSVKjE3PePX/3H3hET7ZmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+njIDDB;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1460A6F4E
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B1460A6F4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+njIDDB
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b042c0728so123914f8f.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356127; x=1793960927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62LH6tXgHkNXNQFKVS3eAj0D0bjF39cfuYXq447uUT0=;
        b=T+njIDDB+SGYMYlgpComfSE5xEWmWFrT83Zk7eZQh08pP9ocXV8XYZs0qG0h5AURhp
         nviIkthpG6eHdhbqCkOjWxiiwT9Qm5g5LVI6XE1MNY1P7IfLFtJjOi5kSucpDL3qLwAa
         WRQLnl8ai+qHdzsOdiwt2SIITB5W2VKvRP/BEmbBiX0q5TcRoafS87S4HBmKCkxs7WTk
         +LoyE28ul18B1D2vCRPClTT69vldoKv6szfPR5yAkiFdq2QhvSsYj1/AOyiQhlD1AeN/
         1LQ17/zOEvsLUJy2uEfzrVXkRMdW1KgWWTNUkVQhlCMbvcE3zQeYvreMGiLoiJSdbsnM
         Yv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356127; x=1793960927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=62LH6tXgHkNXNQFKVS3eAj0D0bjF39cfuYXq447uUT0=;
        b=czZX7kXugP3VglF9fz+naImTWGBiF/Mnjo8x4YQ5KsmbIv8VYiSPW/5bN6Y82J0LTo
         pR80MTi2/hOtttROPz+qL/hCy1dAzqXlmhMZiluZpouanYL4HnBjVjS0e9J7YqO2Scet
         +yUgJW/O3DHa1+H2fJsc/d6OR4edLsF8XRqvpCt+alf+xvW4i9C4b56Uh1TLdWUDO3Ch
         vksaWIAyZ0Y01f+UXoV+wHURRDmnDG5N4UDSKYZLo71ByScBcBttUQXsypZhUSaOVMk9
         RGDXUCO+bGgc5nQ1LXaE7LNQnxst7rMwljNAH/3M5AzzZn/J2/hWulfI2R+Hu1LlXWuq
         layw==
X-Gm-Message-State: AFq9FYL7QeR2p4FHByYlKUEECT53hKiRlbHOExMfu/t+8CcEbG8NVWSP
	NcgZMZ2jfw0Y0HRXtfhE+rf6D1DuhWvRmvparFbLjzcUc1q7oRgG/tnOLIDAkA==
X-Gm-Gg: AYBFou2pw/Q35M39T3znEPdkfhJIjNsS3spRW/Hq6Nv/MJ3q8jeewxIIJU0lBIQv3xY
	fLlVc/QTJvZHwT12st9YOHFe4LevNu9Xk56cZLwZZ/4lZe6sXKZZpI+AnABnPO5g+wA0lkalRhb
	vtfpr2Brz7B+RSvfCHg/ooSkAeDfBP6sqOYyYcQX9zQtSPA69T4tL/jW1ybTtIvZZgCtl1rTkbe
	Q+HrvGmeB94sQ08C1X2Iu7wBlsqzlnktnGcrOysjyoU6oly8mrlVnRotKr+G1nIU94NgODv11Pg
	bCLnvrIgOco56BWqnS6H6cZnw2FQx42rcKZ2NC/hbctxvzKNHS6DVezKiHHrURbZ6WIn+9M6o5c
	HuLVr5qJVjRJrN+nrx+So2bIorI7Ps6mBGkVcNU+MKQXPA5BFBwrP/A8WLIHtHFXmYuNPn2KKma
	TcFyZuB5lnpL+KGURGGJFnZM5pn1h+nGM0/Ut9bBz/nZMlIH96ciwo3R1UYERsdMpMBaN7FD9vz
	a7aCH8PBGa+0imbSpFgZ7rd6pVVAVW+tKXbv52vsh6BZZZymgijGTEiHrM/Z9oObZGc/dX78dNZ
	odzswLz16vtFFtHjmyXeiyGZZreWarZh+l46yIWR7RPGTvMvXQ==
X-Received: by 2002:a05:6000:4311:b0:48e:20ed:d5e7 with SMTP id ffacd0b85a97d-48e6e2ff167mr4035848f8f.34.1793356127363;
        Fri, 30 Oct 2026 03:28:47 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:47 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] object-file: use size_t for loose object sizes
Date: Fri, 30 Oct 2026 11:28:35 +0100
Message-ID: <ee4439354afda7637f935293d5accff91cc0ad71.1793355390.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793355390.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com>
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
size_t. But unpack_loose_rest() still takes an "unsigned long", which
is only 32 bits on Windows. A header claiming 4GiB + 5 bytes thus
makes us allocate a 6-byte buffer, the size check added by the previous
commit is happy because the stream really has 5 bytes, and the caller
gets that buffer back together with *oi->sizep set to 4GiB + 5. Any
user of the object then reads far beyond the end of the buffer;
read_loose_object() already does so when it hashes the contents.

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
index 6d39138511..0fc240b1e8 100644
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
@@ -1135,7 +1135,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
-			    unsigned long size,
+			    size_t size,
 			    const char *path,
 			    const struct object_id *expected_oid,
 			    const struct git_hash_algo *algop)
@@ -1143,7 +1143,7 @@ static int check_stream_oid(git_zstream *stream,
 	struct git_hash_ctx c;
 	struct object_id real_oid;
 	unsigned char buf[4096];
-	unsigned long total_read;
+	size_t total_read;
 	int status = Z_OK;
 
 	git_hash_init(&c, algop);
@@ -1203,7 +1203,7 @@ int read_loose_object(struct repository *repo,
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

