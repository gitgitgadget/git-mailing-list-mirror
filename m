From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] commit: configure submodules
Date: Sun, 23 Sep 2012 09:37:47 +0200
Message-ID: <1348385867-17359-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 09:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFgld-00073l-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 09:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab2IWHiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 03:38:08 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50491 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2IWHiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 03:38:07 -0400
Received: by wibcb5 with SMTP id cb5so2875973wib.1
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V4jOXFGLcr/8bDw8ztl0Yyqe1FHOU/6GjZQIAcoa/R4=;
        b=WNJFfQwMJuABm4MPkFD6ZzqD333Kdwe66xLy+PoLJ6VLR6k3kPJQuxXVKjvsUIcZHt
         zKfQB3A7t2P5VCe7BT00b7OdPtO+5fGyvhySc+wZBN5wx9/IWKu95kP2aqI9lN4ENUum
         lsLMEQVPx3pnT1ld5tMmobHXhW6aSHWRgYfyL/F63qNm5fCixwswuns8iaChQWEV5nHL
         YhfBN69ev0xWyuE7+U5zDw2tgbhseEMx9Re29LrBHUKmOE+4cWek8KmUE2jfy0SkMSL6
         PJRJd9ogr3WO3EivzUq8azHpfjligZbaeDAi0Sr0nD//EvvhmhVp/3UYivaCgzyQ5P3f
         fCQA==
Received: by 10.216.145.9 with SMTP id o9mr5351179wej.107.1348385885242;
        Sun, 23 Sep 2012 00:38:05 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-228-252-129.inter.net.il. [84.228.252.129])
        by mx.google.com with ESMTPS id fb20sm8822591wid.1.2012.09.23.00.38.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 00:38:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206221>

As reported on the mailing list[1], ignore submodule config is not
respected on commit.

[1] http://git.661346.n2.nabble.com/submodule-ignore-is-not-respected-on-commit-td7539238.html

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/commit.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 62028e7..7a83cae 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1452,6 +1452,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	wt_status_prepare(&s);
+	gitmodules_config();
 	git_config(git_commit_config, &s);
 	determine_whence(&s);
 	s.colopts = 0;
-- 
1.7.10.4
