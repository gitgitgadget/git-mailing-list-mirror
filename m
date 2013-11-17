From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 40/86] environment: replace prefixcmp() with starts_with()
Date: Sun, 17 Nov 2013 23:06:32 +0100
Message-ID: <20131117220719.4386.73779.chriscool@tuxfamily.org>
References: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisUU-0002aL-QO
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3KSVFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:05:41 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:59016 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab3KSVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:05:33 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 239895F;
	Tue, 19 Nov 2013 22:05:32 +0100 (CET)
X-git-sha1: 722f205c8f28efff9b9718dd6622760f5f2dec7e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238047>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 378254c..1270278 100644
--- a/environment.c
+++ b/environment.c
@@ -176,7 +176,7 @@ const char *get_git_namespace(void)
 
 const char *strip_namespace(const char *namespaced_ref)
 {
-	if (prefixcmp(namespaced_ref, get_git_namespace()) != 0)
+	if (!starts_with(namespaced_ref, get_git_namespace()))
 		return NULL;
 	return namespaced_ref + namespace_len;
 }
-- 
1.8.4.1.561.g12affca
