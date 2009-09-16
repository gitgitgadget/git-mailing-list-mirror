From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Update the usage bundle string.
Date: Wed, 16 Sep 2009 17:20:11 -0400
Message-ID: <1253136011-12011-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo1w5-0003mk-VF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbZIPVUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbZIPVUz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:20:55 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:4653 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZIPVUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:20:54 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1768210qwb.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=62Dzn+HVwc+KnX+pZzGphYwaKjalblMm7eJ70O3NXC4=;
        b=Rzj1hSAw1IIS4uMgjc3rR36cIZzz6TF6pP6iyMnvXJyXnDsXa/lTCUknwQrROFi8i+
         UTG1osAi6anI0AyRu2A7J43vM4gaiO1A/NeBua64JLnvPd3K4AP4F6gMFd8GELkORREB
         y6/5qPXx1dPiCbgVF0NSTZuqb0qBPWCQ6p7iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=v0J6crZiHGj9rZC1kHxllQPaRNCleNSAYDKK8E05bzCChXAVywB+8stBFSE3V5/45/
         4lIAwLVTamVYj/0UZIFzejb2mxHUHopuHKoMJa6CCy4M20DCOsfIrvcldCSvMgOiP5+1
         RFZ2EXA6hOxr4Sq/aWlUX0ulxl2/vSSgY2xeM=
Received: by 10.224.63.1 with SMTP id z1mr7891277qah.314.1253136057844;
        Wed, 16 Sep 2009 14:20:57 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 4sm757728qwe.5.2009.09.16.14.20.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 14:20:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128677>

Currently the usage bundle string is not well formatted.
Now it is formatted and the user can read the string much more easily.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-bundle.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9b58152..2e98907 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -11,6 +11,12 @@
 
 static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
 
+static const char builtin_bundle_usage[] = "\
+  git bundle create <file> <git-rev-list args>\n\
+  git bundle verify <file>\n\
+  git bundle list-heads <file> [refname...]\n\
+  git bundle unbundle <file> [refname...]";
+
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
@@ -19,8 +25,8 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	int bundle_fd = -1;
 	char buffer[PATH_MAX];
 
-	if (argc < 3)
-		usage(bundle_usage);
+  if (argc < 3)
+		usage(builtin_bundle_usage);
 
 	cmd = argv[1];
 	bundle_file = argv[2];
@@ -59,5 +65,5 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
 	} else
-		usage(bundle_usage);
+		usage(builtin_bundle_usage);
 }
-- 
1.6.5.rc0.dirty
