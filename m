From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 2/4] Header Includes Cleanup Part 2
Date: Tue, 31 Mar 2009 02:45:19 -0700
Message-ID: <1238492721-92484-3-git-send-email-nathaniel.dawson@gmail.com>
References: <1238492721-92484-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238492721-92484-2-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 11:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaYd-0007Pf-Bl
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbZCaJpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbZCaJpc
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:45:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:64362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZCaJpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:45:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2938874rvb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ClD4das0za33uTbSgvCsO6oHiwq65y2nYgTZysX7ajs=;
        b=CUIMAkpwB+Nia4WiEE+aSC7jMXL/VR8k2WZTM7+fNfG4bCJVljzhvOG1+3L/E6zACv
         ln1d6zfYGIKi27Bu9p1w28g4VNNZQKBYNieWe5ZcGoKGAwSk6kuQwW/3lbBdLXFFuJmm
         oogA+536br12GXF5DcMyEetf6I3NBNvw5dzk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HZ6fsItgux9F32pKoQ8GQSQqoGdh8nMXqMNhCiHFysANtgCBTCoIzaBtMDQCdEYKxy
         nWdS0vu4ZAAQ0AkW3NuP7UdHnave0zIqLgEPp/qfl+uwKHYcQeX8qrfSDjcPtF8ls7HX
         ATjbt+1USPNI1Er9mVp1hHEmd0MiR+CW9usuc=
Received: by 10.141.69.12 with SMTP id w12mr3374734rvk.154.1238492729118;
        Tue, 31 Mar 2009 02:45:29 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id g31sm16494669rvb.37.2009.03.31.02.45.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 02:45:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238492721-92484-2-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115241>

Deleted includes of revision.h where log-tree.h was included since
log-tree.h includes it.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 builtin-commit.c      |    3 +--
 builtin-diff.c        |    1 -
 builtin-fast-export.c |    1 -
 builtin-log.c         |    1 -
 builtin-merge.c       |    3 +--
 builtin-rev-list.c    |    3 +--
 diff-no-index.c       |    1 -
 pretty.c              |    3 +--
 revision.c            |    3 +--
 9 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index aba5660..0e21313 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -11,11 +11,10 @@
 #include "dir.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "revision.h"
+#include "log-tree.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "refs.h"
-#include "log-tree.h"
 #include "utf8.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin-diff.c b/builtin-diff.c
index 252c519..50239a9 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -9,7 +9,6 @@
 #include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "revision.h"
 #include "log-tree.h"
 
 struct blobinfo {
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b62e48d..e1aa036 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -9,7 +9,6 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "log-tree.h"
-#include "revision.h"
 #include "decorate.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/builtin-log.c b/builtin-log.c
index 5105c91..db7c344 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -7,7 +7,6 @@
 #include "builtin.h"
 #include "color.h"
 #include "diff.h"
-#include "revision.h"
 #include "log-tree.h"
 #include "tag.h"
 #include "reflog-walk.h"
diff --git a/builtin-merge.c b/builtin-merge.c
index cb4c645..fb6e61a 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -12,12 +12,11 @@
 #include "diff.h"
 #include "refs.h"
 #include "diffcore.h"
-#include "revision.h"
+#include "log-tree.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
 #include "dir.h"
 #include "utf8.h"
-#include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
 #include "help.h"
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index cedfe9a..faac425 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -4,9 +4,8 @@
 #include "tag.h"
 #include "tree.h"
 #include "diff.h"
-#include "revision.h"
-#include "list-objects.h"
 #include "log-tree.h"
+#include "list-objects.h"
 #include "graph.h"
 
 /* bits #0-15 in revision.h */
diff --git a/diff-no-index.c b/diff-no-index.c
index cb68b8d..fa8b669 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -10,7 +10,6 @@
 #include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "revision.h"
 #include "log-tree.h"
 #include "string-list.h"
 
diff --git a/pretty.c b/pretty.c
index efa7024..0465de1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2,10 +2,9 @@
 #include "commit.h"
 #include "utf8.h"
 #include "diff.h"
-#include "revision.h"
+#include "log-tree.h"
 #include "string-list.h"
 #include "mailmap.h"
-#include "log-tree.h"
 #include "color.h"
 
 static char *user_format;
diff --git a/revision.c b/revision.c
index 827108d..18425d6 100644
--- a/revision.c
+++ b/revision.c
@@ -4,12 +4,11 @@
 #include "commit.h"
 #include "diff.h"
 #include "refs.h"
-#include "revision.h"
+#include "log-tree.h"
 #include "graph.h"
 #include "grep.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
-#include "log-tree.h"
 
 volatile show_early_output_fn_t show_early_output;
 
-- 
1.6.1.3
