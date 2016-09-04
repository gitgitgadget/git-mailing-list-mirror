Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6A91F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932464AbcIDUUa (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35379 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbcIDUS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so10465388wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4jpX3Y2IBG+IsVKUUbz2boD49elHOnU5SySimFMhP+0=;
        b=N+hCmBX+BLMrve0pOcdDdrFJDi3raniQkbCP06n3Ie6PH32rjWkIT1uNEpxgytlM7x
         NW9Q+MGF2lebCgf0OM2dx38xKXv/RI1jBacK0cnH9bOHUbZFTKmC93I8omN4auvoT+RC
         nKOxlsUJpe8mjBpSEHOoytwEnveLw0Tx/aG5SnGGV5YX0xiRU2E7kg5YhYRWdQED6fuQ
         6dxA81iodg3KvbKLtE9mPcBGeAqBFRbZvXqwOEW8X3iSh1ukJbZ/OmZuHzl+b9LkwDHO
         OrnrUK2Exyole9+nBdlzxgN8ZTF58qRVQGffTSyeU8eYaC1s5sgy5vvJp355uMQO/LMF
         SxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4jpX3Y2IBG+IsVKUUbz2boD49elHOnU5SySimFMhP+0=;
        b=MjzbtEoTvSiMZr0P5phIH8Wa0VhbgyKJF/U6+IiBKpU+eVJ3rl9KFKzAL4J0WknOiS
         SMbCtv7mHa5F7aOO9RzkPgd8GRROpXratdFGjDZOgJHq4PZlnTvQd84NDXBzhCKrti7E
         NZOj607SAqjU6lNF6IF0Yay2za2i/R2bIJReS5jBgCf6AHNewlOKZGj8jEVmvp+5dCpf
         Qf26PLuu/NV0u4SMgBduDMgl/m6Jb2eKaOtmktT33/I4Jk6kzC0fHtj6IBqydOfUUmXD
         0KBaXNd9DWrxTkTqO7gmeyjhfu5ddhxvnhjVpdjS0wISHC4sxJBjg/sGSYvAZgprpMdg
         rXkw==
X-Gm-Message-State: AE9vXwPgNaYNFvHOktHIBaGdO++asbugPMlyZqVIiQ+azeAlXg5uVdYYQNQGAsi8xBYcjg==
X-Received: by 10.194.236.68 with SMTP id us4mr27302158wjc.12.1473020332859;
        Sun, 04 Sep 2016 13:18:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:52 -0700 (PDT)
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
Subject: [PATCH v14 06/41] builtin/apply: make parse_chunk() return a negative integer on error
Date:   Sun,  4 Sep 2016 22:17:58 +0200
Message-Id: <20160904201833.21676-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.10.0.41.g9df52c3

