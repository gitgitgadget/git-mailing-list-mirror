Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA64C69
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642373; cv=none; b=Ow2c2gWAfnMiIOh9877w3N5gM4ioMolQjBtcFH0y+ofgvyqjvhdrTIho76RBeBYfVDgHuzMZafJJD0dr+cVBcRnkfjUkMYqDJ6F2Tue1AVU+K52TqH2SiswvMaOqwUCAa7M3HRNXeSbv2qjUmE+0B1CnISbCf7pP2o+wRXljTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642373; c=relaxed/simple;
	bh=0Mxe7PkzWxPmgxebb0HRdIlnleuj/Q5l8SJ+80YqRog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pon/txA/TwEPeRbM07mG4F1kHvVtgdCwQi12PGxCnI391V9IvtnpKkcZvfzXIQwTSu+IZGOpZqEPMGGQbc1IHyOid8xkFinsEtifp8BWB+zEvtNZNBYBug0lLqbpULlGF34mXg610gswZliYyjlqF6iTAyO5lfbcwM8HXYfUuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AUynF/I2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vjwDvoZD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AUynF/I2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjwDvoZD"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6675D114014A;
	Tue,  9 Apr 2024 01:59:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 Apr 2024 01:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1712642370; x=1712728770; bh=b0yfhGevDC0sWGSL+AwUGaVIbPUAuBwk
	RnA5dWM1Wds=; b=AUynF/I2j72/L4615b8hF/MhN0XdiC2n5dry8H9ancmrC6ga
	c9QHDnBlLfj279/yPQe62f29YMofK5YEQ7NmkNtAZ2x/81RQR2lsPG2aF9SUQ4CN
	M59rzNjSk43kG8J7oXr0AT7pJTTQ5/V7DqdlLjkfkaiDef0IYyxxfaep3ZFQ1SRe
	xx0swt07l5ZIgLs/fdzsdPlDWqhQjHi+XTTkKt+P9Vfx9+Gii0mRvju/2AhCsr9a
	VNViLMx/8i11bD14b4aJzjbRKB0xdJWCGQx28Ed/tuzhpjaHEMpJGWN/ev+8tcV6
	1gUvIfgIUZ0ZJPCDQaxSe1dsD9mHFoHeeDB5KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1712642370; x=1712728770; bh=b0yfhGevDC0sWGSL+AwUGaVIbPUAuBwkRnA
	5dWM1Wds=; b=vjwDvoZDfyL7b6ai8FIN48X2i9eFDAnbVgXu9W2nu79YjkeRFMO
	/FnC2D0QIAchMyZOzWmXyASs2wxhqLs3L0KOB3J4X/4I5fTzdCFWWw/USF6LzRqE
	5C/uMp7GLVPUq32iNOaTO/srvS2SppEyDdBe3XW3y5FT4fPa61pFmHrvmVf7Kqlh
	ZxltoX+IQ2Sy4qseS90kuApVo7LlvhMlV/Qnem6pBCdg7tKj5VB7wCmeHUdx9GjN
	za2ZMLppKH/oTVWHSBoIn1f/lFreYT+COZgs7PAaKzz6L/C0eFCtwDoYkNhlFy0I
	OUQcIir+d5ZzZZmm7A6SyleyoK3luOEvrGg==
X-ME-Sender: <xms:QtkUZk3GliC19NwqKDlAxE43gTgXBWPaDIZP7j6L7FOsXXvkdvVUmw>
    <xme:QtkUZvG4TTObvFdix-BaLACuzmsv6dAt7NIdD359kPRfhhnfvIPoRIfpc0mBmIxrr
    z2uoB-7MICeBLTJrA>
X-ME-Received: <xmr:QtkUZs6czB-NwJHM9-IP7DPxYlxnjQOlYUjO53MU-T3op-C4dtguhpv-m9fI6PL-guFeyNQbDK7Qt2q-IjK1wVhILHDDToKcrjEe6zIOX4BT3P6YYxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QtkUZt1Dy9VvMp-RvG1rKXTqITcttcoNON3xN4mOe-6vAqrDZsDZQw>
    <xmx:QtkUZnE3hBhp7Z3BymxRtucnGTJUJsiGp8tGX__OXjXtdabjhMKGFQ>
    <xmx:QtkUZm-9LdWF7xczXp-H0sHAcYii3RkunhSq62LcLKwzrAkA8Bhefw>
    <xmx:QtkUZsnznDPT9S-2XWnPQcsV-R6p50xxgG0m4rhfg99B6BfVsVN9JA>
    <xmx:QtkUZsRhmjYMQypqcoM3MZzr0hFlDgjjZ27PnT9qFxE29HWEL5P211jf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 01:59:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a1530f6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 05:59:19 +0000 (UTC)
Date: Tue, 9 Apr 2024 07:59:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7Y4Hb5+oDSAS9bx1"
Content-Disposition: inline


--7Y4Hb5+oDSAS9bx1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 0fea6b73f1 (Merge branch 'tb/multi-pack-verbatim-reuse', 2024-01-12)
we have introduced multi-pack verbatim reuse of objects. This series has
introduced a new BTMP chunk, which encodes information about bitmapped
objects in the multi-pack index. Starting with dab60934e3 (pack-bitmap:
pass `bitmapped_pack` struct to pack-reuse functions, 2023-12-14) we use
this information to figure out objects which we can reuse from each of
the packfiles.

One thing that we glossed over though is backwards compatibility with
repositories that do not yet have BTMP chunks in their multi-pack index.
In that case, `nth_bitmapped_pack()` would return an error, which causes
us to emit a warning followed by another error message. These warnings
are visible to users that fetch from a repository:

```
$ git fetch
=2E..
remote: error: MIDX does not contain the BTMP chunk
remote: warning: unable to load pack: 'pack-f6bb7bd71d345ea9fe604b60cab9ba9=
ece54ffbe.idx', disabling pack-reuse
remote: Enumerating objects: 40, done.
remote: Counting objects: 100% (40/40), done.
remote: Compressing objects: 100% (39/39), done.
remote: Total 40 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
=2E..
```

While the fetch succeeds the user is left wondering what they did wrong.
Furthermore, as visible both from the warning and from the reuse stats,
pack-reuse is completely disabled in such repositories.

What is quite interesting is that this issue can even be triggered in
case `pack.allowPackReuse=3Dsingle` is set, which is the default value.
One could have expected that in this case we fall back to the old logic,
which is to use the preferred packfile without consulting BTMP chunks at
all. But either we fail with the above error in case they are missing,
or we use the first pack in the multi-pack-index. The former case
disables pack-reuse altogether, whereas the latter case may result in
reusing objects from a suboptimal packfile.

Fix this issue by partially reverting the logic back to what we had
before this patch series landed. Namely, in the case where we have no
BTMP chunks or when `pack.allowPackReuse=3Dsingle` are set, we use the
preferred pack instead of consulting the BTMP chunks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                        |  7 ++++---
 pack-bitmap.c                 | 36 ++++++++++++++++++-----------------
 t/t5326-multi-pack-bitmaps.sh | 22 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/midx.c b/midx.c
index 41521e019c..6903e9dfd2 100644
--- a/midx.c
+++ b/midx.c
@@ -1661,9 +1661,10 @@ static int write_midx_internal(const char *object_di=
r,
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
 			  write_midx_revindex);
-		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
-			  bitmapped_packs_concat_len,
-			  write_midx_bitmapped_packs);
+		if (git_env_bool("GIT_TEST_MIDX_WRITE_BTMP", 1))
+			add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
+				  bitmapped_packs_concat_len,
+				  write_midx_bitmapped_packs);
 	}
=20
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2baeabacee..f286805724 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2049,7 +2049,25 @@ void reuse_partial_packfile_from_bitmap(struct bitma=
p_index *bitmap_git,
=20
 	load_reverse_index(r, bitmap_git);
=20
-	if (bitmap_is_midx(bitmap_git)) {
+	if (bitmap_is_midx(bitmap_git) &&
+	    (!multi_pack_reuse || !bitmap_git->midx->chunk_bitmapped_packs)) {
+		uint32_t preferred_pack_pos;
+		struct packed_git *pack;
+
+		if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+			warning(_("unable to compute preferred pack, disabling pack-reuse"));
+			return;
+		}
+
+		pack =3D bitmap_git->midx->packs[preferred_pack_pos];
+
+		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
+		packs[packs_nr].p =3D pack;
+		packs[packs_nr].bitmap_nr =3D pack->num_objects;
+		packs[packs_nr].bitmap_pos =3D 0;
+
+		objects_nr =3D packs[packs_nr++].bitmap_nr;
+	} else if (bitmap_is_midx(bitmap_git)) {
 		for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
@@ -2062,26 +2080,10 @@ void reuse_partial_packfile_from_bitmap(struct bitm=
ap_index *bitmap_git,
 			if (!pack.bitmap_nr)
 				continue;
=20
-			if (!multi_pack_reuse && pack.bitmap_pos) {
-				/*
-				 * If we're only reusing a single pack, skip
-				 * over any packs which are not positioned at
-				 * the beginning of the MIDX bitmap.
-				 *
-				 * This is consistent with the existing
-				 * single-pack reuse behavior, which only reuses
-				 * parts of the MIDX's preferred pack.
-				 */
-				continue;
-			}
-
 			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
=20
 			objects_nr +=3D pack.p->num_objects;
-
-			if (!multi_pack_reuse)
-				break;
 		}
=20
 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 70d1b58709..ee3843b239 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -513,4 +513,26 @@ test_expect_success 'corrupt MIDX with bitmap causes f=
allback' '
 	)
 '
=20
+for allow_pack_reuse in single multi
+do
+	test_expect_success "MIDX without BTMP chunk does not complain with $allo=
w_pack_reuse pack reuse" '
+		test_when_finished "rm -rf midx-without-btmp" &&
+		git init midx-without-btmp &&
+		(
+			cd midx-without-btmp &&
+			test_commit initial &&
+
+			# Write a multi-pack index that does have a bitmap, but
+			# no BTMP chunk. Such MIDX files would not be generated
+			# by modern Git anymore, but they were generated by
+			# older Git versions.
+			GIT_TEST_MIDX_WRITE_BTMP=3Dfalse \
+				git repack -Adbl --write-bitmap-index --write-midx &&
+			git -c pack.allowPackReuse=3D$allow_pack_reuse \
+				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/null 2=
>err &&
+			test_must_be_empty err
+		)
+	'
+done
+
 test_done
--=20
2.44.GIT


--7Y4Hb5+oDSAS9bx1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYU2TwACgkQVbJhu7ck
PpRUDw//X5KB/PxbsayMw3WwsNXlLztJflvVfNiixorx1qix8Li0HCbcDYZ1Jj4N
17k0cENHA7ioH9kIRozui1A6/RW6ptuYOsF7KS9Yc9REI2O8Tl3o1KVCqF16z/J1
D/8x+vlWpdYqGkhihicMK3Mc/VhYrYF5ya4e4BOSEdBCt3vkPwI19p7D8CrMBQZp
MVbYotIf0sSCmFMwDv7adqCF0+edkWlQ0pLRlVX9trVF4nm4MjtJtrMabj+yGSwr
ZbEwAQMxiGUg2UsjzlJ3N3s0du9p190XTaeul0moEg1RgWQMIBhlbvwaHXZelUKG
UmqXqgOu1kxq+ar5uvJWfn3N0dOPrdmJPQ01D6y41553leEqRupUvEpmHRI/tWoE
Su9aSkV0vAtlHxhPgsCiDfrZdxYD7DmSqWyqWcaOOqUALP6hvpD4ijpXe+ZnxsnQ
+X1VK06itTPCFBsS9io+jUzBhhbv9IVjmZ6JrCzTPl2tORer2yC+7H/K5Qovj11l
mLAQK/obJJeNxdJ1KJkEKZlKzLE6fjCI5jTIjJNTAPAiQv2IHZQ9gq3AksATKu02
wrCXsc0qPyMmqpevmzrRjmTRRAYXvu+4b48cl7a5F56kcVSS41oYYrXPpfpmFKHY
PJRFUEAmX7ppuYgk1U2au1sxD+ax9X9BTkM+ibSTDfog8E69E1Q=
=w7uU
-----END PGP SIGNATURE-----

--7Y4Hb5+oDSAS9bx1--
