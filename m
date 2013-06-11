From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v4 19/31] git-remote-mediawiki: Check return value of open
Date: Wed, 12 Jun 2013 00:18:10 +0200
Message-ID: <1370989102-24942-20-git-send-email-celestin.matte@ensimag.fr>
References: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWuu-0007jn-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405Ab3FKWTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 18:19:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48152 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756819Ab3FKWSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:18:45 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BMIfGD012574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 00:18:41 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BMIhdr024064;
	Wed, 12 Jun 2013 00:18:43 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BMIb2d018360;
	Wed, 12 Jun 2013 00:18:43 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 00:18:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227551>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 15ad19b..d95119f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -337,7 +337,8 @@ sub get_mw_pages {
 sub run_git {
 	my $args =3D shift;
 	my $encoding =3D (shift || "encoding(UTF-8)");
-	open(my $git, "-|:$encoding", "git " . $args);
+	open(my $git, "-|:$encoding", "git " . $args)
+	    or die "Unable to open: $!\n";
 	my $res =3D do {
 		local $/ =3D undef;
 		<$git>
--=20
1.7.9.5
