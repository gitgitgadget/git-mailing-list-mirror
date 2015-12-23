From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 05/11] update-index: move 'uc' var declaration
Date: Wed, 23 Dec 2015 22:03:53 +0100
Message-ID: <1450904639-25592-6-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqaT-0008TJ-IY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454AbbLWVEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:40 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38800 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbbLWVEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:34 -0500
Received: by mail-wm0-f43.google.com with SMTP id l126so164249796wml.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WvMgRrxtqjeDJBLX2khuIUSRgQpjQnXhZVlgVy4zis=;
        b=tfZ0qalcbN7DvN482AF30/s7jxkdJXM218ap9uZAvBzDDuwnix2NJhZ8tutOCD8w8Y
         ypmI2EPZIrlHTwvm1dBX5LOn2A9WqUBI8g1ZksMuvHrKWq1LtbARGowcgcg1UHxAyWYT
         Ix2OlWi00wkx6f8tDLjcgGdWrcqBWmoc85fZl8fy0oljrXdvXHVp3jAmMFrCEVuElHFn
         uIgDjoaSu5bmVeFTGEthwbCjG5k7aIgc7cllhHbjzrYxdr2OzVnwoKBFNNj8MCQpLN01
         nfzhZ3xoeo3pNfnR2td/yLLWsdQAoURadJmAsU/TRQxfrKBQqJ1FQgUt93+YZGTk1eUR
         BRVw==
X-Received: by 10.194.178.70 with SMTP id cw6mr35866542wjc.73.1450904673748;
        Wed, 23 Dec 2015 13:04:33 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:32 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282960>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index c91e695..f667125 100644
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
2.7.0.rc2.11.g68ccdd4
