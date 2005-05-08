From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] core-git documentation update
Date: Sun, 08 May 2005 13:28:03 -0700
Message-ID: <7vd5s15up8.fsf@assigned-by-dhcp.cox.net>
References: <427E4AE1.2040105@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 22:27:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsMq-0002U3-PM
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVEHUdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVEHU3l
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:29:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:968 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261680AbVEHU2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 16:28:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508202803.KJRW23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 16:28:03 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <427E4AE1.2040105@dgreaves.com> (David Greaves's message of
 "Sun, 08 May 2005 18:22:41 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David, thanks for taking time to update the document.  I ended
up hand merging your two patches since I had a bit more
documentation updates in git-jc tree, so I'd like you to
proofread the result.  

It is my understanding that if I have a correct patch result
from your patch 1 and patch 2, I can throw away this message:

    Subject: [FILES] core-git documentation update

Am I correct?

I intend to keep not-so-controvercial stuff in git-jc tree, so
that when Linus returns he can pull from it instead of patching
from a pile of e-mails, potentially risking to leave good stuff
in his mailbox during that process.

The following diff is between:

    - Linus tree with two patches from you
    + The result of my hand merge, which I intend to ask Linus
      to pull when he returns.

Thanks.
---

# - 2: As Greaves
# + (working tree)
--- a/Documentation/core-git.txt
+++ b/Documentation/core-git.txt
@@ -473,7 +473,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [--cached] <tree-ish>
+'git-diff-cache' [-p] [-r] [-z] [-m] [--cached] <tree-ish>
 
 DESCRIPTION
 -----------
@@ -500,6 +500,12 @@ OPTIONS
 --cached::
 	do not consider the on-disk file at all
 
+-m::
+	By default, files recorded in the index but not checked
+	out are reported as deleted.  This flag makes
+	git-diff-cache say that all non-checked-out files are up
+	to date.
+
 Output format
 -------------
 include::diff-format.txt[]
@@ -1515,7 +1521,7 @@ git-update-cache - Modifies the index or
 SYNOPSIS
 --------
 'git-update-cache'
-	     [--add] [--remove] [--refresh]
+	     [--add] [--remove] [--refresh] [--replace]
 	     [--ignore-missing]
 	     [--force-remove <file>]
 	     [--cacheinfo <mode> <object> <file>]\*
@@ -1556,6 +1562,14 @@ OPTIONS
 	Remove the file from the index even when the working directory
 	still has such a file.
 
+--replace::
+	By default, when a file `path` exists in the index,
+	git-update-cache refuses an attempt to add `path/file`.
+	Similarly if a file `path/file` exists, a file `path`
+	cannot be added.  With --replace flag, existing entries
+	that conflicts with the entry being added are
+	automatically removed with warning messages.
+
 --::
 	Do not interpret any more arguments as options.
 


