From: martin f krafft <madduck@madduck.net>
Subject: git-svn -t/-b should respect existing *
Date: Thu, 13 Mar 2008 12:27:38 +0100
Message-ID: <20080313112738.GA28589@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Cc: normalperson@yhbt.net
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZlbt-0002mP-JA
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 12:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbYCML1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 07:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYCML1s
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 07:27:48 -0400
Received: from clegg.madduck.net ([82.197.162.59]:59058 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYCML1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 07:27:47 -0400
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 31722A800B;
	Thu, 13 Mar 2008 12:27:40 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id E89BC9F18E;
	Thu, 13 Mar 2008 12:27:38 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A74C6442E; Thu, 13 Mar 2008 12:27:38 +0100 (CET)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6221/Thu Mar 13 11:10:51 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77060>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

My git-svn target configuration is

  [svn-remote "svn"]
    url =3D svn://svn.berlios.de/docutils
    fetch =3D trunk/docutils:refs/remotes/trunk
    branches =3D branches/*/docutils:refs/remotes/*
    tags =3D tags/*/docutils:refs/remotes/tags/*

Unfortunately, when I run

  git-svn init -T trunk/docutils -t 'tags/*/docutils' -b 'branches/*/docuti=
ls' ...

then I get (note the two asterisks on the left hand side):

    branches =3D branches/*/docutils/*:refs/remotes/*
    tags =3D tags/*/docutils/*:refs/remotes/tags/*

I took a brief stab at the code but I can't even figure out where
the /* is appended, so I defer to you.

It should be trivial to keep git-svn from appending /* if the left
side already contains an asterisk.

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"auch der mutigste von uns hat nur selten den mut zu dem,
 was er eigentlich wei=DF."
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2Q+qIgvIgzMMSnURAuWtAJ4xxBHxwjm8wJFOAGPngD4Yrg6PuACgylmH
0TuG/AYuVVjCmosb5XQixrk=
=b0QF
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
