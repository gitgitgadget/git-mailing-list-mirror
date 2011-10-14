From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/8] t1020: disable the pwd test on MinGW
Date: Fri, 14 Oct 2011 23:53:28 +0100
Message-ID: <1318632815-29945-2-git-send-email-patthoyts@users.sourceforge.net>
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
	id 1REqdx-0000Zr-7P
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 00:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab1JNWyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 18:54:05 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:63161 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752853Ab1JNWyE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 18:54:04 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225402.PYZE21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:02 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqde-0006Yw-7s; Fri, 14 Oct 2011 23:54:02 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id BA4A520A65; Fri, 14 Oct 2011 23:54:01 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=0YwelN13cTEA:10 a=5uk79n7GP3YK1YLrpfAA:9 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183620>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It fails both for line ending and for DOS path reasons.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1020-subdirectory.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 3b1b985..e23ac0e 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -118,7 +118,7 @@ test_expect_success 'alias expansion' '
 	)
 '
 
-test_expect_success '!alias expansion' '
+test_expect_success NOT_MINGW '!alias expansion' '
 	pwd >expect &&
 	(
 		git config alias.test !pwd &&
-- 
1.7.7.1.gbba15
