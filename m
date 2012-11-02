From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/14] remote-testgit: remove irrelevant test
Date: Fri,  2 Nov 2012 03:02:10 +0100
Message-ID: <1351821738-17526-7-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bB-0000fm-09
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965796Ab2KBCCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965791Ab2KBCCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:53 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ChpNFLW5jOyHW3RdrpEK2K50Dyqc9FrPLxbeDWlYE24=;
        b=zBb0HPDv1Zax1mkt64mSphjIx3BaDW9A5UDldLP3azS3GxG4Q4TD4B481CiqLMESNr
         SttWvl2ues1NdplbhnNPt0HSEDSBAY80ixCQaJB7hvqCeIx4OLfg8Ana0HWQki2f4ZPE
         dEAIXOlivLzux8Hav2Osu5KS5SfqDUuMkDVLGUCR1u2eO5Ynfrt9vYruS5fhd9Zn0vUY
         /L1Sfq/NcSTXT5n7qzSbtIToqRYrfQ2Aekl3dGTw1j20HiGW5TmVZ2nGwGsCvm1jEnde
         oaRX+DZVo5wuq/Y/l4OJts6FCvV3B8POQXaWJC3l/R0gEXLjzH820dEtO+GX7/77BpCy
         w6mA==
Received: by 10.204.8.141 with SMTP id h13mr24386bkh.54.1351821772480;
        Thu, 01 Nov 2012 19:02:52 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id z22sm5773927bkw.2.2012.11.01.19.02.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208900>

Only makes sense for remote-testpy.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 2eca42e..a03d087 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -48,19 +48,6 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
-# Generally, skip this test.  It demonstrates a now-fixed race in
-# git-remote-testgit, but is too slow to leave in for general use.
-: test_expect_success 'racily pushing to local repo' '
-	test_when_finished "rm -rf server2 localclone2" &&
-	cp -R server server2 &&
-	git clone "testgit::${PWD}/server2" localclone2 &&
-	(cd localclone2 &&
-	echo content >>file &&
-	git commit -a -m three &&
-	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
-	compare_refs localclone2 HEAD server2 HEAD
-'
-
 test_expect_success 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
-- 
1.8.0
