From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 08/18] Explicitely assign local variable as undef and make a proper one-instruction-by- line indentation
Date: Thu,  6 Jun 2013 21:34:13 +0200
Message-ID: <1370547263-13558-9-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfyI-0001PQ-La
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab3FFTfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:35:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44532 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab3FFTfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:35:01 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYqQn031907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:53 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JYtuM021415;
	Thu, 6 Jun 2013 21:34:55 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTov023108;
	Thu, 6 Jun 2013 21:34:55 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 21:34:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYqQn031907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152097.20592@IERWJz+spIX7wkM0Er9Izw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226544>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 7fbc998..ae6dd2e 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -339,7 +339,10 @@ sub run_git {
 	my $args =3D shift;
 	my $encoding =3D (shift || "encoding(UTF-8)");
 	open(my $git, "-|:$encoding", "git " . $args);
-	my $res =3D do { local $/; <$git> };
+	my $res =3D do {=20
+		local $/ =3D undef;
+		<$git>
+	};
 	close($git);
=20
 	return $res;
--=20
1.7.9.5
