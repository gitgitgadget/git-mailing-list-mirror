From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] t9105-fetch-local: quote path created with pwd
Date: Sun, 27 Nov 2005 21:05:21 +0100
Message-ID: <20051127200521.GA17293@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 21:06:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgSm9-0006Bi-5p
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 21:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVK0UFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 15:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVK0UFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 15:05:25 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:55783 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750754AbVK0UFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 15:05:25 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id BAED66DFD8A; Sun, 27 Nov 2005 21:04:42 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 866206DFDE4; Sun, 27 Nov 2005 21:04:42 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B56E161460; Sun, 27 Nov 2005 21:05:23 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12819>

Small fix to let it work when pwd contains spaces.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
diff --git a/t/t9105-fetch-local.sh b/t/t9105-fetch-local.sh
index a309693..35e2778 100755
--- a/t/t9105-fetch-local.sh
+++ b/t/t9105-fetch-local.sh
@@ -35,7 +35,7 @@ test_expect_success 'symlinked clone of 
 rm -rf repo2
 mkdir repo2
 test_expect_success 'clone in-current-dir repo2 from $(pwd)/../repo1/../repo1.git/' \
-	'(cd repo2 && cg-clone -s $(pwd)/../repo1/../repo1.git/)'
+	'(cd repo2 && cg-clone -s "$(pwd)/../repo1/../repo1.git/")'
 
 echo file1v2 >repo1/file1
 test_expect_success 'commit in repo1' \
 
-- 
Jonas Fonseca
