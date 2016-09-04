Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AA81F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbcIDUUO (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36400 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbcIDUTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so2667746wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jpQSvJw182szZe9i5pB3o9zQLNLq9WKA3RqukTyn/E=;
        b=mIiHXXTbB0Pd5V/OgH9kBPjhnPtEqX92GpirLBevs2K/pIdefTO6wbDbxjhPgd+u8x
         o0dGjbq7wG2oMw+W5tiMtdUHvbfJ983kytxq1IcS0L3bd6gtSbCGykzsTC5yWawwARL+
         Tig3Hnmh02R6fkZc5EXSfurDGztDjpcrBPBZcQ/kWMWyWS4UZttCDoVvvfhzL9BZWgIo
         LCzAI9QQ/oxUhgxrFEAuFIz5Bu6kYB5qS6vj2DgWKHQMF5x8LFyQ18ihX7Owg1G5Ti5n
         ZPQnLaHaVxV2MMfKLCkI4FxsGm3qPn/hSEpxMGBRosE0ap+2kWfgjcACye0HICwWIQ2p
         RZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jpQSvJw182szZe9i5pB3o9zQLNLq9WKA3RqukTyn/E=;
        b=BknZEuylE78fRmUAWS94pUJ+AK/DaiD1f2AG+4D6H0hMj8NJRk8Q2+DWO2RD+dFwfX
         hM9NQVgLJuXslRhc+PxLJE18oYWY7YnFOUTZ8J4D9oPChg0cIHI4V+ADt7Ir7RIjswHT
         ruLXmAvLOgxYuqXeZ1/MICmdY4NAjh8ripc8ddKqTG9o3t4uiVXFutPUuJBH8t7qfQwI
         qhD6FP4/41PEtnVj+owacUNh5VO4hDnw+c61sluRAo4fiR1rIVU8SZvIGLnujM1hVcAo
         yv7haG9IkobyD1z0VICAnVRJUAkVkeibOHHXBBQaHGKTuFJbJ4FNjFS7NFc09s63PPTI
         Jf5A==
X-Gm-Message-State: AE9vXwPZ4Rv/gPs3PfMUn8M/vMUg5cctmnSBXdV10iyvW6iAVoSZi0oPOQEl4v9nxQGMZA==
X-Received: by 10.194.85.18 with SMTP id d18mr27477891wjz.43.1473020393493;
        Sun, 04 Sep 2016 13:19:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:52 -0700 (PDT)
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
Subject: [PATCH v14 39/41] apply: pass apply state to build_fake_ancestor()
Date:   Sun,  4 Sep 2016 22:18:31 +0200
Message-Id: <20160904201833.21676-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify git apply functionality, we will need to read from a
different index file in get_current_sha1(). This index file will be
stored in "struct apply_state", so let's pass the state to
build_fake_ancestor() which will later pass it to get_current_sha1().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 2dad0db..f29387d 100644
--- a/apply.c
+++ b/apply.c
@@ -4042,7 +4042,7 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 }
 
 /* Build an index that contains the just the files needed for a 3way merge */
-static int build_fake_ancestor(struct patch *list, const char *filename)
+static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
 	struct patch *patch;
 	struct index_state result = { NULL };
@@ -4089,12 +4089,13 @@ static int build_fake_ancestor(struct patch *list, const char *filename)
 		}
 	}
 
-	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
 	res = write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
 
 	if (res)
-		return error("Could not write temporary index to %s", filename);
+		return error("Could not write temporary index to %s",
+			     state->fake_ancestor);
 
 	return 0;
 }
@@ -4709,7 +4710,7 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if (state->fake_ancestor &&
-	    build_fake_ancestor(list, state->fake_ancestor)) {
+	    build_fake_ancestor(state, list)) {
 		res = -128;
 		goto end;
 	}
-- 
2.10.0.41.g9df52c3

