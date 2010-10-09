From: ebik <ebik@ucw.cz>
Subject: git-svn.perl - bug in lookup_svn_merge()
Date: Sat, 9 Oct 2010 11:20:16 +0200
Message-ID: <20101009112016.3e3ed175@Chewbacca.cub>
Reply-To: ebik@ucw.cz
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/jXPrjtAb4SY.nVStFOgcsfV"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 11:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4VbV-0000sE-5S
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 11:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0JIJUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 05:20:19 -0400
Received: from drak.ucw.cz ([212.71.128.78]:52069 "EHLO drak.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753Ab0JIJUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 05:20:18 -0400
X-Greylist: delayed 764 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Oct 2010 05:20:18 EDT
Received: from Chewbacca.cub (localhost [127.0.0.1])
	by drak.ucw.cz (Postfix) with ESMTP id 246EB6E;
	Sat,  9 Oct 2010 11:20:17 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158577>

--Sig_/jXPrjtAb4SY.nVStFOgcsfV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I triggered a bug in lookup_svn_merge when I was trying to convert one
of our repositories.

Namely the $bottom variable has sometimes value '1', i.e. the first
commit ever. Then it pushes "$bottom_commit^..$top_commit" to some list
for further processing. This processing fails, because there is no
commit before the first one.

We should test existence of parent of $bottom_commit, but I don't know
what is the correct behavior if it does not exist.

--=20
                                 Tom=C3=A1=C5=A1 'eb=C3=ADk' Ebenlendr
                                 PF 2010.77113540081


--Sig_/jXPrjtAb4SY.nVStFOgcsfV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EAREIAAYFAkywM9AACgkQUYN+FqT7KZvy9gEAl0uZFpYoQ/iHlkgNcrsJKyLP
+m+OxldIruavqIIHwQYBANEu2fNMuXP70Um/qmPgineDxXZO8SdTirRyo13yqofg
=0RK9
-----END PGP SIGNATURE-----

--Sig_/jXPrjtAb4SY.nVStFOgcsfV--
