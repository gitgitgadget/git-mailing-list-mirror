From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 12/15] fast-export: trivial cleanup
Date: Sun, 11 Nov 2012 14:59:49 +0100
Message-ID: <1352642392-28387-13-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6M-0007td-GY
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2KKOBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:17 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:16 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ihVHQcm/ysQ3Rsr4S3UI/qUQjVGPoVzQdbQdV/ULl/E=;
        b=JSpe/SieSFzQx8pQyfpm+nKz0X2BR2OwLHK+3BFu2Zdm54gCCvIcOvyOtFQgINIWht
         QBoigH+znKIpUswzqKfKadbwT+akFVr3Mh1oNx7ZvPKkGtS0JD/mqUI2amw3ZoGWvjGR
         F/D08bZta5vWaa55MAdGiMSyX1GIrHShiywkEdetl/0Urf6r2ZHWZDB3tvXTE99ZbPLq
         dV1KF8RkG6LWPGp4IkPvfrZbBJJRwIDK5QgCvDm99QmIislVpwERrtjyhVDj/et3jBPG
         xO1+2W1+/l0nnOXSIPkxi2ewOceTELXWOctl9UJh8YZoaRvq32yFVlslk6gcODBzfmrI
         leCA==
Received: by 10.204.128.138 with SMTP id k10mr6095236bks.27.1352642475945;
        Sun, 11 Nov 2012 06:01:15 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id n27sm1495258bkw.0.2012.11.11.06.01.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209367>

Setting 'commit' to 'commit' is a no-op. It might have been there to
avoid a compiler warning, but if so, it was the compiler to blame, and
it's certainly not there any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a06fe10..4f3c35f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -483,7 +483,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	for (i = 0; i < pending->nr; i++) {
 		struct object_array_entry *e = pending->objects + i;
 		unsigned char sha1[20];
-		struct commit *commit = commit;
+		struct commit *commit;
 		char *full_name;
 
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
-- 
1.8.0
