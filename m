Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YcUsJNC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hr4BhDW8"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA704C2E
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 1A5DC320077A;
	Fri,  8 Dec 2023 09:53:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 09:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047184; x=1702133584; bh=Uz
	BFYxHGgBVtEJGlUELGUayA7oNlbWLe/nYuyIkfrfU=; b=YcUsJNC7DGRPM5d8Xb
	oQbcXGr53VX91tZJxHqtZvCsulMkt0qMYKIUlfrWf1frke0PAtInofWdyQMY01gK
	Yn3gF+Yh95ZGlJeKR6mI5LG8m1K3kWiQeA1x5fUVdj+GUTOuRQ8dgN6HUTmZqm+M
	UcGWCb9f0bnRkRWtCX5wvBmSB8WWmQgYTYl2JsF5IZ0jcS1EyNW0LLIU1Xhl8f8C
	cACBHqfnNx1KiHoLmHGBOgtR+wkn/Bv5ryj0L73JuDmjVbCKIJDsAcdRgLgtxiTj
	v33yaj8wLd2Xy7Y5+Zzd+nW18eQZMH4iil+xJEkuGeMgPaIehzZvS5bAjaqPIvPH
	uYzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047184; x=1702133584; bh=UzBFYxHGgBVtE
	JGlUELGUayA7oNlbWLe/nYuyIkfrfU=; b=hr4BhDW8WlH8LhlrXbc0BKmNiCZ8I
	t67MzhEzUE3dQi/jNd79bhIV6hJF5soHV4oA9OpQsJRK/1+s+bz0OS8TDYvAGDOg
	eLBty6UshvsRHj1ncQOOvLN71mC8vprBDqp7MWpWodjqCIBBNDLWF7vT8zf8IOqX
	4s+Of5Ns0nFamnIQrTXgiFhLCW9lJZ4pEWulO0vmZDl7L8lscn20qp2zXv3aTC83
	8+CzdzjxxeBCK1a7FCnTtjUdG73Y1DlPFDUxTkmb8+GwOJOAPa9C/fnMAJyxi74F
	jwjKGN3fSLkTaPza1gBGAjKfQFxSWBwMy43rv9PQZ5lIFc6+Ia9FXFkzQ==
X-ME-Sender: <xms:0C1zZSu4DFEtBA35VqvF78fM3oKII0zajAOWssc166YH8d4gRNsERQ>
    <xme:0C1zZXcoe0nLwYuMxOA1MkT4MlSfJQRHvButvYDbte0NUatbpFcnitdiO5Ro0J3Nl
    ZVTqa24FXgYq1lRpg>
X-ME-Received: <xmr:0C1zZdx832b7kAmXAHcjQVbTFC0aUDa3zshAbyx5CSdC8ynKueLLTgCx0NQWLQbB4V4xWe57UKfbKW7FxFuwxXMei1GYltpA0xPEO7g8YsTBHoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0C1zZdM9Cb-_tMdhkwfx6-PAzRVFQROjYmT3D1FJJ00lVd3aUFhReQ>
    <xmx:0C1zZS-pQtkkSVGXxO2qkEYxHjyX-ag26nsvMp3zTEwtxtg44AYE2A>
    <xmx:0C1zZVXfnJ9SkYwm-rkqmhRqZ6OPazluy1QwWMneF21t5jgEVXY5fg>
    <xmx:0C1zZYkQbXUQvxQuzkR0m-deUwTBI_HS1SCk5uYQADt0sEXdGn2tZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3cb134f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:33 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 02/11] reftable: handle interrupted reads
Message-ID: <b404fdf066e802328bcbcefeb9da7c996738f840.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0wh7SWN0+bRtFnKf"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--0wh7SWN0+bRtFnKf
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
2.43.0


--0wh7SWN0+bRtFnKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLc0ACgkQVbJhu7ck
PpR9NA//dj0MBq89U5lGRkejyebaWUBDpn0dwHJW9lftInci8WLqsC6+nSadbLzI
qGeqTWt2Z65mXyK+dPNNCGLnMhDAbD73AMqcBPL/T66eiuQ3jdvb16yCeoRETZmY
lHYQCSgord2sccvOqG67wX16stajTePbfLZiAVbNob28vk1X57y1M+5kVUwkpCRq
Ip6GHxfP4y+14itc05RZs+5kbx7sP4KNlSzBKDg1cBGaxz8Pzx9wCfC2aEXONVJ2
eyt2Tw1hprDGQHEks+5/ClAbcGS32apswKHDSd6T5iyYv+FcTGUKEi4J6wOGw/o5
KiHNvbk++xnVdk+3mLcFJHPyO8Fw0rVPRm5ggT5i16gpYjpC6Nl+DROPvZxju0p4
w+oEiLO9rFHDIp3RIccMRUF8Z5Tu4A843myDjo59RLHLkVhX2iOVinJOSmAfekoo
4MtrucW43Ye24iw+qdZcrcAgs2izJiMVoSPPtmD45QcFnjmOB3YtQCXmbqDAc6DM
Srkw9tK8XSBkaOUBhcOyrOlkFwgyDmaitqyY+6LDarfv3pI8y4NAQg9JAIyBn5Ch
vvXNOukt2oy0+qUNV97PlGaQJK2hj1YEAHjBDIfZxpVE6Jw3nwejxLdpnI7Nr8DX
4cXT7YPUcieMBNkTfP0J3OX6S1zrmTiePnnVOW62uNKbzJk6SM8=
=/4yU
-----END PGP SIGNATURE-----

--0wh7SWN0+bRtFnKf--
