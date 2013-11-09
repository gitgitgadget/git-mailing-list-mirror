From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 73/86] builtin/reflog: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:06 +0100
Message-ID: <20131109070720.18178.65381.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lO-0001Sp-FH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758710Ab3KIHPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:18 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33964 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758687Ab3KIHOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:20 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 817153A;
	Sat,  9 Nov 2013 08:14:19 +0100 (CET)
X-git-sha1: 97801e4dcc9fa407a48da9c3161641976db7321d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237555>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/reflog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6eb24c8..f1a2578 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -610,12 +610,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
-		else if (!prefixcmp(arg, "--expire=")) {
+		else if (has_prefix(arg, "--expire=")) {
 			if (parse_expiry_date(arg + 9, &cb.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
-		else if (!prefixcmp(arg, "--expire-unreachable=")) {
+		else if (has_prefix(arg, "--expire-unreachable=")) {
 			if (parse_expiry_date(arg + 21, &cb.expire_unreachable))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_UNREACH;
-- 
1.8.4.1.566.geca833c
