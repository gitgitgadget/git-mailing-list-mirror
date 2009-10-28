From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] bash completion: difftool accepts the same options as diff
Date: Wed, 28 Oct 2009 10:45:38 +0100
Message-ID: <1256723138-1480-1-git-send-email-markus.heidelberg@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 10:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3585-00042p-EW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbZJ1Jrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZJ1Jre
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:47:34 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41917 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbZJ1Jre (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:47:34 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 45D9C139FFAA5;
	Wed, 28 Oct 2009 10:45:36 +0100 (CET)
Received: from [89.59.65.242] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N355z-0006eR-00; Wed, 28 Oct 2009 10:45:35 +0100
X-Mailer: git-send-email 1.6.5.2.86.g61663
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/dNIf6hfE1rG5i/cWMwj7aaXUEqM9FqZVHZPVO
	HEE3xptu5uM3BzKdjkPV3KhARBNgx0OulJhTV4KYlX3nr4nVrM
	UU/JO0TQMTFYgb15roCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131442>

So complete refs, files after the doubledash and some diff options that
make sense for difftool.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/completion/git-completion.bash |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d3fec32..45369e2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -958,6 +958,8 @@ __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
 
 _git_difftool ()
 {
+	__git_has_doubledash && return
+
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--tool=*)
@@ -965,11 +967,15 @@ _git_difftool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool="
+		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
+			--base --ours --theirs
+			--no-renames --diff-filter= --find-copies-harder
+			--relative --ignore-submodules
+			--tool="
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__git_complete_file
 }
 
 __git_fetch_options="
-- 
1.6.5.2.86.g61663
