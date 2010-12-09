From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@MIT.EDU>
Subject: [PATCH] git-send-email: Accept -n as a synonym for --dry-run
Date: Wed,  8 Dec 2010 23:44:38 -0500
Message-ID: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 05:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQYSX-0002Da-Bz
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 05:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab0LIEtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 23:49:43 -0500
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:50909 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab0LIEtn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 23:49:43 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2010 23:49:43 EST
X-AuditID: 1209190e-b7b3bae000000a71-c0-4d005eb9dbeb
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 18.9A.02673.9BE500D4; Wed,  8 Dec 2010 23:44:41 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id oB94ifie013413
	for <git@vger.kernel.org>; Wed, 8 Dec 2010 23:44:41 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oB94icUI001759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 8 Dec 2010 23:44:40 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
	id A7A5014C011; Wed,  8 Dec 2010 23:44:38 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163261>

git-send-email is not currently using -n for anything else, and it
seems unlikely we will want to use it to mean anything else in the
future, so add it as an alias for convenience.

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 git-send-email.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..7e3df9a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -85,7 +85,7 @@ git send-email [options] <file | directory | rev-list=
 options >
     --confirm               <str>  * Confirm recipients before sending=
;
                                      auto, cc, compose, always, or nev=
er.
     --quiet                        * Output one line of info per email=
=2E
-    --dry-run                      * Don't actually send the emails.
+    -n, --dry-run                  * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Defa=
ult on.
     --[no-]format-patch            * understand any non optional argum=
ents as
                                      `git format-patch` ones.
@@ -304,7 +304,7 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$send=
er,
 		    "suppress-cc=3Ds" =3D> \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
 		    "confirm=3Ds" =3D> \$confirm,
-		    "dry-run" =3D> \$dry_run,
+		    "dry-run|n" =3D> \$dry_run,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
 		    "validate!" =3D> \$validate,
--=20
1.7.3.3
