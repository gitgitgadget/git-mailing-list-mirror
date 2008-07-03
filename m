From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: [BUG] Git looks for repository in wrong directory
Date: Thu, 3 Jul 2008 02:16:26 +0200
Message-ID: <200807030216.28921.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3156964.kHAUVueWX4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 02:17:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KECVu-0001Su-GQ
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYGCAQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 20:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbYGCAQe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:16:34 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:50616 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751623AbYGCAQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 20:16:33 -0400
Received: (qmail 22132 invoked from network); 3 Jul 2008 00:16:30 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.10)
  by 10.98.86.1 with SMTP; 3 Jul 2008 00:16:30 -0000
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87210>

--nextPart3156964.kHAUVueWX4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

The following sequence:

mkdir r1
cd r1
git init
echo a > a
git add a
git commit -m "a"
cd ..
git clone r1 r1.git
cd r1
echo b > b
git add b
git commit -m "b"
cd ..
git ls-remote r1
git ls-remote r1/.

shows that Git searches for a repository in the wrong place. I think the la=
st=20
two commands should output exactly the same but "git ls-remote r1" actually=
=20
lists the contents of "r1.git". Is that a bug or is this (extremely=20
confusing) behaviour intended?

This also afflicts the behaviour of "git-pull" and friends. I cloned a=20
directory and tried to pull new commits but I repeatedly got stuck with an=
=20
older commit. I have to move a second directory that was named like the fir=
st=20
directory, only with an appended ".git", out of the way so that I could=20
access the repository I asked for.

Used Git version is 1.5.6.1 on Linux 2.6.25.6 (Gentoo/x86).


	David

--nextPart3156964.kHAUVueWX4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhsGlwACgkQsh8Hgp5TwkPbNgCgi6oRP82cJ+W/W8rve8DpGSon
s9EAoLoYVP2UCQ6s+Mu2OZ9UEV+vcm32
=gxzY
-----END PGP SIGNATURE-----

--nextPart3156964.kHAUVueWX4--
