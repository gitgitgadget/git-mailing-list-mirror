Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B196B2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcF0SZo (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35707 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcF0SZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so26931134wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U0IDaThPpX6X+gnKUGLiu7d47rgvilpMOsd5AHAVb3I=;
        b=hJoQj9FGWVL0KcD388UWM3KdhKCSL0MCHW97uNVrW118r3TMfv1s5xd/UgbS6zn3DS
         TGBQxUfmzIn2ABk4XLjPtjG19fjbsXHPGdlQxwi7os4OeFYuCSLzjoUMyGYP0yzlVigY
         earCqWwGTm/IOVpYIJEiytAs2XWby9gtATD8x2IwgqrYu4t3XrVNzayaCv9M2CR6UrJA
         /v4v1FNhixDrnUaoiXYDXhNDgDBn2DvLla83wCEnauBJdKwXEv8/RyNUU/9duPQbhCeZ
         EGyeWpzUgzDGDahQN0W47g+L5xr38SwElj9LoxcEc+hgvndBcIwTe7jjZ+2N6IDNMPOG
         cWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U0IDaThPpX6X+gnKUGLiu7d47rgvilpMOsd5AHAVb3I=;
        b=dyn48R+j/V3KusjpeVl9XS2GFTsWUCX+yTuoXlyHN5vVxiTgPTIjiqY0laaelR1wpp
         EHpWTupjdNia5oRhlOPFf4xdURYtdknXWMH/TbIEJFZfx6XMm13VOEac8oYe3Gz9m7jM
         S18vcrM7c6hSrWtZjpiQxT+or4HZfFcfECiwmDijTfi1b4MKqY5Nt5jtkHChOBSJ0TC+
         40TqrFagbAZPL7HHXo9xBq2Dst2hOMVKMUgliEbGC4FESdiuqDtsJX6d+NZPk4Jq9S0J
         TKMCdy1kI/q7wRnhWs4mLro4S/2BZasZDmizEoH+k8mbfu9BSagGc4hlPgPRp/VD5y14
         jTDA==
X-Gm-Message-State: ALyK8tJfkPiIs8POwa8wfSZzzoUanMEc+5kPTexa2mc+VCrs2CfHxbF///joMcq9U7FZpQ==
X-Received: by 10.194.139.162 with SMTP id qz2mr2104461wjb.111.1467051923233;
        Mon, 27 Jun 2016 11:25:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:22 -0700 (PDT)
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
Subject: [PATCH v8 24/41] builtin/apply: make write_out_one_result() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:12 +0200
Message-Id: <20160627182429.31550-25-chriscool@tuxfamily.org>
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
in "builtin/apply.c", write_out_one_result() should just return what
remove_file() and create_file() are returning instead of calling
exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bce3988..6ec87e6 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4287,36 +4287,29 @@ static int create_file(struct apply_state *state, struct patch *patch)
 }
 
 /* phase zero is to remove, phase one is to create */
-static void write_out_one_result(struct apply_state *state,
-				 struct patch *patch,
-				 int phase)
+static int write_out_one_result(struct apply_state *state,
+				struct patch *patch,
+				int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0) {
-			if (remove_file(state, patch, 1))
-				exit(128);
-		}
-		return;
+		if (phase == 0)
+			return remove_file(state, patch, 1);
+		return 0;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1) {
-			if (create_file(state, patch))
-				exit(128);
-		}
-		return;
+		if (phase == 1)
+			return create_file(state, patch);
+		return 0;
 	}
 	/*
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0) {
-		if (remove_file(state, patch, patch->is_rename))
-			exit(128);
-	}
-	if (phase == 1) {
-		if (create_file(state, patch))
-			exit(128);
-	}
+	if (phase == 0)
+		return remove_file(state, patch, patch->is_rename);
+	if (phase == 1)
+		return create_file(state, patch);
+	return 0;
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
@@ -4403,7 +4396,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(state, l, phase);
+				if (write_out_one_result(state, l, phase))
+					exit(128);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
-- 
2.9.0.172.gfb57a78

