From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 42/86] pathspec: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:35 +0100
Message-ID: <20131109070720.18178.68051.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gY-0004Ea-CT
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336Ab3KIHKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:14 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54194 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933279Ab3KIHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 535CBA0;
	Sat,  9 Nov 2013 08:08:37 +0100 (CET)
X-git-sha1: 5759f372128b7297e957bd42052e7c63b249cd48 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237512>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pathspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index ad1a9f5..182b162 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -150,7 +150,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 					magic |= pathspec_magic[i].bit;
 					break;
 				}
-				if (!prefixcmp(copyfrom, "prefix:")) {
+				if (has_prefix(copyfrom, "prefix:")) {
 					char *endptr;
 					pathspec_prefix = strtol(copyfrom + 7,
 								 &endptr, 10);
-- 
1.8.4.1.566.geca833c
