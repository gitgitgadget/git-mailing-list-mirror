From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH for kh/commit] Replace "runstatus" with "status" in the tests
Date: Thu, 15 Nov 2007 06:27:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150627100.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 15 07:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYEB-0007i5-NQ
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765904AbXKOG2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765652AbXKOG2R
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:28:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:41684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765798AbXKOG2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:28:16 -0500
Received: (qmail invoked by alias); 15 Nov 2007 06:28:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 15 Nov 2007 07:28:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HeGQ1dQEHzGXV9VNdI1EOK8tdT0fftqv+kRcpja
	YOqfcflGHAV3rB
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65067>


We no longer have "runstatus", but running "status" is no longer that 
expensive anyway; it is a builtin.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3001-ls-files-others-exclude.sh |    2 +-
 t/t4001-diff-rename.sh             |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index ae0639d..e25b255 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -86,7 +86,7 @@ EOF
 
 git config core.excludesFile excludes-file
 
-git runstatus | grep "^#	" > output
+git status | grep "^#	" > output
 
 cat > expect << EOF
 #	.gitignore
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 063e792..877c1ea 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -71,10 +71,10 @@ test_expect_success 'favour same basenames over different ones' '
 	git rm path1 &&
 	mkdir subdir &&
 	git mv another-path subdir/path1 &&
-	git runstatus | grep "renamed: .*path1 -> subdir/path1"'
+	git status | grep "renamed: .*path1 -> subdir/path1"'
 
 test_expect_success  'favour same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
-	git runstatus | grep "renamed: .*path1 -> subdir/path1"'
+	git status | grep "renamed: .*path1 -> subdir/path1"'
 
 test_done
-- 
1.5.3.5.1785.g714b8
