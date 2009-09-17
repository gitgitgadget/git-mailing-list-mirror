From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v3] Update the usage bundle string.
Date: Thu, 17 Sep 2009 13:20:53 -0400
Message-ID: <1253208053-9732-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 19:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoKfW-0007Sz-9O
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 19:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbZIQRVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 13:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbZIQRVI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 13:21:08 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:1246 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbZIQRVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 13:21:07 -0400
Received: by qw-out-2122.google.com with SMTP id 5so88187qwd.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TI4DueE4PAWBiKUKXN75M5+xGHzLTt+jeGhv2GNhh4M=;
        b=ITBEP+U+vb/RCRmsEMVkXFQENqMDd1HvcYI+0Pce8fEI+npK/gvEj2RF3I3GSNsRo3
         Em8PsKYQF75bMCUQCUcKPHr6XzCIoWSc1aZJyokXoFnsvZruTXDqeCVA3UNmt3U2zI3x
         EB9DshX29KZ0xuMkWxvsHyVeMiDsTAeqqFARY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rmwmTT6cXzXyYjXg2grAsBWMi0r2GnmzTIzvPS7vyXDDIb9YHE3taI4CeVM7k1btAA
         e3uYU47TGWbCf+vsDCGmw2vpOXDhIRHEZAzV/k1f/3PyZNO7zOYJ3U3FbpohxjwSIImm
         YDBezZ+zBRbmzAdzhV3O2FQ4HDhe1eDVynlyM=
Received: by 10.224.119.4 with SMTP id x4mr531155qaq.304.1253208070483;
        Thu, 17 Sep 2009 10:21:10 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 6sm129519qwk.44.2009.09.17.10.21.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 10:21:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128766>

Currently the usage bundle string is not well formatted.
Now it is formatted and the user can read the string much more easily.
Also makes the output more consistent with the other usage strings that use
usage_with_options to show the usage string.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-bundle.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9b58152..2006cc5 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -9,7 +9,11 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
+static const char builtin_bundle_usage[] =
+  "git bundle create <file> <git-rev-list args>\n"
+  "   or: git bundle verify <file>\n"
+  "   or: git bundle list-heads <file> [refname...]\n"
+  "   or: git bundle unbundle <file> [refname...]";
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
@@ -20,7 +24,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	char buffer[PATH_MAX];
 
 	if (argc < 3)
-		usage(bundle_usage);
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
