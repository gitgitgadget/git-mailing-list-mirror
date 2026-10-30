Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356128;
	b=27akGapBFdzuhKsgsIomwdR+prv4mZUhj1oecBz/n/7H3MCLmIIVJGpKjzxvWo6hgXmT
	 kCqvqgYeFI0afWXETS3CQ8ZSEwCZYkpmsFKaId95f0Cwt6iVNxkm3rHzy3L2pqvVBMW/J
	 XHtga+uI3O28ORtWipZgLCSn7Bv8H98hGY8BQYWLVW1Lg68w9ibL+iFsvG6hTfTcpr9RT
	 fU6Z+8bOJlpOQGGIw7KO3haere6SMPbj2uV8X0M+ueO/XjD+k5Qn3IzufpUnYMjSj87IL
	 HhDpUYNRKeKzNixr07dl2upWC19tprIvr6XFL2N8bSFIOgCcO1x8DYCEqoq7/0D7A3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YfdX/o6CwbfM/kj1CTQ2Cv7cDqpw0N6PZX5sOl9jbVY=;
	b=U5FYDShjhQaqk2rSpKJToVLBW02m/Wo4jZkx6jjxOzzwe/pkOumK+OABbrKumnkO1Y5u
	 EyjTbBdAyJAGk1Jj8I/Q7QYAAZmV0LJZQVATDt2ocogsDsVk++IRkZOwKGGcriQGJSkYM
	 NHmOl/kvF2o1ZRooq8vi/WI0djgX4qiF7UQl48T+XPN/glHSn9jkH/jpkRh7+VKvK9AXO
	 1PEn4DB9MtDrPZFtUcOPm1bYQoQiIbOqTYy2UI0FSqsyz6DUEBwgpXT8/TxLIb0psKMml
	 /cyxFjlXll2RdFnzGA1IbNy32iBPZ4uyixHk8W7SIlG9Qm+Pi1y10TQOByKeW2o/LAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgIYuViw;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712F60A6F43
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C712F60A6F43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgIYuViw
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso4493285e9.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356126; x=1793960926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfdX/o6CwbfM/kj1CTQ2Cv7cDqpw0N6PZX5sOl9jbVY=;
        b=FgIYuViwHoxIpd2OMQs9rJ3qujv0D6FuOvK2uPIV7NrNYncukQ1oURQ5CdztzyWqC4
         nhpGshAWkDEaCvTKLbtfNvZ+Cawg6xI5EjqZ+RTxLQu4jPa3mK2G5cmmetPyKqy3ZRwk
         ur2xNml9TLCvqQnJpLjVBDQ75BWjkd/CmpgK/zXDczKyzD9uqaLJMYtdqwBVMYJteEJC
         6/A3xwaEp2WZXFDejmAdV+rVwY9cPCtaE0go6ZNZkblMrwv/ryDmUSJpmztZqGcRwcrg
         a/+A7wZx1YDm6UpD/qNVYHcOL8jbiXoLON7VKsNtZ7uOItrXUGVQYJJ5MXzRVJJf4Hur
         1/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356126; x=1793960926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfdX/o6CwbfM/kj1CTQ2Cv7cDqpw0N6PZX5sOl9jbVY=;
        b=ohfsUA744nByH6zmjC88aEdF8h7hv7333wRjisIdX8aKycb4JbdGK0q9Wn4UxHXOHy
         kAB2cO0x/B8NpdpEaGJ4J8Mc9QgcB/LgN0XA7dv1FZdFS9y20HjKdyCfkpO7jUEZbVIM
         gNHEgGsjusBoddo1XyoK6ux3skowvmOYPOZLhNsV5L9vKvGWeHFQwW57k5KdKfJqWirN
         SMvW6wgV6k97SLvOESKaH+lJ3/OlcHwQ0Yuxwp1mmLyuCx3phDETVWceD8Fq5AFGAdXF
         enIhiGGVf7jJC0n84Y5gEYXiWVsrhFPOdgnQz4JaP267zBGVci9uB6c/jGHNBpVfETEu
         eplA==
X-Gm-Message-State: AFq9FYKpefW4MLy9BzZunl11OILsRBG1mFC2a3xuaHKKU+5zZLPKbzjY
	yZubBbG4A/plfLWugow6+dgS5AoPflmQSj8MfnSmqEY1SUCz7lWkFi7nQE3cNQ==
X-Gm-Gg: AYBFou1QrCUqzY1hLbRjrbPbw8oG0zasrhGkK+WuDxiFAh/L7MKnpDsmPdqiLRzr3CD
	Go1q47EVyoj2LPbv0gVrDrtGpiZsrFS8G5e4yJRvP6LwYFIF2Y+j4gBRCeGEkQ9goRxIws6Zx0G
	DQZ8dUXJQl4DCcJk4QZFoW5/nbnCTKurFKLIMQjlFop9kB92NvHpQYu0PRsAdsCqAn/eZKotqxg
	RXupjKjpZVdxdeWqtLrV7wIezKfPLfQcyqMbwMEDZMqyTbyErAeXwTYu8fUi41YxFXDdAWDAkdS
	MR9ZR5MTLTQhL5NzX5ZWi8M94ptzjAauogSn+6mgAHZvV3+4plGOj8y/mJOh7yhlXT7D297aQ3n
	reK2vYWROUKyU8iV1cpA4YFt4PdCP9QkLEjXcHz9Lnw+Qd0bDJd0BK4NXjBp6fN0IwjwRvkQxA9
	CoX1PYPf0mBJBSt0OOxNXHRIqoQc8uCg+Zp0IxUXFEBOWSK6f4rAnsmRHbPvwIFZilzSHRaBsj6
	ORwg6aq66l9hJPkSXA+RL+C+O7it22oNX41CUKTSUFTLFOMlaAHMiKkL2hQonBHcFOBBq/L5mr7
	pew4SqXosbJW6l+HOHtQPRe9FTxr85w0XOfDi4G3mQ2rSAo4Xw==
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4ac17e10ac3mr38502525e9.19.1793356126139;
        Fri, 30 Oct 2026 03:28:46 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:45 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 1/6] object-file: check size of inflated loose object against its header
Date: Fri, 30 Oct 2026 11:28:34 +0100
Message-ID: <6c2efb87fbb95d3d24ac8e4ef34b586c2b25980e.1793355390.git.gitter.spiros@gmail.com>
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

unpack_loose_rest() allocates a buffer of the size given in the object
header and inflates the rest of the stream into it, but it never checks
that the stream actually produced that many bytes. If the compressed
data ends early we return success with the tail of the buffer never
written, and callers like odb_read_object() hand it out as object
content. For example, "git cat-file commit" on a loose object whose
header says "commit 200" but which contains only 44 bytes prints 156
bytes of uninitialized heap memory.

The opposite case slips through, too: when the whole object fits into
the buffer filled by unpack_loose_header(), we copy only "size" bytes
out of it, the stream has already ended, and the extra data is silently
dropped.

The packfile reader in unpack_compressed_entry() and index-pack already
compare total_out with the expected size. Do the same here and report
the object as corrupt if they differ. Today fsck notices the first case
only by accident, because it hashes the uninitialized bytes and gets a
mismatch.

Teach loose_obj() in lib-loose.sh to write a bogus size, so that the
tests can create such objects.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 object-file.c                | 15 +++++++++++----
 t/lib-loose.sh               |  5 ++++-
 t/t1060-object-corruption.sh | 28 ++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index c049bf13f7..6d39138511 100644
--- a/object-file.c
+++ b/object-file.c
@@ -212,14 +212,14 @@ void *unpack_loose_rest(git_zstream *stream,
 			void *buffer, unsigned long size,
 			const struct object_id *oid)
 {
-	size_t bytes = strlen(buffer) + 1, n;
+	size_t hdrlen = strlen(buffer) + 1, bytes, n;
 	unsigned char *buf = xmallocz(size);
 	int status = Z_OK;
 
-	n = stream->total_out - bytes;
+	n = stream->total_out - hdrlen;
 	if (n > size)
 		n = size;
-	memcpy(buf, (char *) buffer + bytes, n);
+	memcpy(buf, (char *) buffer + hdrlen, n);
 	bytes = n;
 	if (bytes <= size) {
 		/*
@@ -244,7 +244,14 @@ void *unpack_loose_rest(git_zstream *stream,
 		}
 	}
 
-	if (status != Z_STREAM_END) {
+	/*
+	 * Make sure that the stream produced exactly as many bytes as the
+	 * header claims. Otherwise we would hand back a buffer whose tail
+	 * was never written (if the stream is short), or silently drop data
+	 * (if the stream is long but ended before we noticed).
+	 */
+	if (status != Z_STREAM_END ||
+	    stream->total_out - hdrlen != size) {
 		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
 		FREE_AND_NULL(buf);
 	} else if (stream->avail_in) {
diff --git a/t/lib-loose.sh b/t/lib-loose.sh
index 3613631eaf..807fca6f05 100644
--- a/t/lib-loose.sh
+++ b/t/lib-loose.sh
@@ -5,9 +5,12 @@
 #
 #   oid=$(echo foo | loose_obj .git/objects blob)
 #
+# If $3 is given, it is written as the size in the object header instead
+# of the real size of the contents.
+#
 loose_obj () {
 	cat >tmp_loose.content &&
-	size=$(wc -c <tmp_loose.content) &&
+	size=${3:-$(wc -c <tmp_loose.content)} &&
 	{
 		# Do not quote $size here; we want the shell
 		# to strip whitespace that "wc" adds on some platforms.
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index d2ef468b45..bd3d1adf5d 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -3,6 +3,7 @@
 test_description='see how we handle various forms of corruption'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-loose.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
 obj_to_file() {
@@ -163,4 +164,31 @@ test_expect_success 'corrupted loose commit can be read from alternate' '
 	test_grep "inflate: data stream error" err
 '
 
+test_expect_success 'setup loose objects with bogus header size' '
+	git init bogus-size &&
+	(
+		cd bogus-size &&
+		printf "short" |
+		loose_obj .git/objects commit 200 >../oid-too-big &&
+		printf "much longer" |
+		loose_obj .git/objects commit 3 >../oid-too-small
+	)
+'
+
+test_expect_success 'reading loose object shorter than its header fails' '
+	test_must_fail git -C bogus-size cat-file commit $(cat oid-too-big) 2>err &&
+	test_grep "corrupt loose object" err
+'
+
+test_expect_success 'reading loose object longer than its header fails' '
+	test_must_fail git -C bogus-size cat-file commit $(cat oid-too-small) 2>err &&
+	test_grep "corrupt loose object" err
+'
+
+test_expect_success 'fsck reports loose objects with bogus header size' '
+	test_must_fail git -C bogus-size fsck 2>err &&
+	test_grep "corrupt loose object .$(cat oid-too-big)" err &&
+	test_grep "corrupt loose object .$(cat oid-too-small)" err
+'
+
 test_done
-- 
2.53.0

