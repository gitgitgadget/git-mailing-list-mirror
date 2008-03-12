From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-quiltimport: fix security risk because of un-sanitized $level.
Date: Wed, 12 Mar 2008 21:46:48 +0100
Message-ID: <20080312204648.GA28729@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9amGYk9869ThD9tj";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZXrT-0003zC-0E
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbYCLUqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 16:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbYCLUqy
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 16:46:54 -0400
Received: from pan.madism.org ([88.191.52.104]:50487 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYCLUqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 16:46:53 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E95AD2DDC9;
	Wed, 12 Mar 2008 21:46:49 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A673099E; Wed, 12 Mar 2008 21:46:48 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76985>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  I assume that nobody will have a series with -p1000 in it :)
  sorry for this gross mistake in the first place.

  [ for the inattentive readers $level was used without quoting, for
    good reasons as it's sometime empty and then we don't want to pass
    an empty argument to git-apply, though someone could use that to run
    arbitrary commands, not nice ]

 git-quiltimport.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 84c8b8e..d35cb02 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -67,7 +67,7 @@ while read patch_name level garbage
 do
 	case "$patch_name" in ''|'#'*) continue;; esac
 	case "$level" in
-	-p*);;
+	-p[0-9]|-p[0-9][0-9]|-p[0-9][0-9][0-9]);;
 	''|'#'*)
 		level=3D;;
 	*)
--=20
1.5.4.4.599.gba501

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH2EE4vGr7W6HudhwRAshiAKCHvo3R/pd6JvC2dvHsSDR6J9i/AQCgpLBG
Qg0gt219q7ccOuWZaVqk0oI=
=T3tt
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
