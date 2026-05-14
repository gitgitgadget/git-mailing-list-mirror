Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5F39EB58
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783882; cv=none; b=LwCgUITPWJHxkFkA/TpVMGD5XPemwRrZvfwFhRvkXXhIT84tkgG2JF2jmKWa4f/kEQNzdQRHcNWPw72uwcr2gxgxBT2WLFWPcELr89eVbKojttVcGpl+c/DpMfGFMQOK/9dCMUwE9E4D//3CxW12Q543yMD1Y4KavykVSJsfFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783882; c=relaxed/simple;
	bh=vo9WeIW49Camqm0Xy1YQ5nTq/nVq4eg8ZXb4L0WB9wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN2Hui41xNa4ZtoEYDpRt8g2N5U17g2YUMJ4G2l08+Ygo9HHlNqIN5wz6maoUaJ7NSXsTjF878X4PRpixhDWdUeQY9bO5zhivWO26Lta0PkYGA9hVEMl6kJhVchCoW5XJblbP+dYy0LeU9dCYhHiVpLMsjRza0MOc7CcqQP8Bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb6L8dFC; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb6L8dFC"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-404254ffe8aso139112fac.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783879; x=1779388679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feRdvjTnbKpIlFWaeBPfJwjvtCMki6CbVTxfQk+EG2g=;
        b=Gb6L8dFC0dS6ngkgSh4s3Bevw58k1FocsQIc/U/iv8zVUyL6PzEgZHUjLglkeBoFzD
         wWukO0xfUtd7lXqmJBk5jUSXoa4s4ge8G4H+daKYawCNX4hKRqRRM2drOm9bQJ3LHsKe
         WAI0lF/lBTE1fpID2UyU6kNhWtH6HLZipv/qm1i/PQRF7PIQjWKJ9MD16WiGFuiFEnRA
         XKVKX68Ccyq+tPa6z4h9+MOwrCMmHgcuUnEmtXt3Lvd06AqwzekfbHqh4xOCpdqlayXV
         a3UQCxn+SZ04XSVDotZMl05fu2QBhL7em1vsT4DkT9RpplvD2/685TafMDuWNlp2GK81
         GCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783879; x=1779388679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feRdvjTnbKpIlFWaeBPfJwjvtCMki6CbVTxfQk+EG2g=;
        b=HneH+/oAgUQd8qNVFqCqtweTCJQ8Qq2XkG7eYDCazj8LSUngMWXevsaFJM8HmJJaZq
         4jCkun0Qi+7ltJoZ8UpA1Ux5xMCPDrB7y8IJSHu8ZVmUdE4ROAnxeIuGRG4MMSj525RB
         9JPAvFq45Xu5dZCoxrnWdROjqQ+hZz0HMr2G9JSke9x5boLtFUWV+a6ZOf3lslMaTaad
         xiL6S1+Wsjk1YCMJs+FsipNQfosqVhDw7suTpB0kYi7XYFCdiAPL68+/D5FJ1twY6QFk
         1ccDJ472CfDYck3m+ujcqP05zWNN7oE9bjaroZVCaRb7+RLA10kQY04GljSRP8bcj/eZ
         Xhxw==
X-Gm-Message-State: AOJu0Yxn9JrGclSBta11JJGg/IczRCxGLGcWIR4D0wNhIBWH9qYRT6Jx
	ubw+Izf1vRejad2Q1RGTNSo3VOP7wLLrt5PxoVa0mhKjJySGiPEGtd4syoAogw==
X-Gm-Gg: Acq92OG0Jn1KYYVGqINZDjT6CEqDUByuZMl/MdGHjSS5pqPQP53KXv0bUvSXg3KWeDA
	Gx5mr8OK7sdpb9Eid2er5uRR7KWsKszeb0lyx+bZwzutKPePKfbhWtKSaeSk+kukoqK7j40Uwgu
	dnrl8gzkRBCMy/Vs8LS1uhGLish5o5AqNEjIgDAt8zh7Mqh2K/vGwXoNL7w7sNaRqzcBkPHjcVj
	BmTKkhDQFvkQegLTrNhNRHgPrlxX6M4rAX05bxMwQcA+toz5aYg1UUihjSRcmAZvOLQpWSdQlgX
	lOCmb72iscRWhr9tmuCCFJaAlOVEtnYPqFkO/duhOIF7kLvVnnDmJnkA2ten71c7eMv9janqCki
	N//zSzWIknVLEtZ8teiK/HvLbLwFLCf/dKKofGxzBTUMhaZMWTc1G083YL5x04/yydNsDF8wGot
	6My/aUgoKzhzu0h0zNPBOSPeFNPppWICfTAQxkvFmjbg==
X-Received: by 2002:a05:6870:b4a7:b0:423:9751:c1c5 with SMTP id 586e51a60fabf-439f959b6efmr2603962fac.22.1778783879550;
        Thu, 14 May 2026 11:37:59 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:37:59 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/7] odb: update `struct odb_write_stream` read() callback
Date: Thu, 14 May 2026 13:37:36 -0500
Message-ID: <20260514183740.1505171-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260514183740.1505171-1-jltobler@gmail.com>
References: <20260402213220.2651523-1-jltobler@gmail.com>
 <20260514183740.1505171-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `read()` callback used by `struct odb_write_stream` currently
returns a pointer to an internal buffer along with the number of bytes
read. This makes buffer ownership unclear and provides no way to report
errors.

Update the interface to instead require the caller to provide a buffer,
and have the callback return the number of bytes written to it or a
negative value on error. While at it, also move the `struct
odb_write_stream` definition to "odb/streaming.h". Call sites are
updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/unpack-objects.c | 20 ++++++++------------
 object-file.c            | 15 ++++++++++++---
 odb.h                    |  6 +-----
 odb/streaming.c          |  5 +++++
 odb/streaming.h          | 18 ++++++++++++++++++
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index bc9b1e047e..64e58e79fd 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "odb/transaction.h"
 #include "object.h"
 #include "delta.h"
@@ -360,24 +361,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 
 struct input_zstream_data {
 	git_zstream *zstream;
-	unsigned char buf[8192];
 	int status;
 };
 
-static const void *feed_input_zstream(struct odb_write_stream *in_stream,
-				      unsigned long *readlen)
+static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
+				  unsigned char *buf, size_t buf_len)
 {
 	struct input_zstream_data *data = in_stream->data;
 	git_zstream *zstream = data->zstream;
 	void *in = fill(1);
 
-	if (in_stream->is_finished) {
-		*readlen = 0;
-		return NULL;
-	}
+	if (in_stream->is_finished)
+		return 0;
 
-	zstream->next_out = data->buf;
-	zstream->avail_out = sizeof(data->buf);
+	zstream->next_out = buf;
+	zstream->avail_out = buf_len;
 	zstream->next_in = in;
 	zstream->avail_in = len;
 
@@ -385,9 +383,7 @@ static const void *feed_input_zstream(struct odb_write_stream *in_stream,
 
 	in_stream->is_finished = data->status != Z_OK;
 	use(len - zstream->avail_in);
-	*readlen = sizeof(data->buf) - zstream->avail_out;
-
-	return data->buf;
+	return buf_len - zstream->avail_out;
 }
 
 static void stream_blob(unsigned long size, unsigned nr)
diff --git a/object-file.c b/object-file.c
index bfbb632cf8..a1afca23c5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1066,6 +1066,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	struct git_hash_ctx c, compat_c;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct strbuf filename = STRBUF_INIT;
+	unsigned char buf[8192];
 	int dirlen;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
@@ -1098,9 +1099,17 @@ int odb_source_loose_write_stream(struct odb_source *source,
 		unsigned char *in0 = stream.next_in;
 
 		if (!stream.avail_in && !in_stream->is_finished) {
-			const void *in = in_stream->read(in_stream, &stream.avail_in);
-			stream.next_in = (void *)in;
-			in0 = (unsigned char *)in;
+			ssize_t read_len = odb_write_stream_read(in_stream, buf,
+								 sizeof(buf));
+			if (read_len < 0) {
+				close(fd);
+				err = -1;
+				goto cleanup;
+			}
+
+			stream.avail_in = read_len;
+			stream.next_in = buf;
+			in0 = buf;
 			/* All data has been read. */
 			if (in_stream->is_finished)
 				flush = 1;
diff --git a/odb.h b/odb.h
index ec5367b13e..6faeaa0589 100644
--- a/odb.h
+++ b/odb.h
@@ -529,11 +529,7 @@ static inline int odb_write_object(struct object_database *odb,
 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
 }
 
-struct odb_write_stream {
-	const void *(*read)(struct odb_write_stream *, unsigned long *len);
-	void *data;
-	int is_finished;
-};
+struct odb_write_stream;
 
 int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
diff --git a/odb/streaming.c b/odb/streaming.c
index 5927a12954..a68dd2cbe3 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -232,6 +232,11 @@ struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
 	return st;
 }
 
+ssize_t odb_write_stream_read(struct odb_write_stream *st, void *buf, size_t sz)
+{
+	return st->read(st, buf, sz);
+}
+
 int odb_stream_blob_to_fd(struct object_database *odb,
 			  int fd,
 			  const struct object_id *oid,
diff --git a/odb/streaming.h b/odb/streaming.h
index c7861f7e13..65ced911fe 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -47,6 +47,24 @@ int odb_read_stream_close(struct odb_read_stream *stream);
  */
 ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t len);
 
+/*
+ * A stream that provides an object to be written to the object database without
+ * loading all of it into memory.
+ */
+struct odb_write_stream {
+	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
+	void *data;
+	int is_finished;
+};
+
+/*
+ * Read data from the stream into the buffer. Returns 0 when finished and the
+ * number of bytes read on success. Returns a negative error code in case
+ * reading from the stream fails.
+ */
+ssize_t odb_write_stream_read(struct odb_write_stream *stream, void *buf,
+			      size_t len);
+
 /*
  * Look up the object by its ID and write the full contents to the file
  * descriptor. The object must be a blob, or the function will fail. When
-- 
2.54.0.105.g59ff4886a5

