Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2567B2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbcHHVEK (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36024 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbcHHVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so316121wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D5mUYdeMYhBbAFv7tHHRUHwE2w3J6S9ThKHh7llvc1k=;
        b=zPXiwD7nu74P/pdGsK2ET1Yo98/5nx3XbJHVsXltYP8ymG2VA82gwJpFn9FZO4wuae
         tFwhiBHUpiTq4R/Y+cMHk6TILMXh7juk65KASZd63LkEozwxe3HPeux0YGGFPGwsI0BS
         c9oUx/vG25v58skakKrpY2Uih73euEmSjYGCxDqxtnoLNjUOSRkdybQk/D1rstuMlq6d
         ryJbSNK/yD2f0BvgdbZIiQy72Z8uIdnPu5HSRw+Tz8Npkpt8SeZXkDrqb4C93TEVsPeP
         kH5CUJOc15uTHkwTv55RolOxmcW4lcmECQMkYeKLEGvuJXpDpNuh3fV6yOLJlVU/L5tl
         9XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D5mUYdeMYhBbAFv7tHHRUHwE2w3J6S9ThKHh7llvc1k=;
        b=a0I5jYsmRpTt8oCUK6ND5K296GdZ3JH+OtHmgdCv8R1SOfDHW/MEbhfLFnkeytcBMr
         EqI9ScxoSwNU6P3rcm6g7G5oZbAZd0s/ge6laJBW5VuZEcMEXDkC+QOgXdyn51iFeT/+
         RAfHYonVFHiIThlLCqUsb5CeJkjkFT7hPhkQar7Z/JaoiLCQa9Dx8+lbz/lCLkqHr7DB
         4I6/N3dX0WXvpf20M0nn4sfEaE6rQzQI42nSrbhQ3ElF69juTaZnHbEpNmvrRlfHEHFo
         dq/8yXJho0aTA8R9AVke+qx7//Xg2RL/REElzKbC3MzzIUTCJwn++dy/pkf2Uu8WRQ2W
         wNeA==
X-Gm-Message-State: AEkoousQAOE3zKOgG8C5scrUkACHxxKpr+pUXi0xCkgax84mErZDLOdHPhe219bshIne2w==
X-Received: by 10.194.43.9 with SMTP id s9mr36322113wjl.46.1470690240240;
        Mon, 08 Aug 2016 14:04:00 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:03:59 -0700 (PDT)
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
Subject: [PATCH v10 06/40] builtin/apply: make parse_chunk() return a negative integer on error
Date:	Mon,  8 Aug 2016 23:03:03 +0200
Message-Id: <20160808210337.5038-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 434ba0c..c07d142 100644
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
2.9.2.614.g4980f51

