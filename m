From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Fri, 1 Jun 2007 20:11:37 +0200
Message-ID: <20070601181137.GA3002@efreet.light.src>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com> <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com> <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com> <200705302028.15549.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paolo Teti <paolo.teti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Lederhofer <matled@gmx.net>,
	Junio C Hamano <junkio@cox.net>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 20:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuBbK-0006s2-Vh
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 20:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbXFASLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 14:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758653AbXFASLk
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 14:11:40 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58537 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbXFASLk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 14:11:40 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 4F23157602;
	Fri,  1 Jun 2007 20:11:38 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HuBb7-0001J6-HA; Fri, 01 Jun 2007 20:11:37 +0200
Content-Disposition: inline
In-Reply-To: <200705302028.15549.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48873>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2007 at 20:28:15 +0200, Robin Rosenberg wrote:
> Wasn't because it's better to make .git a link to a repository somewhere=
=20
> else? Just a guess.
>=20
> ln -s /somewhere/repo/.git .git
>=20
> Works fine for me (yes, in a clearcase dynamic view).

It works for me too. It requires cygwin version of git though, since windows
don't have native symlinks.

> BTW, Does anyone have something like git-cvsexportcommit for clearcase?

No, but it should not be too hard to create.

If you want to quickly import something, you can try starting with something
like:

diff clearcase-view git-checkout > p
lsdiff p | xargs -d '\n' cleartool checkout
patch -p $n < p

You'll have to sort out which directories to run which command in and how
many components to strip with -p in the patch. It also does not handle addi=
ng
and removing.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGYGFZRel1vVwhjGURAkcOAKCcg/v4UqXnU7ezek9tB4oi2359CgCgioKy
2lJ62U3Jyz9Lw2RA9JLAcfk=
=GOiF
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
