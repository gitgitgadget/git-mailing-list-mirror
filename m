From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/7] add push line in git-clone
Date: Mon, 28 Apr 2008 11:32:13 -0400
Message-ID: <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:34:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMg-0004Kp-Rv
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934368AbYD1Pcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935671AbYD1Pch
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:37 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60625 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935623AbYD1Pcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:35 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004f7-Ex; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80540>

This patch makes git-clone add a remote.origin.push line, using the
new ":" special refspec.  This is useful in the following patches that
modify the behavior of "git push"; right now, it only adds clarity.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 git-clone.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 2636159..7a5570a 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -480,6 +480,8 @@ then
 	# Set up the mappings to track the remote branches.
 	git config remote."$origin".fetch \
 		"+refs/heads/*:$remote_top/*" '^$' &&
+	git config remote."$origin".push \
+		":" '^$' &&
 
 	# Write out remote.$origin config, and update our "$head_points_at".
 	case "$head_points_at" in
-- 
1.5.5
