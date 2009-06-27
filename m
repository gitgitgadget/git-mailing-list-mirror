From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] Test git archive --remote
Date: Sat, 27 Jun 2009 20:47:43 +0200
Message-ID: <dac606a8ee9b87339d1cf4b1bff23cea3c1b1c23.1246128025.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:48:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKcwz-0007YR-Uo
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 20:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbZF0Srp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 14:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbZF0Srp
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 14:47:45 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:26216 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbZF0Sro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 14:47:44 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 20:47:46 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 20:47:46 +0200
X-Mailer: git-send-email 1.6.3.3.437.ge636e
X-OriginalArrivalTime: 27 Jun 2009 18:47:46.0734 (UTC) FILETIME=[C34934E0:01C9F757]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122381>

Add a small test case for git archive --remote (and thus
git-upload-archive), which so far went untested.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This and the next patch are some fairly low-hanging fruit picked from
looking at 'make coverage'.


 t/t5000-tar-tree.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index abb41b0..5f84b18 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -94,6 +94,10 @@ test_expect_success 'git archive with --output' \
     'git archive --output=b4.tar HEAD &&
     test_cmp b.tar b4.tar'
 
+test_expect_success 'git archive --remote' \
+    'git archive --remote=. HEAD >b5.tar &&
+    test_cmp b.tar b5.tar'
+
 test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
-- 
1.6.3.3.423.ga0175
