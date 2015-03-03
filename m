From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] t7508: test git status -v
Date: Tue,  3 Mar 2015 15:16:21 +0100
Message-ID: <4979bf9de04197c1cd0d4a6af1348b45d4b0894c.1425390756.git.git@drmicha.warpmail.net>
References: <54B8C82E.8000707@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 15:16:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSncn-0007eH-34
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 15:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbbCCOQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 09:16:27 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42068 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754819AbbCCOQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 09:16:26 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 503FA20C20
	for <git@vger.kernel.org>; Tue,  3 Mar 2015 09:16:24 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 03 Mar 2015 09:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=jZXbMwZ6p6Lg8KKrISfE+QXFak4=; b=Z9dwx/dgQnuHY3SIN2SI
	+nz4pPEyQi+BsARQeDSOK89/GUPY1fBwyoWeGmqh6VB4frhjq0yMz0SjkUsXexPW
	sLpLT7DU6rGzbxXy1yCrUF3SpY0K12LkfzFyX3tnRjvmwKW3nGE7SES6iAuoHep/
	0wKuvAIZWywDgEVNeKQvLxc=
X-Sasl-enc: ey0qKhPRNBOslrbkeKrtPc5+rkIpSAKTe7cLJm9Y3Gc/ 1425392185
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 07C2168019E;
	Tue,  3 Mar 2015 09:16:24 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54B8C82E.8000707@drmicha.warpmail.net>
In-Reply-To: <cover.1425390756.git.git@drmicha.warpmail.net>
References: <cover.1425390756.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264660>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8ed5788..4989e98 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -133,6 +133,12 @@ test_expect_success 'status with status.displayCommentPrefix=false' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'status -v' '
+	git diff --cached >>expect &&
+	git status -v >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'setup fake editor' '
 	cat >.git/editor <<-\EOF &&
 	#! /bin/sh
-- 
2.3.1.303.g5174db1
