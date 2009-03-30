From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 3/5] Header includes cleanup
Date: Mon, 30 Mar 2009 02:55:23 -0700
Message-ID: <1238406925-15907-4-git-send-email-nathaniel.dawson@gmail.com>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-2-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-3-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEFI-0001ZQ-6W
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbZC3Jzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758257AbZC3Jzn
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:55:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:10076 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758119AbZC3Jzi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:55:38 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1910555yxl.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ez8L9eFrOt2/ul9gQl0541GfLGz9WVWSRIm0J70YROg=;
        b=uR3FA63tRetrB1a8pan96DbDAczkG5PUUcRGPILpCwd9fyqh9b/WcPHdxqX+PyGyDc
         SyrbAC4j3DjCQCvvmYbCIVeMh43HbDWd5PgyNEzeMpkVOU9ZpDfRUJYPlRiAY10O5cPP
         qrAqUA/DehbiT67tANb4yXSDwRAvMtgnO25Us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DowsCXY4gVMvUm2Vdo7qX8XZsJv7Ly2Ki574UZ5kLkcezv8erOnogXAVy3aeQ+Y2cZ
         JIir3eujHwa9aJmW2mZvRBX6XxX85CM0jIYz/zt+yG8KkvHMkwYSt5ZSe/idIoLYurR2
         oi/QLWUMGKt2vL/IPGElI7Lq3lsOxh1ZZ4JWM=
Received: by 10.100.216.12 with SMTP id o12mr3750080ang.73.1238406936526;
        Mon, 30 Mar 2009 02:55:36 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id d38sm10593350and.49.2009.03.30.02.55.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:55:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238406925-15907-3-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115122>

Deleted header includes of git-compat-util.h, strbuf.h, hash.h where cache.h was included since cache.h includes them.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 builtin-clone.c   |    1 -
 builtin-remote.c  |    1 -
 connect.c         |    1 -
 diffcore-rename.c |    1 -
 editor.c          |    1 -
 hash.c            |    1 -
 parse-options.c   |    3 +--
 shell.c           |    1 -
 test-delta.c      |    3 +--
 9 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0031b5f..50cb6ba 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -16,7 +16,6 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
-#include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
diff --git a/builtin-remote.c b/builtin-remote.c
index 9ef846f..5bf8042 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -3,7 +3,6 @@
 #include "transport.h"
 #include "remote.h"
 #include "string-list.h"
-#include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
 
diff --git a/connect.c b/connect.c
index 7636bf9..12a5c2b 100644
--- a/connect.c
+++ b/connect.c
@@ -1,4 +1,3 @@
-#include "git-compat-util.h"
 #include "cache.h"
 #include "pkt-line.h"
 #include "quote.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0b0d6b8..00e1ce1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,7 +4,6 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "hash.h"
 
 /* Table of rename/copy destinations */
 
diff --git a/editor.c b/editor.c
index 4d469d0..22fd4c0 100644
--- a/editor.c
+++ b/editor.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "strbuf.h"
 #include "run-command.h"
 
 int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
diff --git a/hash.c b/hash.c
index 1cd4c9d..5a68fdf 100644
--- a/hash.c
+++ b/hash.c
@@ -2,7 +2,6 @@
  * Some generic hashing helpers.
  */
 #include "cache.h"
-#include "hash.h"
 
 /*
  * Look up a hash entry in the hash table. Return the pointer to
diff --git a/parse-options.c b/parse-options.c
index cf71bcf..bafeeea 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,6 +1,5 @@
-#include "git-compat-util.h"
-#include "parse-options.h"
 #include "cache.h"
+#include "parse-options.h"
 #include "commit.h"
 
 #define OPT_SHORT 1
diff --git a/shell.c b/shell.c
index e339369..37c52c2 100644
--- a/shell.c
+++ b/shell.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "quote.h"
 #include "exec_cmd.h"
-#include "strbuf.h"
 
 static int do_generic_cmd(const char *me, char *arg)
 {
diff --git a/test-delta.c b/test-delta.c
index 3d885ff..3d90611 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -8,9 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#include "git-compat-util.h"
-#include "delta.h"
 #include "cache.h"
+#include "delta.h"
 
 static const char usage_str[] =
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
-- 
1.6.1.3
