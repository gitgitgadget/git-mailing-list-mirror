From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: Strange behaviour with git-add, .gitignore and a tracked file
Date: Fri, 16 Dec 2011 22:57:57 +0100
Message-ID: <201112162258.04661.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6104809.u55lBJFu0p";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 23:23:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbgBa-00059g-Aa
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654Ab1LPWXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 17:23:21 -0500
Received: from weltgehirnmaschine.de ([46.163.73.232]:50765 "EHLO
	beak.pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644Ab1LPWXU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 17:23:20 -0500
X-Greylist: delayed 1486 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Dec 2011 17:23:20 EST
Received: from magnesium ([10.98.86.14]:55139 helo=magnesium.localnet)
	by beak.pterodactylus.net with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <bombe@pterodactylus.net>)
	id 1RbfnT-0007LT-2c
	for git@vger.kernel.org; Fri, 16 Dec 2011 22:58:31 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-31-generic-pae; KDE/4.5.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187326>

--nextPart6104809.u55lBJFu0p
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi.

I stumbled across some strange behaviour today:

=2D--
git init git-test
cd git-test
echo '*' > .gitignore
git add -f .gitignore
git commit -m "Add gitignore."
mkdir dir
echo a > dir/file
git add -f dir/file
git commit -m "Add dir/file."
echo b >> dir/file
git add dir/file
=2D--

The last git-add results in the following error message:

=2D--
The following paths are ignored by one of your .gitignore files:
dir
Use -f if you really want to add them.
fatal: no files added
=2D--

While it is true that the file specification matches a pattern in .gitignor=
e,=20
the file is already tracked and should not be ignored.

This behaviour was reproduced with 1.7.7.4 (on OS X), 1.7.5.4, 1.7.1,=20
1.7.8-247-g10f4eb6 (latest master as of a couple of hours ago) (all Linux).


Greetings,

	David
=2D-=20
David =E2=80=98Bombe=E2=80=99 Roden <bombe@pterodactylus.net>

--nextPart6104809.u55lBJFu0p
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk7rvugACgkQsh8Hgp5TwkOQXwCfSsHDDWRgmF4rnmEXq6/bnPHM
z+YAn2atasoH4Q59sqN4uFuaq741lp1T
=Xu+S
-----END PGP SIGNATURE-----

--nextPart6104809.u55lBJFu0p--
