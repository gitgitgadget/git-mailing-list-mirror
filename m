From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 05/11] update-index: move 'uc' var declaration
Date: Wed, 27 Jan 2016 07:58:01 +0100
Message-ID: <1453877887-11586-6-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOK9I-0002r4-G8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbcA0HEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:13 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38396 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbcA0HDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:48 -0500
Received: by mail-wm0-f53.google.com with SMTP id p63so11488223wmp.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wf1j2DdzLE9DISfhJ6XkTMcA8/DK2qbx/CsPW2dv6P4=;
        b=HLSrc2iLJHxOAaYO636vnDzT4PKOX1z4suBmpzTUwzYfl7LbmcBQrAg5QPRclCKZDZ
         rrZGW/DA8VB9e47L++W7tNQgzbzxEG0sWJ+F8NzX9sGtJ+ujNZB/AlTNs0+JKfPSlmun
         PWCT21KTCEMXoYN7BfnWsMjaa8cPur1MKdscOKDZBh95isym5J7VMkkL6ANJIHTyj8oL
         AZKzDy+WkyK4YfYSOapZv9LeNoJqJXQ1Q1fg282qBZWalpCm1SV5P1SuRX/hvW6Udpxg
         4m02k0skLqTrdWAbh20fqcp4FRJowySGhOVQ+0J0tbnq6MwtN2C6YkNljdRyRDXG5NGv
         qsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wf1j2DdzLE9DISfhJ6XkTMcA8/DK2qbx/CsPW2dv6P4=;
        b=a/qCMBC13xqr1IG7MX+0QGdJpah+l0a1162HdYFAQacErJwwhw2bftqEYZCbeY9VsK
         di/cDFxS3zSSPDx+GpfWFeVnj7DC2th5z8oBMmNA72y4GBwEpm8Q+6g/yE4Fx1zp7rkV
         Awn8505HAP+v6fngEYri/bD0FsA2fA0B6W3XCYCoz15EPKZaUjj/FAYg+r5psIe0Kbz2
         M+EDxDArRxF9M5FGMVEemBFD+lOkoHyOn5gPRHxfR1auy969u4rxoEcGTvXRSc2uYPDP
         USdvvwUh/JKMe9O313EILh7+8LL9ZafDGPFBgnjhGaCMmJMv5/RwKP71rSxHzfW106Hb
         yRyg==
X-Gm-Message-State: AG10YORv/2zq/dyywEJYJy5w6XT8hcQmA7qEE8RnojR3n81t9gdzUBzWRw7/UqXNC8bhHA==
X-Received: by 10.194.118.164 with SMTP id kn4mr32137584wjb.130.1453878227807;
        Tue, 26 Jan 2016 23:03:47 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:46 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284880>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 369c207..fe7aaa3 100644
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
2.7.0.181.g07d31f8
