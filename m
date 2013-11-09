From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 80/86] builtin/symbolic-ref: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:13 +0100
Message-ID: <20131109070720.18178.41674.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l4-00014x-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481Ab3KIHO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:59 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33990 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab3KIHOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:24 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8C6C171;
	Sat,  9 Nov 2013 08:14:22 +0100 (CET)
X-git-sha1: 929fb14976ef70e44024f3c24e0e39f9650d547c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237547>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/symbolic-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index f481959..868fab4 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -65,7 +65,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		break;
 	case 2:
 		if (!strcmp(argv[0], "HEAD") &&
-		    prefixcmp(argv[1], "refs/"))
+		    !has_prefix(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
 		create_symref(argv[0], argv[1], msg);
 		break;
-- 
1.8.4.1.566.geca833c
