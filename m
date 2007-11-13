From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 1/2] t/t3404: fix test for a bogus todo file.
Date: Tue, 13 Nov 2007 13:14:41 -0800
Message-ID: <7vhcjpsv9a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 22:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is36b-000335-79
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbXKMVOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758651AbXKMVOv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:14:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50713 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758634AbXKMVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:14:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 806432F2;
	Tue, 13 Nov 2007 16:15:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E13095564;
	Tue, 13 Nov 2007 16:15:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64867>

The test wants to see if there are still remaining tasks, but checked
a wrong file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3404-rebase-interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1113904..f1039d1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -149,7 +149,7 @@ test_expect_success 'stop on conflicting pick' '
 	diff -u expect .git/.dotest-merge/patch &&
 	diff -u expect2 file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
-	test 0 = $(grep -v "^#" < .git/.dotest-merge/todo | wc -l)
+	test 0 = $(grep -v "^#" < .git/.dotest-merge/git-rebase-todo | wc -l)
 '
 
 test_expect_success 'abort' '
-- 
1.5.3.5.1728.g34b3e
