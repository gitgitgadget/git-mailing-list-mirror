From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/9] builtin-init-db: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:13 +0100
Message-ID: <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9g-0006Vh-QX
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZCXBIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZCXBIm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:42 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57069 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbZCXBI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:26 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 56298294075;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E2FC2186224; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114377>

---
 builtin-init-db.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..fc63d0f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -130,8 +130,7 @@ static void copy_templates(const char *template_dir)
 	}
 	dir = opendir(template_path);
 	if (!dir) {
-		fprintf(stderr, "warning: templates not found %s\n",
-			template_dir);
+		warning("templates not found %s", template_dir);
 		return;
 	}
 
@@ -144,8 +143,8 @@ static void copy_templates(const char *template_dir)
 
 	if (repository_format_version &&
 	    repository_format_version != GIT_REPO_VERSION) {
-		fprintf(stderr, "warning: not copying templates of "
-			"a wrong format version %d from '%s'\n",
+		warning("not copying templates of "
+			"a wrong format version %d from '%s'",
 			repository_format_version,
 			template_dir);
 		closedir(dir);
-- 
1.6.2
