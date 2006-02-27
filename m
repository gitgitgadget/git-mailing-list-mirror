From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: tell the user to not modify git-svn-HEAD directly
Date: Mon, 27 Feb 2006 11:04:02 -0800
Message-ID: <20060227190402.GA14199@localdomain>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 20:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnfF-0005MK-K5
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 20:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWB0TEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWB0TEF
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 14:04:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58288 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751720AbWB0TEE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 14:04:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id EFDAF2DC01A;
	Mon, 27 Feb 2006 11:04:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 27 Feb 2006 11:04:02 -0800
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <20060227184641.GA21684@hand.yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16877>

As a rule, interface branches to different SCMs should never be modified
directly by the user.  They are used exclusively for talking to the
foreign SCM.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

4676a850ad5a9e4a88fa5dfba1ac231a58bffda1
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index b4b7789..b588a2a 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -43,6 +43,11 @@ fetch::
 	Fetch unfetched revisions from the SVN_URL we are tracking.
 	refs/heads/git-svn-HEAD will be updated to the latest revision.
 
+	Note: You should never attempt to modify the git-svn-HEAD branch
+	outside of git-svn.  Instead, create a branch from git-svn-HEAD
+	and work on that branch.  Use the 'commit' command (see below)
+	to write git commits back to git-svn-HEAD.
+
 commit::
 	Commit specified commit or tree objects to SVN.  This relies on
 	your imported fetch data being up-to-date.  This makes
@@ -179,7 +184,9 @@ SVN repositories via one git repository.
 environment variable to a name other other than "git-svn" (the default)
 and git-svn will ignore the contents of the $GIT_DIR/git-svn directory
 and instead do all of its work in $GIT_DIR/$GIT_SVN_ID for that
-invocation.
+invocation.  The interface branch will be $GIT_SVN_ID-HEAD, instead of
+git-svn-HEAD.  Any $GIT_SVN_ID-HEAD branch should never be modified
+by the user outside of git-svn commands.
 
 ADDITIONAL FETCH ARGUMENTS
 --------------------------
-- 
1.2.3.gfc24dc-dirty
