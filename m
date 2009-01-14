From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH next v2] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 11:09:52 -0600
Message-ID: <200901141109.56580.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E129B.3020502@trolltech.com> <20090114165633.GC15758@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1820775.4HQUxaLx3h";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Tor Arne =?utf-8?q?Vestb=C3=B8?= <tavestbo@trolltech.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9H1-0001Xv-HD
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764990AbZANRJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765092AbZANRJS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:09:18 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:51236 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765087AbZANRJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:09:16 -0500
Received: from [63.167.77.128]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LN9Ev-00020S-60; Wed, 14 Jan 2009 17:09:13 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090114165633.GC15758@coredump.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105664>

--nextPart1820775.4HQUxaLx3h
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2009 January 14 10:56:33 Jeff King wrote:
>On Wed, Jan 14, 2009 at 05:28:11PM +0100, Tor Arne Vestb=C3=B8 wrote:
>> +MSG=3D${MSG//%/}
>> +printf "$MSG" > "$1"
>> +printf "$MSG" >& 2
>
>Substitution parameter expansion is a bash-ism, IIRC. How about just

MSG=3D$(printf '%s\n' "$MSG" | sed -e 's/%/%%/g')
printf "$MSG" > "$1"
printf "$MSG" >& 2

Is my best attempt at portable and "safe".  It's a few extra processes thou=
gh.

>  printf %s "$MSG" ?

On my box
$ printf '%s\n' '\n'
\n
$

He wants '\n' in $MSG to be expanded, and what you gave doesn't do that.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1820775.4HQUxaLx3h
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluHGQACgkQdNbfk+86fC3jNwCdE6B5YQ2Z5eLNJ3sbfvaxX+pj
qR4An38cL01THz4dO0vrDR6rEhgYHsn7
=GlRp
-----END PGP SIGNATURE-----

--nextPart1820775.4HQUxaLx3h--
