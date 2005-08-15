From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add documentation for git repack and git-prune-packed.
Date: Mon, 15 Aug 2005 04:16:23 -0400
Message-ID: <11240937833130-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 10:16:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4a8x-00081y-QD
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVHOIQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVHOIQZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:16:25 -0400
Received: from mail.autoweb.net ([198.172.237.26]:2775 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932237AbVHOIQY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 04:16:24 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4a8t-00085T-UN; Mon, 15 Aug 2005 04:16:24 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4a8t-0004vl-00; Mon, 15 Aug 2005 04:16:23 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1E4a8t-0006z3-75; Mon, 15 Aug 2005 04:16:23 -0400
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/git-pack-objects.txt  |    4 +++
 Documentation/git-prune-packed.txt  |   42 +++++++++++++++++++++++++++++++++++
 Documentation/git-repack-script.txt |   41 ++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-prune-packed.txt
 create mode 100644 Documentation/git-repack-script.txt

a5842d0ec3abe8316d7a965f43299ce4852dfa04
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -74,6 +74,10 @@ Documentation
 -------------
 Documentation by Junio C Hamano
 
+See-Also
+--------
+git-repack-script(1) git-prune-packed(1)
+
 GIT
 ---
 Part of the link:git.html[git] suite
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-prune-packed.txt
@@ -0,0 +1,42 @@
+git-prune-packed(1)
+=====================
+v0.1, August 2005
+
+NAME
+----
+git-prune-packed - Program used to remove the extra object files that are now
+residing in a pack file.
+
+
+SYNOPSIS
+--------
+'git-prune-packed'
+
+DESCRIPTION
+-----------
+This program search the GIT_OBJECT_DIR for all objects that currently exist in
+a pack file as well as the independent object directories.
+
+All such extra objects are removed.
+
+A pack is a collection of objects, individually compressed, with delta
+compression applied, stored in a single file, with an associated index file.
+
+Packs are used to reduce the load on mirror systems, backup engines, disk storage, etc.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Ryan Anderson <ryan@michonline.com>
+
+See-Also
+--------
+git-pack-objects(1) git-repack-script(1)
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-repack-script.txt b/Documentation/git-repack-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-repack-script.txt
@@ -0,0 +1,41 @@
+
+git-repack-script(1)
+=====================
+v0.1, August 2005
+
+NAME
+----
+git-repack-script - Script used to pack a repository from a collection of
+objects into pack files.
+
+
+SYNOPSIS
+--------
+'git-repack-script'
+
+DESCRIPTION
+-----------
+This script is used to combine all objects that do not currently reside in a
+"pack", into a pack.
+
+A pack is a collection of objects, individually compressed, with delta
+compression applied, stored in a single file, with an associated index file.
+
+Packs are used to reduce the load on mirror systems, backup engines, disk storage, etc.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Ryan Anderson <ryan@michonline.com>
+
+See-Also
+--------
+git-pack-objects(1) git-prune-packed(1)
+
+GIT
+---
+Part of the link:git.html[git] suite
+
