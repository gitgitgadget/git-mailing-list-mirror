Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZjoNdKdg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOGat/qy"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC0DB
	for <git@vger.kernel.org>; Sun, 10 Dec 2023 23:43:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 066113201F2C;
	Mon, 11 Dec 2023 02:43:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 02:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702280620; x=1702367020; bh=Fn
	SYx0CZvyP2xTbaQJeqlh3t7JNvyaicXgf0X08YtTs=; b=ZjoNdKdgrK8mG//Di5
	mjKO2pfSWtYPZp3dYG/pwQRbbt/+X/TGN2++KpWsXXFfl0ZgR0gHO/S8OaeWW9rz
	MeFaD3ifni2dro1NtydjRb/dMTXXbghG/3cBRO0PHxVbZ5vLp1Tt9XU4uZyyN0DE
	hBF5umm6Qzsx3lXn7GGXobhVQLN8YjIsWIUo175rR0fEMsKe1k8WIkYuZ67VdIfh
	cE/YAePDpWdWbqKWpvI7MXMBqDilyrbsGqh2AXWD+BpZFDOD+1lKZoSJd8n8VElo
	g5Q6cC/Rkf/Xl53m+jV72CUttAMaq5Lhz+lQRuu/XzcwLifqC7aFMtWgawZbpfkz
	seVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702280620; x=1702367020; bh=FnSYx0CZvyP2x
	TbaQJeqlh3t7JNvyaicXgf0X08YtTs=; b=TOGat/qyc9xMIEdWM6RsRBDZrpD2k
	sEpDxlfwjtDsdcF+13rs2s4i6lTuhG+WqCUvqEBSdyCm0xleccOMn/vHrFC28Guj
	TVim1pHXdjPIZgPUI4ZcIBue4/3sQOwsM7i3GD2hfZ4eELEAaeQMDGGA+qnqHBHw
	79Gx0WMX+iWlpY4uVqA0lLSU+TEuMaa9fZE3JTEtGiUP/ONyCB7ZtuyOyBdEbXPK
	Qzlrwu4OeGBYLHuth4d97cqJQoILGBrYr+S1wFzauwDdT0rfu1uHtXULuHPp6QsA
	VqUa6a4bSZIE4JGlFdQ9T0PJ+oR4e/HNRebQdVTjoyXiU2tNM2Qs5wACQ==
X-ME-Sender: <xms:rL12Zc0_w0KTm7RfqH6TDKGjg8EWQcYyJPxo7AzMxG8ZuO8wTPHAYw>
    <xme:rL12ZXF0Zrdz3P8oKxF6boTIRKjMmmmuImI2oyVTl7NbzZ3uV8zxyO9NTWeKhxZvc
    b94ACEYbOD4ZQIWkA>
X-ME-Received: <xmr:rL12ZU5yyXBqY_rOy_qrkVPrD94YdjE_VW3343zjMWpLHqwQ_VI5Ix__EZrXfVdgFh0Jc2zdNaBJTcG6e8BFFGipGFftgya3QCjuwVLo7JhTUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rL12ZV0rQ0tZVfjGIaG04ecjt3Fh9hyTCcDeoYpQiNQjbDl2JoE5mg>
    <xmx:rL12ZfHIjkBKrKvRwDU4ziQAbh1Bx86c5ffvKuVve7Rj4TIP99fIcA>
    <xmx:rL12Ze-wZoItCaMc3m1AlfoLiLwTHZllGWGPM6g9y29Kpex3L3puZg>
    <xmx:rL12ZVNlX44CUNkBMWCshD1DIHOmDY-WAR6kkvXkuNxOrhU4j9cacQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 02:43:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1318b0f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 07:42:01 +0000 (UTC)
Date: Mon, 11 Dec 2023 08:43:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/9] imap-send: don't use git_die_config() inside callback
Message-ID: <ZXa9pz65O2B6Gwjp@tanuki>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
 <20231207072458.GC1277973@coredump.intra.peff.net>
 <ZXGJE-pkb3BjlO-d@tanuki>
 <ZXOfrKYsmOjOHGmj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MggqxVcHMPLQHjuQ"
Content-Disposition: inline
In-Reply-To: <ZXOfrKYsmOjOHGmj@nand.local>


--MggqxVcHMPLQHjuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:58:52PM -0500, Taylor Blau wrote:
> On Thu, Dec 07, 2023 at 09:57:55AM +0100, Patrick Steinhardt wrote:
> > On Thu, Dec 07, 2023 at 02:24:58AM -0500, Jeff King wrote:
> > [snip]
> > > diff --git a/imap-send.c b/imap-send.c
> > > index 996651e4f8..5b0fe4f95a 100644
> > > --- a/imap-send.c
> > > +++ b/imap-send.c
> > > @@ -1346,7 +1346,7 @@ static int git_imap_config(const char *var, con=
st char *val,
> > >  		server.port =3D git_config_int(var, val, ctx->kvi);
> > >  	else if (!strcmp("imap.host", var)) {
> > >  		if (!val) {
> > > -			git_die_config("imap.host", "Missing value for 'imap.host'");
> > > +			return error("Missing value for 'imap.host'");
> >
> > Nit: while at it we might also mark this error for translation. Not
> > worth a reroll on its own though.
>=20
> This string goes away entirely in the next patch, so I don't think we
> need to mark it here.
>=20
> Thanks,
> Taylor

Ah, true. Never mind in that case.

Patrick

--MggqxVcHMPLQHjuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV2vaIACgkQVbJhu7ck
PpQmzw/+KzqxCmvYYps44eiXpDGGz9lR6GxcBeCH999YJ95uI2gvL/sZit/3xf6G
cL1gGhQgFo/YIcJbuGxtEM1yyMZ2i7R5S7Si65adG/tdL+YHpOuzOF7rWnm7gwyf
VUgIYb51IRxM1KbKVNO3tV+SBg+rAos/CmK1M6xaZziYFGTToSmOeQdnlY4SxDLi
bXCqU/9QbUYCEIFUASf3aaqhmfN1fhBQnv4TtlToCUu36MdJDlsXCzfBf25/y7tK
ITb5P69niDyxpxrqp70LJ5Vio09lqwRWLZA7iwA6BaCWmLCk9S4N42RovoiCl2bx
bZbiIid+MEsC3bV/bnUX4qq4CftHJbvZC44Kg/PQF7AJtSuAbIg4EQeo+9sdjKdK
sgdtlKtEntXTBeB29Ip8uF0qXi1gR8xQHz8nJatisePXTmMv4+/VcNWiaPy9hQVq
oGbAVPb2qxGYeOrJThHKbBAjG/75Nwtlhd2c9M87/SPMf63g0HjFwhsHKQYK//zw
amhmP+iRNda2ZbwzXsl9CXQbD++wCvCWe4f7ta9TOfoIJdNZIDi7XNh9SdKPp2lo
kAh2Y+zYJy3Jb0JiLTTkiDwXuz3IUz73dU1aSff/LvcNgiTpEkykVeRTYfP9Kib4
NYUK8YhcO3G2GbhgW6T6lLKFWTqU+IlOZ5Ba84Evz2xcSEJ4yzw=
=tTJX
-----END PGP SIGNATURE-----

--MggqxVcHMPLQHjuQ--
