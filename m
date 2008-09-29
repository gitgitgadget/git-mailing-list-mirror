From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Mon, 29 Sep 2008 17:07:22 +0200
Message-ID: <20080929150722.GU23137@genesis.frugalware.org>
References: <20080925235029.GA15837@neumann> <m37i8y3mqt.fsf@localhost.localdomain> <20080926193122.GW23137@genesis.frugalware.org> <200809270151.51785.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdEaXsHGJIWX/19R"
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 17:09:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKMf-00044Q-HO
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYI2PHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYI2PHY
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:07:24 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38237 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbYI2PHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:07:23 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6327A580F7;
	Mon, 29 Sep 2008 17:07:22 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 284CA4465E;
	Mon, 29 Sep 2008 17:07:22 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1377F11901A1; Mon, 29 Sep 2008 17:07:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809270151.51785.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97018>


--gdEaXsHGJIWX/19R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2008 at 01:51:47AM +0200, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> > Actually I think this would be ugly. MERGE_HEAD is about you can see
> > what will be merged once you commit the merge, but once you include HEAD
> > there, you can't easily check that. Maybe it's just me who sometimes
> > have a look at that file myself directly... :-)
>=20
> The new semantic would be very simple.  If there is no MERGE_HEAD, it
> is an ordinary no-merge commit, and its only parent would be previous
> (current) version of HEAD.  If there is MERGE_HEAD it contains _all_
> parents in a merge commit, and only those heads which will be parents
> (_reduced_ heads); if HEAD is symref, we modify given branch so it
> points to newly created merge commit.
>=20
> Currently parents of merge commits are 'reduce(HEAD + MERGE_HEAD)'
> in symbolic equation; I propose they would be simply 'MERGE_HEAD'.
> then we set this branch to new commit

Yes. Currently - after a merge conflict - you are able to check what
heads caused were merged, which caused the conflict, but with this
approach you would not be able to. I think this would be a step back...

--gdEaXsHGJIWX/19R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjg7yoACgkQe81tAgORUJZj1gCeMfnRbovS9umukgz3DmRrNECd
M60AoKYDXcf6Ksej277G35xGS0YE6+b3
=Da/9
-----END PGP SIGNATURE-----

--gdEaXsHGJIWX/19R--
