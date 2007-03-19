From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [patch] prefer "git COMMAND" over "git-COMMAND" in gitk
Date: Mon, 19 Mar 2007 18:00:37 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0703191746150.5525@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 00:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTREk-0006Lm-6o
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 00:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965573AbXCSXZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966052AbXCSXZI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 19:25:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50119 "EHLO
	mail1.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965584AbXCSXZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 19:25:05 -0400
X-Greylist: delayed 1462 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2007 19:25:05 EDT
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail1.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l2JN0or5000396
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 18:00:53 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Mar 2007 18:00:37 -0500
X-OriginalArrivalTime: 19 Mar 2007 23:00:38.0195 (UTC) FILETIME=[68E83030:01C76A7A]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15058001
X-TM-AS-Result: : Yes--7.427900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQ0LTE0NzAxOC03MDc3?=
	=?us-ascii?B?NDQtNzAwNzU2LTcwMjQ4NS03MDM3ODgtNzEwMjI0LTcwMDEwNy03?=
	=?us-ascii?B?MDMyMzItMTg4MDE5LTcwNzc3MC0xMzc3MTctMTQ4MDUw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42681>


Preferring git _space_ COMMAND over git _dash_ COMMAND allows the
user to have only git and gitk in their path. e.g. when git and gitk
are symbolic links in a personal bin directory to the real git and gitk.

Perfect time to say Thanks for the great work.

-brandon


--- gitk.orig   2007-02-13 20:46:46.000000000 -0600
+++ gitk        2007-03-19 17:46:55.142030000 -0500
@@ -1904,7 +1904,7 @@
      } else {
         set gdtargs [list "-S$highlight_files"]
      }
-    set cmd [concat | git-diff-tree -r -s --stdin $gdtargs]
+    set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
      set filehighlight [open $cmd r+]
      fconfigure $filehighlight -blocking 0
      fileevent $filehighlight readable readfhighlight
@@ -1956,7 +1956,7 @@
      }
      if {[eof $filehighlight]} {
         # strange...
-       puts "oops, git-diff-tree died"
+       puts "oops, git diff-tree died"
         catch {close $filehighlight}
         unset filehighlight
      }
