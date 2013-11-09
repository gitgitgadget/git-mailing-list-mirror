From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/86] test-line-buffer: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:06 +0100
Message-ID: <20131109070720.18178.58215.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hZ-0005PQ-Hg
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364Ab3KIHLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:12 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65364 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235Ab3KIHIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 043B15D;
	Sat,  9 Nov 2013 08:08:24 +0100 (CET)
X-git-sha1: ac4adbd1be0a430256d49db77d40eb9e324da99a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237531>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 test-line-buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test-line-buffer.c b/test-line-buffer.c
index ef1d7ba..ed0d681 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -19,7 +19,7 @@ static void handle_command(const char *command, const char *arg, struct line_buf
 {
 	switch (*command) {
 	case 'b':
-		if (!prefixcmp(command, "binary ")) {
+		if (has_prefix(command, "binary ")) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addch(&sb, '>');
 			buffer_read_binary(buf, &sb, strtouint32(arg));
@@ -28,12 +28,12 @@ static void handle_command(const char *command, const char *arg, struct line_buf
 			return;
 		}
 	case 'c':
-		if (!prefixcmp(command, "copy ")) {
+		if (has_prefix(command, "copy ")) {
 			buffer_copy_bytes(buf, strtouint32(arg));
 			return;
 		}
 	case 's':
-		if (!prefixcmp(command, "skip ")) {
+		if (has_prefix(command, "skip ")) {
 			buffer_skip_bytes(buf, strtouint32(arg));
 			return;
 		}
-- 
1.8.4.1.566.geca833c
