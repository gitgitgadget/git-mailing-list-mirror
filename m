Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D06313FEE
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qDqwoaYd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUqVLwe8"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0428110
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:18:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7BE6E3200A80;
	Fri, 10 Nov 2023 05:18:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 05:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699611525; x=1699697925; bh=MP
	mAFZk34bRokc9DJ9DvMmCepsttpeoMSIzFBZyM++E=; b=qDqwoaYdJF2yi8GoRg
	vk/ctsxWO4ChQB3g0A3JkraiMJZ8dulq/fETD6lTzjgvd064dn6zybzAldebgt+G
	vkuV4zo49azPYr4wUBME9pVEdTBFS+8imo1vCxKFyTvMzwSk/RL8/nY9ihtvJ8Bq
	tjg7l5l/W0CkeYjpNZ+qPzc3CTcPitnyloP7mWCNRZ6Uf4TLHPEmr1j2gf6RAYUE
	YXstyogrhwC09W+rK2j2xZKuBkMACHdwLseO8EgDR1sJUzrwcYiftogCSZIcF/l5
	fdcnkvxR9WTlWoY46IXclFPpwe9vG4jUt2qZx09v8J1ZkI4tvXN8ii1wB/g8eY9F
	Y+1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699611525; x=1699697925; bh=MPmAFZk34bRok
	c9DJ9DvMmCepsttpeoMSIzFBZyM++E=; b=EUqVLwe8KxzC9lzVcXvTafTpihJf1
	3X+Wiz5qEDk0CF1WAoOLIXVFzxjUdx3181nqHN7ng12aawCEyEetGaFKzHA1pARs
	I8Z1w3pqtDnpyuuJavq+qdn/3WBN9C052tax1PjQ4y8x8o80AUrR3GS+zLYadJN9
	PMWcKQQkvQ5kR2EK95jY+K5aEvJfLmM2pl7Nj/QAG+HsYGbLrU2fb/jz9Ke5DYOs
	iLtvwO77THqV5Ukh9ClmvMf6YmOxqn2FxRFDxoI7wJ7gOLBg1aZxzWBe1LkLL6hX
	tV3+itrVwv6ad7Pt82TflrogVsPD632VYz59FM0O0graqRq6ITuRW1vGA==
X-ME-Sender: <xms:hANOZcQbaz2_26FOUQH9FBJrkhV5k87qO6wYh-433YBEOmWYlap3dQ>
    <xme:hANOZZwGMzpS0GwNWJ-28yx2XLWM1a5TwMNUZThveXJYDMYbCG1ecQsmKxJCPhGxe
    zNg5KFpGYCcfqB6Mw>
X-ME-Received: <xmr:hANOZZ1Q2vaM1ipJNP0VwYaqA4V_LNn3jAn9pGtnbZ4aetofma0D9tUsbxUITCeCMX24rjIfmixiesi-0UjxXmyJtKSM83y0IL1iA9V_76_rf4-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:hANOZQDNAPtPgWLBr58MwZuuhGk0sSPnZaTbjuvq01HKzghjzmaI4g>
    <xmx:hANOZVgNyc-g7jv7XvrxUlPiMwXGduApIgNdNIAs--hdUQLqR38lGw>
    <xmx:hANOZcpanjizvLXClQunGPUSFc8MoPpSpWpE_dgpbsrxvS0KVYXObw>
    <xmx:hQNOZVZ4xJalXOdfeEfd8EkOmXDn0oOWn7Nmq8qw5e2ktVBSZzoycQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:18:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 364098e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:18:14 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:18:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] contrib/subtree: stop using `-o` to test for number
 of args
Message-ID: <ZU4DgaVfLhSags-r@tanuki>
References: <cover.1699526999.git.ps@pks.im>
 <b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>
 <20231109185515.GD2711684@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hEEet0qe6vcSPWYH"
Content-Disposition: inline
In-Reply-To: <20231109185515.GD2711684@coredump.intra.peff.net>


--hEEet0qe6vcSPWYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 01:55:15PM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 11:53:35AM +0100, Patrick Steinhardt wrote:
>=20
> > Functions in git-subtree.sh all assert that they are being passed the
> > correct number of arguments. In cases where we accept a variable number
> > of arguments we assert this via a single call to `test` with `-o`, which
> > is discouraged by our coding guidelines.
> >=20
> > Convert these cases to stop doing so.
>=20
> OK. I think these ones really are safe, because they're only expanding
> $#, but I agree with the principle to follow the guidelines.
>=20
> >  # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITOR=
Y]
> >  process_subtree_split_trailer () {
> > -	assert test $# =3D 2 -o $# =3D 3
> > +	assert test $# -ge 2
> > +	assert test $# -le 3
>=20
> It took me a minute to figure out why we were swapping "=3D" for "-ge". It
> is because we want to logical-OR the two conditions, but "assert"
> requires that we test one at a time. I think that is probably worth
> explaining in the commit message.

I really hate to admit how long I've pondered over this patch series in
total, up to the point where I did a `git rebase --reset-author-date` at
the end just so that it's not obvious. So I totally get everyone who
needs to stop and think for a bit here.

Will adapt the commit message.

Patrick

> > @@ -916,7 +919,7 @@ cmd_split () {
> >  	if test $# -eq 0
> >  	then
> >  		rev=3D$(git rev-parse HEAD)
> > -	elif test $# -eq 1 -o $# -eq 2
> > +	elif test $# -eq 1 || test $# -eq 2
>=20
> OK, this one is a straight-forward use of "||".
>=20
> >  cmd_merge () {
> > -	test $# -eq 1 -o $# -eq 2 ||
> > +	if test $# -lt 1 || test $# -gt 2
> > +	then
> >  		die "fatal: you must provide exactly one revision, and optionally a =
repository. Got: '$*'"
> > +	fi
> > +
>=20
> But here we swap "-eq" for other operators. We have to because we went
> from "||" to an "if". I think what you have here is correct, but you
> could also write:
>=20
>   if ! { test $# -eq 1 || test $# -eq 2; }
>=20
> (I am OK with either, it just took me a minute to verify that your
> conversion was correct. But that is a one-time issue now while
> reviewing, and I think the code is readable going forward).

--hEEet0qe6vcSPWYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVOA4AACgkQVbJhu7ck
PpQdDhAAqxAsatmh53cpDi+k7X8SYFETpqLZ73SBZtL/z6n1JHpVjmsNgPWGdPbg
aRkTdKLJX9+Z7mZ0SpA9vxHvZhn+Xia8z5Nvldi3h0XL8tpUbN3IgdXsx4C393Yn
dM5U0l0litXUW43UAVgbJ524gAO+uTyCLjfFuMYzbKK/aa38DVyrQxBAL+glP09g
scoezylM+b690mJLFV78QHPEfbn1/89Ctbm0VbybPyog1xlkK2ETZO8y53EovDvK
0c9niBiE+Fk5TpThSFC5bXeWofq/ZDC/kVbpzXTwzUrPY1QkkqQBnCgDov4sdUOu
4FqZxO6inky8oNNahblSd8gtFv8/V56OiCz/prN3960bNOUS7UfoJRbKdQPLCfn+
FOE5fGuGZYc55T1zToFWpPtAGVHuaYIND8R+5vsfSDL5yHdXJhU6V1b+G8+iDuzE
HgpvTCPXF2ZD69Mv8s8ZvPD7n9xXuhRYNXS43k8eCvZ5/YZQWC7CK1Y4E9vPDaQV
rbJPSw31bPe3GXC+1FnWZ9LfgLWtywljl2gRlLz8i76xNcwEX+XZPUHAhVmrgttn
TOftPYZTQH+CQXj4W6tGBT+z1Zcjtg/FAfQ4queueAFB+SJspR5R/dXybsWnNRE6
2jOhAkSW1ZyGsnPfOZLyMMie6AzPRKNCux/fSmfPiYIjRSa4dC8=
=bAN6
-----END PGP SIGNATURE-----

--hEEet0qe6vcSPWYH--
