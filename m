From: Olaf Hering <olh@suse.de>
Subject: [PATCH] allow double click on current HEAD id after git-pull
Date: Sat, 11 Feb 2006 12:26:30 +0100
Message-ID: <20060211112630.GA12421@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-From: git-owner@vger.kernel.org Sat Feb 11 12:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7stj-0002FB-CO
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 12:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWBKL0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 06:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBKL0g
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 06:26:36 -0500
Received: from cantor.suse.de ([195.135.220.2]:31206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751409AbWBKL0g (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 06:26:36 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 137B2EB41
	for <git@vger.kernel.org>; Sat, 11 Feb 2006 12:26:31 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15937>


Double click on to current HEAD commit id is not possible,
the dot has to go.

olaf@pomegranate:~/kernel/git/linux-2.6> git-pull
Unpacking 194 objects
 100% (194/194) done
* refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Updating from 5bc159e6cb7ca8d173195919ee935885c129011e to 25bf368b3d98668c5d5f38e2201d8bca16e52680.
Fast forward
...
olaf@pomegranate:~/kernel/git/linux-2.6> git-whatchanged 5bc159e6cb7ca8d173195919ee935885c129011e..25bf368b3d98668c5d5f38e2201d8bca16e52680.
olaf@pomegranate:~/kernel/git/linux-2.6> git-whatchanged 5bc159e6cb7ca8d173195919ee935885c129011e..25bf368b3d98668c5d5f38e2201d8bca16e52680
<stuff>

Index: git-1.1.3/git-merge.sh
===================================================================
--- git-1.1.3.orig/git-merge.sh
+++ git-1.1.3/git-merge.sh
@@ -127,7 +127,7 @@ case "$#,$common,$no_commit" in
 	;;
 1,"$head",*)
 	# Again the most common case of merging one remote.
-	echo "Updating from $head to $1."
+	echo "Updating from $head to $1"
 	git-update-index --refresh 2>/dev/null
 	new_head=$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -u -m $head "$new_head" &&
Index: git-1.1.3/git-resolve.sh
===================================================================
--- git-1.1.3.orig/git-resolve.sh
+++ git-1.1.3/git-resolve.sh
@@ -41,7 +41,7 @@ case "$common" in
 	exit 0
 	;;
 "$head")
-	echo "Updating from $head to $merge."
+	echo "Updating from $head to $merge"
 	git-read-tree -u -m $head $merge || exit 1
 	git-update-ref HEAD "$merge" "$head"
 	git-diff-tree -p $head $merge | git-apply --stat
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
