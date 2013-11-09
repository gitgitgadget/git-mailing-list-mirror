From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 28/86] bisect: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:21 +0100
Message-ID: <20131109070720.18178.4605.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fC-0002lM-9X
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647Ab3KIHIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:53 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65421 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933261Ab3KIHIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:32 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7694A57;
	Sat,  9 Nov 2013 08:08:31 +0100 (CET)
X-git-sha1: a895af49f96d4f5757e4b6a1eacbf68635fde9cb 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237489>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1e46a4f..4819091 100644
--- a/bisect.c
+++ b/bisect.c
@@ -406,9 +406,9 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 	if (!strcmp(refname, "bad")) {
 		current_bad_sha1 = xmalloc(20);
 		hashcpy(current_bad_sha1, sha1);
-	} else if (!prefixcmp(refname, "good-")) {
+	} else if (has_prefix(refname, "good-")) {
 		sha1_array_append(&good_revs, sha1);
-	} else if (!prefixcmp(refname, "skip-")) {
+	} else if (has_prefix(refname, "skip-")) {
 		sha1_array_append(&skipped_revs, sha1);
 	}
 
-- 
1.8.4.1.566.geca833c
