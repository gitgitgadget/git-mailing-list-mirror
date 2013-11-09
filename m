From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 54/86] builtin/fast-export: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:06:47 +0100
Message-ID: <20131109070720.18178.44653.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fk-0003IA-RW
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320Ab3KIHJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:27 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54232 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933293Ab3KIHIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:44 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 644297B;
	Sat,  9 Nov 2013 08:08:42 +0100 (CET)
X-git-sha1: 912cb3beb6df9786d7aeffc22a5423bcb55d6308 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237497>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78250ea..8a9136b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -476,7 +476,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		}
 	}
 
-	if (!prefixcmp(name, "refs/tags/"))
+	if (has_prefix(name, "refs/tags/"))
 		name += 10;
 	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
 	       name, tagged_mark,
-- 
1.8.4.1.566.geca833c
