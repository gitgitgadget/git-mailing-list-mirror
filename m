From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] t1020: test !alias in subdirectory
Date: Wed, 27 Apr 2011 10:36:26 +0200
Message-ID: <3422485b672000ecdc72d82ffce8c89f258831b9.1303893279.git.git@drmicha.warpmail.net>
References: <4DB7CF72.3080205@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Matej Batic <matej.batic@ge.infn.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0Ef-0006iY-Nk
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab1D0Igd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:36:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43672 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754811Ab1D0Ig3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 04:36:29 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 44F6820729;
	Wed, 27 Apr 2011 04:36:29 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 27 Apr 2011 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=awromdF+vRfc1w52uGxzSjNClCg=; b=szqqqqlL/zqjK06ei4ZSo6GUgdIqIPnu3IMoKOZceFkpZ4uq+dngxHUFMZLX97Dt3Zktk2orCSyzORXHiBTA66Y/syOcKbEm+qK3CTpw4zrrioBb4mGuuHZ8+ws9JDDn5tir0XNkBBtQMh0khTA5mlllwBk7SzWTptUsrm9CaeQ=
X-Sasl-enc: uPoyi9P9nFhwzj/ksKt8QzKpQPNf/O5lzKapmNY+jjJP 1303893388
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B44A5403E27;
	Wed, 27 Apr 2011 04:36:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
In-Reply-To: <4DB7CF72.3080205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172197>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t1020-subdirectory.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 1fd187c..66e40d3 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -118,6 +118,17 @@ test_expect_success 'alias expansion' '
 		git ss
 	)
 '
+
+test_expect_success '!alias expansion' '
+	pwd >expect &&
+	(
+		git config alias.test !pwd &&
+		cd dir &&
+		git test >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
-- 
1.7.5.270.gafca7
