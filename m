From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 1/3] t5550: do not assume the "matching" push is the default
Date: Tue, 15 Jan 2013 21:05:06 -0500
Message-ID: <0b1d36198b986bbbf4f421032e793b5f4dbed5c3.1358301792.git.brian@gernhardtsoftware.com>
References: <cover.1358301792.git.brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIUo-0003OL-5G
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab3APCMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:12:33 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55696 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526Ab3APCMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:12:31 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 517DD1170089; Wed, 16 Jan 2013 02:06:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPA id BEE58117005D;
	Wed, 16 Jan 2013 02:06:09 +0000 (UTC)
X-Mailer: git-send-email 1.8.1.rc1.222.gec797b3
In-Reply-To: <cover.1358301792.git.brian@gernhardtsoftware.com>
In-Reply-To: <cover.1358301792.git.brian@gernhardtsoftware.com>
References: <cover.1358301792.git.brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213704>

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t5550-http-fetch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 80d20c8..f7d0f14 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -13,6 +13,7 @@ LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
 start_httpd
 
 test_expect_success 'setup repository' '
+	git config push.default matching &&
 	echo content1 >file &&
 	git add file &&
 	git commit -m one
-- 
1.8.1.rc1.222.gec797b3
