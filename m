From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/9] git-svn: change ; to && in addremove()
Date: Mon, 20 Feb 2006 10:57:28 -0800
Message-ID: <11404618481876-git-send-email-normalperson@yhbt.net>
References: <11404618483821-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:57:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGE3-0001PS-DG
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWBTS5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWBTS5b
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57787 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932628AbWBTS52 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:28 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7A6062DC09E;
	Mon, 20 Feb 2006 10:57:28 -0800 (PST)
In-Reply-To: <11404618483821-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16489>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

ff01f98a865018be26baf1008c669009e95a93bf
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 4391bc3..25c248d 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -580,10 +580,10 @@ sub sys { system(@_) == 0 or croak $? }
 
 sub git_addremove {
 	system( "git-diff-files --name-only -z ".
-				" | git-update-index --remove -z --stdin; ".
+				" | git-update-index --remove -z --stdin && ".
 		"git-ls-files -z --others ".
 			"'--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude'".
-				" | git-update-index --add -z --stdin; "
+				" | git-update-index --add -z --stdin"
 		) == 0 or croak $?
 }
 
-- 
1.2.0.gdee6
