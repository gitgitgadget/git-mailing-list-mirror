Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1214F20193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbcIDUTM (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36201 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbcIDUTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so2666045wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e0ErflTtGVRIh4CzXc3ne7UpNuOlX9d0n+7DM6lSQdQ=;
        b=QMYm+YXCn7vuaEZPSj4NDC7/jJ4b7opFNMOQgQSUkV8HDh5WYjr5c4qtSuMCrChv9N
         N2IgVr08r1MSOlcUydiOam6WzNVWCJBshUrC9Bmx+Ub2SP9fktZNK6mcfrw2nYY2iMbT
         BfDTicUUNFOBsnWCJm1hsLT4WNhrNrL5yU9L3LSz8VWABUKVEWFmi7q1az2UtWoqx/si
         QSkToN5vrRM66IkREed+IhICgf7BMA73uXwdILiWAl2a4QgR5NmyXuX0YUodUINdBJri
         bI6LUSUjJqXJY+W7mKb43OJE1k5kSCEnizU9pzRguq/bVWYHOfngCeLnrC4nQKnWOLmc
         D21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0ErflTtGVRIh4CzXc3ne7UpNuOlX9d0n+7DM6lSQdQ=;
        b=DFrzQwLX9QKvJNHGKfJ+1vE7ntSdqn5LcHTR9nF+CC0C/deoil8Xf60zLfcXcDhCjG
         UC1iCklyAdUf++e70bD1vtgTm9xFLbqJeGbAzVdsHWGQTzQjDuQfJkmwkrRnUamxBbdN
         L+e6vecAXNnzLm/d9TN6w+TaCXpg2r6XWXmSBFHVmE+WOtcS/ypKLsIOP50xCe4i4O58
         /dIxqHclkOrtktQg7IGYoQBvRxnQ0zTOdRoR+qbtHqovxLDRqMs484LorpLUaVfkotpE
         NviE2h+hQsmkzgyrXNJKCoBOCDPqwyVH7WHtivobr+Wd+lvnZGENPemnjkKqgcBqABYm
         txPQ==
X-Gm-Message-State: AE9vXwNiGppz5ZQ9zXh5FuMiohrfad30t7QK0IcMjh6V7kX1Zj+CUMKSRCzX2GXkkKiffg==
X-Received: by 10.194.236.68 with SMTP id us4mr27302589wjc.12.1473020347656;
        Sun, 04 Sep 2016 13:19:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:07 -0700 (PDT)
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
Subject: [PATCH v14 15/41] builtin/apply: make parse_traditional_patch() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:07 +0200
Message-Id: <20160904201833.21676-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_traditional_patch() should return -1
instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5530ba1..f99498b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -755,10 +755,10 @@ static int has_epoch_timestamp(const char *nameline)
  * files, we can happily check the index for a match, but for creating a
  * new file we should try to match whatever "patch" does. I have no idea.
  */
-static void parse_traditional_patch(struct apply_state *state,
-				    const char *first,
-				    const char *second,
-				    struct patch *patch)
+static int parse_traditional_patch(struct apply_state *state,
+				   const char *first,
+				   const char *second,
+				   struct patch *patch)
 {
 	char *name;
 
@@ -803,7 +803,9 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), state->linenr);
+		return error(_("unable to find filename in patch at line %d"), state->linenr);
+
+	return 0;
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -1467,7 +1469,8 @@ static int find_header(struct apply_state *state,
 			continue;
 
 		/* Ok, we'll consider it a patch */
-		parse_traditional_patch(state, line, line+len, patch);
+		if (parse_traditional_patch(state, line, line+len, patch))
+			return -128;
 		*hdrsize = len + nextlen;
 		state->linenr += 2;
 		return offset;
-- 
2.10.0.41.g9df52c3

