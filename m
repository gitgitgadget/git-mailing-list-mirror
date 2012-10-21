From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/6] tests: fix remote-hg warnings for modern git
Date: Sun, 21 Oct 2012 19:49:04 +0200
Message-ID: <1350841744-21564-7-git-send-email-felipe.contreras@gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 19:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzf7-0002zW-2V
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab2JURt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:57 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34362 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420Ab2JURt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:56 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so1546732wib.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6/Ka+pRMtWT7iEgMgjGLPu3+f+g++FNimVHaH77ZDGE=;
        b=zMBvgTgZO9ulP1BAk2bCBIy35t/rQv5hwCJ10+6E2FjkCjIilPFYrHX1Zn6z0t9WoU
         kx9f6S7wOgah6xt6OS2KLli8IV7cRFCsoKEeDxiSJ7rorUFR/lh6N7iG1wUV9gW57RZH
         Q7NwCvU06oBSdAelaggmaEUGiT0sV9YV1Zvg0x7rXrYTbNsnljis707PDOiG/UGcjsxg
         NMpmJdfRAiCEKc6yNBrmqP25RH73KVnhEJXc9QIHztwiuR6nVd70Le74A+vfNuWZMP5I
         UxC2MeEfZBt0UTrHQ6ke8WsM6F4io3pGtVaertcZ8iq0wvkiC+Fq75+VO/QwelWGoWx5
         q9bA==
Received: by 10.180.83.101 with SMTP id p5mr15900130wiy.2.1350841795974;
        Sun, 21 Oct 2012 10:49:55 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id v3sm17153353wiy.5.2012.10.21.10.49.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208134>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-hg.sh b/t/t5801-remote-hg.sh
index 2e68372..ba4d7a2 100755
--- a/t/t5801-remote-hg.sh
+++ b/t/t5801-remote-hg.sh
@@ -95,7 +95,7 @@ test_expect_success 'pushing to local repo' '
 	(cd localclone &&
 	echo content >>file &&
 	git commit -a -m three &&
-	git push) &&
+	git push --all) &&
 	(cd server &&
 	hg up tip) &&
 	vcs_cmp localclone server
@@ -110,7 +110,7 @@ test_expect_success 'pushing remote local repo' '
 	(cd clone &&
 	echo content >>file &&
 	git commit -a -m four &&
-	git push) &&
+	git push --all) &&
 	(cd server &&
 	hg up tip) &&
 	vcs_cmp clone server
-- 
1.8.0.rc2.7.g0961fdf.dirty
