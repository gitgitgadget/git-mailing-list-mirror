From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 13/13] remote-hg: add extra author test
Date: Sun, 28 Oct 2012 04:54:13 +0100
Message-ID: <1351396453-29042-14-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:56:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJyk-0003mE-9A
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab2J1Dzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:55:47 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab2J1Dzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:46 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vuPv5983rB/lrMhGH3U3IVOEn/3iAcZ4N9mCAeqXcYs=;
        b=BIqXAdQnJgsG1HMdGAZYnv0T5CO8QJ8o3Q5jN3HAKBx9vGlutKeGQffsoG231HW1WY
         UCyeqBxjAmGmyJetL2b7uED7wLmeBf64w2A89j4eCIKKfrgIkm2xeBYN+ZUZBZnaHjzc
         OjqSmVorwJPze7JWcW+O600UJgNQ14WqcKsH1Nleh9sGaW9RxlIMQZwyDOQxghfSEDXa
         NUVT0oH5vcr8rSCzoKoyDfFbagf6Y1WxMzKhK/sk4L3ZIYk7ErnmgobXh0oaDP57G+UD
         1XCGXtygYmbXYEq1yNsbfa2eloQVzT6UG/JCZSgYI32h/OOekc6gpXqWTBs3oS1p9FVW
         b4ng==
Received: by 10.14.173.137 with SMTP id v9mr34572028eel.41.1351396545947;
        Sat, 27 Oct 2012 20:55:45 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id a44sm13231458eeo.7.2012.10.27.20.55.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208531>

For hg.hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5802-remote-hg-hg-git.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5802-remote-hg-hg-git.sh b/t/t5802-remote-hg-hg-git.sh
index 3cfa9e6..1f9f85c 100755
--- a/t/t5802-remote-hg-hg-git.sh
+++ b/t/t5802-remote-hg-hg-git.sh
@@ -353,7 +353,11 @@ test_expect_success 'hg author' '
 
 		echo theta > theta &&
 		hg add theta &&
-		hg commit -u "test >test@example.com>" -m "add theta"
+		hg commit -u "test >test@example.com>" -m "add theta" &&
+
+		echo iota > iota &&
+		hg add iota &&
+		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
 		) &&
 
 		hg_push_$x hgrepo-$x gitrepo-$x &&
-- 
1.8.0
