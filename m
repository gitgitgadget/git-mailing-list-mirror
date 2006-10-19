From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add revspec documentation for ':path', ':[0-3]:path' and git-describe
Date: Wed, 18 Oct 2006 21:43:53 -0700
Message-ID: <7vlkncx6d2.fsf@assigned-by-dhcp.cox.net>
References: <20061019030455.GA10554@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 06:44:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaPlJ-0000Ge-7J
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 06:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWJSEn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 00:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWJSEnz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 00:43:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2244 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030300AbWJSEnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 00:43:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019044354.JAPO18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Oct 2006 00:43:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c4jg1V00T1kojtg0000000
	Thu, 19 Oct 2006 00:43:40 -0400
To: pclouds@gmail.com
In-Reply-To: <20061019030455.GA10554@localhost> (pclouds@gmail.com's message
	of "Thu, 19 Oct 2006 10:04:55 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29319>

> As I'm not very good at English, please correct any mistake I made

Thanks.  I do not know about English, but I'd move things around
to group them better.  Most talk about committish but the
colon-path are about trees and blobs.

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2f1306c..412bafb 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -111,7 +111,9 @@ SPECIFYING REVISIONS
 
 A revision parameter typically, but not necessarily, names a
 commit object.  They use what is called an 'extended SHA1'
-syntax.
+syntax.  Here are various ways to spell object names.  The
+ones listed near the end of this list are to name trees and
+blobs contained in a commit.
 
 * The full SHA1 object name (40-byte hexadecimal string), or
   a substring of such that is unique within the repository.
@@ -119,6 +121,9 @@ syntax.
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
 
+* An output from `git-describe`; i.e. a closest tag, followed by a
+  dash, a 'g', and an abbreviated object name.
+
 * A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by $GIT_DIR/refs/heads/master.  If you
   happen to have both heads/master and tags/master, you can
@@ -156,6 +161,15 @@ syntax.
   and dereference the tag recursively until a non-tag object is
   found.
 
+* A suffix ':' followed by a path; this names the blob or tree
+  at the given path in the tree-ish object named by the part
+  before the colon.
+
+* A colon, optionally followed by a stage number (0 to 3) and a
+  colon, followed by a path; this names a blob object in the
+  index at the given path.  Missing stage number (and the colon
+  that follows it) names an stage 0 entry.
+
 Here is an illustration, by Jon Loeliger.  Both node B and C are
 a commit parents of commit node A.  Parent commits are ordered
 left-to-right.
