From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 55/86] builtin/fetch-pack: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:06:48 +0100
Message-ID: <20131109070720.18178.20584.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fl-0003IA-Cy
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab3KIHJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:25 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65433 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933241Ab3KIHIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:44 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id C9F089C;
	Sat,  9 Nov 2013 08:08:42 +0100 (CET)
X-git-sha1: 0795472df3eac79c964f4a5041e61c35943de068 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237499>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c8e8582..29a3b33 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -48,11 +48,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc && *argv[i] == '-'; i++) {
 		const char *arg = argv[i];
 
-		if (!prefixcmp(arg, "--upload-pack=")) {
+		if (has_prefix(arg, "--upload-pack=")) {
 			args.uploadpack = arg + 14;
 			continue;
 		}
-		if (!prefixcmp(arg, "--exec=")) {
+		if (has_prefix(arg, "--exec=")) {
 			args.uploadpack = arg + 7;
 			continue;
 		}
@@ -85,7 +85,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.verbose = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--depth=")) {
+		if (has_prefix(arg, "--depth=")) {
 			args.depth = strtol(arg + 8, NULL, 0);
 			continue;
 		}
-- 
1.8.4.1.566.geca833c
