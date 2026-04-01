Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26370330305
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012608; cv=none; b=HzqAXZZUOjV34yfaAMBmwYpXNwWMPwgDYdpmqn5llAId2LGr+xNa7n6JAMIE/+gC/OuoHN1wMA24Ek+sMKzFzMgGF0posKzEs+10ifOcgOhM0G23Z1xDg7CwTkNN70VX6v26MmYD0d6IN4+9sxQ9CB6/hro0KmfJO7QQc33aNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012608; c=relaxed/simple;
	bh=7ctc/udTpDOwf8RonNysWRguSwyZqmdPioOi/kk6/Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCMrlLXXXfd4/PBo0CZXM7niiEjEyf6+LpcyIyQDTU4S5PtS1V0Wmsyfj9OOhMmPJjbtBY1kTGWOvaGD0WOxLI+/ozfTJFFrZ3ppkqEF97iQbGvkbKbvF9OhcJSLQyCXeyp6dAH9YetiB/NPx0lUGPLAicoMdSx/yH+m/XKDoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=po5uxhyI; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po5uxhyI"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7c77fd31cso5936834a34.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012603; x=1775617403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K19aQqT4Unok6dbzDISfLY510iqT2jjWbSBcgsQ7W9o=;
        b=po5uxhyI/VqhbMBRPV6oHuXNajt/AdCI8+T+EDcGq6isksBs+7WTZJwvfPjUxbcZof
         +VTr7rE/cutqG5UDI7PCBGtlmkPhSJNY1udNu+iva9poPWWrLMnVmAoDwuoHn9VzFXf2
         dN554KPhHOeJNSd4vGHR86rzTxawnRMa3LvjdRS5ZkyottZgpMljvTzMAECxfTILXauh
         zqZ4HIr/fbpKC378VLfa0lLmaVOuqcqNSIdR8ajKw4T0yx93Ad92f4Q3JKQ3Cv3x/gBZ
         7Irh7hUCJc1wmkEHB/Ra/ivjyEC5Q1HZ35Az5JitvIFkw7fUPw4Ph4n7rYN059EPx0zw
         k9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012603; x=1775617403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K19aQqT4Unok6dbzDISfLY510iqT2jjWbSBcgsQ7W9o=;
        b=st4HkMTpXcGMQSjHBzmV+lYsnjFzcwTuyrNtBFcWBN6w5/RClYCEEHWktZtVkby6Oj
         GmF93r0bmiwRxPezyEbkhXabcff6rcluFdX6FLvGAymDLvViHiZWLs/n1tfCsEqJE1jq
         DZdpwU3FmzAxNm0UnpE2CnVfYwjPL0LT8EO/f4BhmSN3vvhfDbvz785LLID+QSBZU2h1
         YejH70ZZ65m8xTNht1nn71t57o/kIwg4DF86lK5s+AI3yY+udmAIDKjkMabskb6NzWEN
         RlVQdileRB9ssgoQSDwK+HswCa+DQmxGQ0CyK7xMnlxZZiu7tPq5wR0BUZ9jPud1vej6
         MDxQ==
X-Gm-Message-State: AOJu0YzD6tc3vIzrnsq7V2wme7M5NBNXUARcgAUWEJfafyNEQ7G02CHr
	5YUTgOA4kStSZ3XAG4r7rQulW9EMz5kE8UqCcerQCZ75NncOci243dLuRiNsbg==
X-Gm-Gg: ATEYQzzpcbyi5JTPsGM7NYjWuZrJq422lp0KiZX/XZ1S0QWnRNuP58QsVbRaaFurQsf
	fb/9alZoA55VZ7n2TF/tZMl0XaPyhyNQXUF5BgYIe2jo20ay6TY3+swXIR1IA8bNFu8HsY5g2cm
	Mf7UnFb3C5CUK1ROyJK30GmuO5h4n9UbLiCRPhiHiHAIABioNLZnxJcqZeKtFVMcsgGm03XZkFg
	QO/1TML3NPOXaRGK6Zkye6tKhWNE5ZKitI4+fvjwOMV+bdQwvk5uMsVIzvW9otcURLeigexMjer
	UYVbgb8n6G2KAKVMSOkXvDNYuhW6Do5qt9Hltv+0+5gkCVLRJMb6ugxdziBs7Xm6A5Qao9UBMQa
	jlwkxaaEtIcbBJhBQp1zMCEL4NqSyaD4YpL74Px3Eboo2ac+aHFnJlQOY6UznOGZSU60TP/Vf2L
	nEFHR3MwDlLyB78wPX1PE8Y2BasNyal3k=
X-Received: by 2002:a05:6830:6a93:b0:7db:984c:a1f2 with SMTP id 46e09a7af769-7db991d50e4mr1453898a34.3.1775012603540;
        Tue, 31 Mar 2026 20:03:23 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/7] odb: update `struct odb_write_stream` read() callback
Date: Tue, 31 Mar 2026 22:03:11 -0500
Message-ID: <20260401030316.1847362-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
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
negative value on error. Call sites are updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/unpack-objects.c | 19 +++++++------------
 object-file.c            | 13 ++++++++++---
 odb.h                    |  2 +-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index bc9b1e047e..420619e2cb 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -360,24 +360,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 
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
 
@@ -385,9 +382,7 @@ static const void *feed_input_zstream(struct odb_write_stream *in_stream,
 
 	in_stream->is_finished = data->status != Z_OK;
 	use(len - zstream->avail_in);
-	*readlen = sizeof(data->buf) - zstream->avail_out;
-
-	return data->buf;
+	return buf_len - zstream->avail_out;
 }
 
 static void stream_blob(unsigned long size, unsigned nr)
diff --git a/object-file.c b/object-file.c
index bfbb632cf8..f3038756fc 100644
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
@@ -1098,9 +1099,15 @@ int odb_source_loose_write_stream(struct odb_source *source,
 		unsigned char *in0 = stream.next_in;
 
 		if (!stream.avail_in && !in_stream->is_finished) {
-			const void *in = in_stream->read(in_stream, &stream.avail_in);
-			stream.next_in = (void *)in;
-			in0 = (unsigned char *)in;
+			ssize_t read_len = in_stream->read(in_stream, buf, sizeof(buf));
+			if (read_len < 0) {
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
index ec5367b13e..91ec206eed 100644
--- a/odb.h
+++ b/odb.h
@@ -530,7 +530,7 @@ static inline int odb_write_object(struct object_database *odb,
 }
 
 struct odb_write_stream {
-	const void *(*read)(struct odb_write_stream *, unsigned long *len);
+	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t len);
 	void *data;
 	int is_finished;
 };
-- 
2.53.0.381.g628a66ccf6

