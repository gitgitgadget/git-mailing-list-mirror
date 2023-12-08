Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GQsrfgFw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdNxEhDQ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886A2115
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:40 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A6BED3200A2F;
	Fri,  8 Dec 2023 09:53:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 08 Dec 2023 09:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047219; x=1702133619; bh=0s
	FTJ9aXTpCWq74275Rcgq/s/ZG9uvwafIGo3u7CVP8=; b=GQsrfgFw7oMuV8tTif
	ppKOAOojLSenkHhDlCFp51cfIgQ6Z/w5LjLN47nf+oJ3o35mh2xMKzmng+YNBGLm
	Rz7wulEOSlhOQCyPjGaPJCSOKU5eYs75pNSk7qFh+Xtrd5sp9L4BcP1h1iyTq2GI
	hLw28dtS9Z5e9hKjm0KGDpcswDxiiYyEswNCcqgmrF84FFNh/vpxLovxVwqlSF9V
	bWx8YNhXib4iINzGez23DZBUg7RFPNUVZogTLQQRfAc3e0P9x9uIUmCjFi3z1cA2
	Fm2Ar8gU7hlILehgHvxLuu13sCZqzkU+vPx8/LPiOcxRjIsseI3AfrD0kCiJCTaa
	2ftg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047219; x=1702133619; bh=0sFTJ9aXTpCWq
	74275Rcgq/s/ZG9uvwafIGo3u7CVP8=; b=tdNxEhDQRBQri3W1Oyqcd90keNbJR
	uqI3fD5f7xwmog8FZFNx1oryZ0pY0VA0k/ObvxTQD+PYDtFrVUX3MpYjxHL2qTZ7
	XFyBoG7lpdLW8SRPmoGl9ydWxc9xJphuFFe4pUyqdRdMnbNWEbVp5eNvrfeO0VJB
	r4MwdM2981QapZRLyA2rWEzinpIAoBrO9TzESs1eOrvixcKEyV81QOAjpmW75rDk
	jqCzHbWXBtk0nHaTwuM11nfaob9DihGA7etL0ftdNoE7Y4H/tvw7k2pT1U+ePDxo
	iD4qAhchnFcoEnekojeIwt5UIURIq26mi1lx8ghKlj8BIcHpwwc3Ol8+A==
X-ME-Sender: <xms:8y1zZQs7YGchtc8ZUNb9Jb2HPSRVK6t__VAKQYam5-Hw7Lv8LnDd6g>
    <xme:8y1zZdchH7mWbnWWSGgKTaHPQG-RkUYLQrv1i0zlubyg972Aw__LRn_aQMQ-cBrgl
    jEuTMqXEHr7bJRXJA>
X-ME-Received: <xmr:8y1zZbzqPGZNYmE6w7anTS4U4mL3Er-zMe94G31JX4sxqmKsR_s9RVS6e36FZSNmCXPAYghqw5ZUlZGekc2Q83aw961b7Ch3gC-fguHw_4AmEe0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8y1zZTNGCPWjC5w6O7l8zHePtUjEJAEr8m8mYvmoEjyoStlfPxOW7g>
    <xmx:8y1zZQ963_CEzgonh2QXU5N976lIwoGKhLXumJkdiVwAR9BhMYbVag>
    <xmx:8y1zZbUOi1_3Sj2w41BGN4XNVIuPjPPhfqJVV_grod_-Zw5pJ-F4BQ>
    <xmx:8y1zZenEYKdxZZ1e5e1p3zMYELTZ2Z8sddUMnVvnEQdTPRoZ9tOaDg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da07f292 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:52:07 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 10/11] reftable/block: introduce macro to initialize
 `struct block_iter`
Message-ID: <c9a1405a9a1311d21a20c041b105681411660591.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AVvuokDSM8H9SICh"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--AVvuokDSM8H9SICh
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


--AVvuokDSM8H9SICh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLe4ACgkQVbJhu7ck
PpTGIQ/+MFuxzRi0vD5Lv2nu+aVGGrBrSIR61R7Da4AnfFrjtUnO8ZO+IP6lJdGE
10ME+u5e2XaZuCY+pK+RR4HK7+VZQjFlrrC9r49yts7e/oT3fSZW0ZeLh7FGKQaJ
CnPcfPUHPJmqxc6LoPRe0Qi66dunoo30xMo+PWf051XN/Nml0mlcKVvD946mZtKD
fpYTF+9vIgoVAYr1VQT4P0Gt6MXEO9VwkB25vfKIwwWHqK6mytEHoy5O2gl9vcPE
U4PZSYgQLAKh5bClYpzJ6PsBVIdSL1ca+rsyUJBu8ZbG9bYllmdV7RjgU3dFaPJs
tkrQ+T+gWrzm3hRzieUP1CPIPX3bnl3cDa6RTAKuehiRJ1OnG8EY5/T2RV0/vKGP
J2yeC712/pqmMhJFntn7B9+U/UAcNIdcIFXyBGMiO+iokJqEG33MsfG6D6QPL9ju
5peEQaO69gqQP4pSFbfU1b4AgZPNgrtdKglTiKeVDxL9EInr5I/m6jX7USCwcK8m
IWMICB3N1QnB7cDpybGmWeklKoEEvs2htrvlSF1c7TKBwdFi2z5ms7e8EPvrIcKB
RbDINoifdjeEBh5ux5rbDCGunqwrXD0Za7NmpXnnqa3SKm5BQKKqjORKe5ooO9eT
xxvl3TcUbbAWcL8L5I2/kNsV3hlzjlLsOwX9F0BuSljjWFj72to=
=MiDd
-----END PGP SIGNATURE-----

--AVvuokDSM8H9SICh--
