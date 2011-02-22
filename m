From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH (n+1)/n] t6007: test rev-list --cherry
Date: Tue, 22 Feb 2011 14:36:19 +0100
Message-ID: <679a1a3a57bd6b5f4138a1e0500ec8f97f224578.1298381698.git.git@drmicha.warpmail.net>
References: <7vlj18g92x.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 14:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrsSr-0005d9-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 14:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab1BVNjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 08:39:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57501 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab1BVNjg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 08:39:36 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 564C82078C;
	Tue, 22 Feb 2011 08:39:35 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 22 Feb 2011 08:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=mBFmn2OEIl5Y90rDKXsUmswFHLA=; b=Qg9TAXTz9+JxVxLmR+jVIkpV4JJVo6TNLnMkHORhu2zwwTpXL8CFoyI8mXmqMJPeYdxjxDxUNSQTQy87mcof0SVq77782Yv14s2y0mwRiTAHAI4ejGPW8xLGgPlt1Oa08Cg/IjvfZ7t5FS8rajoAlTzd6kA4d6m+Jz7sF7yA0R4=
X-Sasl-enc: rzD4g0y7JCkSAMLDnrKlITcN23zMhJ9n+ile4+261E0I 1298381974
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D058E443A81;
	Tue, 22 Feb 2011 08:39:34 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <7vlj18g92x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167543>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6007-rev-list-cherry-pick-file.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index cd089a9..5373541 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -110,6 +110,13 @@ test_expect_success '--cherry-pick --right-only' '
 	test_cmp actual.named expect
 '
 
+test_expect_success '--cherry' '
+	git rev-list --cherry F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
 test_expect_success '--cherry-pick --left-only' '
 	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
-- 
1.7.4.1.74.gf39475.dirty
