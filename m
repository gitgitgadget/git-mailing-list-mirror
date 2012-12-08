From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 6/8] t9402: Simplify git ls-tree
Date: Sat, 8 Dec 2012 22:35:19 +0100
Message-ID: <201212082235.20257.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS3o-0002Bf-Jw
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203Ab2LHVfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:35:32 -0500
Received: from mout.web.de ([212.227.17.12]:58350 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758189Ab2LHVfb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:35:31 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0Lmu2K-1TFoLe2Sse-00hWXL; Sat, 08 Dec 2012 22:35:30 +0100
X-Provags-ID: V02:K0:0SKY3Pufj6aFAzU7X/B+9zqa9Tqw7F+h/micX7KPDrK
 X7moGWnNpoUuV52aL1c7dQvuUdYU09xnbBTv5jQTLnYgU/vFYs
 ezMPGimlYtylwC1lfRocQLFCtJCv1k25BSOUlj8JdbiMKAAvhf
 immB3lOYeQGzRWt5AluE/jK9My+4PBDkw9Ke/zxJMvLwzIySgE
 8gTXldKpcLc5GpxXe86uA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211221>

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
