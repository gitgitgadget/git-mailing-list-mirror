From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: how to check remote git repo for updates without pull/fetch
Date: Sat, 20 Dec 2008 18:02:53 -0600
Message-ID: <200812201802.57953.bss@iguanasuicide.net>
References: <494BC89F.9070107@gmail.com> <m3skoi21m3.fsf@lugabout.jhcloos.org> <402731c90812201541r510170tbe1d56b7261e8146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4816325.C21r06CnP6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>,
	"James Cloos" <cloos@jhcloos.com>,
	"Ivan Zorin" <ivan.a.zorin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 01:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEBnm-0003xq-Kb
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 01:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbYLUACp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 19:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbYLUACp
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 19:02:45 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:45413 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYLUACp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 19:02:45 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEBmN-0000QM-OK; Sun, 21 Dec 2008 00:02:43 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <402731c90812201541r510170tbe1d56b7261e8146@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103675>

--nextPart4816325.C21r06CnP6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2008 December 20 17:41:13 David Aguilar wrote:
> 2008/12/20 James Cloos <cloos@jhcloos.com>:
> > #!/bin/bash
> > #
> > # does this git repo need a pull?
> > #
> > l=3D$(git log|head -1|awk '{print $NF}')
> > r=3D$(git ls-remote origin heads/master|awk '{print $1}')
> > test "${r}" !=3D "${l}"
> >
> >
> > -JimC
> > --
> > James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
>
> Hello
>
> Your script will report false positives if you run that in a branch
> where you've made local commits since git log's output will list a
> commit that's not on the remote side.

Change the last line to:
test "${r}" !=3D "$(git merge-base "${r}" "${l}")" and those false positive=
s=20
should go away.

The script is far from a complete solution to the OPs problem though.  It o=
nly=20
checks one, specific remote branch.  It only checks against the current=20
branch.  It is the core of something that might be useful as another=20
subcommand to 'git remote' though.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4816325.C21r06CnP6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklNh7EACgkQdNbfk+86fC2SGACdHHvF6YHXMC6CJiF+f1aOWKoa
zWYAn32wYxnMbw/gH9+YDRkMedXvl2fg
=j+jS
-----END PGP SIGNATURE-----

--nextPart4816325.C21r06CnP6--
