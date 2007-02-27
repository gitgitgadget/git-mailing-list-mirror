From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Describe core.symlinks in the man pages.
Date: Tue, 27 Feb 2007 22:41:41 +0100
Message-ID: <11726125071378-git-send-email-johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <11726125033437-git-send-email-johannes.sixt@telecom.at> <1172612504272-git-send-email-johannes.sixt@telecom.at> <11726125052184-git-send-email-johannes.sixt@telecom.at> <11726125062739-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 22:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA59-0000yR-3e
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbXB0Vlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXB0Vlv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:51 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:46978 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXB0Vls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:48 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8A6F297694;
	Tue, 27 Feb 2007 22:41:47 +0100 (CET)
X-Mailer: git-send-email 1.5.0.19.gddff
In-Reply-To: <11726125062739-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40814>

---
 Documentation/config.txt           |    7 +++++++
 Documentation/git-update-index.txt |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9fec769..08d13ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -116,6 +116,13 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See gitlink:git-update-index[1]. True by default.
 
+core.symlinks::
+	If false, symbolic links are checked out as small plain files that
+	contain the link text. gitlink:git-update-index[1] and
+	gitlink:git-add[1] will not change the recorded type to regular
+	file. Useful on filesystems like FAT that do not support
+	symbolic links. True by default.
+
 core.gitProxy::
 	A "proxy command" to execute (as 'command host port') instead
 	of establishing direct connection to the remote server when
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index b161c8b..cd5e014 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -295,6 +295,11 @@ in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
 need to use `git-update-index --chmod=`.
 
+Quite similarly, if `core.symlinks` configuration variable is set
+to 'false' (see gitlink:git-config[1]), symbolic links are checked out
+as plain files, and this command does not modify a recorded file mode
+from symbolic link to regular file.
+
 The command looks at `core.ignorestat` configuration variable.  See
 'Using "assume unchanged" bit' section above.
 
-- 
1.5.0.19.gddff
