Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5814F70
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H7O5l9SH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1L52lgA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 0FB3B320034E;
	Thu, 11 Jan 2024 05:06:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 05:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704967614; x=1705054014; bh=/vD9005ykh
	MTzCKwvK6H6cu8M7XWK29+pcFlZZ0hbwk=; b=H7O5l9SHVE6/CUOW/cpTwsmoni
	TlPmH2kRVUKbLrJ+7ZVG6a8icZQdyNZjkGg5sWGLwr4+uZXlgSJvaIoCSZkC26id
	Jtit8qYU/VxxoxBFHFkKoAjvzzZ0lhnGtT8XjYDFqc+1Wjd2TmIZTagsPLyFtEtX
	nmK+WUAUCdEYgaHbdN9RMTuy/H7/Z6ctOUm6A8c4ZlbibAPxMKWCcTJ6lOya0z6E
	lR7BnEAr+r1LRv4oc8UEmcVZwZOPeld6ZOSyhP37T3YkW6kqe/jloD+11Ik8vTj7
	hyD65ZjAmXo26TfMFQaI583HW5ukSsdeZwc2PHKckdkkuDZYiRPgB/MZUqXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704967614; x=1705054014; bh=/vD9005ykhMTzCKwvK6H6cu8M7XW
	K29+pcFlZZ0hbwk=; b=Z1L52lgAPkbbMfEiUBTNBh6Isr1Bv4OFxORUQmXLysF5
	v1PchzzW0wVJ7s3hdGGa0cArYC3NygA2IZvv8Psn9NModhOaoufCVoVfljv9kkv/
	TMhrmELKzA99JnMJMRb08WkFlNSt7+Tb6umIT/fboej4TROx3WdUidugfYfdEMBF
	e8bG+nvqkG4Aldo++r4CXEOPi6HKTmEyx6XRrY+Q5OUhCUe7n5568tYlrWkXkI3G
	YGQ0LzTmQklGOnhOIV7De7AyrdAtXRmaXDE0TPf2uyqHa9ots5YRcn+Wr+oU3kfo
	d35UONcOYkYp4EKSWsGdxaTddK+EMzAGFj10SAflBA==
X-ME-Sender: <xms:vr2fZWbCRg-XIeQsJJOWEeEHzAEdBgaxlTlqAuCLdKzWH5fYdVlI6w>
    <xme:vr2fZZaFxgUGkhnOstczroKON5SfnQjnwWyF_8VtgPuRwIBd_EjDNwe_MNu71SHx4
    F1lvlCJFBAq7lh8Uw>
X-ME-Received: <xmr:vr2fZQ_9MwPvSGqMc27n_paVTKYti6gll487P-_WbL5RkJNU9fJiaFk-xNOYaHxXU8zWoLcyha3Xej-Y849Q55jdDEnnejmHrx2yxdTfobYFE6RYHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vr2fZYqlNaMUdLAPj2E6PuPczXb6Qk7Ygkvr-k48765XojYuUGa41A>
    <xmx:vr2fZRo8DTSdYdjv__OnNf5VwwWoFbDj3nIa1u0tAM-mwo8PeMnCPw>
    <xmx:vr2fZWSPgII6L5p9_WNry8V6DleyPlZEOJ_YI59RedJ3DVNV7Dn58w>
    <xmx:vr2fZSAYBBrJ2lOPqalz7GE6v7LoYUDsTg6YF4Oj-V0eNqkK6BzyUA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:06:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62dc9229 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:04:12 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:06:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] reftable/blocksource: refactor code to match our
 coding style
Message-ID: <96e79dc3ba011915924a8a4766eba426ef83abb5.1704966670.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RTvbiNIMDv0wAFmB"
Content-Disposition: inline
In-Reply-To: <cover.1704966670.git.ps@pks.im>


--RTvbiNIMDv0wAFmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `reftable_block_source_from_file()` to match our coding style
better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index a1ea304429..1e2fb5e9fd 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -125,24 +125,23 @@ static struct reftable_block_source_vtable file_vtabl=
e =3D {
 int reftable_block_source_from_file(struct reftable_block_source *bs,
 				    const char *name)
 {
-	struct stat st =3D { 0 };
-	int err =3D 0;
-	int fd =3D open(name, O_RDONLY);
-	struct file_block_source *p =3D NULL;
+	struct file_block_source *p;
+	struct stat st;
+	int fd;
+
+	fd =3D open(name, O_RDONLY);
 	if (fd < 0) {
-		if (errno =3D=3D ENOENT) {
+		if (errno =3D=3D ENOENT)
 			return REFTABLE_NOT_EXIST_ERROR;
-		}
 		return -1;
 	}
=20
-	err =3D fstat(fd, &st);
-	if (err < 0) {
+	if (fstat(fd, &st) < 0) {
 		close(fd);
 		return REFTABLE_IO_ERROR;
 	}
=20
-	p =3D reftable_calloc(sizeof(struct file_block_source));
+	p =3D reftable_calloc(sizeof(*p));
 	p->size =3D st.st_size;
 	p->fd =3D fd;
=20
--=20
2.43.GIT


--RTvbiNIMDv0wAFmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfvbsACgkQVbJhu7ck
PpSKgBAAqSjNsbf6+4jqaptUx1Iut4ixulIUnHFBadrWUYb6K1nvx4+HQ4DfGeVD
mEzrFlQ787u++k7RQCir65VDIbZ7weWWGD34PIVG8Ob9mHMpOsyot4NXoj+n2qqk
SQSmINsGmljxGzz6GIfSnq4G8tc4MOn8ygxlEfRIU3cXnqvs6mLJL9r2dmUSm0ih
E3salhdtessjVY3EEvE6ShkwXYnZNGhQM+1e9G/Zu5yBSy1tY2Xs+Q7rzj2ojCrd
S7pCD0Ub49r7SN8hd3D6b6i4MscOkxqJITFaioeCRy1/cQbkO7oiAmbi2D8ZDOhg
j/yfqYW9NkF+/YV997Nls3LwsbNUueanByeYW6rxBagilJSkEJXE46P8MNKh4Yw1
Ks8XQ65zWanuRl65wKbbP/n34EHmCeMLlVXuYiLyFt4xADsffcAkCWA01pLUCNj3
r6iVHmqtC68t+Lxb71iaisRqEzryu3EgNfVfQvB9ZsnqxxWolaZDYswY18285qtT
KWE74wRst+jBjlOhJAZmZUsl11JsMDM+QuLI6TlqN+Z8aAT+dRiidtHbI6okboIy
Htk2ubDhXajmBQupnHvndgbueZX/iQJdUY9gIC9X+hKTPiqsWNTRpQUCHo2MwdAw
hTrxgD+TxIv5Iy9nsz4LGnO4vUhW7UQkRO1Qkwz9JtxfJ2mEKxc=
=1v6f
-----END PGP SIGNATURE-----

--RTvbiNIMDv0wAFmB--
