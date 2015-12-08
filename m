From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 4/8] update-index: move 'uc' var declaration
Date: Tue,  8 Dec 2015 18:15:12 +0100
Message-ID: <1449594916-21167-5-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:15:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lrm-0006Ji-RL
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbbLHRPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:48 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38499 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbLHRPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:46 -0500
Received: by wmec201 with SMTP id c201so38600606wme.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sJWFBfMciDYBYaCK8rWMUpajksUCXkiOAl8jHtT36bM=;
        b=A60XuCZ1xF5w3qAmz0s44//4ktwRYJp13oVOBJYiwXRQP3xkQFD/hA5tRFWNTaK1ER
         NGH4bzuqbEqrnOK+gmAHcbV2gbhNqNDT0ZRfkaGzZoM1yVj8RnkJxEDga7ZRb4uDazRX
         S8vBvuUj9U1dXKNHTUaj5lj2KnMk9Qc1P//uLukbWHmjr6CVSXu5XDFvu7tsoagxQfgi
         Gy51/q+2Gu6K/7qCWLzOekNsfPr0QAQgUdCeEItMCf9/7Iu9e8t4BvriJe2ML5HCOmTH
         owfzOI5FYQR8xNdBSbj/ELMkmpTwdgWppeC4OZdTXowh1jfAbIW9c7HfX711dfLzq+y3
         30eA==
X-Received: by 10.194.75.202 with SMTP id e10mr806196wjw.160.1449594944803;
        Tue, 08 Dec 2015 09:15:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:43 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282161>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ecb685d..21f74b2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1116,8 +1116,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
 	if (untracked_cache > NO_UC) {
-		struct untracked_cache *uc;
-
 		if (untracked_cache < FORCE_UC) {
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
2.6.3.478.g9f95483.dirty
