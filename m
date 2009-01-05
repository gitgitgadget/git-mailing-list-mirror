From: Joey Hess <joeyh@debian.org>
Subject: gitweb: removal of old style blobdiff support breaks ikiwiki
Date: Mon, 5 Jan 2009 18:54:18 -0500
Message-ID: <20090105235418.GA9373@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 01:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJzSE-0006eZ-4y
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 01:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbZAFAEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 19:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbZAFAEP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 19:04:15 -0500
Received: from wren.kitenet.net ([80.68.85.49]:47563 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbZAFAEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 19:04:14 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jan 2009 19:04:14 EST
Received: from gnu.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 8C3683142DB;
	Mon,  5 Jan 2009 18:54:25 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 768C8A81B9; Mon,  5 Jan 2009 18:54:18 -0500 (EST)
Content-Disposition: inline
X-Reportbug-Version: 3.48
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8837/Mon Jan  5 11:08:06 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104605>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>  * debian/diff/0005-gitweb-do-not-run-git-diff-that-is-Porcelain.diff:
>     new; fix possible gitweb vulnerability: calling "git diff": Jakub
>     says that legacy-style URI to view two blob differences are never
>     generated since 1.4.3.  This codepath runs "git diff" Porcelain from
>     the gitweb, which is a no-no.  It can trigger diff.external command
>     that is specified in the configuration file of the repository being
>     viewed.

Jakub didn't know the whole picture. This change breaks ikiwiki
configurations that use the old url form with gitweb. That url form
is used in configuration examples that have probably been copied into a
lot of ikiwiki setup files.

(Who knows what else might rely on the old url form.. One other thing I've
found that does is various cut-n-pasted gitweb urls embedded on various
websites..)

I wonder if it wouldn't be better to make gitweb continue to support the
old urls, using diff-tree instead of the porcelain?

Gerrit:
I'll be releasing a new version of ikiwiki to that documents how to use
the new gitweb url form. The version in Debian testing would need to
have a new-ish feature backported into it to support the new url form at
all. So please let me know if there are any plans to make this change to
the git in testing (or stable).

--=20
see shy jo

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJYp2ld8HHehbQuO8RAtyxAJ0VYRM/yiUc/38y+wHa3JhVDN/bmgCggaFl
Jr0yL99HlysEB+2kMLq14XU=
=TbwV
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
