Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3058A2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcHHVEd (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36283 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcHHVEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so318289wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ua1c4Q4SqMxOPF/MZwtQqV5Me30Xpff6Fw1zwQovzgY=;
        b=qgA41LpKmxCQ/U5+0oNtRzpPs2rfFeeprapu9B4hbdPLJTeMN0OqFNxqKRDGU/eDzc
         KE8/FEdZ7kEWpF0Q5O/n3CfYwMHJfe+KC+G4wuLkn2Wu/EODmH/VVu86FdhON82pjxfc
         6LwE3ulYyjzemYPmOrlqhH9eifiJRIrLvgpt2OlZppEEmVN58SYg48MrLzbdbw/2dA8K
         QiAMu4Knn2G6Uo6GDV6xXAiMuv/ysLZQt1jtKjvYO0p8+z3tKKOcV3z6037nMo0QAT8z
         1tNhyPUBM58Klj1ZhvRu7gIi5x/l7u8TBz/njzdGXOYNzDDM4Tneg+nvjr6jj9vv/eSY
         iHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ua1c4Q4SqMxOPF/MZwtQqV5Me30Xpff6Fw1zwQovzgY=;
        b=iWLma9vjYvOeoLe11YjGKF/IrWILY5bYj5mi15bl80kgc79eXn9FVU86+5TKbgay+o
         nl6fc/ZwpVJdijgslN+3zg5fzlfk7YUiH+UPbu984uVgzn7E4hGINGtX3LaliIRbjYL+
         d21bbSFRNWhQokap/Zmf9hNTxNJMQSvUAMfV3u+THCaC5jBro7kQOrGXLD69qdgbTrBd
         myNboWeqEN1k+g2Z/gP9mqyp90eWG5Y7GNSmETHLG7J3yS+wgZCETlyex4k499ktWUb3
         2R+nU96Osoq3azYbP0iWSC1LowqQbpYzmeiYuMTKNVIVTjPPCufL/DPl5wnH6l+YPpJB
         Crlw==
X-Gm-Message-State: AEkoouuhV8OwAjKywQoh5wOEWPNqjmn6rmFvFuSt897kJ3lKVrixeYUc1x+QBT5SWkRTLg==
X-Received: by 10.194.145.103 with SMTP id st7mr85004876wjb.61.1470690269456;
        Mon, 08 Aug 2016 14:04:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:28 -0700 (PDT)
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
Subject: [PATCH v10 27/40] builtin/apply: make create_one_file() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:24 +0200
Message-Id: <20160808210337.5038-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 9372999..ad403f8 100644
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
2.9.2.614.g4980f51

