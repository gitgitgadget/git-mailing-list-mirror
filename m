From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 70/86] builtin/pack-objects: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:03 +0100
Message-ID: <20131109070720.18178.14075.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lg-0001o9-4D
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab3KIHPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:30 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55681 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885Ab3KIHOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:19 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 3E2D078;
	Sat,  9 Nov 2013 08:14:18 +0100 (CET)
X-git-sha1: d37c5d6fb97e97bee01f7e2dfbbb0e8b9a47966b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237560>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e86cd57..45ee54a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2031,7 +2031,7 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
 {
 	unsigned char peeled[20];
 
-	if (!prefixcmp(path, "refs/tags/") && /* is a tag? */
+	if (has_prefix(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, peeled)        && /* peelable? */
 	    locate_object_entry(peeled))      /* object packed? */
 		add_object_entry(sha1, OBJ_TAG, NULL, 0);
-- 
1.8.4.1.566.geca833c
