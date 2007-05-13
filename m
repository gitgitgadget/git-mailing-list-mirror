From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: Split description of pretty formats of commit log
Date: Mon, 14 May 2007 01:25:45 +0200
Message-ID: <200705140125.45711.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 01:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNZ2-0002hy-3T
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131AbXEMXcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758456AbXEMXcn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:32:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131AbXEMXcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:32:41 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1226383uga
        for <git@vger.kernel.org>; Sun, 13 May 2007 16:32:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OqQaG7c6QIdSe3qFMOEmVzO+GDEVLvt9Ea7Awyzcz3MSCodmclPMsUAdqP/52ct2bn9fzgmEGRj+QqjQY8OUpZx0S5q9GWihlw0Z49qU2WvJC1sZsb+QQ9F/l1SpXbuIslpr5n+KsjHK0imwHCba4iU8zY9IFpq9GCymkz4L3k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mH6PHRBbsqf2PJaq/f8iWa32lc8wWfbNvcp9yDumAcB7vp1tXd4j4hJ5kh2r4Ir4j9WKXuawfbb0X27UiPA75CCaXjdf+rfqNN2qKFCerR3sAWYOph1yq9gBqeCFGSqUJcd+vwTMlZt4keWrOPXSh+hu/w41tabHijmTik6jUfo=
Received: by 10.66.243.4 with SMTP id q4mr4723430ugh.1179099160845;
        Sun, 13 May 2007 16:32:40 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e33sm12678053ugd.2007.05.13.16.32.38;
        Sun, 13 May 2007 16:32:39 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47192>

Split description of pretty formats into list of pretty options
(--pretty and --encoding) in new file Documentation/pretty-options.txt
and description of formats itself as a separate "PRETTY FORMATS"
section in pretty-formats.txt

While at it correct formatting a bit, to be better laid out in the
resulting manpages: git-rev-list(1), git-show(1), git-log(1) and
git-diff-tree(1).  Those manpages now include pretty options in the
same place as it was before, and description of formats just after
all options.

Inspired by the split into two filesdocumentation for merge strategies:
Documentation/merge-options.txt and Documentation/merge-strategies.txt

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I was fed up with the fact that description of pretty formats takes
so much place for some manpages directly in the middle of other options,
making manpage unnecessary hard to read. So here there are the patch
for this.

Note: I have tested only manpage output; HTML output style might be
a bit broken, but I think it was broken before.

Most of the patch Documentation/pretty-formats.txt is just
reformatting.

 Documentation/git-diff-tree.txt  |    5 ++-
 Documentation/git-log.txt        |    5 ++-
 Documentation/git-rev-list.txt   |    6 +++-
 Documentation/git-show.txt       |    3 ++
 Documentation/pretty-formats.txt |   70 +++++++++++++++++--------------------
 Documentation/pretty-options.txt |   14 +++++++
 6 files changed, 62 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/pretty-options.txt

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 5d6e9dc..6e660e2 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -73,7 +73,7 @@ separated with a single space are given.
 	This flag causes "git-diff-tree --stdin" to also show
 	the commit message before the differences.
 
-include::pretty-formats.txt[]
+include::pretty-options.txt[]
 
 --no-commit-id::
 	git-diff-tree outputs a line with the commit ID when
@@ -104,6 +104,9 @@ include::pretty-formats.txt[]
 	if the diff itself is empty.
 
 
+include::pretty-formats.txt[]
+
+
 Limiting Output
 ---------------
 If you're only interested in differences in a subset of files, for
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index dd06527..0f353f6 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -25,7 +25,7 @@ This manual page describes only the most frequently used options.
 OPTIONS
 -------
 
-include::pretty-formats.txt[]
+include::pretty-options.txt[]
 
 -<n>::
 	Limits the number of commits to show.
@@ -58,6 +58,9 @@ include::pretty-formats.txt[]
 	Show only commits that affect the specified paths.
 
 
+include::pretty-formats.txt[]
+
+
 Examples
 --------
 git log --no-merges::
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 1b12b4f..ab90a22 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -87,7 +87,7 @@ Using these options, gitlink:git-rev-list[1] will act similar to the
 more specialized family of commit log tools: gitlink:git-log[1],
 gitlink:git-show[1], and gitlink:git-whatchanged[1]
 
-include::pretty-formats.txt[]
+include::pretty-options.txt[]
 
 --relative-date::
 
@@ -367,6 +367,10 @@ These options are mostly targeted for packing of git repositories.
 	Only useful with '--objects'; print the object IDs that are not
 	in packs.
 
+
+include::pretty-formats.txt[]
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 5a219ab..34c5caf 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -38,6 +38,9 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
+include::pretty-options.txt[]
+
+
 include::pretty-formats.txt[]
 
 
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d7ffc21..99fbd6b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -1,31 +1,32 @@
---pretty[='<format>']::
-
-        Pretty-prints the details of a commit.  `--pretty`
-	without an explicit `=<format>` defaults to 'medium'.
-	If the commit is a merge, and if the pretty-format
-        is not 'oneline', 'email' or 'raw', an additional line is
-        inserted before the 'Author:' line.  This line begins with
-        "Merge: " and the sha1s of ancestral commits are printed,
-        separated by spaces.  Note that the listed commits may not
-        necessarily be the list of the *direct* parent commits if you
-        have limited your view of history: for example, if you are
-        only interested in changes related to a certain directory or
-        file.  Here are some additional details for each format:
-
-        * 'oneline'
+PRETTY FORMATS
+--------------
+
+If the commit is a merge, and if the pretty-format
+is not 'oneline', 'email' or 'raw', an additional line is
+inserted before the 'Author:' line.  This line begins with
+"Merge: " and the sha1s of ancestral commits are printed,
+separated by spaces.  Note that the listed commits may not
+necessarily be the list of the *direct* parent commits if you
+have limited your view of history: for example, if you are
+only interested in changes related to a certain directory or
+file.
+
+Here are some additional details for each format:
+
+* 'oneline'
 
 	  <sha1> <title line>
-+
-This is designed to be as compact as possible.
 
-        * 'short'
+	  This is designed to be as compact as possible.
+
+* 'short'
 
 	  commit <sha1>
 	  Author: <author>
 
 	      <title line>
 
-        * 'medium'
+* 'medium'
 
 	  commit <sha1>
 	  Author: <author>
@@ -35,7 +36,7 @@ This is designed to be as compact as possible.
 
 	      <full commit message>
 
-        * 'full'
+* 'full'
 
 	  commit <sha1>
 	  Author: <author>
@@ -45,7 +46,7 @@ This is designed to be as compact as possible.
 
 	      <full commit message>
 
-        * 'fuller'
+* 'fuller'
 
 	  commit <sha1>
 	  Author: <author>
@@ -57,18 +58,16 @@ This is designed to be as compact as possible.
 
 	       <full commit message>
 
-
-        * 'email'
+* 'email'
 
 	  From <sha1> <date>
 	  From: <author>
 	  Date: <date & time>
 	  Subject: [PATCH] <title line>
 
-	  full commit message>
-
+	  <full commit message>
 
-	* 'raw'
+* 'raw'
 +
 The 'raw' format shows the entire commit exactly as
 stored in the commit object.  Notably, the SHA1s are
@@ -77,19 +76,22 @@ displayed in full, regardless of whether --abbrev or
 true parent commits, without taking grafts nor history
 simplification into account.
 
-	* 'format:'
+* 'format:'
 +
 The 'format:' format allows you to specify which information
 you want to show. It works a little bit like printf format,
 with the notable exception that you get a newline with '%n'
 instead of '\n'.
-
-E.g, 'format:"The author of %h was %an, %ar%nThe title was >>%s<<"'
++
+E.g, 'format:"The author of %h was %an, %ar%nThe title was >>%s<<%n"'
 would show something like this:
-
++
+-------
 The author of fe6e0ee was Junio C Hamano, 23 hours ago
 The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 
+--------
++
 The placeholders are:
 
 - '%H': commit hash
@@ -120,11 +122,3 @@ The placeholders are:
 - '%m': left, right or boundary mark
 - '%n': newline
 
-
---encoding[=<encoding>]::
-	The commit objects record the encoding used for the log message
-	in their encoding header; this option can be used to tell the
-	command to re-code the commit log message in the encoding
-	preferred by the user.  For non plumbing commands this
-	defaults to UTF-8.
-
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
new file mode 100644
index 0000000..7d515be
--- /dev/null
+++ b/Documentation/pretty-options.txt
@@ -0,0 +1,14 @@
+--pretty[='<format>']::
+
+	Pretty print the contents of the commit logs in a given format,
+	where '<format>' can be one of 'oneline', 'short', 'medium',
+	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
+	When left out the format default to 'medium'.
+
+--encoding[=<encoding>]::
+	The commit objects record the encoding used for the log message
+	in their encoding header; this option can be used to tell the
+	command to re-code the commit log message in the encoding
+	preferred by the user.  For non plumbing commands this
+	defaults to UTF-8.
+
-- 
1.5.1.4
