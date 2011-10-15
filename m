From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/7] t1020: disable the pwd test on MinGW
Date: Sat, 15 Oct 2011 15:05:14 +0100
Message-ID: <1318687520-19522-2-git-send-email-patthoyts@users.sourceforge.net>
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
	id 1RF4ru-0003yR-C1
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab1JOOF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:29 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:64755 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587Ab1JOOF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:27 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140526.GEEO8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:26 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4re-00024L-2L; Sat, 15 Oct 2011 15:05:26 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id AA432207A7; Sat, 15 Oct 2011 15:05:25 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=QHdCzcSCHFAA:10 a=5uk79n7GP3YK1YLrpfAA:9 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183659>

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
