From: Brandon Philips <brandon@ifup.org>
Subject: Re: [ANNOUNCE] qgit, another git GUI viewer
Date: Tue, 31 May 2005 11:11:10 -0700
Message-ID: <20050531181109.GH11774@osuosl.org>
References: <20050531170445.38748.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 20:09:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdBAK-0003tZ-1o
	for gcvg-git@gmane.org; Tue, 31 May 2005 20:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEaSLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVEaSLT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 14:11:19 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:63908 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S261159AbVEaSLO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 14:11:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ns2.osuosl.org (Postfix) with ESMTP id AE01E120825;
	Tue, 31 May 2005 11:11:11 -0700 (PDT)
Received: from ns2.osuosl.org ([127.0.0.1])
	by localhost (ns1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14532-76; Tue, 31 May 2005 11:11:11 -0700 (PDT)
Received: from shell.osuosl.org (shell.osuosl.org [140.211.166.149])
	by ns2.osuosl.org (Postfix) with ESMTP id EC8A11206E4;
	Tue, 31 May 2005 11:11:10 -0700 (PDT)
Received: by shell.osuosl.org (Postfix, from userid 1000)
	id 2C31B2F4010; Tue, 31 May 2005 11:11:10 -0700 (PDT)
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050531170445.38748.qmail@web26305.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at osuosl.org
X-Spam-Status: No, hits=-1.6 tagged_above=-999.0 required=5.0 tests=AWL,
	BAYES_00
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: multipart/mixed; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marco,

Obligatory screenshot:
http://ifup.org/~philips/qgit.png

Some quick feedback:

>   This is qgit, basically a porting of gitk to Qt/C++.

The tarball extracts to the current directory which isn't very friendly.

> Just run make, install the bin anywhere in the path
> and run from any git project working directory to see
> the graph

Out of the box it wouldn't compile for several reasons on my own
computer.  I have attached a diff but the only real solution is to use
autotools as my diff will now only work on Gentoo systems.

Hope this helps.

-Brandon Philips

--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qgit-gentoo-compile.patch"
Content-Transfer-Encoding: quoted-printable

--- b/Makefile	2005-05-28 14:38:22.000000000 -0700
+++ a/Makefile	2005-05-31 10:15:05.000000000 -0700
@@ -26,7 +26,7 @@
 sub-src: src/$(MAKEFILE) FORCE
         cd src && $(MAKE) -f $(MAKEFILE)
=20
-Makefile: qgit.pro  /usr/lib/qt3/mkspecs/default/qmake.conf=20
+Makefile: qgit.pro  /usr/qt/3/mkspecs/linux-g++/qmake.conf
         $(QMAKE) -o Makefile qgit.pro
 qmake: qmake_all
         @$(QMAKE) -o Makefile qgit.pro
--- b/src/Makefile	2005-05-28 08:31:26.000000000 -0700
+++ a/src/Makefile	2005-05-31 10:18:15.000000000 -0700
@@ -12,8 +12,8 @@
 CXX      =3D g++
 LEX      =3D flex
 YACC     =3D yacc
-CFLAGS   =3D -pipe -Wall -W -O2 -fomit-frame-pointer -pipe -march=3Di586 -=
mtune=3Dpentiumpro  -DQT_NO_DEBUG -DQT_SHARED -DQT_THREAD_SUPPORT
-CXXFLAGS =3D -pipe -Wall -W -O2 -fomit-frame-pointer -pipe -march=3Di586 -=
mtune=3Dpentiumpro  -DQT_NO_DEBUG -DQT_SHARED -DQT_THREAD_SUPPORT
+CFLAGS   =3D -pipe -Wall -W -O2 -fomit-frame-pointer -pipe -march=3Di586  =
 -DQT_NO_DEBUG -DQT_SHARED -DQT_THREAD_SUPPORT
+CXXFLAGS =3D -pipe -Wall -W -O2 -fomit-frame-pointer -pipe -march=3Di586  =
-DQT_NO_DEBUG -DQT_SHARED -DQT_THREAD_SUPPORT
 LEXFLAGS =3D=20
 YACCFLAGS=3D -d
 INCPATH  =3D -I/usr/lib/qt3/mkspecs/default -I. -I$(QTDIR)/include
@@ -123,8 +123,8 @@
=20
 $(MOC):=20
         ( cd $(QTDIR)/src/moc && $(MAKE) )
-
-Makefile: src.pro  /usr/lib/qt3/mkspecs/default/qmake.conf /usr/lib/qt3/li=
b/libqt-mt.prl
+#####/usr/qt/3/mkspecs/linux-g++/libqt-mt.prl
+Makefile: src.pro  /usr/qt/3/mkspecs/linux-g++/qmake.conf=20
         $(QMAKE) -o Makefile src.pro
 qmake:=20
         @$(QMAKE) -o Makefile src.pro

--rCwQ2Y43eQY6RBgR--

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCnKi9oP8TDUUjhZ0RAiJmAKCJdz6lRy1PnNfyeN0zreRO45ucowCeP/RQ
1zr/N7F32OD+CPmaE17vHHE=
=+wFQ
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
