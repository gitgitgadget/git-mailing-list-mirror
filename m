From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH] Make usage documentation for git-add consistent.
Date: Sat, 25 Aug 2007 23:20:06 -0400
Message-ID: <20070826032006.GC7644@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 05:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP8fx-0006rK-Sp
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 05:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbXHZDUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 23:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbXHZDUU
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 23:20:20 -0400
Received: from ag-out-0708.google.com ([72.14.246.242]:62114 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbXHZDUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 23:20:09 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2222201aga
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 20:20:09 -0700 (PDT)
Received: by 10.100.153.17 with SMTP id a17mr640382ane.1188098409604;
        Sat, 25 Aug 2007 20:20:09 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id c1sm2576386ana.2007.08.25.20.20.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 20:20:08 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Sat, 25 Aug 2007 23:20:07 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56670>

The usage string for the executable was missing --refresh.  In
addition, the documentation referred to "file", but the usage string
referred to "filepattern".  Updated the documentation to
"filepattern", as git-add does handle patterns.

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 Documentation/git-add.txt |    6 ++++--
 builtin-add.c             |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 3383aca..e5efbc9 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,7 +7,9 @@ git-add - Add file contents to the index
 
 SYNOPSIS
 --------
-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <file>...
+[verse]
+'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh]
+          [--] <filepattern>...
 
 DESCRIPTION
 -----------
@@ -41,7 +43,7 @@ commit.
 
 OPTIONS
 -------
-<file>...::
+<filepattern>...::
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
diff --git a/builtin-add.c b/builtin-add.c
index 3dd4ded..b08e688 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -14,7 +14,7 @@
 #include "revision.h"
 
 static const char builtin_add_usage[] =
-"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern>...";
+"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <filepattern>...";
 
 static int take_worktree_changes;
 static const char *excludes_file;
-- 
1.5.3.rc6.23.g0058-dirty
