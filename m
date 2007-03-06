From: Nur Hussein <hussein@cs.usm.my>
Subject: [PATCH 1/1] Guilt: Fixed guilt-patchbomb temporary mbox deletion
	bug
Date: Tue, 06 Mar 2007 15:01:46 +0800
Message-ID: <1173164506.4877.19.camel@gandalf.dcc.usm.my>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Mar 06 08:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOThr-00043f-HW
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965825AbXCFHD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbXCFHD3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:03:29 -0500
Received: from cs.usm.my ([202.170.56.49]:47040 "EHLO cs.usm.my"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965825AbXCFHD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:03:28 -0500
Received: from localhost (cs.usm.my [10.207.207.3])
	by cs.usm.my (8.13.8/8.13.8) with ESMTP id l2670Wh6025949;
	Tue, 6 Mar 2007 15:00:33 +0800 (SGT)
X-Mailer: Evolution 2.6.3 
X-Ppskomp-MailScanner-Information: Please contact the ISP for more information
X-Ppskomp-MailScanner: Found to be clean
X-Ppskomp-MailScanner-From: hussein@cs.usm.my
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41546>

A bug occurred where the temporary mbox is deleted even when 'N' or 'n' was selected
because of the incorrect use of the -a operator when testing user input. Fixed now to
use -o instead.

Signed-off-by: Nur Hussein <hussein@cs.usm.my>
---
 guilt-patchbomb |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/guilt-patchbomb b/guilt-patchbomb
index 6f51b4b..ad80fb1 100755
--- a/guilt-patchbomb
+++ b/guilt-patchbomb
@@ -88,5 +88,5 @@ fi
 echo -n "Delete temporary directory? [Y/n] "
 read n
 
-[ "$n" != "n" -a "$n" != "N" ] && exit 0
+[ "$n" != "n" -o "$n" != "N" ] && exit 0
 rm -rf $dir
-- 
1.4.4.4


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
