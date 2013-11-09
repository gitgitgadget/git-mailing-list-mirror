From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 38/86] pager: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:31 +0100
Message-ID: <20131109070720.18178.37111.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gp-0004XO-8H
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346Ab3KIHKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:23 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65462 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933274Ab3KIHIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:37 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id A247DA7;
	Sat,  9 Nov 2013 08:08:35 +0100 (CET)
X-git-sha1: 7d5642925116e3ebbfee18c6aeb295663f59df69 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237515>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pager.c b/pager.c
index fa19765..cd7bc43 100644
--- a/pager.c
+++ b/pager.c
@@ -151,7 +151,7 @@ int decimal_width(int number)
 static int pager_command_config(const char *var, const char *value, void *data)
 {
 	struct pager_config *c = data;
-	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, c->cmd)) {
+	if (has_prefix(var, "pager.") && !strcmp(var + 6, c->cmd)) {
 		int b = git_config_maybe_bool(var, value);
 		if (b >= 0)
 			c->want = b;
-- 
1.8.4.1.566.geca833c
