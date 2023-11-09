Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE39DDB8
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDSG8nIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiHz2too"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40005170F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:37:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DB73E5C035F;
	Thu,  9 Nov 2023 02:36:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 09 Nov 2023 02:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699515417; x=1699601817; bh=jx
	3cf+lMkCyT2mxwmrqiwnblOQCBDp6Uo0nvYLpyadE=; b=fDSG8nItBsgSo7ikGI
	3m8d7v/C4bZQirE6Z0W43/XqBiOMgPPDVNFw5s7dUSxQ1f0//Px8xTW8WojITs/I
	GH3X/fSFoH0Cv+c6g+0xomkZOlnWfss6KU9FdV6W4BEOfqthUNCFb1f1jW5bKgKy
	LGEKYPYlF/8BkF1fMRKjonDUnNGUZjlkPRN3uqCql9GWIBZRoUG/SPzBmvUzCHgR
	RKYZyiyVYOBrkhTV1i8La+Gfhc24lpPCVSlwubZh0+EOUT4/LcOslYCoiu/OqcFW
	F+0GnBy2GaTanNW7xMJW+xGwXyxg4vJCA9zQLJpqavlOkCCvufGFLDzGm0BqOoiE
	hl3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699515417; x=1699601817; bh=jx3cf+lMkCyT2
	mxwmrqiwnblOQCBDp6Uo0nvYLpyadE=; b=XiHz2tooxed/HmciPBe0qyMeD+Q8z
	m5UYY0LMTPKHdKuV83dtn1hj+RAgUIy0kXszzVojhic+X8XiNfmb3WsdTdwd9/rM
	aPv5YOMAigoskkjDlscBqIvp/xeXb3G9enqI+inKNyrgpnd1jejFvPlYeQug+XyE
	srFji2M58Bl8Y6dfHgisB9ZIkXSU5GPMKWINeGWi+DAyWkV6vQX5jQP2xLE8d3qw
	C0BXhK1QEoz1W7MEtxMqjluZCi/XlmfKjM3xE7quGBtblVnQjJI5iIT4kPnLLK0S
	J11A75kv3/2usyySLBd0gjeB0sPqfcCaGP7dHlKi8ti0kVAckenkci4tQ==
X-ME-Sender: <xms:GYxMZbIfPQfjew3wRB1Hw_mMIVIyp0WohDzUo161RF3_E0-8erxfpw>
    <xme:GYxMZfKGjtvz4Gs4e2Hr7MRdaJwyG0UvCE455zTF5kW-29kkwaWpAvffDb75a5MGz
    G485JM0ifbiN90hWA>
X-ME-Received: <xmr:GYxMZTs5ZcMdRUwao55BTa1iSanMWk59Kyi8NqwLQYUvn9tSsnNjOo--ce08ydoFrtq2TudTX6Odker4PTJFhCM5XguXnw45gqxhHU8fw6Alewjl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GYxMZUbMy1RbMnWrGx0POLQURg1Z_QcYScTkHQ8iZ728X4NQNiDkag>
    <xmx:GYxMZSaiGHX8uKxPK91Hgo2CDwyXX8o1HVzVJGBjtmYur33qBfzptA>
    <xmx:GYxMZYDKGe2ncJ60c-E6xhmR9E_eZw0Q-YiqzN0ieXYVnFkN9RttMg>
    <xmx:GYxMZVzamZ2wwdeZlLG6hDZBMqNM4DFflA5oS4mA_Mjhs16nGE9gCQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:36:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ba7413e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:36:28 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:36:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <ZUyMFZ7c9_rlu5lk@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
 <e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>
 <20231109073250.GA2698227@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pLx2Hv3kbJrB3Hhw"
Content-Disposition: inline
In-Reply-To: <20231109073250.GA2698227@coredump.intra.peff.net>


--pLx2Hv3kbJrB3Hhw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 02:32:50AM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 08:09:52AM +0100, Patrick Steinhardt wrote:
>=20
> > -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
> > +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' \
> > +			  '/usr/sbin/apache2' \
> > +			  "$(command -v httpd)" \
> > +			  "$(command -v apache2)"
> >  do
> > -	if test -x "$DEFAULT_HTTPD_PATH"
> > +	if test -n "$DEFAULT_HTTPD_PATH" -a -x "$DEFAULT_HTTPD_PATH"
>=20
> Sorry to be a pedant, but I'm not sure if we might have portability
> problems with "-a". It's an XSI extension, and POSIX labels it as
> obsolescent because it can create parsing ambiguities.
>=20
> We do have a few instances, but only in corners of the test suite that
> probably don't get as much exposure (t/perf and valgrind/valgrind.sh).
> So maybe not worth worrying about, but it's easy to write it as:

Yeah, I was grepping for it in our codebase and saw other occurrences,
so I assumed it was fair game. If we're going to convert it to the
below, how about I send another patch on top that also converts the
preexisting instances so that the next one grepping for it isn't going
to repeat the same mistake?

Patrick

>   if test -n "$DEFAULT_HTTPD_PATH" && test -x "$DEFAULT_HTTPD_PATH"
>=20
> -Peff

--pLx2Hv3kbJrB3Hhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMjBQACgkQVbJhu7ck
PpQX0Q//R/vtjRfDy/iN+OIS4BjYeT/F04cGg8A+mRk4dmml0yij8IyG2zON4sW/
gSmUm20uuEvKjkmb72G58id0i5DNrnnJH1SKOjNDQy19t9eTwc+mMVo7EEDEE4ZT
/IlWjgdcOXd5ndKQPpYO5l5h20BY/JuvRSnVLrVA7MfGpiIBqMD0b5LBy4urzryw
Zjk0430HwgEV476/hUyTbeVtLZU+LDfoyLf0SGSMSu6HqNsUe3RSH6uwoXYlZnij
9JI/X3YyAkthxay5VhqTVVkIaXrmin4nwnQXEx+A/DmlXN6vCz01HHxdoed/9DgY
AhNE6i2Px4dOJxQlRepEhX5XFMtA3VoqMtOj8kPjt2r18ohWbYQXBuMot2aMrCbp
R2pcduDLyh99yx71UhYZisB/RQYdVSwqLcJFiTijkLuiZ5dEAyfwPO/D/fReLbLd
XnCwsPBai2JLzAPBVMeASi2tBrs597q+aIEk+X7kiQE8ckjp+MuGgwsYoJjrE9hm
Iw3UI31KwIIgHFR9y7qdmsA1e4/XZPyxEib7pwKibGWP0mPyzDCNb/G+H5LE4jsb
4ZivRzGXW55XPY92R4TiKwouQiCPdS936tDNTSYaD4s9FWrfroiBfwGIFw38vBeI
Hd96RcfonPus6kLtHrBXcUPDIjrbRwlWcBAzWlYg+gXd7pVd8tw=
=sqld
-----END PGP SIGNATURE-----

--pLx2Hv3kbJrB3Hhw--
