From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] cogito: fix t9105-fetch-local.sh - use "git-fsck-objects
	--full"
Date: Tue, 20 Mar 2007 13:04:23 -0400
Message-ID: <20070320170423.9139.43914.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HThl9-0004Td-RO
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbXCTRE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965346AbXCTRE2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 13:04:28 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:49644 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965375AbXCTRE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 13:04:26 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HThj8-0006QU-CZ
	for git@vger.kernel.org; Tue, 20 Mar 2007 13:02:26 -0400
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HThl1-0002Nw-Ur; Tue, 20 Mar 2007 13:04:23 -0400
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42753>

git-fsck-objects without "--full" won't succeed in a repository that
uses "alternates".

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 t/t9105-fetch-local.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9105-fetch-local.sh b/t/t9105-fetch-local.sh
index 35e2778..184ae69 100755
--- a/t/t9105-fetch-local.sh
+++ b/t/t9105-fetch-local.sh
@@ -66,6 +66,6 @@ test_expect_success 'incremental update in repo2' \
 	'(cd repo2 && cg-update)'
 test_expect_success 'verifying incremental update' \
 	"(cmp repo1/.git/refs/heads/master repo2/.git/refs/heads/master &&
-	  cd repo2 && git-fsck-objects)"
+	  cd repo2 && git-fsck-objects --full)"
 
 test_done
