Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE3C1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbcG3RZl (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36654 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbcG3RZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so20017356wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9elNAo/kC/JKC6s8iZrQ5wHl2LusooTmrCErecjyFcs=;
        b=IRepWZ6adggMMiwNZjYxTk+yr4wZ5EZNRq0brE4LS9K//k/gQp+O4p/XRBtHyPNrE5
         eRx4RToV0ybH0vstWHtEc4X2lSD7vGBYK2QxDV4dsJAomv5fZteesHjV0V8YuSAIeLn7
         mNmK2xTWMGYjlAP6XtQ05WDCavNcjum9DeQS28v3jG/v7hC49c58MOdTSY88WW/pTNZ+
         yWvK2hHsWpD9OBM0izPgNpnQ6eZG70JHTBSAZ6v6WnUlbcpFeT4r5e6zUGbiBQVM+N6p
         /Py8B1MNjFCx/XNATpdzyjp3LsMAZzfDx7cVRJJV+rR/T5aLvF4sKV0wsvq0zENKKQ/x
         PORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9elNAo/kC/JKC6s8iZrQ5wHl2LusooTmrCErecjyFcs=;
        b=RZd+JVqyKtVjKRJahr8moz7U1+EQQNWw2B1l0I+H0eVgNJDmNoNCm5aVBwZCLqyX//
         7DJhLgAQ4XZEJJMMaoaenx5/7YKCurO1YfWH6IlsyJujBfsvq/+8vIKhsdurXW0uzye1
         XSA/QYIVNVrBgusjCBnNF03w/+qYSavYQxOj6qs+6LaYAQmeVX/pDsl6btfkkXTX5g0c
         BLDsrB6EwCdQKZJUzgyGFrouaxHUqaxJ6VeRxbp6uLeDU4WKDXB1cGlk7/T5tRQsWTVf
         z/gf135acCv0g6BEiBkhnmmUIISk4GBG4ydVBvLPhieN7uHj8NouL6lYdvkIZnSklazC
         uagA==
X-Gm-Message-State: AEkoousEdCTa6abS/heiyQ5PVezd0dDhGivB5uZsVq4Ur5/2DjIfMxmfPlVKdWVm88M1HA==
X-Received: by 10.28.145.20 with SMTP id t20mr48178458wmd.74.1469899531191;
        Sat, 30 Jul 2016 10:25:31 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:30 -0700 (PDT)
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
Subject: [PATCH v9 06/41] builtin/apply: make parse_chunk() return a negative integer on error
Date:	Sat, 30 Jul 2016 19:24:34 +0200
Message-Id: <20160730172509.22939-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing or exit()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_chunk() should return a negative integer
instead of calling die() or exit().

As parse_chunk() is called only by apply_patch() which already
returns either -1 or -128 when an error happened, let's make it also
return -1 or -128.

This makes it compatible with what find_header() and parse_binary()
already return.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9e78758..5c73a37 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1996,22 +1996,22 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	return !state->has_include;
 }
 
-
 /*
  * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
- * Return the number of bytes consumed, so that the caller can call us
- * again for the next patch.
+ *
+ * Returns:
+ *   -1 if no header was found or parse_binary() failed,
+ *   -128 on another error,
+ *   the number of bytes consumed otherwise,
+ *     so that the caller can call us again for the next patch.
  */
 static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
-	if (offset == -128)
-		exit(128);
-
 	if (offset < 0)
 		return offset;
 
@@ -2071,8 +2071,10 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * empty to us here.
 		 */
 		if ((state->apply || state->check) &&
-		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state->linenr);
+		    (!patch->is_binary && !metadata_changes(patch))) {
+			error(_("patch with only garbage at line %d"), state->linenr);
+			return -128;
+		}
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4455,6 +4457,10 @@ static int apply_patch(struct apply_state *state,
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
+			if (nr == -128) {
+				res = -128;
+				goto end;
+			}
 			break;
 		}
 		if (state->apply_in_reverse)
-- 
2.9.2.558.gf53e569

