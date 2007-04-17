From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 16:56:49 -0700
Message-ID: <20070417235649.GE31488@curie-int.orbis-terrarum.net>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Cc: Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 01:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdxXK-0008Uf-Ms
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 01:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031311AbXDQX43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 19:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031312AbXDQX43
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 19:56:29 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:58872 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031309AbXDQX42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 19:56:28 -0400
Received: (qmail 27014 invoked from network); 17 Apr 2007 23:56:26 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 17 Apr 2007 23:56:26 +0000
Received: (qmail 13256 invoked by uid 10000); 17 Apr 2007 16:56:49 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44842>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2007 at 11:23:03AM -0700, Linus Torvalds wrote:
> > Well, if the only keyword we support is $BlobId:$, then if the tree/obj=
ect
> > hasn't changed, then we still don't need to touch the object.
> >=20
> > Not so?
> Correct. However, is that actually a useful expansion?
>=20
> Most of the time, I'd expect people to want things like "last committer,=
=20
> time, story of their life" etc.. I don't think the SHA1 ID's are pretty=
=20
> enough that anybody would ever want to see them. But yes, they are=20
> certainly stable.
I'd certainly settle for having only $Blobid:$. It fits my requirements
perfectly.

This is perhaps a reasonable wording of my requirement.
"Files from from the VCS should contain a stable machine-usable
identifier that is unique for that revision of the file, without
post-processing to insert the identifier."

In the case of CVS, $Header$ contains the path and revision number of a
file, which serve to identify the content uniquely.

In the case of Git, $BlobId$ fills the same requirement.

As for a usage case:
- J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
  same output)
- Copies some file outside of the tree (the user is NOT smart enough,
  and resists all reasonable attempts at edumacation)
- Modifies said file outside of tree.
- Contacts maintainer with entire changed file.
- User vanishes off the internet.

The entire file he sent if it's CVS, contains a $Header$ that uniquely
identifies the file (path and revision), and the maintainer can simply
drop the file in, and 'cvs diff -r$OLDREV $FILE'.
If it's git, the maintainer drops the file in, and does 'git diff
$OLDSHA1 $FILE'.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGJV7BPpIsIjIzwiwRAij1AJkBZ808bZ++PVBG5H37iSFfiE4QGwCgiPHx
Hk/rpnBfbu1xOd3ONgDS/x4=
=ueoW
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
