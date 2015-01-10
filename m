From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] cat-file: remove unnecessary #include
Date: Sun, 11 Jan 2015 00:29:18 +0600
Message-ID: <1420914558-5324-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA0nB-0007cR-99
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 19:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbbAJS3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 13:29:36 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:55674 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbAJS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 13:29:35 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so18973489lab.10
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RDdl5loKXy6fAdayE9u/07bmVQaAld6qFnXbKsj8ObU=;
        b=j/ceAHnAfyIutPoSzkhdz7cwbXTKgyA+sIcw7v+YgHkd/hFIksULiXkMEbS6OK00Mj
         k0xBdRmcGz7DYwzG6WtdYjaIEiPgOF9g+4/N29VVvWC/Kv1ESuKQnptiGWD2rOSKMOId
         Ii5THIaHFH5j67SFyLypXIijk+KnprKyNJNO4z0rt8amWeiULeu9A89XlNGmMU2ewJFI
         58mZski4i6lV7QQwP3h/9111mafuOwEZymbj3PFuV+GhxayVUP0tatVPxLVdnwlk+dDf
         lWRgE5goB7wFvHqw/RFwN+XEPr14bt40aSNax0DZ/9qBTldSdGPmytDLo1StdhlsMbrr
         ms7w==
X-Received: by 10.152.21.228 with SMTP id y4mr28657658lae.72.1420914573872;
        Sat, 10 Jan 2015 10:29:33 -0800 (PST)
Received: from localhost.localdomain ([95.59.102.98])
        by mx.google.com with ESMTPSA id g7sm2701032lae.15.2015.01.10.10.29.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jan 2015 10:29:32 -0800 (PST)
X-Mailer: git-send-email 2.2.1.532.g168b885.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262268>

"cache.h" is already included in "builtin.h"

It appeared at e83c51 (Initial revision of "git", the information manager
from hell., 8 Apr 2005) and used cache.c API (get_sha1_hex and read_sha1_file).
After this in the commit f81dae (Builtin git-cat-file., ) was included
"builtin.h", which already includes "cache.h", so we no need to include it in
the cat-file.c

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/cat-file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 750b5a2..2e6aaa1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "userdiff.h"
-- 
2.2.1.532.g168b885.dirty
