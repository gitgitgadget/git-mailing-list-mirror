From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: having to pull twice
Date: Sun, 28 Sep 2008 17:26:20 +0200
Message-ID: <200809281726.23062.trast@student.ethz.ch>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <200809271616.32082.trast@student.ethz.ch> <20080928151135.GF23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2519246.Y42fZX4XQK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 17:28:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjyCR-0004S3-Gd
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 17:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYI1P0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYI1P0Y
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 11:26:24 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:35592 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbYI1P0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 11:26:24 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 28 Sep 2008 17:26:22 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 28 Sep 2008 17:26:22 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080928151135.GF23137@genesis.frugalware.org>
X-OriginalArrivalTime: 28 Sep 2008 15:26:22.0447 (UTC) FILETIME=[902157F0:01C9217E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96976>

--nextPart2519246.Y42fZX4XQK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Miklos Vajna wrote:
>=20
> Oh, the racy git problem. ;-)
>=20
> $ git reset --hard; touch foo; git merge side

IIUC, this is not the same as "racy git".  The racy case is if you
manage to get a file changed immediately after its index entry was
updated, so that it will look unchanged.  In this case, it's simply
the same file with a new mtime, which means it looks changed
superficially but still has the same contents.

Granted, you could call my test "racy" because it relies on 'make
install' taking at least one second, which by Moore's law should
happen sometime around 2019 ;-)

> Thanks for the reproducer, I'll write a proper testcase for this and try =
to
> provide a fix for it as well.

Thanks.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch




--nextPart2519246.Y42fZX4XQK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjfoh8ACgkQqUud07tmzP0PEQCfR1HRVjrR+shEJL4HDP4aWkUd
Y8EAn0ewCNBQBUS5CmwUoIq1y/TxMIzT
=MhBM
-----END PGP SIGNATURE-----

--nextPart2519246.Y42fZX4XQK--
