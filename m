From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup in git
Date: Thu,  9 Apr 2009 17:45:10 +0200
Message-ID: <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl>
References: <20090409153033.GN23604@spearce.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 17:47:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwSy-0001r7-47
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935577AbZDIPpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935639AbZDIPpU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:45:20 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:54496 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935630AbZDIPpO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 11:45:14 -0400
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id E8E3E58BD88;
	Thu,  9 Apr 2009 17:45:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <20090409153033.GN23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116176>

In several places merge.keepBackup is used i.s.o.
mergetool.keepBackup. This patch makes it all
consistent for git

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 contrib/difftool/git-difftool.txt |    2 +-
 git-mergetool.sh                  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 6e2610c..ca7482a 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -66,7 +66,7 @@ merge.tool::
 +
 See the `--tool=<tool>` option above for more details.
 
-merge.keepBackup::
+mergetool.keepBackup::
 	The original, unedited file content can be saved to a file with
 	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..1455bd9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -430,7 +430,7 @@ else
 
     init_merge_tool_path "$merge_tool"
 
-    merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+    merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
     merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
     if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
-- 
1.6.0.6
