From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 62/86] builtin/init-db: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:55 +0100
Message-ID: <20131109070720.18178.93850.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:16:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2mI-0002Wp-4V
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933487Ab3KIHQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:16:12 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37687 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758645Ab3KIHOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:16 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id C372831;
	Sat,  9 Nov 2013 08:14:14 +0100 (CET)
X-git-sha1: 391215f981e967efd5fd3223bef5568bf9170cf5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237568>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/init-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 78aa387..7fe9d8c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -266,7 +266,7 @@ static int create_default_files(const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-		if (prefixcmp(git_dir, work_tree) ||
+		if (!has_prefix(git_dir, work_tree) ||
 		    strcmp(git_dir + strlen(work_tree), "/.git")) {
 			git_config_set("core.worktree", work_tree);
 		}
-- 
1.8.4.1.566.geca833c
