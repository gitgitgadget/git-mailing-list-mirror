From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] checkout: --to requires directory
Date: Mon, 23 Feb 2015 15:16:59 +0100
Message-ID: <768eecca8711467b43fcc45403ce9ce91bb1550e.1424700971.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 15:17:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPtov-000738-5G
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 15:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbbBWORC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 09:17:02 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34377 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136AbbBWORB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 09:17:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 18E1220B05
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 09:17:00 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 23 Feb 2015 09:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id; s=smtpout; bh=8hClZ9qRIWF+4IK5wf/UxsI49Fw=; b=QLCoo
	ozkxiS21N61YR3elXmfvMkO7uyQ77DZI7pdLJtL2iGy46r9xojTpnX2EAIo3+GuD
	u1Y0TxwkBlWgL0T3Psk5E9rpbAbmT4mDdA5Nma1ieoECzWU4vvFGIhkiwJDc8AUz
	pwcR5UFNlClEg7WpTEuqLmmj5KR8OTv2KdKMPc=
X-Sasl-enc: 4lQ2qjrArC5S/geLPchTNdSrDVj1IMCsVXlbGepNyaZN 1424701020
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 56DDC680093;
	Mon, 23 Feb 2015 09:17:00 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264260>

--to requires a directory, not a file. Say so in the usage string.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8b2bf20..8cdcd07 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1341,7 +1341,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
-		OPT_FILENAME(0, "to", &opts.new_worktree,
+		OPT_STRING(0, "to", &opts.new_worktree, N_("dir"),
 			   N_("check a branch out in a separate working directory")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
-- 
2.3.0.296.g32c87e1
