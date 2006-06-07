From: Francis Daly <francis@daoine.org>
Subject: [PATCH] git-cvsserver asciidoc formatting tweaks
Date: Wed, 7 Jun 2006 23:28:34 +0100
Message-ID: <20060607222834.GW29682@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 08 00:28:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo6W1-0006H5-5W
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 00:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWFGW2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 18:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFGW2g
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 18:28:36 -0400
Received: from craic.sysops.org ([217.75.2.2]:31977 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S932441AbWFGW2g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 18:28:36 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k57MSYKa031856
	for <git@vger.kernel.org>; Wed, 7 Jun 2006 23:28:34 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/1517/Wed Jun  7 01:05:07 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.5
X-Spam-Checker-Version: SpamAssassin 3.0.5 (2005-11-28) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21462>

No content change here.

html output improved. man output changed.

Signed-off-by: Francis Daly <francis@daoine.org>

---

08a466185e9d4ca5eb9914addc17297435d204a0
 Documentation/git-cvsserver.txt |   49 +++++++++++++++++++++++++--------------
 1 files changed, 31 insertions(+), 18 deletions(-)

08a466185e9d4ca5eb9914addc17297435d204a0
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 952635d..e328db3 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -36,49 +36,62 @@ INSTALLATION
 
 1. If you are going to offer anonymous CVS access via pserver, add a line in
    /etc/inetd.conf like
-
++
+--
+------
    cvspserver stream tcp nowait nobody git-cvsserver pserver
 
-   Note: In some cases, you need to pass the 'pserver' argument twice for
-   git-cvsserver to see it. So the line would look like
+------
+Note: In some cases, you need to pass the 'pserver' argument twice for
+git-cvsserver to see it. So the line would look like
 
+------
    cvspserver stream tcp nowait nobody git-cvsserver pserver pserver
 
-   No special setup is needed for SSH access, other than having GIT tools
-   in the PATH. If you have clients that do not accept the CVS_SERVER
-   env variable, you can rename git-cvsserver to cvs.
-
+------
+No special setup is needed for SSH access, other than having GIT tools
+in the PATH. If you have clients that do not accept the CVS_SERVER
+env variable, you can rename git-cvsserver to cvs.
+--
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
-
++
+--
+------
    [gitcvs]
         enabled=1
         # optional for debugging
         logfile=/path/to/logfile
 
-   Note: you need to ensure each user that is going to invoke git-cvsserver has
-   write access to the log file and to the git repository. When offering anon
-   access via pserver, this means that the nobody user should have write access
-   to at least the sqlite database at the root of the repository.
-
+------
+Note: you need to ensure each user that is going to invoke git-cvsserver has
+write access to the log file and to the git repository. When offering anon
+access via pserver, this means that the nobody user should have write access
+to at least the sqlite database at the root of the repository.
+--
 3. On the client machine you need to set the following variables.
    CVSROOT should be set as per normal, but the directory should point at the
    appropriate git repo. For example:
++
+--
+For SSH access, CVS_SERVER should be set to git-cvsserver
 
-   For SSH access, CVS_SERVER should be set to git-cvsserver
-
-   Example:
+Example:
 
+------
      export CVSROOT=:ext:user@server:/var/git/project.git
      export CVS_SERVER=git-cvsserver
-
+------
+--
 4. For SSH clients that will make commits, make sure their .bashrc file
    sets the GIT_AUTHOR and GIT_COMMITTER variables.
 
 5. Clients should now be able to check out the project. Use the CVS 'module'
    name to indicate what GIT 'head' you want to check out. Example:
-
++
+------
      cvs co -d project-master master
+------
 
 Eclipse CVS Client Notes
 ------------------------
-- 
1.3.3.g63df-dirty

-- 
Francis Daly        francis@daoine.org
