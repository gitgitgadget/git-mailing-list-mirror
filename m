From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Fix problematic ']'
Date: Mon, 23 Jul 2007 22:36:21 +0200
Message-ID: <200707232236.21389.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4dy-00065y-FQ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934141AbXGWUg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbXGWUg1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:36:27 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:39759 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934141AbXGWUg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:36:26 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id D3F43BEE45;
	Mon, 23 Jul 2007 22:36:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9BC7057651;
	Mon, 23 Jul 2007 22:36:21 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53473>

Not all shells grok a closing ']' of the shell '[' command without
surrounding space.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

I didn't go the long way to change all `[ ... ]` into `test ...`

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 579a45e..e0d1326 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -385,7 +385,7 @@ do
 
 		require_clean_work_tree
 
-		if [ ! -z "$2"]
+		if [ ! -z "$2" ]
 		then
 			git show-ref --verify --quiet "refs/heads/$2" ||
 				die "Invalid branchname: $2"
-- 
1.5.3.rc0
