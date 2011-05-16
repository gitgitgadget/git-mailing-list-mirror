From: Hermann Gausterer <git-mailinglist@mrq1.org>
Subject: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Mon, 16 May 2011 18:26:11 +0200
Message-ID: <20110516162611.GA6960@mrq1.org>
References: <7v7h9rpuzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 18:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM0ci-0005oY-VW
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 18:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab1EPQ0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 12:26:16 -0400
Received: from smtpout02.highway.telekom.at ([195.3.96.113]:3578 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751790Ab1EPQ0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 12:26:15 -0400
Received: (qmail 17070 invoked from network); 16 May 2011 16:26:12 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL603.highway.telekom.at
X-Spam-Level: 
Received: from 93-82-36-149.adsl.highway.telekom.at (HELO mrq1.org) ([93.82.36.149])
          (envelope-sender <git-mailinglist@mrq1.org>)
          by smarthub96.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 16 May 2011 16:26:12 -0000
Content-Disposition: inline
In-Reply-To: <7v7h9rpuzb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173745>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

this combines the two commands "y"+"q" to one.
i use this if i know that this is the last hunk to add.

Signed-off-by: Hermann Gausterer <git-git-2011@mrq1.org>
---
 Documentation/git-add.txt |    1 +
 git-add--interactive.perl |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c1d395..76ffd45 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -280,6 +280,7 @@ patch::
        y - stage this hunk
        n - do not stage this hunk
        q - quit; do not stage this hunk nor any of the remaining ones
+       Q - quit; stage this hunk but none of the remaining ones
        a - stage this hunk and all later hunks in the file
        d - do not stage this hunk nor any of the later hunks in the file
        g - select a hunk to go to
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 4f08fe7..67d0b48 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1123,6 +1123,7 @@ sub help_patch_cmd {
 y - $verb this hunk$target
 n - do not $verb this hunk$target
 q - quit; do not $verb this hunk nor any of the remaining ones
+Q - quit; $verb this hunk but none of the remaining ones
 a - $verb this hunk and all later hunks in the file
 d - do not $verb this hunk nor any of the later hunks in the file
 g - select a hunk to go to
@@ -1313,7 +1314,7 @@ sub patch_update_file {
 		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
 		   ' this hunk'),
 		  $patch_mode_flavour{TARGET},
-		  " [y,n,q,a,d,/$other,?]? ";
+		  " [y,n,q,Q,a,d,/$other,?]? ";
 		my $line =3D prompt_single_character;
 		if ($line) {
 			if ($line =3D~ /^y/i) {
@@ -1366,6 +1367,9 @@ sub patch_update_file {
 				next;
 			}
 			elsif ($line =3D~ /^q/i) {
+				if ($line =3D~ /^Q/) {
+					$hunk[$ix]{USE} =3D 1;
+				}
 				for ($i =3D 0; $i < $num; $i++) {
 					if (!defined $hunk[$i]{USE}) {
 						$hunk[$i]{USE} =3D 0;
--=20
1.7.0.4


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFN0VAjAdCXZ1Xu7u4RAmcXAKC1YcuWsQ5vyg0Z+g1TsqlAsY0hpACdEozN
Mf22cm80G01Ey6oaAj0sOWk=
=VBkl
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
