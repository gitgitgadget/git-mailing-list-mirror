Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255220313
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vW2M2PSf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zNf160MB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 229945C01E5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 04:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063840; x=1703150240; bh=nxEVCiPimo
	C99N6wAyN+qy66ywNRNCzXda2GpyTZNQw=; b=vW2M2PSfI16+IcpR9cHFZqbhYp
	sUe0O5261vdzz8+vgKS+GXth5ijbpIJ2+pC2zNMqDsiIJsFF1QNt6QjCKAOvn+TE
	yZaH5TyoClza6RrBBy98n+ieL1PLwqMw12AWOq/3NIipDcYGEqE5niSVzAsLqLMu
	mCUgUwb18QqziwuGoE+f5+kmr8bn4CLySN5ZmbSFyrNJZj/b8QPvkUo5G1F9l3GK
	b7I6zMfdszh3Nkm7PbgOFVX5PddAF7kDU1ZH/Bys+2kuuKROcKpbzvZnSUeBJu86
	lZVUwAutdda/BuSWt/3pTNisMq1UgTuqL6NqKVfVGID3/mzIMcR0Ki1fjDIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063840; x=1703150240; bh=nxEVCiPimoC99N6wAyN+qy66ywNR
	NCzXda2GpyTZNQw=; b=zNf160MBYdQytL+tmV4GygJh1gq87hpvMLHgsOV/zMW7
	9xEMiYx+q/hUYAzlo1VCvFzbUTkIVAucRAV1YhVMep3h8pcZP5tYYp+i/OKYI2qZ
	rDLxlnsecWZKtqUGZSXjjU54QKHcpUwrip2zOmb5sFfHdDE55H8tiQYe5W3aECo9
	hwxY9whOriF3QPMUsW02v6Wn8cxVIqziRB2MofGmihAmKv5W8AEVEBUmkBTr0ekG
	+SYwiblKXpRyQApGmCZKfXaPHrDSyTR856r0OGiNExOyzPCuHZAzJvbxKhqoEdi+
	2ZPEAovml2oLzvFyGSdm6cTz5lARPRt76ma1BCA+Yw==
X-ME-Sender: <xms:H7GCZYDg6YUfpf1dk5U8diCgq-ox_T46lC4vxZvu0y0XZ5h7cDfYKg>
    <xme:H7GCZaiyPWLAZWpG0VvSEYYbUwPWQkQw0MpMowhuT4ggaH15xNtlhGaCjoptfqohA
    Sh5YhMyuiG6e4hc3Q>
X-ME-Received: <xmr:H7GCZblZCJ2KteP8EtXK4hVqlhVoUVesiILL38fXVjc6o547STcB6N5RLoZwqJZqR6QoGqfdLAydaOaPLx8cL1G2iyXJ9RKjsqZLcjwrUKup3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ILGCZezVmcYGauyMOcWoZ5BRxR8kSir5ML9Xfg2cc9-6Xhi8wPb_6A>
    <xmx:ILGCZdThhd-ffemeFGyxmyX8qV6_EfPP4kdkOCfzlHzcz5vYr914ZA>
    <xmx:ILGCZZY7PP3uWShwLPHfeQ55huguds0-_xmf6qIpsD5KCC7bBDPVXQ>
    <xmx:ILGCZYOS9pXwqLnANbPtFaiHpSJqB7l3E195arHz1fZj5vq2_Ezolg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7aeaf71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:24 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] reftable/record: store "val1" hashes as static arrays
Message-ID: <06c9eab67802ba933b44d32f5c8d11fddc216c26.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyJkOnneEbbZ0lnu"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--xyJkOnneEbbZ0lnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading ref records of type "val1" we store its object ID in an
allocated array. This results in an additional allocation for every
single ref record we read, which is rather inefficient especially when
iterating over refs.

Refactor the code to instead use a static array of `GIT_MAX_RAWSZ`
bytes. While this means that `struct ref_record` is bigger now, we
typically do not store all refs in an array anyway and instead only
handle a limited number of records at the same point in time.

Using `git show-ref --quiet` in a repository with ~350k refs this leads
to a significant drop in allocations. Before:

    HEAP SUMMARY:
        in use at exit: 21,098 bytes in 192 blocks
      total heap usage: 2,116,683 allocs, 2,116,491 frees, 76,098,060 bytes=
 allocated

After:

    HEAP SUMMARY:
        in use at exit: 21,098 bytes in 192 blocks
      total heap usage: 1,419,031 allocs, 1,418,839 frees, 62,145,036 bytes=
 allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block_test.c      |  4 +---
 reftable/merged_test.c     | 16 ++++++----------
 reftable/readwrite_test.c  | 11 +++--------
 reftable/record.c          |  3 ---
 reftable/record_test.c     |  1 -
 reftable/reftable-record.h |  2 +-
 reftable/stack_test.c      |  2 --
 7 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/reftable/block_test.c b/reftable/block_test.c
index c00bbc8aed..dedb05c7d8 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -49,13 +49,11 @@ static void test_block_read_write(void)
=20
 	for (i =3D 0; i < N; i++) {
 		char name[100];
-		uint8_t hash[GIT_SHA1_RAWSZ];
 		snprintf(name, sizeof(name), "branch%02d", i);
-		memset(hash, i, sizeof(hash));
=20
 		rec.u.ref.refname =3D name;
 		rec.u.ref.value_type =3D REFTABLE_REF_VAL1;
-		rec.u.ref.value.val1 =3D hash;
+		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
=20
 		names[i] =3D xstrdup(name);
 		n =3D block_writer_add(&bw, &rec);
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index d08c16abef..b3927a5d73 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -123,13 +123,11 @@ static void readers_destroy(struct reftable_reader **=
readers, size_t n)
=20
 static void test_merged_between(void)
 {
-	uint8_t hash1[GIT_SHA1_RAWSZ] =3D { 1, 2, 3, 0 };
-
 	struct reftable_ref_record r1[] =3D { {
 		.refname =3D "b",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
-		.value.val1 =3D hash1,
+		.value.val1 =3D { 1, 2, 3, 0 },
 	} };
 	struct reftable_ref_record r2[] =3D { {
 		.refname =3D "a",
@@ -165,26 +163,24 @@ static void test_merged_between(void)
=20
 static void test_merged(void)
 {
-	uint8_t hash1[GIT_SHA1_RAWSZ] =3D { 1 };
-	uint8_t hash2[GIT_SHA1_RAWSZ] =3D { 2 };
 	struct reftable_ref_record r1[] =3D {
 		{
 			.refname =3D "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash1,
+			.value.val1 =3D { 1 },
 		},
 		{
 			.refname =3D "b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash1,
+			.value.val1 =3D { 1 },
 		},
 		{
 			.refname =3D "c",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash1,
+			.value.val1 =3D { 1 },
 		}
 	};
 	struct reftable_ref_record r2[] =3D { {
@@ -197,13 +193,13 @@ static void test_merged(void)
 			.refname =3D "c",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash2,
+			.value.val1 =3D { 2 },
 		},
 		{
 			.refname =3D "d",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash1,
+			.value.val1 =3D { 1 },
 		},
 	};
=20
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 9c16e0504e..56c0b4db5d 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -60,18 +60,15 @@ static void write_table(char ***names, struct strbuf *b=
uf, int N,
 	*names =3D reftable_calloc(sizeof(char *) * (N + 1));
 	reftable_writer_set_limits(w, update_index, update_index);
 	for (i =3D 0; i < N; i++) {
-		uint8_t hash[GIT_SHA256_RAWSZ] =3D { 0 };
 		char name[100];
 		int n;
=20
-		set_test_hash(hash, i);
-
 		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
=20
 		ref.refname =3D name;
 		ref.update_index =3D update_index;
 		ref.value_type =3D REFTABLE_REF_VAL1;
-		ref.value.val1 =3D hash;
+		set_test_hash(ref.value.val1, i);
 		(*names)[i] =3D xstrdup(name);
=20
 		n =3D reftable_writer_add_ref(w, &ref);
@@ -675,11 +672,10 @@ static void test_write_object_id_min_length(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &buf, &opts);
-	uint8_t hash[GIT_SHA1_RAWSZ] =3D {42};
 	struct reftable_ref_record ref =3D {
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
-		.value.val1 =3D hash,
+		.value.val1 =3D {42},
 	};
 	int err;
 	int i;
@@ -711,11 +707,10 @@ static void test_write_object_id_length(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &buf, &opts);
-	uint8_t hash[GIT_SHA1_RAWSZ] =3D {42};
 	struct reftable_ref_record ref =3D {
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
-		.value.val1 =3D hash,
+		.value.val1 =3D {42},
 	};
 	int err;
 	int i;
diff --git a/reftable/record.c b/reftable/record.c
index 5e258c734b..a67a6b4d8a 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -219,7 +219,6 @@ static void reftable_ref_record_copy_from(void *rec, co=
nst void *src_rec,
 	case REFTABLE_REF_DELETION:
 		break;
 	case REFTABLE_REF_VAL1:
-		ref->value.val1 =3D reftable_malloc(hash_size);
 		memcpy(ref->value.val1, src->value.val1, hash_size);
 		break;
 	case REFTABLE_REF_VAL2:
@@ -303,7 +302,6 @@ void reftable_ref_record_release(struct reftable_ref_re=
cord *ref)
 		reftable_free(ref->value.val2.value);
 		break;
 	case REFTABLE_REF_VAL1:
-		reftable_free(ref->value.val1);
 		break;
 	case REFTABLE_REF_DELETION:
 		break;
@@ -394,7 +392,6 @@ static int reftable_ref_record_decode(void *rec, struct=
 strbuf key,
 			return -1;
 		}
=20
-		r->value.val1 =3D reftable_malloc(hash_size);
 		memcpy(r->value.val1, in.buf, hash_size);
 		string_view_consume(&in, hash_size);
 		break;
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 70ae78feca..5c94d26e35 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -119,7 +119,6 @@ static void test_reftable_ref_record_roundtrip(void)
 		case REFTABLE_REF_DELETION:
 			break;
 		case REFTABLE_REF_VAL1:
-			in.u.ref.value.val1 =3D reftable_malloc(GIT_SHA1_RAWSZ);
 			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index f7eb2d6015..44b5125445 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -38,7 +38,7 @@ struct reftable_ref_record {
 #define REFTABLE_NR_REF_VALUETYPES 4
 	} value_type;
 	union {
-		uint8_t *val1; /* malloced hash. */
+		unsigned char val1[GIT_MAX_RAWSZ];
 		struct {
 			uint8_t *value; /* first value, malloced hash  */
 			uint8_t *target_value; /* second value, malloced hash */
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 14a3fc11ee..feab49d7f7 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -463,7 +463,6 @@ static void test_reftable_stack_add(void)
 		refs[i].refname =3D xstrdup(buf);
 		refs[i].update_index =3D i + 1;
 		refs[i].value_type =3D REFTABLE_REF_VAL1;
-		refs[i].value.val1 =3D reftable_malloc(GIT_SHA1_RAWSZ);
 		set_test_hash(refs[i].value.val1, i);
=20
 		logs[i].refname =3D xstrdup(buf);
@@ -600,7 +599,6 @@ static void test_reftable_stack_tombstone(void)
 		refs[i].update_index =3D i + 1;
 		if (i % 2 =3D=3D 0) {
 			refs[i].value_type =3D REFTABLE_REF_VAL1;
-			refs[i].value.val1 =3D reftable_malloc(GIT_SHA1_RAWSZ);
 			set_test_hash(refs[i].value.val1, i);
 		}
=20
--=20
2.43.GIT


--xyJkOnneEbbZ0lnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsRwACgkQVbJhu7ck
PpRB2A/7B7W2BrNqG1BjazLUO3fyUmE35t+nsRfIxsRHMmjMIQL0Adk6uUxIYT1S
5g0dmiKKNqxqzl/YadIB+a6zFjRudkyPCt7pD5HDp8fXnVrqDLPDRUaS1Wid4I0I
iKY5HaAMyhBzr7dVkQp2dH7NHAyV1HKq+KjUbVUQNJX9f0c1G+ZqrOT8E66Q6zCi
fNPQdNIKb4VJUndIh3LocMY89ZDHbcyRSAQUiBpXlSSCviS+VMCJ8WkIYtU31d95
5NqAopR7U2NJO6ROg5ufXYjnh+ZCP6jivgx3xDm+gMjTM6P0wVVH0VIz1tUFYdM9
lF68oRNb8qj5HeeslzdCEL/y4zHJa1H1w3J9uUJ2ABdSB0kCjiryE3QzZQInjJ7W
1UVP8ZMXkrYHp63ZGpozyFU7GCYeKSFfhGJW3KBt0vuOxrGaXtMsFJcuFPaGiYo9
T3dFaqEP8R4xsTjnBw059An7lMBteCKYwKO9rU/HtRsbicwi1qPjouUmXfT7S84Z
ebjhfqGmNjEXWEnnaq3S1RQ2bLyZkPlA6Y3WItzNBhlLY64PCJn7CZRAUeMHyfaB
t0Dqwh4LFQq30VHBLS15txyWFtQ4fE4oSFH4lJUZSlFXLo9rNPvMRu1lmyPHzzJR
0TzEiawLU+Mrtlw1VQJ/OLWgqtMWT5hqxVKDqJrnYIemaeIrCt0=
=EYW2
-----END PGP SIGNATURE-----

--xyJkOnneEbbZ0lnu--
