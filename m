From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] git-sh-setup: make require_clean_work_tree part of the interface
Date: Tue, 20 Dec 2011 12:09:04 +0100
Message-ID: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 12:09:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcxZO-0002vW-2S
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 12:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab1LTLJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 06:09:10 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:56092 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab1LTLJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 06:09:08 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 12:09:03 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 12:09:07 +0100
X-Mailer: git-send-email 1.7.8.484.gdad4270
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187508>

92c62a3 (Porcelain scripts: Rewrite cryptic "needs update" error
message, 2010-10-19) refactored git's own checking to a function in
git-sh-setup.  This is a very useful thing for script writers, so
document it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Noticed while helping ribasushi on IRC.

 Documentation/git-sh-setup.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index a2f346c..bbfefca 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -68,6 +68,15 @@ require_work_tree_exists::
 	cd_to_toplevel, which is impossible to do if there is no
 	working tree.
 
+require_clean_work_tree <action> [<hint>]::
+	checks if the working tree associated with the repository is
+	clean.  Otherwise it emits an error message of the form
+	`Cannot <action>: <reason>. <hint>`, and dies.  Example:
++
+----------------
+require_clean_work_tree rebase "Please commit or stash them."
+----------------
+
 get_author_ident_from_commit::
 	outputs code for use with eval to set the GIT_AUTHOR_NAME,
 	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
-- 
1.7.8.484.gdad4270
