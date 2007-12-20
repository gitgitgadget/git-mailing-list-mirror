From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: Question about git-svn import
Date: Thu, 20 Dec 2007 17:52:27 +0100
Message-ID: <20071220165227.GB22683@alea.gnuu.de>
References: <4766AF65.5060706@obry.net> <20071218034836.GA27080@dervierte> <4767724A.9040207@obry.net> <20071218153159.GA12549@alea.gnuu.de> <476A98BB.8000900@obry.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 17:54:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Oeo-00041v-03
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 17:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170AbXLTQxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 11:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760422AbXLTQxf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 11:53:35 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:1364 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760170AbXLTQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 11:53:33 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2F399488063; Thu, 20 Dec 2007 17:53:31 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J5OdH-0000e0-O6
	for git@vger.kernel.org; Thu, 20 Dec 2007 17:52:27 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.68)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J5OdH-0005wp-QB
	for git@vger.kernel.org; Thu, 20 Dec 2007 17:52:27 +0100
Content-Disposition: inline
In-Reply-To: <476A98BB.8000900@obry.net>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69011>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pascal Obry schrieb am Thu 20. Dec, 17:30 (+0100):
> # Rewrite post/trunk on top of pre/trunk into merged-master
> $ git checkout post/trunk
> $ git checkout -b merged-master
> $ git-filter-branch --tag-name-filter cat --parent-filter "sed -e
> 's/^$/-p $(git rev-parse pre/trunk)/'" merged-master
>=20
> The problem is that at this point I cannot "git svn rebase". Looks like
> the filter-branch command did break the link between the Subversion
> repository and the git svn one:
>=20
> $ git svn rebase
> Unable to determine upstream SVN information from working tree history
>=20
> Is there a way around that ?

According to http://duncan.mac-vicar.com/blog/archives/282 it should help
to do something like:

git update-ref refs/remotes/git-svn master
find -name .rev_db* | xargs rm

I didn't had this problem, because I did a one=E2=80=90time import.

Bye, J=C3=B6rg.
--=20
Die zehn Gebote Gottes enthalten 172 W=C3=B6rter, die amerikanische
Unabh=C3=A4ngigkeitserkl=C3=A4rung 300 W=C3=B6rter, die Verordnung der euro=
p=C3=A4ischen
Gemeinschaft =C3=BCber den Import von Karamelbonbons exakt 25911 W=C3=B6rte=
r.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHap3Lwe0mZwH1VIARArRQAKDEft26WQexQkgDZqm3SurUybkjtgCfZePE
hsR7uGL/u6THKgH2C4FMfkA=
=tRAz
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
