Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24896C2FD
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233353; cv=none; b=a0NQ34FVseMpSh/+V/OxS6mGO/QrviYX0KRP08XLdf6lavY9cqVrzWyPUJso5DjKV0wXnr3K3EP/L5m/BNKnHElxixcrRPr43uffbhSMBTU954dNgmVGhals/bhMCiCADSWGSlgnG5yerxPUCZd8hqf3Mi5dzlKOWDbvxXJCbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233353; c=relaxed/simple;
	bh=ksEg63i+TMK5bpHGII22Felde8R74ttVaHI+s4yh8gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnZ4MbAFVcizHUPsHtal8D2yCniyMEow3UfSXAQeVdJ7K39PugocVIJ5NirFWs5mMUpihufjvNVBkVqChJIduA779Rto3zkNY96PzQO/jWnA2V0aetRy5iqC4RPwgl0XybSc9Jjv1/INswE3qXetSk9l3sXuU2tAYePEZL2mUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=G04EdINq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G04EdINq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746233343;
	bh=ksEg63i+TMK5bpHGII22Felde8R74ttVaHI+s4yh8gk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=G04EdINqeBdkWvnho0wHVjp4PU0X1nKC0hxH3O3SYy++l0cRF3a8Jtdydk98S8rvH
	 0lLZmVW7CaVm72GJJVJf13iu6IoNtP6+fHbfLmMp3gmfF4cVeEg1TD9DDIxJf0E10D
	 Nab2bh3QnnGurOHrzX80lOtKCaKL0kysReKO0qRZgmvyZ0m2vH1xBxPWM18sB7vuHB
	 lz1f83j7n4rPv44lO7Lhzwn5AyKqOoNFT0RXwMxpITSlUEXMN/ht2WJnf3TVDb0tXw
	 yv6DxuxaI8jLYqnhhjC3NbvrDgSEwz7YcfawGFl+8efZSkj0fpBk8VVCpP6hn/ONWw
	 18Ie1hUUcNCL7Swm2kcVDNuD20Iyrnus6Abp3o8g+VaYf81Cq+jQ9+tLCgoWklfF0+
	 4tX/8OEHY87dGnNQA9S1wyzc0JsZ2ElpO5KDsSJU1v2ItJ3FEtmv18pFrG+NGRcxsQ
	 mQps+DvyUDirxC0i1pfdQe1UekuTcEG1ZvQt7ElX/9DSpKB1bZt
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 195AC2011C;
	Sat,  3 May 2025 00:49:03 +0000 (UTC)
Date: Sat, 3 May 2025 00:49:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthias vom Bruch <matthias.vombruch@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: bugreport - cannot clone repo over ssh which I don't own
Message-ID: <aBVn_abDjpZFk41p@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthias vom Bruch <matthias.vombruch@gmx.de>, git@vger.kernel.org
References: <dcf355a7-cbeb-4162-82a9-5486d3ce3166@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UJ0Ejf+Muz/ia8yc"
Content-Disposition: inline
In-Reply-To: <dcf355a7-cbeb-4162-82a9-5486d3ce3166@gmx.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UJ0Ejf+Muz/ia8yc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-02 at 22:07:51, Matthias vom Bruch wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> Create a repository, rsync it to my homelab server, place into a directory
> that is owned by a:a_and_b and has -R file mod of 770. Then cloned that
> into a new, bare repository with the same name, say on /path/to/bare_repo.
> Then I prepared ssh auth via key on new machine, so that user b can lo
> g in to homelab without password. Then tried to clone the repository with
> `git clone b@local-name:/path/to/bare_repo` and variations prepending `s
> sh://` and appending `/.git`. Got error
>=20
> fatal: detected dubious ownership in repository at '/path/to/bare_repo'
> To add an exception for this directory, call:
> =C2=A0=C2=A0=C2=A0git config --global --add safe.directory /path/to/bare_=
repo
> [The following is a rough translation, as the machine is in German and so
> was this message]
> fatal: could not read from remote repository
>=20
> Please ensure that you have the correct access rights
> and the repository exists
>=20
> I then execute the command it suggests and confirm that the appropriate l=
ine
> has been added to my git config
>=20
> Retry - same error
>=20
> Test if there is actually a problem with access rights by copying the
> repository with `rsync -r b@local-name:/path/to/bare_repo ./`. No issue, =
eve
> rything gets copied
>=20
> What did you expect to happen? (Expected behavior)
>=20
> Firstly, no issue at all, as cloning from a remote (bare) repository that
> _isn't owned by me_ seems like standard usage of git. People are bound t
> o run into this in projects of more than one person, unless they use the
> more elaborate implementations of vendors like github. My understanding w
> ould be that this is how git should "naturally" work.
>=20
> Then, the error being fixed after I apply the command it suggested.

Can you retry this with Git 2.48 or newer on the server?  There's a
patch in that version that should allow cloning from an untrusted
repository.

Note that if you're cloning on the local system, you will need to use
`--no-local`, as documented in that version.  That isn't necessary over
the network, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--UJ0Ejf+Muz/ia8yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgVZ/0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZwWj5/KcTtZ8Z26QsZsnQg0np7OxLB4cUC2vniPuzeRM
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADRCAQDURlH1+MywqByupi1sTUOVchO9
c4cKtBem0HQrl1l0ewEAlazpXbqHJU6KpHDip9N/3xjInbXSMq88cPHcHhh8gAg=
=FN2K
-----END PGP SIGNATURE-----

--UJ0Ejf+Muz/ia8yc--
