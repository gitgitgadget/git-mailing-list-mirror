From: Emil Sit <sit@emilsit.net>
Subject: [PATCH] test-lib: Clean up comments and Makefile.
Date: Fri, 27 Mar 2009 21:57:18 -0400
Message-ID: <20090328015718.GD6538@cauchy-sequence.lcs.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 02:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnNoc-000351-5V
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 02:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbZC1B47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 21:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbZC1B47
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 21:56:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40013 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938AbZC1B46 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 21:56:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A15062FF812;
	Fri, 27 Mar 2009 21:56:56 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 Mar 2009 21:56:56 -0400
X-Sasl-enc: vONz/YQoE8X0FPP+7jVBcyqsRw5CsGQyCVDeJ80LEIdBwc9jIT1zgr0 1238205416
Received: from cauchy-sequence.lcs.mit.edu (h-68-166-237-209.cmbrmaor.dynamic.covad.net [68.166.237.209])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 63FDD227E7
	for <git@vger.kernel.org>; Fri, 27 Mar 2009 21:56:56 -0400 (EDT)
Received: by cauchy-sequence.lcs.mit.edu (Postfix, from userid 10900)
	id A06D69C168; Fri, 27 Mar 2009 21:57:18 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114932>

Bring documentation in test-lib and clean target
in Makefile in-line with abc5d372.

Signed-off-by: Emil Sit <sit@emilsit.net>
---
 t/Makefile    |    2 +-
 t/test-lib.sh |    8 --------
 2 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 0962341..bf816fc 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -24,7 +24,7 @@ pre-clean:
 	$(RM) -r test-results
 
 clean:
-	$(RM) -r 'trash directory' test-results
+	$(RM) -r 'trash directory'.* test-results
 
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2979e8e..b050196 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -523,14 +523,6 @@ test_done () {
 	fi
 	case "$test_failure" in
 	0)
-		# We could:
-		# cd .. && rm -fr 'trash directory'
-		# but that means we forbid any tests that use their own
-		# subdirectory from calling test_done without coming back
-		# to where they started from.
-		# The Makefile provided will clean this test area so
-		# we will leave things as they are.
-
 		say_color pass "passed all $msg"
 
 		test -d "$remove_trash" &&
-- 
1.5.4.3

-- 
Emil Sit / http://www.emilsit.net/
