From: apw@us.ibm.com (Amos Waterland)
Subject: [PATCH] Document subproject feature
Date: Fri, 11 May 2007 20:58:44 -0400
Message-ID: <20070512005844.GA24184@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 03:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmg4O-0007FB-Va
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbXELBGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760183AbXELBGr
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:06:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:42841 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748AbXELBGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:06:46 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4C13FkW006025
	for <git@vger.kernel.org>; Fri, 11 May 2007 21:03:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4C16haG205390
	for <git@vger.kernel.org>; Fri, 11 May 2007 19:06:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4C16htt002860
	for <git@vger.kernel.org>; Fri, 11 May 2007 19:06:43 -0600
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l4C16gEK002657
	for <git@vger.kernel.org>; Fri, 11 May 2007 19:06:42 -0600
Received: by kvasir.watson.ibm.com (Postfix, from userid 1000)
	id A6F2BB151F1; Fri, 11 May 2007 20:58:44 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47005>

Add a section to the user manual about the new subproject support.
Show how to make a subproject.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 user-manual.txt |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 13db969..27d601f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,4 +1,4 @@
-Git User's Manual (for version 1.5.1 or newer)
+Git User's Manual (for version 1.5.2 or newer)
 ______________________________________________
 
 This manual is designed to be readable by someone with basic unix
@@ -1406,6 +1406,39 @@ just performs a "fast forward"; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
 
+[[subprojects]]
+Subprojects
+-----------
+
+Some large development efforts, such as embedded Linux distributions,
+are composed of a set of large projects, each with its own development
+team, but all of which are combined to produce the project as a whole.
+For example, there might be a firmware project, a hypervisor project,
+a kernel project, and a userspace project.  Note that while each
+project is conceptually independent, there are many cases in which a
+change to the hypervisor necessitates a change to the kernel, for
+example.
+
+In this case it is nice to be able to reason about the state of the
+entire project, but also not inconvenience each development team with
+checking out a gigantic repository that represents the entire project.
+Git provides subproject support for this case, which is similar to CVS
+modules or the hg forest extension.
+
+Here is an example of creating a subproject inside an existing project:
+
+-------------------------------------------------
+$ mkdir subproject
+$ cd subproject
+$ git init
+$ touch Makefile
+$ git add Makefile
+$ git commit -m "Create subproject."
+$ cd ..
+$ git add subproject
+$ git commit -m "Add subproject."
+-------------------------------------------------
+
 [[fixing-mistakes]]
 Fixing mistakes
 ---------------
