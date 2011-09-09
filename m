From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t3200: test branch creation with -v
Date: Fri,  9 Sep 2011 21:40:59 +0200
Message-ID: <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
References: <20110909193033.GA31184@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 21:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26wr-0007JT-3T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759867Ab1IITlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:41:07 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:57881 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759687Ab1IITlF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 15:41:05 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0184A2557E;
	Fri,  9 Sep 2011 15:41:05 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 09 Sep 2011 15:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=VfSsiOqtm5Hvul4trNfVDr6mG
	zY=; b=K8kcNfl156FfbvjiV0OB4WlTZpbCx3yuRPu5PbrVWXajDEXWoeaXEiqEM
	Go8fcIVEPI4yrizgxE+VdqZhBniXQ5/SVQ3XCqsacxHoKqe/0jbR9p85+t20+Ib5
	w106TOulIUxmkMQ0GDz/G9xmQGjkrKzsUoiMMrIot3xVmW6do0=
X-Sasl-enc: 9VjQzoYoXVEEKSdFidvvx2kVglccDvfIB2LttUCoxg08 1315597263
Received: from localhost (p548594B4.dip0.t-ipconnect.de [84.133.148.180])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EFD857806A4;
	Fri,  9 Sep 2011 15:41:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <20110909193033.GA31184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181114>

Make sure that "git branch -v t" creates branch "t".

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3200-branch.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c466b20..8381f0c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -105,6 +105,13 @@ test_expect_success 'git branch -v -d t should work' '
 	test ! -f .git/refs/heads/t
 '
 
+test_expect_success 'git branch -v t should work' '
+	git branch -v t &&
+	test .git/refs/heads/t &&
+	git branch -d t &&
+	test ! -f .git/refs/heads/t
+'
+
 test_expect_success 'git branch -v -m t s should work' '
 	git branch t &&
 	test .git/refs/heads/t &&
-- 
1.7.7.rc0.469.g9eb94
