From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 3/4] t7407: fix line endings for mingw build
Date: Thu,  3 Feb 2011 15:31:44 +0000
Message-ID: <1296747105-1663-4-git-send-email-patthoyts@users.sourceforge.net>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 16:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl1B2-00069T-NQ
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 16:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196Ab1BCPcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 10:32:25 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:40570 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932191Ab1BCPcY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 10:32:24 -0500
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pl1AP-0005Qg-Np; Thu, 03 Feb 2011 15:32:17 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <pat@patthoyts.tk>)
	id 1Pl1AC-0001Pv-Eq; Thu, 03 Feb 2011 15:32:04 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id D485E24EBA; Thu,  3 Feb 2011 15:32:03 +0000 (GMT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165976>

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t7407-submodule-foreach.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 1d67ef5..4c84764 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -254,6 +254,10 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 		) &&
 		git submodule status --cached --recursive -- nested1 > ../actual
 	) &&
+	if test_have_prereq MINGW
+	then
+		dos2unix actual
+	fi &&
 	test_cmp expect actual
 '
 
-- 
1.7.4.msysgit.0
