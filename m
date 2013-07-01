From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t4205: replace .\+ with ..* in sed commands
Date: Mon,  1 Jul 2013 14:59:59 -0400
Message-ID: <1372705199-17679-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 01 21:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtjKq-00082t-B4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3GATAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 15:00:20 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59052 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab3GATAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 15:00:20 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 2470727362F9; Mon,  1 Jul 2013 19:00:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (u-of-rochester-128-151-150-1.wireless.rochester.edu [128.151.150.1])
	by silverinsanity.com (Postfix) with ESMTPA id 99336273617B;
	Mon,  1 Jul 2013 19:00:06 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1.636.g893104c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229321>

OS X's sed only accepts basic regular expressions, which does not
allow the + quantifier.  However '..*' (anything, followed by zero or
more anything) is the same as '.\+' (one or more anything) and valid
in any regular expression language.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t4205-log-pretty-formats.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 719d132..3cfb744 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -192,7 +192,7 @@ test_expect_success 'left alignment formatting with trunc' "
 message ..
 message ..
 add bar  Z
-$(commit_msg "" "8" ".\+$")
+$(commit_msg "" "8" "..*$")
 EOF
 	test_cmp expected actual
 "
@@ -310,7 +310,7 @@ test_expect_success 'left/right alignment formatting with stealing' "
 short long  long long
 message ..   A U Thor
 add bar      A U Thor
-$(commit_msg "" "8" ".\+$")   A U Thor
+$(commit_msg "" "8" "..*$")   A U Thor
 EOF
 	test_cmp expected actual
 "
-- 
1.8.3.1.636.g893104c
