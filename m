From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] t3200-branch: test -M
Date: Mon,  8 Dec 2014 17:28:44 +0100
Message-ID: <4f734d9f44bd6aa1b54ca3f81aa0e3822286f9d9.1418055912.git.git@drmicha.warpmail.net>
References: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1BC-00056B-B2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbaLHQ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:28:50 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59190 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbaLHQ2s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:28:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 499F32061D
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:28:48 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Dec 2014 11:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=7wmY4z0V7cfUdh2ZfVOKuRzy/7Y=; b=TbIdKChlQJDv7br0u/lN
	Qk9xAga3cAg4RGA/NwoneGEshnp4NxKAKhyTHnNByZf1/b68jWNs1Md1PcM3wzh+
	7mJeFNJsKPnspnUiRPaLOe4jogvfNSzuy18RriiXSZnxfi0Oo+guroD6EAfAX5nR
	jNop/PxGXg+C86XL0wqY4/I=
X-Sasl-enc: +qo4MeRkJQLgUq4hyHDy8M3T87raN/dhJhb9Y6myvbhW 1418056127
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DE21FC00280;
	Mon,  8 Dec 2014 11:28:47 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1418055912.git.git@drmicha.warpmail.net>
References: <cover.1418055912.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261074>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.2.0.345.g7041aac
