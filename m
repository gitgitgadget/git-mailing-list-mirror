From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] t6021: add a new test for git-merge-resolve
Date: Sat, 12 Jul 2008 20:42:10 +0200
Message-ID: <1215888130-3260-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHk6A-0004Gk-Gx
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 20:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbYGLSl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 14:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbYGLSl4
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 14:41:56 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38498 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYGLSlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 14:41:55 -0400
Received: from vmobile.example.net (dsl5401CADA.pool.t-online.hu [84.1.202.218])
	by yugo.frugalware.org (Postfix) with ESMTP id 9ACCB1DDC5B;
	Sat, 12 Jul 2008 20:41:53 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 069C51A9833; Sat, 12 Jul 2008 20:42:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88262>

It should fail properly if there are multiple merge bases, but there
were no test for this till now.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t6021-merge-criss-cross.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 0ab14a6..331b9b0 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -89,4 +89,8 @@ EOF
 
 test_expect_success 'Criss-cross merge result' 'cmp file file-expect'
 
+test_expect_success 'Criss-cross merge fails (-s resolve)' \
+'git reset --hard A^ &&
+test_must_fail git merge -s resolve -m "final merge" B'
+
 test_done
-- 
1.5.6.2.450.g8d367.dirty
