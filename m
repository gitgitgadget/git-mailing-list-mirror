Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1ut0xgV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqasaEwF"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11813EB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:16 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 239A43202738;
	Mon, 11 Dec 2023 04:08:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 04:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285694; x=1702372094; bh=GV
	ycWQ8hCxswlDagTpg3H6ecLfcmhkzitmNJa9fGJ4U=; b=O1ut0xgVlHRQ+1IYIR
	iUJDDdOMonsx5LicQN+xqr4hBPtRq4JJ5Nj8iTVAart1jCabShduhydTZpMFuihl
	dLR1u0vA1i74DhXLkzg1HrfI1v2F6BdFnqW4v+I3MfzY09UwtM5n5x5i/ViQ6tld
	YFpv83cP3oDUPKejWC5oa0MdzvByDQvb7lI7y2RbGLLqalk3FZCsr4SBZ18kLa70
	jTlDruLvNFZaIbX3PpR7zAIzkouVbAugX7jjSYbVym9BiyFGMQ4p4FDvRZpM8Rvw
	QnztNl56kTD/WEDQ9pBkliVJQ7xOj2kyBli8mBXr3p/MNcsQk9FcWH+Nw1P7gj1X
	0J4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285694; x=1702372094; bh=GVycWQ8hCxswl
	DagTpg3H6ecLfcmhkzitmNJa9fGJ4U=; b=PqasaEwFRKjmDyQIjxR8djRdhzsKd
	cPP6JbS7R6v5N+sop8qf1wFXWGuUycDJgwjjsoUcj1YJgLrdkDQPgCEgORfMtCaI
	ICvgnavQoYVFPOrlnOelbg5xxO34jvBLdK6B9OGEQ/jxaOHrQo92ueaiJZ8SbXuq
	xKOl7pCSKb26e52vFCeu/LjWwp2djoGXSTHlFmtRGPF42+7pIEczjvaYiJBOoLxY
	ZZwotbQG6GEK03GvGWO/CkqCUQ6N/zQ031Bv1UJ8a46zKas2VcCB9y2VyoMT1vxn
	f7kwJ8RVH9+VYqPmIaSTDgSh1MNe/zPxXxj2A+LrHoCnf5vv1+6mH/Gqw==
X-ME-Sender: <xms:ftF2ZdFlsgpXJhv7HI6bdzugdv1d14C_IgZDtn_nxEOffayKD193mA>
    <xme:ftF2ZSU8ETjZILCZeyfstOTtuj-kq-S9sJNiaKdjQ4sYrtEa7UQofQoP3d1PvmdUS
    Pio-NNDGulhNxdiug>
X-ME-Received: <xmr:ftF2ZfIx3NpCN3y0k1eKHKoPgU7V0jdxqQg8A_Gub34zSvd_2l07F23hzmSIL1mekPTD0IAAkzFYHxw3CN6kGi3zqIvJbZFgFohSdquDUJLfVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ftF2ZTEcnDDFDi-qrKXwp7PQuYCQ9uuHxkpRQ9v5o5SuBdpqqxUU-A>
    <xmx:ftF2ZTXLO6uLL3YMxgR85PgcilNnFXIR9h4T1zrzlKy9BwZPq6CMzQ>
    <xmx:ftF2ZeO_yWxDJi7GO5OpCmUloc7LNaeQAMAT4zKioKm9k_VaF7KIYQ>
    <xmx:ftF2ZeQep_KYWXO17zKQXb1z6GNlLvNoeCjHWgNYasw4vNQfhRlo3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c27f6fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:37 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/11] reftable/block: reuse buffer to compute record keys
Message-ID: <eeb6c358231a2cc0647ca44ea3161a32a06157b9.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BDlmsFz8BseLtAXq"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--BDlmsFz8BseLtAXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over entries in the block iterator we compute the key of
each of the entries and write it into a buffer. We do not reuse the
buffer though and thus re-allocate it on every iteration, which is
wasteful.

Refactor the code to reuse the buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 19 ++++++++-----------
 reftable/block.h |  2 ++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8c6a8c77fc..1df3d8a0f0 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -323,30 +323,28 @@ int block_iter_next(struct block_iter *it, struct ref=
table_record *rec)
 		.len =3D it->br->block_len - it->next_off,
 	};
 	struct string_view start =3D in;
-	struct strbuf key =3D STRBUF_INIT;
 	uint8_t extra =3D 0;
 	int n =3D 0;
=20
 	if (it->next_off >=3D it->br->block_len)
 		return 1;
=20
-	n =3D reftable_decode_key(&key, &extra, it->last_key, in);
+	n =3D reftable_decode_key(&it->key, &extra, it->last_key, in);
 	if (n < 0)
 		return -1;
=20
-	if (!key.len)
+	if (!it->key.len)
 		return REFTABLE_FORMAT_ERROR;
=20
 	string_view_consume(&in, n);
-	n =3D reftable_record_decode(rec, key, extra, in, it->br->hash_size);
+	n =3D reftable_record_decode(rec, it->key, extra, in, it->br->hash_size);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
=20
 	strbuf_reset(&it->last_key);
-	strbuf_addbuf(&it->last_key, &key);
+	strbuf_addbuf(&it->last_key, &it->key);
 	it->next_off +=3D start.len - in.len;
-	strbuf_release(&key);
 	return 0;
 }
=20
@@ -377,6 +375,7 @@ int block_iter_seek(struct block_iter *it, struct strbu=
f *want)
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
+	strbuf_release(&it->key);
 }
=20
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
@@ -387,7 +386,6 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 		.r =3D br,
 	};
 	struct reftable_record rec =3D reftable_new_record(block_reader_type(br));
-	struct strbuf key =3D STRBUF_INIT;
 	int err =3D 0;
 	struct block_iter next =3D BLOCK_ITER_INIT;
=20
@@ -414,8 +412,8 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 		if (err < 0)
 			goto done;
=20
-		reftable_record_key(&rec, &key);
-		if (err > 0 || strbuf_cmp(&key, want) >=3D 0) {
+		reftable_record_key(&rec, &it->key);
+		if (err > 0 || strbuf_cmp(&it->key, want) >=3D 0) {
 			err =3D 0;
 			goto done;
 		}
@@ -424,8 +422,7 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 	}
=20
 done:
-	strbuf_release(&key);
-	strbuf_release(&next.last_key);
+	block_iter_close(&next);
 	reftable_record_release(&rec);
=20
 	return err;
diff --git a/reftable/block.h b/reftable/block.h
index 51699af233..17481e6331 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -84,10 +84,12 @@ struct block_iter {
=20
 	/* key for last entry we read. */
 	struct strbuf last_key;
+	struct strbuf key;
 };
=20
 #define BLOCK_ITER_INIT { \
 	.last_key =3D STRBUF_INIT, \
+	.key =3D STRBUF_INIT, \
 }
=20
 /* initializes a block reader. */
--=20
2.43.0


--BDlmsFz8BseLtAXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20XsACgkQVbJhu7ck
PpQYfQ/+PoZLg4OPDYeCDoLFsbSHpdI3NdcuQTT9NnFkpduvq/IirdVli06xuB+i
NzgeckZnn307eijN9aYm+UCcq0gTrKbLNXqg02ZBSfjmc/yD5XtfevszMtnvVgsA
+YAYTNc+PphO/XB/eLzBhIKt8emmdKLA89hda3fgrQpXk1uxUjV9UAsfg1jO7roJ
V3DqP87MlWn/m/i4E6DbJaVAfPu0i/Pt4YmYm5RYWkcdQNK1gX5s3WlSwWBv8Zix
+mqU6p5Do7eZXln7cKrYtGlqmDrE93QfokOeILqIks2QOScybXw/yMna8z1C60yD
PJnG7DQGfhQ0+3yp9IkYW/+dHJLl0y/+RAK+GHwQ/dhy1y52iLb0Y7z6c4VXf3tF
dDg2O8ZMGyFRG5JqODQfjNEyNOJSTXhsVixXSIooF+5HVDFvvNgI9LhggeftBL+q
uH99gSdkF1aab3Dv4cnJMoczwK+B/D7o1rFX4xfGc8Nm2wPiND64YiztI6v+lMJY
Mt4ejNvTvDpUZFjYWcnyO5/SNzTAvfm5WAFrjhY4xxFhpTjdLNnzGY4RfTeS1XWF
n75osqmu47fWwf4yWpmtwvyBK4xO9p9BSuK6DBSXxVD743wNGHqsfi1APqGLg8KZ
sAj6MIIZSMP4oEJWyiB5v7S3N2z703BqRhRU45SDGkdLjXBYsXQ=
=VaB1
-----END PGP SIGNATURE-----

--BDlmsFz8BseLtAXq--
