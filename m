From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/14] fast-export: trivial cleanup
Date: Fri,  2 Nov 2012 03:02:15 +0100
Message-ID: <1351821738-17526-12-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bW-00018E-Km
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992639Ab2KBCDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992462Ab2KBCDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:12 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ihVHQcm/ysQ3Rsr4S3UI/qUQjVGPoVzQdbQdV/ULl/E=;
        b=K7htPO+PN4VdNDUEm65uxT/7g7dDLcH2bTM5bU7xgnzazBX/Y8tAUcLu3K0ugyTjfd
         xVkBjBWxLBwgPBmSuJF9tg3/eK6aNtebnBcDo1WwKsU3a6udkdxRL2aaaqQgAan/gOcq
         nMvuq7N/wLUDY0ei2GSwsuS5rzdo7p+zxQaLaPQIE95+Gx/sK+FNWq5flIaknPvSwblp
         aW4HvBqIbLJA8O9T/hd2Oz2qNp53oGSzWZ9+gIcAVOO3WHpKpW9HOftr3XYw0Faf4Dhw
         Kag6kKwxAJG5vTdlpBJAs4Hw3z3D9xhzuhRGYU+vFieWA3HoIN2nYNVx63sn8jFyQdrV
         OXeQ==
Received: by 10.204.9.3 with SMTP id j3mr27297bkj.15.1351821791875;
        Thu, 01 Nov 2012 19:03:11 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id 1sm5773001bks.3.2012.11.01.19.03.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:03:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208907>

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
