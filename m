X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Set $HOME for selftests
Date: Tue, 24 Oct 2006 20:00:37 +0000
Message-ID: <20061024200037.17087.qmail@d8dab9a84b4add.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 24 Oct 2006 20:01:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30007>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcSRh-0002aE-JW for gcvg-git@gmane.org; Tue, 24 Oct
 2006 22:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161211AbWJXUAS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 16:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbWJXUAR
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 16:00:17 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:52640 "HELO
 a.mx.smarden.org") by vger.kernel.org with SMTP id S1161211AbWJXUAQ (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 16:00:16 -0400
Received: (qmail 17088 invoked by uid 1000); 24 Oct 2006 20:00:37 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Set HOME environment variable to test trash directory and export for
selftests.  This fixes the git-svn selftests with nonexistent or not
readable home, as found in at least one automated build system:

 http://buildd.debian.org/fetch.cgi?&pkg=git-core&ver=1%3A1.4.2.3-2&arch=alpha&stamp=1161537466&file=log

Signed-off-by: Gerrit Pape <pape@smarden.org>

---
 t/test-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2488e6e..07cb706 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -207,7 +207,8 @@ # Test the binaries we have just built. 
 # t/ subdirectory and are run in trash subdirectory.
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
-export PATH GIT_EXEC_PATH
+HOME=$(pwd)/trash
+export PATH GIT_EXEC_PATH HOME
 
 # Similarly use ../compat/subprocess.py if our python does not
 # have subprocess.py on its own.
-- 
1.4.2.3
