From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Thu, 21 Apr 2005 21:58:14 -0600
Message-ID: <200504212158.14898.elenstev@mesatop.com>
References: <20050422030931.GA14565@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 05:58:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOpIk-0005gS-AP
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 05:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVDVEC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 00:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVDVEC0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 00:02:26 -0400
Received: from taco.zianet.com ([216.234.192.159]:59404 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261940AbVDVECV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 00:02:21 -0400
Received: (qmail 72584 invoked from network); 22 Apr 2005 04:02:20 -0000
Received: from 216-31-65-209.zianet.com (216.31.65.209)
  by 0 with SMTP; 22 Apr 2005 04:02:20 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <20050422030931.GA14565@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 21 April 2005 09:09 pm, Petr Baudis wrote:
>   Hello,
> 
>   FYI, I've released git-pasky-0.6.3 earlier in the night. It brings
> especially plenty of bugfixes, but also some tiny enhancements, like
> colored log and ability to pick branch in the remote repository. git log
> and git patch now also accept range of commits, so e.g. if you do

Here's a patch to let people know about the nice color feature.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

Index: git
===================================================================
--- 0a9ee5a4d947b998a7ce489242800b39f98eeee5/git  (mode:100755 sha1:39969debd59ed51c57973c819cdcc3ca8a7da819)
+++ uncommitted/git  (mode:100755)
@@ -35,7 +35,7 @@
 	fork		BNAME BRANCH_DIR [COMMIT_ID]
 	help
 	init		RSYNC_URL
-	log		[COMMIT_ID | COMMIT_ID:COMMIT_ID]
+	log		[-c] [COMMIT_ID | COMMIT_ID:COMMIT_ID]
 	ls		[TREE_ID]
 	lsobj		[OBJTYPE]
 	lsremote
Index: gitlog.sh
===================================================================
--- 0a9ee5a4d947b998a7ce489242800b39f98eeee5/gitlog.sh  (mode:100755 sha1:50eab642cdf5e695cf15be4ce3a7469dd68637e7)
+++ uncommitted/gitlog.sh  (mode:100755)
@@ -7,6 +7,14 @@
 # Major optimizations by (c) Phillip Lougher.
 # Rendered trivial by Linus Torvalds.
 #
+# Takes a -c option to add color to the output.
+# Currently, the colors are:
+#
+#	header		Green	
+#	author 		Cyan
+#	committer	Magenta
+#	signoff		Yellow
+#
 # Takes an id resolving to a commit to start from (HEAD by default),
 # or id1:id2 representing an (id1;id2] range of commits to show.
 
