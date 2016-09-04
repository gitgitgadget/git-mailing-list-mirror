Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36B81F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbcIDUTm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34099 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbcIDUTc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id w12so959781wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R4KGj0OM2I1nxy7EwrCS5KxLcKb2dLA3WyrcYHZpZJ4=;
        b=rad+rEGcYt8aumrnuRcxJu1CiPxy6KBWlkhM/By1bTIkY+pnJpiJThaqEhjPJPbQMe
         bynqGebFSByBSTX9UDXN4UU6RZdRs7/reV93zkwHDHXKpSMA+J6XE9CHMjGdaAU4Y1js
         bGgrSSo8k86Ml4/dwEV7G2gMtmnWvJbMr+lWprv3rsqI+2naHiHK0TNiulrbQWyLQf5g
         iPGoRIu6LmtdB9+evNtF0pFbbrIXerzg2pSna+mnIYwWytOwYGrceiIY/3Wf63PxiFwp
         4GN5WCdxujuuQxIbCXl+m8aAPqWWSa+0D4Wc8+TqgICzYg5GqGTUFR3HPJpof69706gU
         MAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R4KGj0OM2I1nxy7EwrCS5KxLcKb2dLA3WyrcYHZpZJ4=;
        b=QWveORWxgDgy+eobkbVdcgo7v2mCfnj9Q4/59VdtO95cH840JlKr67PmbJE+kqxg2A
         i8d0KlesmAlOVHnx3VXeUqbqn1sZKiZhr9bZoUZKtCazJUIExokLCrAKlGfCUIsimSTR
         w4Yew7fvVQv0M8X35hFR6cQEM2W641De4rwHknr/eDi8pO0JpubnPK01igILCCeM2ee+
         mNDyt4Zm3lt+LlkJiq5TvZnJoQt2/XlswvOvbvlh7YoVx18ukkSHync8Z8gTDX5O1QHb
         fglubLsg4O4DHcT7AmFEF/XXJ4ehUT/iYya+uHO5DmoFvWO1seseZom7Uu+F/CPAo/TJ
         HoIQ==
X-Gm-Message-State: AE9vXwNOzqCtJw/VIMdHBdTHeAM+fmuVeTZ74J3FJcuPVlw3klNzO6XshNRRyGUojPCe2A==
X-Received: by 10.195.12.163 with SMTP id er3mr30482017wjd.49.1473020366213;
        Sun, 04 Sep 2016 13:19:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 27/41] builtin/apply: make create_one_file() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:19 +0200
Message-Id: <20160904201833.21676-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 3145e03..5cd7fd8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4198,32 +4198,36 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
@@ -4243,10 +4247,10 @@ static void create_one_file(struct apply_state *state,
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
@@ -4255,7 +4259,8 @@ static void create_one_file(struct apply_state *state,
 			++nr;
 		}
 	}
-	die_errno(_("unable to write file '%s' mode %o"), path, mode);
+	return error_errno(_("unable to write file '%s' mode %o"),
+			   path, mode);
 }
 
 static int add_conflicted_stages_file(struct apply_state *state,
@@ -4300,7 +4305,8 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(state, path, mode, buf, size);
+	if (create_one_file(state, path, mode, buf, size))
+		return -1;
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-- 
2.10.0.41.g9df52c3

