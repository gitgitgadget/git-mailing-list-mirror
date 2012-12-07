From: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Subject: [PATCH] completion: add option --recurse-submodules to "git push"
Date: Fri,  7 Dec 2012 13:28:24 +0100
Message-ID: <1354883304-6860-1-git-send-email-steffen.jaeckel@stzedn.de>
Cc: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 13:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tgx3T-0000Mr-40
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 13:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933788Ab2LGM3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 07:29:05 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:57418 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933740Ab2LGM3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 07:29:04 -0500
X-RZG-AUTH: :P3gBc0atdbHQf4m9P0fPTPM9Kz3UUxAg/dg4cUs5qun4+E7h2uzct8C7qfeaL15YHuoXU+bgZg==
X-RZG-CLASS-ID: mo00
Received: from localhost (pd956be74.dip0.t-ipconnect.de [217.86.190.116])
	by smtp.strato.de (josoe mo1) (RZmta 31.7 AUTH)
	with ESMTPA id e043cboB7BZ9M0 ; Fri, 7 Dec 2012 13:28:59 +0100 (CET)
X-Mailer: git-send-email 1.8.0.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211175>

Signed-off-by: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
---
 contrib/completion/git-completion.bash | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..5b4d2e1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1434,6 +1434,10 @@ _git_pull ()
 	__git_complete_remote_or_refspec
 }
 
+__git_push_recurse_submodules_options="
+	check on-demand
+"
+
 _git_push ()
 {
 	case "$prev" in
@@ -1446,10 +1450,15 @@ _git_push ()
 		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
 		return
 		;;
+	--recurse-submodules=*)
+		__gitcomp "$__git_push_recurse_submodules_options" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
 			--receive-pack= --repo= --set-upstream
+			--recurse-submodules=
 		"
 		return
 		;;
-- 
1.8.0.msysgit.0
