From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/3] t6009: use test_commit() from test-lib.sh
Date: Mon, 21 Mar 2011 11:14:05 +0100
Message-ID: <1f39cb4a4fc02a50fa869bef412ea0f2a527e480.1300702130.git.git@drmicha.warpmail.net>
References: <4D870157.2070309@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 11:14:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1c7s-0007Ec-Nb
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab1CUKOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:14:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54947 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab1CUKOK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 06:14:10 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5653B205DD;
	Mon, 21 Mar 2011 06:14:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 21 Mar 2011 06:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=C3wOZ2EWjc7A5J+IP3TwCm304os=; b=ZQzzlK1CMN7MGabruw4CtF0LnKupFv5GYHQL+pGwl6WV7Ro1rqL8Q1d+QiybQGeDySfhoXC6e81NVh9GiZbQUaOChChu0DHoErQxdLSi/55wbIgJiCKMrws6FnDeYulHZiRu7m8mv/b0sOPDwNBlZvEof/YJM+1Lnu+iX1n2YNk=
X-Sasl-enc: PBHx9R0Nxxh2o6zyIQPJceHtZXl8H3yOEtYmSM4ubxoN 1300702449
Received: from localhost (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A1F9D441B38;
	Mon, 21 Mar 2011 06:14:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <4D870157.2070309@drmicha.warpmail.net>
In-Reply-To: <cover.1300702130.git.git@drmicha.warpmail.net>
References: <cover.1300702130.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169575>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6009-rev-list-parent.sh |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 52f7b27..0f0e457 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -4,25 +4,18 @@ test_description='properly cull all ancestors'
 
 . ./test-lib.sh
 
-commit () {
-	test_tick &&
-	echo $1 >file &&
-	git commit -a -m $1 &&
-	git tag $1
-}
-
 test_expect_success setup '
 
 	touch file &&
 	git add file &&
 
-	commit one &&
+	test_commit one &&
 
 	test_tick=$(($test_tick - 2400)) &&
 
-	commit two &&
-	commit three &&
-	commit four &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four &&
 
 	git log --pretty=oneline --abbrev-commit
 '
-- 
1.7.4.1.511.g72e46
