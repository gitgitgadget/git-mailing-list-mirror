From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 15:27:16 -0600
Message-ID: <200901121527.21818.bss@iguanasuicide.net>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <20090112204030.GA23327@chistera.yi.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1305545.nSjWWbEWvl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:28:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUKO-0007mn-Cj
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbZALV0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZALV0p
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:26:45 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:57457 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbZALV0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:26:44 -0500
Received: from [63.167.79.33]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMUIy-0003wb-Dz; Mon, 12 Jan 2009 21:26:40 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090112204030.GA23327@chistera.yi.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105385>

--nextPart1305545.nSjWWbEWvl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 12 14:40:30 Adeodato Sim=C3=B3 wrote:
>* Boyd Stephen Smith Jr. [Mon, 12 Jan 2009 14:35:35 -0600]:
>> >The attached patch replaces things like
>> >
>> >         if [ -z "$1" ]
>> >
>> >with
>> >
>> >         if [ -z "${1-}" ]
>>
>> That looks ugly to me.  Any reason we shouldn't just "set +u" at the top
>> of the script?
>
>`set +u` affects the shell globally, not just to the sourced file. If
>you do that, you must be aware that you'll be preventing people from
>running their shell in `set -u` mode. (Merely stating a fact here, not
>giving any opinion.)

I'm not familiar with bash completion exception as a user, I didn't realize=
=20
all these functions had to be sourced into the current shell.

Well, if the user want to run in "set -u" mode preventing it is bogus, IMO.=
 =20
We could use subshells and unset at the top of _git and _gitk functions, th=
at=20
would be only a +6/-4 patch.  It would also not be something future=20
contributors have to think (much) about.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1305545.nSjWWbEWvl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklrtbkACgkQdNbfk+86fC0BRQCgijQ+0vAtwRQGTiNsCIlD5SvJ
kT8An1MBLlz0RPoIuLguM22c2aHnas+f
=NBwT
-----END PGP SIGNATURE-----

--nextPart1305545.nSjWWbEWvl--
