From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] checkout: --to requires directory
Date: Mon, 23 Feb 2015 17:17:46 +0100
Message-ID: <3ae582f2ca4e4a7ef6cb0041148037bbb31c5e09.1424707497.git.git@drmicha.warpmail.net>
References: <20150223144214.GA31624@peff.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:18:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvhw-0003pz-QI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbbBWQR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:17:59 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54021 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752588AbbBWQRy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 11:17:54 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F85E2077B
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 11:17:53 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 23 Feb 2015 11:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=7XeSudA0CbkoomFFqBNs3wDOwbI=; b=GSG8WO1gt680x5QfnOpA
	qLGnX3VnUMb9NQpkSyTLi9xvHu2uKsBvg4RVvTDJJcWLVwUnAFfxewr37X9obX05
	RjZJnqiyDl+PkMp0SjE/yzO+kqEL+6S96seUQJZm3OyceTwQnYJluShODJ/ezKpK
	s5EH3t0fDVZQCfqKWPwk42s=
X-Sasl-enc: GOkg5T0Jzc939RwHBG5XJJhqeZb/mF6ge20T5pzpSs4X 1424708273
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 84B106800FA;
	Mon, 23 Feb 2015 11:17:53 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
In-Reply-To: <20150223144214.GA31624@peff.net>
In-Reply-To: <cover.1424707497.git.git@drmicha.warpmail.net>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264271>

--to requires a directory, not a file. Say so in the usage string.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I did not spot any other "misuses" of OPT_FILENAME (for non-files).

 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8b2bf20..4256560 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1341,7 +1341,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
-		OPT_FILENAME(0, "to", &opts.new_worktree,
+		OPT_PATH(0, "to", &opts.new_worktree, N_("dir"),
 			   N_("check a branch out in a separate working directory")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
-- 
2.3.0.296.g32c87e1
