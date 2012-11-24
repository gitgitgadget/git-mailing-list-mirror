From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 12/14] fast-export: trivial cleanup
Date: Sat, 24 Nov 2012 04:17:12 +0100
Message-ID: <1353727034-24698-13-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
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
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6GM-0002Mf-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636Ab2KXDSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:18:13 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab2KXDSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:18:10 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YaTprFuqIc4B80bLGqY11GDtZObbFgbD+guRTxljA4g=;
        b=g4FQ6S0pG1FGZDjDGkLFbrc/fl87p9oP8rQmnUvGOyt863SoSdcamEs/npLFokmfkQ
         Cgple1+n4aID0Wx2XZrF5xP/kQ8SA2p0rxJ/bAKlCY1xLxdjRoJoOXaw0fHq5X7rD/u0
         vnx+26eQb7qqfElYqBacXKO/0rcpPEF759uthO16AkbcuM1ng6y8WKn0Jbcj5pVBWmNv
         rM02eM5bRbwkcN9n7yIb6Gg2Juv2nnTP05ow8zeoRgSwLVofYY1CUwv69m5zahUGTHgY
         EE1pv6T2uGAkRDu+qzl9bvI4ZSkEdaCLy7KUVkiq8Z6dC6D30ogQe+6sNv+SrUSAReyK
         I0kw==
Received: by 10.204.5.205 with SMTP id 13mr1749512bkw.111.1353727089552;
        Fri, 23 Nov 2012 19:18:09 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id hm8sm2493717bkc.10.2012.11.23.19.18.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:18:08 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210298>

Setting 'commit' to 'commit' is a no-op. It might have been there to
avoid a compiler warning, but if so, it was the compiler to blame, and
it's certainly not there any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9b70ec1..191936c 100644
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
