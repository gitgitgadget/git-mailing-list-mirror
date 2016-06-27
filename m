Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F41A2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbcF0S0c (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36424 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcF0SZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id c82so26937791wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8lNUA7xFnd/a7tIXlDY+bgu4qSxv1fUig7LFcdapm9A=;
        b=RKB1bGFc4ylkc0J1DscdXkhs1Nmb3rn5opdGrzjyuXphPRTTcnIjd+xH7fsoVl7KH7
         bU83PthZf//NtdYM/uYZs8KtcYFidRnDNC7QTSJLtDZXBhZeRU0jNqL7B0aGU/kVoAyf
         EWmX/KeSG3Uvj+sxpsU4PEBhP5ffwy/bv095bnsdd8czEHzotRrvM6htljc3DYfLWf/L
         zLhIMRtnXttxN9i0tM6FNR8zb/nyB7cKS508r1xcgsdZ45P2r240Gt5MT0bvWnrWkC0A
         QK5F3BH3JbcZkTMpfg2m7hyBr3RsRBokwjzb6s1D6TtZqDk71vog03l9RhA9yMa7UwjP
         R9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8lNUA7xFnd/a7tIXlDY+bgu4qSxv1fUig7LFcdapm9A=;
        b=ii1Uq3fLHeodFyJ5an/uDirqx69SSmFwp7NHI8TbK5BLTrZLLGg5S8gjqGDbt26RE6
         syJAmkTI+gG7b9TGUExsQD0PQH5noF+qsVJ1qdSTLXNrXsrLhUfNG7X03Yiwe97B9oTJ
         8Gi+DrVHjOPfqn7lRCqURysrEr0UCTJ0QjVyUQyTF8fbI0bv73z5KdEyyy9XrFXFIawU
         e1vkL7y0llhTZ5u4pRv6TMONQ8up7nmFodfpxUTAY1sOj/Wpq/06/j1wtVxJ6FVTUNfc
         gnVL6nSzd7U3qvswO3wjLAxzdWX2v1ZVW3uA841zB8jHirRasGMzyPQClnivilKE/X7K
         wm5g==
X-Gm-Message-State: ALyK8tJFRc7RSVzK4HrqdOafOw0f5TD5bNMAWaY5l6ljTl3sNCaYnDgI+dWk0wdeEfc49w==
X-Received: by 10.28.144.80 with SMTP id s77mr12254288wmd.41.1467051910861;
        Mon, 27 Jun 2016 11:25:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:10 -0700 (PDT)
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
Subject: [PATCH v8 15/41] builtin/apply: make parse_traditional_patch() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:03 +0200
Message-Id: <20160627182429.31550-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 29ca524..174dbf3 100644
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
2.9.0.172.gfb57a78

