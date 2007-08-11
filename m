From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Fix t5701-clone-local for white space from wc
Date: Sat, 11 Aug 2007 15:24:29 -0400
Message-ID: <20070811192429.GA10142@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 21:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJwZe-0005yL-O6
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 21:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbXHKTY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbXHKTY3
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 15:24:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54658 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbXHKTY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 15:24:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 177521FFC01F
	for <git@vger.kernel.org>; Sat, 11 Aug 2007 19:24:27 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55621>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Once again the fact that OS X's wc outputs "   0" instead of "0" breaks
 tests.

 t/t5701-clone-local.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index a3026ec..56f9d8a 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -48,7 +48,7 @@ test_expect_success 'With -no-hardlinks, local will make a copy' '
 	git clone --bare --no-hardlinks x w &&
 	cd w &&
 	linked=$(find objects -type f ! -links 1 | wc -l) &&
-	test "$linked" = 0
+	test 0 = $linked
 '
 
 test_expect_success 'Even without -l, local will make a hardlink' '
@@ -57,7 +57,7 @@ test_expect_success 'Even without -l, local will make a hardlink' '
 	git clone -l --bare x w &&
 	cd w &&
 	copied=$(find objects -type f -links 1 | wc -l) &&
-	test "$copied" = 0
+	test 0 = $copied
 '
 
 test_done
-- 
1.5.3.rc4.67.gf9286-dirty
