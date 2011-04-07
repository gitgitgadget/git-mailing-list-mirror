From: Andrew Garber <andrew@andrewgarber.com>
Subject: [PATCH] git-p4: replace each tab with 8 spaces for consistency
Date: Thu,  7 Apr 2011 02:01:21 -0400
Message-ID: <1302156081-3286-2-git-send-email-andrew@andrewgarber.com>
References: <y>
Cc: Andrew Garber <andrew@andrewgarber.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 07 08:04:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7iKN-0007ot-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 08:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab1DGGES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 02:04:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44378 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1DGGER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 02:04:17 -0400
Received: by iyb14 with SMTP id 14so2133424iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 23:04:17 -0700 (PDT)
Received: by 10.42.155.130 with SMTP id u2mr779410icw.291.1302156204064;
        Wed, 06 Apr 2011 23:03:24 -0700 (PDT)
Received: from localhost.localdomain (75-119-246-204.dsl.teksavvy.com [75.119.246.204])
        by mx.google.com with ESMTPS id gy41sm915291ibb.22.2011.04.06.23.03.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 23:03:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171044>

Note that the majority of git-p4 uses spaces, not tabs, for indentation.
Consistent indentation is critical to the functionality of Python
scripts: mixing tabs and spaces in Python can lead to hard-to-find bugs.

Signed-off-by: Andrew Garber <andrew@andrewgarber.com>
---
 contrib/fast-import/git-p4 |   64 ++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3881515..78e5b3a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -222,10 +222,10 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
     try:
         while True:
             entry = marshal.load(p4.stdout)
-	    if cb is not None:
-		cb(entry)
-	    else:
-		result.append(entry)
+            if cb is not None:
+                cb(entry)
+            else:
+                result.append(entry)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -449,8 +449,8 @@ def p4ChangesForPaths(depotPaths, changeRange):
 
     changes = {}
     for line in output:
-	changeNum = int(line.split(" ")[1])
-	changes[changeNum] = True
+        changeNum = int(line.split(" ")[1])
+        changes[changeNum] = True
 
     changelist = changes.keys()
     changelist.sort()
@@ -1033,10 +1033,10 @@ class P4Sync(Command):
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
-	if file["type"] == "apple":
-	    print "\nfile %s is a strange apple file that forks. Ignoring" % \
-		file['depotFile']
-	    return
+        if file["type"] == "apple":
+            print "\nfile %s is a strange apple file that forks. Ignoring" % \
+                file['depotFile']
+            return
 
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.wildcard_decode(relPath)
@@ -1085,22 +1085,22 @@ class P4Sync(Command):
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
-	if marshalled.has_key('depotFile') and self.stream_have_file_info:
-	    # start of a new file - output the old one first
-	    self.streamOneP4File(self.stream_file, self.stream_contents)
-	    self.stream_file = {}
-	    self.stream_contents = []
-	    self.stream_have_file_info = False
+        if marshalled.has_key('depotFile') and self.stream_have_file_info:
+            # start of a new file - output the old one first
+            self.streamOneP4File(self.stream_file, self.stream_contents)
+            self.stream_file = {}
+            self.stream_contents = []
+            self.stream_have_file_info = False
 
-	# pick up the new file information... for the
-	# 'data' field we need to append to our array
-	for k in marshalled.keys():
-	    if k == 'data':
-		self.stream_contents.append(marshalled['data'])
-	    else:
-		self.stream_file[k] = marshalled[k]
+        # pick up the new file information... for the
+        # 'data' field we need to append to our array
+        for k in marshalled.keys():
+            if k == 'data':
+                self.stream_contents.append(marshalled['data'])
+            else:
+                self.stream_file[k] = marshalled[k]
 
-	self.stream_have_file_info = True
+        self.stream_have_file_info = True
 
     # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
@@ -1132,14 +1132,14 @@ class P4Sync(Command):
             self.stream_contents = []
             self.stream_have_file_info = False
 
-	    # curry self argument
-	    def streamP4FilesCbSelf(entry):
-		self.streamP4FilesCb(entry)
+            # curry self argument
+            def streamP4FilesCbSelf(entry):
+                self.streamP4FilesCb(entry)
 
-	    p4CmdList("-x - print",
-		'\n'.join(['%s#%s' % (f['path'], f['rev'])
+            p4CmdList("-x - print",
+                '\n'.join(['%s#%s' % (f['path'], f['rev'])
                                                   for f in filesToRead]),
-	        cb=streamP4FilesCbSelf)
+                cb=streamP4FilesCbSelf)
 
             # do the last chunk
             if self.stream_file.has_key('depotFile'):
@@ -1148,7 +1148,7 @@ class P4Sync(Command):
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
-	self.branchPrefixes = branchPrefixes
+        self.branchPrefixes = branchPrefixes
 
         if self.verbose:
             print "commit into %s" % branch
@@ -1253,7 +1253,7 @@ class P4Sync(Command):
 
         s = ''
         for (key, val) in self.users.items():
-	    s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
+            s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
         open(self.getUserCacheFilename(), "wb").write(s)
         self.userMapFromPerforceServer = True
-- 
1.7.3.4
