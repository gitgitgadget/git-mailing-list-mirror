Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BC4426
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="queBli+s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="heupwb7U"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A1C1E5C010F;
	Thu, 28 Dec 2023 01:28:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 01:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744882; x=1703831282; bh=oN9zVSeBdj
	qUwYVBoQ6eDHinMiM16bO3wb/lvdSBzYI=; b=queBli+sxAQtkK5jy7nXfEz5t4
	GxTDX/c5zmZZkL0Z1pFk72pX9pYWYMWcJYYMB4baudy+NNhCf1o2Umy8H072/E5t
	noE/yHEVNaAU+tORb/D0iZMS/CPfcma9VWnVgb/AAJPHz9m3Pcg9sWnC1DMjkuo5
	JHUCotR4brej/4xG7Kt7/ALrsXWb+a9wDWoJciKXD3Gz2WBt+lEPQ5ADf307Fjz5
	YatNyJuYh6mb5Eevodz+hUNwP7P1oWtEo93PSJR3/1X5G4jYH5kvJsol7Qc2te2W
	duqq8AQC0UM92yM4DRpiOGB57KRA71B5hZhZ/QdAEShn4+nG1YdBAs6nJrzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744882; x=1703831282; bh=oN9zVSeBdjqUwYVBoQ6eDHinMiM1
	6bO3wb/lvdSBzYI=; b=heupwb7Ujwhig86aSVFPglViE1Yr7svj3eJPvnnCC2ke
	hNMtOJ0664pA2aEE1w5sKejHYyE2fA5vQ8VliWrxPN3mT+iL8BaXZMP6Yt6bbZc6
	ITw2q0Aq7w6HHERetKPMCmV/FwntvK+hVtzMlCohJGxhSSnXmzsSESJ1kbybcnMF
	p0eQwnSJjHTpraRUT8o0Sh7j4kC3BJDXUUCF5xuxVskmsBVq+/M6gKSvdnbCjnL5
	dWlVsnmoUHUrwRSeh6knPVGNizUnParafpas6qp0jNzl290wLzWpX3boH9DgVWN7
	sPTHdtIq85B7B1EG6pmGmEAX2b7ofXpvPdxbhwMj9g==
X-ME-Sender: <xms:chWNZT0OGJCNtav12eh_Il4_0dsvFe_xt1NTKKOsXrbYTqg9mZk5-A>
    <xme:chWNZSH6OkVjSkmyd9HFah1wJtOvtjUVEgKCLFPB6nVHIWWUcg9v7oJal8T9_ijP7
    002gkdMCTIIuaP4PA>
X-ME-Received: <xmr:chWNZT5-oqKuSIuSys-Lp439L2gEb88fokbYRclFjCXE86Q6_Pfi-4wPrrUSIqkli1ORjH_QaTylApP15gteVx442z4PDda7TiCiHVOXj8iNMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehjeffudefkeejheekfefguedvtdehte
    fgiefgveelgefgheekhfdvjeefvdekudenucffohhmrghinhepvhgrlhdvrdhtrghrghgv
    thenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:chWNZY3gpqbqNslAvjGaJAP4o2EUkBt0QzYP6EVWC-njqyUsQ1RvwA>
    <xmx:chWNZWEODGeEfUaFeFe4jQ_wPe_cp41n1a-jGmRHWEClGJM4K9GMaw>
    <xmx:chWNZZ_hX5V9h1NPFGUPjdt08ezxt-JMYkW-lwKz3J-frM0oSbEHyA>
    <xmx:chWNZYOQskPDc6HQGus9Z7PBrjj4RQFkx64CyXuxM6NVQlKOzmyu5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:28:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b37eb379 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:48 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:28:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] reftable/record: store "val2" hashes as static arrays
Message-ID: <c8a36917b12a0c32f49ed7632483ad1f37c9855c.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TBk4AbSwD6ZyAQXE"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--TBk4AbSwD6ZyAQXE
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


--TBk4AbSwD6ZyAQXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFW8ACgkQVbJhu7ck
PpQCchAAhzjCC2jnV+bPEhI4F5NZ8/V4ChNpxvLWhT6pr6btD3NdBKYJBbtlAO1T
+1Q2ln3dAWqPrLqEOEI5n3ZaOFtY9hdE2l6lLtyHNWP0n93/p8Fd+/kxtIroxCUc
jXsAA8uybRimrGVNcmNYWH8FjjDQdE5w4PdNlvBh3ZOPR8ydGm3yOyhd6DqzkF3o
mbiXENfpYAjYLYvsJKaZFbs1MClAMDC1hIIBcLzCwbNtiwowx1GkhJ/bE9f8kBKa
s2SahBfqfDPUMIlTjOdh5GENhYKR0pwgD4013D+g0PdKb/EZYdRs5ogt14Y1Chuw
WW9ALUOjJ80t2BLUFQhXEX0b1YBTyHxGaWCQYd8tDUBH06c1RtpY1+XWoim5Rlqr
+ZEXq+i+lsg2ix+AhriY5TPutnFYvAXXjFeKuxKba5NGOiaDpJSU42/KwOlVJyaP
ZLc6c31Hj6jnT0N23dRQzYejLzm0vJA9LAO0HRJXqsDTRbCL2ckt3sQ5saQC/DTq
G+SQzOHnPN/bUj67ixR1QhEnwwS04jEQPgWmhhpsLtHQq9jlnohTWJ/x+djowtmg
6iuufJXpc6fHZd2XIuH61ra4I7xPpXS0fvb8Gxjhg5KJgOX66DRk3+DlNz38zAv/
xqFpTV+bsrKLHlN2xJcBDxKW40Y0/bbuhTJPys3ydlz4MP3RuGw=
=UpQl
-----END PGP SIGNATURE-----

--TBk4AbSwD6ZyAQXE--
