Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92A17DFFD
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847531; cv=none; b=Jmnlo4GyAABcrZI1ASCgggCi4jmUFIQYL5HQTfchgUuD8S9FTFIIVhvOt3dnIPqaKvrnYvwAfe4qV3VA/V22S+P8PPv/ta5HJokLfwT6h4yO+9fztsHfEMfuv6WgqUdFbdwnQ4Nh944uXI+0CuCgN2qBgG/c2QEVirByRiCuusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847531; c=relaxed/simple;
	bh=/Wu9WC8BmsXB417u+MWbDdv6mjiBYj7kHrwagWwcbnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI7bELMJzV8mFQXhjaJ0reBWNOSpooWvLum/U5zuR1C4RJCHze6hq5nINHuD84nN0h9PWK+J8TIuWrTAsC0qKhRtMLyHaKUdu98BMxivvl4MBD5UxOq5WpEo96rpNmZri2PvlBBRU6Q16thbILxAdhVQkxIHEef5Bv1jxfjSqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=f89/+ljO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f89/+ljO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726847521;
	bh=/Wu9WC8BmsXB417u+MWbDdv6mjiBYj7kHrwagWwcbnA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=f89/+ljO063tHaCt/Umxz2LtW6SVqcQ5r2Wp9feoF0R2IKbxDkuXoMuvpHXbZfz7G
	 rWFdvbxpXZflDgCwe6cBFZdhQEEhpy1QoW6fprypMS1ze1jwuZaZNP6BkFzsNbDCvc
	 OrYq++UnnZm/WSZGNmLuGzEFMeZpkt44v0Mdqiuns3UzVdraiYb5BfQ0tqcwYdc0ep
	 Y0MHEhiHuotorxTIniWZjqdW5J4CYulbCdZt/+R/3TyPuSoiCI0QnfvMvExCAshr0o
	 5/Mbjkyuvj6yWUBCnZBHh7dfBjOiizlYn9RPd5AzaqGRfVpRTd+zoVtebTuN/mPRhp
	 sut+kqDPT+MRnKSXuxtOI6f+F4rkxkVIC+tGp1hWyko5y82aRBFN2THiN58kAR47rm
	 oF6itAEZTi0Pptcsyllh6aUPno0rkrTCbT/kH2dM7GGby6JkW5YgfFQK8Oy8IkPH7w
	 4xjWFneCGh1W86LagbD0eZKaoBQxFfY7nPS8IpTjWdfwGapOyIZ
Received: from tapette.crustytoothpaste.net (unknown [151.189.190.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1708B20067;
	Fri, 20 Sep 2024 15:52:00 +0000 (UTC)
Date: Fri, 20 Sep 2024 15:51:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: git <git@vger.kernel.org>
Subject: Re: Permission issue in Git in DrvFs-mounted network drives
Message-ID: <Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marcos Del Sol Vives <marcos@orca.pet>, git <git@vger.kernel.org>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RzidWhV6kzqFWyaV"
Content-Disposition: inline
In-Reply-To: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RzidWhV6kzqFWyaV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-18 at 16:16:26, Marcos Del Sol Vives wrote:
> Under WSL1 (Windows Subsystem for Linux), when using a network share
> mounted via DrvFs, Git fails to add any files to a new or an existing
> repository.
>=20
> The reason is that Git tries to open a temporary file as with RW
> permissions but mode 0444, which causes WSL1 (or Samba, unsure who's here
> to blame) to create first an file empty with the read-only DOS attribute =
set
> that prevents any writes, and then actually trying to opening it in write
> mode, which of course fails.
>=20
> Seems to be a pretty common issue that nobody has yet reported officially,
> judging by the amount of posts on Stackoverflow, impacting not only WSL
> but also CIFS under Linux (hence why sending to this mailing list and not
> the Windows-specific one):
>=20
>  - https://superuser.com/questions/681196/debugging-git-repo-permissions-=
on-samba-share
>  - https://superuser.com/questions/1450094/git-on-wsl-commands-fail-despi=
te-permissions-seeming-fine
>  - https://superuser.com/questions/1491499/use-git-on-a-shared-drive-with=
in-wsl
>=20
> As a workaround, opening the file with permissions 0600 and then using a
> fchmod with the final desired mode works, which is a very small change th=
at
> should cause no issues under neither real Linux nor WSL:

This behaviour also occurs on some broken NFS mounts.  It is, however,
explicitly permitted by POSIX to open a file 0444 with O_WRONLY or
O_RDWR, and we've traditionally not fixed it for that reason.  I would
say that WSL1 behaviour is incorrect here.  Here's what POSIX says[0]:

  The argument following the oflag argument does not affect whether the
  file is open for reading, writing, or for both.

That is, POSIX forbids failing to open a file for writing because the
permissions are 0444, and as such this is not POSIX compliant.  Note
that the operation must also be atomic; that is, the server can't
emulate this by setting the permissions to 0600 and then doing an fchmod
internally unless nobody can ever detect the intermediate state.

I think we also probably have a few other codepaths that are affected in
the same way and this is maybe just the most noticeable.

Other folks may feel differently about fixing this, but I would suggest
against it.

> The WSL team at Microsoft has been already informed as well:
> https://github.com/microsoft/WSL/issues/12051

I've provided some comments in the issue there.

[0] https://pubs.opengroup.org/onlinepubs/9799919799/functions/open.html
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RzidWhV6kzqFWyaV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZu2aHAAKCRB8DEliiIei
gY+nAP9jwIs31etaIoSUjHG15CYhwR5XnVpClqUMfrKxFju8IQD/dXw7d60/IoaQ
r4P8NUQbFuzpYsqd38CoCate72Z0ggk=
=O6Is
-----END PGP SIGNATURE-----

--RzidWhV6kzqFWyaV--
