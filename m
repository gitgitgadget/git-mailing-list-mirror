From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] t/Makefile: don't define TEST_RESULTS_DIRECTORY recursively
Date: Mon,  6 May 2013 13:35:46 +0100
Message-ID: <6bb37f45280373b96c2ae581db9bd87007dc0fb7.1367843730.git.john@keeping.me.uk>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 14:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZKeJ-000630-9j
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 14:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab3EFMgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 08:36:06 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:34841 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab3EFMgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 08:36:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 156936065A1;
	Mon,  6 May 2013 13:36:04 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ht9rnBukIbhO; Mon,  6 May 2013 13:36:03 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id E89AB6064E8;
	Mon,  6 May 2013 13:36:02 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D87D0161E2F4;
	Mon,  6 May 2013 13:36:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dnmgd5-doHyU; Mon,  6 May 2013 13:36:02 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9F507161E52B;
	Mon,  6 May 2013 13:35:52 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc0.149.g98a72f2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223446>

Commit 54bb901 (t/Makefile: fix result handling with
TEST_OUTPUT_DIRECTORY - 2013-04-26) incorrectly defined
TEST_RESULTS_DIRECTORY relative to itself, when it should be relative to
TEST_OUTPUT_DIRECTORY.  Fix this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 11de5da..ebb7371 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -16,7 +16,7 @@ DEFAULT_TEST_TARGET ?= test
 TEST_LINT ?= test-lint-duplicates test-lint-executable
 
 ifdef TEST_OUTPUT_DIRECTORY
-TEST_RESULTS_DIRECTORY = $(TEST_RESULTS_DIRECTORY)/test-results
+TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
 else
 TEST_RESULTS_DIRECTORY = test-results
 endif
-- 
1.8.3.rc0.149.g98a72f2.dirty
