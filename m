From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-mkpatch: Show diffstat before the patch
Date: Wed, 27 Apr 2005 00:58:55 +0200
Message-ID: <20050426225855.GA28560@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYwy-0006W7-LF
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVDZW7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVDZW7S
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:59:18 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:30948 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261835AbVDZW7A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 18:59:00 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id BD37B6E2BD0; Wed, 27 Apr 2005 00:58:03 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 387C46E2B32; Wed, 27 Apr 2005 00:58:01 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id AC9F161FDE; Wed, 27 Apr 2005 00:58:55 +0200 (CEST)
To: pasky@ucw.cz
Mail-Followup-To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Show diffstat before the patch.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit a738ed98e4557877f8bcd3b992aa55579b22b9d1
tree 2447d3a399200c8f736344822969f88f675612dd
parent ed095b1a965517f1674b812a9978c60eb907e192
author Jonas Fonseca <fonseca@diku.dk> 1114554627 +0200
committer Jonas Fonseca <fonseca@diku.dk> 1114554627 +0200

 cg-mkpatch |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: cg-mkpatch
===================================================================
--- 6159f313b10f0cfcdfedd63d6fb044029fe46aaa/cg-mkpatch  (mode:100755 sha1:5ba423cbbb3e5f72cd7fb74f2873d49b60557f12)
+++ 2447d3a399200c8f736344822969f88f675612dd/cg-mkpatch  (mode:100755 sha1:25c67a29296730daeac00e43fd4c18cf914a1c87)
@@ -23,7 +23,10 @@
 		echo $line >>$header
 	done
 	echo
-	cg-diff -p -r $id
+	cg-diff -p -r $id > $header
+	cat $header | diffstat
+	echo
+	cat $header
 	rm $header
 }
 


-- 
Jonas Fonseca
