From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 10/10] cvsserver doc: emphasize using CVS_SERVER= phrase within CVSROOT
Date: Sat, 24 Jan 2009 16:43:21 -0700
Message-ID: <1232840601-24696-11-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-10-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBc-0006Ei-Ok
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZAXXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbZAXXnp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:45 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:57609 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753457AbZAXXnc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:32 -0500
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id 7XJd1b00E17UAYkA2bjZWM; Sat, 24 Jan 2009 23:43:33 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id 7bjW1b00J1TYyYj8ZbjY5Q; Sat, 24 Jan 2009 23:43:32 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 16E9C8911E;
	Sat, 24 Jan 2009 16:43:26 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-10-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107023>

Add information about CVSROOT=":ext;CVS_SERVER=git-cvsserver:..." to
"SYNOPSIS" section.  This information was/is already spelled out deep in
the "INSTALLATION" section, but this new method is far superior to
the old backwards-compatible option (separate environment variable),
so try to emphasize it's use for versions of CVS that support it.

Also mention how to connect to a local git repository using
git-cvsserver.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Documentation/git-cvsserver.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 6f8cd88..d1dc5be 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -14,6 +14,18 @@ SSH:
 export CVS_SERVER=git-cvsserver
 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
 
+SSH with newer CVS versions (>= 1.12.11):
+
+[verse]
+export CVSROOT=":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git"
+'cvs' -d "$CVSROOT" co <HEAD_name>
+
+Local repository:
+
+[verse]
+export CVSROOT=":fork;CVS_SERVER=git-cvsserver:/path/repo.git"
+'cvs' -d "$CVSROOT" co <HEAD_name>
+
 pserver (/etc/inetd.conf):
 
 [verse]
-- 
1.6.1.81.g9833d.dirty
