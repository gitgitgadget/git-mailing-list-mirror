From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] update hook: redirect _both_ diagnostic lines to stderr upon tag failure
Date: Thu, 28 Dec 2006 16:05:02 +0100
Message-ID: <87tzzg6oyp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 28 16:05:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzwoy-0003Nu-Hv
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 16:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbWL1PFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 10:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbWL1PFE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 10:05:04 -0500
Received: from mx.meyering.net ([82.230.74.64]:37157 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754864AbWL1PFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 10:05:03 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 64B754EC6; Thu, 28 Dec 2006 16:05:02 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35557>


Otherwise, sending the diagnostic to stdout would provoke a protocol failure.
Signed-off-by: Jim Meyering <jim@meyering.net>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 76d5ac2..9863a80 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -19,7 +19,7 @@ # Remove this code to treat dumb tags th
 case "$1","$ref_type" in
 refs/tags/*,commit)
 	echo "*** Un-annotated tags are not allowed in this repo" >&2
-	echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate."
+	echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
 	exit 1;;
 refs/tags/*,tag)
 	echo "### Pushing version '${1##refs/tags/}' to the masses" >&2
--
1.4.2.GIT
