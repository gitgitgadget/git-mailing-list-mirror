From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 07/28] git-remote-mediawiki: Rewrite unclear line of instructions
Date: Mon, 10 Jun 2013 00:22:32 +0200
Message-ID: <1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo1l-0000od-3v
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab3FIWXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:23:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41261 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab3FIWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:23:46 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNabt021489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:36 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNdPs019441;
	Mon, 10 Jun 2013 00:23:39 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHU008599;
	Mon, 10 Jun 2013 00:23:39 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 00:23:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNabt021489
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421421.62038@jl88ffQW6UhQQcO22VlI6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227177>

Subroutines' parameters should be affected to variable before doing any=
thing
else
Besides, existing instruction affected a variable inside a "if", which =
break
Git's coding style

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 431e063..2db6467 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1333,7 +1333,8 @@ sub get_mw_namespace_id {
 }
=20
 sub get_mw_namespace_id_for_page {
-	if (my ($namespace) =3D $_[0] =3D~ /^([^:]*):/) {
+	my $namespace =3D shift;
+	if ($namespace =3D~ /^([^:]*):/) {
 		return get_mw_namespace_id($namespace);
 	} else {
 		return;
--=20
1.7.9.5
