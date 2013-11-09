From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 32/86] http-backend: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:25 +0100
Message-ID: <20131109070720.18178.24891.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hB-0004uI-R4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360Ab3KIHK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:57 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36282 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933265Ab3KIHIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:34 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 27D266E;
	Sat,  9 Nov 2013 08:08:33 +0100 (CET)
X-git-sha1: b9f336e6859a27a3f9f23d44b642ae747203573e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237523>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 http-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8c464bd..d0183b1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -226,7 +226,7 @@ static int http_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!prefixcmp(var, "http.")) {
+	if (has_prefix(var, "http.")) {
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
@@ -247,7 +247,7 @@ static struct rpc_service *select_service(const char *name)
 	struct rpc_service *svc = NULL;
 	int i;
 
-	if (prefixcmp(name, "git-"))
+	if (!has_prefix(name, "git-"))
 		forbidden("Unsupported service: '%s'", name);
 
 	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
-- 
1.8.4.1.566.geca833c
