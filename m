From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] fix git config example syntax
Date: Sat, 28 Jun 2008 16:02:47 -0400
Message-ID: <20080628200247.GA10683@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 22:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCgeE-0005of-6D
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 22:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYF1UCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYF1UCv
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 16:02:51 -0400
Received: from wren.kitenet.net ([80.68.85.49]:59880 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbYF1UCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 16:02:51 -0400
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 8C8DD3142FB
	for <git@vger.kernel.org>; Sat, 28 Jun 2008 16:02:49 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id A3E091143C7; Sat, 28 Jun 2008 16:02:47 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93/7081/Fri May  9 11:52:50 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86740>

git-config expects a space, not '=' between option and value.

Also, quote the value since it contains globs, which some shells will not
pass through unchanged, or will abort if the glob doesn't expand.

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 97bed54..c350ad0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -513,7 +513,7 @@ have each person clone that repository with 'git clone':
 	cd project
 	git-init
 	git remote add origin server:/pub/project
-	git config --add remote.origin.fetch=+refs/remotes/*:refs/remotes/*
+	git config --add remote.origin.fetch '+refs/remotes/*:refs/remotes/*'
 	git fetch
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
 	git-svn init http://svn.foo.org/project

-- 
1.5.5.4
