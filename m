From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Misc doc improvements
Date: Wed, 7 Jun 2006 20:32:33 +0200
Message-ID: <20060607183233.GA21448@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 07 20:32:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo2pb-0004FF-Vd
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWFGSch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWFGSch
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:32:37 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:17557 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932067AbWFGScg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 14:32:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1C49677004D;
	Wed,  7 Jun 2006 20:32:35 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05498-12; Wed,  7 Jun 2006 20:32:33 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id E157D77004B;
	Wed,  7 Jun 2006 20:32:33 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3BFCB6DF835; Wed,  7 Jun 2006 20:29:13 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id CD89062629; Wed,  7 Jun 2006 20:32:33 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21448>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-apply.txt    |    2 +-
 Documentation/git-shortlog.txt |   19 ++++++++++++++++---
 Documentation/glossary.txt     |    7 +++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9cc7c74..2ff7494 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -76,7 +76,7 @@ OPTIONS
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
-	context exist they all most match.  By default no context is
+	context exist they all must match.  By default no context is
 	ever ignored.
 
 --apply::
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 54fb922..0dbd3b2 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -5,7 +5,6 @@ NAME
 ----
 git-shortlog - Summarize 'git log' output
 
-
 SYNOPSIS
 --------
 git-log --pretty=short | 'git-shortlog'
@@ -13,8 +12,22 @@ git-log --pretty=short | 'git-shortlog'
 DESCRIPTION
 -----------
 Summarizes 'git log' output in a format suitable for inclusion
-in release announcements.
-
+in release announcements. Each commit will be grouped by author
+the first line of the commit message will be shown.
+
+Additionally, "[PATCH]" will be stripped from the commit description.
+
+FILES
+-----
+'.mailcap'::
+	If this file exists, it will be used for mapping author email
+	addresses to a real author name. One mapping per line, first
+	the author name followed by the email address enclosed by
+	'<' and '>'. Use hash '#' for comments. Example:
+
+		# Keep alphabetized
+		Adam Morrow <adam@localhost.localdomain>
+		Eve Jones <eve@laptop.(none)>
 
 Author
 ------
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 39c90ad..879c708 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -109,6 +109,13 @@ file system::
 git archive::
 	Synonym for repository (for arch people).
 
+grafts::
+	Grafts enables two otherwise different lines of development to be
+	joined together by recording fake ancestry information for commits.
+	This way you can make git pretend the set of parents a commit
+	has is different from what was recorded when the commit was created.
+	Configured via the `.git/info/grafts` file.
+
 hash::
 	In git's context, synonym to object name.
 
-- 
1.4.0.rc1.gfd4c-dirty
-- 
Jonas Fonseca
