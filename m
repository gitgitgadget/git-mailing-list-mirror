From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 2/4] use "crt_series.get_branch()" instead of "git.get_head_file()"
Date: Mon, 14 Nov 2005 11:50:57 -0500
Message-ID: <20051114165057.22202.82090.stgit@dexter.citi.umich.edu>
References: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhXy-0002xN-RD
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKNQu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKNQu6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:50:58 -0500
Received: from citi.umich.edu ([141.211.133.111]:44141 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751190AbVKNQu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:50:57 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 888011BB9A
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 11:50:57 -0500 (EST)
To: git@vger.kernel.org
In-Reply-To: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11823>

More cleanup to the branch command.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/branch.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index d85ba69..9bf6cdb 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -147,7 +147,7 @@ def func(parser, options, args):
     elif options.protect:
 
         if len(args) == 0:
-            branch_name = git.get_head_file()
+            branch_name = crt_series.get_branch()
         elif len(args) == 1:
             branch_name = args[0]
         else:
@@ -182,7 +182,7 @@ def func(parser, options, args):
     elif options.unprotect:
 
         if len(args) == 0:
-            branch_name = git.get_head_file()
+            branch_name = crt_series.get_branch()
         elif len(args) == 1:
             branch_name = args[0]
         else:
@@ -222,4 +222,4 @@ def func(parser, options, args):
     if len(args) != 0:
         parser.error('incorrect number of arguments')
 
-    print git.get_head_file()
+    print crt_series.get_branch()
