Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D789A2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbcF0SZC (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33759 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcF0SZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id r201so26992915wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:24:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60o13a0Uk2WHlweNEip8W40bYC9M3A9kD0Dr/Dh2uN4=;
        b=IBO/M76VyqEgDYwC+sCilQiCS0WFByQmbN3Y7scFduVzt1JGEas/DCvVpwne7w01u2
         5rHF8eSqjkV/CeUbQ+8MI+QVQHmTF8P7eQJCO6lCVpxmg242Xe1TNbp+C+rQ32iBvD0O
         NEZ5+/+LLSA16jLDEcW/2zOkcOmZM28Z7qzhN3tvcOi10B36eoGVMvoztDpxbt4lp1l5
         AgAvpvg/8WF7AbsMj0PHImDudE5/6fiT7fi4Ms8pnU9qIdmDRKA4JQ0t7fuCGKDv0dJN
         SBYlv/Tvj1p/yWEDvZVthFxKySUomjUSfnj+V+HoGwcenjr9YKVwci9yBIHdBC9eQZD1
         z2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60o13a0Uk2WHlweNEip8W40bYC9M3A9kD0Dr/Dh2uN4=;
        b=F/FADVvHNTLWBHk+eDonRqfTZel/riPgv9wXqw8go+uIWKs7X6cqnKMlLpBsKhRa3z
         zXlBVW5QpIIfEzBJGmYXVyp5uQaBKKG2kw0eijfknOFT9HVSoRiipRBJKvCEd8MFFvz9
         9TE1F1xwKmL92wKexyzY6PKU6G7e0zbubNoao7n3/9ksVBFuu9MMyz3Vgu9bYCgSI2rM
         lTj8ecgl5/qfjkrPugyOtzBZTtTK5Ew2XMh95z+YtqFwv8f1HsXgfxDfm2YkN6vs+lI/
         pUjs74u8WyacYDGSU39xidrEKKA0ONuF/2GBOKE6KnRxXoJEYM6XTYgIBNutqdX9BKj0
         PKPg==
X-Gm-Message-State: ALyK8tLRYv1eiudH/NwURtC/m0cY5Ti5FWq6KD1PCx29XA1VCBGcujY9RnPuuSrsDBi6FQ==
X-Received: by 10.28.23.79 with SMTP id 76mr9773397wmx.93.1467051899193;
        Mon, 27 Jun 2016 11:24:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:24:58 -0700 (PDT)
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
Subject: [PATCH v8 06/41] builtin/apply: make parse_chunk() return a negative integer on error
Date:	Mon, 27 Jun 2016 20:23:54 +0200
Message-Id: <20160627182429.31550-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index aff0d66..b10a7e3 100644
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
2.9.0.172.gfb57a78

