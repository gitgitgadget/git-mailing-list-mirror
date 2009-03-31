From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 1/4] Header Includes Cleanup Part 2
Date: Tue, 31 Mar 2009 02:45:18 -0700
Message-ID: <1238492721-92484-2-git-send-email-nathaniel.dawson@gmail.com>
References: <1238492721-92484-1-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 11:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaYc-0007Pf-KD
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbZCaJp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZCaJp3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:45:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:64362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZCaJp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:45:28 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2938874rvb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ihm0Eo6VyVs7Ut8Bvxm+GRCwGhhNVbon3Y8tZacbWc8=;
        b=ihsy28sz7UV6Rvct9z3hAeRj6Y3WkEfDJEa8AQ0YfpWpERnXfuvvlLx7lEfx0dKyZb
         6OIU8n9XtlTF6CvVsbsr4bTwWmWfHNI8EzCfqdyPIZYnlOEnrcRel+Cp0UBI0ggcV5H7
         kJJohUBnl2EP6emD106s0FdfBfp1wxYwNAs78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=akR0Y31Nyn55vx2BiT5U01RW5+0DMg3cm1lO5ReQ4MPnb094FpvgY/zHGhY4K7c5MW
         iN7YVXwvs3MI/ivlW7VjnZhgASYUlMOHQ1YnCfXfAvn5PR9pbF3Fs1IuS0+mXJUl8rnh
         lHlfkAYIwIkqweZNvVcnPW29lxNSw+VWSgegQ=
Received: by 10.140.144.1 with SMTP id r1mr3367906rvd.131.1238492726539;
        Tue, 31 Mar 2009 02:45:26 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id c20sm16508685rvf.0.2009.03.31.02.45.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 02:45:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238492721-92484-1-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115239>

Deleted header includes of cache.h, strbuf.h, and remote.h where
http.h is already included since it includes them.

Also deleted a couple includes I missed during part 1.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 builtin-rev-parse.c                       |    4 +---
 contrib/convert-objects/convert-objects.c |    1 -
 http-push.c                               |    4 +---
 http-walker.c                             |    3 +--
 http.h                                    |    1 -
 5 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 81d5a6f..dc0a9ab 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -3,11 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
-#include "commit.h"
+#include "builtin.h"
 #include "refs.h"
 #include "quote.h"
-#include "builtin.h"
 #include "parse-options.h"
 
 #define DO_REVS		1
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index 90e7900..99a7cfd 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "blob.h"
 #include "commit.h"
-#include "tree.h"
 
 struct entry {
 	unsigned char old_sha1[20];
diff --git a/http-push.c b/http-push.c
index 6ce5a1d..97b2e68 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,14 +1,12 @@
-#include "cache.h"
+#include "http.h"
 #include "commit.h"
 #include "pack.h"
 #include "tag.h"
 #include "blob.h"
-#include "http.h"
 #include "refs.h"
 #include "diff.h"
 #include "revision.h"
 #include "exec_cmd.h"
-#include "remote.h"
 #include "list-objects.h"
 #include "sigchain.h"
 
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..6ecd754 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,8 +1,7 @@
-#include "cache.h"
+#include "http.h"
 #include "commit.h"
 #include "pack.h"
 #include "walker.h"
-#include "http.h"
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
diff --git a/http.h b/http.h
index 905b462..e424356 100644
--- a/http.h
+++ b/http.h
@@ -6,7 +6,6 @@
 #include <curl/curl.h>
 #include <curl/easy.h>
 
-#include "strbuf.h"
 #include "remote.h"
 
 /*
-- 
1.6.1.3
