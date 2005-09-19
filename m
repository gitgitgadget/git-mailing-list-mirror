From: Linus Torvalds <torvalds@osdl.org>
Subject: Remove total confusion from "git checkout"
Date: Mon, 19 Sep 2005 10:11:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191009041.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Sep 19 19:11:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHPAv-00047N-W8
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVISRL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVISRL1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 13:11:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932477AbVISRL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 13:11:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JHBLBo022048
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 10:11:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JHBIiV002821;
	Mon, 19 Sep 2005 10:11:20 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8890>


The target to check out does not need to be a branch. The _result_ of the 
checkout needs to be a branch. Don't confuse the two, and then insult the 
user.

Insulting is ok, but I personally get really pissed off is a tool is both 
confused and insulting. At least be _correct_ and insulting.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-checkout.sh b/git-checkout.sh
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -23,7 +23,7 @@ while [ "$#" != "0" ]; do
 		;;
 	*)
 		rev=$(git-rev-parse --verify "$arg^0" 2>/dev/null) ||
-			die "hey dummy, branch '$arg' doesn't exist."
+			die "I don't know any '$arg'."
 		if [ -z "$rev" ]; then
 			echo "unknown flag $arg"
 			exit 1
