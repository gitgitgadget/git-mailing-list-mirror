From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Adjust t3404 to ignore empty lines in the todo file
Date: Thu, 22 Nov 2007 11:41:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221139490.27959@racer.site>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711221113360.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvARK-0005ru-1Q
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbXKVLld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbXKVLld
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:41:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:53361 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbXKVLlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:41:32 -0500
Received: (qmail invoked by alias); 22 Nov 2007 11:41:30 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 22 Nov 2007 12:41:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/e5eYhUZfeORh5hfLiGl1mziuqxs6N5ZNyc3i2wx
	iyKV83J8QboPZc
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711221113360.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65806>


---

	... and this fixes the tests again.  I changed the single "#"
	line after the commits to an empty line, since it made things
	more readable to this developer.  The test expected "#", though.

	Please amend.

 t/t3404-rebase-interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f1039d1..907c7f9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -149,7 +149,8 @@ test_expect_success 'stop on conflicting pick' '
 	diff -u expect .git/.dotest-merge/patch &&
 	diff -u expect2 file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
-	test 0 = $(grep -v "^#" < .git/.dotest-merge/git-rebase-todo | wc -l)
+	test 0 = $(grep -ve "^#" -e "^$" < .git/.dotest-merge/git-rebase-todo |
+		wc -l)
 '
 
 test_expect_success 'abort' '
-- 
1.5.3.6.1977.g54d30
