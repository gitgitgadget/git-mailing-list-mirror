From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/3] cg-mv doesn't work with bash 3.1.7 due to excessive quotes
Date: Thu, 02 Mar 2006 20:11:54 -0500
Message-ID: <20060303011154.14619.71590.stgit@dv.roinet.com>
X-From: git-owner@vger.kernel.org Fri Mar 03 02:12:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEyq5-0003AK-TR
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 02:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbWCCBMD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 20:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWCCBMA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 20:12:00 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:45535 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1752106AbWCCBL7
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 20:11:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FEypo-0005T9-8Z
	for git@vger.kernel.org; Thu, 02 Mar 2006 20:11:56 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FEypn-0003ny-39; Thu, 02 Mar 2006 20:11:55 -0500
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17128>



Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-mv |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-mv b/cg-mv
index c42853c..d5618ba 100755
--- a/cg-mv
+++ b/cg-mv
@@ -38,7 +38,7 @@ done
 # Strip trailing / which is something GIT does not bear well.
 ARGS2=()
 for arg in "${ARGS[@]}"; do
-	ARGS2["${#ARGS2[@]}"]="$_git_relpath${arg%/}"
+	ARGS2[${#ARGS2[@]}]="$_git_relpath${arg%/}"
 done
 
 git-mv $force "${ARGS2[@]}"
