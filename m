Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J++CUc1v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKaHV/N4"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BCBD9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:42 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 9C9B43202657;
	Mon, 11 Dec 2023 04:07:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Dec 2023 04:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285661; x=1702372061; bh=HK
	rsSDIRCHkrbjb8BAIQRDSXxURBnxmliYt0D/tQEWM=; b=J++CUc1vN7w831H4sx
	+wvmwittll9BbXzamwl4RytjzB3wPYvr9f6YtVNzQ2cmnboXWHPkjIYQ9IjeMk0J
	MrO7b1tL0p7l3ctExgZHm1VDAMo0NRDmfrhSaNCD4VyqOD2DN5hztX/zyR0M0+nw
	cw0MRNpNLcZw/h67Kkl8wzPwwzjSTvXVaHW4lMRpn5lEXQziD3ljkWJDxlVCYY+y
	ihk/mP2LvOAnqYPTtrbpYbkjSlap1UjtWsuu3F2/ITFVmhrhLsQvyVFR6l/c5Ee0
	/aLwe05k27HUohaw+rw6AVamXmm4wOhGZ/2+99I9fVZ+2IBNzEBxFp/WthxpWh6h
	OCeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285661; x=1702372061; bh=HKrsSDIRCHkrb
	jb8BAIQRDSXxURBnxmliYt0D/tQEWM=; b=HKaHV/N4eEY9NN2AvzOHJsZeqpfqa
	lZM9DhTyXHwIG4TBVD7myzW1opefhg+2ndvSz83QpoEO5FhTLp8TvrjFsTr5ZuSR
	bFEw2NSCDHfflz91IMXHqaZGUvmmNa8Jk+ZvGyv2tUqSCdo4unAlDNjtIzCOy7/R
	ke9utb/egGMpwfWk5Otr6vaxI07UjDqsqcJwy6xsB7Vj41kN84Ep0r34ZlGpOqvc
	TF92OmEuTq+sPcagURTLUTYvXTs1AQLbNQmF0xrSC/xjLVsKFKKUagikRPTBN5yX
	3rK5ECPSWCWZYirl2N6jIifR3PSN3WyVTGxBooMVGcp0SJV5Pmk4AYmvA==
X-ME-Sender: <xms:XNF2ZUzZ41nBY5TPoPDYku5QdJIzc8zngnw7m3mLays8IxVJNAa3yQ>
    <xme:XNF2ZYTpQ30GYcJd5BC5z99-F2KlZmXclUWl22xgbkz2bo1A3jw3OQVroS0SezOw3
    sSerxKgVA4f97yzyQ>
X-ME-Received: <xmr:XNF2ZWVdxw6UR-ZtQ6FraOy11PYZ8ljB95pnzWQ-zew5G-cNewK0lpHP1KtruuSX1Xrj-_PUm-tKCI3zlKETWxPpGLvZlhAiCAYO8pot_gQsug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XdF2ZSjuylwY-_MdrfmTXTaXGjDcOM4zAsxIFllybcJBzc5P8b9M2Q>
    <xmx:XdF2ZWAbg03elfHN5ikqvrFBee0OJl-A9siwQuwhXShtxdIP3FmjZw>
    <xmx:XdF2ZTKE0cijbEn3E6WROCBvgyjsHsZEe0yY4U1ln7EjMKZq6y_GXg>
    <xmx:XdF2ZRN-_xKHJ4lmz6TzYJB6k314_2RlIA6PX2W-dBxneOhjhCDa3Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c189136f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:03 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/11] reftable: handle interrupted writes
Message-ID: <1700d00d1ca017730d9188caf4eff9c02720131a.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pqz9S8STXZXJzq1l"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--Pqz9S8STXZXJzq1l
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


--Pqz9S8STXZXJzq1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20VkACgkQVbJhu7ck
PpTXvw/+I/Mm8lsTJ7SV1jq33tvfdIE2Q6yP6P/9Li7MSH1W9CzuRu7gJ/qeapkg
RKNAfUOkhUvpETu6Q4fsWNySAwoHOWYH+2Qhxl8L+qdT+mUsVo9/Z/9d7H/K6Ne9
yK2nqyZaY7bjkzWAhR4xBnNreQ97dnYk0bCriEw1Yfjw1fk0cuMc91WrYGp494XX
7GEwzveV0seldCW6lP+gzRM3uKtGsC6LauZUulpNfD7b7mrP+QgQLk7EQ1tSPgEC
voRuX1IdJkwfzIxwUOVCATlNO56yiq/oeujE30Dn4tZOoi6nlHFwv3QB9nAC+gt9
fab0ujRx8ztrgcEnLHPuqpVpyit7tcriSSaAIJPH0eHowbh8thX6HC6mDB5gnKhZ
j+HXFG5j+F3uvTb/dHE+Fo1XzyVtjRbRxbxbNatWMryS+7EEdFpvg4Ic7OBDLPHC
VfSg8WNkPWO4lHiYtn11T91DvyOderJCkcwOThl/+rYaVGAAGD8zb9XLFbFOBr9v
f9KYbzy5jndf2tkOcIyjPtR+LUMNwWys3ZB+9+yZlfr11Y4NtMsO8OgbSKix4JPO
6uEQj9c85rzdwvH4r4pDEwIEIAdt1dF9jy/JJMUpfS7ORMZ+En4w1DvE7NqSBiKb
ESVRcCU5febgHte8edWOI1A45aLVM+aLOrEPsECmmThbFjOm5r0=
=5JYO
-----END PGP SIGNATURE-----

--Pqz9S8STXZXJzq1l--
