From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 64/86] builtin/ls-remote: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:57 +0100
Message-ID: <20131109070720.18178.77768.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2mA-0002M0-H0
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029Ab3KIHQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:16:02 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37702 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758658Ab3KIHOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:16 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A93EB76;
	Sat,  9 Nov 2013 08:14:15 +0100 (CET)
X-git-sha1: 2bea64f75f101d90ec911242308ae898b43a7ba9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237566>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/ls-remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 25e83cf..9050072 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -50,11 +50,11 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!prefixcmp(arg, "--upload-pack=")) {
+			if (has_prefix(arg, "--upload-pack=")) {
 				uploadpack = arg + 14;
 				continue;
 			}
-			if (!prefixcmp(arg, "--exec=")) {
+			if (has_prefix(arg, "--exec=")) {
 				uploadpack = arg + 7;
 				continue;
 			}
-- 
1.8.4.1.566.geca833c
