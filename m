From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/7] t9001: do not fail only due to CR/LF issues
Date: Sat, 15 Oct 2011 15:05:15 +0100
Message-ID: <1318687520-19522-3-git-send-email-patthoyts@users.sourceforge.net>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:05:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4ru-0003yR-S8
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab1JOOFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:30 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:6505 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412Ab1JOOF2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:28 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140527.WLMD21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:27 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4rf-00024h-16; Sat, 15 Oct 2011 15:05:27 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 8D91F207A7; Sat, 15 Oct 2011 15:05:26 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=5TjCeSe-6U4A:10 a=jyJh6hIQu4X6GKzYoPgA:9 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183654>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9001-send-email.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 87b4acc..8c12c65 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -23,6 +23,7 @@ test_expect_success $PREREQ \
       echo do
       echo "  echo \"!\$a!\""
       echo "done >commandline\$output"
+      test_have_prereq MINGW && echo "dos2unix commandline\$output"
       echo "cat > msgtxt\$output"
       ) >fake.sendmail &&
      chmod +x ./fake.sendmail &&
-- 
1.7.7.1.gbba15
