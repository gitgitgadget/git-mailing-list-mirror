From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: [Patch] trap: exit: invalid signal specification
Date: Sat, 24 Jun 2006 04:10:12 +0300
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
Message-ID: <200606240410.18334.caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart20559460.BHK1FWBiLA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 24 03:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtwfI-0005hx-Ok
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 03:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbWFXBKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933174AbWFXBKW
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 21:10:22 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:2780 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S933172AbWFXBKV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 21:10:21 -0400
Received: from zangetsu.local (unknown [85.101.118.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 274EE34C6BA
	for <git@vger.kernel.org>; Sat, 24 Jun 2006 04:10:19 +0300 (EEST)
To: Git Mailing List <git@vger.kernel.org>
User-Agent: KMail/1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22465>

--nextPart20559460.BHK1FWBiLA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

This tiny patch is needed to solve

caglar@zangetsu ~ $ git-clone=20
/usr/bin/git-clone: line 121: trap: exit: invalid signal specification

error under tr_TR.UTF-8 (and other Turkic locales). For these locales=20
upper(i) !=3D I .

P.S: If needed please CC me, i'm not subscribed to list

Signed-off-by: S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
=2D--

diff -ur git-1.4.0.orig/git-clone.sh git-1.4.0/git-clone.sh
=2D-- git-1.4.0.orig/git-clone.sh=C2=A02006-06-10 22:41:54.000000000 +0300
+++ git-1.4.0/git-clone.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02006-06-24 03=
:54:49.000000000 +0300
@@ -205,7 +205,7 @@
=C2=A0[ -e "$dir" ] && echo "$dir already exists." && usage
=C2=A0mkdir -p "$dir" &&
=C2=A0D=3D$(cd "$dir" && pwd) &&
=2Dtrap 'err=3D$?; cd ..; rm -r "$D"; exit $err' 0
+trap 'err=3D$?; cd ..; rm -r "$D"; EXIT $err' 0
=C2=A0case "$bare" in
=C2=A0yes)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GIT_DIR=3D"$D" ;;

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart20559460.BHK1FWBiLA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnJD6y7E6i0LKo6YRAqeJAJ0YI9isWFMb3aJ19MnhWUOIaPei0ACgtMZ8
uXjiIGMAsV/ZXV4Pp8xrDjQ=
=ttY0
-----END PGP SIGNATURE-----

--nextPart20559460.BHK1FWBiLA--
