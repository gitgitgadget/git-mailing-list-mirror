Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OYJWWmws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZOlT5rS"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8996B100
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:12 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A3DB93202728;
	Mon, 11 Dec 2023 04:08:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 04:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285691; x=1702372091; bh=jp
	/Yhc9QXyPlx+0Sedzvr6+U5MuE3ip3mgMoUgceSr0=; b=OYJWWmwsHvmp7gy5Ts
	046OgW89/CqxdVzWL/e+BzfMSukfCT5GJuseR6IxYlyenXP0Zg91att/71s1SxNB
	go2zw97XQnFMADvWQNaNw2j40VzDzayPxnx+OUSRopws5H2a/EcelxU4ZQp8WQX5
	NanV35FaCWkFvMnUgwc8/T9FI2IEu+rF4XmIj8Kvq0BH6R6VGD0cU4v6XRtp/gV9
	F2ETnYWgeW6tA1e8E9RyDS+LrPxjjj1U7x9ZclDSjBz/RJq/LEjq91368optmHP6
	h02otLy3dTx6BThBoDXcqFM9JsBoUaH9um2dOdemfcPUbdFXcH2kIMb4KdjucLmf
	yt8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285691; x=1702372091; bh=jp/Yhc9QXyPlx
	+0Sedzvr6+U5MuE3ip3mgMoUgceSr0=; b=HZOlT5rSA0R1lXDLmbVP8Cw+UvlU4
	jR2TtSET+Cud326FlGOvpNZxHeF+7FbIm+gZLXvk0GhXNebQXKcUPDfS3nATlD9W
	IMbg+9Vh66tPqPQUlR4i8y0qhB3ut15faJP3x5Vmcd+WMHIvvlRqUCH1dr4QEr4e
	Ni25xEvTJrijyVv/VG46xRUQuRjM7n16ysQc3KQ4ybLhKytJtJzx9k85TbCi6NIP
	YCEJ1qo98FigeZCQrM5zOsyRXWgJeZv6xAvTJXj8EOte8rBY4FIRnVqIsWMzEwMx
	6ZnFjEcr4pJmjC5xGXD3B/jkA5ev3FAVkp6zc8pHKfbW352xBV4L73ORw==
X-ME-Sender: <xms:etF2ZYAz9xNg1z8aWav4H0MnwYMe8wvtbQZIQs6PhUuRD3ClQOkjsw>
    <xme:etF2ZagJfFodAK_EhcsQ3ymexsIqFkwobRnew67TPlkbeJImEd6SqV-HSP0be5t7k
    DdmMVxze9_DHm3wog>
X-ME-Received: <xmr:etF2ZblkvYWDHuMj04VPiJBiYgRMOSgzr-XdsOp9ivq5ihYg7Roxui2_wQUq6I9CHUtezXWKo7Yhc0xeKNF2MQ2VCOKiukqkOx-7GXXbGvL2SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:e9F2ZeyEkadrq4Eb1LQP8WMasruqbd4dnl7yLRyUNOent0SzWGS3Iw>
    <xmx:e9F2ZdRkNYQ7JVwdGD9C8x9N6Ymo5MtwHeBpn3YTe-3ZmyJgZmAw-Q>
    <xmx:e9F2ZZYCqY-CkCNcMpuxgGIJiCDci78TpWZQeAX2qL532q9Fd4cB3g>
    <xmx:e9F2ZffkuuzV5XQ_Tfk56J1LGx_KII2JelYxS_12599Yg1h1DvY1MQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51867a61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:33 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/11] reftable/block: introduce macro to initialize
 `struct block_iter`
Message-ID: <8574ad7635614fcc64c23ac3bb464f460768c7f3.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MRc9tN2vkPQZE/4n"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--MRc9tN2vkPQZE/4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are a bunch of locations where we initialize members of `struct
block_iter`, which makes it harder than necessary to expand this struct
to have additional members. Unify the logic via a new `BLOCK_ITER_INIT`
macro that initializes all members.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c      | 4 +---
 reftable/block.h      | 4 ++++
 reftable/block_test.c | 4 ++--
 reftable/iter.h       | 8 ++++----
 reftable/reader.c     | 7 +++----
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 34d4d07369..8c6a8c77fc 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -389,9 +389,7 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 	struct reftable_record rec =3D reftable_new_record(block_reader_type(br));
 	struct strbuf key =3D STRBUF_INIT;
 	int err =3D 0;
-	struct block_iter next =3D {
-		.last_key =3D STRBUF_INIT,
-	};
+	struct block_iter next =3D BLOCK_ITER_INIT;
=20
 	int i =3D binsearch(br->restart_count, &restart_key_less, &args);
 	if (args.error) {
diff --git a/reftable/block.h b/reftable/block.h
index 87c77539b5..51699af233 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -86,6 +86,10 @@ struct block_iter {
 	struct strbuf last_key;
 };
=20
+#define BLOCK_ITER_INIT { \
+	.last_key =3D STRBUF_INIT, \
+}
+
 /* initializes a block reader. */
 int block_reader_init(struct block_reader *br, struct reftable_block *bl,
 		      uint32_t header_off, uint32_t table_block_size,
diff --git a/reftable/block_test.c b/reftable/block_test.c
index cb88af4a56..c00bbc8aed 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -32,7 +32,7 @@ static void test_block_read_write(void)
 	int i =3D 0;
 	int n;
 	struct block_reader br =3D { 0 };
-	struct block_iter it =3D { .last_key =3D STRBUF_INIT };
+	struct block_iter it =3D BLOCK_ITER_INIT;
 	int j =3D 0;
 	struct strbuf want =3D STRBUF_INIT;
=20
@@ -87,7 +87,7 @@ static void test_block_read_write(void)
 	block_iter_close(&it);
=20
 	for (i =3D 0; i < N; i++) {
-		struct block_iter it =3D { .last_key =3D STRBUF_INIT };
+		struct block_iter it =3D BLOCK_ITER_INIT;
 		strbuf_reset(&want);
 		strbuf_addstr(&want, names[i]);
=20
diff --git a/reftable/iter.h b/reftable/iter.h
index 09eb0cbfa5..47d67d84df 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -53,10 +53,10 @@ struct indexed_table_ref_iter {
 	int is_finished;
 };
=20
-#define INDEXED_TABLE_REF_ITER_INIT                                     \
-	{                                                               \
-		.cur =3D { .last_key =3D STRBUF_INIT }, .oid =3D STRBUF_INIT, \
-	}
+#define INDEXED_TABLE_REF_ITER_INIT { \
+	.cur =3D BLOCK_ITER_INIT, \
+	.oid =3D STRBUF_INIT, \
+}
=20
 void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 					  struct indexed_table_ref_iter *itr);
diff --git a/reftable/reader.c b/reftable/reader.c
index b4db23ce18..9de64f50b4 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -224,10 +224,9 @@ struct table_iter {
 	struct block_iter bi;
 	int is_finished;
 };
-#define TABLE_ITER_INIT                          \
-	{                                        \
-		.bi =3D {.last_key =3D STRBUF_INIT } \
-	}
+#define TABLE_ITER_INIT { \
+	.bi =3D BLOCK_ITER_INIT \
+}
=20
 static void table_iter_copy_from(struct table_iter *dest,
 				 struct table_iter *src)
--=20
2.43.0


--MRc9tN2vkPQZE/4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20XYACgkQVbJhu7ck
PpS5fxAAlOAVMCyLm/1OKCiUQt6RbbXCbRhnuy/lUPJis+3gFvWLpHVjlHJkA5h2
4XhfywsANnabEOdRWDUAazZYFuxsVlXju/Xz9FJPMQX0bpJn37SXjdtiVDL9UOJQ
c3KyJd7RJtBdxzDxL+f3B8ozeWa8i1oW1kZKY5L5Epa0nRxq4QJ9SePm79mz8gXC
VvF/VKJNY5ob4bhx7N6MhVjEIWynphXuRNJuyaD+MHQ7JiWvEdFfEW4VXlDshXJu
QVWqcttN1JV3qJ7P8326B50Y3eLZR0qxBXANLGRyFqQXc+6f/1C9AqbwevsLAJz5
E9t7x9QU5j+tWGGCOIzoJAagZeuK9Muq/fdSYmwahJMp0t+Zt7EFaEKFXC112wIK
U2rAGvR4rf+IPnlfsewNQLsWZVoy9+gVcRRkqiPu79ZAKFdnJIRDc1hkIrHRufij
bm52MIboR/xZSTPlQUq0VYKIU+gCfrpt7tx3dlXwgrC6XoEOdbIEAEs7QEGBiFkJ
aBH3yS3R7n69M9rVl421ERgw5GWNkry5LXZI+djJ853G/jOAwCObldQmbzJrG1tl
gCal4wHfZCD0s4xbctqcn/SKYuRpS3uGNWAIDW/YdKBhwMzXouwhUAJwc2sAIzkE
KQ+BlItz9kf8otEnHSMQj/ZqOpuLKPHzhYpWQdOJXA2F68W8PK0=
=6QfM
-----END PGP SIGNATURE-----

--MRc9tN2vkPQZE/4n--
