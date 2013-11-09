From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 37/86] connect: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:30 +0100
Message-ID: <20131109070720.18178.47748.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gu-0004XO-5P
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340Ab3KIHKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:18 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54121 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933277Ab3KIHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:38 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 3C82B91;
	Sat,  9 Nov 2013 08:08:35 +0100 (CET)
X-git-sha1: ed91bad201d33c24fd2b2ab02ade4c6af6a5b657 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237520>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 4086861..1cb4090 100644
--- a/connect.c
+++ b/connect.c
@@ -87,7 +87,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		if (!len)
 			break;
 
-		if (len > 4 && !prefixcmp(buffer, "ERR "))
+		if (len > 4 && has_prefix(buffer, "ERR "))
 			die("remote error: %s", buffer + 4);
 
 		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] != ' ')
-- 
1.8.4.1.566.geca833c
