From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 16:33:23 -0700
Message-ID: <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:30:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMaG1-0007q6-If
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 01:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVDOXd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVDOXd1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:33:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9354 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262265AbVDOXdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 19:33:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415233324.FQAW1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 19:33:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 15 Apr 2005 14:48:47 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

    the merge-trees I sent you earlier was expecting the old
diff-tree behaviour, and I did not realize that I need an
explicit -z flag now.  Here is a fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-trees |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- merge-trees	2005-04-15 13:21:35.000000000 -0700
+++ merge-trees+	2005-04-15 16:27:34.000000000 -0700
@@ -78,8 +78,8 @@
     local ($_, $/);
     $/ = "\0"; 
     my %path;
-    open $fhi, '-|', 'diff-tree', '-r', @tree
-	or die "$!: diff-tree -r @tree";
+    open $fhi, '-|', 'diff-tree', '-r', '-z', @tree
+	or die "$!: diff-tree -r -z @tree";
     while (<$fhi>) {
 	chomp;
 	if (/^\*($reM)->($reM)\tblob\t($reID)->($reID)\t(.*)$/so) {

