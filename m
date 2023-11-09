Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D71101FC
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lY++Uyqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZgLjAjR"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D6C111
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 22:30:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E1E5C5C0301;
	Thu,  9 Nov 2023 01:30:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 Nov 2023 01:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699511409; x=1699597809; bh=73
	cBPRGbULxFZVm3R+4y5TVyEyuM+K278GtTUvxo+Es=; b=lY++UyqskIhoefbchE
	tJvnHGOZ4gHbazhNp9erEx/NVrr7FzGxknvJeKHj6d20MZ9VvNVYP5Hsu+nzVNbK
	P/x8+UGxg7lxJs49H4NiFc7QrThzZyNjR7DMqP1tJGTqbcoa/x2KJxcSbQhDQpiA
	myAmWJbgDjQgDFMjl/m29TPxdPT2N4Gu/w9dAIYoH2R75Lw3t2OWZQa9wKGH7FwD
	MaYOBjIMgSDVDhkSXImZaSaxPpSXFAv3nXijAzyjlS+O8zQmG3dRSdnkvmauHpSa
	FnC1TAmfEh8Qee3qHCjNxsETN0D7JVHKKHMNsSSKTnc26D00TyI8OvNuGDvJcmry
	cj7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699511409; x=1699597809; bh=73cBPRGbULxFZ
	Vm3R+4y5TVyEyuM+K278GtTUvxo+Es=; b=ZZgLjAjRe+1gsj8/Z/ZfyTlUBlGNN
	qbHJFmqWWA8APN7WtEhNapom6XLSNgWFw0yDlVKaGoCwJI1yYHdNPv3DCwzFIitu
	wWPmNegh6CGogUwu0jOSD3vTQf4jmsHBuqkKvnSp0Oqfxjf7nroqIsIkaIMlF+Od
	U/nWx52HH1TU3sHgGok36Et7w0fNGqlBKVQU4411ejMYrJjQEkw3WwBJMlD7QD5F
	sD8nIZoo82jw3DHJv8vkIwO99FGtThhyyxqZnr0H698UzOKS5UvEzFJVPkSK44FZ
	gmFQU+jY4BxnswjFvEMbwwMoJlVui234X/A09uEgda0vTImR9bQvTpfeA==
X-ME-Sender: <xms:cXxMZWVsN_YRhWXoFB4wKB9uxR1CABAq05nai-C18O_-tuoS8vLhyg>
    <xme:cXxMZSkBDmwjBRgxTqCSz602GEfLqy770X3miJGmRR3XoJYr2NhFsX13ONvDrDewJ
    MLFyHNjJ6B04xHhhA>
X-ME-Received: <xmr:cXxMZaasLS6ORs_czvWq6mqztruhTXiTMo0qiD3oujB_yK23xa2M8RVaKEtRcYorGfLhq4QskzCMueqqPcU1r-v0xcQ7ZZym2d2xyRSAW338AIEf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedugfekjeevleejhfehvdetjedtteetge
    eiteffgfdtkeeltdekteeghfduveefffenucffohhmrghinhephhhtthhpuggprhhoohht
    mhhoughulhgvshgrnhihfigrhidrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cXxMZdUSexTpIAtn83v0wio-pFzpSbbJQECM-Hl3XlM-Wy4WYIaqZw>
    <xmx:cXxMZQkn8pmYpmPppvh-tXEtiA7kOx5kpkITBcH9cRfgkUup0_wq7g>
    <xmx:cXxMZSdRX2ZT7waymWWs7m9hPmbZ-DibWL0E7c3JROhZy_2TRZX4aQ>
    <xmx:cXxMZcvDrzOmsnjpduAG5St__8G1C3skd_F1lq5IS2X6Ib2ziTJvvQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 01:30:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 247c807c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 06:29:42 +0000 (UTC)
Date: Thu, 9 Nov 2023 07:30:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <ZUx8b9LequWRRlz3@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
 <cee8fbebf84422f73c38d55b5730053121b74e0f.1699455383.git.ps@pks.im>
 <20231108165426.GB1028115@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjKxdrHDtUaUSxV+"
Content-Disposition: inline
In-Reply-To: <20231108165426.GB1028115@coredump.intra.peff.net>


--fjKxdrHDtUaUSxV+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 11:54:26AM -0500, Jeff King wrote:
> On Wed, Nov 08, 2023 at 03:57:19PM +0100, Patrick Steinhardt wrote:
>=20
> > While it is possible to specify these paths via `LIB_HTTPD_PATH` and
> > `LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
> > to figure out how to set those up. And in fact we can do better by
> > dynamically detecting both httpd and its module path at runtime:
> >=20
> >     - The httpd binary can be located via PATH.
> >=20
> >     - The module directory can (in many cases) be derived via the
> >       `HTTPD_ROOT` compile-time variable.
> >=20
> > Amend the code to do so. The new runtime-detected paths will only be
> > used in case none of the hardcoded paths are usable.
>=20
> If these improve detection on your platform, I think that is a good
> thing and they are worth doing. But as a generic mechanism, I have two
> comments:
>=20
> > -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
> > +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2' "$(com=
mand -v httpd)"
> >  do
> >  	if test -x "$DEFAULT_HTTPD_PATH"
> >  	then
>=20
> The binary goes under the name "httpd", but also "apache2". But the PATH
> search only looks for "httpd". Should we check "command -v apache2" as
> well?

Doesn't hurt to do it.

> This also means we may run "test -x" on an empty string, but that is
> probably OK in practice (we could guard it with "test -n", though).

Fair, will do.

> > +if test -x "$DEFAULT_HTTPD_PATH"
> > +then
> > +	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HT=
TPD_ROOT=3D"\(.*\)"$/\1/p')"
> > +fi
>=20
> I was really pleased to see this and hoped it could replace the
> kitchen-sink list of paths in the hunk below. But sadly I think it
> depends on having a configured apache setup. On my Debian system, for
> example, I have the "apache2-bin" package installed but not "apache"
> (because only the latter actually sets up a system apache daemon, which
> I don't want). And thus there is no config:
>=20
>   $ /usr/sbin/apache2 -D HTTPD_ROOT
>   apache2: Could not open configuration file /etc/apache2/apache2.conf: N=
o such file or directory
>=20
> So without a system config file to act as a template for our custom
> config, I think we are stuck with guessing where the installer might
> have put them.

Indeed. Also, paths like `/usr/libexec/apache2` wouldn't be possible to
be discovered via `${HTTPD_ROOT}/modules` anyway. It's kind of a shame
that there is no way (or at least no way I know of) to portably discover
the default modules directory used by httpd.

Patrick

--fjKxdrHDtUaUSxV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMfG4ACgkQVbJhu7ck
PpTydA/9Fe+ThPmkuw9bbdTAOY7Edik4PlpajF53z5uMo0xkArkU+s7PTzHkqkEg
XEpNnE8jPGot2KHuIQXIIqeHMQZapx66sNbAk0cfqQijiw8wyQGN1upeQ9Rakqkt
gFfbSD7G3LpXS6pRbNENCJ10Dt96iHd7Ma+HJWLZEXdrM2kbhlWuAyLvP17aQHUC
eSzxylmgCxEnbSzpznauOQsOAO/1hcpUctlixaChzT4GkqAyQR/nmjfx2bgUHt8N
cwL9ZP8VYTo94uy0tsqMa4u8MbQAikBn8byjc/58mmHMolH0aHdTLERICKTyuVhm
87i8Cl+1b/HelC4zaB04PHy0NkKGv05VUH77cJ/YZaovM8lOpFjXTv71guIvb0o6
LhIfVCg06jpnMpLRfmG1IRi4PrHRzZmnPurikyFyyJtmAJCGJx0nWA82vNokxs4O
ixJ4BmrrHJPbsGaXeQKYPduGiZ0V3yGymOBMXf2gBTCzGLAg/klExLeS1apFm92G
xgRrNsqPJvkkdaD2Iay1QNX0sRHxptzh0XCmlJHS5wdPRA+fa+n2OxSnKDHUJiQH
RESGZOhtwQWFDeIln2+MQn+BAAGcP5z/D3yeY7JUvDDdK2UrBE0IskVwOGIbKC/2
wVQW/tKDEcpevmXAxNASMhv7g+QWXcRJnmWs/4q9RGv6wjKdS8o=
=yuhd
-----END PGP SIGNATURE-----

--fjKxdrHDtUaUSxV+--
