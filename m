From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 76/86] builtin/send-pack: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:09 +0100
Message-ID: <20131109070720.18178.21433.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2kz-00014x-JW
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933469Ab3KIHOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:30 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33977 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932931Ab3KIHOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id CDD7781;
	Sat,  9 Nov 2013 08:14:20 +0100 (CET)
X-git-sha1: 4dbfd7195dd19d65835a332a96baa1082761b308 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237544>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/send-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4482f16..0c29e69 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -115,15 +115,15 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		const char *arg = *argv;
 
 		if (*arg == '-') {
-			if (!prefixcmp(arg, "--receive-pack=")) {
+			if (has_prefix(arg, "--receive-pack=")) {
 				receivepack = arg + 15;
 				continue;
 			}
-			if (!prefixcmp(arg, "--exec=")) {
+			if (has_prefix(arg, "--exec=")) {
 				receivepack = arg + 7;
 				continue;
 			}
-			if (!prefixcmp(arg, "--remote=")) {
+			if (has_prefix(arg, "--remote=")) {
 				remote_name = arg + 9;
 				continue;
 			}
@@ -181,7 +181,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 					exit(1);
 				continue;
 			}
-			if (!prefixcmp(arg, "--" CAS_OPT_NAME "=")) {
+			if (has_prefix(arg, "--" CAS_OPT_NAME "=")) {
 				if (parse_push_cas_option(&cas,
 							  strchr(arg, '=') + 1, 0) < 0)
 					exit(1);
-- 
1.8.4.1.566.geca833c
