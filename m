From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 3/8] update-index: move 'uc' var declaration
Date: Tue,  1 Dec 2015 21:31:34 +0100
Message-ID: <1449001899-18956-4-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbR-0008BN-OT
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbbLAUci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:38 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33689 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbbLAUcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:36 -0500
Received: by wmuu63 with SMTP id u63so5078649wmu.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zM+10dgxWSAc3rgETSyTTSM5+HoJm3mqWTTVMUTHDiY=;
        b=GaRxOsuvKMj/bVjjV1qm352LThfEFBVYD1vDxvz8EC8gtjaaYoGBxTdOX5Y1lbxzd3
         mENbfb4tAHkQ4QBQZx+KbxWyZJ8OFf9rJKrdTA3oKRUH3waJ+1sfnDXffaY8LFLV77GO
         HaNyFggwErhiozwaivv4l2No52IFy/JZ2ZCAH+PA7hPq9MtWxYHzMVttfTO4b3F9LLEk
         DrIwVYgOhwhLsQ9O4tmBTcyqfnB3JWwevz5EN79eIoS/PSRtYGPn2QBKx2kac3Cnq9gK
         CILQ4aekiaQcWgRkBc4LQdzw3PuOmN5sG1QTP5eSUL1BSaU396I5J9woLWsH2rh/Xoxi
         b9ag==
X-Received: by 10.194.20.35 with SMTP id k3mr83184428wje.19.1449001955060;
        Tue, 01 Dec 2015 12:32:35 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:34 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281848>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index b7b5108..b54ddc3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1107,8 +1107,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
 	if (untracked_cache > 0) {
-		struct untracked_cache *uc;
-
 		if (untracked_cache < 3) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
@@ -1117,7 +1115,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				return 0;
 		}
 		if (!the_index.untracked) {
-			uc = xcalloc(1, sizeof(*uc));
+			struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 			strbuf_init(&uc->ident, 100);
 			uc->exclude_per_dir = ".gitignore";
 			/* should be the same flags used by git-status */
-- 
2.6.3.391.g95a3a5c
