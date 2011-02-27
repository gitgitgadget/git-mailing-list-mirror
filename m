From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/3] git-add: make -A description clearer vs. -u
Date: Sun, 27 Feb 2011 16:50:10 +0100
Message-ID: <059f131e50675ac53d5d304a51530984e1b7b8a8.1298821535.git.git@drmicha.warpmail.net>
References: <4D68D630.9000608@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 16:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptis5-0004aZ-UJ
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab1B0PtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:49:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59296 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752182Ab1B0PtF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 10:49:05 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DD4BB206B9;
	Sun, 27 Feb 2011 10:49:04 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Sun, 27 Feb 2011 10:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=8PdbErXIS+neJ0L4xd1Jg7PhEiE=; b=aQSVSlX/QehAd/2PNnUgXOoUKim4K7h/ViEzQ3q0iNMj8GABF2RU/BuiGAPtJaM0AYE/E+kaFw1jcwsABMrgnbZDO7BoEcghP8o42qcxgErK3KqxFOM3QBAoL+wRZhNuIViTAxhblUQ67el5Upw5wdTpsfni9yGrFSBv1NxqvsI=
X-Sasl-enc: KNeAKGkDW/lmlsY5GkI+XA8ylDVoUdXDOvW6WzfKRV8A 1298821744
Received: from localhost (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3AD9B448DAC;
	Sun, 27 Feb 2011 10:49:04 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
In-Reply-To: <4D68D630.9000608@drmicha.warpmail.net>
In-Reply-To: <cover.1298821535.git.git@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168038>

Currently, it sounds as if "notice removal of files" distinguishes "-A"
from "-u", and there is no mention of the worktree.

But both notice the removal, and only "-A" adds changes from untracked
files. Say so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f8e51f9..f7a17e4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -322,7 +322,7 @@ static struct option builtin_add_options[] = {
 	OPT__FORCE(&ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, "record only the fact that the path will be added later"),
-	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked files"),
+	OPT_BOOLEAN('A', "all", &addremove, "add changes from all tracked and untracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
 	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, "check if - even missing - files are ignored in dry run"),
-- 
1.7.4.1.224.gefc87
