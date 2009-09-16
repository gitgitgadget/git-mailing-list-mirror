From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] Update the usage bundle string.
Date: Wed, 16 Sep 2009 17:32:54 -0400
Message-ID: <1253136774-13179-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo28D-0007gt-VS
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbZIPVdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbZIPVdc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:33:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:37961 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbZIPVdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:33:31 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1771425qwb.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=c3Wc2X+h5Z4Votzwen1p90FLwR0joahd1kNl8nfHo4Y=;
        b=hxP+uR10o2L2peOUe6j0Ai9sA7qcR8hs4GXiMvG+5YE6pZxV4BRhh6V4yhVTaH7xOY
         +nNBR4T3+ApIlhhOWoLjOe9lf5Qal0zxZSxc34Jp2xGal2+juxAjlNVvxzrWcUzoC7Wh
         1fEW9Jv7g9e8Y6/QQSScDWwBzv2n4y1Wxd+e4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WeiL7jNT1XfuXKgo1MZQDb/YCJdmgPtik8ZPKL4FTVaKNFITiA+xQZwBrZDMPoqKw7
         6ntj1vywfbvteYWBzgNHfCUWa8ztKOGaR5aIaa2xUYnp/jBPTG/SlSlIRD3Wt8uGtk5j
         +eAZ1w2ulhsB3TQLsGuvDA31qcsXpd5D3I+o4=
Received: by 10.224.96.81 with SMTP id g17mr7872445qan.265.1253136815123;
        Wed, 16 Sep 2009 14:33:35 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 5sm72234qwh.56.2009.09.16.14.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 14:33:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128679>

Currently the usage bundle string is not well formatted.
Now it is formatted and the user can read the string much more easily.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-bundle.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9b58152..9946592 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -9,7 +9,11 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
+static const char builtin_bundle_usage[] = "\
+  git bundle create <file> <git-rev-list args>\n\
+  git bundle verify <file>\n\
+  git bundle list-heads <file> [refname...]\n\
+  git bundle unbundle <file> [refname...]";
 
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
