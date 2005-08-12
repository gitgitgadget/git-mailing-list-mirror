From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Update unpack-objects usage and documentation.
Date: Fri, 12 Aug 2005 02:41:36 -0700
Message-ID: <7v3bpf5w6n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 12 11:42:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3W2s-0005da-SQ
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 11:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVHLJlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 05:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVHLJli
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 05:41:38 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62661 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750952AbVHLJli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 05:41:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812094137.UCBV12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 05:41:37 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It long supported -q flag to suppress progress meter without
properly being documented.
---

 Documentation/git-unpack-objects.txt |    8 +++++++-
 unpack-objects.c                     |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

7d4cacb2e5ba94c45c3d5438c1703d0ea80d4ef1
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from
 
 SYNOPSIS
 --------
-'git-unpack-objects' < pack-file
+'git-unpack-objects' [-q] <pack-file
 
 
 DESCRIPTION
@@ -18,6 +18,12 @@ Reads a packed archive (.pack) from the 
 expands the objects contained in the pack into "one-file
 one-object" format in $GIT_OBJECT_DIRECTORY.
 
+OPTIONS
+-------
+-q::
+	The command usually shows percentage progress.  This
+	flag suppresses it.
+
 
 Author
 ------
diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -6,7 +6,7 @@
 #include <sys/time.h>
 
 static int dry_run, quiet;
-static const char unpack_usage[] = "git-unpack-objects < pack-file";
+static const char unpack_usage[] = "git-unpack-objects [-q] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
