From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 2/5] Header includes cleanup
Date: Mon, 30 Mar 2009 02:55:22 -0700
Message-ID: <1238406925-15907-3-git-send-email-nathaniel.dawson@gmail.com>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-2-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEFH-0001ZQ-ER
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566AbZC3Jzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbZC3Jzm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:55:42 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:43577 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273AbZC3Jzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:55:36 -0400
Received: by an-out-0708.google.com with SMTP id d14so1536964and.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C/isu1nk//6tfXIZd3t9PRx/woCTVEJQXzmMbhE9Qgw=;
        b=x4Jy6YmudcfOOIcyG86HKku261RocUb3fdVISJ8nx7YQQQ9WTUWIhO5lkbCu7SSf2d
         rfHhAkeFPkbN8JDzmjJqvJOMW92P0/SfXJPsb3XS2w8AzymoI5ncX7pnGPyxbXiJmS57
         PcLLCdSwJQR6ROPUPhUjzuckOjVsx7FTpdwFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PrpqJz5LNzd5+ampJ+Dy9vu6YldPzTyqsDPWOEeL/Q32hmVspkRHPr+fbpL7hgCtSR
         LJFAy+4xPnzIQCLsdlbPG7S5l/SXCWjXUYrLn/4M0Yoj0o5J/GX55bvZxceHf3V89uFY
         w0V/cCuV7rLIiotKylrjiBBAf35LOE0FJVazA=
Received: by 10.100.41.9 with SMTP id o9mr2104177ano.24.1238406933935;
        Mon, 30 Mar 2009 02:55:33 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id c40sm4333708anc.28.2009.03.30.02.55.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:55:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238406925-15907-2-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115123>

Deleted header includes of object.h where blob.h was included since blob.h includes it.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 alloc.c                  |    1 -
 builtin-for-each-ref.c   |    1 -
 builtin-pack-objects.c   |    1 -
 builtin-unpack-objects.c |    3 +--
 fast-import.c            |    1 -
 fsck.c                   |    1 -
 object.c                 |    1 -
 7 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..5b3d4a2 100644
--- a/alloc.c
+++ b/alloc.c
@@ -10,7 +10,6 @@
  * for the new allocation is.
  */
 #include "cache.h"
-#include "object.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index ab9bfa4..6cbfb03 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "blob.h"
-#include "object.h"
 #include "refs.h"
 #include "tag.h"
 #include "tree.h"
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index fe7a8de..c53147a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "attr.h"
-#include "object.h"
 #include "blob.h"
 #include "tag.h"
 #include "tree.h"
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 4f5495d..674bede 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -1,8 +1,7 @@
 #include "builtin.h"
-#include "object.h"
+#include "blob.h"
 #include "delta.h"
 #include "pack.h"
-#include "blob.h"
 #include "tag.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/fast-import.c b/fast-import.c
index e3c138f..8d1d9f3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -141,7 +141,6 @@ Format of STDIN stream:
 */
 
 #include "builtin.h"
-#include "object.h"
 #include "blob.h"
 #include "tree.h"
 #include "delta.h"
diff --git a/fsck.c b/fsck.c
index 511b82c..e903f6a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "object.h"
 #include "blob.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/object.c b/object.c
index 7e6a92c..380652f 100644
--- a/object.c
+++ b/object.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "object.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
-- 
1.6.1.3
