Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5A12E47
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NNzgk5M1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwuFs2Pl"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA691BD4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:42:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B46CA32009EE;
	Wed,  8 Nov 2023 05:42:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Nov 2023 05:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699440136; x=1699526536; bh=nZ
	I//KvLB5dqBSfmvbZbdqrlXm9vgLYc1IoQtiUes44=; b=NNzgk5M1Pc+0IYP4VS
	4hu1iFw8vBpHCFRBasCfaklVBa1qRfGca36GKFQUKNR+DxsZisFjzhjKXz+hrVgE
	FukoBVkSOnWk5l8ZiLv4PdjNX4uZ08T68gs8n47TjZKVnO+zjO3WGRPK85IwPB/Q
	kAQPHSJCDdbSwwWhE3qiFigBqI7k4S2gILWcp1Dt3n7Q82KgJwlG/5M2V3T8MVOj
	OjIgnBOsaXE4FIbI+XKgeQKKavxvtpUqr03RWAeI8wR+YBWy9Mrl/tBTXyaetN4C
	GArwBUOxeViuV98Aam2cXXkxxG+IplQ7QxUBZTtO49NpxM9wKT6wDPbrVyctheDz
	0mFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699440136; x=1699526536; bh=nZI//KvLB5dqB
	SfmvbZbdqrlXm9vgLYc1IoQtiUes44=; b=dwuFs2Pl5hCoSgcKNPLXiTFAs2lFt
	Ls7OWFcOVTOGHYawRXnbK3fZ6et/5FxR/VGnZ0zZIAOlLrM2J5B/N3v8UWAWpmDz
	GUS4ROWjfERSO9tJuFuV1BVrceKgGCh16ArexV5MhjtAwKcWaOWuvKBO/zjVSZI2
	SEnAja4wnE7i6NqlJhmdLdtcTQwgl8TtEpWcrj2sWhXNHmR5nYgAvT59G5ZoMTK8
	CIgNHOejYj4Q1dpBIC4WHdjAKCQ+bmN4i8Pzg0UUcYg89yIjwBdy2AsAaJEeG2PI
	8BwUDflFOrA5r1LIgIiTA/RW6rko/w6jrDHwOhJ99boAe85TJR+ZlEfZg==
X-ME-Sender: <xms:B2ZLZU1xK49vN7nobkp8SmNiQSy2yoI-oFvBPdSDyX-tMnaxkdvc4Q>
    <xme:B2ZLZfGHPH46HQCdoZWK4FYp26_0fjh7bPOoW_ydb5a7dl491cofOq4Ih54aga7kF
    hRXA3azgMhAv1HIpg>
X-ME-Received: <xmr:B2ZLZc6_dGlHmLATn-UUMFeDsJivpD2cgEdQ_aZGymnAFWNHv0o_eoU7MQ8A_bWaJquxAuNZseQSJ2w4S-1yNP6mQTwpLLRnzxrqA2MBr71K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:B2ZLZd0q1IUebBs8ThuYC6wSzb30rYzUAqR_4Oj4SHZp8QfkaZZQhA>
    <xmx:B2ZLZXGS2P-mRXEuRd0tphwfW3RigmgVjGM617_80UIa2hrBfVwg5w>
    <xmx:B2ZLZW982gEWIgsNpsM1RnAPe51gIGlAkbahdYCrMIfcJTOXd6b4iw>
    <xmx:CGZLZaPIQO4RT8kAXII9gVyY7sUg2MpTPyFq1_Fa1CAjGiIjBHxhig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 05:42:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41c05d1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 10:41:48 +0000 (UTC)
Date: Wed, 8 Nov 2023 11:42:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <ZUtmAyVHO4ROhLEq@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <ac059db8fedc6493c64f703814c7db11adb4385e.1699428122.git.ps@pks.im>
 <xmqqcywk7k0d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YqWe118U3Okirj4R"
Content-Disposition: inline
In-Reply-To: <xmqqcywk7k0d.fsf@gitster.g>


--YqWe118U3Okirj4R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 04:59:46PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In order to set up the Apache httpd server, we need to locate both the
> > httpd binary and its default module path. This is done with a hardcoded
> > list of locations that we scan. While this works okayish with distros
> > that more-or-less follow the Filesystem Hierarchy Standard, it falls
> > apart on others like NixOS that don't.
> >
> > While it is possible to specify these paths via `LIB_HTTPD_PATH` and
> > `LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
> > to figure out how to set those up. And in fact we can do better by
> > dynamically detecting both httpd and its module path at runtime:
> >
> >     - The httpd binary can be located via PATH.
> >
> >     - The module directory can (in many cases) be derived via the
> >       `HTTPD_ROOT` compile-time variable.
> >
> > Refactor the code to do so. If runtime detection of the paths fails we
> > continue to fall back to the hardcoded list of paths.
>=20
> Hmph.
>=20
> I do not think we would want to punish the distros that follow the
> FHS that was created explicitly to help developers by standardizing
> locations of various things, with an approach this patch takes that
> throws everthing with bathwater and rely on $PATH first.
>=20
> Would it be sufficient to please NixOS if we simply append $(command
> -v apache) or whatever after the well known candidate locations?

I was a bit torn myself when writing this. I can also see a potential
future where we would drop the hardcoded list of locations altogether in
favor of always using PATH. After all we already rely on PATH to resolve
other tools as well, so why should httpd be special there?

But in the end I opted to use the more conservative approach of using
both PATH and the static list as I didn't want to break other distros. I
don't mind to make this even more conservative and resolve via PATH as a
last resort, only.

Patrick

> I know "command -v" is in POSIX, and on both bash and dash (the two
> shells most distros use), it works as this patch expects, but its
> portability is also a bit worrysome, especially because the whole
> point of this patch is to support a platform that is, eh, on the
> fringe.
>=20
> So, I dunno.

--YqWe118U3Okirj4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLZf4ACgkQVbJhu7ck
PpR8Rg/8DmEu5zPNP9NeLhoz/+O67X/ztCRoiSQJkcLpiPlMWJ7vE50d1bIO/tr0
29129unAF7sARJVlvSGXMEamfrsqZSv2SYxPI3lKUcqoBtrTWD9YsYONpFjcOHYA
ccVyOOjOPKq0s0vKrq8ysdT5XTmCAimebeKhZr9tAdyktx0458UMuWzH8UZFswAN
jd5ZZOSh8E205OjhslgrIDW4ILunKzKi1h/g2jwbn1xcnvPJgiO8/jdKRe6zwEno
dVGmosGAVY2uge4D29bcG/zslIqeyrqGPWE5s/KLBzDyBsgW/HruoqjiJt41qMMo
S+6DaUEcV3k0mFJ+txWGc9p6NBvsMwltX4FqzlGSb3KFRHSRQsQgAnh+hQSXqEKX
n6zfCxnDKbSMiKiWbPghOZSI76ZaiXmNlFEvV9uxn0sk5k7CgKjC0Dv4wMQsj6/3
mfBy4xWxgL0+WZ0/kvF6k5v7B8+hitB4CFb95cH+c3Zcv5XZ4a+INHaFWNaZskjY
CU04GFuj39uclHJ7rfrJLuPtu+j3Dji056kMfFFeu2c+VtmT2m5O+hW1Yz/wa/WN
6lcuIF5dc1ZqL79fJEE6UhdZRQt996NXEftSNkKWgvSrEEMOmYVp9km7ub9V8Z9t
96vo9GmRZ6m5BmeP5EHs2nW8bhQn5WovIq+itLjTa0kAom42wpo=
=bL+q
-----END PGP SIGNATURE-----

--YqWe118U3Okirj4R--
