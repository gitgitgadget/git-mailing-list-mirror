From: Peter Harris <git@peter.is-a-geek.org>
Subject: [PATCH 2/2] Documentation/git-svn.txt: Fix "git clone" example
Date: Thu, 7 Feb 2008 09:52:31 -0500 (EST)
Message-ID: <alpine.OSX.1.00.0802070949080.314@mac.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 15:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN87e-00078B-U1
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 15:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbYBGOwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 09:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755703AbYBGOwg
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 09:52:36 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:32572 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696AbYBGOwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 09:52:35 -0500
Received: by py-out-1112.google.com with SMTP id u52so4970616pyb.10
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 06:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:user-agent:mime-version:content-type:sender;
        bh=+yigIZ4iVbi5/xhryj/GKJPBAySe0O6entGoiEFSYP4=;
        b=G8yZ473beG1v/jy4PoQ5+eV59YlAf816OOhIK68+55itC51Aac8mbkb7gXd8zRwxekEC6Ac+sE1JcFpoE2UAtHAlrrSUHAMQHUVMkIYHc0WWZRZSSnhNklJgyir3S0NxbeMH2p6MfNwlexAVSIir6JsCMSCjUGlVlHPzO7DiQig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:user-agent:mime-version:content-type:sender;
        b=vADSk5ERj2Ruepa3nivgBbS7ZU1l8/gxihrsULXvTiV4p/cAyxJkTLXl4MK9OCTvObZnLHGCgNIZxl7883xFV+r7sc9++R/H6NyIyWP4mTB+07b6cmm6XFdvWYrOwn/5KQo2+ftcNBYsjTVQ2maDkqPwr5zkEdFiKaGhtk3FAEc=
Received: by 10.65.192.19 with SMTP id u19mr21802182qbp.81.1202395954043;
        Thu, 07 Feb 2008 06:52:34 -0800 (PST)
Received: from mac.local ( [76.10.147.56])
        by mx.google.com with ESMTPS id f17sm9726142qba.35.2008.02.07.06.52.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Feb 2008 06:52:33 -0800 (PST)
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72954>

Subject: [PATCH] Documentation/git-svn.txt: Fix "git clone" example

If you don't "git reset --hard" to create master, then the "git svn rebase"
step fails.

Also add "-s" to use a standard layout, and remove the bogus '=' from
the "git config" step.

Signed-off-by: Peter <git@peter.is-a-geek.org>
---

This time with a correctly spelled log message.

 Documentation/git-svn.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f94d0f9..b293a66 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -455,16 +455,18 @@ have each person clone that repository with 'git clone':
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
-	ssh server "cd /pub && git svn clone http://svn.foo.org/project
+	ssh server "cd /pub && git svn clone -s http://svn.foo.org/project
 # Clone locally - make sure the refs/remotes/ space matches the server
 	mkdir project
 	cd project
 	git init
 	git remote add origin server:/pub/project
-	git config --add remote.origin.fetch=+refs/remotes/*:refs/remotes/*
+	git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
 	git fetch
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
-	git svn init http://svn.foo.org/project
+	git svn init -s http://svn.foo.org/project
+# Check out the svn branch you want to work on
+	git reset --hard trunk
 # Pull the latest changes from Subversion
 	git svn rebase
 ------------------------------------------------------------------------
-- 
1.5.3.7
