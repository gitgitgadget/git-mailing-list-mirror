From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] variable $projectdesc needs to be set before checking against unchanged default.
Date: Mon, 16 Apr 2007 08:30:42 +0000
Message-ID: <20070416083042.7415.qmail@5f69bf745847ea.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 10:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMbU-0005xa-RH
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbXDPIaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbXDPIaY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:30:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:46407 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964960AbXDPIaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:30:23 -0400
Received: (qmail 7416 invoked by uid 1000); 16 Apr 2007 08:30:42 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44622>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/hooks--update |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 0ff0330..0dcb1ad 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -34,6 +34,7 @@ fi
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
 # check for no description
+projectdesc=$(sed -e '1p' "$GIT_DIR/description")
 if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb" ]; then
 	echo "*** Project description file hasn't been set" >&2
 	exit 1
-- 
1.5.1.1
