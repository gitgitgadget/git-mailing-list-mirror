Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A401F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbcG3R1J (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36829 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so20018850wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/KqzjUZMmTK4Ki4i4U3OiR+/qtcM8CDAUHG9YfHM828=;
        b=qODb6O58MttEMjy0rVXTyrKpmevid+kaokfkKorxFW57umzYRMQWYUNijh6PjNxENX
         eg1HjB7fJG+FXsaD0N2CQTM5Id9q8J1gP26Ldy9/UDV8vGngpZouQz4td3LR/euKh+4h
         1nsPlipOjFrWTJGb42hw+Whwff+xa3OQlgJZDl3xHzAZ1dhu6b+/yt/eixkAsCDle3Sf
         XYakJG/JXrYaQh3C36a78kprcFSFjwX0d1+yg8bpDRgwlfXoe+D3sVsER3GKgoehLSwf
         xxwLlZuzGgLB49rgj6xOkTThNSz/HUsTxBDXiSnidqwMeVAKuG8Mp/W6owoy/oZ748dJ
         lmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/KqzjUZMmTK4Ki4i4U3OiR+/qtcM8CDAUHG9YfHM828=;
        b=aL7mh7nIAH3mE4BS3pf1Qehxw+iUR4q/GIItZhZwNKacD5B8f1V8w1q+JPEeq12is3
         fkJYdOch3KrOuiDBI07/CPfshS9W4xqnJDi/5zrIvOv2fMjdyrqg2aQni1KhfEuE8LgZ
         NlLwng9zPY8LRodrbjm1/cT+CdQ/oroxG3grL9Z7wcxbFJTwTyV6DNifhJ0mPyOPmWC+
         nARu5IL/tZ29rZ6/HmuIplyuCQplw7HGlUn3xqX8YXIhtmbbu0ZCmMPbNsXbOSs7iUM6
         t+qA09gPeYuITQXeqtrz6gCLh9984l5n93XPZ8ZweJ/0gw2vUzDl1XL7jQKitPHA6MYz
         Tn8w==
X-Gm-Message-State: AEkooutULwZ+ovOkjtr7CPYItuC4kyhFC4HCYiZdq4BZAxt3Rw5CuJurAqFciVxOXMur7Q==
X-Received: by 10.194.61.205 with SMTP id s13mr42675139wjr.86.1469899567863;
        Sat, 30 Jul 2016 10:26:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:07 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 27/41] builtin/apply: make create_one_file() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:55 +0200
Message-Id: <20160730172509.22939-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", create_one_file() should return -1 instead of
calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dbf0372..7165abd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4195,32 +4195,36 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
  * We optimistically assume that the directories exist,
  * which is true 99% of the time anyway. If they don't,
  * we create them and try again.
+ *
+ * Returns:
+ *   -1 on error
+ *   0 otherwise
  */
-static void create_one_file(struct apply_state *state,
-			    char *path,
-			    unsigned mode,
-			    const char *buf,
-			    unsigned long size)
+static int create_one_file(struct apply_state *state,
+			   char *path,
+			   unsigned mode,
+			   const char *buf,
+			   unsigned long size)
 {
 	int res;
 
 	if (state->cached)
-		return;
+		return 0;
 
 	res = try_create_file(path, mode, buf, size);
 	if (res < 0)
-		exit(128);
+		return -1;
 	if (!res)
-		return;
+		return 0;
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
-			return;
+			return 0;
 		res = try_create_file(path, mode, buf, size);
 		if (res < 0)
-			exit(128);
+			return -1;
 		if (!res)
-			return;
+			return 0;
 	}
 
 	if (errno == EEXIST || errno == EACCES) {
@@ -4240,10 +4244,10 @@ static void create_one_file(struct apply_state *state,
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
 			res = try_create_file(newpath, mode, buf, size);
 			if (res < 0)
-				exit(128);
+				return -1;
 			if (!res) {
 				if (!rename(newpath, path))
-					return;
+					return 0;
 				unlink_or_warn(newpath);
 				break;
 			}
@@ -4252,7 +4256,8 @@ static void create_one_file(struct apply_state *state,
 			++nr;
 		}
 	}
-	die_errno(_("unable to write file '%s' mode %o"), path, mode);
+	return error_errno(_("unable to write file '%s' mode %o"),
+			   path, mode);
 }
 
 static int add_conflicted_stages_file(struct apply_state *state,
@@ -4297,7 +4302,8 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(state, path, mode, buf, size);
+	if (create_one_file(state, path, mode, buf, size))
+		return -1;
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-- 
2.9.2.558.gf53e569

