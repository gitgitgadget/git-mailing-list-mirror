From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 5/5] Header includes cleanup
Date: Mon, 30 Mar 2009 02:55:25 -0700
Message-ID: <1238406925-15907-6-git-send-email-nathaniel.dawson@gmail.com>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-2-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-3-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-4-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-5-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEFI-0001ZQ-US
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758581AbZC3Jzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758578AbZC3Jzq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:55:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:32233 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbZC3Jzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:55:43 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1907093ywb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rcwmEPnxQhHJNz5ozAXxg5cBtDZ1OWFec2IezPy4tCo=;
        b=oWW78xc5ynqPWIqlK44wdKkEnHqDrSMSbZAuXa36arLPya2KaujzVpuN7q2gEgHJgE
         cCmK+CQ6JeLrs1t8/w/UVuIPd8f0N7QwWm2OzF0sTUCzp4ojihfnTKm2OgvxhvzA9qRr
         OILHVsfVf5SWrUge8UqA5pB9WC4bMDYOKPMtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mRJT3pGHw99Q4gdwY3mKAn9N8wAxVWGZ/bmvxi1ZT51YEs92EGhywoWEi7FMtq4krt
         QAwR9Hc4Lg2Zn0xZQDT1FzBd7JpYVrnvPMnPeBGAk5PEzylLPLJYU8IpLNsLFMuiL8qY
         dgrJq10dIa5l1rx9pdy57Jv+DjaITUcjY3OCI=
Received: by 10.100.125.9 with SMTP id x9mr316971anc.35.1238406941970;
        Mon, 30 Mar 2009 02:55:41 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id c14sm10500332ana.1.2009.03.30.02.55.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:55:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238406925-15907-5-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115125>

Deleted header includes of tree-walk.h where diff.h was included since diff.h includes it.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 builtin-blame.c        |    1 -
 builtin-checkout.c     |    3 +--
 builtin-pack-objects.c |    1 -
 builtin-reflog.c       |    1 -
 builtin-rev-list.c     |    1 -
 list-objects.c         |    1 -
 merge-recursive.c      |    1 -
 7 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index a91d350..bce181c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -6,7 +6,6 @@
 #include "builtin.h"
 #include "blob.h"
 #include "tag.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
diff --git a/builtin-checkout.c b/builtin-checkout.c
index f8bb9ea..3000e87 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -3,13 +3,12 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "tree.h"
-#include "tree-walk.h"
+#include "diff.h"
 #include "unpack-trees.h"
 #include "dir.h"
 #include "run-command.h"
 #include "merge-recursive.h"
 #include "branch.h"
-#include "diff.h"
 #include "revision.h"
 #include "remote.h"
 #include "xdiff-interface.h"
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c53147a..9d87fc7 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -7,7 +7,6 @@
 #include "pack.h"
 #include "pack-revindex.h"
 #include "csum-file.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
diff --git a/builtin-reflog.c b/builtin-reflog.c
index fcd92e8..4c122d6 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -1,7 +1,6 @@
 #include "builtin.h"
 #include "refs.h"
 #include "dir.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index bc86e3c..cedfe9a 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -3,7 +3,6 @@
 #include "refs.h"
 #include "tag.h"
 #include "tree.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
diff --git a/list-objects.c b/list-objects.c
index 6446f81..715e06d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -3,7 +3,6 @@
 #include "commit.h"
 #include "blob.h"
 #include "diff.h"
-#include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 352677c..370151e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -6,7 +6,6 @@
 #include "builtin.h"
 #include "blob.h"
 #include "cache-tree.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "tag.h"
-- 
1.6.1.3
