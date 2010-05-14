From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 3/4] t6018: make sure all tested symbolic names are different revs
Date: Fri, 14 May 2010 20:26:51 +0200
Message-ID: <37d27fe11df8bf3dd5c053276ccc068b316717b2.1273861341.git.git@drmicha.warpmail.net>
References: <4BED7574.4070503@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 20:27:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCzbO-00071C-VO
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0ENS1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:27:01 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47132 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503Ab0ENS06 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 14:26:58 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1991DF7D14;
	Fri, 14 May 2010 14:26:58 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 May 2010 14:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=0YAR8txBC8Rsnu85xFw1hEmeV24=; b=tqwNOGT0/nbod9dqLgZXyzBKd+S6mrMo1QFzvP8Ktf4j/ASBY4bxWZ1rv7xL7bF84cqMNmXD9lTqIMSimqupLEHsBK5ok2eR/43O0Oqk8EtM0cppMLjdkWj3Da0g2mkDJkm5jKuAa0//RNs0Lr33ktUZ7ENNZqsF1cqyDmOBtC0=
X-Sasl-enc: x1kKqWUw+JY5SmBTcYOWKTjnOUetS6hb+NInSasvXscs 1273861616
Received: from localhost (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 137634CFCB3;
	Fri, 14 May 2010 14:26:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <4BED7574.4070503@drmicha.warpmail.net>
In-Reply-To: <cover.1273861341.git.git@drmicha.warpmail.net>
References: <cover.1273861341.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147107>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6018-rev-list-glob.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index dbedc4d..58428d9 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -34,7 +34,9 @@ test_expect_success 'setup' '
 	git checkout master &&
 	commit master2 &&
 	git tag foo/bar master &&
-	git update-ref refs/remotes/foo/baz master
+	commit master3 &&
+	git update-ref refs/remotes/foo/baz master &&
+	commit master4
 '
 
 test_expect_success 'rev-parse --glob=refs/heads/subspace/*' '
-- 
1.7.1.240.geeaa4d
