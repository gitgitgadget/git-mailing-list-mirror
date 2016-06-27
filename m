Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4302018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbcF0S0a (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36786 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcF0SZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so26939830wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQyBrvvBuyMeujieZXqAvsE+9h1j3GascjJrHHCCCAo=;
        b=u0TxLByP0ItAmFduiwCLmp5ymr9fa5foHlxcw1fgs1+Usw8ZU2ZYEdjVt6ftFevksr
         usnDVj3/5lfQNGh8OPqmWXHykX/CrQzBnQPMw4Wpl6I3u43b14nvXvnmC1/pcE4iR7uk
         mT9z01TvPAqaRO0PnXykFHlAdQ2x9HiPUYrbdh2ge8WkzD2n815V1sDi56NrGK7uzsEw
         x8sqwhT3UWOSqvNSMP6jjoOIPvzIgOIQWp+IgLSxuJzUUkkcm4gHkak8qvWNF3QtnUBX
         YFmzlq8cvU2sJnbGCYkpeFBYgUlMcF3gWwdfxGdTlA68XwxXcF+N9uKNYBMfJDUYGNT3
         mJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQyBrvvBuyMeujieZXqAvsE+9h1j3GascjJrHHCCCAo=;
        b=IKVplXfM4UxiJu4CWetZqt5w3t1glZspWJq4B2DOxATn45vwOUk/svVxuwlxNXj4nl
         AUkSg5pt1m8UP5uzz1jWv0qC2iP4/DU2X4mUCM0GL+xHd0xFpsxJ1rV8JRhlBDguJVP7
         yyvwpC8WpL2jfKFOLOZHdovU/pZ65BfNNBdoUgZnM1URbu3HLHsBx7JqPUDnxTFQVxcv
         rzCyY/v8guhkIgvGdWVBmN4WDArGSauAxsZYdS4fRz1Ypf0BsY//YJkuanczzjgPFMd2
         pWC3Czebc+3s/ZvuO5VbQdFJzc+lNd/231YVbisRDQW23ZLkk0XGL0++agtfOKzSgs1o
         NUkQ==
X-Gm-Message-State: ALyK8tIx5fPRADxpLULocQstAOBAQVGoaLfxDFJ5TCBwK015YeAJTzCIzemZO+++VzEfMw==
X-Received: by 10.194.201.102 with SMTP id jz6mr2090043wjc.101.1467051926980;
        Mon, 27 Jun 2016 11:25:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:26 -0700 (PDT)
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
Subject: [PATCH v8 27/41] builtin/apply: make create_one_file() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:15 +0200
Message-Id: <20160627182429.31550-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index 651a057..5c67713 100644
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
2.9.0.172.gfb57a78

