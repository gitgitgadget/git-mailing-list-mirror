From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Is there any plan to support partial checkout or submoudule
	improvement?
Date: Tue, 16 Oct 2007 23:33:59 +0200
Message-ID: <20071016213359.GJ26127@efreet.light.src>
References: <Pine.LNX.4.64.0710161158350.25221@racer.site> <20071016115310.5FB957E6D@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Cc: 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Lars Hjemli' <hjemli@gmail.com>, git@vger.kernel.org
To: franky <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihu3p-0005rs-Ux
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965648AbXJPVeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965718AbXJPVeL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:34:11 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:46786 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965601AbXJPVeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:34:09 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B0A215739C;
	Tue, 16 Oct 2007 23:34:05 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id kQnoEJVcC8co; Tue, 16 Oct 2007 23:34:03 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8281E5731D;
	Tue, 16 Oct 2007 23:34:00 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Ihu35-0002Jn-8l; Tue, 16 Oct 2007 23:33:59 +0200
Content-Disposition: inline
In-Reply-To: <20071016115310.5FB957E6D@mail.kooxoo.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61259>


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 19:53:08 +0800, franky wrote:
> > You are talking as if your partial checkout was a project in its own
> > right.  Then make it so.  Do not use a partial checkout, but make that a
> > submodule.
>=20
> As I said in the first email, the submodule way suffers from the multiple
> commit problem: src and bin as two submodules of project, three commits (=
for
> the 3 dirs separately) are needed when src directory changes and compiled
> binaries being put in bin directory. It's annoying to have to give 3 comm=
it
> logs.

Thinking about it, it's only two commits -- src can be a submodule, but bin
a normal directory (you can choose not to check out subprojects during
repository checkout).

This has the advantage, that bin, even when src is not checked out, always
knows what version of src it is based on (it's in the gitlink) and you only
give two commit messages.

Now I would actually say that commiting bin independently is better.
It allows you to commit sources more often (eg. if you are doing series of
small fixes) and more flexibility for branching (you don't want to merge
binaries).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFS5HRel1vVwhjGURAt8EAJoCCuXI2z85HduNqIHRaN3g4jt45gCgu+ev
FjChpWZkXkvlZ4rE6h9r/OU=
=QvpY
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--
