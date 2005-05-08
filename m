From: David Greaves <david@dgreaves.com>
Subject: [PATCH 1/2] core-git documentation update
Date: Sun, 08 May 2005 18:22:45 +0100
Message-ID: <427E4AE5.3090700@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050109070505050508060405"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 19:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpOT-0006VM-Ia
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVEHRXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVEHRXj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:23:39 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:35720 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262899AbVEHRW6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:22:58 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id B67BDE6A8B; Sun,  8 May 2005 18:22:00 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12653-15; Sun,  8 May 2005 18:22:00 +0100 (BST)
Received: from oak.dgreaves.com (modem-2142.leopard.dialup.pol.co.uk [217.135.152.94])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C1D89E6D4F; Sun,  8 May 2005 18:21:55 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DUpUM-0005jm-Bk; Sun, 08 May 2005 18:22:46 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------050109070505050508060405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sorts core-git.txt into alphabetical order

Signed-off-by: David Greaves <david@dgreaves.com>
---


--------------050109070505050508060405
Content-Type: text/x-patch;
 name="core-git_sort.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="core-git_sort.patch"

--- a/Documentation/core-git.txt
+++ b/Documentation/core-git.txt
@@ -161,16 +161,16 @@ filenames. Just so that you wouldn't hav
 problems (not possible in the above example, but get used to it in
 scripting!).
 
-The prefix ability basically makes it trivial to use git-checkout-cache as
-a "git-export as tree" function. Just read the desired tree into the
-index, and do a
+The prefix ability basically makes it trivial to use
+git-checkout-cache as an "export as tree" function. Just read the
+desired tree into the index, and do a
   
         git-checkout-cache --prefix=git-export-dir/ -a
   
-and git-checkout-cache will "git-export" the cache into the specified
+and git-checkout-cache will "export" the cache into the specified
 directory.
   
-NOTE! The final "/" is important. The git-exported name is literally just
+NOTE! The final "/" is important. The exported name is literally just
 prefixed with the specified string, so you can also do something like
   
         git-checkout-cache --prefix=.merged- Makefile
@@ -351,6 +351,33 @@ special all-zero sha1.
 
 
 ################################################################
+git-diff-files
+	git-diff-files [-p] [-q] [-r] [-z] [<pattern>...]
+
+Compares the files in the working tree and the cache.  When paths
+are specified, compares only those named paths.  Otherwise all
+entries in the cache are compared.  The output format is the
+same as git-diff-cache and git-diff-tree.
+
+-p
+	generate patch (see section on generating patches).
+
+-q
+	Remain silent even on nonexisting files
+
+-r
+	This flag does not mean anything.  It is there only to match
+	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
+	at all the subdirectories.
+
+
+Output format:
+
+See "Output format from git-diff-cache, git-diff-tree and git-diff-files"
+section.
+
+
+################################################################
 git-diff-tree
 	git-diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]*
 
@@ -477,6 +504,14 @@ See also the section on generating patch
 
 
 ################################################################
+git-export
+	git-export top [base]
+
+Exports each commit and diff against each of its parents, between
+top and base.  If base is not specified it exports everything.
+
+
+################################################################
 git-fsck-cache
 	git-fsck-cache [--tags] [--root] [[--unreachable] [--cache] <object>*]
 
@@ -572,11 +607,20 @@ GIT_INDEX_FILE
 
 
 ################################################################
-git-export
-	git-export top [base]
+git-http-pull
 
-Exports each commit and diff against each of its parents, between
-top and base.  If base is not specified it exports everything.
+	git-http-pull [-c] [-t] [-a] [-v] commit-id url
+
+Downloads a remote GIT repository via HTTP protocol.
+
+-c
+	Get the commit objects.
+-t
+	Get trees associated with the commit objects.
+-a
+	Get all the objects.
+-v
+	Report what is downloaded.
 
 
 ################################################################
@@ -594,11 +638,11 @@ git-init-db won't hurt an existing repos
 
 
 ################################################################
-git-http-pull
+git-local-pull
 
-	git-http-pull [-c] [-t] [-a] [-v] commit-id url
+	git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path
 
-Downloads a remote GIT repository via HTTP protocol.
+Downloads another GIT repository on a local system.
 
 -c
 	Get the commit objects.
@@ -609,22 +653,80 @@ Downloads a remote GIT repository via HT
 -v
 	Report what is downloaded.
 
-
 ################################################################
-git-local-pull
+git-ls-files
+	git-ls-files [-z] [-t]
+		(--[cached|deleted|others|ignored|stage|unmerged])*
+		(-[c|d|o|i|s|u])*
+		[-x <pattern>|--exclude=<pattern>]
+		[-X <file>|--exclude-from=<file>]
 
-	git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path
+This merges the file listing in the directory cache index with the
+actual working directory list, and shows different combinations of the
+two.
 
-Downloads another GIT repository on a local system.
+One or more of the options below may be used to determine the files
+shown:
+
+-c|--cached
+	Show cached files in the output (default)
+
+-d|--deleted
+	Show deleted files in the output
+
+-o|--others
+	Show other files in the output
+
+-i|--ignored
+	Show ignored files in the output
+	Note the this also reverses any exclude list present.
+
+-s|--stage
+	Show stage files in the output
+
+-u|--unmerged
+	Show unmerged files in the output (forces --stage)
+
+-z
+	\0 line termination on output
+
+-x|--exclude=<pattern>
+	Skips files matching pattern.
+	Note that pattern is a shell wildcard pattern.
+
+-X|--exclude-from=<file>
+	exclude patterns are read from <file>; 1 per line.
+	Allows the use of the famous dontdiff file as follows to find
+	out about uncommitted files just as dontdiff is used with
+	the diff command:
+	     git-ls-files --others --exclude-from=dontdiff
 
--c
-	Get the commit objects.
 -t
-	Get trees associated with the commit objects.
--a
-	Get all the objects.
--v
-	Report what is downloaded.
+	Identify the file status with the following tags (followed by
+	a space) at the start of each line:
+	H	cached
+	M	unmerged
+	R	removed/deleted
+	?	other
+
+Output
+show files just outputs the filename unless --stage is specified in
+which case it outputs:
+
+[<tag> ]<mode> <object> <stage> <file>
+
+git-ls-files --unmerged" and "git-ls-files --stage " can be used to examine
+detailed information on unmerged paths.
+
+For an unmerged path, instead of recording a single mode/SHA1 pair,
+the dircache records up to three such pairs; one from tree O in stage
+1, A in stage 2, and B in stage 3.  This information can be used by
+the user (or Cogito) to see what should eventually be recorded at the
+path. (see read-cache for more information on state)
+
+see also:
+read-cache
+
 
 ################################################################
 git-ls-tree
@@ -959,33 +1061,6 @@ Helper "server-side" program used by git
 
 
 ################################################################
-git-diff-files
-	git-diff-files [-p] [-q] [-r] [-z] [<pattern>...]
-
-Compares the files in the working tree and the cache.  When paths
-are specified, compares only those named paths.  Otherwise all
-entries in the cache are compared.  The output format is the
-same as git-diff-cache and git-diff-tree.
-
--p
-	generate patch (see section on generating patches).
-
--q
-	Remain silent even on nonexisting files
-
--r
-	This flag does not mean anything.  It is there only to match
-	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
-	at all the subdirectories.
-
-
-Output format:
-
-See "Output format from git-diff-cache, git-diff-tree and git-diff-files"
-section.
-
-
-################################################################
 git-tag-script
 
 This is an example script that uses git-mktag to create a tag object
@@ -1003,81 +1078,6 @@ generated tar archive.
 
 
 ################################################################
-git-ls-files
-	git-ls-files [-z] [-t]
-		(--[cached|deleted|others|ignored|stage|unmerged])*
-		(-[c|d|o|i|s|u])*
-		[-x <pattern>|--exclude=<pattern>]
-		[-X <file>|--exclude-from=<file>]
-
-This merges the file listing in the directory cache index with the
-actual working directory list, and shows different combinations of the
-two.
-
-One or more of the options below may be used to determine the files
-shown:
-
--c|--cached
-	Show cached files in the output (default)
-
--d|--deleted
-	Show deleted files in the output
-
--o|--others
-	Show other files in the output
-
--i|--ignored
-	Show ignored files in the output
-	Note the this also reverses any exclude list present.
-
--s|--stage
-	Show stage files in the output
-
--u|--unmerged
-	Show unmerged files in the output (forces --stage)
-
--z
-	\0 line termination on output
-
--x|--exclude=<pattern>
-	Skips files matching pattern.
-	Note that pattern is a shell wildcard pattern.
-
--X|--exclude-from=<file>
-	exclude patterns are read from <file>; 1 per line.
-	Allows the use of the famous dontdiff file as follows to find
-	out about uncommitted files just as dontdiff is used with
-	the diff command:
-	     git-ls-files --others --exclude-from=dontdiff
-
--t
-	Identify the file status with the following tags (followed by
-	a space) at the start of each line:
-	H	cached
-	M	unmerged
-	R	removed/deleted
-	?	other
-
-Output
-show files just outputs the filename unless --stage is specified in
-which case it outputs:
-
-[<tag> ]<mode> <object> <stage> <file>
-
-git-ls-files --unmerged" and "git-ls-files --stage " can be used to examine
-detailed information on unmerged paths.
-
-For an unmerged path, instead of recording a single mode/SHA1 pair,
-the dircache records up to three such pairs; one from tree O in stage
-1, A in stage 2, and B in stage 3.  This information can be used by
-the user (or Cogito) to see what should eventually be recorded at the
-path. (see read-cache for more information on state)
-
-see also:
-read-cache
-
-
-################################################################
 git-unpack-file
 	git-unpack-file <blob>
 

--------------050109070505050508060405--
