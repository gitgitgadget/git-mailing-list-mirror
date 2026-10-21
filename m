Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564403;
	b=ptiFtEToRIcTTJgh40+QRnJAUVG6XwZFqEvFPyutTcKhYZHbIF2RypcL/SjHkk75RGiX
	 HWOleaXS4GlkccJeuFsNrxCUy/YIPxE+C8pne90vtZP1waGs1gnYDMisqMHKRbJEiBBbm
	 ljNl5BAZSrVUvVaXKazsDpvz97H06gNr/WsB0Gd183Xdd6Ha6Ez+nX9x5n9H7JqsqzdDF
	 znbIyMfqavEmtcvkmbbdB2iKfyfYjFvUv9qjXl5WvIyM/86ljLoCb+R8ZhLlmLQvEptmj
	 Xd4cJ+CWHQvioJA545dM/TqqwXdkP35/rFgNBIOSvn2Ad/+LnLjOJYuxJcEjA1PFvgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tVQya4zBBvRCPfkBD4JKIVbm04JtEbk7i/yiZVqyOOs=;
	b=wPZlCq75q7HQcyuIJKIKm1WO9HL+nk1/x2u5HwzxZ+mgR3CMkptU6KmqnMZFcjHnifEH
	 VG3q26uvLdXXjMHsBFXMGwc5x1mseYM31esIEMtpLXGOe1hn5DQ5wdf1j8vax12qrW+Oe
	 1lb/UkkrgapEi9ZvWxmIc0l3JuBKuBtD/CehkXTHkIYZpeM9aq9tpCTEj4KLgMyVt5gwc
	 dOfWVcZ9xSLybtcx0UyCa44yB6VV7Wv+PSKjl53UrwejdJYCrzZW8VEhnLp3tP6JAfF4m
	 2JYAzeGh6jV/X38+yIP7YWo0RmM/WBukTkdZc3Nhnx/XSTYEKeNup9pEE1NTUW0vEow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWQa7fOI;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF160A2602
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFF160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWQa7fOI
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso2275755e9.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564402; x=1793169202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVQya4zBBvRCPfkBD4JKIVbm04JtEbk7i/yiZVqyOOs=;
        b=CWQa7fOITbPvGHiykQfcE5uizuMp4/2ed9gbj4TgAABwIg+8VVtXpVwDkG1bn4ngqS
         vg6Xg36IMqw6VLDPnGE8i9BXIOvS8+QtPTyW5F8rC32LsMRN60V3LmewRG88J3Lv1kMN
         mgIJib0A8XKhRs9kPHLxSjpw+5uX+kZ0/M5NO+jHPf04Ibdd6pN/O5I0KuY2V/YxUtZC
         sNc0NQrYCTszxgaFo4OWWx3GvVNhtdlBcz79WGvf1qyDT6T3/JnzQyKGkY1pBIXnwzcv
         eqkQlImTEqlpsLNaKCFH+m3jjfxfV3SULgWwUsAnGv9JGxqgSTeQwmEBJlqYAqDcgSMc
         FAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564402; x=1793169202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVQya4zBBvRCPfkBD4JKIVbm04JtEbk7i/yiZVqyOOs=;
        b=IPtAfUThxl1wI9BRjC+HLkqNwmY4f1K/p+HQvM49Bv56XRGoZulAjvygLRssUsGi8C
         4a08LTU+iOQJp6yM2pGlhFS9RxWGsIg7TCzuk5cysoUqm9C7MvhFpPca9VrXpo/I0VpK
         UxQ2NvMKm+LQbLf1uHgqdxtM898nzH4IWU5/+UmJ72boJhopr0npPrt0eiXxs/aZ/+JV
         GWCGiFv9U3lTyd/juQ0olisGvcEbUObpMuCkcFQDneyQ+qTS4Bu3c1bMbhuQsfr85M4d
         DT8Y/Wlp1VljsjPur8abkCTmrZge4W/xq4ZocO0t9tjX0/YNv2RppnmDW6WMd4r4X5H2
         rthQ==
X-Gm-Message-State: AFq9FYIHd2P+lzKupXVC7pMv1bm6xI1+XhYL8KhuE4gJmUdTj6GaR8a8
	3mtQrGLewMZoGAGsn1d6T42yecKI1eF+FL1XKLmdRIU+S5fmErpu8w0cr7SdKg==
X-Gm-Gg: AYBFou1Q2lh4qb2qzyyqDSTq2s3MXUQJYJLgzCfDLY1UtLh7y6F8MKHz0N+ed+ofNF0
	z0ZUgMpyOEVvmgSYmRJrA1Rv/pWsYJEaIqRla6iCWQ1IcIqECLn+zIGc/+S2WZuz1NKpHIJwHYS
	zLtjtM0otLZIgHMsEgmArXLmiHvDfvbPKsu+7B7k2MI81c3KIieKXWvuKvyD1U6cVw/g+XkVfL+
	+zxT7dLmAKeZBE7/EGgFSLmvCVqcaPagro5+hROwRD/0bttFVWNOZ+EoTyp3ydcVJcnTiY0m4yl
	1Vhv72aMJhL/UruolpJBjmEB2PyFxij0Uvjg4GqoUNU+gljGwbtc+MADM4oyXPyulyUEwavVyPe
	mVcmB1J96jtt1Xnhox8QhPIY8otTQPxU5Dj62ZDDmD24Sleav26kSd0xgqkdq+2pxGS1VcCUacU
	Uka12ge8Ya7Ki69+Y788XGl0poLvaIeOCeVP/27iAe7lS1g4LGYL4mESt2hlF26AX2rRfL/rvWN
	5aa0jrNi9mMPXYFhcO5iVkqYCDLSjUYAhHrLJ+qhWBEuCCK0rySBcQ+bVu/4saOiroRY9ddhfBc
	oVVlKIe7q1Fp/pKdL3E0ojQplsqRa+32qB9qHI+ww1DO2rWSdRhvbW8sSqnVNUeDC7uB/KYe062
	yxyEhd41VlMOjvrbnk8Vtjc8KWu+Ka3JhT3T8SRUlQBZHQQ6TLPku0R9X70/KEOHMuQ==
X-Received: by 2002:a05:600c:19c7:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a1fdd2f2ecmr17038735e9.16.1792564401572;
        Tue, 20 Oct 2026 23:33:21 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:20 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 12/13] packfile: allow looking up compat object IDs in packs
Date: Wed, 21 Oct 2026 08:32:44 +0200
Message-ID: <20261021063245.2917625-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
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

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Now that we have the ability to store compatibility object IDs in pack
index v3, we also want to be able to look up these object IDs.  Our
disambiguation code can work with a particular hash algorithm or with
any hash algorithm, the most notable instance of the latter case being
when git rev-parse is invoked with --output-object-format.

We already handle the single algorithm case just fine, but we don't
gracefully handle resolving an object ID in any algorithm.  Solve this
by iterating through the algorithms and, if the algorithm is both one of
the desired ones and one our repository supports, then try looking up
the object IDs for that algorithm.  Use an intermediate variable so that
we can pass the correct algorithm in the object ID's algo member, which
will cause the correct tables to be looked up.

Write this check as two if statements because the logic is complex and
it is easier to understand as two statements.  The compiler will
optimize it appropriately.

When looking up an object ID, we find positions in the table sorted by
that object ID's algorithm. So read the object IDs there for that
algorithm with nth_packed_object_id_algop(), and add
nth_packed_object_offset_algop() to get their offsets.

Skip the compatibility algorithm for packs with an index older than v3,
as these only store object IDs in the main algorithm.

Add a test that looks up an abbreviated compatibility object ID of a
packed object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 odb/source-packed.c           | 83 +++++++++++++++++++++++------------
 packfile.c                    | 13 +++++-
 packfile.h                    |  7 +++
 t/t1016-compatObjectFormat.sh | 30 +++++++++++++
 4 files changed, 104 insertions(+), 29 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 4ecc2de818..8b16e8da29 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -295,37 +295,64 @@ static int for_each_prefixed_object_in_pack(
 	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
 		p->repo->hash_algo->hexsz : opts->prefix_hex_len;
 	int ret;
+	struct object_id wanted;
 
 	num = p->num_objects;
-	bsearch_pack(opts->prefix, p, &first);
 
-	/*
-	 * At this point, "first" is the location of the lowest object
-	 * with an object name that could match "bin_pfx".  See if we have
-	 * 0, 1 or more objects that actually match(es).
-	 */
-	for (i = first; i < num; i++) {
-		struct object_id oid;
-
-		nth_packed_object_id(&oid, p, i);
-		if (!match_hash(len, opts->prefix->hash, oid.hash))
-			break;
-
-		if (data->request) {
-			struct object_info oi = *data->request;
-			off_t offset = nth_packed_object_offset(p, i);
-
-			ret = packed_object_info(source, p, offset, &oi);
-			if (ret)
-				goto out;
-
-			ret = data->cb(&oid, &oi, data->cb_data);
-			if (ret)
-				goto out;
-		} else {
-			ret = data->cb(&oid, NULL, data->cb_data);
-			if (ret)
-				goto out;
+	for (uint32_t algo = 1; algo < GIT_HASH_NALGOS; algo++) {
+		const struct git_hash_algo *algop = &hash_algos[algo];
+
+		/*
+		 * Skip this algorithm unless it's the desired one or we've
+		 * asked for any algorithm.
+		 */
+		if (opts->prefix->algo != GIT_HASH_UNKNOWN &&
+		    opts->prefix->algo != algo)
+			continue;
+		/*
+		 * Skip this algorithm unless it's the main algorithm or we have
+		 * a compatibility algorithm and it's that algorithm.
+		 */
+		if (algop != p->repo->hash_algo &&
+		    (!p->repo->compat_hash_algo ||
+		     algop != p->repo->compat_hash_algo))
+			continue;
+		if (p->index_version < 3 && algop != p->repo->hash_algo)
+			continue;
+
+		oidcpy(&wanted, opts->prefix);
+		wanted.algo = algo;
+
+		bsearch_pack(&wanted, p, &first);
+
+		/*
+		 * At this point, "first" is the location of the lowest object
+		 * with an object name that could match "bin_pfx".  See if we have
+		 * 0, 1 or more objects that actually match(es).
+		 */
+		for (i = first; i < num; i++) {
+			struct object_id oid;
+
+			if (nth_packed_object_id_algop(&oid, p, i, algop, algop) ||
+			    !match_hash(len, opts->prefix->hash, oid.hash))
+				break;
+
+			if (data->request) {
+				struct object_info oi = *data->request;
+				off_t offset = nth_packed_object_offset_algop(p, i, algop);
+
+				ret = packed_object_info(source, p, offset, &oi);
+				if (ret)
+					goto out;
+
+				ret = data->cb(&oid, &oi, data->cb_data);
+				if (ret)
+					goto out;
+			} else {
+				ret = data->cb(&oid, NULL, data->cb_data);
+				if (ret)
+					goto out;
+			}
 		}
 	}
 
diff --git a/packfile.c b/packfile.c
index 3bfd427c6c..3f3eb27e42 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1919,16 +1919,27 @@ void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 }
 
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
+{
+	return nth_packed_object_offset_algop(p, n, p->repo->hash_algo);
+}
+
+off_t nth_packed_object_offset_algop(const struct packed_git *p, uint32_t n,
+				     const struct git_hash_algo *algop)
 {
 	const unsigned char *index = p->index_data;
 	const unsigned int hashsz = p->repo->hash_algo->rawsz;
+
+	if (p->index_version < 3 && algop != p->repo->hash_algo)
+		BUG("pack index v%d only stores main object IDs",
+		    p->index_version);
+
 	if (p->index_version == 1) {
 		index += 4 * 256;
 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
 	} else {
 		uint32_t off;
 		if (p->index_version == 3)
-			n = nth_packed_object_pack_order_algop(p, n, p->repo->hash_algo);
+			n = nth_packed_object_pack_order_algop(p, n, algop);
 		index += st_add(p->crc_offset, st_mult(p->num_objects, 4));
 		off = ntohl(*((uint32_t *)(index + st_mult(4, n))));
 		if (!(off & 0x80000000))
diff --git a/packfile.h b/packfile.h
index 73452b2a43..40760295ee 100644
--- a/packfile.h
+++ b/packfile.h
@@ -303,6 +303,13 @@ int nth_packed_object_id_algop(struct object_id *, struct packed_git *,
  */
 off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
+/*
+ * The same as nth_packed_object_offset, but the nth object is counted in
+ * algop. For indices older than v3, algop must be the main algorithm.
+ */
+off_t nth_packed_object_offset_algop(const struct packed_git *, uint32_t n,
+				     const struct git_hash_algo *algop);
+
 /*
  * Return the index into pack order of the nth object within the specified
  * packfile.  The index must already be opened and it must be a v3 index.
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 030d6000b5..97a299f088 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -269,6 +269,36 @@ do
 		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success 'abbreviated compat object IDs are found using pack index v3' '
+		test_when_finished "rm -rf abbrev-repo v3.idx" &&
+		create_compat_repo $hash abbrev-repo &&
+		echo content >abbrev-repo/file &&
+		git -C abbrev-repo add file &&
+		git -C abbrev-repo commit --message A &&
+		compat_oid=$(git -C abbrev-repo rev-parse --output-object-format=$(compat_hash $hash) HEAD) &&
+		abbrev=$(echo $compat_oid | cut -c 1-12) &&
+
+		# A multi-pack-index only stores object IDs in the main
+		# algorithm.
+		GIT_TEST_MULTI_PACK_INDEX=0 git -C abbrev-repo repack -a -d &&
+		pack=$(echo abbrev-repo/.git/objects/pack/pack-*.pack) &&
+		git -C abbrev-repo index-pack --index-version=3 \
+			-o "$(pwd)/v3.idx" "$(pwd)/$pack" &&
+		rm abbrev-repo/.git/objects/loose-object-idx &&
+
+		# A v2 index only has object IDs in the main algorithm.
+		test_must_fail git -C abbrev-repo cat-file -t $abbrev &&
+
+		rm -f "${pack%.pack}.idx" "${pack%.pack}.rev" &&
+		mv v3.idx "${pack%.pack}.idx" &&
+		echo commit >expect &&
+		git -C abbrev-repo cat-file -t $abbrev >actual &&
+		test_cmp expect actual &&
+		echo $compat_oid >expect &&
+		git -C abbrev-repo rev-parse --output-object-format=$(compat_hash $hash) $abbrev >actual &&
+		test_cmp expect actual
+	'
 done
 cd "$base"
 
-- 
2.56.0.215.g47fdf2208c

