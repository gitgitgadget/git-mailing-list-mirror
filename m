Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC019D266
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fp45jGnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSZxjUjN"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FB1706
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:19:53 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 4F093320099B;
	Wed,  8 Nov 2023 02:19:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 08 Nov 2023 02:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699427991; x=1699514391; bh=eo
	eU3dOkhAnMjSzYUfKY5D2YrfXjkK6dyFIrHGrUelA=; b=Fp45jGnWQrf8Y9MAs+
	KlqYPF8uDDE4lWIZDlQGJuLCghrmXD15kixV7zNgzenoHqdirYCQ5pT8E9MfQpZz
	1ZaYitIw7Uigtn92FEEe1V2WZsvoECVKRAkvqwIW5XERW/3N1X3YoZIAKlcUYJut
	VvGH0wMdC1f6QtTBAxSFi1qEjjHN7/ZM6HYMDA641xuNM6piavWp46mVzJ3C2MUX
	bcGcSyjhxtuKAuHzNNVo54ySEnVmVjH2I6Hr2t7tfZlZ0Kj8PQLDkoUohLNS+X7/
	aai+rtJ+RXwKoZNvRKVOcFaYO21Ay7pEcN+7Y/aDVq6QAwBEid1k3KQgwZH7cetg
	aqWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699427991; x=1699514391; bh=eoeU3dOkhAnMj
	SzYUfKY5D2YrfXjkK6dyFIrHGrUelA=; b=GSZxjUjNbxDlTClfwNHZQpWoNN4ok
	qE3IdnCaCTq5I3VBTYASvp2oz0YG1yzZHQ3iqEJEaRP+H45tmPFPgHzE9aCiLaNG
	YivyCp81i259cv/pZ5gXyXo1QZAtSjshfp4EnRaLBL3bRyajVjv5iFxI//cpR280
	MN8zIGMkWnmxXjfRlto6ctrJmI2U+0LVlbfAH9VLoL3QUcYBrGdoy/J8G7mTlLkL
	atNVfcAd1jYDxXGmJnzJaJDq0M3LHl0WRfUDQX3OLi/m26Y4vhAdSX1peGoPv3iF
	68VbpfuaSsbPQiUc9ifIcLUhbZaz7N+zEYtCZmpDDM9OZq0LpttIqRKfQ==
X-ME-Sender: <xms:lzZLZcSjW6iR3FrWhNIdwnrqOutc8hCbkKZmyo8tpUj7_rVaPz_RSQ>
    <xme:lzZLZZzuzDxzm3CWWg7ddq6x_x1JFHUzFfzjVUdTfkXJ4ZVlISqGaqrFZ3va3RqMc
    bdtQTJKgXocmwQilg>
X-ME-Received: <xmr:lzZLZZ0Y0jgtA-LtUmYiYazngMdrTXamRboKomer1xBR0ZU-VM1x6Fb0luV1f1_2mINcNACktJFxAIhX-lAvKXrg3r10WQOWCHfTPLd_cwjC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:lzZLZQD1MA-jWzupoNV2dNP-9Bqoq85XBIFMDaAd8XQPWjNDz-01FA>
    <xmx:lzZLZVgVOoy_Um1shXKLcDoiubsQDr93KKhN3zIPsm5o8I87gfeBrg>
    <xmx:lzZLZcrC7mGrZEub2rYZpME3OQi_pxZvQcPeKecY_ubGnMCZjBS23A>
    <xmx:lzZLZYt1QaGOgHdR4ymMGw6nmfTDXpOA5IZfoCSKuUaT4P3QTpyKuQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 02:19:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1d5c600 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 07:19:24 +0000 (UTC)
Date: Wed, 8 Nov 2023 08:19:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Victoria Dye <vdye@github.com>,
	Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
Message-ID: <ZUs2kxOEr4vqCJi0@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
 <ZUoWWo7IEKsiSx-C@tanuki>
 <cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
 <xmqq4jhx7x8l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6z3IB9SPbAKK3nQ"
Content-Disposition: inline
In-Reply-To: <xmqq4jhx7x8l.fsf@gitster.g>


--q6z3IB9SPbAKK3nQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:14:02PM +0900, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
>=20
> > I think `^{}fieldname` would be a good candidate, but it's *extremely*
>=20
> Gaah.  Why?  fieldname^{} I may understand, but in the prefix form?
>=20
> In any case, has anybody considered that we may be better off to
> declare that "*field" peeling a tag only once is a longstanding bug?
>=20
> IOW, can we not add "fully peel" command line option or a new syntax
> and instead just "fix" the bug to fully peel when "*field" is asked
> for?

I see where you're coming from, but I wonder whether this wouldn't break
scripts. To me, the documentation seems to explicitly state that this
will only deref tags once:

    If fieldname is prefixed with an asterisk (*) and the ref points at
    a tag object, use the value for the field in the object which the
    tag object refers to (instead of the field in the tag object).

So changing that now would break both the documented and the actual
behaviour. Now whether anybody actually cares about such a breaking
change is of course a different question, and you're probably correct
that in practice nobody does.

Patrick

> An application that cares about handling a chain of annotatetd tags
> would want to be able to say "this is the outermost tag's
> information; one level down, the tag was signed by this person;
> another level down, the tag was signed by this person, etc."  which
> would mean either
>=20
>  * we have a syntax that shows the information from all levels
>    (e.g., "**taggername" may say "Victoria\nPatrick\nGitster")
>=20
>  * we have a syntax that allows to specify how many levels to peel,
>    (e.g., "*0*taggername" may be the same as "taggername",
>    "*1*taggername" may be the same as "*taggername") plus some
>    programming construct like variables and loops.
>=20
> but the repertoire being proposed that consists only of "peel only
> once" and "peel all levels" is way too insufficient.
>=20
> Note that I do not advocate for allowing inspection of each levels
> separately.  Quite the contrary.  I would say that --format=3D<>
> placeholder should not be a programming language to satisify such a
> niche need.  And my conclusion from that stance is "peel once" plus
> "peel all" are already one level too many, and "peel once" was a
> very flawed implementation from day one, when 9f613ddd (Add
> git-for-each-ref: helper for language bindings, 2006-09-15)
> introduced it.
>=20
>=20

--q6z3IB9SPbAKK3nQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLNpIACgkQVbJhu7ck
PpQm1g//dcxorqRVq9MPT2g562Xq5ku+7tFziL76lyrIw7xLbZafUS1N4yMxREPN
IIeqRIEZMIe9nAJkt0RmLM4ydejoox6AXxlTRd+AKv48ipIas2mfMg5DBepJgkgb
uCcLdOj7vu4ODSU0x2E/B9RotNyw9lFw64MmmT183En0sazY+w1av5EroZoozlhl
dZE2XgOuKeoPPUA5BIaaULOWvoP37g7OW+NYPu4tkm90MHuDB5qXOSTvLkZywnIh
UxOLrr5Z8lmo4P1GH3SXWvRuvBILfD1nLhx1pYiGilmeK9esTtPXw2pu6HfoDZz2
Ed6cYDRVBNlx+ZJM7AfdAj0ocQ6MqU0KoGLhBSkDUhm9bpupqGfu/OqdJCiJEXKr
M7mgzfiHmUXQqOjPGm+A94Xbl9F/djxA8GybUOqx4GVkkCfb99qVsVMvsNR9BQbG
jrnLepOsCSX4yBxE37NzsKzf0nVyHngr/gTx7CufJTg7LKg558r4jdd8G1tkGsr8
9QwJWv+OIvAsexeVHkkUYfytvzVJTghtM/3VxnV54PA03FTjm9pvS7kIyBdsbg9/
gBITaPHwIDSo380iWiUUin11xikqyrFbFmO8aTIOkjAYM9dI1uPbkg1UA3Iqa0rH
V+FV+ic/TolI/ZEsrDwFjnO4gZu/EwXY8SHVYAtHjAkM+1Qtp2A=
=wAs8
-----END PGP SIGNATURE-----

--q6z3IB9SPbAKK3nQ--
