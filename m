Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069329;
	b=LGBP03aJQTnOiNa/zUkMr3x3n5RVuattcWe0qOue9UYWyJHbu00UGgWqRKKZxdMOtcM3
	 sXQFl3PFVsYWOboKLeQfbXeTYFMRR8k35BBUBzr0S5xzAuL5T2xg2P5sV1iAgxYw9Xxhl
	 iPd/sMXM/RxVfHSRUBsfkK6c+M6XQ/PRerhb5JHdOtUBC/XGQE0dYp9AZh/HXzrDjFkgf
	 WMh4ZyhIWSdF8g3CtCJfMMha+xhh9UsbUKdVJDy2N0H/UxomI6CRDUL1TnzPJmv65sJkv
	 92i1H2u8ecbsV4GLCbrhtjNQk1hLEPtjD2nmE+OJO973ap8n158Os1YmLJZgppGqqig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B3BX5J3v00mAyVxGykA4nqtbZDsMJ1ecF3Yx5UFZqGo=;
	b=w0ZoHbvhsdEdY9oWk6aXf4wINzy/o/3kAf8ov68p05z4/wsCrSQ7V6madHR5KAdB3iWw
	 qb8CiVqQrUF2NTR/uF6P+MTTz9Kqa0bADOXJXbo4E7D8gsGxhqxhErlSoL93NgJpp4+EQ
	 FS3OVrvoZIMr7SutEAGRZV816DWPZ5r8na0t948oU+ajLI1toRunFb5MnbCy/5m/wmWiR
	 QSTzmo86QYra2tqkrGbiLwIWqgMX32ylbK3vgp4lv+BmmONadJzZLn+xsnjozBBSOdtMI
	 ohP6Pj0YGu34c/rImhuWkmrCXCqU2DKWnzOjTOAWVJGcvnQ7UsNbm2i31qn6fBmoL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1GjRQ3s;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB65606A33E
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB65606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1GjRQ3s
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so18984955e9.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069327; x=1795674127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3BX5J3v00mAyVxGykA4nqtbZDsMJ1ecF3Yx5UFZqGo=;
        b=F1GjRQ3srckhzK/lgrpVIDUGV98YYqnAM1OTgUBqEieg61X6qIiS1oEsNbo60hNMxD
         sczGlX/0T/Egf25s2Y8ggA3jMreZv8zdvxNOFYDx7+o01qNnMFv+8KKUSGzMR+TU4aPZ
         vAekKa532NjFCJw3cPUNkQ0uEuWqFaecm+X31tIzRXodql1QFHj5XtEpCd/r0DmBF9gK
         2i+fLn68bVE2ioeudIkzQ60GPccN3iT7NJdRyjH+HzrpjLaRsEeriX0VQnRwlVh9zkxv
         s87nH4+3iioxeq1jfHq+GMAiRjDpBAfw1oik8ppwYbvRDgWRaTXdrdXGRWmE2X5qVCCX
         ynvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069327; x=1795674127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3BX5J3v00mAyVxGykA4nqtbZDsMJ1ecF3Yx5UFZqGo=;
        b=atOf8dT5wutsCAzWzx4d8O+/qtI8RAU2QxYZDJYbjbmRmNtzJ0mQb6cMGJWNotFlUA
         uxtrZq4Cjm2ygmykryoTBEWkwunQ5fSQKxYCxrCjVKX9zmlqpyIWQ5OdKWKQ5CWs+TZ2
         QcBH+piK+wx/s9fNt3aFDDtb5d8dYv/8zmgn+M2tpjBPSAw5QTyjtyc9GqHK8tWjq+OF
         Z0FBGrb8IkmlzZNQwl6d/nrkpBPGboV8XxulW2XlHW+oz/dusoxL1vtJm5R6cRfkqbR/
         H4C5xN2CyGX2aRgy40SOP1CCRk/LmJRdOYLd+0ALSSnSThLSea31Nl3W9jcD32lI2eVa
         Q7kw==
X-Gm-Message-State: APuU4Z96obAKodLpW43gyq5C1nJrLoqBpGoyaf8Kb1ETUBYxU4pn2R7V
	2TUdvPxdTzzavXXldcUYoMk/vXA4TZ8jJQqNu1pl+IURR+NeAhBiWoIBNgX0GA==
X-Gm-Gg: AYBFou1IBVOUcJt/6ouMCtGpmjAVTGMtT2sbAyRY1wCkufTsrAzo/2QHiyZBtwtl/9D
	0cN1GMSIwSvNpEdUPKz2+24DYKAdHjsS1MLvtyQNhzH8z5M1MyETUXeQNI9WHYYv75k20V1OnhI
	1AXyoHBDdVglDoeFH25bWriG12HAmVV0MmY5ddmQbJ9umpBS+rsF6ND1MPvmiZZYZ064bL5FdVj
	fbVaxz4sc7UuwlDiFcI/s65s2UpyTx57waOffPq8RQ3BLxtpuQvDuO0PM5QLjtDJy46n0w7wz98
	C3NoNekV261vbo6Obzuf6AwRKgBVEIxxrehIQodDVTjqjkJ5vkPGQp/0qa7tnI/zEJQGiW+nAem
	YStqZtCMGMBaq06MQWhRDboOr7vqV92A2gTD6MgxJ8eM4kP8RcDzYYD6hsvmeunaVWrJzzSDXzo
	/PgKjYqE307qnCauIKWat1UNIsh60cxKcn21/sYDULzVfh2T+J4MWhh+/7Lj32RL2m+Tom6248j
	a4DywoCljUEbprmRF85PK9n96alTFMqAL666jX57duVcuqlVKiN30kw4nf2emJrzre73Ylz6JFU
	hXsRWb7LLGiZGTwt7gsATrJBH3qSzL/vR0HBBeiBLx6FhMfXThG3KPvTS4j11jDa1UMdrYZ3/8e
	qb+b/hzJt
X-Received: by 2002:a05:600d:41c9:b0:4bb:7033:c938 with SMTP id 5b1f17b1804b1-4bb7da186f9mr79176285e9.14.1795069327194;
        Wed, 18 Nov 2026 22:22:07 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm8508413f8f.14.2026.11.18.22.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:22:06 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/5] object-file: use size_t for loose object sizes
Date: Thu, 19 Nov 2026 07:21:47 +0100
Message-ID: <c9facd8b3b8a60c8516075616f66da4308380684.1795069177.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795069177.git.gitter.spiros@gmail.com>
References: <cover.1794914210.git.gitter.spiros@gmail.com> <cover.1795069177.git.gitter.spiros@gmail.com>
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
size_t, but unpack_loose_rest() takes it as an "unsigned long". Where
"long" has 32 bits while size_t has 64, as on 64-bit Windows, a header
claiming 4GiB + 5 bytes makes us allocate 6 bytes; the check added by
the previous commit passes, as the stream does hold 5 bytes, and the
caller then reads the object as 4GiB + 5 bytes long.

Use size_t along the whole loose object reading path. No st_add() is
needed on the way: the size is parsed with st_mult() and st_add(), and
a buffer of that size is allocated with xmallocz() before anything is
added to it or subtracted from it.

No test, as the reader allocates the claimed size before it notices
the short stream. On Windows,

	printf short |
	loose_obj .git/objects commit $((4 * 1024 * 1024 * 1024 + 5))

and "git cat-file commit" on the resulting object reproduce it.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 object-file.c      | 14 +++++++-------
 object-file.h      |  6 +++---
 odb/source-loose.c |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/object-file.c b/object-file.c
index d7057182ff..a5686a468f 100644
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
@@ -1140,7 +1140,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
-			    unsigned long size,
+			    size_t size,
 			    const char *path,
 			    const struct object_id *expected_oid,
 			    const struct git_hash_algo *algop)
@@ -1148,7 +1148,7 @@ static int check_stream_oid(git_zstream *stream,
 	struct git_hash_ctx c;
 	struct object_id real_oid;
 	unsigned char buf[4096];
-	unsigned long total_read;
+	size_t total_read;
 	int status = Z_OK;
 
 	git_hash_init(&c, algop);
@@ -1208,7 +1208,7 @@ int read_loose_object(struct repository *repo,
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

