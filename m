Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483C22061A
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbcHHVEt (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33099 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbcHHVE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so17872300wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0YFA/LR9xof1Q71nNwBsxcEGq7jWi+/QGfY8f7OHwg=;
        b=iIYK7x7EgSxXHkld3Q3ahFZxIl9FMA6W1hPnidtUGnP6eGBUAnxO16UKq/C6H3LLqQ
         UqCPSD/ulj3ImBDn/prGFB6frLwqPpdFHVPz/G+xpUnxjHo0c9c55eWmE0fOQlzAyP8t
         G3HhwWvrqtpv3ik3/yvmhw3ZLbUhkByU1VXkaeWZg7IQUDDNovEnVkQFP8G6kdDi2w6M
         FWD1KNxQZlyreN+kKt3JXFvZqxn1tE4hvqRY7Lxc4HETYx7voe5tvwkM5pP5ca3pQZbE
         B2rvMS6vOFzDAbv0UIdx8gkC8wuueAd37tNOSAtz6BPQA7ro+6wO0MfOZBoevXLcauWf
         skdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0YFA/LR9xof1Q71nNwBsxcEGq7jWi+/QGfY8f7OHwg=;
        b=istUQRBCw1kE2F4xhqYD8FX6I0WZ9HpALVSxe3bK14fVL3c8WidEJoKmfv7nKDvV+r
         Iio7wNH0kxrqqSU6e7wkdNdJfcFAv8wLkKSj9tdMc+buGmNHGtL0bNKvclabvvaWbxQc
         vxMaYl9kPDhcsasu+Ri0R3aDYQaATGDgYh7MaQvPGLCWYe735QfsQIyUtBpuUxlDLhNC
         8QtnGC71q8jTeu2lgxRISDATBkC7JIknaEB7gt+A47Er5A3mP/8/q6FzU68uob1AhK86
         M5zWytaR6D8FvqCbbOVXTbVBbIAAixVAMLjgi2MM5UALYpkmSh2lovDl5FeNhsySANNa
         qYAw==
X-Gm-Message-State: AEkoousmKa+WWmxNmwaO+MVp+bGNX3rLUTFqq1DQ+rofflGSKRgiZqIijJuKrHUoCFLEzQ==
X-Received: by 10.28.193.77 with SMTP id r74mr17311196wmf.13.1470690265607;
        Mon, 08 Aug 2016 14:04:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:24 -0700 (PDT)
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
Subject: [PATCH v10 24/40] builtin/apply: make write_out_one_result() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:21 +0200
Message-Id: <20160808210337.5038-25-chriscool@tuxfamily.org>
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
in "builtin/apply.c", write_out_one_result() should just return what
remove_file() and create_file() are returning instead of calling
exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fdfeab0..003acec 100644
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
2.9.2.614.g4980f51

