From: Joey Hess <joey@kitenet.net>
Subject: git log and utf-u in filenames
Date: Thu, 25 Sep 2008 17:50:02 -0400
Message-ID: <20080925215002.GA30810@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 23:51:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiyk0-0004ua-59
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbYIYVuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbYIYVuI
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:50:08 -0400
Received: from wren.kitenet.net ([80.68.85.49]:57153 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbYIYVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:50:07 -0400
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 6C80D314303
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 17:50:05 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id D1F881142B1; Thu, 25 Sep 2008 17:50:02 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8340/Thu Sep 25 16:13:43 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96809>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Git, particularly git-log seems to not display utf-8 characters in filename=
s,
instead showing an escaped representation. On the other hand, commit messag=
es,
as git-log(1) notes, are assumed to be utf-8, and the same utf-8 character
used in a commit message is not escaped, and displays ok.

Can anyone point me at the documentation for this utf-8 filename escaping,
assuming it's not a bug? And did earlier versions of git (circa 2006) perha=
ps
not do that escaping? I have code in ikiwiki that apparently used to work, =
but
is certianly not working with current git, due to this escaping.

Here's an example of the inconsistent handling of the same utf-8 character
("=F6") in commit messages and filenames.

joey@kodama:~/tmp>mkdir utf8; cd utf8; git-init
Initialized empty Git repository in /home/joey/tmp/utf8/.git/
joey@kodama:~/tmp/utf8>echo hi > =F6
joey@kodama:~/tmp/utf8>git add =F6; git commit -m 'adding file: =F6'
Created initial commit ee7d809: adding file: =F6
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 "\303\266"
joey@kodama:~/tmp/utf-8>git log --stat
commit ee7d809d1811b1e1ad485ce3e7274316257029ae
Author: Joey Hess <joey@kodama.kitenet.net>
Date:   Thu Sep 25 17:34:10 2008 -0400
      =20
          adding file: =F6
      =20
 "\303\266" |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--=20
see shy jo

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFI3AeBd8HHehbQuO8RArDsAJ9UcaU3O2F/ujGNcZHknk2K3Yt7uQCgpKV7
3YJNNCvHNoc5dyrXeHTov30=
=KyZb
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
