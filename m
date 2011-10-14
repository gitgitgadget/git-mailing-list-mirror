From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 3/8] t9001: do not fail only due to CR/LF issues
Date: Fri, 14 Oct 2011 23:53:30 +0100
Message-ID: <1318632815-29945-4-git-send-email-patthoyts@users.sourceforge.net>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 00:54:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REqdx-0000Zr-Ne
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 00:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab1JNWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 18:54:08 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:63167 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757038Ab1JNWyF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 18:54:05 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225404.PYZW21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:04 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqdg-0007Lh-4k; Fri, 14 Oct 2011 23:54:04 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 9301420A65; Fri, 14 Oct 2011 23:54:03 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=RbUhplWs4RcA:10 a=jyJh6hIQu4X6GKzYoPgA:9 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183619>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9001-send-email.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 579ddb7..7d75738 100755
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
