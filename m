Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91761D55C
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OpiyJ3Lf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJ+HU86k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 08BA25C00D5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 04:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063845; x=1703150245; bh=OPzbFCLw49
	w3k19YqVHfuomKD/o7Hx5kBYXQPZinhjU=; b=OpiyJ3LfZ5fClrONzLN2WjTVaM
	yBFXG90CTo4rimRtFaHWatbsVOzNnkOJK31GsJgst7LPeBw8BCakOadYC+tLN4Sn
	Eh+LxJfhR8K+S4+2+AVZTQy+9xgS1f77N4T3xpf3RjL3fdUmq8NM4cdUxcjaGfCf
	8yj84fEwqC+Qdwop1VYv3Z0qclO4yElR60TgwdOwItfd7q8CdImpORigWu68G8fN
	boqU99yhki5uaJsBn3IZfqsfL3PbOCgbr3PIA+uek5+fjsw9hYSGS26mg6yeVNNU
	5uBUHIztCrzmmXDA6e7YjgyaUSGqjh3dymHNYJW4Yl+aT0+YOMYSQwHTK04A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063845; x=1703150245; bh=OPzbFCLw49w3k19YqVHfuomKD/o7
	Hx5kBYXQPZinhjU=; b=uJ+HU86kLbpaUAeFDHn/4OUTE1TLm8MzOanPOfk9xyqG
	DtKeUDjUhxhZ1F0oqnhJXmyj1crJZJdp7rP5N81EIShnmRx/T40dOK8XwBrLwL6e
	yWEXIH/KszFjJKATjnGrklf2aTr1l6zt+MozLnVYUt08OEds5G8nL2bf1vTWNIBM
	ezqqLowVqpsDmh8PyVRWXIZetpz7xUAP2btvGG20PkiCla/6cyE9FR3V9bfTEvOL
	7c7XqNF2ZFHajMn+aPyhZ7EZk/lyxpLHhJGPiE2PNiIISFWx4i3xO9j+4tRHy8Mb
	cyLQKPSVJvP9uqExS2HGS3fzPuJkGxgU2IPZ6PxHEA==
X-ME-Sender: <xms:JLGCZYZCTGDGhPMFFFBf9pFDigZ_BcVdd52o8-tT-nzTY-6K2gKEmQ>
    <xme:JLGCZTbTulPzzLA20GrmCz3ollikZUSODET03ueyiLi5BIQrBu78V96W7a1f0UexQ
    tbQthvP8ztzqhezKQ>
X-ME-Received: <xmr:JLGCZS_KdgFTRbgilEJJ_SenbQNctup9r7bKwlYM5_AlYNRKovFnOBy6yr14WCgH4Jb9-I90A84FxejsO_O5uZQjFkDuFkheVp6CBgcApdXHog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfeelkeetleetteelkeehteekieduueehhf
    eljeetkeehgfevvdevledtjedtkefhnecuffhomhgrihhnpehvrghlvddrthgrrhhgvght
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JLGCZSq8ccMZf0jIxNNeOjBIHNQJnln9s_DOl4hVJzx3ApfkGLhJ4A>
    <xmx:JLGCZTqedoXVbkQAOhIeFvbm7QminyaZUY8Qc6116GNdpVIfqeQPtw>
    <xmx:JLGCZQQXCBB5c1XvT1XSJGy8AE2o4flQUiV3lulsGwfXyhlxjk2Dfg>
    <xmx:JbGCZdH21VQTUNC7WBAkt6GsVRFkvTDKYINY04U-K8JPBXSM8j8l1w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49fa591f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:29 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] reftable/record: store "val2" hashes as static arrays
Message-ID: <49f13c123f211c0cf4b22316a326930ee5852c38.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sC9Rah/PVC6aqHi4"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--sC9Rah/PVC6aqHi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding commit, convert ref records of type "val2" to
store their object IDs in static arrays instead of allocating them for
every single record.

We're using the same benchmark as in the preceding commit, with `git
show-ref --quiet` in a repository with ~350k refs. This time around
though the effects aren't this huge. Before:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 1,419,040 allocs, 1,418,847 frees, 62,153,868 bytes=
 allocated

After:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 1,410,148 allocs, 1,409,955 frees, 61,976,068 bytes=
 allocated

This is because "val2"-type records are typically only stored for peeled
tags, and the number of annotated tags in the benchmark repository is
rather low. Still, it can be seen that this change leads to a reduction
of allocations overall, even if only a small one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/readwrite_test.c  | 12 ++++--------
 reftable/record.c          |  6 ------
 reftable/record_test.c     |  4 ----
 reftable/reftable-record.h |  4 ++--
 4 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 56c0b4db5d..900afc1b70 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -547,8 +547,6 @@ static void test_table_refs_for(int indexed)
 		uint8_t hash[GIT_SHA1_RAWSZ];
 		char fill[51] =3D { 0 };
 		char name[100];
-		uint8_t hash1[GIT_SHA1_RAWSZ];
-		uint8_t hash2[GIT_SHA1_RAWSZ];
 		struct reftable_ref_record ref =3D { NULL };
=20
 		memset(hash, i, sizeof(hash));
@@ -558,11 +556,9 @@ static void test_table_refs_for(int indexed)
 		name[40] =3D 0;
 		ref.refname =3D name;
=20
-		set_test_hash(hash1, i / 4);
-		set_test_hash(hash2, 3 + i / 4);
 		ref.value_type =3D REFTABLE_REF_VAL2;
-		ref.value.val2.value =3D hash1;
-		ref.value.val2.target_value =3D hash2;
+		set_test_hash(ref.value.val2.value, i / 4);
+		set_test_hash(ref.value.val2.target_value, 3 + i / 4);
=20
 		/* 80 bytes / entry, so 3 entries per block. Yields 17
 		 */
@@ -570,8 +566,8 @@ static void test_table_refs_for(int indexed)
 		n =3D reftable_writer_add_ref(w, &ref);
 		EXPECT(n =3D=3D 0);
=20
-		if (!memcmp(hash1, want_hash, GIT_SHA1_RAWSZ) ||
-		    !memcmp(hash2, want_hash, GIT_SHA1_RAWSZ)) {
+		if (!memcmp(ref.value.val2.value, want_hash, GIT_SHA1_RAWSZ) ||
+		    !memcmp(ref.value.val2.target_value, want_hash, GIT_SHA1_RAWSZ)) {
 			want_names[want_names_len++] =3D xstrdup(name);
 		}
 	}
diff --git a/reftable/record.c b/reftable/record.c
index a67a6b4d8a..5c3fbb7b2a 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -222,9 +222,7 @@ static void reftable_ref_record_copy_from(void *rec, co=
nst void *src_rec,
 		memcpy(ref->value.val1, src->value.val1, hash_size);
 		break;
 	case REFTABLE_REF_VAL2:
-		ref->value.val2.value =3D reftable_malloc(hash_size);
 		memcpy(ref->value.val2.value, src->value.val2.value, hash_size);
-		ref->value.val2.target_value =3D reftable_malloc(hash_size);
 		memcpy(ref->value.val2.target_value,
 		       src->value.val2.target_value, hash_size);
 		break;
@@ -298,8 +296,6 @@ void reftable_ref_record_release(struct reftable_ref_re=
cord *ref)
 		reftable_free(ref->value.symref);
 		break;
 	case REFTABLE_REF_VAL2:
-		reftable_free(ref->value.val2.target_value);
-		reftable_free(ref->value.val2.value);
 		break;
 	case REFTABLE_REF_VAL1:
 		break;
@@ -401,11 +397,9 @@ static int reftable_ref_record_decode(void *rec, struc=
t strbuf key,
 			return -1;
 		}
=20
-		r->value.val2.value =3D reftable_malloc(hash_size);
 		memcpy(r->value.val2.value, in.buf, hash_size);
 		string_view_consume(&in, hash_size);
=20
-		r->value.val2.target_value =3D reftable_malloc(hash_size);
 		memcpy(r->value.val2.target_value, in.buf, hash_size);
 		string_view_consume(&in, hash_size);
 		break;
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 5c94d26e35..2876db7d27 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -122,11 +122,7 @@ static void test_reftable_ref_record_roundtrip(void)
 			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
-			in.u.ref.value.val2.value =3D
-				reftable_malloc(GIT_SHA1_RAWSZ);
 			set_hash(in.u.ref.value.val2.value, 1);
-			in.u.ref.value.val2.target_value =3D
-				reftable_malloc(GIT_SHA1_RAWSZ);
 			set_hash(in.u.ref.value.val2.target_value, 2);
 			break;
 		case REFTABLE_REF_SYMREF:
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 44b5125445..83d252ec2c 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -40,8 +40,8 @@ struct reftable_ref_record {
 	union {
 		unsigned char val1[GIT_MAX_RAWSZ];
 		struct {
-			uint8_t *value; /* first value, malloced hash  */
-			uint8_t *target_value; /* second value, malloced hash */
+			unsigned char value[GIT_MAX_RAWSZ]; /* first hash  */
+			unsigned char target_value[GIT_MAX_RAWSZ]; /* second hash */
 		} val2;
 		char *symref; /* referent, malloced 0-terminated string */
 	} value;
--=20
2.43.GIT


--sC9Rah/PVC6aqHi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsSEACgkQVbJhu7ck
PpRl3w/+Mz0c1CHdtHg92V1l2X8qBR/l/OFvNekdc/NqsRyuLQ2YkNmRA3u1qRo/
65Y43qgAeFVy2L1oU0ws9wrnQAoNgFsjucpCgFfPHAbCRnPoSRea5jnag2zdUzf8
dZLjs67AGtGq4BTRHYQKJ46kxPvR+vbRjD4bomTcwD+omaftnHGNJWM6XqWpHTyq
kJWDclbxcaHPwB1X9+Udja3yeipoEjXZYuZaG7+OSiLI3TOvPlOOankbEx1PpL1Q
gqe6Baj0ZaiOIpWnvEtEpMoTBjmz05uWDzos3QQSsFox/EK0eP0lnwn1w3O9MnBY
RCazHBL1Et7TiiemMpynDhNxKih6ZZegM669K8XoYRuxAXFgOBVVdcCErYNhqhhx
Yf/h9WMYGAHdb8seUr9ntk1B+lZ9Lg7xqOPySn1VFOOfnOZ2iJi6FQBB4ASbc+yA
KjPSd5F7CLZp9cwcp8YgWMECghLQM6FDvnanwcjB0q7FQiNr7GBN/y6EkUukCkWX
/UTmHaWNS+N2wucSa1hhDzR0zkvmz67p/yvlXcpTlBSSeXivkldSo9VcTdwpXjGl
7fepP3LlqIKOJ/idwlsExqCCyD5b9ZoFV32CedwSurWe8L6HUQifRjEfxQ6RP8+q
FI+eyuGkCCvPoWkw0jSqfMN0vzpEfwjoFLy547c1ucypDwO8tng=
=FERM
-----END PGP SIGNATURE-----

--sC9Rah/PVC6aqHi4--
