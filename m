From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 85/86] builtin/upload-archive: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:18 +0100
Message-ID: <20131109070720.18178.40165.chriscool@tuxfamily.org>
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
	id 1Vf2lN-0001Sp-BW
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933462Ab3KIHOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:50 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37758 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933467Ab3KIHO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:26 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id AC23E83;
	Sat,  9 Nov 2013 08:14:24 +0100 (CET)
X-git-sha1: 987403a36dab1ebc518fc478c9802214a2e4aa27 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237556>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/upload-archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index af2da35..298bc76 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -37,7 +37,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 		if (sent_argv.argc > MAX_ARGS)
 			die("Too many options (>%d)", MAX_ARGS - 1);
 
-		if (prefixcmp(buf, arg_cmd))
+		if (!has_prefix(buf, arg_cmd))
 			die("'argument' token or flush expected");
 		argv_array_push(&sent_argv, buf + strlen(arg_cmd));
 	}
-- 
1.8.4.1.566.geca833c
