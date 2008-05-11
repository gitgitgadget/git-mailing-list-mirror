From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/4] t0050: Set core.ignorecase case to activate case insensitivity
Date: Sun, 11 May 2008 18:16:41 +0200
Message-ID: <1210522602-4724-3-git-send-email-prohaska@zib.de>
References: <1210522602-4724-1-git-send-email-prohaska@zib.de>
 <1210522602-4724-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEFY-0008VV-2j
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbYEKQQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYEKQQx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:16:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:62451 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbYEKQQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:16:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4BGGhqE004671;
	Sun, 11 May 2008 18:16:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4BGGgDW019981;
	Sun, 11 May 2008 18:16:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1210522602-4724-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81783>

Case insensitive file handling is only active when
core.ignorecase = true.  Hence, we need to set it to give the tests
in t0050 a chance to succeed.  Setting core.ignorecase explicitly
allows to test some aspects of case handling even on case sensitive file
systems.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystem.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 66d3647..399b45d 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -50,6 +50,7 @@ fi
 
 test_expect_success "setup case tests" '
 
+	git config core.ignorecase true &&
 	touch camelcase &&
 	git add camelcase &&
 	git commit -m "initial" &&
-- 
1.5.5.1.313.g9decb
