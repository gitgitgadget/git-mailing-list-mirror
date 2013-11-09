From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 34/86] pkt-line: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:27 +0100
Message-ID: <20131109070720.18178.13134.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2h9-0004uI-EE
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271Ab3KIHKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:46 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65442 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933270Ab3KIHIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:35 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 0124668;
	Sat,  9 Nov 2013 08:08:33 +0100 (CET)
X-git-sha1: 8dfd21b8b074c0f6909362b161abf77d4c681e70 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237524>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pkt-line.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 70f1950..d967727 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -24,8 +24,8 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_addf(&out, "packet: %12s%c ",
 		    packet_trace_prefix, write ? '>' : '<');
 
-	if ((len >= 4 && !prefixcmp(buf, "PACK")) ||
-	    (len >= 5 && !prefixcmp(buf+1, "PACK"))) {
+	if ((len >= 4 && has_prefix(buf, "PACK")) ||
+	    (len >= 5 && has_prefix(buf+1, "PACK"))) {
 		strbuf_addstr(&out, "PACK ...");
 		unsetenv(trace_key);
 	}
-- 
1.8.4.1.566.geca833c
