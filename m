From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/2] Fix git stash apply
Date: Tue, 21 Jul 2009 22:06:16 +0200
Message-ID: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:14:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLj7-0006et-DE
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbZGUUOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbZGUUOF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:14:05 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:60338 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbZGUUOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:14:05 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2009 16:14:04 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 1171D1303974;
	Tue, 21 Jul 2009 22:06:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njPJnBjv3hQP; Tue, 21 Jul 2009 22:06:18 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id F263C130396E;
	Tue, 21 Jul 2009 22:06:17 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id EC0B06800645; Tue, 21 Jul 2009 22:06:17 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123691>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 531c7c3..5b4b4e6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -219,7 +219,7 @@ apply_stash () {
 	then
 		export GIT_MERGE_VERBOSITY=0
 	fi
-	if git-merge-recursive $b_tree -- $c_tree $w_tree
+	if git merge-recursive $b_tree -- $c_tree $w_tree
 	then
 		# No conflict
 		if test -n "$unstashed_index_tree"
-- 
1.5.6.5
