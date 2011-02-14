From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] pull: do not display fetch usage on --help-all
Date: Mon, 14 Feb 2011 17:48:08 +0100
Message-ID: <c98bbd60ccdbe059811280e09951100611487ccf.1297702066.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 17:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp1dx-0001Xt-T6
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 17:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab1BNQvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 11:51:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37706 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756051Ab1BNQvN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 11:51:13 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E57CB208D8;
	Mon, 14 Feb 2011 11:51:12 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 14 Feb 2011 11:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=AMMKHSHGyp3WoC3UFnrYUdaENkw=; b=Jbcm/wH2cABgqyDlmzmO35KSovhOttHFkXNH1NtGkcsHdsAlM8uiYm2O9rIbYL3Wzd6bhrHjE+zn+J+2o4OIppYv2Yw+cGRz6WBfRQ5s0S2TR1mXl2PKg+HZX+BFEb/UIUacYWKvQk1KeldhiO5H40XTFmwlxTGm4aGARLVxf3s=
X-Sasl-enc: w2+UkkxmO7acmMv4pFOV/3u/X/9U1as9s8Hr7kL4FaZV 1297702272
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6F81444254E;
	Mon, 14 Feb 2011 11:51:12 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166734>

Currently, "git pull --help-all" displays the fetch usage info.

Make it equivalent to "git pull -h" instead since "--help-all" is
documented in gitcli(7).

Do not try to sanitize the pull option parser (aka last hair puller).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index eb87f49..f6b7b84 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -114,7 +114,7 @@ do
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
-	-h|--h|--he|--hel|--help)
+	-h|--h|--he|--hel|--help|--help-|--help-a|--help-al|--help-all)
 		usage
 		;;
 	*)
-- 
1.7.4.1.74.gf39475.dirty
