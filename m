From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/7] merge,tag: describe -m just like commit
Date: Mon, 14 Feb 2011 16:10:32 +0100
Message-ID: <5d55b72b16f3d2def5fa955862fe5be6ff9f82f7.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp086-0002oe-SD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab1BNPNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41871 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753867Ab1BNPNr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:47 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1517B208E7
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:47 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 14 Feb 2011 10:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=I5VIhIuw+WVDOIcGhf5bl/ztj8w=; b=BjVNsHDBctdpteutJF0Hfbh/qWix2CoAnunEVL4cJZ7FKSCgIMRigkL/DNWuq9yFIiP+ANJpeQ4hDP0+PTY59YkRqGpZPEDAXrgXE4dSG+GDi4EY3sk4vmp0mjkT8xwclKUSWN/PBjgmzQAa1HDENl07NRMIc8HfyoCV0PkAO5g=
X-Sasl-enc: sjzPqrDZugxb88XH+lBYrNGv5uSU5ogKMIkw5kHpjpzE 1297696426
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9260C4425C5;
	Mon, 14 Feb 2011 10:13:46 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166724>

This also removes the misleading "if any" which sounds as if omitting
"-m" would omit the commmit message. (It meant to mean "if a merge
commit is created at all".)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/merge.c |    4 ++--
 builtin/tag.c   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9403747..cbbd053 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -194,8 +194,8 @@ static struct option builtin_merge_options[] = {
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, "option=value",
 		"option for selected merge strategy", option_parse_x),
-	OPT_CALLBACK('m', "message", &merge_msg, "message",
-		"message to be used for the merge commit (if any)",
+	OPT_CALLBACK('m', "message", &merge_msg, "MESSAGE",
+		"specify merge commit message",
 		option_parse_message),
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
diff --git a/builtin/tag.c b/builtin/tag.c
index 6408171..e135717 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -376,8 +376,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Tag creation options"),
 		OPT_BOOLEAN('a', NULL, &annotate,
 					"annotated tag, needs a message"),
-		OPT_CALLBACK('m', NULL, &msg, "msg",
-			     "message for the tag", parse_msg_arg),
+		OPT_CALLBACK('m', NULL, &msg, "MESSAGE",
+			     "specify tag message", parse_msg_arg),
 		OPT_FILENAME('F', NULL, &msgfile, "read message from file"),
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', NULL, &keyid, "key-id",
-- 
1.7.4.1.74.gf39475
