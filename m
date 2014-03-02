From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v2] Place cache.h at the first place to match general rule
Date: Sun,  2 Mar 2014 10:18:17 +0800
Message-ID: <1393726697-2816-1-git-send-email-sunheehnus@gmail.com>
Cc: sandals@crustytoothpaste.net, psclouds@gmail.com,
	Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:19:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJw0U-00078A-07
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbaCBCTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 21:19:52 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64800 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaCBCTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:19:51 -0500
Received: by mail-pa0-f50.google.com with SMTP id kq14so2366203pab.23
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QBwjxz+PyrSE3MeynCnTkJZY4OUFV266qqHF9s6rdN0=;
        b=vPOhIyk4vnnO1w+4D1qz8CA8P8FW2mACppiosXf55dciNBq4+PZZ2f5Sl60PTVN8e4
         LMxshErMN1LcGLDooarU59yt0kjs+1yhblOCN1jp2Eow72Upcrsf32KG8b2F9Y0kWrrL
         0s49MY6mMD7Rmd/lrth9b7uy0x8WY+gqP6iS30q8CfcLZG7+H8XhxunMkZEXBh9bNias
         py1UvU4iwM9aTkHJUBcPVEyJKBQaiUe+OUcd+oHCNaYN4vy76LftboK3/zE9FmP5YOFL
         Hdm1PngQAqzgvM9d+CPdmjVy4AvSDfhCODwUCWtAAyu2hZ3hf0FUTUXbedRxblSA+p5J
         46CQ==
X-Received: by 10.68.176.65 with SMTP id cg1mr35171pbc.145.1393726791238;
        Sat, 01 Mar 2014 18:19:51 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id oa3sm20858743pbb.15.2014.03.01.18.19.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Mar 2014 18:19:50 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243117>

Signed-off-by: Sun He <sunheehnus@gmail.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
---

 "PATCH v2" Fix the spelling bug of general in subject as is suggested
 by brain m.calson <sandals@crustytoothpaste.net>

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
