From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 10/22] git-remote-mediawiki: Turn double-negated expressions into simple expressions
Date: Fri,  7 Jun 2013 23:42:11 +0200
Message-ID: <1370641344-4253-11-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4S3-00009l-4b
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab3FGVn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55305 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621Ab3FGVnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:16 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lh25L003268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57Lh5WW029585;
	Fri, 7 Jun 2013 23:43:05 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRl019409;
	Fri, 7 Jun 2013 23:43:05 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lh25L003268
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246187.9353@iWhO31qLcpY5jeP3IyfLQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226732>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 68fd129..a6c7de2 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -136,16 +136,16 @@ while (<STDIN>) {
 	if (defined($cmd[0])) {
 		# Line not blank
 		if ($cmd[0] eq "capabilities") {
-			die("Too many arguments for capabilities\n") unless (!defined($cmd[=
1]));
+			die("Too many arguments for capabilities\n") if (defined($cmd[1]));
 			mw_capabilities();
 		} elsif ($cmd[0] eq "list") {
-			die("Too many arguments for list\n") unless (!defined($cmd[2]));
+			die("Too many arguments for list\n") if (defined($cmd[2]));
 			mw_list($cmd[1]);
 		} elsif ($cmd[0] eq "import") {
-			die("Invalid arguments for import\n") unless ($cmd[1] ne "" && !def=
ined($cmd[2]));
+			die("Invalid arguments for import\n") if ($cmd[1] eq "" || defined(=
$cmd[2]));
 			mw_import($cmd[1]);
 		} elsif ($cmd[0] eq "option") {
-			die("Too many arguments for option\n") unless ($cmd[1] ne "" && $cm=
d[2] ne "" && !defined($cmd[3]));
+			die("Too many arguments for option\n") if ($cmd[1] eq "" || $cmd[2]=
 eq "" || defined($cmd[3]));
 			mw_option($cmd[1],$cmd[2]);
 		} elsif ($cmd[0] eq "push") {
 			mw_push($cmd[1]);
--=20
1.7.9.5
