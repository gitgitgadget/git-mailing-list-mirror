From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 01/10] t9903: remove Zsh test from the suite of Bash prompt tests
Date: Tue, 27 May 2014 03:40:51 -0400
Message-ID: <1401176460-31564-2-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
 <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC0t-0003O6-Me
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbaE0Hlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:31 -0400
Received: from smtp.bbn.com ([128.33.0.80]:56149 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbaE0Hla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:30 -0400
Received: from socket.bbn.com ([192.1.120.102]:50698)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC0n-000PGw-C0; Tue, 27 May 2014 03:41:29 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id E44AD4037C
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250146>

This test is about to become redundant:  All of the Bash prompt tests
will be moved into a separate library file that will also be used by a
new Zsh-specific test script.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/t9903-bash-prompt.sh | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 9150984..335383d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -577,15 +577,4 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - zsh color pc mode' '
-	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
-	(
-		ZSH_VERSION=5.0.0 &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
 test_done
-- 
1.9.3
