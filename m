From: Marc Pegon <pegon.marc@gmail.com>
Subject: [PATCHv2] Fix usage of git-init and git-init-db documentation
Date: Tue, 24 May 2011 17:07:21 +0200
Message-ID: <1306249641-20316-1-git-send-email-pegon.marc@gmail.com>
Cc: gitster@pobox.com, Marc Pegon <pegon.marc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 17:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOtBM-0006Ud-Js
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 17:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab1EXPF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 11:05:58 -0400
Received: from mail-ww0-f66.google.com ([74.125.82.66]:43351 "EHLO
	mail-ww0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab1EXPF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 11:05:57 -0400
Received: by wwb22 with SMTP id 22so1525589wwb.1
        for <git@vger.kernel.org>; Tue, 24 May 2011 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=2oogRmtub2L9Kgfk8ipM/0CI20QdrGYdFm39Z5IsMig=;
        b=XAnzGrAmvDFQaMizEIlyPZTntgPMXKSWJyqLgpDdf9/SM9uh3GlK2z32KmN2MZOUOc
         tIoJPZI5qbAFXDR2J/uLU1I8g8fYsvnGdffGyYtxDBTly5s3zUPZxvY2OBowbKdYcgUt
         MBAkK9+vWtZqMCA5o4/Y2yxtxA+drbY2qp+YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=k8sCHs0eeunhf4ULbm0/RppfXfFmJBlC/88y4QR/wkfN7f0cXv3zsEdf4cKdMcVnRA
         SeYoDmiy6qJSnA8YurP+TUFN3JaCzfxF89stu75O+CetvM34/2i0u9cxCZNjxlpmW7v6
         ieS6E58S99Llhi6HpshiQ25S8C+PRr9NgfNcs=
Received: by 10.216.235.234 with SMTP id u84mr3581215weq.51.1306249556234;
        Tue, 24 May 2011 08:05:56 -0700 (PDT)
Received: from localhost.localdomain (bru67-1-82-227-48-153.fbx.proxad.net [82.227.48.153])
        by mx.google.com with ESMTPS id h11sm4830745wbc.26.2011.05.24.08.05.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 08:05:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174320>

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
index b7370d9..b22ea5e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -463,7 +463,9 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const char *const init_db_usage[] = {
-	"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [directory]",
+	"git init [-q | --quiet] [--bare] [--template=<template_directory>]\n"
+	"[--separate-git-dir|-L <git dir>]\n"
+	"[--shared[=<permissions>]] [directory]",
 	NULL
 };
 
-- 
1.7.1
