From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 2/2] config documentation: some configs are auto-set by git-init
Date: Sun, 22 Nov 2009 19:07:30 -0700
Message-ID: <1258942050-11423-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1258942050-11423-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1258942050-11423-2-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 23 03:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCOLV-0008Os-B3
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 03:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbZKWCHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 21:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755664AbZKWCHn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 21:07:43 -0500
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:33727 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065AbZKWCHn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 21:07:43 -0500
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id 8RVP1d00417UAYkA7S7qWU; Mon, 23 Nov 2009 02:07:50 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id 8S7p1d0035FCJCg8ZS7poD; Mon, 23 Nov 2009 02:07:50 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 4237789114;
	Sun, 22 Nov 2009 19:07:48 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1258942050-11423-2-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133473>

Add documentation for core.ignorecase, and mention git-init
in core.filemode and core.symlinks.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Documentation/config.txt |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 78ee906..b2ee139 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -131,7 +131,11 @@ advice.*::
 core.fileMode::
 	If false, the executable bit differences between the index and
 	the working copy are ignored; useful on broken filesystems like FAT.
-	See linkgit:git-update-index[1]. True by default.
+	See linkgit:git-update-index[1].
++
+The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.fileMode false if appropriate when the
+repository is created.
 
 core.ignoreCygwinFSTricks::
 	This option is only used by Cygwin implementation of Git. If false,
@@ -144,6 +148,18 @@ core.ignoreCygwinFSTricks::
 	is true, in which case ignoreCygwinFSTricks is ignored as Cygwin's
 	POSIX emulation is required to support core.filemode.
 
+core.ignorecase::
+	If true, this option enables various workarounds to enable
+	git to work better on filesystems that are not case sensitive,
+	like FAT. For example, if a directory listing finds
+	"makefile" when git expects "Makefile", git will assume
+	it is really the same file, and continue to remember it as
+	"Makefile".
++
+The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.ignorecase true if appropriate when the repository
+is created.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working copy are ignored; useful when the inode change time
@@ -223,7 +239,11 @@ core.symlinks::
 	contain the link text. linkgit:git-update-index[1] and
 	linkgit:git-add[1] will not change the recorded type to regular
 	file. Useful on filesystems like FAT that do not support
-	symbolic links. True by default.
+	symbolic links.
++
+The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.symlinks false if appropriate when the repository
+is created.
 
 core.gitProxy::
 	A "proxy command" to execute (as 'command host port') instead
-- 
1.6.4.GIT
