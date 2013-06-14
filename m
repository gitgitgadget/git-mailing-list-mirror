From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 15/31] git-remote-mediawiki: Turn double-negated expressions into simple expressions
Date: Fri, 14 Jun 2013 15:50:23 +0200
Message-ID: <1371217839-23017-16-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUPJ-0001Cw-Kj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab3FNNvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:51:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33265 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab3FNNvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:51:00 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDouCh011182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:56 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDowJK013381;
	Fri, 14 Jun 2013 15:50:58 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqg7016142;
	Fri, 14 Jun 2013 15:50:57 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:50:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227840>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 1fcdf2d..68df6e4 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -131,16 +131,16 @@ while (<STDIN>) {
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
1.8.3.rc3.49.g4e74807
