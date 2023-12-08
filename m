Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UfpFUwk5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU0vdZIL"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386964ED9
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:11 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 549B03200A01;
	Fri,  8 Dec 2023 09:53:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 08 Dec 2023 09:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047188; x=1702133588; bh=9L
	LqehmDLTPnmdpLWFmrwJ3o8akTNT9TXYtBI0QXN7M=; b=UfpFUwk5CeXsqxkbzQ
	VYaGkK6j/dJK0D7Bo2DoTZ70ErHJxw+bxheAAokTKf/a6O0n3TMA9Zgz/zByql/z
	kDF7UL2RWCxZxTly2qgZLRKDEWaHGrO4inxiRagUd0tqUPn1lhpQSX0rc7rnQ2FU
	AM7sVhDPo98tpkscdX5hUmDos+6atvdIdjK+Tl/VLDS0VDzGtNULa2YIT1QiVee7
	FK3wFUkoy9duholREzOg7iR9nVaojm51Pz+K4W2xBeBYniNsxF720p4E/hfw3dOZ
	bdCxOP2n5I57tNO3v/67iesI30iV6GTyU48LDPReTV21iXHBuVkV62O3mqZZRYKj
	jUlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047188; x=1702133588; bh=9LLqehmDLTPnm
	dpLWFmrwJ3o8akTNT9TXYtBI0QXN7M=; b=FU0vdZIL97y3FUMZeH5fTsv2lNt66
	VO1l16Wtvj3YWhw6su8uYN3UZvb6ynKBWzT/1AVNb/FkdyMprQkSS9r5sXqsWmXH
	AU98QgZ7qT7WfTaRcnZBmRI9JJcjppybHAwAKfstuQosaSKoHuCG6FCMXUYt53Oz
	KBh9HvuIi77GBFrVZAWZxZKiVM16TKEH2QRqBugKjAeVbXeLvfetwx456D7SEPEA
	OosisZZGbCd2AGnprCMQG/dNeNH/KQpk6UX2TtG3s1u11jkxOyZGhL9epsDzjesh
	1HrkYzupjox4xK65UpkE1+cjKMbMkmgAQGTywmpL4G3wQl71K6Gyf7lQQ==
X-ME-Sender: <xms:1C1zZdfOxqwY5q5B0i4ua3Vyfp5jLxP-YIz6zTFLVkesCOZivfmTvg>
    <xme:1C1zZbNXpZaCYTHQ39jYwyDHEkTLovwtGdSTEYdx0IlRR17DNfknkRswMxu0g-HhK
    ID-l7iqUZe-s_rEzQ>
X-ME-Received: <xmr:1C1zZWiBlbvq5BF3XGEJK7xS23SYiWIGRCuplMYkkUytCUdq_LKch0KDKPr1R7Hjd_4kWrruwMmx3Z_Hdsu60FqouVbwQsnRhYZm4gQtkQB85fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1C1zZW_1rvFLqkDd99sbWAZEsqLU28MUZEKRZHFHGT3-4N5pb__dCQ>
    <xmx:1C1zZZv-l9gXBW1mG_yo0wH3U9xdAofu1dK3XTmHSJkyFps6lwESIA>
    <xmx:1C1zZVFGQWnWUIL4tqSuTn0JsU6fqPE7tegyQApBtPDcJbVvoJeVzw>
    <xmx:1C1zZaWfX1chC_YAAiV4kcP_oon2khp7fJ2iu9puFdqmmAoTSfIrng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9cbca9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:37 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 03/11] reftable: handle interrupted writes
Message-ID: <8c1d78b12b5b8d7c4770e627790336c442aef665.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CTbF3H/jdSLWbbNK"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--CTbF3H/jdSLWbbNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are calls to write(3P) where we don't properly handle interrupts.
Convert them to use `write_in_full()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 6 +++---
 reftable/stack_test.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ed108a929b..f0cadad490 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -42,7 +42,7 @@ static void stack_filename(struct strbuf *dest, struct re=
ftable_stack *st,
 static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
 {
 	int *fdp =3D (int *)arg;
-	return write(*fdp, data, sz);
+	return write_in_full(*fdp, data, sz);
 }
=20
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
@@ -554,7 +554,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 		strbuf_addstr(&table_list, "\n");
 	}
=20
-	err =3D write(add->lock_file_fd, table_list.buf, table_list.len);
+	err =3D write_in_full(add->lock_file_fd, table_list.buf, table_list.len);
 	strbuf_release(&table_list);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
@@ -1024,7 +1024,7 @@ static int stack_compact_range(struct reftable_stack =
*st, int first, int last,
 		strbuf_addstr(&ref_list_contents, "\n");
 	}
=20
-	err =3D write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+	err =3D write_in_full(lock_file_fd, ref_list_contents.buf, ref_list_conte=
nts.len);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d0b717510f..0644c8ad2e 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -78,7 +78,7 @@ static void test_read_file(void)
 	int i =3D 0;
=20
 	EXPECT(fd > 0);
-	n =3D write(fd, out, strlen(out));
+	n =3D write_in_full(fd, out, strlen(out));
 	EXPECT(n =3D=3D strlen(out));
 	err =3D close(fd);
 	EXPECT(err >=3D 0);
--=20
2.43.0


--CTbF3H/jdSLWbbNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLdEACgkQVbJhu7ck
PpQe3A//RNaW4D+4chhCsjARML97MAunEtiTNBSogHybzQAq2eFWOEQMh22gPSY9
7LUGW+FQpLWmG1nplAcipuE7nKjFw1EgOHNgZ4zMWRGMERU7gadVdnmvJ/MEvqN+
iA5V+6ulmfMs1ma0UpY/ej3xCnz7ehVLhH2MXB5M8fB5XjtmrYM+AgbN6EH/bL5+
XI21XwiHLogRbUDyBzV6/0mBKFGR1TdsCMqVEXB4k/dUdRjnXAGAsMtFfuKw3IyI
96ncu9qYPI3R/L9V2LEhvajOdVWlmkWAt5RfMTSWHiyl2R+X/+HLLV6Pu2gLEugy
smagRF1oWjhfvYls0AtFQGVEB7qBWPafZPRoHxHw3DaPZ5CspzP1nPTmE9c9Pcrb
O7LHdBphwix7Pf1yAkmmKVe1MOzfUWc3p0qyn0z7KcDG3YDZ4gLPNlj8xK2wuvJl
342zzNMhh51Do2dsdA3G/ZpwNVlHZCj0l2/6nHzW8/r9CDv22Ud57jDfh5ld/R9t
DzKnG9vkM+mrXpI3WqF8Ng2ASzooKWm8+W6S2GlfCxFb6pn+V8ZULLAjhG+l1CIN
SU3LDDTwxkMoii7RJYYuujlWknclwPBpL2bzJfs/Ard/Mnhw4pfGTf6CmqDXunVL
if66FaF12zZ4w71JKlEkHjAWFd0Z2ZY60pqkFQbQRbH4rYgZDRo=
=2Tn7
-----END PGP SIGNATURE-----

--CTbF3H/jdSLWbbNK--
