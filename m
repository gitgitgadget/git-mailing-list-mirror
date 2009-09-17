From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] Update the usage bundle string.
Date: Wed, 16 Sep 2009 22:13:36 -0400
Message-ID: <1253153616-10051-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 04:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo6WX-0005i3-KK
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 04:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbZIQCOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 22:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbZIQCOx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 22:14:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:53012 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZIQCOx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 22:14:53 -0400
Received: by qyk11 with SMTP id 11so4819553qyk.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 19:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iROYY/vNbX2cA8ikWj4VYF1/ILesvVtM+S+a3pMo3fw=;
        b=Zei5IhqT/6+rAfwTSRIyLZ5gQ5Sl/xnX9rz6GmxZgFlaMbr7x+DFUkRwSQUnk/2IaH
         XYd3Sca9FWb/PqDyaJJEUcyspiAP6bDu0pEa1FUdHlfIn9/K0koBvlGDByeHf1BYKNqh
         2zGGgXhvS4oyKbBEXQLy4PzpWdzoyiJYVJgPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GWHIFbCEyHs2OjhcC0WgVAIBH0AvUcsW20+/BtneJGpyK8kTgbcmWrKOhw1xzpUa1z
         5RorBmthkRc0YcsNkN4YKzwUdHmG9lptTUWlxsvJzkKlthOUkXgxP4C4h2EuU4a1d9Od
         9SHRbNz+64Wk5h54YgSqhBk15NK9r+zi1YXjQ=
Received: by 10.224.16.131 with SMTP id o3mr7184561qaa.18.1253153696349;
        Wed, 16 Sep 2009 19:14:56 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 5sm114086qwg.6.2009.09.16.19.14.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 19:14:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128704>

Currently the usage bundle string is not well formatted.
Now it is formatted and the user can read the string much more easily.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-bundle.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9b58152..bade253 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -9,7 +9,11 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
+static const char builtin_bundle_usage[] = "\
+  git bundle create <file> <git-rev-list args>\n\
+         git bundle verify <file>\n\
+         git bundle list-heads <file> [refname...]\n\
+         git bundle unbundle <file> [refname...]";
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
@@ -19,8 +23,8 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	int bundle_fd = -1;
 	char buffer[PATH_MAX];
 
-	if (argc < 3)
-		usage(bundle_usage);
+  if (argc < 3)
+		usage(builtin_bundle_usage);
 
 	cmd = argv[1];
 	bundle_file = argv[2];
@@ -59,5 +63,5 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
 	} else
-		usage(bundle_usage);
+		usage(builtin_bundle_usage);
 }
-- 
1.6.5.rc0.dirty
