From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 49/86] builtin/clean: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:42 +0100
Message-ID: <20131109070720.18178.14270.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gA-0003oQ-SO
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321Ab3KIHJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:38 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54224 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933290Ab3KIHIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:43 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 484B19F;
	Sat,  9 Nov 2013 08:08:40 +0100 (CET)
X-git-sha1: 92e50497ae997911eaf9edf2b9f8116bd01d24e4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237506>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clean.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 615cd57..98887cd 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -100,7 +100,7 @@ static int parse_clean_color_slot(const char *var)
 
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
-	if (!prefixcmp(var, "column."))
+	if (has_prefix(var, "column."))
 		return git_column_config(var, value, "clean", &colopts);
 
 	/* honors the color.interactive* config variables which also
@@ -109,7 +109,7 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		clean_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (!prefixcmp(var, "color.interactive.")) {
+	if (has_prefix(var, "color.interactive.")) {
 		int slot = parse_clean_color_slot(var +
 						  strlen("color.interactive."));
 		if (slot < 0)
-- 
1.8.4.1.566.geca833c
