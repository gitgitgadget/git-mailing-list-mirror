From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 4/8] Update git-grep documentation
Date: Fri, 27 Apr 2007 00:09:26 -0500
Message-ID: <20070427050926.GC9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIkM-00011S-Qh
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbXD0FLv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbXD0FLv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:11:51 -0400
Received: from www.aeruder.net ([65.254.53.245]:4589 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbXD0FLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:11:50 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id D45FF40EC7;
	Fri, 27 Apr 2007 00:11:49 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45690>

Documentation/git-grep.txt: Document -F/--fixed-strings to
search for non-regexp patterns.  Document -I to not search
binary files.  Document -<num> as a shortcut for -C<num>.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-grep.txt |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0140c8e..c5a5dad 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -12,12 +12,13 @@ SYNOPSIS
 'git-grep' [--cached]
 	   [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
-	   [-E | --extended-regexp] [-G | --basic-regexp] [-F | --fixed-strings]
-	   [-n] [-l | --files-with-matches] [-L | --files-without-match]
+	   [-E | --extended-regexp] [-G | --basic-regexp]
+	   [-F | --fixed-strings] [-n]
+	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count] [--all-match]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
-	   [-f <file>] [-e] <pattern> [--and|--or|--not|(|)|-e <pattern>...]
-	   [<tree>...]
+	   [-f <file>] [-e] <pattern>
+	   [--and|--or|--not|(|)|-e <pattern>...] [<tree>...]
 	   [--] [<path>...]
 
 DESCRIPTION
@@ -39,6 +40,9 @@ OPTIONS
 	Ignore case differences between the patterns and the
 	files.
 
+-I::
+	Don't match the pattern in binary files.
+
 -w | --word-regexp::
 	Match the pattern only at word boundary (either begin at the
 	beginning of a line, or preceded by a non-word character; end at
@@ -64,6 +68,10 @@ OPTIONS
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
 
+-F | --fixed-strings::
+	Use fixed strings for patterns (don't interpret pattern
+	as a regex).
+
 -n::
 	Prefix the line number to matching lines.
 
@@ -81,6 +89,9 @@ OPTIONS
 	line containing `--` between contiguous groups of
 	matches.
 
+-<num>::
+	A shortcut for specifying -C<num>.
+
 -f <file>::
 	Read patterns from <file>, one per line.
 
-- 
1.5.2.rc0.64.g8476
