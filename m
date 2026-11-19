Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116160;
	b=n2N3om/1Qr5wbZQNLX1/zMH2QN1GiyKOtwEkNW9AmXk5z9qLHcuEBlktmrtEl/wlKAk2
	 UiT/xzwcNKTJ6cQc2UkpEncz/Mnc8POrUevIDOelLba642PL/ZCPY4sY1FDP3XE9QQuTd
	 11eKjLQe6NZTDYIrULPpCBz5Lbsd6GgtNtnQAEyzw+Xk8hE08IuFeSTERO66XFt5aL6hJ
	 2qgB57jhfUniJE5fXmB56aZKrMFrKHbbLKKI9puQ1QtakE3zS2s0qODfgPheFcYByD8sA
	 5r0ZqeVZ1IkxXB/msT3ZBdATSXeQuKRu/kdbD5o49J1NkHV4qT1tsrJvq0ZMrGUMChw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=xfwHsZ02Id7r+S/HT3ZM2XnSEQqvoTh+iFcAFN9S9gM=;
	b=ghu/zrmhoDP3o0zvUXZN3b8H4KTzkArvOhY9RDI00ueFXshuqtMEKe8J422FrIcfjj2i
	 w/q8jWi9F+Hl2dPgPraw1NhMNb9bCDs4GF7rnGxloVJTMEUOt3TYBgBCIWPIckzF0d5Tk
	 twZ1J004SfRl/Kd0EFHgkM7g+7HGc7bPETBTaVU8257MFCAuj04L1+ALwA/OWv4CWxdAH
	 6HmFrjQEhTCxkQAQKqJVchILKOXc9TKdeGL/6hUI+WTzb5Dg6obrMdxyzvzmZmIAgPK8a
	 4J6iFsBTrrJcD6XcS/AvRwvigLUBYkyjzuoQVd0aHcsTQ05mAFs0QgzyLguCpeay9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BMZiF/9F";
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B7606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377B7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BMZiF/9F
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso14790f8f.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116159; x=1795720959; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xfwHsZ02Id7r+S/HT3ZM2XnSEQqvoTh+iFcAFN9S9gM=;
        b=BMZiF/9F/mr04ZIxwGoOPBP6apy/xxNHIdSWq3QAeJ/5eh4vt/4aWISHmeZhMYSf2E
         fvTlTOdP40jdwz/QaGszJHaF1WTHQo517usdIZfrcfDWvijqrrLevmAB4TcoFirXg+Aa
         ldQ8emhqt50H/VQaOzgXr9qSNxDpiM7v3IbeoxwUidzBiU2B/dMFNsmYPn+ymxdXiDUV
         ODDB/ocmwhHhg9z/R2e582XRcaUw4qp4Rplko/lENycxyTVfQbxL/xncLzWiFQKQUEnl
         dm3g1eY6Y3RGSZCi3bBsGKRVl3fJuctgoOpX46Qi4JtOpO2vxxZvrYop5VfEvEUlDBnA
         ftDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116159; x=1795720959;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xfwHsZ02Id7r+S/HT3ZM2XnSEQqvoTh+iFcAFN9S9gM=;
        b=djYNc/4KSepwSUEMjAIMP/pAg6goRTgSLJP2PB4fFcIJAvZTbY9ngan+gAUizq2Chf
         zMSZvMoLo5diVVeonKOXtTUDms38L9v2TT6gke2HKcXupWgc5hmvX8DS/maiE8+Y6aQn
         UEiE/tOy6aHOA5u0kKXrBl53K912Y9bbqMMlxhRVWmaCFyl9Jfyyqnsn3qqfJA9bGFxB
         wkGA6kR6W8xoUouNHT5IZGjUXG3eS7czEt23zse9x+A+VVUsIdH45qKKjbaIAGtdWQv/
         OL3kXDQwC4XuVTHPwjLgRp/1OzPOcZ8M1FpkuQtcXqxzx/T8+FprLXN/O5vd/nXOiMeF
         1yUA==
X-Gm-Message-State: APuU4Z/J2bypUEW5QinsCo6YJGgxNTlQngU8V5yvkI/3PoKPKgCKA/In
	F4n3BZEirRH1IkHxEjsW5Tlmsho3fNj8z54uxL8PTiRCdW4aUpmIwJHTZ4JM6rwbU01/FqWOP+y
	2J7inu25KWjbS5/AFcLdt16LDGXgDmckbgcYYzmAKKnM993yz/2YMQRx6qH0ven5U0QST8cRB5J
	2JpJLbd4EiB9CDVDzs75gzPw==
X-Received: from wmdn7.prod.google.com ([2002:a05:600c:2947:b0:4a2:8ef:a5af])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6749:b0:4a2:d99:3171
 with SMTP id 5b1f17b1804b1-4bb8881b52dmr11213525e9.23.1795116158504; Thu, 19
 Nov 2026 11:22:38 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:37 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192237.2666510-1-dmnk@google.com>
Subject: [PATCH] ewah: validate rlw bounds in ewah_read_mmap
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, 
	Lidong Yan <502024330056@smail.nju.edu.cn>, 
	Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

ewah_read_mmap() trusts the serialized word count, RLW offset, and
per-header literal word counts after reading a bitmap from disk. A
corrupt .bitmap file with buffer_size == 0, an oversized buffer_size,
an rlw offset past buffer_size, or a running-length header whose
literal_words exceeds the remaining words in self->buffer causes memory
leaks, huge pre-check reallocations, or out-of-bounds heap reads in
ewah_each_bit(), rlwit_init(), next_word(), and rlwit_discharge().

Validate non-zero buffer_size and available mmap length before mutating
self or growing self->buffer, verify that every RLW header's literal
word count fits within self->buffer_size and that the serialized rlw
offset points to the final RLW header, and clamp next_word() /
rlwit_init() against the buffer size as defense in depth.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 ewah/ewah_io.c          |  43 +++++++++++++----
 ewah/ewah_rlw.c         |  17 +++++--
 t/t5310-pack-bitmaps.sh | 103 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 13 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index da005523b0..551aec22d3 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -21,6 +21,7 @@
 
 #include "git-compat-util.h"
 #include "ewok.h"
+#include "ewok_rlw.h"
 #include "strbuf.h"
 
 int ewah_serialize_to(struct ewah_bitmap *self,
@@ -93,21 +94,32 @@ ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 {
 	const uint8_t *ptr = map;
 	size_t data_len;
-	size_t i;
+	size_t i, pos, last_rlw = 0;
+	uint32_t bit_size, buffer_size, rlw_offset;
 
 	if (len < sizeof(uint32_t))
 		return error("corrupt ewah bitmap: eof before bit size");
-	self->bit_size = get_be32(ptr);
+	bit_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
 	len -= sizeof(uint32_t);
 
 	if (len < sizeof(uint32_t))
 		return error("corrupt ewah bitmap: eof before length");
-	self->buffer_size = self->alloc_size = get_be32(ptr);
+	buffer_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
 	len -= sizeof(uint32_t);
 
-	REALLOC_ARRAY(self->buffer, self->alloc_size);
+	if (!buffer_size)
+		return error("corrupt ewah bitmap: empty buffer");
+
+	if (buffer_size > len / sizeof(eword_t))
+		return error("corrupt ewah bitmap: eof in data "
+			     "(%"PRIuMAX" bytes short)",
+			     (uintmax_t)buffer_size * sizeof(eword_t) - len);
+
+	self->bit_size = bit_size;
+	self->buffer_size = buffer_size;
+	ALLOC_GROW(self->buffer, self->buffer_size, self->alloc_size);
 
 	/*
 	 * Copy the raw data for the bitmap as a whole chunk;
@@ -115,11 +127,7 @@ ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 	 * the endianness conversion in a separate pass to ensure
 	 * we're loading 8-byte aligned words.
 	 */
-	data_len = st_mult(self->buffer_size, sizeof(eword_t));
-	if (len < data_len)
-		return error("corrupt ewah bitmap: eof in data "
-			     "(%"PRIuMAX" bytes short)",
-			     (uintmax_t)(data_len - len));
+	data_len = (size_t)buffer_size * sizeof(eword_t);
 	memcpy(self->buffer, ptr, data_len);
 	ptr += data_len;
 	len -= data_len;
@@ -129,9 +137,24 @@ ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 
 	if (len < sizeof(uint32_t))
 		return error("corrupt ewah bitmap: eof before rlw");
-	self->rlw = self->buffer + get_be32(ptr);
+	rlw_offset = get_be32(ptr);
 	ptr += sizeof(uint32_t);
 	len -= sizeof(uint32_t);
 
+	if (rlw_offset >= self->buffer_size)
+		return error("corrupt ewah bitmap: rlw offset out of bounds");
+
+	for (pos = 0; pos < self->buffer_size; ) {
+		eword_t literal_words = rlw_get_literal_words(&self->buffer[pos]);
+		last_rlw = pos;
+		if (literal_words > self->buffer_size - 1 - pos)
+			return error("corrupt ewah bitmap: literal words out of bounds");
+		pos += 1 + (size_t)literal_words;
+	}
+	if (rlw_offset != last_rlw)
+		return error("corrupt ewah bitmap: invalid rlw offset");
+
+	self->rlw = self->buffer + rlw_offset;
+
 	return ptr - (const uint8_t *)map;
 }
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
index 76b4c6c19e..9db47ab6f7 100644
--- a/ewah/ewah_rlw.c
+++ b/ewah/ewah_rlw.c
@@ -25,13 +25,20 @@
 
 static inline int next_word(struct rlw_iterator *it)
 {
+	size_t avail;
+	eword_t literal_words;
+
 	if (it->pointer >= it->size)
 		return 0;
 
+	avail = it->size - it->pointer - 1;
 	it->rlw.word = &it->buffer[it->pointer];
-	it->pointer += rlw_get_literal_words(it->rlw.word) + 1;
+	literal_words = rlw_get_literal_words(it->rlw.word);
+	if (literal_words > avail)
+		literal_words = avail;
+	it->pointer += (size_t)literal_words + 1;
 
-	it->rlw.literal_words = rlw_get_literal_words(it->rlw.word);
+	it->rlw.literal_words = literal_words;
 	it->rlw.running_len = rlw_get_running_len(it->rlw.word);
 	it->rlw.running_bit = rlw_get_run_bit(it->rlw.word);
 	it->rlw.literal_word_offset = 0;
@@ -45,7 +52,11 @@ void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *from_ewah)
 	it->size = from_ewah->buffer_size;
 	it->pointer = 0;
 
-	next_word(it);
+	if (!next_word(it)) {
+		memset(&it->rlw, 0, sizeof(it->rlw));
+		it->literal_word_start = 0;
+		return;
+	}
 
 	it->literal_word_start = rlwit_literal_words(it) +
 		it->rlw.literal_word_offset;
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index b75a35707c..7679166c37 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -566,6 +566,109 @@ test_bitmap_cases () {
 		    test_cmp expect actual
 		)
 	'
+
+	test_expect_success 'reject ewah bitmap with invalid buffer_size, rlw, or literal words' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			test_commit base &&
+			git repack -adb &&
+			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
+			chmod +w "$bitmap" &&
+			cp "$bitmap" "$bitmap.orig" &&
+			algo=$(test_oid algo) &&
+
+			# Corrupt the first type bitmap buffer_size to 0
+			"$PERL_PATH" -MDigest::SHA=sha1,sha256 -e '\''
+				my ($file, $algo) = @ARGV;
+				open my $fh, "+<:raw", $file or die $!;
+				local $/;
+				my $data = <$fh>;
+				my $hsz = ($algo eq "sha256") ? 32 : 20;
+				my $off = 12 + $hsz;
+				substr($data, $off + 4, 4) = pack("N", 0);
+				my $sum = ($algo eq "sha256") ?
+					sha256(substr($data, 0, -$hsz)) :
+					sha1(substr($data, 0, -$hsz));
+				substr($data, -$hsz, $hsz) = $sum;
+				seek $fh, 0, 0 or die $!;
+				print $fh $data or die $!;
+				close $fh or die $!;
+			'\'' "$bitmap" "$algo" &&
+			test_must_fail git rev-list --test-bitmap HEAD 2>err &&
+			test_grep "corrupt ewah bitmap: empty buffer" err &&
+
+			# Corrupt the first type bitmap buffer_size to 0xffffffff
+			cp "$bitmap.orig" "$bitmap" &&
+			chmod +w "$bitmap" &&
+			"$PERL_PATH" -MDigest::SHA=sha1,sha256 -e '\''
+				my ($file, $algo) = @ARGV;
+				open my $fh, "+<:raw", $file or die $!;
+				local $/;
+				my $data = <$fh>;
+				my $hsz = ($algo eq "sha256") ? 32 : 20;
+				my $off = 12 + $hsz;
+				substr($data, $off + 4, 4) = pack("N", 0xffffffff);
+				my $sum = ($algo eq "sha256") ?
+					sha256(substr($data, 0, -$hsz)) :
+					sha1(substr($data, 0, -$hsz));
+				substr($data, -$hsz, $hsz) = $sum;
+				seek $fh, 0, 0 or die $!;
+				print $fh $data or die $!;
+				close $fh or die $!;
+			'\'' "$bitmap" "$algo" &&
+			test_must_fail git rev-list --test-bitmap HEAD 2>err &&
+			test_grep "corrupt ewah bitmap: eof in data" err &&
+
+			# Corrupt the first type bitmap rlw offset past buffer_size
+			cp "$bitmap.orig" "$bitmap" &&
+			chmod +w "$bitmap" &&
+			"$PERL_PATH" -MDigest::SHA=sha1,sha256 -e '\''
+				my ($file, $algo) = @ARGV;
+				open my $fh, "+<:raw", $file or die $!;
+				local $/;
+				my $data = <$fh>;
+				my $hsz = ($algo eq "sha256") ? 32 : 20;
+				my $off = 12 + $hsz;
+				my $words = unpack("N", substr($data, $off + 4, 4));
+				substr($data, $off + 8 + $words * 8, 4) = pack("N", $words + 64);
+				my $sum = ($algo eq "sha256") ?
+					sha256(substr($data, 0, -$hsz)) :
+					sha1(substr($data, 0, -$hsz));
+				substr($data, -$hsz, $hsz) = $sum;
+				seek $fh, 0, 0 or die $!;
+				print $fh $data or die $!;
+				close $fh or die $!;
+			'\'' "$bitmap" "$algo" &&
+			test_must_fail git rev-list --test-bitmap HEAD 2>err &&
+			test_grep "corrupt ewah bitmap" err &&
+
+			# Corrupt the first RLW header literal_words count past buffer_size
+			cp "$bitmap.orig" "$bitmap" &&
+			chmod +w "$bitmap" &&
+			"$PERL_PATH" -MDigest::SHA=sha1,sha256 -e '\''
+				my ($file, $algo) = @ARGV;
+				open my $fh, "+<:raw", $file or die $!;
+				local $/;
+				my $data = <$fh>;
+				my $hsz = ($algo eq "sha256") ? 32 : 20;
+				my $off = 12 + $hsz;
+				substr($data, $off + 8, 8) = pack("NN", 0x00001000, 0x00000000);
+				my $sum = ($algo eq "sha256") ?
+					sha256(substr($data, 0, -$hsz)) :
+					sha1(substr($data, 0, -$hsz));
+				substr($data, -$hsz, $hsz) = $sum;
+				seek $fh, 0, 0 or die $!;
+				print $fh $data or die $!;
+				close $fh or die $!;
+			'\'' "$bitmap" "$algo" &&
+			test_must_fail git rev-list --test-bitmap HEAD 2>err &&
+			test_grep "corrupt ewah bitmap" err
+		)
+	'
 }
 
 test_bitmap_cases
-- 
2.56.1.750.gf70dc682cf-goog

