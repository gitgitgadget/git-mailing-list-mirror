Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116165;
	b=wDP7UruR5U0DTZkjzZ7BUaKJPN2k4ljBHOMq6WRAlIxgx9jQONemtphTN1dvx1XkPkB2
	 3L5XhUT85w2YjJJtNVMrfkwNL/lVntM7mDgRoBNIHdf2E5Oiwga6b5yp2CMbltNLWM7XA
	 hH94uhnpFMrRNl70RGEFG6NAG92bEyzieRfdMsGg342wLeiYqBP7V59Bs7mEOlen72uCC
	 EXCV3r3L21Vv5M0v+GNaVBsbsv2SD7AhECR4LDQGlertPVsOyoapSNbA+mlnhJyhHWgnU
	 tPnTbsXzicyAZV7yAEGgFEcissWIZoSyLbgBlI5HQrUD4cYzQzqkhgIYWGZAOlv5tBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=q2v53SllHmTARje7vrVZuvOnXhG7TxdpXzf6VZRk9ac=;
	b=VSJUqnMkegTS8kulj/Quvkro/oXYmy1hrYNrnxRxaNhYY7Rrfy/IynMluMeW2BOlP1aP
	 h5IMnKZbnclwNPfv+JuroNYxo6pEeVQW9BZy8ka0bQEv1V21HWilkL0b8dclLdZrQsMZZ
	 +FSPifVo1uN2iPJhmoaxdtNw/FkBt8Z83i+nYy+MarDvK7o0UO6Gzt6GJAPaDa9BxCUWW
	 sk6vi3xhd+o5GMU1zHWMyTbcZC/tkvezo2bP7mJ0dIaHYv2XjqdistHb6VTm+2Bnex7V8
	 osIQotiTQgpEOr6kculmyDhDEKzdItIafEhmfRWvuno9WIY6qR1l10cBp6W390Nszbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U3oYczNq;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584A606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7584A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U3oYczNq
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c505ee61160so15946566b.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116164; x=1795720964; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q2v53SllHmTARje7vrVZuvOnXhG7TxdpXzf6VZRk9ac=;
        b=U3oYczNqWTqcfoKVi8EIT60laiAg8+GZq4nc611rBvwrjQm3ZSp7gJwQr/XBXaogbm
         gnluEwFyEIN5y/q8L9BNhAj5JbjYXPuSM3A4rdsmb/im4RIaPQPa0NBE7bYErZjiuu7+
         X2JbZRogH8iJWGI+vlaIj5OZGWwLaEfXtil9q7bu/GCkLfiuMoZTd3nYLBFomUbYlQna
         M7cQTc8leu4dOFAqqVJc7FhQGOvd+uN8nZBlWtpuxTywC+GpFRUoBbmls8KHUMGQr6qT
         nnfO0+cnrb+Lwr91Q3yLfhOAGIhwOuvwWKF1Q3RNNYquN1DhVkZTzSIJ6Yod+Rcu2lma
         h2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116164; x=1795720964;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2v53SllHmTARje7vrVZuvOnXhG7TxdpXzf6VZRk9ac=;
        b=OHGrP3qXyv1cG/m64Nkp2aNGgBH2ddUMc5+ZQ69ikHnAEc0N3lSFaiuUDEUviLz+2c
         M1LFN90aQoQzW2HNYPvWfEbTzOzj4GhdPQnyCZKR/ANg3npTFr0gWsQpnpzxgpzTwQNw
         4nEaKZ56075jxw4+ILB4jinKtYruPQr+xqYx44AQIVphvT/1cb8kJteWFG3fm7Lgpw1x
         ReJfv3cQcUKzbDDsAE1SR/W/b28MzxkdIpDKuJdBGhcGlQFEUXJiEwKxWWkmHcXVALRE
         9korBCyDzHLs4SlAFLjE0Onp/j3BMkX7TJsa5DTGRyqXDuZ1z9FS7oLjSqZHcqw+Ag3G
         ekKg==
X-Gm-Message-State: APuU4Z/fbMO0uRW7Nn7NWS2FAe37uTAKKaaHddnsDXsLs8D4N89zwcgy
	E0BGBm6qFEgoCwwSICTSK98FN1OHn4ZEi3lvijZ5CVDkJ6O75KY9+/YZmnKlSC7HCoqu2Z61cG1
	6jxVwCd5kXbjG2Rf11vVYklvztug7OwR0mHgbJCsxGS0/UXGUb50t57DbpThBxOf7eL7W12ynx4
	9GBhuskIRQkMoGYiTav3dXyw==
X-Received: from ejbmb2.prod.google.com ([2002:a17:906:eb02:b0:c50:bfa5:2f11])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4792:b0:c50:62ca:6f7
 with SMTP id a640c23a62f3a-c513a858eaamr99398766b.25.1795116163430; Thu, 19
 Nov 2026 11:22:43 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:42 +0100
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
Message-ID: <20261119192242.2669774-1-dmnk@google.com>
Subject: [PATCH] packfile: bound delta header size reads
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Matt Cooper <vtbassmatt@gmail.com>, 
	dmnk+artist@google.com, Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

get_size_from_delta() inflates up to 20 bytes into stack-allocated
delta_head[] and passes delta_head + sizeof(delta_head) to
get_delta_hdr_size() twice, even when Z_STREAM_END stopped after fewer
than 20 bytes. Meanwhile, get_delta_hdr_size() uses a do-while loop that
unconditionally dereferences *data before checking data < top and
returns a partial size when a varint's continuation bit is still set at
top.

On a corrupt local packfile, a delta inflating to fewer than 20 bytes
reads uninitialized stack bytes, and a 20-byte header whose bytes all
have 0x80 set leaves data == top after the base-size read so the second
get_delta_hdr_size() call reads 1 byte past delta_head[20].

Replace get_delta_hdr_size() with decode_delta_hdr_size(), returning -1
on EOF, unterminated varints, or size_t shift overflow so neither
get_size_from_delta() nor patch_delta() treats a truncated varint as a
zero-byte size, and bound top by stream.total_out.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 delta.h                | 31 +++++++++++----
 packfile.c             | 11 ++++--
 patch-delta.c          |  6 +--
 t/t5300-pack-object.sh | 86 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 14 deletions(-)

diff --git a/delta.h b/delta.h
index 42a211905d..9a7c0ad496 100644
--- a/delta.h
+++ b/delta.h
@@ -85,20 +85,35 @@ void *patch_delta(const void *src_buf, size_t src_size,
 /*
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
+ * Returns 0 on success and -1 on truncated or overflowing varints.
  */
-static inline size_t get_delta_hdr_size(const unsigned char **datap,
-					const unsigned char *top)
+static inline int decode_delta_hdr_size(const unsigned char **datap,
+					const unsigned char *top,
+					size_t *sizep)
 {
 	const unsigned char *data = *datap;
 	size_t cmd, size = 0;
-	int i = 0;
-	do {
+	unsigned int i = 0;
+
+	while (data < top) {
 		cmd = *data++;
-		size |= st_left_shift(cmd & 0x7f, i);
-		i += 7;
-	} while (cmd & 0x80 && data < top);
+		if (i >= bitsizeof(size_t)) {
+			if (cmd & 0x7f)
+				return -1;
+		} else {
+			if (unsigned_left_shift_overflows(cmd & 0x7f, i))
+				return -1;
+			size |= (cmd & 0x7f) << i;
+			i += 7;
+		}
+		if (!(cmd & 0x80)) {
+			*datap = data;
+			*sizep = size;
+			return 0;
+		}
+	}
 	*datap = data;
-	return size;
+	return -1;
 }
 
 #endif
diff --git a/packfile.c b/packfile.c
index b32b4cd75d..bb6d0219ac 100644
--- a/packfile.c
+++ b/packfile.c
@@ -890,8 +890,9 @@ size_t get_size_from_delta(struct packed_git *p,
 			   struct pack_window **w_curs,
 			   off_t curpos)
 {
-	const unsigned char *data;
+	const unsigned char *data, *top;
 	unsigned char delta_head[20], *in;
+	size_t size;
 	git_zstream stream;
 	int st;
 
@@ -933,12 +934,16 @@ size_t get_size_from_delta(struct packed_git *p,
 	 * the result size.
 	 */
 	data = delta_head;
+	top = delta_head + stream.total_out;
 
 	/* ignore base size */
-	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	if (decode_delta_hdr_size(&data, top, &size) < 0)
+		return 0;
 
 	/* Read the result size */
-	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	if (decode_delta_hdr_size(&data, top, &size) < 0)
+		return 0;
+	return size;
 }
 
 int unpack_object_header(struct packed_git *p,
diff --git a/patch-delta.c b/patch-delta.c
index 42199fa956..3e29e81f4e 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -27,12 +27,12 @@ void *patch_delta(const void *src_buf, size_t src_size,
 	top = (const unsigned char *) delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	size = get_delta_hdr_size(&data, top);
-	if (size != src_size)
+	if (decode_delta_hdr_size(&data, top, &size) < 0 || size != src_size)
 		return NULL;
 
 	/* now the result size */
-	size = get_delta_hdr_size(&data, top);
+	if (decode_delta_hdr_size(&data, top, &size) < 0)
+		return NULL;
 	dst_buf = xmallocz(size);
 
 	out = dst_buf;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index e5ce478484..972671abfc 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -766,4 +766,90 @@ test_expect_success '--path-walk thin pack' '
 	git -C server index-pack --fix-thin --stdin <out.pack
 '
 
+test_expect_success 'delta header decoding rejects truncated and unterminated varints' '
+	test_when_finished "rm -rf delta-bounds" &&
+	git init delta-bounds &&
+	(
+		cd delta-bounds &&
+		printf "hello" >delta_base &&
+		printf "\005\201\200\200" >corrupt_delta &&
+		test_must_fail test-tool delta -p delta_base corrupt_delta delta_out &&
+		: >empty_base &&
+		printf "\200\200\200\200" >corrupt_empty_delta &&
+		test_must_fail test-tool delta -p empty_base corrupt_empty_delta delta_out &&
+
+		test-tool genrandom base 4096 >base &&
+		cat base >file &&
+		test-tool genrandom oldtail 512 >>file &&
+		git add file &&
+		git commit -m base &&
+		cat base >file &&
+		test-tool genrandom newtail 1024 >>file &&
+		git add file &&
+		git commit -m delta &&
+		git -c pack.writeReverseIndex=false repack -ad --window=10 --depth=10 &&
+		idx=$(ls .git/objects/pack/pack-*.idx) &&
+		pack=${idx%.idx}.pack &&
+		chmod +w "$pack" "$idx" &&
+		cp "$pack" "$pack.orig" &&
+		cp "$idx" "$idx.orig" &&
+		delta_line=$(git verify-pack -v "$idx" | awk '\''NF >= 7 && $2 == "blob" { print $1, $5; exit }'\'') &&
+		delta_oid=${delta_line% *} &&
+		offset=${delta_line#* } &&
+		test -n "$delta_oid" &&
+		test -n "$offset" &&
+		algo=$(git rev-parse --show-object-format) &&
+
+		for mode in unterm oob trunc
+		do
+			cp "$pack.orig" "$pack" &&
+			cp "$idx.orig" "$idx" &&
+			chmod +w "$pack" "$idx" &&
+			"$PERL_PATH" -MCompress::Zlib=compress -MDigest::SHA=sha1,sha256 -e '\''
+				my ($pfile, $ifile, $off, $algo, $mode) = @ARGV;
+				my $hsz = ($algo eq "sha256") ? 32 : 20;
+				my $hash = ($algo eq "sha256") ? \&sha256 : \&sha1;
+				local $/;
+
+				open my $pfh, "+<:raw", $pfile or die $!;
+				my $pdata = <$pfh>;
+				my $p = $off;
+				my $c = ord(substr($pdata, $p++, 1));
+				my $type = ($c >> 4) & 7;
+				while ($c & 0x80) { $c = ord(substr($pdata, $p++, 1)); }
+				if ($type == 6) {
+					$c = ord(substr($pdata, $p++, 1));
+					while ($c & 0x80) { $c = ord(substr($pdata, $p++, 1)); }
+				} elsif ($type == 7) {
+					$p += $hsz;
+				} else {
+					die "expected delta object, got type $type";
+				}
+				my $raw = ($mode eq "unterm") ?
+					pack("C*", 0x81, (0x80) x 8, 0x00, 0xaa, (0x80) x 9) :
+					($mode eq "oob") ?
+					pack("C*", (0x80) x 20) :
+					pack("C*", 0x05);
+				my $z = compress($raw);
+				die "compressed stream too large" if $p + length($z) > length($pdata) - $hsz;
+				substr($pdata, $p, length($z)) = $z;
+				my $psum = $hash->(substr($pdata, 0, -$hsz));
+				substr($pdata, -$hsz, $hsz) = $psum;
+				seek $pfh, 0, 0 or die $!;
+				print $pfh $pdata or die $!;
+				close $pfh or die $!;
+
+				open my $ifh, "+<:raw", $ifile or die $!;
+				my $idata = <$ifh>;
+				substr($idata, -2 * $hsz, $hsz) = $psum;
+				substr($idata, -$hsz, $hsz) = $hash->(substr($idata, 0, -$hsz));
+				seek $ifh, 0, 0 or die $!;
+				print $ifh $idata or die $!;
+				close $ifh or die $!;
+			'\'' "$pack" "$idx" "$offset" "$algo" "$mode" &&
+			test_must_fail git cat-file -s "$delta_oid" || return 1
+		done
+	)
+'
+
 test_done
-- 
2.56.1.750.gf70dc682cf-goog

