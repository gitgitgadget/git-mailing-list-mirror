Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F91CA88
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZM/yxZ86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJC5zANh"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68ADD
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:22:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7B2F05C0320;
	Wed, 25 Oct 2023 04:21:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 25 Oct 2023 04:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698222119; x=1698308519; bh=7f
	TenoidO5EOjeYMbwTQjI/WRLEh0b8/M2ouO964aSM=; b=ZM/yxZ86Hs9a6kuOig
	PjyKKNivnRMIDV8iAaGA1JAFyzD4ohv5dgGuSs8eh3O5rJy4fisTa/hXYYcVfgZV
	2sEoiq443IuG0clqBsFLElleTtyMqBankN/tWtcxTlA4Bv5y5DfYucoeORhePEc9
	QuxijxwKOUttzJq7waIZyDQUJT0auUSdeQEPb0e/N57USEVU+zq4imC81SFIabKT
	JGVBH6ZOXdUk9lx6CqNnSxqQNNcrw9T9fSWmPzyKIAShH+4q5OhzN+CieU79mvUi
	Ma/ato7ksDI2QHhMMYAmyttl0YkULTCBLsq1yAqPHXzzmtFdyDxAER2QEfiAg9CZ
	XNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698222119; x=1698308519; bh=7fTenoidO5EOj
	eYMbwTQjI/WRLEh0b8/M2ouO964aSM=; b=nJC5zANh5OePU4CXpAQo6ahrh9Z7D
	0d5qxO0Y7eMxyEYRkMEP1NcjrsmethfutY9rsHyNAB8X/1xZdFkt2qLnQF5FgLpx
	eoQtFHsXme48PofX1/CA9ls8OWlSWu/rj2grq3/T/sObTH7gwMsknp3SRlDFVNHC
	F9pubQJl1xsTE0G56EWWwu+E9PrRxackEY92irStjx7DwkHWQFaG++yLlEHJX/xL
	txwF8Lpce3YrpTNhC9h6roLS/Bk2lzOwCb8UHnDJv4xhCkEkILXHkawx5czC5l9h
	VgDGFbH/59hwge1LGHeDK9Lv62R/RcTKg3QLTujPugq2aTlfkb/JzFO3A==
X-ME-Sender: <xms:JtA4ZUT3ZRCwUeG28YbGTxbpXr0loXtK1QAN9vJMSFG5O0r7i0bpZw>
    <xme:JtA4ZRx8N8rDOkJd8HNE80FYx2UlJs0w7vHWsz4qiDlL2XJKz2LMBv5sG3PG6NQFy
    s1HxP03O_qBJAI4cw>
X-ME-Received: <xmr:JtA4ZR1YUZy8CM-cP_csduSd2K-gyNaNVIQUeuYaB5gDkqCGvCoQxHdy18mLZvAJ94msyhmCKNaJPoQRXW55JkRxEguPwWV4Cd4n1IkwZrD8ZI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JtA4ZYD-a0l3hy_NTbGpBpIz8Dq8LTRXjMvBROoysijlhECcJWLD9Q>
    <xmx:JtA4Zdgg5iP3KJkBBqMruMGJNEUWNcQ9LM0S5G-pVUwGVnhOiEpTTg>
    <xmx:JtA4ZUqohCJhNoK_pUQpQp2CoFlis3-fssA31plk3ZVmiPtS5fNWjQ>
    <xmx:J9A4ZQtxEzMM1YL5XItTygaQXCIih-7u1sdF8_u4TWjxK-dD0fnCpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 04:21:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f88f44f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 08:21:50 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:21:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] fetch: no redundant error message for atomic fetch
Message-ID: <ZTjQIrCgSANAT8wR@tanuki>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ZTYue-3gAS1aGXNa@tanuki>
 <CANYiYbEJ_mHdsPM3-huDPFktSWFhrpoz7Cvf000JSfZM2cco9w@mail.gmail.com>
 <ZTZF3AbNNuGpy38l@tanuki>
 <CANYiYbG0YFc4Hg=e+0db4NBgM2QwOLpjHjfp8WaoObNxR-=euA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/PQGdahQVGhiV+Pz"
Content-Disposition: inline
In-Reply-To: <CANYiYbG0YFc4Hg=e+0db4NBgM2QwOLpjHjfp8WaoObNxR-=euA@mail.gmail.com>


--/PQGdahQVGhiV+Pz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 07:20:08AM +0800, Jiang Xin wrote:
> On Mon, Oct 23, 2023 at 6:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > On Mon, Oct 23, 2023 at 05:16:20PM +0800, Jiang Xin wrote:
> > > On Mon, Oct 23, 2023 at 4:27=E2=80=AFPM Patrick Steinhardt <ps@pks.im=
> wrote:
> > > >
> > > > On Thu, Oct 19, 2023 at 10:34:33PM +0800, Jiang Xin wrote:
> > > > > @@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *tran=
sport,
> > > > >       }
> > > > >
> > > > >  cleanup:
> > > > > -     if (retcode && transaction) {
> > > > > -             ref_transaction_abort(transaction, &err);
> > > > > +     if (retcode && transaction && ref_transaction_abort(transac=
tion, &err))
> > > > >               error("%s", err.buf);
> > > > > -     }
> > > >
> > > > Right. We already call `error()` in all cases where `err` was popul=
ated
> > > > before we `goto cleanup;`, so calling it unconditionally a second t=
ime
> > > > here is wrong.
> > > >
> > > > That being said, `ref_transaction_abort()` will end up calling the
> > > > respective backend's implementation of `transaction_abort`, and for=
 the
> > > > files backend it actually ignores `err` completely. So if the abort
> > > > fails, we would still end up calling `error()` with an empty string.
> > >
> > > The transaction_abort implementations of the two builtin refs backends
> > > will not use "err=E2=80=9C because they never fail (always return 0).=
 Some one
> > > may want to implement their own refs backend which may use the "err"
> > > variable in their "transaction_abort". So follow the pattern as
> > > update-ref.c and files-backend.c to call ref_transaction_abort() is
> > > safe.
> > >
> > > > Furthermore, it can happen that `transaction_commit` fails, writes =
to
> > > > the buffer and then prints the error. If the abort now fails as wel=
l, we
> > > > would end up printing the error message twice.
> > >
> > > The abort never fails so error message from transaction_commit() will
> > > not reach the code.
> >
> > With that reasoning we could get rid of the error handling of abort
> > completely as it's known not to fail. But only because it does not fail
> > right now doesn't mean that it won't in the future, as the infra for it
> > to fail is all in place. And in case it ever does the current code will
> > run into the bug I described.
>=20
> If in the future ref_transaction_abort() fails for some reason, the
> err variable will be filled with the error message and the previous
> error message will be discarded, no duplication will occur. So I think
> use this fix is OK.

Isn't that assuming quite a lot about that future code though? It
assumes both:

    - That the code knows to always populate the error in the first
      place. Otherwise we may end up with the same empty error message
      that you aim to fix.

    - That the code will know to overwrite it instead of appending to
      it. Otherwise we may end up printing previous errors a second
      time.

Both of these assumptions may not hold. Current code that does write to
the error buffer for example will always append to it, not overwrite its
preexisting contents. And it's likely that future code will do the same.

Patrick

--/PQGdahQVGhiV+Pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU40CEACgkQVbJhu7ck
PpTL9w//TEjEfNueqjU/TYnB/4StyawwodOnhw9l0+nT0FC5vU6Z5IfhjrmbSLj2
OLxOoEmWbGytRkBc/QQGAigDsWRse2qZrjycPM0YkN3LYYcOj7fD1K0p3OBWcD69
adFX/xXz1fbvy02vRmpHxXuR0n8FdXP4eZ77HnsXgs9WVo/+yeodS7GRfAFAGhkQ
7mArO5WeDdWM1WJwrGSJv7FSM1TnMd4nD0YrcpjuY2o7IXNw5UndLA9wDC8gG3tg
DA+5e67UfUFie7VLt9JU+S/UYLhHdjQWIQoC+Mg1yi1S9LoYRZdPXcXc7Cdjf5vG
6O3VnecMqbBCcA2YScy6iGckNTB46xc5mZPgPlelqsrSgrU6O+69suRfSWMTz9xB
kQqDMJGUksh+3AOKYDiKLpTN9YCw1C4pJtZNPyfikRoCoXqP6kCIwanuA979ofuP
IYtc4cv33O5heWk08bZqMxZSRAauFmeraMhIawGgQD+kpZgXZySnE6uu/TdXR8aS
b58ydh7FxR6JvKMVjh7I9j4aSq1Qj05qiAJ+C6F5/CrmtELDxRLsVuvnARmNnal6
0uTdXB1q+byrf2SfRQkama7QzGzocsVhM44JzrtGwH/mNQfUofLMmpHxFjzmIo12
VOr8UlC1F/PbOhGcNtmZY0uhyc8nv49qhD7SWZm/QHqXoFOkmhs=
=oASK
-----END PGP SIGNATURE-----

--/PQGdahQVGhiV+Pz--
