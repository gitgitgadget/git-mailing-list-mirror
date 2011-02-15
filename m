From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 04/10] commit,merge,tag: describe -m likewise
Date: Tue, 15 Feb 2011 14:09:07 +0100
Message-ID: <4a14b88302dee7fc92d4dca88f13d4a5890dec3f.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKi5-0004O3-2a
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab1BONMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:30 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35327 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466Ab1BONMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:25 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E4458202D1;
	Tue, 15 Feb 2011 08:12:24 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 15 Feb 2011 08:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=1GDWnwJS3rNWNZlXd4PrDlh4sx0=; b=QL/yZjyWzRu11jFcMKsCJ3XjLVFB4bZd/XCNG6pz/ETo6YO2SmrDRR+SlvZqMislfUCbXQJkCFJKacQ2Xzjq/72Z68TMdk1DAksmKNPmNV9yOw0YocmzR8C32JIVcTWVHVAbqPIzwPBQewU7m40tWo8L7Cz5jkxB3Y4b1sJsn9c=
X-Sasl-enc: yH9dV+I26+j8GoTmEv1K6WJfK13y63mVgPRQgXp2b4zl 1297775544
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 679AA405952;
	Tue, 15 Feb 2011 08:12:24 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166847>

This also removes the superfluous "specify" and rewords the misleading
"if any" which sounds as if omitting "-m" would omit the merge commit
message. (It means "if a merge commit is created at all".)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c |    2 +-
 builtin/merge.c  |    4 ++--
 builtin/tag.c    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0245d9f..0090571 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -121,7 +121,7 @@ static struct option builtin_commit_options[] = {
 	OPT_FILENAME('F', "file", &logfile, "read message from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_STRING(0, "date", &force_date, "DATE", "override date for commit"),
-	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
+	OPT_CALLBACK('m', "message", &message, "MESSAGE", "commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_STRING(0, "fixup", &fixup_message, "COMMIT", "use autosquash formatted message to fixup specified commit"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 9403747..8c58c3c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -194,8 +194,8 @@ static struct option builtin_merge_options[] = {
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, "option=value",
 		"option for selected merge strategy", option_parse_x),
-	OPT_CALLBACK('m', "message", &merge_msg, "message",
-		"message to be used for the merge commit (if any)",
+	OPT_CALLBACK('m', "message", &merge_msg, "MESSAGE",
+		"merge commit message (for a non-fast-forward merge)",
 		option_parse_message),
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
diff --git a/builtin/tag.c b/builtin/tag.c
index 6408171..246a2bc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -376,8 +376,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Tag creation options"),
 		OPT_BOOLEAN('a', NULL, &annotate,
 					"annotated tag, needs a message"),
-		OPT_CALLBACK('m', NULL, &msg, "msg",
-			     "message for the tag", parse_msg_arg),
+		OPT_CALLBACK('m', NULL, &msg, "MESSAGE",
+			     "tag message", parse_msg_arg),
 		OPT_FILENAME('F', NULL, &msgfile, "read message from file"),
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', NULL, &keyid, "key-id",
-- 
1.7.4.1.74.gf39475.dirty
