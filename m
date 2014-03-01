From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] Place cache.h at the first place to match generl rule
Date: Sat,  1 Mar 2014 23:05:23 +0800
Message-ID: <1393686323-20978-1-git-send-email-sunheehnus@gmail.com>
Cc: pclouds@gmail.com, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 16:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJlVG-0007L7-6j
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 16:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbaCAPGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 10:06:47 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52628 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbaCAPGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 10:06:46 -0500
Received: by mail-pb0-f52.google.com with SMTP id rr13so1984517pbb.25
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CdovIZeLq4+rWg36syjKv/QKwnQLd86muvDrGMiOPWs=;
        b=YyCzwhnBOp19/f39mUdpDBjPkayFJsEUmdAlOHKx2zFV1dAg+xgKHv7LI9VOlWQo15
         kunhVzGRU2BizYTiVhHO9P6ty8g9CYpIfUkntj/hIGvaoT+zlSECfSYKr5+AMfzb2njl
         bDUHHrzMpZhJtmCzFtepAggcj+aAPuJSm1zMQekYbMzxA886mJO9obpoUXbw+mjLsNxr
         t2xpsnJ7ei8jEztS5TozPFJjcvDE+EHwcXukNrBmr7WxaBU9XUXXB95lk86MGAhB8URX
         BYnKbwgmfu/rC6M2myooId028qmq4GwpkIQHCPzT/pAfokCqg2VCvCykkNU+KeWhQIw1
         47lg==
X-Received: by 10.66.146.170 with SMTP id td10mr9855828pab.105.1393686406249;
        Sat, 01 Mar 2014 07:06:46 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id ug2sm40019506pac.21.2014.03.01.07.06.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Mar 2014 07:06:45 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243101>

Signed-off-by: Sun He <sunheehnus@gmail.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
---

 The general rule is if cache.h or git-compat-util.h is included,
 it is the first #include.

 I parsed all the source files, and find many files start with builtin.h.
 And git-compat-util.h is the first in it. So they don't need any change.

 sigchain.c and test-sigchain.c are started with "sigchain.h"
 I checked sigchain.h, and it didn't import any bug.
 But to keep consistant with general rule, we should take this patch.

 Thanks.

 sigchain.c      | 2 +-
 test-sigchain.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sigchain.c b/sigchain.c
index 1118b99..faa375d 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -1,5 +1,5 @@
-#include "sigchain.h"
 #include "cache.h"
+#include "sigchain.h"
 
 #define SIGCHAIN_MAX_SIGNALS 32
 
diff --git a/test-sigchain.c b/test-sigchain.c
index 42db234..e499fce 100644
--- a/test-sigchain.c
+++ b/test-sigchain.c
@@ -1,5 +1,5 @@
-#include "sigchain.h"
 #include "cache.h"
+#include "sigchain.h"
 
 #define X(f) \
 static void f(int sig) { \
-- 
1.9.0.138.g2de3478.dirty
