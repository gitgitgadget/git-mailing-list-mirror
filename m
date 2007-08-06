From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/5] user-manual: mention git stash
Date: Mon,  6 Aug 2007 00:33:59 -0400
Message-ID: <18328.9634449922$1186374869@news.gmane.org>
References: 20070805222527.GB12168@fieldses.org
 <11863748422001-git-send-email->
 <1186374842108-git-send-email->
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 06 06:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHuIT-00083v-Lz
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXHFEeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXHFEeH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:34:07 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38236 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbXHFEeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:34:04 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHuI6-0001mM-Pd; Mon, 06 Aug 2007 00:34:02 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <1186374842108-git-send-email->
Message-Id: <7a7cc594ca294a58b6d7ae5aa50a65378538e875.1186373089.git.bfields@pig.linuxdev.us.dell.com>
In-Reply-To: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
References: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55108>

From: Junio C Hamano <gitster@pobox.com>

Mention the git-stash command as a way to temporarily set aside work in
progress.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c0820e9..9efe85c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1484,6 +1484,38 @@ $ git show HEAD^:path/to/file
 
 which will display the given version of the file.
 
+[[interrupted-work]]
+Temporarily setting aside work in progress
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+While you are in the middle of working on something complicated, you
+find an unrelated but obvious and trivial bug.  You would like to fix it
+before continuing.  You can use gitlink:git-stash[1] to save the current
+state of your work, and after fixing the bug (or, optionally after doing
+so on a different branch and then coming back), unstash the
+work-in-progress changes.
+
+------------------------------------------------
+$ git stash "work in progress for foo feature"
+------------------------------------------------
+
+This command will save your changes away to the `stash`, and
+reset your working tree and the index to match the tip of your
+current branch.  Then you can make your fix as usual.
+
+------------------------------------------------
+... edit and test ...
+$ git commit -a -m "blorpl: typofix"
+------------------------------------------------
+
+After that, you can go back to what you were working on with
+`git stash apply`:
+
+------------------------------------------------
+$ git stash apply
+------------------------------------------------
+
+
 [[ensuring-good-performance]]
 Ensuring good performance
 -------------------------
-- 
1.5.3.GIT
