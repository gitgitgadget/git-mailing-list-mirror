From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: several date related issues
Date: Thu, 25 Jun 2015 13:19:01 +0200
Message-ID: <20150625131901.5b962336@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/HmZvLBJZSgFwG+k.IChtyG5"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:19:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85Bh-0003aE-1R
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbFYLTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:19:12 -0400
Received: from lb2-smtp-cloud2.xs4all.net ([194.109.24.25]:51472 "EHLO
	lb2-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751617AbbFYLTK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 07:19:10 -0400
Received: from pc09.procura.nl ([92.66.41.201])
	by smtp-cloud2.xs4all.net with ESMTP
	id kbK71q00J4LQezg01bK8wC; Thu, 25 Jun 2015 13:19:08 +0200
X-Mailer: Claws Mail 3.11.1-171-g6f063a (GTK+ 2.24.23; x86_64-suse-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272658>

--Sig_/HmZvLBJZSgFwG+k.IChtyG5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Running 2.4.4

*** Dates do not respect LC_TIME

$ date
Thu 25 Jun 2015 13:02:48 CEST
$ git log --pretty=3Dfuller --date=3Dlocal | head -6 | grep -i date
AuthorDate: Mon Feb 16 16:47:08 2015
CommitDate: Mon Feb 16 16:47:08 2015
$ locale -ck LC_TIME | grep fmt
d_t_fmt=3D"%a %d %b %Y %r %Z"
d_fmt=3D"%d-%m-%Y"
t_fmt=3D"%r"
t_fmt_ampm=3D"%H:%M:%S"
era_d_fmt=3D""
era_d_t_fmt=3D""
era_t_fmt=3D""
date_fmt=3D"%a %e %b %Y %H:%M:%S %Z"

*** git log --date-order and --author-date-order do not order by date

$ mkdir git-test
$ cd git-test
$ git init
Initialized empty Git repository in /home/merijn/git-test/.git/
$ touch foo
$ git add foo
$ git commit -m boo
[master (root-commit) 09483e5] boo
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git log | cat
commit 09483e527d6a4d4a9e49f82a11871ab55133cf72
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jun 25 13:14:37 2015 +0200

    boo
$ touch bar
$ env GIT_AUTHOR_DATE=3D"2015-01-15 12:13:14" GIT_COMMITTER_DATE=3D"2015-01=
-15 12:13:14" git add bar
$ env GIT_AUTHOR_DATE=3D"2015-01-15 12:13:14" GIT_COMMITTER_DATE=3D"2015-01=
-15 12:13:14" git commit -m "Commit in past"
[master 6acc7f3] Commit in past
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ git log | cat
commit 6acc7f3d2cbaca7176b63ffac51005ce07b90b91
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jan 15 12:13:14 2015 +0100

    Commit in past

commit 09483e527d6a4d4a9e49f82a11871ab55133cf72
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jun 25 13:14:37 2015 +0200

    boo
$ git log --date-order | cat
commit 6acc7f3d2cbaca7176b63ffac51005ce07b90b91
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jan 15 12:13:14 2015 +0100

    Commit in past

commit 09483e527d6a4d4a9e49f82a11871ab55133cf72
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jun 25 13:14:37 2015 +0200

    boo
$ git log --author-date-order | cat
commit 6acc7f3d2cbaca7176b63ffac51005ce07b90b91
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jan 15 12:13:14 2015 +0100

    Commit in past

commit 09483e527d6a4d4a9e49f82a11871ab55133cf72
Author: H.Merijn Brand <h.m.brand@xs4all.nl>
Date:   Thu Jun 25 13:14:37 2015 +0200

    boo
$


--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/HmZvLBJZSgFwG+k.IChtyG5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVi+OrAAoJEAOhR6E+XcCYAx8H/jiDYt6J8batWfPo0op7mKHg
T6wl4Kh0Sn212bS3EXxnCPc8YaMv+dPVf8k0F1ry5eIc7q0xPAGrkQLM5oOQJxKk
15Pm55YsKYeAsrbdxTxTS/zGTsucEaf/ZuugfGWb6kXHdX3QRm2BeLbhptawv5+j
WMMn3eO5LyEthp7kpeSEbzsbsq5/4B9BFEbFHix3A3VaSfTWqokhsiFxtSTr5Zm9
OWLYDtRpxXN9K9ohclj/p5O3lMzcBYByshSApez/4A45n0YekMKX6glYuqjZrczI
WrrpAV6x8cVk7tPCQ9jdaUbD+lY8TTA5yVTunG+ZlbGJTOnT8SMRyjoNJC5ZqR0=
=Igy0
-----END PGP SIGNATURE-----

--Sig_/HmZvLBJZSgFwG+k.IChtyG5--
