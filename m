Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED411C8B
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aizy5v03";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZkj0NbZ"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524D210A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:43:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 2C070320090A;
	Tue,  7 Nov 2023 04:43:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Nov 2023 04:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699350190; x=1699436590; bh=Jb
	AenFfRMIO1j9AGRgEv8TEAMtVw9inscDvbqVo+38s=; b=aizy5v03xrePpknzG8
	OeO3mlFmJyU21SlP7tNbzRonUliUDCaqHom1Iy2iykYnEfBt0MkVVfI1R34vLU0/
	J5z9c6BlJ/k0fJb/7+ah8LQSUWDjgw8lh06bSyR8S581Y5QFUSiZ739QlSFB+RfH
	gWb7sM8EFcYXE20GQzQy6hD1xXbqUta95+I/ByepQGfC8UnVMPAMycWq4sYkqlBi
	cWya2BoAdrYw3PBAbnfwQ/VT2/EOc5/pP8cAbBY5PVHMUjvwEax9DrE5NLuqohWN
	xYmZlkALBJhow9aIr4osSv4bnBpxInYki3WrEXHFNouRlWDa7doI5wQ0NaQdCL0E
	ow7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699350190; x=1699436590; bh=JbAenFfRMIO1j
	9AGRgEv8TEAMtVw9inscDvbqVo+38s=; b=rZkj0NbZZlD82JHpYACp1gp3kX81V
	vuYhTUKFgF4t0+8HDwBs7SQ2AQDCJuFW+cF2w/nlgWmi9VHlYYbbyFwDiewjPP+8
	p1z4XS5kYxdT4RKaUPj5jM9g+b358bemcCE1vkN1954Fyzum3Mx+R3B/h1CyUx8g
	4wgp9hJCP4DFzKn8blmaUyEDbHK0lhXr9CKno73CMo1witzaSUiBb/y9nJiV34Hp
	P63PNeKKtyocQEL3ZArnRoMBDja9Sl+JABC3ulfniKWbGDr71H9TtS73xV4u/4Pb
	YQR6/BkNQ2OiMlixwyeZA77ZT7DQcYAV2aKwlhkyUeyYL/QwILWHLZWpQ==
X-ME-Sender: <xms:rgZKZd2llUquIDpiOxWWHX39Q85tTnfNB0uiiMDGq8bOrPXv9Ur4zg>
    <xme:rgZKZUFJbgr_Hw2qnjx2c3XQS4enEkEPzyJmMW7OfZOQyWTjELlTMyOM44D_b78k6
    cgiPrXvoeiAkmUiNA>
X-ME-Received: <xmr:rgZKZd7uEWRj4uM4-LriUz28sH3ALKwXIYQmZKEyL_rzGzOE88-l3yv-Zk_U35kuwvqLdp-L51p9wNH5haOUuzRqLap0oG2j2YVNDs328L8Si5It4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:rgZKZa2UybUS5OXaZGM6nFsw8Vx1IdcS3f7TOn2_M0znUvGoxcpp7Q>
    <xmx:rgZKZQGAJ9R04BwXstNYYQXAfqWzQFVCmojCRyzRlbRHFX3MYctWjg>
    <xmx:rgZKZb8CpTGHYA0tuvaUxFkQgHpfQWX1R023r3b8UtmQU_Hzf2ihFQ>
    <xmx:rgZKZVQsiL1MDAWThUVYjre3ME0xGvJA9JyxTSaXGFr39P_DXxUttw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 04:43:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 600625b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 09:42:45 +0000 (UTC)
Date: Tue, 7 Nov 2023 10:43:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] revision: exclude all packed objects with
 `--unpacked`
Message-ID: <ZUoGoYpJFvGSll-u@tanuki>
References: <cover.1699311386.git.me@ttaylorr.com>
 <20231107040235.GD873619@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kxu5DdBTuQtzhgSS"
Content-Disposition: inline
In-Reply-To: <20231107040235.GD873619@coredump.intra.peff.net>


--kxu5DdBTuQtzhgSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 11:02:35PM -0500, Jeff King wrote:
> On Mon, Nov 06, 2023 at 05:56:27PM -0500, Taylor Blau wrote:
>=20
> > While working on my longer series to enable verbatim pack reuse across
> > multiple packs[^1], I noticed a couple of oddities with the `--unpacked`
> > rev-walk flag.
> >=20
> > While it does exclude packed commits, it does not exclude (all) packed
> > trees/blobs/annotated tags. This problem exists in the pack-bitmap
> > machinery, too, which will over-count queries like:
> >=20
> >     $ git rev-list --use-bitmap-index --all --unpacked --objects
> >=20
> > , etc.
> >=20
> > The fix is relatively straightforward, split across two patches that
> > Peff and I worked on together earlier today.
>=20
> I'm not sure my review is worth anything, but this looks good to me. ;)
> I do think it might be worth tightening up the docs as Junio suggested,
> but I would be fine to see that as a patch on top.
>=20
> -Peff

I also read through the patches and agree, this looks good to me.
Thanks!

Patrick

--kxu5DdBTuQtzhgSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKBqkACgkQVbJhu7ck
PpSUZRAAmLN3vheRNfcth6lDfp5htsRDcK9cwtdA1YRX2fy7Non3focXvKdFs1M8
qVKza7bbBof63GXyZKOkYkHDuOJV764zkBUw+guNAU7/P1Snh/P6f3Nyu5Ai58J2
Cm3026xjpN9xc/kurWEZfJtTW7wcQNwLXfy0mZ42nOTY7NvXOx7YMn3aChbrZwX1
kbXZdNoaUG/9c2f1tn3GkOODnK2lB2zKECd8SVdWfBUcJjzYMoN4mnNLLwtZA4S0
Cy4pkAdn+7XMqN+74YadfwQLq1BV9TOIXJITKT2lOQ2hM3mTpgqLYeIL8Xfz3XUu
qlNan4yigQn+zNaYW/e4RMDWjo8G60q7boiQwe1csZmDOTlorV5rssJwT5SFSfrs
mwFaRJKn0bBs0xhswGmb2o5ujTuLEm9QeTvMiJtXVTMnRK8NtTLsbCd8lZsMr/kg
z1AoJYMhouuHEpsBqIaKdPTtCMWWsJd5PBdYQjAw8NBRhyKOJAr+2Tm697mtyB49
W6XoYqST6Zr+V9GQl0Gmt+psF+Wx73M1maJ7c1EqFG3n3wHJ1pdrZqBGR3f/up5w
ozpCZ8DnvOQ07/eLKIEZp6UXiDznTxlXO+P71T5Y8TA1byY0QOCm9JIKPF/4a7kR
RVGBaxcJZ+KEohcGkmQ6RzbMVGV53yUHYTvYyA6LraWBul3ay7s=
=iTgo
-----END PGP SIGNATURE-----

--kxu5DdBTuQtzhgSS--
