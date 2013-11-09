From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 40/86] environment: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:33 +0100
Message-ID: <20131109070720.18178.63707.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gp-0004XO-Pw
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933348Ab3KIHK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:26 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36374 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933273Ab3KIHIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:37 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 7A90C97;
	Sat,  9 Nov 2013 08:08:36 +0100 (CET)
X-git-sha1: 74a9076110e21acb469f189857ce4a544e05e435 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237517>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 378254c..827c6e8 100644
--- a/environment.c
+++ b/environment.c
@@ -176,7 +176,7 @@ const char *get_git_namespace(void)
 
 const char *strip_namespace(const char *namespaced_ref)
 {
-	if (prefixcmp(namespaced_ref, get_git_namespace()) != 0)
+	if (!has_prefix(namespaced_ref, get_git_namespace()))
 		return NULL;
 	return namespaced_ref + namespace_len;
 }
-- 
1.8.4.1.566.geca833c
