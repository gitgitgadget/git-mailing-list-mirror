Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE11DDA4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nAwXE7VA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rS/PPNMy"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E7993
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 03:46:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 0789E320096E;
	Mon, 30 Oct 2023 06:46:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 30 Oct 2023 06:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698662778; x=1698749178; bh=eU
	zrNpjs/vG44HOwFCbIexuG1SlO2ZGIC30B3DC5lTU=; b=nAwXE7VACG8yZJQk32
	UKYX8QGPHrAwUuPB808LcCdptUEErOYz0vOA+8Xn96F+ID3yz/4wUFGgupy8Nkmn
	YE1gC5jqk9rSNIHdPGAR+tG+zcImwVbXmQoeSpbD9syhSuxggXfK13f5rBW4QYKv
	1ISzE+K6KQwOas+Nf9aycoBcZ0MNBCA9siaeV4s2dF9h0cjyx/+pICbh1NDlevtB
	OCNyUVk4YKBsDyJMthJaxmFySysjdWlAcf3frfnb42//zRxpOXnwcpSEnVPoqIVE
	x0ZeOWHIemc5mNKbMRb+vgc7oool+RcZxi8yaTo1bImyN6LO538Td3SpPYdAASC4
	0oig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698662778; x=1698749178; bh=eUzrNpjs/vG44
	HOwFCbIexuG1SlO2ZGIC30B3DC5lTU=; b=rS/PPNMyRZj3OSkURQRZqwhuK8cFa
	5Ii1GLaK4Ykcl/qOoSxr2glmS+gN5bYj7UdY+SoD1Vdo8JkBx8IeqheaeKKD+W9t
	3kOHJeq6veFZSmcWAMPYv/Zj9cMFPnCYKxhtL+A1jCp3ermdTyF37m4Q2nC62Z2D
	XXdsJ1CFLn68qEsGXNerll2R7ey2vFrXBI6YnpPQvJpeviCnzTg49Eu+StNkslGQ
	xt1QDrqGoNejYhe2deTsj3WcpPcVu2oCdc6Uh3Jzfp0gamVnWVS3/oqXG8t9cvjn
	lA1D2DlO2Ai1Juug8tQtyq5jFlzq52LNWiSfeC/O+LO2PjPx6x7tavONQ==
X-ME-Sender: <xms:eok_ZY3jnwyQzGpGvZR54r4UA7buB39-a6h62UXcRR7OUxub-3tbKQ>
    <xme:eok_ZTGtdlqe79liwqItt0Npjyba4DKUjK1GMWGuAGWP9Bbj3YCnnvQCLgAAuYssQ
    XLXDpjyW4P0FhWgEA>
X-ME-Received: <xmr:eok_ZQ4crkLuyZxxZeluE0dhmOWBDQEG78BVvtbZ7c6h3W8M2kOksj0Rqo2liMk2qIsOHiQ5BY_5GlWbjqw1Yc_4QpxY28P3-HKLbkFjdKIVUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eok_ZR3yIRf6v3NKlyepK3TctE4plZ8aTM7Kv8JoTaVRCk8hf5N4qA>
    <xmx:eok_ZbHo-e0NZQ7XZfSEPWcZfzbXuGaPqV2BIcgMB1tbguak5jM3Ww>
    <xmx:eok_Za-1iVyMT5T1okrjAKNs9HaxILV3vIzpIJOTELNgK1p0CBKtxw>
    <xmx:eok_ZRNESC18h4tlMooPnm9hp5HVfJCisLjBaYSwxPxSo5u2OVtKsA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 06:46:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 542fa662 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 10:46:11 +0000 (UTC)
Date: Mon, 30 Oct 2023 11:46:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <ZT-JdyEEgN3l7T5L@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>
 <ZTucxlBR1VrJPuSK@tanuki>
 <ZTulo_rh_G-lfICQ@tanuki>
 <6ee43015-1abc-4269-b710-0647ce80d7a2@crinan.ddns.net>
 <8db10489-546d-428d-9b3e-7ecea87e1313@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ria32jeFgQpBWSsa"
Content-Disposition: inline
In-Reply-To: <8db10489-546d-428d-9b3e-7ecea87e1313@gmail.com>


--ria32jeFgQpBWSsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 04:13:39PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 27/10/2023 14:02, Phillip Wood wrote:
> > On 27/10/2023 12:57, Patrick Steinhardt wrote:
> > > Hum. After having a look at `ci/run-docker-build.sh` I don't feel like
> > > it's sensible to update it. It's not even used anymore by our CI but
> > > only by `ci/run-docker.sh`, which seems to be more of a developer-fac=
ing
> > > script?
> > >=20
> > > As you said, this smells like rotting bits that might rather be remov=
ed.
> > > But in any case, as they don't relate to our current CI infrastructure
> > > except for being in "ci/" I'll leave them be for now.
> >=20
> > I was trying to suggest that we start using these scripts again.
>=20
> Having taken a closer look I think we'd be better off adding something li=
ke
>=20
>   # Ensure the build and tests run as an unprivileged user
>   if test "$(id -u)" -eq 0
>   then
>       useradd --home-dir "$(pwd)" builder
>       chown -R builder .
>       exec sudo --preserve-env --set-home --user=3Dbuilder "$0"
>   fi
>=20
> To the beginning of ci/run-build-and-tests.sh.

That indeed looks like a nice way to handle this, agreed. As mentioned
though, I don't really have an easy way to test this with GitHub
Workflows or Azure Pipelines. So I'd propose to defer this change to a
follow-up patch series -- and in the best case somebody who is familiar
with these CI solutions would pick it up rather than me.

Patrick

--ria32jeFgQpBWSsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/iXYACgkQVbJhu7ck
PpQuuQ//fDDLdP6HyWBsvXgvskt22Bk8XkifWZTgKMENS42GMt5R8K6r6cCsdrK1
RHOZyxV2Kuk3GHNUAAwQTvy9cmW6S3WI8MHIb3Lu9Gm8T0F2JLw5RG9Wef/wxFH7
A9saVKZf0mQmwoNPON0k/LHPom5y9jA1VYXMrbPRmnXhuiI4LmX0rXF2bSfXtKrd
r2abPmdOwEhoowvkBZAUPHLQkzEtDuHcfwSI2HDZWv2Soy9i5SCNiMR49fXSp6M/
lzP0Zk26vVMXmSPmm+y4niZ+r89TFj28vcRaFgAL4ceuxtENKCLLaHlLf3d8LtyY
SAydCbpF/rBrTIH3KrjMpYkqUeuROak3nhktVKBMik5QcNd/DkH3k0Df/veQgVP/
50uL+yhG0ksazXhdP3vk5wG+RrlMXi+vvEiolDKc0CWkAK8Q0SXZzw08buSBUWOz
ygAAd2rlrtG3xGRSzH962E4L3aTR5flWw0rRNg4pOQDWu49C4mZyamNatKQrwfyy
0rvQWj4btPGQyMqEsI1tEcemRNt/vL8DyX3zhrUGXjgePIfH8WYwaXc9AAmZ48jZ
B/Cj447EeJBibztJ4Eh0Iq34RI8L/kGgqMOV/5Bjmm+x8g1yiFSRBTZNeL/Pysw4
61X0C2R0UKBdlOgTMRTC8D2JhAVhfNEm2SzxSzRUtcGiwnhyh8U=
=i7ae
-----END PGP SIGNATURE-----

--ria32jeFgQpBWSsa--
