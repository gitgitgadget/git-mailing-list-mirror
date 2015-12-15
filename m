From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 04/10] update-index: move 'uc' var declaration
Date: Tue, 15 Dec 2015 17:28:21 +0100
Message-ID: <1450196907-17805-5-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTT-00041v-0E
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbbLOQ3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:08 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33215 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbbLOQ3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:05 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so103093767wmn.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wLhenWTIDRZfwTpP91Ka+5TcKE0MWKdP5GcGtQq7K+s=;
        b=T3zTcS+bP5ZHmjOs4/Q1zGhJ89F8qZ0JNWZxTvc7dpkM+LvbeE/2R+Fq+PdxUD9Ojv
         FsOuEJwKoDaSVP99vpHzFbS2s+25+94Qpy/IP34+UUSlksJJNDXq0HDRoK+xCVmL66nG
         wJjL8UmgU1Jjz2eoCRpttwsnM6Ynzw4xMQsOj63BvcKO8wh8ebaZLx0bv1EeVl0mIlXr
         U/WKMsrSTc50ivBJQWbyvOvh7ja9jFnmn6iaa7pw6p4E3D9cRbiLWMx04Sjee565KItC
         dg3rhg25qCgoJ44NWEXNt9FG3Ux8+yfYyfbNPh4wi/2eAP4Gob4HaVlbdUZxC/PK1mt1
         N0xA==
X-Received: by 10.195.18.6 with SMTP id gi6mr49164521wjd.83.1450196944612;
        Tue, 15 Dec 2015 08:29:04 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:03 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282483>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e84674f..fffad79 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1116,8 +1116,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
 	if (untracked_cache > UC_DISABLE) {
-		struct untracked_cache *uc;
-
 		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
@@ -1126,7 +1124,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				return 0;
 		}
 		if (!the_index.untracked) {
-			uc = xcalloc(1, sizeof(*uc));
+			struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 			strbuf_init(&uc->ident, 100);
 			uc->exclude_per_dir = ".gitignore";
 			/* should be the same flags used by git-status */
-- 
2.6.3.479.g8eb29d4
