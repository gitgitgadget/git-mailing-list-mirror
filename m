From: Jan Hudec <bulb@ucw.cz>
Subject: Re: fetching a single commit from remote repo
Date: Sat, 16 Feb 2008 00:07:26 +0100
Message-ID: <20080215230726.GB13178@efreet.light.src>
References: <1530970.y9vPlhFxz8@yoush.homelinux.org> <alpine.LSU.1.00.0802101644540.11591@racer.site> <200802102017.03879@blacky.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nikita V. Youshchenko" <yoush@debian.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ9f6-00089D-VX
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 00:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070AbYBOXHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755817AbYBOXHd
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 18:07:33 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:36882 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbYBOXHc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 18:07:32 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A4ED357386;
	Sat, 16 Feb 2008 00:07:30 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id W5wUwIOz2X9h; Sat, 16 Feb 2008 00:07:28 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id BA8B057316;
	Sat, 16 Feb 2008 00:07:27 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JQ9eQ-0006tM-Va; Sat, 16 Feb 2008 00:07:26 +0100
Content-Disposition: inline
In-Reply-To: <200802102017.03879@blacky.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73994>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2008 at 20:17:03 +0300, Nikita V. Youshchenko wrote:
> > Hi,
> >
> > On Sun, 10 Feb 2008, Nikita V. Youshchenko wrote:
> > > I'm looking for a way to fetch a single snapshot, without history,
> > > from remote git repository.
> > >
> > > I've found how to do it with a head (clone --depth 1, or fetch --depth
> > > 1).
> > >
> > > Is it possible to do the same with non-head and non-tagged commit, if
> > > only sha1 name of the commit is known?
> > > Looks like fetch and fetch-pack only take ref names :(
> >
> > Yes, for security reasons.
>=20
> I can't understand what security issues this may cause ...
>=20
> If one has enough access to a repository to clone it, he already has a wa=
y=20
> to download each and every object from there.

No, that's not true. That is, it is only true for dumb (http, ftp) protocol=
s.
The native git protocol (ssh is used as wrapper for that protocol anyway)
will only give you the objects that are accessible from the references list=
ed
and no others.

> Ability to fetch the tree corresponding to particular commit won't add an=
y=20
> new permissions to him, will it?

It, indeed, may. Though, the git upload-pack could instead limit to only
providing objects, that can be reached from a ref -- than it would not add
any permissions.

> I'm looking for a way to get a copy of a particular previous state of the=
=20
> project tree, without having to download entire tree. Something similar=
=20
> checking out particular svn revision.
> This is going to be wrapped into a script, which is intended to be execut=
ed=20
> by people without any knowledge of any VC system at all. Commit id could=
=20
> be a parameter for such a script.

Would a cgi calling git-archive on the server do instead? It even seems to =
be
already part of gitweb -- the snapshot link for a commit should give you
a .tar.gz of that tree. If the people don't know anything about VC, they
probably won't need the metadata anyway.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHthsuRel1vVwhjGURAvfTAKDYgHxoekbpHFKBbOqU9bgBvB8+dwCeNp0X
UcsV5XU/7jme1aSu1E93L9I=
=16Kk
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
