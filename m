From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: 6d4bb3833c3d2114d (fetch: verify we have everything we need before
 updating our ref) breaks fetch
Date: Wed, 28 Sep 2011 18:04:27 +0200
Message-ID: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ORH2faZWar+50fZ5Rv8s"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 18:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8wce-0007hu-9v
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 18:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab1I1QEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 12:04:31 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:54365 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab1I1QEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 12:04:30 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id BF59C46180;
	Wed, 28 Sep 2011 18:04:07 +0200 (CEST)
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182339>


--=-ORH2faZWar+50fZ5Rv8s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Whilst trying to do some work related to fetch, I came across a
regression in the 'next' branch. Bisecting gave me this commit as
breaking point (and I tried with the parent and there it worked). When
doing 'git fetch', rev-list will complain about usage, and fetch will
say that we didn't receive enough, even though earlier versions of git
have no problems. This fails both on github and on git.or.cz and for git
and http transports:

$ ./git-fetch git://repo.or.cz/git
usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
  limiting output:
    --max-count=3D<n>
    --max-age=3D<epoch>
    --min-age=3D<epoch>
    --sparse
    --no-merges
    --min-parents=3D<n>
    --no-min-parents
    --max-parents=3D<n>
    --no-max-parents
    --remove-empty
    --all
    --branches
    --tags
    --remotes
    --stdin
    --quiet
  ordering output:
    --topo-order
    --date-order
    --reverse
  formatting output:
    --parents
    --children
    --objects | --objects-edge
    --unpacked
    --header | --pretty
    --abbrev=3D<n> | --no-abbrev
    --abbrev-commit
    --left-right
  special purpose:
    --bisect
    --bisect-vars
    --bisect-all
error: git://repo.or.cz/git did not send all necessary objects

--=-ORH2faZWar+50fZ5Rv8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOg0WLAAoJEHKRP1jG7ZzT1SsH/A8Fz5BfVUcj/0SEmK0TZ2UL
qXpIymk5lBsigK8VS4n3PaPnpwc8Ut4tNmngAGtShkSv93bYqV/wzcDt9MYCedbg
Upz4gk2Uq0FFXx/+s+nBgKYQFRHX8ryjjONp6DTTEiiB2RccP5UyoRVAck1PjEPN
glUy3lOunRMNtaAwXmsi169K9wBOQ7KngKtjSFKiVNBS5Y1GUNNZr3+LsSO1bCTv
UAGVG/aJtdsT6k8SmicTvTiKkjDwF/DnMX+fd/rVfcZiJXZt6b0E/fQntRCegi4K
JQdTf3K0LWIdRP2C92R9IRIigJlus75IcBYxyrLhxJdMBtR8vaZuJGV3tLyUtQQ=
=PvwE
-----END PGP SIGNATURE-----

--=-ORH2faZWar+50fZ5Rv8s--
