From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to use git merge -s subtree?
Date: Sun, 6 Jan 2008 04:45:34 +0100
Message-ID: <20080106034533.GE29972@genesis.frugalware.org>
References: <20080105230004.GY29972@genesis.frugalware.org> <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD80nKKiJWXm4UaL"
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jan 06 04:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBMSb-0000tw-U1
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 04:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbYAFDph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 22:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYAFDph
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 22:45:37 -0500
Received: from virgo.iok.hu ([193.202.89.103]:46614 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbYAFDpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 22:45:36 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1B6351B2546;
	Sun,  6 Jan 2008 04:45:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DB9B74465F;
	Sun,  6 Jan 2008 04:43:58 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5E57D11904E7; Sun,  6 Jan 2008 04:45:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69709>


--qD80nKKiJWXm4UaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2008 at 08:17:40PM -0500, Sean <seanlkml@sympatico.ca> wrot=
e:
> Here's another way that is perhaps a little cleaner:
>=20
> $ git remote add -f B /path/to/B
> $ git merge -s ours --no-commit B/master
> $ git read-tree --prefix=3Dsub/ -u B/master=20
> $ git commit -m "subtree merged B"
>=20
> The first line creates and fetches the remote.  The second line initiates=
 a merge, but
> stops before committing it.  The third line reads B/master into the subdi=
rectory "sub",
> at which point all that remains is committing the completed merge.

great, thanks. that's more simple than mine, and this is necessary for
the first commit only. the rest (i hope i'm right) can be done using
just by

$ git fetch
$ git merge -s subtree B/master

do you mind if i send a patch to add this to Documentation/howto? i
don't think it's trivial :)

thanks,
- VMiklos

--qD80nKKiJWXm4UaL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHgE7de81tAgORUJYRAp7NAJsGrUwgT68zlZ/VndcH8/8/AlK+BgCfTAc6
etZzTFpbsky+CLm50fxQxNY=
=6bz8
-----END PGP SIGNATURE-----

--qD80nKKiJWXm4UaL--
