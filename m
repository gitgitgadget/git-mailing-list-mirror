From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 18/31] git-remote-mediawiki: Assign a variable as undef and make proper indentation
Date: Fri, 14 Jun 2013 15:50:26 +0200
Message-ID: <1371217839-23017-19-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnURQ-0002gj-VN
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab3FNNwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:52:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33270 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab3FNNvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:51:00 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDovCI011201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:57 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDoxhk013397;
	Fri, 14 Jun 2013 15:50:59 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqgA016142;
	Fri, 14 Jun 2013 15:50:58 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:50:57 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227860>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Explicitly assign local variable $/ as undef and make a proper
one-instruction-by-line indentation

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 29fb614..d1cddab 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -338,7 +338,10 @@ sub run_git {
 	my $args =3D shift;
 	my $encoding =3D (shift || "encoding(UTF-8)");
 	open(my $git, "-|:$encoding", "git " . $args);
-	my $res =3D do { local $/; <$git> };
+	my $res =3D do {
+		local $/ =3D undef;
+		<$git>
+	};
 	close($git);
=20
 	return $res;
--=20
1.8.3.rc3.49.g4e74807
