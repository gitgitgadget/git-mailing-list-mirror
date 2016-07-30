Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9BA1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbcG3Rhd (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:37:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35467 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbcG3Rhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:37:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so20069099wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:37:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=umxQZICc9CA0PuxsAGxDHbAkXxYu/2iTFt/jNBV1YbU=;
        b=xUEY3QFjGR1cYCUzZo5Jfiv4DMcWVr0lhmG8hT5/eeOdeWRJrDSt6Sw57yUdXR6Lbz
         ILJGWsff5XBq9HDHvkKGJzGY+H8vuHFXmzA0c1mxL6v+Ms/w5YgXBQGjflHWjo+ntQnj
         Wi4pr3kg40uAyUHX+bVZ4hm8GQdzzeTXTPyNGP9QJn1R7uL4oiLJkhc1kmy4x2Juqa7p
         SzRPTUHAZF+jZxRwfaP2Bl0+moPWjqA07NkfcPEniozZ8MDY10tyykzUOY5XonvXMy2I
         psqq5iIndMeYJ3hqXd43WCyvA0W9Mn4+WZnrE3r+Lj+SPRlLnHd5Kdymev4fsmnh3JPW
         OQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=umxQZICc9CA0PuxsAGxDHbAkXxYu/2iTFt/jNBV1YbU=;
        b=Cs9b2nAMjdsdq0RbAPbr0vJl1v8b9nH1pIe7mp2fRDgfSP0f7lbgzfWY54YS33RJyy
         sRpz9LAReglMhFHFDL0fT0gjy7TikB+1Kz4Ef3L+QZkb07rZcZYjfBbcZw/dskasySct
         yXoXrO74b1aFqvlfNUjH/ojXxzD/mImoehBF++FES1n2GveXIDuIr5/VHeRc+EyKSW3/
         aFwc/OQGoDJthqPu6dHKlpaKJGoGVEHgOCw8GUaJG3w6/wGI/sx+wZXa2PMe4YvBwpcs
         iBLXszmchjGYgQ04pX3FJqY0OdsllUbiERLE5TR5f8lK5gC7LxEtj9ch8MCZDC9QufFN
         gomA==
X-Gm-Message-State: AEkooutM6wElpQ38NQyiXq3xqKR9WsE0KUM/dl1Q8MBDVfQvmv4YXvk/i1eMcyjIpoQaig==
X-Received: by 10.28.145.5 with SMTP id t5mr6579534wmd.10.1469899550628;
        Sat, 30 Jul 2016 10:25:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:49 -0700 (PDT)
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
Subject: [PATCH v9 15/41] builtin/apply: make parse_traditional_patch() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:43 +0200
Message-Id: <20160730172509.22939-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 84dcf41..0148c2e 100644
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
2.9.2.558.gf53e569

