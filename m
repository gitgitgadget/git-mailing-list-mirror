Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1318623
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G5dnpLtO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkOx1Gqp"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4F5285C01E8;
	Wed,  3 Jan 2024 01:22:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 01:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262953; x=1704349353; bh=GUCInya8GL
	9eLoSa0aP3KhiheroH7P//W+4lLi/5Hug=; b=G5dnpLtOGK63kvDG9sMf5Dpifg
	rkk/ZmyUWp2IspckUMT54pNyt7vXMGUFR3qCWIk89yy+ebhsMzC+HGJrpDqaw6vJ
	o65bmRWjiUa2pwu2m+7lj8I2iyYkEFE+CuPr/n11gIkuVugLzW3Y2aM+UkQoL+6w
	G09waHns4SjyJqlibp87acroatHwIKmkz9cmKDB/7OSBpZYey9Jc0tHMUnSdBwDt
	tv97UV5o+Ho839T//0DBy4n8O+OnPGJpYR2e3irIgvkOgoDIxEpgcQSf3K2TrpC3
	gkFESdpAhmLl8y2KqurvKCmj3cVcNcjYwoHYs9EClD7vLnPXidlNIVdd+SqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262953; x=1704349353; bh=GUCInya8GL9eLoSa0aP3KhiheroH
	7P//W+4lLi/5Hug=; b=EkOx1GqpDe1PyzIVHY9gs6E96afdpKQGkWfXq6YPCIDm
	wNU51Wi3Ft8nPBU1z4u+1hoo9SJwEZWY779WCthNmijZRpqCJXsPH16Nal+F79d+
	6INfzwSkNdeM3ISYzjLLoHvkf9YmU+wcMZP+3CTx7dfGw42U6xH+/nbLZXEtXhow
	5RQx+/QmjAx8lc04PTlb5hWUhRojldpAtjxgkm81DxZSJ71XlbqY3zzqqkKnEHJA
	k15XMc9+3ZwJkaydWdXnv7evj7Ia6GXFHvcACNrsYkAE9GU4pjU6XKbLQTvjwUV4
	b8UuCCSmpI4BMlc69pwPfW1nC4X6o8PBkxGJRRT94g==
X-ME-Sender: <xms:Kf2UZa2ZyBrfVJokJmihbKWBerGCHOxsEVo0RptAIJ8lt1jn8GHRYw>
    <xme:Kf2UZdH47Jo0xC3vsPEJGiHOfhYuoAYlf1S_ukKkix7xEkZ0mfwFpXCWtayRf27Qa
    YTf1UgreLIesfC68w>
X-ME-Received: <xmr:Kf2UZS4PfnQBNEfR92Y4L5zqIcGBiUk5nxQoANxeIRhMpRX3tE_eawGDuzob04EUj2bqHMMDJkQf7I91ntFyo7K2cIquNUvXFgqhLXzjwaa1lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Kf2UZb02mwLgzrYgRDe-rWw0evDJWgrH7Bjzq4fcB842V7MYHIoznQ>
    <xmx:Kf2UZdHgwyeSUxNMachyhNQeRRG5slYSbpqXh5igXyUYGMHyUu8G0g>
    <xmx:Kf2UZU8b9enq0iy_3Ql0fTVD0UaxxeRgReIRpIWgz-xPNhCxxmYhOA>
    <xmx:Kf2UZbN8qSQHBoPHvcD_aWvFxYSn91pa88hLYwUyEoZ9AzTr9KJN0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f8fbf91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:20:06 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] reftable/record: store "val1" hashes as static arrays
Message-ID: <f1d21904892153c74d22e4fc814aedfafcb28f41.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XmClC7KlR/yCjzcN"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--XmClC7KlR/yCjzcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading ref records of type "val1", we store its object ID in an
allocated array. This results in an additional allocation for every
single ref record we read, which is rather inefficient especially when
iterating over refs.

Refactor the code to instead use an embedded array of `GIT_MAX_RAWSZ`
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


--XmClC7KlR/yCjzcN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/SUACgkQVbJhu7ck
PpR4eBAAmczVkAwl72/L7aX8RU8jbASQKHrbRgi4tjileera/bL+2V44qIy6Proq
RuU3tebltflv/jhgjjwe+hVsHZD39vKQHjijOKddiu+wukaY1RVE76PHoGT3XFce
11zF52OaXQOevecttBBuUTLEjxYaZSgB4QCtSvmnHc6yQfzxd6q8tUaMeKXPFJFS
MIXvyGuqkh1wcGoIPyXwms7GLwt/WeMle/i/XRkQM1GhOKnZrLn7KSL9MP/l4lcc
6mlOFp4nVeXUmp8DDrM53PgikXJtY15uw+5/KDDKn1jFYoEDWNQZTN6Un8sDd64X
ur3B/iPW0d2zOL7G08Q3wN74a8sHn8FgsB9FHlM24tUnV5rfMW9AbNjM+8d4lRyo
26gSO0IuL8S/abTeZkeXaSlH54+76/oE+LVCmHZF3XQ9OA6199hWhPkRujDo6uut
MyiCfEzK+DeIxiKzmr2ar1KS0M56ZTKFoiQFRrWfhg9VRd6Y4zYymPR5ykkC0gVG
MhdweMReysTAkkISp4SdZQNDohtKofE4uAXoZplnomgyT0+H7XVbOxHfvIyJEHk+
vZodZdguB/y+Lycdh+Tep9H02jb2Xv0stXtSa/l93NskE9QM3ZrrxN/oK5OcQI75
7FTvnvsC999hOVLcByAAoJVgX2e+6jomS3mjWmtW5AD+n5y/Hak=
=rpaS
-----END PGP SIGNATURE-----

--XmClC7KlR/yCjzcN--
