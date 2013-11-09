From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 71/86] builtin/prune: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:04 +0100
Message-ID: <20131109070720.18178.82667.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lg-0001o9-Ly
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879Ab3KIHPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:33 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33937 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758683Ab3KIHOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:19 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id A56C440;
	Sat,  9 Nov 2013 08:14:18 +0100 (CET)
X-git-sha1: 503deb321705810f04c514d9a005423365b9dfa3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237561>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/prune.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 6366917..59682ff 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -80,7 +80,7 @@ static int prune_dir(int i, char *path)
 			prune_object(path, de->d_name, sha1);
 			continue;
 		}
-		if (!prefixcmp(de->d_name, "tmp_obj_")) {
+		if (has_prefix(de->d_name, "tmp_obj_")) {
 			prune_tmp_object(path, de->d_name);
 			continue;
 		}
@@ -119,7 +119,7 @@ static void remove_temporary_files(const char *path)
 		return;
 	}
 	while ((de = readdir(dir)) != NULL)
-		if (!prefixcmp(de->d_name, "tmp_"))
+		if (has_prefix(de->d_name, "tmp_"))
 			prune_tmp_object(path, de->d_name);
 	closedir(dir);
 }
-- 
1.8.4.1.566.geca833c
