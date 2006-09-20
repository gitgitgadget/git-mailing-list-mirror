From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Add branch test case: create "j/k" when "j" has been
 deleted.
Date: Wed, 20 Sep 2006 07:03:50 +0200
Message-ID: <20060920070350.29039f28.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 06:57:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPu9f-0000RS-02
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 06:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWITE5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 00:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWITE5n
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 00:57:43 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:64237 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751178AbWITE5n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 00:57:43 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8A9A268851;
	Wed, 20 Sep 2006 06:57:41 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27329>

Linus wrote:
"Somebody should add this test-case

        git branch test
        git branch -d test
        git branch test/first

which should work."

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3200-branch.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5b04efc..d863498 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -61,4 +61,11 @@ test_expect_success \
 	 test -f .git/logs/refs/heads/g/h/i &&
 	 diff expect .git/logs/refs/heads/g/h/i'
 
+test_expect_success \
+    'git branch j/k should work after branch j has been deleted' \
+	'git-branch j &&
+	 git-branch -d j &&
+	 git-branch j/k'
+
+
 test_done
-- 
1.4.2.1.g251a
