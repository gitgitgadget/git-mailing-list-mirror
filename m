Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740397;
	b=Uy/rmko33lN3Ggi6INzVeSeMu3gIWPc2QiAq0MLi1Lc62G+fKiYg2oTfEludYoURwC61
	 hvhICblmzmRl6GIC+i/h8bdepJhHvSCeK9tfXVthONc7YY+u2aNbsi3B/C09moN39fRC7
	 MUp+2JOiJ/tgO6S/nLtxwlwEviApEAKDetHW5wKaTVhZvrBtJjfer4G6DnnFsGZ6Sq1r0
	 K2ea2bWgZZpuAPr8RcAw5+bJTL/bCNrchCNrufh0Luh5704Z9gNUf2tv3NiFDaWrwmNGf
	 ZzjPwFMgyjhntWg3r8JKiPvd+35k1xNLFTK+wtfl5oVYZ/HAHrC/x+spoU/mizG164Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tVQya4zBBvRCPfkBD4JKIVbm04JtEbk7i/yiZVqyOOs=;
	b=Xgjcet5ZrSg4TGTjxcy4gi6C5gL/2WuDX0TNDTOQPNoEHjmGX1FZyGAyIpqFKT7lTOTB
	 VCYs7sfvhPkcfN5LemGA9mOjMcp0YWfSTdjfRmgtOGaq0Bdv7Mzt8Ahtx6WDn+ldLg7l7
	 ybV1TG2kVweP5AT5reuHP42+HYMJ3KZOGdHnWibBiZfWqPe4ZZhBpTCvefDJUpE06a4sm
	 zXNgwjV4EASSUsp1QEnm0JP4rFARRomipQJ03/Zylm0lPqSXUg6M2GQT5Tmh0olvTylA3
	 1pdx0R+tDLTlliOi420qc6tZXruhHwOId16Hft0ko599nLJ6jcxV4oFWqESATptVeMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=an6JUQH7;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481A606A32C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A481A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=an6JUQH7
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e10a70540so293140f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740395; x=1793345195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVQya4zBBvRCPfkBD4JKIVbm04JtEbk7i/yiZVqyOOs=;
        b=an6JUQH77W0skWMuH66wv8jI0VRUgUDKNSCnZvqEuxXUkxCqMrS+hppwWpBht5ViR8
         DFDTbzolvBoyg951VB4hNK/Cqa9C3JAOSMYhVR06JbLflkK+WvJDeCtQtNmqByXsy6bs
         9QMB1ssS+Vv6oAwegug5/cvaHLUNwNsY7RRw1zFAOANu9+s5sh5iZ3q4k6w4LtEO4vFO
         gaTg6ZWDUA53PLL3p81ahEsQWTw2YB1KnCVqziEozAo20ajQqHiX59EnljK5INz+kEtS
         vkk6YBe86IvgiNwfHjzILxJhDI4KNaBI3iLdoiDFIatRER8dyso7F13Dhhz7MpIb0w0Q
         5JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740395; x=1793345195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVQya4zBBvRCPfkBD4JKIVbm04JtEbk7i/yiZVqyOOs=;
        b=UuvuQD5CHCxCOSh+mFZtonzJspcTcz/0Iy3P9lHpVS47w27Xq8x79W+1NuRecTiTYN
         xdoMnnrCddCLCFl6PMHot3JdBHzWIcPvdYJ/WTYRiA8XiEpnuNQFskCXV0QQ5LBZBthk
         wYHMcKPygRDgbrbZ64ch/lBlov86e+JX6ma0xoLOF2a2hEVqQjpMfYAMDlNwcbW0PLDd
         J/PAcuZ+HtfL+DBkT7a9X+yJg2IEK9DjQBRIH+KUuct13u646AvAxe1npiQ0ufqKKbfk
         4aUOdHw9aj+X6SAJP/kUI47XoiXeTHQgZ0M2VAZeyjhxmXccDhVIsV3nHYcZxuIUXZMR
         ss2Q==
X-Gm-Message-State: AFq9FYJU6DSBNEdYWCD7TWFgtvVbaKW+iYu9u84HNzMexUMvsiLeHPgz
	CVJ0GqyxUbFUmYs12V+XXcFZS4uyfplYO4pH4zO/KrA4McWF1wqB9UQcsafcEw==
X-Gm-Gg: AYBFou37yFTxbMnSMfTQ2igZ+vYVx7F6BeZlvZa14y7Lp69Q6a+Ue0GOv24JJMpFdMH
	4XYzs/wbqYJPQY3j8XPEfIzWvXwKQG20aR9oTyyG61euvTrT9vTuZu9o28oe0Floshmos4saF5E
	/OErIQ/RaaRBhAXOyVijI2jaGH2sAeV8eVd8nUxqt6wJoSpJShsUz4Z7v15wG/p4FLfgXRitkZo
	rOgT5GVBkjQ8hoSZZBMMgw44MZNntu1XvMmA9ZTPi2hBsfBftzCTTpH7Cph+uB+922vuZHro/Ad
	SAxQox+uQHKtR1QRPqB1F27crFYye+XLw7P7lRqkh7jHf1XEb3PuWdtqkHNEtsHhRydMJgGBOFI
	sFXSL81cjNhzA2PrEkSRSzPEeMtQl5kKKv0lAIHduSD0Uy4fGaFVN8d+oKTvHHzrQys2XnYGrW4
	/JN1bTfWoghzS2BoSKDOb39AR9gTOP4g+mwkbgdxffs1OIZPMCEijfXZ9fPfr12dRxFrWnALXXb
	XBYqxm/G9mUHRmEO6dFbvOmXjJ7CoF1WRe27GHDzsbbNh5fd1JtTafQR+QvlZZw7007IhvKOBVf
	snFDk5XVyogolsIpcLo/HYHNXJ4x9sMhPc83Ydtxr7Zx5vdtahqhO3fXTO3saQCTfGjYbzN5RFW
	zP0q+teRwNfKhjoQrSt/F/FhBg3Kri02HZKXibIsCqweKCF3Arb3CvVkunpE4Qs0f+g==
X-Received: by 2002:a05:6000:1608:b0:48d:c178:f6e9 with SMTP id ffacd0b85a97d-48e38588c6amr1464834f8f.20.1792740394882;
        Fri, 23 Oct 2026 00:26:34 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:34 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 12/13] packfile: allow looking up compat object IDs in packs
Date: Fri, 23 Oct 2026 09:25:57 +0200
Message-ID: <20261023072559.3204273-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
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

