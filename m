Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JoTjhS4a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/0UIb4o"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E3BBC
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 059BE5C1513;
	Tue, 21 Nov 2023 02:04:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 Nov 2023 02:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550257; x=1700636657; bh=Tm
	9E5VGQHgq1lrDzSMzoyqwEolKwlf6hwea70i+QpmM=; b=JoTjhS4aVvJdSShtZC
	+YgatMS84Deamsk8I24PqV/EpvRUJKJ9XMKR2JXyC3kUB8iQs521MNe89cmF3eCb
	Fsz2XCk3xNuz9rKoW6Vx2/Q6H8oQ1o7u8AhoQwMsKBt6mO3folk2u8t9tKMbv08y
	xsSsAkO88Uty0d1Y4QD5l/c8lDVTlJMDrOJJb4RaiS8T1+RHoWHXYGzvAHEXgxvn
	PWwjU+VX1BuEsxWPo5wT85CFjY+6xUkMx+J6KTxD3eiYzaPlpqf63Zb7KH31iyu8
	5gHuOR10+iG2w4LXjAJZy3/+5p/xX0OUUyuCd9wvOYCMbP+KOEb4Vwe6wJBBwF/A
	VZ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550257; x=1700636657; bh=Tm9E5VGQHgq1l
	rDzSMzoyqwEolKwlf6hwea70i+QpmM=; b=e/0UIb4oa6S0DHbkX5mDMu7rXnxtx
	oacK0FwMTU6PO89BmXsv4yl8uFVKn5WlIrvrfo/kO61guyV+yxGd20t1f6LwRgRr
	GOmSbESybjbIobEEIESPTcAA9WSVQmsrnxVVPRJPilyU58d564b18Yax+coTjfAq
	i8uW2C18ZHDqiUMOYbuJeLFIaxMfaFa/8Z1+I7Li4f05mfavONF/NZ8oc7mb4Pv8
	KtM+DPgl77IN73N25CoTgluaExWzKpY0yeQ9XeBhdKerk7TK1LCyuJKUF03tmtKq
	16Zfp3b4DRYRaSPU0Rwyd2LkgBmbDMY8PlsD2DZabc/B2/1KAlm3EdTwQ==
X-ME-Sender: <xms:cFZcZTML0a31WkFFAqtHpm_bM2s2gWtK3lQsszcOAY0mAYwNapGo_A>
    <xme:cFZcZd-yC6etRnidu-mZ4dNp4EnB1HJAWQ6EBz6u0O42QgsAf7V24yJhdM4jpBKCi
    ifWYxPeqAAj502PwQ>
X-ME-Received: <xmr:cFZcZSTbo-F5F5yffANw5zoKljweiDWMipZApmjf0BMmoVCdToBC7wr6ZcJbNS7HfHKtSh8tj0Cu2leynMP8KfkpU-hw7F06ou9NU_wsVITG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cFZcZXsSusu6TLtW77IijIjywqwq7z3WGWcul49x588jh56-2sF7jQ>
    <xmx:cFZcZbckfNr9F_GYbNRYgcXIQJAQYYg3JO1sE2m4VgK9xCHc2zm6Bg>
    <xmx:cFZcZT2ocpuKdz4fnAKXPHudq9PcEtY5gDjwropvA0Ipo-ov1bpsVw>
    <xmx:cVZcZTHSlAAMCcjwQQasZBcc-lbBoC_BlSI7R3OZDQHPHmmlVGfs0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed4c8ac8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:24 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] reftable: handle interrupted reads
Message-ID: <b147296c5805c921fa403135f04c5bc44a8e59c2.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o2jxeFxgUFxUFNG6"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--o2jxeFxgUFxUFNG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are calls to pread(3P) and read(3P) where we don't properly handle
interrupts. Convert them to use `pread_in_full()` and `read_in_full()`,
respectively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 2 +-
 reftable/stack.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 8331b34e82..a1ea304429 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -109,7 +109,7 @@ static int file_read_block(void *v, struct reftable_blo=
ck *dest, uint64_t off,
 	struct file_block_source *b =3D v;
 	assert(off + size <=3D b->size);
 	dest->data =3D reftable_malloc(size);
-	if (pread(b->fd, dest->data, size, off) !=3D size)
+	if (pread_in_full(b->fd, dest->data, size, off) !=3D size)
 		return -1;
 	dest->len =3D size;
 	return size;
diff --git a/reftable/stack.c b/reftable/stack.c
index ddbdf1b9c8..ed108a929b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -92,7 +92,7 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
=20
 	buf =3D reftable_malloc(size + 1);
-	if (read(fd, buf, size) !=3D size) {
+	if (read_in_full(fd, buf, size) !=3D size) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
--=20
2.42.0


--o2jxeFxgUFxUFNG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVm0ACgkQVbJhu7ck
PpQoDw/9H17zrcYWJsOS2sXJaOrZ+2anDilDLBE0BPWQs/mSiPz1HAli/T6eFUhv
TdaPft+pf6/wpvxMFPgVhP/FtDT2mzn5HGEFVXYVXPVZTs1Z5AptWOJqCIlnyTVi
RF96y/K5JOMUws7FFXsZ16TuPVUJ8DGcAXwrUlw9WyRyAX/2VLyAf4Dd2+U1V0gd
erpb7RsXBgD7QwW5DWWjBY1z3Vh9gXng06t0zPcB9RmLtoIZB2f6Ll2TIZ+vIwrD
x1az1YJEE2nsX1/swpO9/Bcs9Go6CcpCVog+lDWVL+AtKLsGa2F1NdE5G8F8KjLR
dLul5aAgW6/uNkap+egY/F1EY7khEcS6NXelZ9PnxltBvKgO3gI4saQjhcasODIW
WIMaa6L37oMucHlL69P5g+TZPi3V60RqwYnl195VXwI2MUkUzrr5quhi7E00CEmS
gapQnrlRwfj49YE9CVIyIaeY5jrL/G+JUZk4oq1koW6hD8jNbSXRH2yKnCVUHVT0
PQ38EpxiXZFmkTP9g7Jn215b7ccdRZfZvkkNJJBhHZSw29Pwj5z1NIaTRIk7VIny
kjdd0O5U5UfO8xikbKNJWrsHM/r7BA1NDZ/STSbez2h6BbhYGFwffd+P54aQP1i6
O8DLMrhOFNTv7GnwemH1ZB9k/F6oXmmmSgD3FHLur7EKAHf7J/E=
=B7ta
-----END PGP SIGNATURE-----

--o2jxeFxgUFxUFNG6--
