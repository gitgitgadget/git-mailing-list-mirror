Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86A720193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbcHHVEW (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35805 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcHHVEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so17865982wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SfNXGy8xn7cIzJfMFkf/xI/zMAC8NW3ZbspYfVKa2Oc=;
        b=zw75INHPY5PLciz8vTmz/3a0rGfgs2tJeQJ0QfgXC9RoKH0IqYuxb4i/xBPwkUEzb/
         /UgK7A1HWpl7mt5SgLXDs0Dwu+CFp8AybVAHOfBpvqcy8pwdfHc8Xvyu1OeyVNlUJx3l
         enwg680/lJBc7caNaCTcqE6TfcUl+bg7pJ7A01xeuS+4pGhcFRlpnz6TdI978XURqq8z
         584tMLgSc4f3JnYcJ1lat1d245wzJb5M0q5lRvXyIlvNmUFIqcx+MnlPSs69LPsLM+jG
         LWMctLOKaTY/6qAExIdAtxzUVGQFQSWtZQ2jEe0qP4sbAqFCn2CO3QHVwtc3BJL3pDLG
         uijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SfNXGy8xn7cIzJfMFkf/xI/zMAC8NW3ZbspYfVKa2Oc=;
        b=RYn2vU5ArsBfAlz46rJiArWyuqN7HXO8PTlcYB+0lNw0CY1qzVkMBGdrL/sb8smZIo
         ZaNO9zCiD59q/afXh9TS5Ci1+H4y7w0QmKBXDvTBE/M/asKL7724RwpVQDvtBEj0n57k
         INk6VTAVdcInqIjpQLsLQEPOpmupykRZFfNYjwrURMsC1HvZglJsr7JoISpq3pRmNqfT
         7dV8KemLUZAA7DNxKhBgMIYSN517HbkpPOXxZG/xugY1fVL1Hqj37Wu9Xpup/4U/WSHa
         qplg+ttvTWODg815dNzd0+GAKQnDa0NjOAwrWtJbEdsKpPGLp/wwVP18DdpEAMAJS0pE
         3X7g==
X-Gm-Message-State: AEkoout/Y8ftA5U5HzIN6Ae46rr/NcnDZ5KDeCG3WZVp0qVeJZe4jqAooiaPgxQt7is6ng==
X-Received: by 10.194.153.5 with SMTP id vc5mr86227257wjb.75.1470690252337;
        Mon, 08 Aug 2016 14:04:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:11 -0700 (PDT)
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
Subject: [PATCH v10 15/40] builtin/apply: make parse_traditional_patch() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:12 +0200
Message-Id: <20160808210337.5038-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

