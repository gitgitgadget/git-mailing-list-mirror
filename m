From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 69/86] builtin/notes: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:02 +0100
Message-ID: <20131109070720.18178.62710.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lh-0001o9-7b
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885Ab3KIHPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:34 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55674 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629Ab3KIHOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:18 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id CC90576;
	Sat,  9 Nov 2013 08:14:17 +0100 (CET)
X-git-sha1: a65f3ed092fef8dfc7b0d34efa0974dfa2fba2cc 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237562>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d459e23..4bc7385 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -347,7 +347,7 @@ static struct notes_tree *init_notes_check(const char *subcommand)
 	init_notes(NULL, NULL, NULL, 0);
 	t = &default_notes_tree;
 
-	if (prefixcmp(t->ref, "refs/notes/"))
+	if (!has_prefix(t->ref, "refs/notes/"))
 		die("Refusing to %s notes in %s (outside of refs/notes/)",
 		    subcommand, t->ref);
 	return t;
-- 
1.8.4.1.566.geca833c
