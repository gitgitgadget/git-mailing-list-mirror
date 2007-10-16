From: Jan Hudec <bulb@ucw.cz>
Subject: Re: remote#branch
Date: Tue, 16 Oct 2007 23:09:04 +0200
Message-ID: <20071016210904.GI26127@efreet.light.src>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <Pine.LNX.4.64.0710161139530.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Cc: Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhtfR-0007am-Di
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759566AbXJPVJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760191AbXJPVJU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:09:20 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:43190 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761616AbXJPVJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:09:11 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id BE62957310;
	Tue, 16 Oct 2007 23:09:09 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id kNEPR2Z-RJVB; Tue, 16 Oct 2007 23:09:07 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3D5485752D;
	Tue, 16 Oct 2007 23:09:06 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Ihtey-0002GV-5N; Tue, 16 Oct 2007 23:09:04 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710161139530.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61255>


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 11:49:58 +0100, Johannes Schindelin wrote:
> In related news, I recently thought about the url#branch issue.
>=20
> There were three arguments against it AFAIR: "#" is a comment marker, and=
=20
> this syntax is not extensible to more than one branch names.  And that th=
e=20
> branch name is not really a part of the URL.
>=20
> Turns out that I am not so sure about the last two issues.
>=20
> It is easily extensible to more than one branch by remote#branch1#branch2=
,=20
> and in a very real sense, this is a resource locator.
>=20
> And we could replace the "#" by every character that is illegal in ref=20
> names as well as URLs.  I propose SPC.  ('#' is allowed in refnames.)

It's a question, whether the branch name is part of the URI, or a fragment.

Current usage suggests it is a fragment, but according to the URL
specification that is supposed to mean that the resource is always accessed
the same (fragment is NOT part of the URL) and the fragment only affects
local handling. Which I don't think is really true.

If it is a fragment, than "#" is the only correct separator and should stay
that way.

If it is not a true fragment, than we might want to phase it out in favor of
something else. But I would strongly prefer staying within characters allow=
ed
in URI (as per rfc2396). We could consider whether the branch is not
a component parameter -- which would imply ";" as separator, but I would vo=
te
against that on the basis that it's shell special. Non-special characters
allowed by URL in this context would be ":", "@", "=3D", "+", and ",", of w=
hich
":" or "@" seem best to me.

As for multiple branches, separating them with "," feels logical to me, no
matter what separates them from the repository path. On the other hand given
that neither ":" nor "@" is allowed in refnames, reusing the same separator
would make sense especially if git switched to either of those.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFShwRel1vVwhjGURAijEAKCVeZj4Htrb/q+fMrMYF+vdIh6frwCg3ecF
xwvRQIedXqBjUSuzMo0IlVQ=
=xVd1
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
