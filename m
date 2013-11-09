From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 81/86] builtin/tag: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:14 +0100
Message-ID: <20131109070720.18178.89055.chriscool@tuxfamily.org>
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
	id 1Vf2l3-00014x-Hp
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933476Ab3KIHOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:53 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55723 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932712Ab3KIHOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id F26416E;
	Sat,  9 Nov 2013 08:14:22 +0100 (CET)
X-git-sha1: bfd9014342b881e66eb002d4205efc410f8e38f6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237548>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ea55f1d..e7aaaa2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -259,7 +259,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	int status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
-	if (!prefixcmp(var, "column."))
+	if (has_prefix(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
 	return git_default_config(var, value, cb);
 }
-- 
1.8.4.1.566.geca833c
