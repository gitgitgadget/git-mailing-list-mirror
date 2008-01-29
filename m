From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add info about $projectroot and $projects_list to
	gitweb/README
Date: Tue, 29 Jan 2008 20:52:32 +0100
Message-ID: <20080129195231.31960.78215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 20:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJwWY-00061z-Uz
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbYA2TxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 14:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYA2TxG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 14:53:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:30470 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYA2TxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 14:53:04 -0500
Received: by nf-out-0910.google.com with SMTP id g13so255081nfb.21
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=XDOVMEw5IRIq3S5M5j30z/L3M1JN+pJ4x6NaXkABsLE=;
        b=AmHS40fEdyTMKYnFGGll1QBljPAqIWNgE88uOPnH+a4UpjNAkBb099d9fsDXgOxuqgfAtErULOj6L/OfuL3CaMrHg3qQ2eYm8rdIlQaX4cvnEiH0b1Alu59m2EF7um2170alB3TXcf7PqDvBxFfe6q++sOZfuvTW14iUkiuv43A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=gS4qSomvRA6fTF+w90UBQbF3Gn/wEtcFE3P7b4V7QsGG0R3EMOIDoTDpqx4cNeKRZieq8xrHvOPugjJrNsHl+nlsmGT0acY5sNhlMMNozrsfs4uWW2cRfdg4QgpL+XKS5vF5bXY2sCrFH1Zmnh1MkcCplKF3PRGv/mGgsnqf7Yg=
Received: by 10.78.166.7 with SMTP id o7mr10192968hue.31.1201636380716;
        Tue, 29 Jan 2008 11:53:00 -0800 (PST)
Received: from localhost.localdomain ( [83.8.244.23])
        by mx.google.com with ESMTPS id 4sm2860187hud.61.2008.01.29.11.52.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 11:52:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0TJqWL3031986
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 20:52:38 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71989>


Those two configuration variables are important enough that it is
worth to explicitely write about them in the "Gitweb config file
variables" section even if they are usually set during build by
GITWEB_PROJECTROOT and GITWEB_LIST build (Makefile) configuration
variables.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/README |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)


diff --git a/gitweb/README b/gitweb/README
index b28f59f..4c8bedf 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -129,17 +129,30 @@ descriptions.
 Gitweb config file variables
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-You can set, among others,  the following variables in gitweb config files:
+You can set, among others, the following variables in gitweb config files
+(with the exception of $projectroot and $projects_list this list does
+not include variables usually directly set during build):
  * $GIT
    Cure git executable to use.  By default set to "$GIT_BINDIR/git", which
    in turn is by default set to "$(bindir)/git".  If you use git from binary
    package, set this to "/usr/bin/git".  This can just be "git" if your
    webserver has a sensible PATH.  If you have multiple git versions
-   installed it is / can be used to choose which one to use.
+   installed it can be used to choose which one to use.
  * $version
    Gitweb version, set automatically when creating gitweb.cgi from
    gitweb.perl. You might want to modify it if you are running modified
    gitweb.
+ * $projectroot
+   Absolute filesystem path which will be prepended to project path;
+   the path to repository is $projectroot/$project.  Set to
+   $GITWEB_PROJECTROOT during installation.  This variable have to be
+   set correctly for gitweb to find repositories.
+ * $projects_list
+   Source of projects list, either directory to scan, or text file
+   with list of repositories (in the "<URI-encoded repository path> SPC
+   <URI-encoded repository owner>" format).  Set to $GITWEB_LIST
+   during installation.  If empty, $projectroot is used to scan for
+   repositories.
  * $my_url, $my_uri
    URL and absolute URL of gitweb script; you might need to set those
    variables if you are using 'pathinfo' feature: see also below.
