From: Peter Harris <git@peter.is-a-geek.org>
Subject: [PATCH 2/2] Documentation/git-svn.txt: Fix "git clone" example
Date: Wed, 6 Feb 2008 18:45:03 -0500 (EST)
Message-ID: <alpine.OSX.1.00.0802061843420.27901@mac.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 00:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtxc-0000DU-Cy
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759196AbYBFXpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759259AbYBFXpL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:45:11 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:47985 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759018AbYBFXpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:45:09 -0500
Received: by py-out-1112.google.com with SMTP id u52so4621837pyb.10
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:user-agent:mime-version:content-type:sender;
        bh=thxmPyfCO+y7JTWAoJOifpZqhKaAgdBiKGz6ka10kXE=;
        b=jRA08A0LZs4p3DgnNKlJRPZRVEE1Ycuuviwq/Sybhn/djq7cf+3iu2v+cE7AlWc70yJZE0IBRnpOk3u6JRkRwngxugmsTzqkpI8g+Pzww1p31OLHlKfeTpIkUilZAHFGAL1Wgo/P94vxzrCGzSkdVq6MjxzU8vVUWAhVpMJZiOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:user-agent:mime-version:content-type:sender;
        b=WHk6Pf7aOGrGZiHeBOQMvRa8oci7SIdqvi9sbw2XwM3NB1Dpupa2XRKi9tQQMqGYTFxIDMFGqyjy+8S1WfNbQ3Qi0KM2awA6m2yMg9mLiyzophsQ11eRJeFv2kYPIc4p17BMYR0s8KCTF9qBYHNplPxIEVRJCnwByEPtDrJ2zfU=
Received: by 10.65.156.2 with SMTP id i2mr20064060qbo.60.1202341507193;
        Wed, 06 Feb 2008 15:45:07 -0800 (PST)
Received: from mac.local ( [76.10.147.56])
        by mx.google.com with ESMTPS id d12sm8898094qbc.3.2008.02.06.15.45.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 15:45:05 -0800 (PST)
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72876>


If you don't "git reset --hard" to create master, then the "git svn rebase"
step fails.

Also add "-s" to use a satandard layout, and remove the bogus '=' from
the "git config" step.

Signed-off-by: Peter <git@peter.is-a-geek.org>
---
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
