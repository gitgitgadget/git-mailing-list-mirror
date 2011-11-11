From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 22:03:52 +0100
Message-ID: <20111111210352.GA4752@centaur.lab.cmartin.tk>
References: <1321044904175-6986736.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 22:04:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROyGV-0003fx-So
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 22:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab1KKVDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 16:03:55 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:56669 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557Ab1KKVDy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 16:03:54 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9f7e4.pool.mediaWays.net [77.185.247.228])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 2B54F46191;
	Fri, 11 Nov 2011 22:03:17 +0100 (CET)
Received: (nullmailer pid 27894 invoked by uid 1000);
	Fri, 11 Nov 2011 21:03:52 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jvsrvcs <jvsrvcs@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1321044904175-6986736.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185285>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2011 at 12:55:04PM -0800, Jvsrvcs wrote:
> Unexpected git behaviour
>=20
[ ... switch branches with local modifications ...]
> #You will see both lines in the master. =20
>=20
> Question #1:
> 	Why was this line added in the *master branch?
>=20

It wasn't. that line was added in the working directory. When you
switch branches, if the file in the tip of the current branch and the
file in the tip of the target branch don't differ, it's safe to keep
your local changes, so git does. This is to support the use-case where
you start editing a file when the wrong branch is checked out and want
to change to the right one.

>=20
> --- even further surprising
> In the master branch, now do a commit
> $git commit -a
>=20
> cat readme.txt ( you will see the line in the master now that was added in
> the test branch )
>=20
> Question #2:
> 	Why did this happen?

Because you told git to commit the file with that modification in it.

>=20
> # Now switch back to the test branch
> $git checkout test
> $cat readme.txt
>=20
> You will only see the one line: "This was added in the master branch"
>=20
> Question #3:
> 	Why did this happen?

Because the file in the 'test' branch only has that line. As you said
yourself, you edited the file but didn't commit.

>=20
> and NOT the line added in that branch: "this was added in the test branch"
> <=3D this line is gone

Again, that line wasn't added in any branch but in the working
directory. The active branch was 'test', but doesn't magically mean
that uncommitted changes travel with it.

   cmn

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOvY24AAoJEHKRP1jG7ZzTl3YH/iLz2VTUU2brd2Mh43nUeB4z
jaBWr+uGL0rKOsQTRm5yNBDWdssHcuAduoCD4jnlZfir9x2TQNN2er1CsfrRqHh9
5nHeHmgJ6L7sX5nkJK6at+7KkhuX2M1r0hsAI16I9K0Ni0zrcJi1SlfGNlmvBsWe
oq+v66Eabe9TlRS+BG2NggD/J3jnF07pWBaFs9TfgObtueRKD8mzH3qPvpj9yXl3
aolvoQedondM0qiHCZmX8+IlJbeThhfMraqctkZK8zSjWVrOlNYO+wu2wFHntpu2
WpOHdmDHRplOpeerlhsyCGe/d2hnFlI1oWAvTuQE7znxP7TaC6R8wUxRXZTVge8=
=oXig
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
