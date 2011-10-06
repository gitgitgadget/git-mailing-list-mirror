From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: [PATCH 1/3] completion: unite --reuse-message and --reedit-message handling
Date: Thu,  6 Oct 2011 21:40:29 +0300
Message-ID: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 20:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBt1M-0004ig-8a
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251Ab1JFSuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:50:08 -0400
Received: from mx.reaktor.fi ([82.203.205.80]:43170 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758991Ab1JFSuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:50:06 -0400
Received: from localhost.localdomain (v18-46.openvpn.reaktor.fi [10.1.18.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.reaktor.fi (Postfix) with ESMTPSA id 5B8F03BACF;
	Thu,  6 Oct 2011 21:41:18 +0300 (EEST)
X-Mailer: git-send-email 1.7.7.138.g7f41b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183016>

Signed-off-by: Teemu Matilainen <teemu.matilainen@iki.fi>
---
 contrib/completion/git-completion.bash |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8648a36..656297d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1259,12 +1259,8 @@ _git_commit ()
 			" "" "${cur##--cleanup=}"
 		return
 		;;
-	--reuse-message=*)
-		__gitcomp "$(__git_refs)" "" "${cur##--reuse-message=}"
-		return
-		;;
-	--reedit-message=*)
-		__gitcomp "$(__git_refs)" "" "${cur##--reedit-message=}"
+	--reuse-message=*|--reedit-message=*)
+		__gitcomp "$(__git_refs)" "" "${cur#*=}"
 		return
 		;;
 	--untracked-files=*)
-- 
1.7.7.138.g7f41b6
