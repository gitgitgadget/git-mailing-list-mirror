From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 1/2] Added a test for "submodule add" using a ../relative/path/to/the/submodule/repo
Date: Mon, 30 May 2011 17:51:19 -0400
Message-ID: <1306792280-12768-2-git-send-email-marcnarc@xiplink.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 00:05:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRAaz-0004E5-W5
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 00:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab1E3WFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 18:05:50 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:39545 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751950Ab1E3WFu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 18:05:50 -0400
X-Greylist: delayed 853 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2011 18:05:50 EDT
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p4ULpZN5011591;
	Mon, 30 May 2011 17:51:35 -0400
X-Mailer: git-send-email 1.7.5.3.686.g35b8
In-Reply-To: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174784>

---
 t/t7400-submodule-basic.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b2b26b7..bbcfc61 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -86,6 +86,13 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
+test_expect_failure 'submodule add with relative path to submodule repo' '
+	(
+		cd addtest &&
+		git submodule add ../.subrepo relative_subrepo_path
+	)
+'
+
 test_expect_success 'submodule add to .gitignored path fails' '
 	(
 		cd addtest-ignore &&
-- 
1.7.5.3.686.g35b8
