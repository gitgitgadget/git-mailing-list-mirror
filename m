Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069327;
	b=gmo03IBKRJz/lHkbPHx+K/t3+YTeTDDMsDbClxk4VBH0Mf5aEpdk68ei4NWetbT9DUCa
	 l+aHyv+4FRZZkZ4uuEg/vMOwpOwdHpq5WlUx5glJzVaUAG5P61d5Wm/c04iZmpGQzo7eH
	 axls4z5TtSnVGxLeSXNtulh+H8Ybjpxset15sx6Gc9qhibCChBu2oA1mswrTJsHic4qOr
	 jAIbsyFAAQNoaonMrC1OBZ1wgW2scBtdfHkthKxfv3v7BhU9Z1W4KPF7ZsLfDFMxYnwSG
	 aZ7TK62/gkjwLAUBxeJwOvbBmlK5jal9CzMQi/DwfA7DJ6i4RVEzMkVqL3Q8Pg6Dawg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+JOP0dp53sXhTk01VHzvFtyI9YtrOaFDw4js3lbVLPI=;
	b=wCwDgvMV43s2XD5TpHV/ZKZwsh3XeniUHvU2pG4QxEpPZx8dRT3uUCkijcAFqA4o1Xii
	 Ys/TslqyfqDUD953fLJl7BKlBDvQf3Hr3qzxIIr6oAl40oXCTuLIDFu6ppv3hjCb1T6Ds
	 6Kb4gzeEGz0WnDozz5RdrBOBfh9e/+1fBrvLUzQ22gfyHeci5Nbt7eQGyVUBO890jj/rw
	 ac7Yn/RU5F5DKhUclskgswFGL7zUFXCDr1kaHrUNy9tV1JDeA+yvr6gkwwx6yhJmcA4Lp
	 oiSQHldiKM86651kOK9k4nPBRnoZoUbV32v0MZ3pfgWH3NxYz+T74mlxwWWi0BP9CCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylD3HFY6;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF3606A334
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CF3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylD3HFY6
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso841860f8f.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069326; x=1795674126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JOP0dp53sXhTk01VHzvFtyI9YtrOaFDw4js3lbVLPI=;
        b=ylD3HFY6OmtHICcow+p84Ht9AP2eZDEhlcsNlID4mhZZjNzZPX4W+ZrWowZYn9QmzY
         GX+Ns+fylG4suHylwsHp3DNIM+IP+8pWUMsTSVZoKKJmUpGcF5kYNsKR/Ktdg0fbd4m5
         CJe1H7y8gDYmrDW0FkCA+RM+nhhQCC3JS9uGqRsLBEOpa+/RZhQ70YWeCQ26eMIISKC8
         5nA6MV7JLBk/1D736D4zuhKtE5QCFKJNc9KT6ikpNlDWc7qHx5InHzmEIqYr6VZnyLen
         1PK3g5nscU//nwyBXiynuUjXd43KHKiN1DxD5f7fNuh4w3i9C3VImIGpVvnFA2NKT+sT
         BFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069326; x=1795674126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JOP0dp53sXhTk01VHzvFtyI9YtrOaFDw4js3lbVLPI=;
        b=smO86nwzH5wgCHvgjpcJPFDBdzr0nc+sdn5c8O6YrGsXjohT5TIn3S2VVmiBNsdBG4
         wDCDMV7PABtrEaQjNf188hQj0u+lZ7D1jDvnJhRcHzzPxgPUh4qHI9NMlj8G/Ffuo34O
         8xarJbIITbgZb/lkQbD2zQDMSZZwbsKPK6bQImQqPUPgmI5gx0NVHjBgUM8LaKBcvT2P
         hoXKdyOza//Bfve+cZCg3HwEQy64IKTInBmQYB7DYUwFhQ8j0ckujdGmzOtStRktcGfi
         r+jjf2zIfcEtGkkIzzaxztKBQdpYkXOThheThFrnGOXqwpmIuMnkNWIKeWQf3133jPXc
         AgNA==
X-Gm-Message-State: APuU4Z+EaolDOVaw2G5dAgJ5eY2pB29UR76WZcdjyoISGT/350eoWSW2
	6BXVnEj9A5wP+4shyu85KaNjYDshxlfdu8wR/TznxDCzxOILPf+RiBkpqRgFuA==
X-Gm-Gg: AZFdTZdfjKilNtAcpLb5HBkzZD3hFSLkFA9tYFXNAxPNsipPuEAe7hjhWmvr71tkhT3
	qSlDvzS3Cc01hZVQckQcNDgqh9o1X3iExxpYa0GM0gVQfhf97dksIDSXUqVDazQ7YDs+A/ahOWA
	5Aj/sHMO5178MrFESCSNhxPaMrpOFWDxcMvYvYt07Kberz4ZfVg4/uyI6XF9Dx7wEn9cMXxdP6W
	Snglwn+hyuEN0qeZNwcDDeuwWb7gVamipidxt0zKneLGaiL6h0MFqi3yyWmf898lwkjam7PXSen
	KqCEgfBYi58QpNc7ZMrbYX5Gn7qh4aEOjJux6nYxtzNwQwwcV/vpdIw3NJIsKgRkzU4URJO5Olr
	sxcmMD7AQZEc307YrzXPrm5z13DRvCdydgXKWo53BsgkQY5UnAgc0kr/36ZQE7m50I7nZRwgDdK
	DYb6FFQxipZIB9rXvPgbBwU++Wguqv4xWDuinLnIvupstI/TrMjU6ISkf+Z6QpwyIvsLtn+B6X8
	sGnOX3Lu18GNB2j02JzfIxsQU1dIt2V9/RIu6beQBWuBuAHxsfh1jNUp+JrIDrN5nr/iKjDOhgF
	GkdSr/CqFXzuYZqNU0FGE80TRfTw4bfBw9vYqq0iO0Ae6N669XU250hQFXoqmeo=
X-Received: by 2002:a05:6000:65c:b0:48d:fd4b:cdd6 with SMTP id ffacd0b85a97d-4a63a5b51efmr9549911f8f.25.1795069325686;
        Wed, 18 Nov 2026 22:22:05 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm8508413f8f.14.2026.11.18.22.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:22:04 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/5] object-file: check size of inflated loose object against its header
Date: Thu, 19 Nov 2026 07:21:46 +0100
Message-ID: <0d748dbd8e4a28f124c5419180638e1f26943d11.1795069177.git.gitter.spiros@gmail.com>
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

unpack_loose_rest() allocates a buffer of the size given in the object
header, but never checks that the stream produced that many bytes:

 - If the stream is shorter, the unwritten tail of the buffer is handed
   out as object content: "git cat-file commit" on an object whose
   header says "commit 200" but which holds 44 bytes prints 156 bytes
   of uninitialized heap memory.

 - If the whole object fits into the MAX_HEADER_LEN bytes that
   unpack_loose_header() already inflated, the stream has ended before
   we get here; we copy only "size" bytes out of that buffer and
   silently drop the rest.

Compare total_out with the expected size, as unpack_compressed_entry()
and index-pack already do, and say how many bytes we got when they
differ.

Teach loose_obj() in t/lib-loose.sh to write a bogus size, so that the
tests can create such objects.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 object-file.c                | 17 ++++++++++++++---
 t/lib-loose.sh               |  5 ++++-
 t/t1060-object-corruption.sh | 28 ++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index e04ce0bc11..d7057182ff 100644
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
@@ -247,6 +247,17 @@ void *unpack_loose_rest(git_zstream *stream,
 	if (status != Z_STREAM_END) {
 		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
 		FREE_AND_NULL(buf);
+	} else if (stream->total_out != hdrlen + size) {
+		/*
+		 * A short stream would leave the tail of buf[] unwritten;
+		 * a long one can end inside the header buffer, so that
+		 * only "size" bytes were copied and the rest dropped.
+		 */
+		error(_("loose object '%s' has %"PRIuMAX" bytes, "
+			"but its header says %"PRIuMAX),
+		      oid_to_hex(oid), (uintmax_t)(stream->total_out - hdrlen),
+		      (uintmax_t)size);
+		FREE_AND_NULL(buf);
 	} else if (stream->avail_in) {
 		error(_("garbage at end of loose object '%s'"),
 		      oid_to_hex(oid));
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
index d2ef468b45..e8624e70ca 100755
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
+	test_grep "has 5 bytes, but its header says 200" err
+'
+
+test_expect_success 'reading loose object longer than its header fails' '
+	test_must_fail git -C bogus-size cat-file commit $(cat oid-too-small) 2>err &&
+	test_grep "has 11 bytes, but its header says 3" err
+'
+
+test_expect_success 'fsck reports loose objects with bogus header size' '
+	test_must_fail git -C bogus-size fsck 2>err &&
+	test_grep "loose object .$(cat oid-too-big). has 5 bytes" err &&
+	test_grep "loose object .$(cat oid-too-small). has 11 bytes" err
+'
+
 test_done
-- 
2.53.0

