Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793524770;
	b=vO335FivGeYzjIG9nda9SHkov4U+y7wxNy8XcpnhkYb0KeRL+nYYETVGXtn+++yx7Yv8
	 j1yhHJuI7uCcnQT0Yn3FK2QCd6AQaXpIzkaP6xdrB1UpdUGyjkJPs4KmDYTLR8UYYFPiC
	 4FoF6iCw2jZH5XhGJ/LLNZjRWinSvyAAZZpXlO+/fjNnDepjJy4LOpih8/De40Dw9N9mA
	 ZPv68/VucOMEbcvwK+TH643G/uSCMmxrB/XfV09HurRa2ukO+VNHMRNt5HF/125ZBfOPI
	 RkDE78WbpwFnxWySR8Ww9GvFwRpAtAt9+7s2t58QwfOWSPxfHMYOl1qB9MWnv1wQMKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pMaaD5ZmD8SnO6MsjI06FfWYfN+NoV4qH1EZIb9v+5A=;
	b=Z5FPo/Jqv5r9GbyKl+d9C5uK0TaJaYrdo8oatuavG+7bYrYY7snFJvaWjKUbUTIRMP1U
	 zsM8D3WblyhLBchpQ9u9UIMHKmpfdeVpKw5dXLH6pxcK1JkMWqeKbjWTbfLhzga4V2KGd
	 O/lsQa/+BKVw4Pi42Erc5MaIctzj1ae1s2A/15hnTawYfTMpg7cNIF9inARSfS//NBLdC
	 0VdGoE5E4kgKmBHiuXVgubryefTbIQmMvd70SZUnTlKyQKIwMpdgbY62ELxqo8SqOFNf2
	 KPvQyCBU7QSiXAN7V9fuUovkHtRhzRRw6Udz+n67/oA8Uo4q5OI6mQImZTovaPO8FTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8XM7+Oa;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C51606A32C
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 09:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C51606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8XM7+Oa
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e10a70540so1148104f8f.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793524768; x=1794129568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMaaD5ZmD8SnO6MsjI06FfWYfN+NoV4qH1EZIb9v+5A=;
        b=O8XM7+OasrAxHn7Fg0P9vi1LS5rtGah49B3tEYFNj/B6Dx71i/+bCkk8UNjIfpVmkB
         7yRdccSTxE8EwwcvMfkSmWXjmgTsyeZ0fnBrFGZ3Dh21ifjPrZRU3q4NZop568ZzCI3H
         DQkPlKGJZ1hQGaNIobffxZrgFWrX9vTUdq2LN2pSI6t2p9F808fK21FTN8inwqiQYCAL
         4gTwOYYetAYrA6dKxMDYuZNaNDluMOOtfpnv0KlQMyXcqx6HOgu+gBZKwoBLCWzVd1h/
         4pIxmBC37xEM/78DsFar+jEjEDbA5RgFLow7LjEn4pwzXS3rUrxdq5VXAGFbi/IdYoPP
         oY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793524768; x=1794129568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pMaaD5ZmD8SnO6MsjI06FfWYfN+NoV4qH1EZIb9v+5A=;
        b=V8VH4jIkvz3fVShOLx6sGA2n7Mr8BrJ1Q8fhXOngGSXSSyT0iWjcEiCJB50b+dJqxv
         ADSOrZi9yiJLI9cdSY2NyKPYhhZ+0u30zMQKZAIETEyCXhX1Xk9EJxdIqIXQt6AiJy1J
         gYBNaMqZT8Ir2Sd95XqQ2C1Sspdbkrk7xSLITo6U98OX8fE97+BjeKi/+U3N9rru3lie
         A6etgE9CfXl7EOe/AomMHP6BXzU4yqqX6uPy+uK0I3vM1ISkPv0qucB13vUOLaAkvwgL
         wviA17NpXwUjas1ztfQwjEVSF1nhIhT/mEYunZyTCvoJFdVOKTAexNLi5c8OYpZqEwrM
         1GZw==
X-Gm-Message-State: AFq9FYIbDj+dxmdVijmvLRpYpvyXt2SvfTigGh+lP+2ypNKs+vxaB/tq
	ZDcQKQwm7HcbRPQERXBpHAAfSWvdRqOM917W9e4Zdz9WFrTyJ4Kih+1ohrXATjO6
X-Gm-Gg: AYBFou1NAm364Xg2DPQZ+lJJWKsywgXnGRxzQbb2Wq4NiAtuqa82o/pB1OY480Y2GdM
	6oyiq4s4B6MTf5a1gDfqCbNVqMPlUiDnxn510JBZbFdc+mLNQSTry5pu+co3ZMHjaGUkuNVLilf
	vKG03fU1hytiKsGhevBo+Z1qPm3xnQqjwBHOGuLGwIV7fLp4Gnr6LW2UEUKLUW8hwszz5KWX62Y
	FngiZ6EJyTZCn9dD85g6tB8ND3kCx3Z+w9Cb1LN90aoE1dUpuNcOz3526q0X2Li7VVnV0SWD8nR
	O4ZSzc2Fn6kECkswpmfe3DgVe7XTJsJQtDkZ8cHrP46pluduTMkeSdD3FKKTKHcgKISan+8XE0+
	A7h/Q1OXJN0/vQufl+wZXimqkX8gqooddbse6vSrnGtnrsyjCVncjv9pZiwAjF0JkvLDLVLEhTT
	TcQmF79wWcexYXDT9P02vPvdQtF1f6ATYbzaaakloAlYnhVJTe2GN3K0vmKxQ4s44JP7NPJca+F
	pr/0IoTAjUc5I6+odYJKZKNORUgLMxsvLrCwQhBKcf9zSdRTD0wway3UrcaoMpDHAGiiZzpj0hw
	O31klZI1cvh//AC92T8yE1phexb5aFqK7LUWOXD27gaHl06MPY96rkLiMi9s89M=
X-Received: by 2002:a05:600c:8709:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4ac181e75b7mr170878525e9.31.1793524768249;
        Sun, 01 Nov 2026 01:19:28 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm14859390f8f.31.2026.11.01.01.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:19:28 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Matthew E. Luallen" <m@sph3r3.com>
Subject: [PATCH 1/2] archive: use size_t for the size of archive entries
Date: Sun,  1 Nov 2026 10:19:22 +0100
Message-ID: <bfd638278f13b1ca127b723e6af738784fc6a429.1793524457.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793524457.git.gitter.spiros@gmail.com>
References: <cover.1793524457.git.gitter.spiros@gmail.com>
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

The archive entry callback and format implementations use "unsigned
long" for the entry size, while blobs above core.bigFileThreshold
arrive as size_t.

On platforms where "long" is 32 bits but size_t is 64 bits, such as
64-bit Windows, streaming a file of 4GiB or more causes silent
corruption: for tar, the truncated size goes into the ustar header while
stream_blocked() writes the entire blob, corrupting the archive; for
zip, write_zip_entry() overflows compressed_size, producing incorrect
headers and a corrupted archive.

This was verified using a 16-bit simulation, where tar extracted
truncated data and Python's zipfile rejected the output due to bad
magic numbers or CRC-32 errors.

Use size_t in the callback, tar writer, and zip writer functions,
allowing the existing zip64 helpers to handle large files correctly.

Triggering this requires processing a file of 4GiB or more on a platform
where "long" is 32 bits but size_t is 64 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 archive-tar.c | 10 +++++-----
 archive-zip.c | 16 ++++++++--------
 archive.h     |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..31ab704886 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -66,7 +66,7 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void do_write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, size_t size)
 {
 	const char *buf = data;
 
@@ -102,7 +102,7 @@ static void finish_record(void)
 	write_if_needed();
 }
 
-static void write_blocked(const void *data, unsigned long size)
+static void write_blocked(const void *data, size_t size)
 {
 	do_write_blocked(data, size);
 	finish_record();
@@ -218,7 +218,7 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 
 static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
-			   unsigned int mode, unsigned long size)
+			   unsigned int mode, size_t size)
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
 	xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_ISREG(mode) ? (uintmax_t)size : (uintmax_t)0);
@@ -256,11 +256,11 @@ static int write_tar_entry(struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode,
-			   void *buffer, unsigned long size)
+			   void *buffer, size_t size)
 {
 	struct ustar_header header;
 	struct strbuf ext_header = STRBUF_INIT;
-	unsigned long size_in_header;
+	size_t size_in_header;
 	int err = 0;
 
 	memset(&header, 0, sizeof(header));
diff --git a/archive-zip.c b/archive-zip.c
index 785689584c..2ca6dd956d 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -191,9 +191,9 @@ static uint32_t clamp32(uintmax_t n)
 	return (n < max) ? n : max;
 }
 
-static void *zlib_deflate_raw(void *data, unsigned long size,
+static void *zlib_deflate_raw(void *data, size_t size,
 			      int compression_level,
-			      unsigned long *compressed_size)
+			      size_t *compressed_size)
 {
 	git_zstream stream;
 	size_t maxsize;
@@ -224,8 +224,8 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
 	return buffer;
 }
 
-static void write_zip_data_desc(unsigned long size,
-				unsigned long compressed_size,
+static void write_zip_data_desc(size_t size,
+				size_t compressed_size,
 				unsigned long crc)
 {
 	if (size >= 0xffffffff || compressed_size >= 0xffffffff) {
@@ -248,8 +248,8 @@ static void write_zip_data_desc(unsigned long size,
 }
 
 static void set_zip_header_data_desc(struct zip_local_header *header,
-				     unsigned long size,
-				     unsigned long compressed_size,
+				     size_t size,
+				     size_t compressed_size,
 				     unsigned long crc)
 {
 	copy_le32(header->crc32, crc);
@@ -285,7 +285,7 @@ static int write_zip_entry(struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode,
-			   void *buffer, unsigned long size)
+			   void *buffer, size_t size)
 {
 	struct zip_local_header header;
 	uintmax_t offset = zip_offset;
@@ -293,7 +293,7 @@ static int write_zip_entry(struct archiver_args *args,
 	size_t header_extra_size = zip_extra_mtime.len;
 	int need_zip64_extra = 0;
 	unsigned long attr2;
-	unsigned long compressed_size;
+	size_t compressed_size;
 	unsigned long crc;
 	enum zip_method method;
 	unsigned char *out;
diff --git a/archive.h b/archive.h
index bbe65ba0f9..e52328d639 100644
--- a/archive.h
+++ b/archive.h
@@ -56,7 +56,7 @@ typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const struct object_id *oid,
 					const char *path, size_t pathlen,
 					unsigned int mode,
-					void *buffer, unsigned long size);
+					void *buffer, size_t size);
 
 int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 
-- 
2.53.0

