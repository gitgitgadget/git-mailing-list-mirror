From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Create documentation for git-unbundle.
Date: Thu, 15 Feb 2007 19:19:56 -0500
Message-ID: <1171585197833-git-send-email-mdl123@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
 <11715851973802-git-send-email-mdl123@verizon.net>
 <11715851973121-git-send-email-mdl123@verizon.net>
 <11715851973628-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqqG-00016g-I7
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbXBPAUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbXBPAUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:16 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:55137 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422844AbXBPAUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:13 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00MJM4XBEP31@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:20:00 -0600 (CST)
In-reply-to: <11715851973628-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39872>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/git-unbundle.txt |   48 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-unbundle.txt

diff --git a/Documentation/git-unbundle.txt b/Documentation/git-unbundle.txt
new file mode 100644
index 0000000..99713ce
--- /dev/null
+++ b/Documentation/git-unbundle.txt
@@ -0,0 +1,48 @@
+git-unbundle(1)
+===============
+
+NAME
+----
+git-unbundle - Unpackage objects and refs
+
+SYNOPSIS
+--------
+'git-unbundle' [--force] file
+
+DESCRIPTION
+-----------
+
+Some workflows require that one or more branches of development on one
+machine be replicated on another machine, but the two machines cannot
+be directly connected so the gitlink:git-fetch[1] protocol cannot be
+used.  This command unpacks a bundle file created by
+gitlink:git-bundle[1] on another repository, adding the objects and
+updating references as defined by the donor repository.
+
+OPTIONS
+-------
+
+--force::
+        Normally only fast-forward reference updates are performed.
+        Specifying this option allows non-fast forward updates.
+
+file::
+        Bundle file created by gitlink:git-bundle[1]. Default is
+        bundle.tar.
+
+ERROR CHECKING
+--------------
+
+In addition to the checks mentioned under --force above, the bundle
+includes a list of prerequisite commits needed. If any prerequisite is
+not present, git-unbundle stops. The repository is updated using
+gitlink:git-index-pack[1] and gitlink:git-update-ref[1] which assure
+that the pack is readable and that references are updated correctly.
+
+Author
+------
+Written by Mark Levedahl <mdl123@verizon.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.0.34.g6afaa
