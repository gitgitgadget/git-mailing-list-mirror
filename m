From: Eric Blake <eblake@redhat.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Fri, 25 Jan 2013 17:34:09 -0700
Organization: Red Hat, Inc.
Message-ID: <51032481.4030707@redhat.com>
References: <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk> <51031C43.5030307@gmail.com> <7v38xo3irh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2GUBVISJRERUBGHNQTAVL"
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:34:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TytjJ-0006rg-F3
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab3AZAeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:34:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356Ab3AZAeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 19:34:22 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0Q0YBce032496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 25 Jan 2013 19:34:12 -0500
Received: from [10.3.113.27] (ovpn-113-27.phx2.redhat.com [10.3.113.27])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0Q0YAcY005484;
	Fri, 25 Jan 2013 19:34:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7v38xo3irh.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.0
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214600>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GUBVISJRERUBGHNQTAVL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2013 05:11 PM, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>=20
>> Cygwin and Windows should be treated as completely separate platforms:=

>> if __CYGWIN__ is defined, do one thing, if not, go ahead and check
>> WIN32, but the WIN32 macro should never be tested once we know the
>> platform is CYGWIN - these really are different platforms (if you are
>> unsure of this, consider that Cygwin includes a cross-compiler to
>> target native Win32 as the Cygwin maintainers recognized the platforms=

>> are different).
>=20
> Not disagreeing with your conclusion (they should be treated as
> different), why does it define WIN32 in the first place?
>=20
> Perhaps we would want
>=20
> 	#ifdef __CYGWIN__
>         #undef WIN32
>         #endif

Wouldn't work.  Cygwin gcc does NOT define WIN32; rather, the inclusion
of a Windows system header (generally discouraged, but sometimes a
necessary evil) might cause WIN32 to be defined for all subsequent header=
s.

Which is why other projects, like gnulib, have

# if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__

all over the place.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


------enig2GUBVISJRERUBGHNQTAVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJRAySBAAoJEKeha0olJ0NqlyYIAITPpBEDvL9ahmRdl5kJYaqK
MxlGuF881giVUeroWUf3V1n6aK7NSD0bTfHC/6UC7CK34y4UG4R02djtUFG6nAKQ
KzFNLlg01q3qyhaxrzz989FMV3BFS27wDhIsGnmvmopnwrp4sf9xPQpXbUTbfX/2
WZ7JwQnmcyj7Sjw+6A/t/6VEkJeceXqNRcVsPxBB5hNQlFv3KK+JncmLVDY12lSH
nxsmx4OxGG1JpOld+ZSotX5fzVhcG4E0ukTiAYfWEwyEWL7EPQb6JCDZwsOlgTV3
jCKV0lzAA+tT2HCNpnnAT3S+vOxkYMTdVj9DLDx7Z82DHmllQgTwU6qxEKD/tD8=
=4whb
-----END PGP SIGNATURE-----

------enig2GUBVISJRERUBGHNQTAVL--
