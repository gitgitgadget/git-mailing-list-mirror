From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/5] t6009: use test_commit() from test-lib.sh
Date: Wed, 23 Mar 2011 10:38:48 +0100
Message-ID: <1f39cb4a4fc02a50fa869bef412ea0f2a527e480.1300872923.git.git@drmicha.warpmail.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 10:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2KaJ-0008KH-0w
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 10:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab1CWJm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 05:42:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42377 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752373Ab1CWJm2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 05:42:28 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7B3A3203C4;
	Wed, 23 Mar 2011 05:42:28 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 05:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=C3wOZ2EWjc7A5J+IP3TwCm304os=; b=a0np7MRsAL2nu/l/WSu5aJsckzQhhlknGg3YzAUf8jytQfVRlR7i9R9l75V2XGWRj6OcBcexmYy8Mq/U46ZVmejMnNfWsjR4lIaKbnQCYw+7slcfA5TYTPb9sjoZau1FcCtD0lzVkO1EjGvi8zQMlr5X6dB7YFbWtepvzMWnNwc=
X-Sasl-enc: bVJ2YxLyN+XabR55x9tD/MPrptwx2RxhE42Z/W43lnMp 1300873348
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3A22408DD3;
	Wed, 23 Mar 2011 05:42:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <20110321105628.GC16334@sigill.intra.peff.net>
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net>
References: <cover.1300872923.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169806>

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
