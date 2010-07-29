From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] checkout: add a test for creating a new branch with regexp as a starting point
Date: Fri, 30 Jul 2010 02:01:11 +0400
Message-ID: <20100729220111.GA28176@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 30 00:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebIx-0004wB-9x
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab0G2WKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 18:10:12 -0400
Received: from vint.altlinux.org ([194.107.17.35]:51680 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0G2WKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 18:10:11 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2010 18:10:11 EDT
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 6A1DD3F80005
	for <git@vger.kernel.org>; Thu, 29 Jul 2010 22:01:11 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 52B143F48760; Fri, 30 Jul 2010 02:01:11 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152202>

Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

This is just a regression test for the bug.

 t/t2018-checkout-new-branch-by-regexp.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100755 t/t2018-checkout-new-branch-by-regexp.sh

diff --git a/t/t2018-checkout-new-branch-by-regexp.sh b/t/t2018-checkout-new-branch-by-regexp.sh
new file mode 100755
index 0000000..78e54c5
--- /dev/null
+++ b/t/t2018-checkout-new-branch-by-regexp.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='checkout -b new_branch :/regexp'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo a > a &&
+	git add a &&
+	test_tick &&
+	git commit -m first &&
+	echo b > b &&
+	git add b &&
+	test_tick &&
+	git commit -m second
+'
+
+test_expect_success checkout '
+	git checkout -b new_branch :/first
+'
+
+test_done

-- 
ldv
