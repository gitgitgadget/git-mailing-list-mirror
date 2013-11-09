From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 35/86] alias: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:28 +0100
Message-ID: <20131109070720.18178.88863.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gY-0004Ea-UF
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338Ab3KIHKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:16 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54193 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933278Ab3KIHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 65C698F;
	Sat,  9 Nov 2013 08:08:34 +0100 (CET)
X-git-sha1: f42361fc03f227d40a037f5d2af44b0adbf52db2 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237513>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alias.c b/alias.c
index eb9f08b..0933c87 100644
--- a/alias.c
+++ b/alias.c
@@ -5,7 +5,7 @@ static char *alias_val;
 
 static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
-	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
+	if (has_prefix(k, "alias.") && !strcmp(k+6, alias_key)) {
 		if (!v)
 			return config_error_nonbool(k);
 		alias_val = xstrdup(v);
-- 
1.8.4.1.566.geca833c
