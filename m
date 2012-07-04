From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/3] git p4: remove unused P4Submit interactive setting
Date: Wed, 4 Jul 2012 09:49:18 -0400
Message-ID: <20120704134918.GA28164@padd.com>
References: <1341408860-26965-1-git-send-email-pw@padd.com>
 <1341408860-26965-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Horowitz <mike@horowitz.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:49:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmPxQ-0004Ka-In
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 15:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab2GDNtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 09:49:23 -0400
Received: from honk.padd.com ([74.3.171.149]:44735 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab2GDNtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 09:49:22 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 996971FED;
	Wed,  4 Jul 2012 06:49:21 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 419215A90B; Wed,  4 Jul 2012 09:49:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1341408860-26965-2-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201011>

The "diff -w" version looks like this.  A bit easier to review.

--->8---

>From 3327945176be35081f2c86bc40b294ed9f73ea9a Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sun, 24 Jun 2012 15:39:18 -0400
Subject: [PATCH] git p4: remove unused P4Submit interactive setting

The code is unused.  Delete.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f895a24..542c20a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -844,7 +844,6 @@ class P4Submit(Command, P4UserMap):
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
-        self.interactive = True
         self.origin = ""
         self.detectRenames = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
@@ -1209,7 +1208,6 @@ class P4Submit(Command, P4UserMap):
 
         template = self.prepareSubmitTemplate()
 
-        if self.interactive:
         submitTemplate = self.prepareLogMessage(template, logMessage)
 
         if self.preserveUser:
@@ -1281,14 +1279,6 @@ class P4Submit(Command, P4UserMap):
                 os.remove(f)
 
         os.remove(fileName)
-        else:
-            fileName = "submit.txt"
-            file = open(fileName, "w+")
-            file.write(self.prepareLogMessage(template, logMessage))
-            file.close()
-            print ("Perforce submit template written as %s. "
-                   + "Please review/edit and then use p4 submit -i < %s to submit directly!"
-                   % (fileName, fileName))
 
     # Export git tags as p4 labels. Create a p4 label and then tag
     # with that.
@@ -1437,8 +1427,6 @@ class P4Submit(Command, P4UserMap):
             commit = commits[0]
             commits = commits[1:]
             self.applyCommit(commit)
-            if not self.interactive:
-                break
 
         if len(commits) == 0:
             print "All changes applied!"
-- 
1.7.11.1.125.g4a65fea
