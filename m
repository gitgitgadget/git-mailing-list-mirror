Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645D15383D
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726917655; cv=none; b=GTJcwG4WoKprX6RsanYt3tDVGKGaNT+glZbRo8IfDmPkCwwdPeNeCw26Dfo6S5jUW6ZGR9lrUrR4jYDtGc2nThZS2OMOoPT0/hnQ/Vqp+YS0zMzSTbIlTuLqEUT/gsEdxESqJyYUBJEOIgHIgpmZTXC8hqBsK69/GfGmkterd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726917655; c=relaxed/simple;
	bh=tE7wbWz8SVHgpl+wJrGnO1urNKwDh1mwy9brZP5vEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY+QmDnShbNFABsa1dltQMRsAsChWAiicWGEPw9qGFa5Ed8uEIuKaBZygQtTU50XthymZYnRuQe1NZPIAgeOZSEEA1wy2yGtT/p4iLoEOb4PcVU4wlpPow12S6Vseyfr6KawMTL5oIXLZoiKwe0hpzuvKxRHX1qeQ/HSggFCit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bAuSHxaF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bAuSHxaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726917651;
	bh=tE7wbWz8SVHgpl+wJrGnO1urNKwDh1mwy9brZP5vEgU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bAuSHxaFNgcf8Qk4pITsv45pNv/4Iij4F+13bPMEiUPnVa5nd85Qi8COXJjc2JYRG
	 uxdeOv6m7iaASMou32IhKGTgRFLUwsK6Oh1KS9k7kUoBR+P4m5XRa+yHuP/Fn5VJty
	 AKaUZtBd1tJaYh5lwuJs5D0A6+MRd2RQkqnzQ2mvTxg6guNFF9wQAHVDhF2H8TZYJI
	 BaQfn0rMBCmMlqG/EnwwrXsrALXhBG8lkqDmP2guHnqD/0Ha9CJ9VU9UR7XcH+IbYz
	 xSeVoq8FU5alc5YfIRQ9y9vj+XYlzuUUsABBAcRAGeu5rsY6QqgQKzyidVdn0Mqp/s
	 J+y+gvHaQ6GbgscAU1tG+YKnk273r5UL/bQt6+rVE6ldj4rvbriVJI7cLPG6y7+XAg
	 z9VyIff4fKOZKt90RxrNisFeSVMKTBCri8tORDIsVuCkljFaPkIOf634nsWDbVwIW8
	 0Uyw04gkMJv+PRluDRvBP/HCosBlwoFTaVlZBZzabNlx3RcTB9J
Received: from tapette.crustytoothpaste.net (i68975BB5.versanet.de [104.151.91.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3E4E72006F;
	Sat, 21 Sep 2024 11:20:50 +0000 (UTC)
Date: Sat, 21 Sep 2024 11:20:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Permission issue in Git in DrvFs-mounted network drives
Message-ID: <Zu6sDlL65s6NNS_o@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marcos Del Sol Vives <marcos@orca.pet>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
 <Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net>
 <xmqqsetugpip.fsf@gitster.g>
 <19210b887c6.f59622352625372.1022723129771458212@orca.pet>
 <Zu3ec1mDj9JD1Bbj@tapette.crustytoothpaste.net>
 <1921197742f.d7b8c9992630384.1644253106538527208@orca.pet>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8d7ohfn2/qUw7ACX"
Content-Disposition: inline
In-Reply-To: <1921197742f.d7b8c9992630384.1644253106538527208@orca.pet>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8d7ohfn2/qUw7ACX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-20 at 22:39:51, Marcos Del Sol Vives wrote:
> ---- El Fri, 20 Sep 2024 22:43:31 +0200,  brian m. carlson  escribi=C3=B3=
 ----=20
> There is not a significant amount of software that opens files for writing
> in read-only mode. Despite using WSL extensively for development, so far
> Git has been the only that failed to work.

I have been using Debian for many years and have contributed to several
of the packages.  I assure you that using what Git is doing is not, in
fact, uncommon.  It may be that you haven't run into it, but it is
definitely not rare.

For example, I just found an example of doing exactly the same thing in
zsh, which is a major project that people use across distros.  There's
apparently another in the elm MUA.  I found yet another one in some m4
(autoconf) files used in building Emacs.  And there are a lot of other
examples you can find by searching GitHub's code search for "open
O_WRONLY 0444".

Perhaps you don't use any of that software, but they're all substantial
projects that are in common use across Linux distros and Unix systems in
general.  I am a zsh user, for instance.

> > In addition, chmod doesn't always work under WSL.  I believe it _does_
> > work if the drive is mounted with metadata, but some people don't have
> > that enabled and I don't know if it works for all drives.  For those
> > people, the current code will work, since it doesn't call chmod or
> > fchmod, but it will fail with your patch.
>=20
> I can guarantee you it'll work under WSL, even without metadata, because
> I've patched Git on my WSL1 Debian machine by doing the aforementioned
> trick and it totally works. Metadata is not even supported on anything but
> local NTFS drives.

I have actually answered questions about chmod failing to work in some
cases on WSL, which causes operations to fail.  Here's a different
question on StackOverflow that demonstrates a particular problem that's
common where chmod fails to work in Git on certain WSL drives[0].  The
error looks like this:

  Cloning into '<repo>'...
  error: chmod on /mnt/c/Users/User/Code/<repo>/.git/config.lock failed: Op=
eration not permitted
  fatal: could not set 'core.filemode' to 'false'

If this situation occurs, your patch will actually leave the file
writable, which we don't want, since the fchmod will silently fail.

It may be that WSL has changed since that was written, but I've seen
reports of that happening relatively recently, and, in any event, we
don't want to require that people use the absolute latest WSL to get
things working.

Again, maybe Junio will accept a patch here, but I don't think the
current one is going to work correctly, even on WSL.  It may not be
obvious that it's broken because the patch ignores fchmod's exit status.
If you want to submit a patch that uses an option to either use the old
behaviour or one that does an fchmod after the fact, that would probably
be accepted, as long as you added tests (including the read-only bit)
for both cases and sufficient documentation.

[0] https://askubuntu.com/questions/1115564/wsl-ubuntu-distro-how-to-solve-=
operation-not-permitted-on-cloning-repository
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--8d7ohfn2/qUw7ACX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZu6sDQAKCRB8DEliiIei
gWeGAP44HeJ9cSskV7iQeptvQvTwUe/3oY4vohhm+feG+9x1lgEAklqMV6CaZzbg
59H29wU5kUOVFmJLZKtcvVAyIRqBJwo=
=8mh/
-----END PGP SIGNATURE-----

--8d7ohfn2/qUw7ACX--
