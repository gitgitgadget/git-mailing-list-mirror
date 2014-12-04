From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 1/2] t3200-branch: test -M
Date: Thu,  4 Dec 2014 14:26:44 +0100
Message-ID: <4522a9a6606467e130c2430d717286c92c777b6f.1417699299.git.git@drmicha.warpmail.net>
References: <cover.1417699299.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 14:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwWQv-0005nv-SV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 14:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbaLDN0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 08:26:51 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35193 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753933AbaLDN0t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 08:26:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2602220A9B
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 08:26:49 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 04 Dec 2014 08:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=JLY6wkNDqjiv5D
	JgTiRM38UYrfc=; b=gLRPaRHVVFPsl9YwHUtg9BBDdlWf4iovdYeLy9WOIbtJpA
	ViaOo53qXfoYYQEdz6jpyjN8ZgMLC7Siu3ygLxWB541tR3e/cah8Vd9ALbkdc4dO
	20hELPDwAuoicJn8yJMKkz3s6E9t8qwlu6AiT1NAVKlHuGnj0Qr1W4N7c78nk=
X-Sasl-enc: 5swcMYRzjqSGt1oXR+GJuCHTIonqt+cEiMhRiOy4D8Ul 1417699608
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BCF4AC00280;
	Thu,  4 Dec 2014 08:26:48 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc3.286.g888a711
In-Reply-To: <cover.1417699299.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260758>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3200-branch.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 432921b..0b3b8f5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -97,6 +97,15 @@ test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	test_must_fail git branch -m o/o o
 '
 
+test_expect_success 'git branch -m o/q o/p should fail when o/p exists' '
+	git branch o/q &&
+	test_must_fail git branch -m o/q o/p
+'
+
+test_expect_success 'git branch -M o/q o/p should work when o/p exists' '
+	git branch -M o/q o/p
+'
+
 test_expect_success 'git branch -m q r/q should fail when r exists' '
 	git branch q &&
 	git branch r &&
-- 
2.2.0.rc3.286.g888a711
