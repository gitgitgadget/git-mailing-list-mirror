Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1B3451C6
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729143; cv=none; b=KCoWQx6M8qkhAcwzKvflhApz6gCpIUPUXDB22nYDj4bpy/NMkDWF1vJuFbPnD10hQI0F4y43wXM5swmTLKI3e+cLNqRnno+jpkENlQVEO7XPbrLMwCGd7xxBGSDRuU1UpV+dP1qte5skGflnYd0SAYGUpOVHfDFg2lE1KddXO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729143; c=relaxed/simple;
	bh=mf2H48JKulTmoAfTPRotT+3vCcMkkCEFd03S04cIddU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3Sn3lXn/da1sN6Ruz7vbnH/0JiT1S+ryLPVKTt+BlsxRU3QqaXtzcGYyA89/Zd40p7ese6UmTxdEi09Qxes9NhlSCSjXdiQzVaLiJeb5X9p5nUdBUDmwfKHSWI/qxs+ba4hUS9ozsCeHD/4mIFHojckhDhEok844hc3LflQk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pTRhPxcb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pTRhPxcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1769729136;
	bh=mf2H48JKulTmoAfTPRotT+3vCcMkkCEFd03S04cIddU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pTRhPxcbwsMwX1QimVBA/85tDUHGHowEjqgS+aljxG8OVulTAJnqVyp1bmGytzOiP
	 c7+fywJnBsyzPNMuzDD/FystAMKO6AQVe5VxPpr1KOo+R4XkB7sTs9iBy+GwtT3mCO
	 uG2wj5Wxar2W8yrGAsLC8wEK4jyqhyo1oJssDN+d+n05g4Xk5vFxAcmI/ujUp8sE4I
	 Eugl7xGYf+XynIji9rSp9ko/oaw9dEVIRilIftEKgjpE/EE065FcC1RpTD7wotfAiu
	 L1/jcKkidEApXRokmuxPMgtUfzLqW3U+lfvaAb+IrtBMw9XTp33u2WXVMWEJwUGPHy
	 Sj6YEDCe2FIst2TbZxufL+x5tjD+McpX9km9FaMWAMic7a4DRPozuXLp9ESb7psfLN
	 9SCKNorJ3o4tXcTV8+bL7TY3hMqjJfaq4ndnXA68X5OTCHryMCvbIkrkmeXXHqRI+L
	 /fyEDiUKsr9dvQ/uwaBOvUkXbpnb4UxWLKiQXMnwPLZPjhhd/sx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf0d:4ae6:75ea:91b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 257A7200B4;
	Thu, 29 Jan 2026 23:25:36 +0000 (UTC)
Date: Thu, 29 Jan 2026 23:25:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <ericsunshine@gmail.com>
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #09)
Message-ID: <aXvsb43Wq-YIYaVr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <xmqqecnbeyvr.fsf@gitster.g>
 <aXqSyn3Mfcgs8MUG@fruit.crustytoothpaste.net>
 <aXvYnCsXPV0yefyD@fruit.crustytoothpaste.net>
 <CAPig+cStjN15WEKSN3b5VGLK-+N5pzj-dUDQ2rm15ne_9Q07FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ugjq23vmfMVjcJC9"
Content-Disposition: inline
In-Reply-To: <CAPig+cStjN15WEKSN3b5VGLK-+N5pzj-dUDQ2rm15ne_9Q07FQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ugjq23vmfMVjcJC9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-29 at 22:51:40, Eric Sunshine wrote:
> On Thu, Jan 29, 2026 at 5:01=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I did not get a Windows VM working but I did discover the problem and
> > I'm working on a patch and will send it out once I have CI green.
> >
> > The problem is roughly that both the MSVC linker and MSYS linker are
> > both called link.exe.  When compiling with Rust against MSVC, the MSVC
> > linker must be used, but the MSYS linker is first in PATH (because I
> > believe installing the Git for Windows SDK causes that to be the case),
> > causing build.rs to fail to compile.
>=20
> Didn't Ezekiel already tackle[*] this problem or am I misunderstanding?

CI still fails when rebasing my branch on `master`, so it doesn't appear
to have made it upstream quite yet.  I'll resume working on this
tomorrow at $DAYJOB and then add a patch to my series.  I may steal the
approach from Ezekiel's patch if it appears to work.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ugjq23vmfMVjcJC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXvsbgAKCRB8DEliiIei
gUBNAPsEh9KXb41QN1P7cNM549XvpTQtnMl4cMLZk0lCFP/YYwEAxhNLBWJ3s/1+
GUG1b7Ifr+8BHm7P8mUMfJS3nQdqWQI=
=sD+f
-----END PGP SIGNATURE-----

--ugjq23vmfMVjcJC9--
