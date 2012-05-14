From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2] git-svn: clarify the referent of dcommit's optional argument
Date: Mon, 14 May 2012 16:53:25 +1000
Message-ID: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, normalperson@yhbt.net, trast@student.ethz.ch,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 08:53:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STpA9-0003dj-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 08:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab2ENGxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 02:53:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41187 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2ENGxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 02:53:40 -0400
Received: by dady13 with SMTP id y13so5523988dad.19
        for <git@vger.kernel.org>; Sun, 13 May 2012 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5jjOzBRFb8FKjn0VgVnzCckTNDFsJ+a4dKhIGM2RqPo=;
        b=B9KWWt9OVbV2WqVgy/A5SepqZAklBzR02xkqIQadgqzCkz8DjdCSjyA4rTZ4SXUrGC
         F1eBX3xV0jgWN/jbrJY2YUijkvvzfOACqwvK+9B68wTRqwIJNTfCBa9QTwquSWqcGmG7
         e1I1SEC9I5hNtVYQHjsOggDTynQbgHxrKpG4M4imf+Vv47L7RXXZMV7hdDeDEED8++Cl
         ySTT50/1Q5+cH4uP8KbwHEoCXhJuF0jzhoQmY8/4nT7+CD7/LnXt5BOo/t0raB5qbrCe
         17B2S5O+ChLzZ4zO+n4r/jz4OzGGI03DXunfrJiVM3Ci5bM7zcE9O6draBHVjOeNldgg
         Olyg==
Received: by 10.68.218.194 with SMTP id pi2mr9044471pbc.100.1336978420245;
        Sun, 13 May 2012 23:53:40 -0700 (PDT)
Received: from ubuntu.au.ibm.com (124-168-135-11.dyn.iinet.net.au. [124.168.135.11])
        by mx.google.com with ESMTPS id nv2sm21373385pbb.6.2012.05.13.23.53.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 May 2012 23:53:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.514.ge33c7ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197764>

The documentation of the dcommit subcommand is reworded to clarify that
the optional argument refers to a git branch, not an SVN branch.

The discussion of the optional argument is put into its own paragraph
as is the guidance about using 'dcommit' in preference to 'set-tree'.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-svn.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee785..27c4840 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -189,18 +189,20 @@ and have no uncommitted changes.
 	last fetched commit from the upstream SVN.
 
 'dcommit'::
-	Commit each diff from a specified head directly to the SVN
+	Commit each diff from the current branch directly to the SVN
 	repository, and then rebase or reset (depending on whether or
 	not there is a diff between SVN and head).  This will create
 	a revision in SVN for each commit in git.
 	It is recommended that you run 'git svn' fetch and rebase (not
 	pull or merge) your commits against the latest changes in the
 	SVN repository.
-	An optional revision or branch argument may be specified, and
-	causes 'git svn' to do all work on that revision/branch
-	instead of HEAD.
-	This is advantageous over 'set-tree' (below) because it produces
-	cleaner, more linear history.
++
+When an optional git branch name (or a git commit object name)
+is specified as an argument, the subcommand works on the specified
+branch, not on the current branch.
++
+Use of 'dcommit' is preferred to 'set-tree' (below) because it produces
+cleaner, more linear history.
 +
 --no-rebase;;
 	After committing, do not rebase or reset.
-- 
1.7.10.1.514.ge33c7ea
