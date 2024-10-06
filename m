Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B418E2A
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728193297; cv=none; b=SujB8vymxFScmebYaPU58uIRfwCbPxhyD2t1uZGw685SX49Xpxv+wN4YT7brGYl1IH3ffNQAx03jS4byEpuf8/i50ERYD8C4DZMdAC3rsSCSD7y2eRPM00yOFhuzeQdRTCaheL4Y31jlsbAPJ4nKLwx9vYoVi0rkftkmYTQvEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728193297; c=relaxed/simple;
	bh=m1Ry7vs8onwXpArBnMieNZPAs3ByrEZJdzqMIAgAes4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNLkNCHDDM1nNsZP0GiNFAQO9c2FSFKXm4XghVqIKza7HnAdMBty+Ju6UCfh4ZDLkHVMlzoU83CVcBoFKyoo/dwYr+6eLc6U6oR5AbroRGQnG7dAGLZgsIzBjo9upEFK2Gf+pAj8Trqw/7/CLuHe2B0mL6S9yX2zEQ8ACOXb7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UDwL8sJr; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UDwL8sJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728193288; x=1728452488;
	bh=m1Ry7vs8onwXpArBnMieNZPAs3ByrEZJdzqMIAgAes4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UDwL8sJrJM7ljj49/f1HW+r+z8F3bMxR/8MBIELraPPTw7if7IOMv/vlM9EHaCVun
	 1IoTQoTlm56IePuReGcL0fs0GsfMpz2Y1op2micyynEmjSHcOw8YI4hkj87GLyI1rb
	 roi3shD9Y4Id7v9gUvh567L8HVmyKMN10Fb6Q/9BzZtSv9FaM8cdJVdtD+qWEzp2Ro
	 w/M4+vsLUE1o8dmy+Xw4ADH/bKCM9fFrkAFzbfTpgeATC8A/62NsfRETBuKsx+f17D
	 ICGBqFAETojm+Vaj0k29O+Eft+FlCVVFuHTRiGcdwNuNGb7Lu362zJ6qbmhQWPaNpm
	 ViE08gPF6jsLw==
Date: Sun, 06 Oct 2024 05:41:25 +0000
To: Eric Sunshine <sunshine@sunshineco.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Caleb White <cdwhite3@pm.me>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
In-Reply-To: <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com> <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me> <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com> <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com> <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me> <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: e191a0ff50dac22a4c12d25b851f1169e8028a14
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------29c10ff60f9fbd45d2c12723918ce304c4912ebee04004698a2d01c11338851c"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------29c10ff60f9fbd45d2c12723918ce304c4912ebee04004698a2d01c11338851c
Content-Type: multipart/mixed;boundary=---------------------46b37dda95e6a5fc015655ac6bafa7b4

-----------------------46b37dda95e6a5fc015655ac6bafa7b4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 00:32, Eric Sunshine <sunshine@sunshineco.=
com> wrote:

> On Sun, Oct 6, 2024 at 1:21=E2=80=AFAM Caleb White cdwhite3@pm.me wrote:
> =


> > On Sunday, October 6th, 2024 at 00:16, Eric Sunshine sunshine@sunshine=
co.com wrote:
> > =


> > > > + struct strbuf backlink =3D STRBUF_INIT;
> > > > struct strbuf gitd
> > > > ir =3D STRBUF_INIT;
> > =


> > That's strange, the code came through just fine on my end:
> =


> =


> It's broken in the Git mailing list archive, as well. If you search
> for "mbox.gz" at [], you can download this email thread. The patches
> in that mbox file have the same damage as I'm seeing.
> =


> [] https://lore.kernel.org/git/CAPig+cTVbXVffSeyNAV3c0zuSUozY7giWtMw3GpH=
s+xVEpaNvA@mail.gmail.com/T/

That's interesting...what's the best way to try and resubmit? As
a new thread or as a v2?
-----------------------46b37dda95e6a5fc015655ac6bafa7b4--

--------29c10ff60f9fbd45d2c12723918ce304c4912ebee04004698a2d01c11338851c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAiL3CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADihwgApz7UoActOtLHyzt93/8Yf8e3p8QLYiBsSsUkER6jvY0ma3Oy
xrYpUaeSfERl/CsiOS1WpsgV5FYsnMNX8qeZEsLSZ1Kf82cUgh1ERaL+RmES
kmo6jo5sMW0QBoctSVx2P7uWQn6PQzPEjrglSiNWA8PWGpZ8in/KwP6Kk8ha
8zD8vL9hoI8X9BoDJ1/8T9mkt2Lr5z5cCRIDuDNT0atkaRjqk0oDFUSWDpVI
JuNbOCDkjhu9I96KUv9ARG3VOaVDB7CR0MjGJikA4H0NkuTco0K3ZAdniEF4
re3EMaKH89rtBLNsiQdsHZENUrHfFF4WAIuy36OuVQNCHonaN2qrSA==
=c43+
-----END PGP SIGNATURE-----


--------29c10ff60f9fbd45d2c12723918ce304c4912ebee04004698a2d01c11338851c--

