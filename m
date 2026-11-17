Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915549;
	b=STbGOD1BAW+IpgN9klwkgAaf5eUtFFQPjfxbuNu6y+wThsHTqipG4yedTNM9cLaxk+II
	 Oivficu3VweNjmBl7ffYW7U6KRqyCnRSmBbrnFIIXqfDRowWZ58OXZpx8FMgqv/qSo+WJ
	 jxljYU5hDYBjTRXTnZwlMc+4siwP6izxaZ2BS7jd+PrOcaRWcfdUD1aoW65oY8Ho9diwN
	 nIS1bi2sjLff4wWpr3gnIJrznd+Su0VyO6s6BaE9XT9XOCsh6f4QWDXlsUpg+DkT99UUZ
	 X5hYLi6Z1IeKl3YiWbbMXFurP/k3dyKj9+8+JRfLm9Djq98i8xoSL2NegllcxUU7euw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iuGBUCmyzh9YkT9pFfoI7u10VW9CKEwghhVYPcXfQKA=;
	b=F+6IdHLE6NxeLlB4m4YKfDCK/9jqcQQc7CUW+3f6J3x9IlNNEaEwu/VJiGzzAVaC/rgJ
	 EIrXFNHudZWxoPHqZ9eZp1E7oaDu0PLYuLAnwRhO9elqJlfEqDSgeM/6oq7RB+iMjOa/F
	 GNpKg15j024EiFptx9gi02G5DN4aeh6KdVBBWU5uI4qreQpUJ3DktexC/hqZDi1QCWqRW
	 LMgiry+NBBWyhhYYuGNiYD2i++rnVKKxTIDQV4eTLNk+V5HpywuFSygkrqzeu7KKy6bI6
	 dMxeMWUtXowLAmv61tkdsg39ucfAUr0jb6X0aFUZTJnUHGG6ychW17HRXM6UPgZa4Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDOREiiz;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07D606A881
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB07D606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDOREiiz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso46706375e9.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794915547; x=1795520347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iuGBUCmyzh9YkT9pFfoI7u10VW9CKEwghhVYPcXfQKA=;
        b=JDOREiizFgXwtIKWkaMFNvu/GBB58zGJnxB+vRd6sj93ZciyRSGjB1ny1MbzhkDiOF
         3tII5z5Xt6CqNzfkyfMLn5/DIJEvYtgY3/nZpYdAyUglo05XhpO65LfktYO5am4xjvF0
         2RImuLL40Dd+hk9atPsSiG8mhiZsivC3Wc4gL82b3xRxG3jYTfJBMnR7Gxhzmqlnh8OF
         mJJH8n/wy82/Riawxa9r+fLZi1YlfRB5Ca/7hHQKy9km/4wepYBnel0aXCPz+mBcvgV6
         19Up2yZ6RBUvvmPtnYH44MoUTQjskZW0XwWtADWATnDwPxVFcvHBSduDkP36NP8Zw6GU
         0OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915547; x=1795520347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iuGBUCmyzh9YkT9pFfoI7u10VW9CKEwghhVYPcXfQKA=;
        b=o9iwzeNlR+7lr/l47DXnyMSY3vQEcdJSTa3O3vIg3Rcut8hd+RS03yciD9ThoD9KDS
         lc+6bxailmLuP58FtaD8Dk7x/oxAQHmbGzs4y9k+dTm3g4hn0DCBuG0BrZZJKCSgnbwx
         hynhkUb3gGfZ65myYyxeWaEIRsWtSxsZ/nOqdb74j0sKkAdDilP7fr7jvqBGS5m4F3k2
         M1XL/fOoFETwXP3C01EFgtENJ/g4WKPjahGmugyIGVGtDzS8T/6zxzxLCpyydbWEXUsw
         SAw2QPewSZLwFK4JIYv8pBUQrPEgAq8ckPR1rjepiuPK41/RjyNO8sF7MPfjpsYCx6TU
         n+QQ==
X-Gm-Message-State: APuU4Z/rK0NlxF6Mi00j9KF1YrfhCTyCguSOyLJmg7WCkKfo7XoOtHTw
	+vgMZ+1LC8hKV2HrGzwiUXJrSo3uuxtcITHn76MwMjTVc5Yh/6jMO+XY3yKQ8A==
X-Gm-Gg: AYBFou0476m16ZMfBDzg2lKn9OUTEzyXj+Tx5lb1B/Lii8apiesvANqx0usTiuYIv0b
	SEOcGV4Iy+fqYbxmZe4SZF4L3c8NIYN+MkmcPjUn3nf+vedugepU4k79hjXJLMAzIsQnEfdQdvz
	7pg7co8sEXd+TKudWAJAwDVXcznfeswpz7CINCHck+UDHNJ+m513FW8lBIZ69kJU5fN46nSLOyB
	FxK6WanMAtnm8iE79Q5kSrvYHLWF5qpdHfDl+MjNby67ZKJmLGoQtRHl+2KTvSvQb+hHFiv6J65
	CiBL7aFeTzlI3JLTpSQu2w6cCtektFsC6BA9Zb/i5rzLqbAZYuKOneBdvbu6aK6efmWK7IaQ5Gf
	9MTle71c4LMD7SPr6Fm3cg5KFrR6I/Bhl8TNp8IwrKVDxlKc1pDKa/CMGmfRJlvm9itxE/erFK2
	zbNpgFM6GnJ2h5UCvAo3LERdPXoVJpgfae+nyeJ5EOUfvumgwbRzf4GY2WadArQsezkk6p2yJ/p
	jVTbhY6UF3T6DPn8Ym0cwA+D77gIoVyb6taeUntEsT6d3tRkwqIiLn6J4bDGx7X9fpmeX03Yi+C
	aXtTDoD+AnPZaFzdAtVfeQHY0sonk9u9gttkmiIDl/PlZWhmIoYUZLuUGhdMMZk+Er+0oeEEZXK
	fOhBGjhB9
X-Received: by 2002:a05:600c:19d2:b0:4bb:60bd:53b2 with SMTP id 5b1f17b1804b1-4bb60bd55eamr234484985e9.6.1794915547124;
        Tue, 17 Nov 2026 03:39:07 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm93555925e9.9.2026.11.17.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:39:06 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] object-file: check size of inflated loose object against its header
Date: Tue, 17 Nov 2026 12:38:54 +0100
Message-ID: <edb5f34498e91beb0480d9b6ac417602580b3016.1794914210.git.gitter.spiros@gmail.com>
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
index e04ce0bc11..5d03ae94c7 100644
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

