From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] completion: git branch --set-upstream-to=
Date: Tue, 11 Sep 2012 13:58:30 +0200
Message-ID: <bd9d638e84e7e142e94b71213bed2126ea1f1951.1347364675.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 13:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBP76-0006it-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 13:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133Ab2IKL6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 07:58:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38651 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008Ab2IKL6c (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 07:58:32 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E0852119A;
	Tue, 11 Sep 2012 07:58:32 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 11 Sep 2012 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=8ZKB8ZCPHF69LjDhUyMdhc0kxZs=; b=cYTIkFZqW498ssdQbK4n
	EUNBGfRO28UTbOupevzFE38j2E0cpOxf7Vl9sJed34zR3lql1FTsGfs4n8fKqyjH
	4VKQLxXrAvVLpzN2PKCwwykIbs/4GzA9E6KahRFEzdURURO2d+e5ZumVW2Ijepj+
	6Hojd/VgcyxFwvWnba9ojHg=
X-Sasl-enc: 3K0eeLfzUtk66AxF1S+T627+U1hvNNDY3Gk6W7u5eRMg 1347364711
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CC7694825C3;
	Tue, 11 Sep 2012 07:58:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.443.g84e0989
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205223>

Remove the deprecated --set-upstream from completion suggestions and add
the new --set-upstream-to=, offering all refs for completion like in
similar cases.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 222b804..625d767 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -875,11 +875,14 @@ _git_branch ()
 	done
 
 	case "$cur" in
+	--set-upstream-to=*)
+		__gitcomp "$(__git_refs)" "" "${cur##--set-upstream-to=}"
+		;;
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --merged --no-merged
-			--set-upstream --edit-description --list
+			--set-upstream-to= --edit-description --list
 			"
 		;;
 	*)
-- 
1.7.12.443.g84e0989
