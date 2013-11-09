From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 84/86] builtin/update-ref: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:17 +0100
Message-ID: <20131109070720.18178.40463.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l2-00014x-DE
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933475Ab3KIHOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:51 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55738 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933466Ab3KIHO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:26 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 436777B;
	Sat,  9 Nov 2013 08:14:24 +0100 (CET)
X-git-sha1: 17a44a6fdc26865b38e0b9774565be9a92dea9d4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237545>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 702e90d..d81d959 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -229,15 +229,15 @@ static void update_refs_stdin(void)
 			die("empty command in input");
 		else if (isspace(*cmd.buf))
 			die("whitespace before command: %s", cmd.buf);
-		else if (!prefixcmp(cmd.buf, "update "))
+		else if (has_prefix(cmd.buf, "update "))
 			parse_cmd_update(cmd.buf + 7);
-		else if (!prefixcmp(cmd.buf, "create "))
+		else if (has_prefix(cmd.buf, "create "))
 			parse_cmd_create(cmd.buf + 7);
-		else if (!prefixcmp(cmd.buf, "delete "))
+		else if (has_prefix(cmd.buf, "delete "))
 			parse_cmd_delete(cmd.buf + 7);
-		else if (!prefixcmp(cmd.buf, "verify "))
+		else if (has_prefix(cmd.buf, "verify "))
 			parse_cmd_verify(cmd.buf + 7);
-		else if (!prefixcmp(cmd.buf, "option "))
+		else if (has_prefix(cmd.buf, "option "))
 			parse_cmd_option(cmd.buf + 7);
 		else
 			die("unknown command: %s", cmd.buf);
-- 
1.8.4.1.566.geca833c
