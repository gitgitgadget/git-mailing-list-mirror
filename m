From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH] Make usage documentation for git-blame and git-annotate
	consistent.
Date: Sat, 25 Aug 2007 23:19:51 -0400
Message-ID: <20070826031951.GB7644@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 05:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP8fx-0006rK-Bu
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 05:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbXHZDUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 23:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbXHZDUS
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 23:20:18 -0400
Received: from ag-out-0708.google.com ([72.14.246.242]:62114 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXHZDTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 23:19:54 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2222201aga
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 20:19:54 -0700 (PDT)
Received: by 10.100.91.6 with SMTP id o6mr640321anb.1188098394090;
        Sat, 25 Aug 2007 20:19:54 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id b23sm2573026ana.2007.08.25.20.19.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 20:19:53 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Sat, 25 Aug 2007 23:19:52 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56669>

Added git-annotate usage in the synopsis.  The extended information in
the git-blame usage was removed, as no other builtin does this and it
just repeats what is in the full documentation.

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 Documentation/git-annotate.txt |    5 ++++-
 Documentation/git-blame.txt    |    6 +++---
 builtin-blame.c                |   17 +----------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 02dc474..cd5faab 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -7,7 +7,10 @@ git-annotate - Annotate file lines with commit info
 
 SYNOPSIS
 --------
-git-annotate [options] file [revision]
+[verse]
+'git-annotate' [-b] [-l] [--root] [-t] [-p] [--incremental] [-L n,m]
+               [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
+               [<rev> | --contents <file>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 66f1203..e8ddfea 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -8,9 +8,9 @@ git-blame - Show what revision and author last modified each line of a file
 SYNOPSIS
 --------
 [verse]
-'git-blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
-            [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
-            [<rev> | --contents <file>] [--] <file>
+'git-blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w]
+            [--incremental] [-L n,m] [-S <revs-file>] [-M] [-C] [-C]
+            [--since=<date>] [<rev> | --contents <file>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/builtin-blame.c b/builtin-blame.c
index 0519339..222eba5 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -20,22 +20,7 @@
 #include "mailmap.h"
 
 static char blame_usage[] =
-"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
-"  -c                  Use the same output mode as git-annotate (Default: off)\n"
-"  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
-"  -l                  Show long commit SHA1 (Default: off)\n"
-"  --root              Do not treat root commits as boundaries (Default: off)\n"
-"  -t                  Show raw timestamp (Default: off)\n"
-"  -f, --show-name     Show original filename (Default: auto)\n"
-"  -n, --show-number   Show original linenumber (Default: off)\n"
-"  -s                  Suppress author name and timestamp (Default: off)\n"
-"  -p, --porcelain     Show in a format designed for machine consumption\n"
-"  -w                  Ignore whitespace differences\n"
-"  -L n,m              Process only line range n,m, counting from 1\n"
-"  -M, -C              Find line movements within and across files\n"
-"  --incremental       Show blame entries as we find them, incrementally\n"
-"  --contents file     Use <file>'s contents as the final image\n"
-"  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
+"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--since=<date>] [<rev> | --contents <file>] [--] <file>";
 
 static int longest_file;
 static int longest_author;
-- 
1.5.3.rc6.23.g0058-dirty
