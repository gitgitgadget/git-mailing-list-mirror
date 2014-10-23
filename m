From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Thu, 23 Oct 2014 01:09:27 +0000
Message-ID: <20141023010927.GE312818@vauxhall.crustytoothpaste.net>
References: <20141020115943.GA27144@gmail.com>
 <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
 <20141020222809.GB223410@vauxhall.crustytoothpaste.net>
 <CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
 <54461483.9010600@drmicha.warpmail.net>
 <xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com>
 <54477C18.5060806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Cc: Junio C Hamano <gitster@pobox.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 03:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh6uJ-0004GG-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 03:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbaJWBJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 21:09:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49479 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbaJWBJf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 21:09:35 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B85DD2808F;
	Thu, 23 Oct 2014 01:09:30 +0000 (UTC)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54477C18.5060806@drmicha.warpmail.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2014 at 11:42:48AM +0200, Michael J Gruber wrote:
> Junio C Hamano schrieb am 21.10.2014 um 20:14:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> >=20
> >> Unfortunately, the git archive doc clearly says that the umask is
> >> applied to all archive entries.
> >=20
> > Is an extended pax header "an archive entry"?  I doubt it, and the
> > above is not relevant.  The mode bits for the archive entry that it
> > applies to does not come from there.
>=20
> The problem seem to be old tar versions which mis-take the extensions
> for archive entries, aren't they?

Yes.  POSIX isn't clear on how unknown entries are to be handled.  I've
seen some Windows tar implementations extract GNU longlink extensions as
files, which leads to a lot of pain.

> My question to Brian still stands which existing users he was trying to
> cater for with his patch. If there indeed are no existing affected users
> besides the KUP users (as you seem to assume) it's a clear case. Pun
> intended ;)

The pax format is an extension of the tar format.  All of the pax
implementations I've seen on Linux (OpenBSD's and MirBSD's) don't
actually understand the pax headers and emit them as files.  7zip does
as well.  I expect there are other Unix systems where tar itself doesn't
understand pax headers, although I don't have access to anything other
than Linux and FreeBSD.

Since it's very common to extract tar archives in /tmp, I didn't want to
leave world-writable files in /tmp (or anywhere else someone might get
to them).  While the contents probably aren't sensitive, a malicious
user might fill someone's quota by "helpfully" appending /dev/zero to
the file.  And yes, users do these things.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUSFVHAAoJEL9TXYEfUvaLZzkP/AvlyOeT2/0+VpWw9teTAavT
fIbNDzFpHejMhKYBYnO6amLiCPjvC3GAaRgEyuHde8PQ2UzHUeceCPEH3VYMm+Q7
vux6YcYgfeqEpHEtMiFAQwr32D3RcfccHhXvAOoQD4tiePwYe+8OqNluyTbgj1sQ
ESuM5hw9wM1fNGeqU8fh/ClNAVuDdHEyeKMKvVTIYj3S9/8qwNKCeHbMgIdGlgQ+
Gh1qjxXQ0/Ptq6EeC1T/6soxmugmPuWdE3xvjPo3LSihX1bcllYCcGEe6UfDFnXU
eTbi006+xV7iyiDNQGbVM4DrOOclIz6PSDoFLUVpY30DkfIoCfMIlsrP0i1tmD6n
0yX72EVYmUMNEVsY/ymRHPV/TQ5947DDe+NG/rPAO7b40W+b0SEQpaLshe6I+ewQ
7MVqVJS5SlmXN6a1YFrWaoIDFphT7yH7Cab1aRfnjB17QMYO/VxlJnvO9pkBntzQ
alZK6Mk5Jvfiy7o2O5bKsLqgnbmot150i8x8C3iAzDExT6DohRRSezcfNCHLAEjS
UyfwfH6ffv3ItqdP+GKBG7211+lW+F8XQCRnkAmql0PKbJJZ2tdlxYkR0pIJKIjS
NEdNWTcV1+JDctlHIW+lOYfwSdUn+t6YKNqzkabVOVD9UMMMYEmLilqFxkXoF9yf
e36amBtvNIfRlM5nq2Op
=iTVX
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
