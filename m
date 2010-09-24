From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: git-1.7.3 breakage: "git stash show xxx" doesn't show anything
Date: Fri, 24 Sep 2010 19:19:37 +0000
Message-ID: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBbBYFH0ZHvzMoI/"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:20:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDoK-0005xM-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624Ab0IXTTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 15:19:44 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:45936 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757621Ab0IXTTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 15:19:42 -0400
Received: (qmail 30985 invoked from network); 24 Sep 2010 19:19:39 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Fri, 24 Sep 2010 19:19:39 +0000
Received: (qmail 9504 invoked by uid 10000); 24 Sep 2010 19:19:37 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157041>


--yBbBYFH0ZHvzMoI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Downstream bug: http://bugs.gentoo.org/338586

telling git-stash to show a specific stash no longer works with git-1.7.3:
  git stash show stash@{0}
  <no output!?>

Downgrading to dev-vcs/git-1.7.2.3 and it works fine.
Noticed on two stable amd64 systems.

Reproduction:
$ rm -rf foo && mkdir foo && cd foo
$ git init
Initialized empty Git repository in /home/vapier/foo/.git/
$ echo f > f && git add f && git commit -qmm
$ > f
$ git stash
Saved working directory and index state WIP on master: d287dea m
HEAD is now at d287dea m
$ git stash list | cat
stash@{0}: WIP on master: d287dea m
$ git stash show | cat
 f |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
$ git stash show stash@{0} | cat
<nothing!>

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--yBbBYFH0ZHvzMoI/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkyc+ckACgkQPpIsIjIzwizPywCg9GBn/fgjodNgNGel6iuXS3Vc
WqEAoO2AfYujHBz1Nj+/yYSLKud0mCFs
=RoH2
-----END PGP SIGNATURE-----

--yBbBYFH0ZHvzMoI/--
