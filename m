From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t1305: fix include by absolute path test on Windows
Date: Fri, 17 Feb 2012 09:31:32 +0100
Message-ID: <4F3E1064.5080603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 09:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyJEE-0008CP-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 09:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab2BQIbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 03:31:38 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45028 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab2BQIbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 03:31:38 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RyJE4-0007BY-Rd; Fri, 17 Feb 2012 09:31:33 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 918AC1660F;
	Fri, 17 Feb 2012 09:31:32 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Enigmail-Version: 1.3.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190939>

From: Johannes Sixt <j6t@kdbg.org>

Git on Windows does not understand bash's /c/dir/... POSIXy paths, so that
the test fails. Ensure that the config file mentions the Windows style
absolute path to the file to be included.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Feel free to squash this into the patch that adds the test.

 t/t1305-config-include.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f3e03a0..4b1cbaa 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -5,7 +5,7 @@ test_description='test config file include directives'
 
 test_expect_success 'include file by absolute path' '
 	echo "[test]one = 1" >one &&
-	echo "[include]path = \"$PWD/one\"" >.gitconfig &&
+	echo "[include]path = \"$(pwd)/one\"" >.gitconfig &&
 	echo 1 >expect &&
 	git config test.one >actual &&
 	test_cmp expect actual
-- 
1.7.9.1264.g9b7e2
