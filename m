From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/6] lib-rebase.sh: Document what set_fake_editor() does
Date: Tue, 27 Jan 2009 18:46:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271846340.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs2m-0008PP-TJ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbZA0Rqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbZA0Rqr
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:46:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:54866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753934AbZA0Rqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:46:47 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:46:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 27 Jan 2009 18:46:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+34yhWM123f5r600YZ7EUIbPO/aShd84B3efQ4zM
	zAU++x+mOhvrKZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107368>

rnyn
Make it easy for other authors to use rebase tests' fake-editor.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Separated from 1/6 to make the code move more obvious.

 t/lib-rebase.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 8c8caab..cda7778 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -1,5 +1,17 @@
 #!/bin/sh
 
+# After setting the fake editor with this function, you can
+#
+# - override the commit message with $FAKE_COMMIT_MESSAGE,
+# - amend the commit message with $FAKE_COMMIT_AMEND
+# - check that non-commit messages have a certain line count with $EXPECT_COUNT
+# - rewrite a rebase -i script with $FAKE_LINES in the form
+#
+#	"[<lineno1>] [<lineno2>]..."
+#
+#   If a line number is prefixed with "squash" or "edit", the respective line's
+#   command will be replaced with the specified one.
+
 set_fake_editor () {
 	echo "#!${SHELL_PATH-/bin_sh}" >fake-editor.sh
 	cat >> fake-editor.sh <<\EOF
-- 
1.6.1.482.g7d54be
