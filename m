From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [RFC/ PATCH 4/5] t3030: update porcelain expected message
Date: Wed,  9 Jun 2010 14:44:05 +0200
Message-ID: <1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 15:27:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLJI-0005bm-UK
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745Ab0FIN0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 09:26:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34209 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757646Ab0FIN0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:26:41 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o59Cb7YG011088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 14:37:09 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59Cio4Y010563;
	Wed, 9 Jun 2010 14:44:50 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59CiofH025414;
	Wed, 9 Jun 2010 14:44:50 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59Cio3s025413;
	Wed, 9 Jun 2010 14:44:50 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jun 2010 14:37:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59Cb7YG011088
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148777>

=46rom: Diane <diane.gasselin@ensimag.imag.fr>

As porcelain messages have been changed, the expected porcelain message
tested in this test needs to be changed.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
---
 t/t3030-merge-recursive.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 9929f82..9ac5df8 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -268,6 +268,11 @@ test_expect_success 'merge-recursive result' '
 	test_cmp expected actual
=20
 '
+cat> expected2 <<EOF
+error: Your local changes to the files:
+	a
+would be overwritten by merge.
+EOF
=20
 test_expect_success 'fail if the index has unresolved entries' '
=20
@@ -282,7 +287,8 @@ test_expect_success 'fail if the index has unresolv=
ed entries' '
 	grep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
 	test_must_fail git merge "$c5" 2> out &&
-	grep "Your local changes to .* would be overwritten by merge." out
+	grep -A 2 "Your local changes to" out > tmp &&
+	test_cmp expected2 tmp
 '
=20
 test_expect_success 'merge-recursive remove conflict' '
--=20
1.6.6.7.ga5fe3
