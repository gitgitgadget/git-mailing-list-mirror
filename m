Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D4290C
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IoDOJQGG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHe2Y38d"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8037D5C003B;
	Thu, 28 Dec 2023 01:27:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 01:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744878; x=1703831278; bh=qAfDHJQn2k
	go1EhXsu9jE6rmR6AVxd/n9CUBhtAXo64=; b=IoDOJQGGVfdt0AA1gHdFaPTGpS
	dGTPbgOrbhDmjrA7/EXI2LWk5XEsRLgbDzrL70MtLhIKyjowhFGavYe8jJUidhLD
	5GUSf6PsvnifGwyDH9ZBxZ8NQHnH25BNQk928+BjuXJz4nCsUgLUJxCEaKUjO31a
	U0gSFsXhyspRmJuxOFjTPZF7ENX5cO6ObbKOl6fhpR72U0k/+vXk/299YkfvdmIo
	vpPIoQ6HEKOYOTktWCVUC3YoOwDP8884OV1U0xUHGzbfCRi9FAQ9pSzfdJkmJPxg
	ijBfqZrdqkckgnyHakGWDKtRvV3gPKGDgLQpZLwjdx7VtmnHwhhVZ2l1KYFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744878; x=1703831278; bh=qAfDHJQn2kgo1EhXsu9jE6rmR6AV
	xd/n9CUBhtAXo64=; b=RHe2Y38dT3yqOSaKc7GgHoRF8qE3+gFi7tcR7NURYPU3
	R/vVF+UyOFGZYQxjUC6NA5rz5PwXD9s/4hENpbNKujdzCCFP4MwWpL24Cb3RF0FT
	RaVo9QokvQSpPpU05pp6zr/Hjgr0JdbQIb6zPBF9db4rynoa0g4m7nD6XrshspN3
	DKPz2v9GgAzKeGjbA7c4ahZQSWsdEMHKuNn5KuB80dBw3oT2YpVU/FuPlyKVUcX0
	RZpyRUy5lkfgu2xu9g7BLf3xrHZ/jOSjT8RADCvHPZHlDily7y3fT7SUCFPr592X
	VhrJFUSHBwKoAG2c4Eb9jLgaIAitZYjNRNexTPPBmA==
X-ME-Sender: <xms:bhWNZSBORPCgYUWjiIRywbUyY8gHm_t9XDG4p_7lR7f5c3Sc48ctpQ>
    <xme:bhWNZcgfvLiMAmACRaYuYJ1bow4aBRPZuaNnMnJxPBafAONz9TAxycZM3cr5F_9Ft
    kCdZxBFUkF6TTiQog>
X-ME-Received: <xmr:bhWNZVmQZ2DrePqZ1fXiIeZj0m7qnrm_-LNjOcXgVHxodUeVUiGxfug7TRQUVDRM8PqYoCBhBj8xe2jWFhEGgjR6foEWVobSlgK99gm44eziLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bhWNZQzYt5ygIOAI_RO7jCSVZR4e7NLoBLaT4gJgfDPJUz5x1ncYYw>
    <xmx:bhWNZXSJtbW2FZIT00QjPV7PP_qB880WmRRW_XycUdMM00EvaPljIQ>
    <xmx:bhWNZbZaoEd8-jIA2h3YGMOfo1p2SfFQx3D-CBU6vOMe7p1TGmI5Qg>
    <xmx:bhWNZeJY9Stse3LpMVJTsOzHuepxmddgLelNTUngVwNy8zy2SQKO9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:27:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a750066 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:43 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:27:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] reftable/record: store "val1" hashes as static arrays
Message-ID: <46ca3a37f805cd36faa26927220c2793d4cdd561.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jEajSqJq+BhVHX/p"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--jEajSqJq+BhVHX/p
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
 reftable/readwrite_test.c  | 14 ++++----------
 reftable/record.c          |  3 ---
 reftable/record_test.c     |  1 -
 reftable/reftable-record.h |  3 ++-
 reftable/stack_test.c      |  2 --
 7 files changed, 13 insertions(+), 30 deletions(-)

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
index 9c16e0504e..87b238105c 100644
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
@@ -814,11 +809,10 @@ static void test_write_multiple_indices(void)
 	writer =3D reftable_new_writer(&strbuf_add_void, &writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i =3D 0; i < 100; i++) {
-		unsigned char hash[GIT_SHA1_RAWSZ] =3D {i};
 		struct reftable_ref_record ref =3D {
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash,
+			.value.val1 =3D {i},
 		};
=20
 		strbuf_reset(&buf);
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
index f7eb2d6015..7f3a0df635 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_RECORD_H
 #define REFTABLE_RECORD_H
=20
+#include "hash-ll.h"
 #include <stdint.h>
=20
 /*
@@ -38,7 +39,7 @@ struct reftable_ref_record {
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


--jEajSqJq+BhVHX/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFWoACgkQVbJhu7ck
PpT3Gg//Su+3T3c2Bi9D1oYtOxHsyrYYnjhRXzFRqViq6jk10A5YjAuLKsp/xe+x
CzzSp23nzK8PBN49CS6PvBCoyouAtBeL7CyiI06TS23WiY+QlWmeVPX+GlTt4bkj
8gEA3bNeqNcp7wFxtaOudFMff9hk4A6SPQEKVTBXkX0qQC6XuWq1UNd36iqdc+cT
9wJkUHU+Y8JNHbKpt5GjQrDUuCqUEsRkpGQgDaVRQ9o4/VxRdxlZfTlz3PqCl1X5
tqy7vFKd+9t7tVgrQrtEvQ0G0pJ+R/FPsFhHVvbcda6snz/vCV1bggxHoX3apXpg
/pQ7F4y5RXeAH5OCYGXpFRT8uEgHomOzFIT0DiicjPTwvEbZZwDG1BTydIo0wH3p
BgT+yFR/cM4WbpiJ8mU3fq29u4qOORtKz0EB7OcpgZ0Gd6xg7tv6rcL1aWRvvsBV
RW3cKDL1hSjnAT+xr9e/jfXYA8q4+KnZ/SSAB+t6MsFne/VRPHlbrbs3G9BgTBnk
xyxqXGGJV8t0vE6Q4q88H7P6yDlhiy2czOc3sLn9npG27BXLTss18wZV6kJQ1mYh
vs9W7xDjjvXO4LqlApTrHU+VY6HV3RXTU52DprO/MGs+LRAqrg0rL12ExZq6wMcg
FCH4dQop63oBMEL2O+tsChQ6wRkCayVRiT8DGlpYDOGihOCPknI=
=riGE
-----END PGP SIGNATURE-----

--jEajSqJq+BhVHX/p--
