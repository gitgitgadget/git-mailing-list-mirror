From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 1/2] Modify description file to say what this file is
Date: Tue, 17 Feb 2009 10:12:06 +0000
Message-ID: <200902171012.06176.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZNOE-0003ab-QV
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbZBQKjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZBQKjn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:39:43 -0500
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:8677
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbZBQKjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:39:42 -0500
X-Greylist: delayed 1647 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 05:39:41 EST
Received: by basyskom.de (Postfix, from userid 1051)
	id A8169398863; Tue, 17 Feb 2009 11:12:12 +0100 (CET)
X-Spam-Flag: NO
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on new.basyskom.de
X-Spam-Info: No, score=-1.6 required=6.3 tests=BAYES_00,RCVD_IN_PBL,
	RDNS_DYNAMIC autolearn=no version=3.2.5
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
	by basyskom.de (Postfix) with ESMTP id A97C03981FF
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 11:12:08 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110354>

A lot of people see this message for the first time on the gitweb
interface, where there is no clue as to what 'this file' means.

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 templates/hooks--update.sample |    5 +++--
 templates/this--description    |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 93c6055..f753d28 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -43,10 +43,11 @@ allowdeletetag=$(git config --bool hooks.allowdeletetag)
 
 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")
-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
+case $projectdesc in "Unnamed repository;"*|'')
 	echo "*** Project description file hasn't been set" >&2
 	exit 1
-fi
+	;;
+esac
 
 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a ref.
diff --git a/templates/this--description b/templates/this--description
index c6f25e8..914a64e 100644
--- a/templates/this--description
+++ b/templates/this--description
@@ -1 +1 @@
-Unnamed repository; edit this file to name it for gitweb.
+Unnamed repository; edit the .git/description file to name it for gitweb.
-- 
1.6.2.rc1
