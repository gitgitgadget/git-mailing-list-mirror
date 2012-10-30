From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 14/14] remote-hg: add extra author test
Date: Tue, 30 Oct 2012 05:35:36 +0100
Message-ID: <1351571736-4682-15-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:37:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Zd-0006kT-84
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab2J3Eg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:58 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2J3Eg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:57 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PIr+i21kyLtYdA2UcpgY/wK8On3tYsXXADeiReTQbZw=;
        b=PRbbGz+KsdX9xme5ZPp71tXIQvaEtezFwexvl9EJkZoNAL6IvMQgq13wMaT+tXZrPh
         FHffYKPYOp4jHUqajHWaqM2PT6eY2czrzZyeJa5tOO4vxgw5Ax1AhyAHCkd4odhXove0
         7vXOP5e8LBQDdLr5ZkCC0oRLcE2rJIN3NjzIYsGatyb5euj45EoCCqSJYySVPcPDzTtj
         qq/ZVTUNPdlOeOmLAx71wswG4y2k2HY0KoGp8eQOxuAvoG2TM8AHHS+bQICepgkS6HYl
         hEpgpRzPaagw6abni+f20NApzXkQY4wFI/+S1murTw0TGgRCftFjmERFbhPzbdrM+u8r
         S4hw==
Received: by 10.204.149.10 with SMTP id r10mr9674011bkv.61.1351571816357;
        Mon, 29 Oct 2012 21:36:56 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id x13sm5182056bkv.16.2012.10.29.21.36.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208676>

For hg.hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/test-hg-git.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-hg/test-hg-git.sh b/contrib/remote-hg/test-hg-git.sh
index 2b7acb0..a9f5cb2 100755
--- a/contrib/remote-hg/test-hg-git.sh
+++ b/contrib/remote-hg/test-hg-git.sh
@@ -368,7 +368,11 @@ test_expect_success 'hg author' '
 
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
