From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Create a man page for git-unbundle.
Date: Wed, 14 Feb 2007 09:10:29 -0500
Message-ID: <1171462229415-git-send-email-mdl123@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <11714622293142-git-send-email-mdl123@verizon.net>
 <11714622291709-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKqO-0002j3-3T
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbXBNOKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbXBNOKj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:10:39 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:29195 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbXBNOKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:10:37 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDG00A9MI1DEAA0@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 08:10:26 -0600 (CST)
In-reply-to: <11714622291709-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39647>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/git-unbundle.txt |   55 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-unbundle.txt

diff --git a/Documentation/git-unbundle.txt b/Documentation/git-unbundle.txt
new file mode 100644
index 0000000..8dbfccb
--- /dev/null
+++ b/Documentation/git-unbundle.txt
@@ -0,0 +1,55 @@
+git-unbundle(1)
+================
+
+NAME
+----
+git-unbundle - Unpackage objects and refs to update a disconnected repository
+
+
+SYNOPSIS
+--------
+'git-unbundle' [--bare ] [--force] [--shallow] file
+
+DESCRIPTION
+-----------
+
+Some workflows require that one or more branches of development on one machine
+be replicated on another machine, but the two machines cannot be directly
+connected so the gitlink:git-fetch[1] protocol cannot be used.  This command
+unpacks a bundle file created by gitlink:git-bundle[1] on another repository,
+adding the objects and updating references as defined by the donor repository.
+
+OPTIONS
+-------
+
+--bare::
+	Assume operation in a bare repository.
+
+--force::
+        Normally only fast-forward reference updates are performed. Specifying
+        this option allows non-fast forward updates.
+
+--shallow::
+        Normally, git-fsck is invoked on each reference to assure there are no
+        missing objects. This option bypasses that checking, allowing shallow
+        copies. Use with caution, many git operations are not supported on
+        shallow repositories.
+
+file::
+        Bundle file created by gitlink:git-bundle[1]. Default is bundle.zip.
+
+ERROR CHECKING
+--------------
+
+In addition to the checks mentioned under --force and --shallow above,
+git-unbundle uses gitlink:git-unpack-objects[1] to update objects, and
+gitlink:git-update-ref to update all references, and thus all the inherent
+safety checks provided by those functions are in force.
+
+Author
+------
+Written by Mark Levedahl <mdl123@verizon.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.0.rc3.24.g0c5e
