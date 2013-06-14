From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 01/31] git-remote-mediawiki: Make a regexp clearer
Date: Fri, 14 Jun 2013 15:50:09 +0200
Message-ID: <1371217839-23017-2-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUP7-00014e-PX
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab3FNNu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:50:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33239 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660Ab3FNNuz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:50:55 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDoqkU011125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:52 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDorHP013311;
	Fri, 14 Jun 2013 15:50:53 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqfr016142;
	Fri, 14 Jun 2013 15:50:53 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:50:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227836>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Perl's split function takes a regex pattern argument. You can also
feed it an expression, which is then compiled into a regex at runtime.
It therefore works to pass your pattern via single quotes, but it is
much less obvious to a reader that the argument is meant to be a
regex, not a static string. Using the traditional slash-delimiters
makes this easier to read.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 7173872..882da1b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1170,7 +1170,7 @@ sub mw_push_revision {
 		# history (linearized with --first-parent)
 		print STDERR "Warning: no common ancestor, pushing complete history\=
n";
 		my $history =3D run_git("rev-list --first-parent --children $local")=
;
-		my @history =3D split('\n', $history);
+		my @history =3D split(/\n/, $history);
 		@history =3D @history[1..$#history];
 		foreach my $line (reverse @history) {
 			my @commit_info_split =3D split(/ |\n/, $line);
--=20
1.8.3.rc3.49.g4e74807
