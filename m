From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 66/86] builtin/merge-recursive: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:06:59 +0100
Message-ID: <20131109070720.18178.38648.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lx-00028y-GI
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992Ab3KIHPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:54 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37711 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758665Ab3KIHOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:17 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8900B66;
	Sat,  9 Nov 2013 08:14:16 +0100 (CET)
X-git-sha1: 64a8027e608642699c1b399f51df5ff42bbc3681 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237564>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index e7f1a39..73896dc 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -38,7 +38,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; ++i) {
 		const char *arg = argv[i];
 
-		if (!prefixcmp(arg, "--")) {
+		if (has_prefix(arg, "--")) {
 			if (!arg[2])
 				break;
 			if (parse_merge_opt(&o, arg + 2))
-- 
1.8.4.1.566.geca833c
