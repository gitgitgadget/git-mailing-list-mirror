From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] cogito: export user env in tutorial-script
Date: Thu, 29 Jun 2006 08:58:23 +0000
Message-ID: <20060629085823.1400.qmail@2a570ab8441287.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 10:58:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvsLj-0006aL-7c
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 10:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWF2I6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 04:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWF2I6H
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 04:58:07 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:26776 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S932523AbWF2I6G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 04:58:06 -0400
Received: (qmail 1401 invoked by uid 1000); 29 Jun 2006 08:58:23 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22848>

The GIT_* environment variables set in switch_user() must be exported to be
available to the programs run afterwards.

Signed-off-by: Gerrit Pape <pape@smarden.org>

---

 Documentation/tutorial-script/script.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

f4d96a4ceda9b7ac7e2e29f4b017edf60360904c
diff --git a/Documentation/tutorial-script/script.sh b/Documentation/tutorial-script/script.sh
index b99e3c9..b0e49c8 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -52,10 +52,10 @@ switch_user () {
 		*) echo "I don't know you, $1"; exit 1;;
 	esac
 	HOME=$(pwd)
-	GIT_AUTHOR_NAME="$1"
-	GIT_AUTHOR_EMAIL="$1@example.com"
-	GIT_COMMITTER_NAME="$1"
-	GIT_COMMITTER_EMAIL="$1@example.com"
+	export GIT_AUTHOR_NAME="$1"
+	export GIT_AUTHOR_EMAIL="$1@example.com"
+	export GIT_COMMITTER_NAME="$1"
+	export GIT_COMMITTER_EMAIL="$1@example.com"
 }
 
 
-- 
1.3.3
