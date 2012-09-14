From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 09/11] t7810-grep: test multiple --author with --all-match
Date: Fri, 14 Sep 2012 11:46:41 +0200
Message-ID: <830d4a80bb229835b6b4898c3c4b8b2e0e17b056.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUd-0007Hv-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab2INJrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:47:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59963 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754568Ab2INJq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:59 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4F5DA2065F;
	Fri, 14 Sep 2012 05:46:59 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 Sep 2012 05:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ai
	9QRgmrRPBRPiXl8/n3jrs6ZRQ=; b=lxMhpPAZuy33vEwGbi5/mi1uubXV/+N43X
	oTUEfqMo5Y3XHHA3i2fCaVORA8FmUwYm5/9GBQX7hTTZYxUpJSGjM9u/mWfVnMyS
	T94IRf1si0oAdcXFKAY0ZfEhW3Oa0Ln9tjgK6csH0eQC8zE5XvwoUOxJMyaQTB1t
	Ich2FOAn4=
X-Sasl-enc: VQmDdCG+2DgRbyY7qvVWn+br51tkjfLjKGDPplMsT0b5 1347616018
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E42B08E03DB;
	Fri, 14 Sep 2012 05:46:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205475>

--all-match is ignored for author matching on purpose.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index b841909..be81d96 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -513,6 +513,14 @@ test_expect_success 'log with multiple --author uses union' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --all-match with multiple --author still uses union' '
+	git log --all-match --author="Thor" --author="Aster" --format=%s >actual &&
+	{
+	    echo third && echo second && echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log with --grep and multiple --author uses all-match' '
 	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
 	{
-- 
1.7.12.592.g41e7905
