From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] fixup! notes remove: --stdin reads from the standard input
Date: Thu, 19 May 2011 20:47:03 +0200
Message-ID: <19352322fc4fcbf59490ab2d812191a3fdc92acb.1305830419.git.git@drmicha.warpmail.net>
References: <4DD4C73C.7020600@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8Fi-0007NO-Td
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933956Ab1ESSrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:47:10 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33806 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933895Ab1ESSrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 14:47:09 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 06B9120689;
	Thu, 19 May 2011 14:47:09 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 19 May 2011 14:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=WsREFP3+Ns6TwjorCZo1ZM5E3zI=; b=IxeDOV1FcjRSydr3W19zrpVT5FFKjmMqSp3EEhsaaf4ciuUI5jcpn8DVG/NS3S5E1VEO4wwlbeyFgCxdmOnIhLk+EZ8o7SjqAsobn6dasmkXFmLeZHpAp5JB/ZKx3g7SQRJpNYGZFOzyzCVcTNBRsvIE5DR5a4HM82wjtvdXczc=
X-Sasl-enc: K58n3vJOMV6tB63NvQm6c9i4UYMDVbTR4zZRyzcLftn4 1305830828
Received: from localhost (p54858F0A.dip0.t-ipconnect.de [84.133.143.10])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4578B447834;
	Thu, 19 May 2011 14:47:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.558.gc8bec
In-Reply-To: <4DD4C73C.7020600@drmicha.warpmail.net>
In-Reply-To: <bdd14b3138e4d90de58945f25dcf33da027d9f07.1305830419.git.git@drmicha.warpmail.net>
References: <bdd14b3138e4d90de58945f25dcf33da027d9f07.1305830419.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173990>

Cheers :)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3301-notes.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1edb7bf..8462173 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -495,11 +495,11 @@ test_expect_success 'remove --stdin is also atomic' '
 	test "$before" = "$after"
 '
 
-test_expect_success 'removing with --stdin --missing-ok' '
+test_expect_success 'removing with --stdin --ignore-missing' '
 	before=$(git rev-parse --verify refs/notes/commits) &&
 	test_when_finished "git update-ref refs/notes/commits $before" &&
 	git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
-	git notes remove --missing-ok --stdin <input &&
+	git notes remove --ignore-missing --stdin <input &&
 	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
 	test 2 = $(wc -l <actual) &&
 	git ls-tree -r --name-only refs/notes/commits >actual &&
-- 
1.7.5.1.558.gc8bec
