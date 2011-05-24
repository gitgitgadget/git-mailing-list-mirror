From: Marc Pegon <pegon.marc@gmail.com>
Subject: [PATCH] Fix usage of git-init and git-init-db documentation
Date: Tue, 24 May 2011 16:41:53 +0200
Message-ID: <1306248113-19948-1-git-send-email-pegon.marc@gmail.com>
Cc: gitster@pobox.com, Marc Pegon <pegon.marc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 16:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOsmy-0005Qf-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 16:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab1EXOkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 10:40:43 -0400
Received: from mail-ww0-f66.google.com ([74.125.82.66]:34329 "EHLO
	mail-ww0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704Ab1EXOkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 10:40:40 -0400
Received: by wwb22 with SMTP id 22so1520894wwb.1
        for <git@vger.kernel.org>; Tue, 24 May 2011 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=pesYhi9goGP4G6v2wYD9L8/2cv61qJedLAouSFZCHf8=;
        b=DfxgMn/EGsob/1+LQwLiTjhjRTS34ZpRasVe2ze2NFHxBg5qx4fH5OsYO2g45T9B5Z
         1Ldaj8YPHt2PcThFG65CCevfyJJoD8Fy862fB724qXhnORrR3tzi5xqiI8tEFywTO2vh
         r4hdl2d7rsywIUnLReqZ/JIw/n5iPS19hmJ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bMZ7Bg/5znik0JJKfAqtiBi8Yf2ACxkkq0lB4no7bIy2ZWo6v2Zq+KYjRgnwWAKb4V
         9/4JiIskboSEW7CssDyXwNneW2oTIiTFnqAl6PQDsD8eGnf0KRSYjrCvHBrW0GAYbbmX
         48bIaHWFWwEeElky1LiwRktHa6h/FY/JvY64k=
Received: by 10.227.206.21 with SMTP id fs21mr3574765wbb.40.1306248039213;
        Tue, 24 May 2011 07:40:39 -0700 (PDT)
Received: from localhost.localdomain (bru67-1-82-227-48-153.fbx.proxad.net [82.227.48.153])
        by mx.google.com with ESMTPS id w12sm4815580wby.41.2011.05.24.07.40.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 07:40:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174319>

These were not updated in commit b57fb80a7d7 (init, clone: support --separate-git-dir for .git file)

Signed-off-by: Marc Pegon <pegon.marc@gmail.com>
---
 Documentation/git-init-db.txt |    4 +++-
 builtin/init-db.c             |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 2c4c716..0a17450 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,7 +8,9 @@ git-init-db - Creates an empty git repository
 
 SYNOPSIS
 --------
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
+	  [--separate-git-dir|-L <git dir>]
+	  [--shared[=<permissions>]] [directory]
 
 
 DESCRIPTION
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b7370d9..0a71378 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -463,7 +463,9 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const char *const init_db_usage[] = {
-	"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [directory]",
+	"git init [-q | --quiet] [--bare] [--template=<template_directory>]\n"
+	"[--separate-git-dir|-L <git dir>]\n",
+	"[--shared[=<permissions>]] [directory]",
 	NULL
 };
 
-- 
1.7.1
