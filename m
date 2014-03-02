From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v3] Place cache.h at the first place to match general rule
Date: Sun,  2 Mar 2014 16:31:41 +0800
Message-ID: <1393749101-14985-1-git-send-email-sunheehnus@gmail.com>
Cc: sunshine@sunshineco.com, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 09:33:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK1pk-0005WJ-OU
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 09:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaCBIdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 03:33:11 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39166 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaCBIdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 03:33:10 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so2567495pad.13
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Q0S6WGaykM6BYWijWYiGBu/6sqLir+XlliV2BRQp/PA=;
        b=kEfZjbcVjM0lv/dGh5c+v8N1GUbmZHNHZg8ykRXc8ls61TSVqbCIubbbahjCQ3KRhb
         TUsLlqfyKR70z8D7VkFv5YZPqDAdxdklSIZwqVO7vpn7lwPu3fOVBSICbSp25Plalbdj
         O5L74MLQSDVNiBiT9D1OlAdvzHIlU7nXJm4C0ygpen6MqihVfbyySo0xwyiwQwZwtemf
         KYqvm6PcqD5LUOEHf0zvxrMkfP0CBHBw1rdPCEyx+Q9IGtJXL34y4TiHDXZrufmndcnf
         zzKQ5B3AscZEVM+NGhoa8uTPvtU/qSAx7ULR4eIhO/FMRdD8+GtH3AOEsH3MQAu8OGv0
         54pw==
X-Received: by 10.66.232.40 with SMTP id tl8mr91110pac.137.1393749189415;
        Sun, 02 Mar 2014 00:33:09 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id gg3sm1128363pbc.34.2014.03.02.00.33.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Mar 2014 00:33:08 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243139>

 The general rule is if cache.h or git-compat-util.h is included,
 it is the first #include.
 As builtin.h starts with git-compat-util.h, files that start with builtin.h
 are not changed.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Sun He <sunheehnus@gmail.com>
---

 "PATCH v3" fix the position of information I want to convey to readers,
 with the directions of Eric Sunshine.

 sigchain.c and test-sigchain.c are started with "sigchain.h"
 I checked sigchain.h, and it didn't import any bug.
 But to keep consistant with general rule, we should take this patch.

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
