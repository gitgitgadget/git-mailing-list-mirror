Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9E81F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbcIDUTX (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35483 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbcIDUTS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so10466244wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HBVQLXV9kKer063v7ZFZVt8HhYkXJmfbH4n+2c+zXnY=;
        b=Hd8alMXyc/vvDyMQtd2WEGDf3uEIMivYLNSvazmwDbWSTzpFWTEWtaIjbQjgjWg+bJ
         pYznMAxgNFTWQYrZRifElGxwG+qvi6LhWrSqNATfxv+zcKbCi9NrOgJTHfClqT8qpc9G
         BhIUyT4mNE+0+0j2wQbGeTCZ/GHfM+rKGdRZd6NkjCkLuF9C3OJ5aHvIBkVkZxoE2HO0
         CrpKMRa3V1CdTnjd2Ya0PZt2ZnMrVMeMomTCR+8kTq6CC1zJcM/a68ogIhiVIkdk0INr
         n7/X3R/vhJStdkYULfBtROl3iqw4QqtSIsQOiirkDqZN5WlAxGhurOvngr6jFN0PjBof
         HSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HBVQLXV9kKer063v7ZFZVt8HhYkXJmfbH4n+2c+zXnY=;
        b=cAFdPIzlnNQFi9MbJjhMfFqSCSPKEZ3QSiiABfCJxA7Z0j/Qaq8Ma0X8CRC64QwzWe
         U7IoP1Med6kUBcDUH733bnnt/I0l+o2w+a7JjoQvldgGJ2jYNQ3EYeOk6UPkQu9Ch2LG
         Fvj2FZQsMw4w/xkN84+dYMby0j0KSC/qCZlPJxI3ME6UW+O+snXkJ2Ubb7lvYGalFtm8
         1jAhpYahLbgR4sk6hIcOJmS13IoZrXx0m+YkDuTZKQT0VQSNFIb+yBwdKNqN2Uuf9lJq
         RDl+GIl/p5rnmS+VQtzHDrAF81oNlgwkLWOl//SFUV/I4U/N66uLj/H2LLgm5JH1pALR
         0NGA==
X-Gm-Message-State: AE9vXwPC5eKLJqW/eSojKeRBzqvwUI0m0GWEVv1NaOKL495I5D4/sAzclt+B07BAe/bVJA==
X-Received: by 10.28.18.149 with SMTP id 143mr11720903wms.28.1473020356404;
        Sun, 04 Sep 2016 13:19:16 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:15 -0700 (PDT)
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
Subject: [PATCH v14 20/41] builtin/apply: make remove_file() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:12 +0200
Message-Id: <20160904201833.21676-21-chriscool@tuxfamily.org>
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
in "builtin/apply.c", remove_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 575981b..27fb6e2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4085,17 +4085,18 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 	}
 }
 
-static void remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
+static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
-			die(_("unable to remove %s from index"), patch->old_name);
+			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
 	}
+	return 0;
 }
 
 static void add_index_file(struct apply_state *state,
@@ -4274,8 +4275,10 @@ static void write_out_one_result(struct apply_state *state,
 				 int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0)
-			remove_file(state, patch, 1);
+		if (phase == 0) {
+			if (remove_file(state, patch, 1))
+				exit(128);
+		}
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
@@ -4287,8 +4290,10 @@ static void write_out_one_result(struct apply_state *state,
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0)
-		remove_file(state, patch, patch->is_rename);
+	if (phase == 0) {
+		if (remove_file(state, patch, patch->is_rename))
+			exit(128);
+	}
 	if (phase == 1)
 		create_file(state, patch);
 }
-- 
2.10.0.41.g9df52c3

