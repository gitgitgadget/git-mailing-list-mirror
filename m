From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] t3411: Fix ambiguous filename/tagname in setup
Date: Wed,  4 Feb 2009 20:42:36 +0100
Message-ID: <1233776556-9047-1-git-send-email-arjen@yaph.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUng0-0005mP-1L
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbZBDTnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbZBDTnW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:43:22 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4045 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbZBDTnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:43:21 -0500
Received: from localhost.localdomain (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id n14JgaZ7096915;
	Wed, 4 Feb 2009 20:42:37 +0100 (CET)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.1.354.gd9e51
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108417>

After commit 37e5c8f (Simplify t3411) the test setup fails on
case-insensitive filesystems because 'git reset' can't disambiguate the
filenames and tagnames.  An explicit '--' to 'git reset' fixes this.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 6533505..e544451 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup' '
 	test_commit A1 &&
 	test_commit B1 &&
 	test_commit C1 &&
-	git reset --hard B1 &&
+	git reset --hard B1 -- &&
 	test_commit D1 &&
 	test_merge E1 C1 &&
 	test_commit F1
-- 
1.6.1.2.467.g081e7
