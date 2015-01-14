From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] init-db: remove unused #includes
Date: Wed, 14 Jan 2015 23:59:27 +0600
Message-ID: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:59:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBSEP-000256-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbbANR7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:59:45 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:63056 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbANR7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:59:44 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so9533185lab.4
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3P1ZFaldB0eBFS3gmfynIC59b8a7ul7XRPcLZsbvTHI=;
        b=uPp+6rt+5zCqoQYYtK8yY+L3mrZdAYks/RkF2atd5DUB9AWzLSCKGWu1ZH2Iy5VwpU
         ejVTcXNXBqjbAI7vBevF1n2ziba4HUqzdC9xQUexche9eZT7HHlnPrqHwiu2CfTI9Mt0
         y1jUgGQtp1vPV+5BR3tl/du7YtReN8MZcrR35kD9o1Dpk69sfzgvBkJSZVWSFJ7TOkLt
         jlZuvIpavb146fRoxZj/dv+pcrNvu0OKGH1DxfRYkUsAlgl0aK+T9YgVYTgUaxqHeGz9
         cO+WapoI41CKh1PwdC3NPNCGCwxMTE8i5RJmvzhuqSRbCK5eiLlzyQisMM23yLabcc8q
         Mffg==
X-Received: by 10.112.203.196 with SMTP id ks4mr5208330lbc.39.1421258383059;
        Wed, 14 Jan 2015 09:59:43 -0800 (PST)
Received: from localhost.localdomain ([178.89.21.160])
        by mx.google.com with ESMTPSA id t10sm1963786lat.31.2015.01.14.09.59.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jan 2015 09:59:42 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.255.g53b80d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262402>

* "cache.h" - is unnecessary because it already included at "builtin.h"

* "exec_cmd.h" - was added at a47d1813 (Allow a relative builtin template
directory., 15 Nov 2007). init-db used 'git_exec_path' routine from
"exec_cmd.h", but later it was removed at 2de9de5e (Move code interpreting
path relative to exec-dir to new function system_path()., 14 Jul 2008). So
we no need in it anymore.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/init-db.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 280454a..2978b36 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -3,9 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
 #include "builtin.h"
-#include "exec_cmd.h"
 #include "parse-options.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
-- 
2.3.0.rc0.255.g53b80d0
