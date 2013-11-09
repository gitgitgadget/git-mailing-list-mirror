From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 41/86] shell: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:34 +0100
Message-ID: <20131109070720.18178.56673.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2go-0004XO-Mh
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344Ab3KIHKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:21 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36380 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933275Ab3KIHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:38 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id E1BDF34;
	Sat,  9 Nov 2013 08:08:36 +0100 (CET)
X-git-sha1: e01052d520b6be20ef6d5d08025b8e4cd4ebe6b4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237516>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shell.c b/shell.c
index 66350b2..3bbe774 100644
--- a/shell.c
+++ b/shell.c
@@ -15,7 +15,7 @@ static int do_generic_cmd(const char *me, char *arg)
 	setup_path();
 	if (!arg || !(arg = sq_dequote(arg)))
 		die("bad argument");
-	if (prefixcmp(me, "git-"))
+	if (!has_prefix(me, "git-"))
 		die("bad command");
 
 	my_argv[0] = me + 4;
-- 
1.8.4.1.566.geca833c
