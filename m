Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z5nAFTl6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DeTbi1uH"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B4B0
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 20:10:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3622C5C02D7;
	Mon, 11 Dec 2023 23:10:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 23:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702354205; x=1702440605; bh=NJ2WL6pKJt
	Mac2pGBsKsFuWcR6B61cLK2J9RGPnsxTE=; b=Z5nAFTl6+YV7wQmqCpIcpxfmju
	pIDphhBBQcbqnN0+5Tzn/HC869xNOmJzOqioh4em9k/waS1olU6muD4a7s6mffcN
	FTppPAYn/HdRVDhHvmulj6b7GRqP/T4UHhoxYql813xgl5/rmyCmcaSAHpi/dUQV
	XZdURTcGRna1ubMhZsJ4hKp2aiC//itP6kv4TYhNRoxYWRYAxNhzckkzpL/nm26f
	2q+VY8wNm26FVK+Af2MlDA1WgXaXclmzAdL4iiIa5EOaEqyf9gR78pi7v7YVZZ3V
	eq2+glhq5y0cKwuXZW3o3PEOMVofIgAUqOTA97nvLaRMkY8QCaQb4A+Q6usA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702354205; x=1702440605; bh=NJ2WL6pKJtMac2pGBsKsFuWcR6B6
	1cLK2J9RGPnsxTE=; b=DeTbi1uHdVzE8lSupmgiTcYJ/vRlqrfQ5sIY7VgKRJfH
	4eq40zXABWSmwIbA/bHLNkw+rv7+6+G6kVHizo+gRlt26vcKBLoq8V4t2sn4wKjB
	ExR/gKYKInv/4w/reyWbijfsrD3MxanBvJqupJ4SVSXzQdTp+qsyIIu1WYMru0Hh
	o+yAKTXyEpH268ysZbINGqhO97+SeF4KlNx20/Fnx7fmJ4QsUlUD8a/8pwP90hA/
	cYkOwARfmwUrseE4tXKs4tqJiqF9prhqpagjbzeh2DAso0g/RLiIWrnR+s/F0sEp
	eXqZT9CLtfcJvLOTCJa+resWdZ8OPW+E4DpT0glf3w==
X-ME-Sender: <xms:Hd13ZbyvoPBgeU0uy3-C8NoRHy8U3cj92JVYbm4tQUmWjrJo5CpE2A>
    <xme:Hd13ZTTXkyM6MMqzF-ONFQl8UBeDleLGS4FDPrxBOMUgE6B1k7vfu7yRemMd7LVAh
    eaGzJjjBTpvDuF3LQ>
X-ME-Received: <xmr:Hd13ZVWxm2wHcDFmbupEeVbIX6DpoybMEAi4Wv4OBpYHra9ZEfZcrlXAsAqpfeMI5EWtPwBukKKHMtD9EUsAVl54T0LbDSgBqMsdfgXVnImtQlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Hd13ZVhL3JSGHygOKzCMpqm8jJkJMdIhzzwwvYf2xxUMlpW0Mg0V-w>
    <xmx:Hd13ZdDo4E5vHHn75kDBBsoo9ATXHM8-80AzEtf_D1bEKULZooHXog>
    <xmx:Hd13ZeKclCfXwl9GqQ7JIs3hA97Gulh3QV05iu77nS2Jf_E2Au5chA>
    <xmx:Hd13Za5pQKqWJ02kBxJoiOBx2IDB8ctl-q3Gz6MU6vECoAylTKAqZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 23:10:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8fc653e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 04:08:25 +0000 (UTC)
Date: Tue, 12 Dec 2023 05:10:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 0/7] fix segfaults with implicit-bool config
Message-ID: <ZXfdGYUyJz4bnkQ0@tanuki>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <ZXF-7AMZ_SBltplk@tanuki>
 <20231212005228.GB376323@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ijHytg+LI4Yj1MSE"
Content-Disposition: inline
In-Reply-To: <20231212005228.GB376323@coredump.intra.peff.net>


--ijHytg+LI4Yj1MSE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 07:52:28PM -0500, Jeff King wrote:
> On Thu, Dec 07, 2023 at 09:14:36AM +0100, Patrick Steinhardt wrote:
>=20
> > Thanks for working on this topic! I've left a couple of comments, most
> > of which are about whether we should retain previous behaviour where we
> > generate a warning instead of raising an error for unknown values.
>=20
> Thanks for taking a look. I see what you're saying about the warnings,
> but IMHO it's not worth the extra complexity. Returning early means the
> existing code can proceed without worrying about NULLs. Though I suppose
> we could have a "warn_error_nonbool()" which issues a warning and
> returns 0.
>=20
> Still, the "return config_error_nonbool()" pattern is pretty
> well-established and used for most options. I would go so far as to say
> the ones that warn for invalid values are the odd ones out, and probably
> should be returning errors as well (though doing so now may not be worth
> the trouble and risk of annoyance).
>=20
> And certainly there should be no regressions in this series; every case
> is currently a segfault, so returning an error is a strict improvement.
> I'd just as soon stay strict there, as it's easier to loosen later if we
> choose than to tighten.

Fair enough, I'm perfectly fine with this reasoning. Thanks!

Patrick

--ijHytg+LI4Yj1MSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV33RgACgkQVbJhu7ck
PpREwQ//as54RShdVPw0w13VQVhLyC2NWZ2oPOHvKsL9xbHeCvTQaL3qjr8Y1u6s
24urkKhyMi28QRWtLLsRG0jN4uCpm6j06nGsh88ky99bhhXUzMArX5vsxH6675Zz
czX+1Duh5n8Unw/wzUvH/nYI3umQeGQAiJqzEXGR5GTxpgav1s5gMCxZteCWNni9
c4x8E3x2mpSWqtM8PCL3cInah9B7m+C9cOjXMSQYVVkxliExSCylyPQ1qEKGK8RP
fFABajialzH6IJG7l6cyJg3Zt4y3v2gy2ggpZPCPSZz/Tzc+G6M0T3fLhOxFoWIx
tMpqSZvPYUpp7YMo8nkuGfXHMwaqSGSduF4CXRSNdxeP8vLNzNWHdFGLtBVHI3m3
ahAT7nVIIPYWKC/LeL0X135aJ/wchDrM26Iq+TP7WU34hrQvbnvN+e3XSnqu2IUY
12Qnt7IdwOrTevYg3+yqdlKZPVZe83sowynXrJ3GC73BD4+5lzrAy0R/nIbFYwuZ
6SbvIsW9aMG3DvoTEc2kijC1baAPnNXzbIOQQjehnSIxmISS4/FnjMlMbZuEJcQd
UQWrkVGdMiIIPKQUXAtG0DugLtjQM6DRij29N9+kaCAJ8MfTCfwe3ib4sbCOxX0I
M9u0rv2+i2VRiimBz6ffymPlqBLF3fH35OGh1CmCchrnAjYdgpA=
=Sm9S
-----END PGP SIGNATURE-----

--ijHytg+LI4Yj1MSE--
