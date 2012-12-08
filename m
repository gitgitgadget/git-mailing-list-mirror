From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 6/8] t9402: Simplify git ls-tree
Date: Sat, 8 Dec 2012 22:35:06 +0100
Message-ID: <201212082235.07652.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS3i-00020r-8J
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200Ab2LHVf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:35:26 -0500
Received: from mout.web.de ([212.227.17.11]:49695 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758189Ab2LHVfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:35:25 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MUFGo-1TY8Pm1ha6-00Qarl; Sat, 08 Dec 2012 22:35:24 +0100
X-Provags-ID: V02:K0:LRC88+UbQUjk/y6SYn+nbfIbpbCpz1Oi/rXZvn2Eurs
 qimWoR0n0DoloHFnX3mH8ScNrlD7e1VZTVTDxAMaBKbb5XegkB
 wBxhQXa4I9titsl/MmwVoFqfywjIRYryn7CLkkEfbh72HCxuh4
 EhZ/tcL+HzEnOq1YiM6Yfm9mP4h10zo/gktrPZdASJmdPKIeS6
 GipEuerUyLweIxLTEavww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211220>

Use "git ls-tree --name-only" which does not need a sed to filter out t=
he sha

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9402-git-cvsserver-refs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index d525778..fadc80a 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -41,7 +41,7 @@ check_end_full_tree() {
     sort <"$WORKDIR/check.list" >expected &&
     find "$sandbox" -name CVS -prune -o -type f -print | sed -e "s%$sa=
ndbox/%%" | sort >act1 &&
 		test_cmp expected act1 &&
-    git ls-tree -r "$2" | sed -e "s/^.*blob [0-9a-fA-F]*[	 ]*//" | sor=
t >act2 &&
+    git ls-tree --name-only -r "$2" | sort >act2 &&
 		test_cmp expected act2 &&
     rm expected act1 act2
 }
--=20
1.8.0.197.g5a90748
