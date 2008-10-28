From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Tue, 28 Oct 2008 16:39:05 -0700
Message-ID: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
Cc: David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 29 00:40:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuyBC-0001d9-1V
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 00:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbYJ1Xjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYJ1Xjl
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 19:39:41 -0400
Received: from smtp-out.google.com ([216.239.45.13]:3199 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYJ1Xjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 19:39:40 -0400
Received: from zps19.corp.google.com (zps19.corp.google.com [172.25.146.19])
	by smtp-out.google.com with ESMTP id m9SNdB2D010036;
	Tue, 28 Oct 2008 16:39:11 -0700
Received: from localhost.localdomain (dhcp-172-19-79-244.mtv.corp.google.com [172.19.79.244])
	by zps19.corp.google.com with ESMTP id m9SNdAwj032346;
	Tue, 28 Oct 2008 16:39:10 -0700
X-Mailer: git-send-email 1.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99332>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
  This isn't a particularly serious patch, but is very relevant to our
  current discussion at GitTogether '08.

 .gitignore    |    1 +
 Makefile      |    1 +
 git-staged.sh |    8 ++++++++
 3 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100755 git-staged.sh

diff --git a/.gitignore b/.gitignore
index bbaf9de..9353d19 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
+git-staged
 git-stash
 git-status
 git-stripspace
diff --git a/Makefile b/Makefile
index d6f3695..1b23e53 100644
--- a/Makefile
+++ b/Makefile
@@ -262,6 +262,7 @@ SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
+SCRIPT_SH += git-staged.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/git-staged.sh b/git-staged.sh
new file mode 100755
index 0000000..bfd36e7
--- /dev/null
+++ b/git-staged.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+USAGE=''
+SUBDIRECTORY_OK='Yes'
+OPTIONS_SPEC=
+. git-sh-setup
+
+git diff --cached
-- 
1.6.0
