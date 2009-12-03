From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v3 3/3] INSTALL: document a simpler way to run uninstalled builds
Date: Wed,  2 Dec 2009 22:14:07 -0700
Message-ID: <1259817247-3724-4-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259817247-3724-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259817247-3724-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259817247-3724-3-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 06:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG41j-000341-5S
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 06:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbZLCFO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 00:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZLCFO3
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 00:14:29 -0500
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:39781 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142AbZLCFO2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 00:14:28 -0500
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id CTLs1d00G16AWCUA1VDeKp; Thu, 03 Dec 2009 05:13:38 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA06.emeryville.ca.mail.comcast.net with comcast
	id CVEa1d0065FCJCg8SVEaNl; Thu, 03 Dec 2009 05:14:35 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 45EB889114;
	Wed,  2 Dec 2009 22:14:33 -0700 (MST)
X-Mailer: git-send-email 1.6.6.rc1
In-Reply-To: <1259817247-3724-3-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134433>

The new scripts automatically saved in the bin-wrappers directory allow
you to run a build when you have neither installed git nor tweaked
environment variables.  Mention this in INSTALL, along with the slight
performance issue of doing so.

This can be especially handy for manually testing network-invoked git
(from ssh, web servers, or similar), but it is also handy with a plain
command prompt.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 INSTALL |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/INSTALL b/INSTALL
index be504c9..61086ab 100644
--- a/INSTALL
+++ b/INSTALL
@@ -38,13 +38,17 @@ Issues of note:
    Interactive Tools package still can install "git", but you can build it
    with --disable-transition option to avoid this.
 
- - You can use git after building but without installing if you
-   wanted to.  Various git commands need to find other git
-   commands and scripts to do their work, so you would need to
-   arrange a few environment variables to tell them that their
-   friends will be found in your built source area instead of at
-   their standard installation area.  Something like this works
-   for me:
+ - You can use git after building but without installing if you want
+   to test drive it.  Simply run git found in bin-wrappers directory
+   in the build directory, or prepend that directory to your $PATH.
+   This however is less efficient than running an installed git, as
+   you always need an extra fork+exec to run any git subcommand.
+
+   It is still possible to use git without installing by setting a few
+   environment variables, which was the way this was done
+   traditionally.  But using git found in bin-wrappers directory in
+   the build directory is far simpler.  As a historical reference, the
+   old way went like this:
 
 	GIT_EXEC_PATH=`pwd`
 	PATH=`pwd`:$PATH
-- 
1.6.6.rc1
