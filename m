Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF918623
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UEZYtAw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KigAHhbm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 728DB5C01E3;
	Wed,  3 Jan 2024 01:22:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 01:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262957; x=1704349357; bh=LUEzIz2MvW
	GXS0GMwIs0PepWxY49DadEnt4HKy0NAbE=; b=UEZYtAw2b4580caghQSiG5ILHM
	8ymDWh2vL7mgSyVmPS4jiOCTUWjVtePgOnrNPPt4pM+Kb8Er3DVDwrkxqB+14SBf
	Y1sEOL8bPTq6KA+wT6zRNZIaNXa3P9Lf6i/uUnb89VWScFbf/92XTyJsnIE9fule
	B104EmFkTufq5UmOQ89WTvJFunejvRBz9Ng/NOsTtunCbpFo1y0q/EkoktBgZOjW
	UAugTOXJOcwU09cRQWn5WmGFv1CdEEaCTlMoXMXleJViA7ftVStcaggPEB0TRSuZ
	ZJIXNStkvrDJ9al4hD3k+ZjXldV4LSToTYcegKSx5aSGgs5/aDXF3UT6/nig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262957; x=1704349357; bh=LUEzIz2MvWGXS0GMwIs0PepWxY49
	DadEnt4HKy0NAbE=; b=KigAHhbmGPxIgPkf396hM07WQZu++/xiqvEub2p2cSQU
	eXmFmiTV0w4orddm82T6z8aeot892QNctumN7jbLT73U2d/gRh47lVbbw9CmBwNV
	6G/D3WQt9YAwmdmrdLG+XLdlBqNDGF2yyQOhzTL5ww4wA6EZuHrr7f1FlVfK0dpB
	ZpMmz1QAA78SwMVBt3aF6adcMVCFmDRaFdJZLTAM0r2xsfyidVL71TTPMWSPBZ1o
	u+TC7RmJGrOJ7G+8MY1SHLQZ1D88LVD/1KLYZcAsupaOXK1d9/GbutKn4iKicEi5
	Rwmhlf+2xrSnMFct+vnQfFdtGSRzAX+xoxJj4Vb8pA==
X-ME-Sender: <xms:Lf2UZY4-fFNC4cOY2ie7J10UFO7Hc5F52vKr4ZbylqezGCX7kKFBXA>
    <xme:Lf2UZZ5S-EKbexdTYCBonp30ILFBaZ8uKrAJIzo3cm6je7HxoUP0COnK7JNUmT20n
    Agq3BLQTX-6hZIXMw>
X-ME-Received: <xmr:Lf2UZXd5_cIvZGdfWA4O0j5-ZbtU90pbyOqtvgRCv0KE-faLIHga5FsGVmw9663LmRn6Wnsr83lyX-tDPuNBsDbntaomn1UMgJC9tZpmdgUk_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehjeffudefkeejheekfefguedvtdehte
    fgiefgveelgefgheekhfdvjeefvdekudenucffohhmrghinhepvhgrlhdvrdhtrghrghgv
    thenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Lf2UZdINpTG2WApvjC5ZhtZk2FOoj6O0lGZiWnCDjU1PqhiBOSMk4Q>
    <xmx:Lf2UZcJSjYNuVTEQ9DJECVqp-I4qnydzWEPlkmZP4kJYd8pMGwNpuQ>
    <xmx:Lf2UZewkRQMNqgdyCpS2KofXW_jeP_v-AelsjQaGl54okL8_edPFsQ>
    <xmx:Lf2UZWhBjXLmUgWSPcGTfCzcZaIo5IUAu9bqHesL36ptrf2ySLl-DA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e172148d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:20:11 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/8] reftable/record: store "val2" hashes as static arrays
Message-ID: <6ec02d6775c0f3e3274d57ef4a7dfeefac8308a9.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ckp13kzEGXREZGKs"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--ckp13kzEGXREZGKs
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
index 87b238105c..178766dfa8 100644
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
index 7f3a0df635..bb6e99acd3 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -41,8 +41,8 @@ struct reftable_ref_record {
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


--ckp13kzEGXREZGKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/SoACgkQVbJhu7ck
PpSusg//XF3/BmBJwS/yFzTfxcDbEgsT0Uy2aGFxUSMY4wxiLyRnMWIB3tzP4Nrf
zzjOjeImWh2rNGVyWiRYs7Bx0jG9g801TCuJHnvmKoFg/QFdfCzvTXI3hARunB2q
uUsyQUkbHq8UxEDUSczzT4MJd/paUwNSDTfKjpPXkv/13bJS9/1bw7LUcAuqXlxn
fXrfVN77P0Xn5UUZJfaArZ5KAERlBZYKcOxfGEIXUFkeu64smZb5DbM0QscEWZPi
waegdqbDkykFdHtHUj2a+vlxmdljluI/ZuHtBIsoClVOubpdO8FsltENC/eX1KrI
/yZT4s9i1HShTQ1vO1BCGkUgqfRoAZC7RWwJNnGvYsjKDxY803UqQgQX65TsvVxE
BYY0o/YAGQ3hUFE4G+olPvShBKwV5WdtXF7d3BxqubKZ4FnIUvv5riwmzdHTi/VO
KufpzxkEAnaqdECyEpmgSEz9ZA3llwJq0IWAm4us9NXfqvQXVTvJaIrq1xgRGIPG
nBDHR4l0/1RSrE4wbH9H0ZTdFk0gW+N+H1CSdMznCwoaTccMDJtsM90hhLyeLJ5C
e1GGjU86/MWWuaHhfMm53pa5Vlz6JhmGIN8ZX7Xx1w7LSS4yjXoSvVs6DMdsG3BI
eMElX2fF2xhrEFf6z07d97uRpP/LcB9mJnc3YknC8TFk9I18erY=
=LnGF
-----END PGP SIGNATURE-----

--ckp13kzEGXREZGKs--
