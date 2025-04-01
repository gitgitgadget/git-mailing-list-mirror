Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC61E5B93
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542198; cv=none; b=r69N5a6qGmRUNnWVzJ9houW0Tr16xVGvATaRL+JKFer5wlsQ10M7QbHbacA5zQHdkgOd1vxkZxrF/2cZ4sQknJ064rqM8uq+B7vdJXHODlTPKVbj8i8uzoBLFl/ErcUOheJMgouS8CrlFZ6ll0JynnSdfQt7NZNg1nsFHLBN0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542198; c=relaxed/simple;
	bh=WxmVbBs4xc+T7HEfZKcHIDu9OAJs+jEF1bxvek3U4rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3ExgvRDdsVtpJuh4lqw1tinsLbdcFzETzWHcxiGTTK2MUx3P0qNOaB6EOTLBcxV7wTdCEM6UjGFmHKzoBXsOciJY/5mW4iW7yaDXGJGsK/R/DNsNDOWs1UJ9Q0YKSE/YPbRJwJrOYhlAc4EKqUhIIegx83OmkZQjx+s4udTD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=d9FiqQFa; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d9FiqQFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743542193;
	bh=WxmVbBs4xc+T7HEfZKcHIDu9OAJs+jEF1bxvek3U4rE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=d9FiqQFa53BL6J6/piIx9CBmvir+XXSDKvdR6RFWq3rB5uy7mzni3Mpm4Ouvv87uf
	 /J+P4P/IRrxHX9Lu4flAxih5xZ1PVeHs25Prslc1Ot22bkRBcBo3tgG2e4trxUHPdL
	 DQK+oRWw/FRPADf97YR/m9J3Qo8uNsuiQ1TbSEkCKCNcnNHARtFiZk0iYofoLnMAZ/
	 dhI5rfqDAFoIDtSrsp/u9Jrn9YbXnTEHoTr3U1mtxogUA9dYFEHpNATzRRX28e47md
	 LED1M84cVcZAfjKfbFWrdZRMPxRmK6T9UnCPEh3BNjrYygitVufl+K5o2UDDrPkUug
	 U0KnbqsMRZdHrnLActHiYBhZv2UK4X2L/Rb8QMyAADwUYCY6BZQdPh+EW2kmasEdjZ
	 p/AokZeSijgr3dEi06xIlJ0K2PuEG3kMGeAlMTGpMjGCZqL1nuOmFIPoKHLgAeiWUk
	 t6+WqI7PGFF7c2WmuJb4Fcsr7/vdLd2YxWSqpDHHWrhtL931RaC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ADD7F200BE;
	Tue,  1 Apr 2025 21:16:33 +0000 (UTC)
Date: Tue, 1 Apr 2025 21:16:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Milan AJDINOVIC <milan.ajdinovic@se.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git client bug with branch containing "."
Message-ID: <Z-xXsCs3Wr6NwYx1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Milan AJDINOVIC <milan.ajdinovic@se.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <VI1PR04MB695864E125F3381932332BDC91AC2@VI1PR04MB6958.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X2rClL/xi4Ynk2kh"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB695864E125F3381932332BDC91AC2@VI1PR04MB6958.eurprd04.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--X2rClL/xi4Ynk2kh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-01 at 12:19:47, Milan AJDINOVIC wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> On GitHub Enterprise server I have created a branch named: features/team1=
/feature./1.0/main in my repo.
> I tried to fetch the branch and switch to it.
>=20
> What did you expect to happen? (Expected behavior)
> I expected for branch to be switched to:features/team1/feature./1.0/main
> What happened instead? (Actual behavior)
> I got an error: fatal: cannot lock ref 'refs/heads/features/team1/feature=
=2E/1.0/main': unable to create directory for .git/refs/heads/features/team=
1/feature./1.0/main
> What's different between what you expected and what actually happened?
> The branch did no switch.
> Anything else you want to add:
> From my analisys the problem is because my branch have "feature." in it a=
nd Windows can not create directory with "." at the end.

I think that's correct as to why it's not working.  Git by default uses
the files ref backend, which stores the data in files in the repository,
and in your case, Windows is unable to create that directory.  That's
unfortunately a limitation of Windows and we can't do anything about it.

We allow those branches because Unix systems don't have this problem and
users working with Unix-only repositories might want to use them.

> git version 2.42.0.windows.2

If you use the latest release (2.49.0), you can probably switch to the
experimental reftable backend using `git refs migrate
--ref-format=3Dreftable`, which will not have this problem.  However,
please make a backup of your repository first, since we've seen some
bugs during the conversion that have caused problems, including with
stashes.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--X2rClL/xi4Ynk2kh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+xXsAAKCRB8DEliiIei
gSbDAQD9hPVPLAXjxWWBnJjbNjobXEqsEM3qEM8W8R1YwXX3uQEAtfWWnVgV9Ykg
pUg4CV30mqTeQYbU6iHuCazUH1M9NgE=
=lcxk
-----END PGP SIGNATURE-----

--X2rClL/xi4Ynk2kh--
