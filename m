From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 01/12] git p4 test: remove bash-ism of combined export/assignment
Date: Sun,  9 Sep 2012 16:16:02 -0400
Message-ID: <1347221773-12773-2-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnvw-0003jc-8i
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab2IIUQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:16:37 -0400
Received: from honk.padd.com ([74.3.171.149]:35553 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab2IIUQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:16:36 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 254F15AF2;
	Sun,  9 Sep 2012 13:16:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CAF4C32112; Sun,  9 Sep 2012 16:16:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205091>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2d753ab..482eeac 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -26,9 +26,10 @@ testid=${this_test#t}
 git_p4_test_start=9800
 P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 
-export P4PORT=localhost:$P4DPORT
-export P4CLIENT=client
-export P4EDITOR=:
+P4PORT=localhost:$P4DPORT
+P4CLIENT=client
+P4EDITOR=:
+export P4PORT P4CLIENT P4EDITOR
 
 db="$TRASH_DIRECTORY/db"
 cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
-- 
1.7.12.rc2.111.g96f7c73
