From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Demonstrate breakage: checkout overwrites untracked symlink
 with directory
Date: Tue, 15 Feb 2011 08:24:36 +0100
Message-ID: <4D5A2A34.7090008@viscovery.net>
References: <201102022025.06140.j6t@kdbg.org> <7v7hdixkys.fsf@alter.siamese.dyndns.org> <201102022324.22123.j6t@kdbg.org> <201102051918.44848.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 08:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpFHD-0006NJ-NU
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 08:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab1BOHYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 02:24:43 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62083 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751758Ab1BOHYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 02:24:41 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PpFH2-0005Ny-Vj; Tue, 15 Feb 2011 08:24:37 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 885861660F;
	Tue, 15 Feb 2011 08:24:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <201102051918.44848.j6t@kdbg.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166822>

I forgot to test the patch on Windows.. Would you please squash this
into js/checkout-untracked-symlink~1 ?

Thanks a lot!

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fixup! Make test case number unique, mark tests with SYMLINKS prerequisite

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 ...ut-overwrite.sh => t2021-checkout-overwrite.sh} |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
 rename t/{t2019-checkout-overwrite.sh => t2021-checkout-overwrite.sh} (83%)

diff --git a/t/t2019-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
similarity index 83%
rename from t/t2019-checkout-overwrite.sh
rename to t/t2021-checkout-overwrite.sh
index e4e529d..27db2ad 100755
--- a/t/t2019-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -29,7 +29,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 	test -f a/b
 '
 
-test_expect_success 'create a commit where dir a/b changed to symlink' '
+test_expect_success SYMLINKS 'create a commit where dir a/b changed to symlink' '
 
 	rm -rf a/b &&	# cleanup if previous test failed
 	git checkout -f -b symlink start &&
@@ -39,7 +39,7 @@ test_expect_success 'create a commit where dir a/b changed to symlink' '
 	git commit -m "dir to symlink"
 '
 
-test_expect_failure 'checkout commit with dir must not remove untracked a/b' '
+test_expect_failure SYMLINKS 'checkout commit with dir must not remove untracked a/b' '
 
 	git rm --cached a/b &&
 	git commit -m "un-track the symlink" &&
-- 
1.7.4.2.gb816c.dirty
