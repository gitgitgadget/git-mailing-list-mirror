Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C58830
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kay7do5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaqN8dst"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4947DA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 03:07:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 0E59432009B3;
	Mon, 23 Oct 2023 06:07:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 23 Oct 2023 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698055648; x=1698142048; bh=8k
	PR29y5JF2NUe9LPScb/EGruUmiqojY384FrbilLkw=; b=kay7do5seEEtD80piT
	V8cv2ca44eaxSW9J4SelTcfiE4INNcMaLKtYjqhdqQomqMh7PTGChy1hTuJyvqga
	jJMeqf/BI2Up8BUbMpnrow8yhwnNw5ABJes7e+ii7h+3G3SF5IlF6KhtsTRL2mIM
	f1g30UpFKEb3t9qJXJx2ZfCdzr1BVpRfAFfyM2XBw2SJR9F5lP5vA6t1nQ8WGPtJ
	r7mgRxO7NUxdEO5KRYFr1pQ38W6b43lgRExUj1MTML3sKPLGgdexrI6+6fcT2ZRb
	SSPzIQZCtWrfNE9Eq/ARJ99+N+4uR3K3DYdypC2dylePO02tbdbsgB+S0g/OCXzZ
	T/+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698055648; x=1698142048; bh=8kPR29y5JF2NU
	e9LPScb/EGruUmiqojY384FrbilLkw=; b=gaqN8dstCFFR08XN5tyBqG8RedV2H
	b52U2utupZxHOjRmvPEKj9WKnvbkIekZ8LevAdd6M/kMnov8cMOq+maYOgU/RymU
	gPAUfeuBPlaGuJfygBYjmZPEInru4kWGjta9oOF6SeME/ljFiCYSXBczimaFhkT/
	qXQTSB9UsTx9UINFCPfIG0MFbXO7ymXAMkHYyZ1coBztlp5/itN9O8Cn1G8dGnvk
	Rlm33TygFc34DUleLnzu/lbvOVtw0/S4BdAI0ao8KwK5vd4In9BOYN4l8klSOTdm
	rwlDVGqz/7JEiPHuywIB+tLEr/KcKUDeYKQ6cO9pgVZD60PjsKHxmxa5g==
X-ME-Sender: <xms:4EU2ZVb77FWbLM4wRaA2vShAxzQa-wyZk58yk2MQZ_yQULYE8duFCg>
    <xme:4EU2ZcZj9A6DGOI0afQTfSSvKwy8obW8aVpt-2gkCMZVzqT1YIoE3pouw6PgzxOSC
    IDtpLHNG6U0yfMYHQ>
X-ME-Received: <xmr:4EU2ZX-3mpUhVjWKkDk1fSX2ITwt61jV4LKpS90qesqa1dff0dl0YP1ez03x-QuYTkY1bSF6DRcYCoys3wh9e9wdLLGdWQQNidBdD6_3_n-1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4EU2ZTqns0PfujCQACefeLUbAYph1oBavc-TZmnLbACUYBqnaTHkkw>
    <xmx:4EU2ZQoUeO17Mm0EyYgN4PI6ErKxXIPlEthcUJ4vGthuxRR578xCTA>
    <xmx:4EU2ZZQgQKQ2FvjC8yzKG_sVtQyIppgUaAFgkOR7-wqSVG8HgE--bg>
    <xmx:4EU2ZX3YKQkqo2yP3tCfmwcMDdc9Wh7aPtZj3xiii_Di8fK4qIpPiA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 06:07:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8501de9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 10:07:23 +0000 (UTC)
Date: Mon, 23 Oct 2023 12:07:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] fetch: no redundant error message for atomic fetch
Message-ID: <ZTZF3AbNNuGpy38l@tanuki>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ZTYue-3gAS1aGXNa@tanuki>
 <CANYiYbEJ_mHdsPM3-huDPFktSWFhrpoz7Cvf000JSfZM2cco9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WpdTTr4UtZ/DIkLK"
Content-Disposition: inline
In-Reply-To: <CANYiYbEJ_mHdsPM3-huDPFktSWFhrpoz7Cvf000JSfZM2cco9w@mail.gmail.com>


--WpdTTr4UtZ/DIkLK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:16:20PM +0800, Jiang Xin wrote:
> On Mon, Oct 23, 2023 at 4:27=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > On Thu, Oct 19, 2023 at 10:34:33PM +0800, Jiang Xin wrote:
> > > @@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *transpor=
t,
> > >       }
> > >
> > >  cleanup:
> > > -     if (retcode && transaction) {
> > > -             ref_transaction_abort(transaction, &err);
> > > +     if (retcode && transaction && ref_transaction_abort(transaction=
, &err))
> > >               error("%s", err.buf);
> > > -     }
> >
> > Right. We already call `error()` in all cases where `err` was populated
> > before we `goto cleanup;`, so calling it unconditionally a second time
> > here is wrong.
> >
> > That being said, `ref_transaction_abort()` will end up calling the
> > respective backend's implementation of `transaction_abort`, and for the
> > files backend it actually ignores `err` completely. So if the abort
> > fails, we would still end up calling `error()` with an empty string.
>=20
> The transaction_abort implementations of the two builtin refs backends
> will not use "err=E2=80=9C because they never fail (always return 0). Som=
e one
> may want to implement their own refs backend which may use the "err"
> variable in their "transaction_abort". So follow the pattern as
> update-ref.c and files-backend.c to call ref_transaction_abort() is
> safe.
>=20
> > Furthermore, it can happen that `transaction_commit` fails, writes to
> > the buffer and then prints the error. If the abort now fails as well, we
> > would end up printing the error message twice.
>=20
> The abort never fails so error message from transaction_commit() will
> not reach the code.

With that reasoning we could get rid of the error handling of abort
completely as it's known not to fail. But only because it does not fail
right now doesn't mean that it won't in the future, as the infra for it
to fail is all in place. And in case it ever does the current code will
run into the bug I described.

So in my opinion, we should either refactor the code to clarify that
this cannot fail indeed. Or do the right thing and handle the error case
correctly, which right now we don't.

Patrick

--WpdTTr4UtZ/DIkLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2RdsACgkQVbJhu7ck
PpSqMg//Zl+a++6SYM9DRrRJ1+Ru37uSpDmH3aRsMFdKApJxPJEb2QwdtsZfnWLD
OBXdr6OMdVfbFiDfFu2seCZTGTMapglmoWZIhntQFaxjSWNovR908gcgcrRctRgF
9Eq1eJEskvkfZtD0VWfL+SKDyAMO/9xuQ6tzEgudLiU7mKZdbjwS5kx7409zYzib
H9kpcY0QQ2s6U8pHMNAqi6cOEi4UB5Pfw8mtwLvww0JK0q7yRDpgha4ty+M4nyYv
wbyL8PaAnh2dLZSxBwEG2ARQPXEWzBOjLjzHZtjMWO2WWjEu3VF3vMzUiV3oVZoT
2mwy/kXgSRocCVDVFdR+Q1LBIGtYgQk6gzsWkDBbgdb4TVh1wKpaYsiQHnqIkspK
1+jCqtLNKyyS54xuYGnshq9nniNw6YxyUiPYugSWhGmPFIl6dHDLzz/SBuHjangw
3ucD8a/d5hORR2voRDxPRh7CI/PoKJDderRQlk/QW3bl0BIxqZ5Y+ViZqbfocUdv
3wfTB8lCcTXy1cV2S6s21gFZn2gwrW+ZN1KwrbawPmuV5oXIdblq/5WfVgKeFFCV
6gN7kyxJ4Z6FfgUekxAcZWwX5BaylkVT/3uMEzpc+7XpKQyYGU1oF5BGwWZnGHQ8
YFCcXQxeBEvV1gyYRF8MgQDg440SdmXOsKC8E1d1AN06PeZd2B4=
=rNr8
-----END PGP SIGNATURE-----

--WpdTTr4UtZ/DIkLK--
