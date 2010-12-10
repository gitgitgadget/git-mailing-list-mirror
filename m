From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@MIT.EDU>
Subject: [PATCH 2/2] git-send-email: Add some short options
Date: Fri, 10 Dec 2010 13:44:16 -0500
Message-ID: <1292006656-1264-3-git-send-email-asedeno@mit.edu>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 19:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7xP-0005Ib-Q6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab0LJSof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Dec 2010 13:44:35 -0500
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:42317 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752114Ab0LJSoc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 13:44:32 -0500
X-AuditID: 12074423-b7bd0ae000000a00-ae-4d02750ff3ed
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 4A.85.02560.F05720D4; Fri, 10 Dec 2010 13:44:31 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id oBAIiUXW025272;
	Fri, 10 Dec 2010 13:44:30 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oBAIiSYp001541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Dec 2010 13:44:29 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
	id 294D114C013; Fri, 10 Dec 2010 13:44:28 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3
In-Reply-To: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163428>

* Accept -n as a synonym for --dry-run
* Accept -f as a synonym for --force
* Accept -q as a synonym for --quiet

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 Documentation/git-send-email.txt |    3 +++
 git-send-email.perl              |   12 ++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 7ec9dab..2d0faf2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -297,6 +297,7 @@ Default is the value of 'sendemail.confirm' configu=
ration value; if that
 is unspecified, default to 'auto' unless any of the suppress options
 have been specified, in which case default to 'compose'.
=20
+-n::
 --dry-run::
 	Do everything except actually send the emails.
=20
@@ -306,6 +307,7 @@ have been specified, in which case default to 'comp=
ose'.
 	or as a file name ('--no-format-patch'). By default, when such a conf=
lict
 	occurs, git send-email will fail.
=20
+-q::
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
@@ -322,6 +324,7 @@ have been specified, in which case default to 'comp=
ose'.
 Default is the value of 'sendemail.validate'; if this is not set,
 default to '--validate'.
=20
+-f::
 --force::
 	Send emails even if safety checks would prevent it.
=20
diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..ede7835 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -84,12 +84,12 @@ git send-email [options] <file | directory | rev-li=
st options >
   Administering:
     --confirm               <str>  * Confirm recipients before sending=
;
                                      auto, cc, compose, always, or nev=
er.
-    --quiet                        * Output one line of info per email=
=2E
-    --dry-run                      * Don't actually send the emails.
+    -q, --quiet                    * Output one line of info per email=
=2E
+    -n, --dry-run                  * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Defa=
ult on.
     --[no-]format-patch            * understand any non optional argum=
ents as
                                      `git format-patch` ones.
-    --force                        * Send even if safety checks would =
prevent it.
+    -f, --force                    * Send even if safety checks would =
prevent it.
=20
 EOT
 	exit(1);
@@ -298,19 +298,19 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$se=
nder,
 		    "identity=3Ds" =3D> \$identity,
 		    "annotate" =3D> \$annotate,
 		    "compose" =3D> \$compose,
-		    "quiet" =3D> \$quiet,
+		    "quiet|q" =3D> \$quiet,
 		    "cc-cmd=3Ds" =3D> \$cc_cmd,
 		    "suppress-from!" =3D> \$suppress_from,
 		    "suppress-cc=3Ds" =3D> \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
 		    "confirm=3Ds" =3D> \$confirm,
-		    "dry-run" =3D> \$dry_run,
+		    "dry-run|n" =3D> \$dry_run,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
 		    "validate!" =3D> \$validate,
 		    "format-patch!" =3D> \$format_patch,
 		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
-		    "force" =3D> \$force,
+		    "force|f" =3D> \$force,
 	 );
=20
 unless ($rc) {
--=20
1.7.3.3
