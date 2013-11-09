From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 46/86] builtin/archive: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:39 +0100
Message-ID: <20131109070720.18178.2112.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fw-0003XL-RC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325Ab3KIHJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:41 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54159 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933287Ab3KIHIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:43 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 05B31A4;
	Sat,  9 Nov 2013 08:08:38 +0100 (CET)
X-git-sha1: 8507d4bafd9be803da59a5ea7de1658801d4ba4c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237503>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/archive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 49178f1..b808bb5 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -57,9 +57,9 @@ static int run_remote_archiver(int argc, const char **argv,
 	if (!buf)
 		die(_("git archive: expected ACK/NAK, got EOF"));
 	if (strcmp(buf, "ACK")) {
-		if (!prefixcmp(buf, "NACK "))
+		if (has_prefix(buf, "NACK "))
 			die(_("git archive: NACK %s"), buf + 5);
-		if (!prefixcmp(buf, "ERR "))
+		if (has_prefix(buf, "ERR "))
 			die(_("remote error: %s"), buf + 4);
 		die(_("git archive: protocol error"));
 	}
-- 
1.8.4.1.566.geca833c
