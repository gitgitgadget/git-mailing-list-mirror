Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A2D1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbcG3R0x (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:26:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33267 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so20039980wme.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skyl+RMxaOIRRThZWpy+4vdNIHjB1pHvUZRtc8hMGnY=;
        b=GnQjUeW2WXwhlIe8N7oEbfTWI6L8IymOFqF0dMazaW+hoQOYRKtV5OOHEwGuLPgkNn
         SVi8PcNidkpikWOhaMBPaWL9kEROcPNxNOVRF2of7IFP2WTz1eyuz4LJRR9Od5jEDOLJ
         BYsGRZYiGAVTfIWFdupoLZYLNoHFtrN0FmZ6gjAzvS7uM7C0H9GRcKddgD7/f0Cqx0bF
         d5CYMWaYLFEPfgUtNyi1ABBpivH8cfooCeLGbUl8AaMJiG+fWLkXj9JUMJ2wHhdzEVQv
         Co87zaxDqKSfIorjk5qTLawFO7Vs7SiceZ8+vrgQDjFTeN2BUrcGyxnlPxYNKnfBspDP
         dDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skyl+RMxaOIRRThZWpy+4vdNIHjB1pHvUZRtc8hMGnY=;
        b=UAAkmv/1qj8m/w/wtkF41b3aYJ607043mUftvXGkT3Vh3qsprbXXZge4hILbxmLMrf
         5W3+n132cnANGiYilovg7TZb9wSpvzIR6rZ6NmWOO5+4ybbSmU11qotJunlAkMDQOIBg
         tSnyHvNJoKz01KggSG2FUMXyACVFV2E/bKxXnj1/aQ3cJmGVSlj6iL1hPo/g1gPqZbe5
         olySL/iCZYM0sBkmwQM9wH9d7rkdfI7Wzp/hMBQ3Sodh9tx1H4QP5JnsPzm/kvfaNfl2
         oJGgP8OjshXTAX/ltqJHf7cB0AW351b26bnVHafa6nkwXOghQazK0tWpJfvyh0fk4i72
         iuxA==
X-Gm-Message-State: AEkoouskSA+4VU05hyj+DbGboG5hqYl5r6wRAGJkLTi6Pod1dU8hMK/7ykZ/KowJ1DqvPA==
X-Received: by 10.194.143.17 with SMTP id sa17mr41090662wjb.97.1469899558352;
        Sat, 30 Jul 2016 10:25:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:57 -0700 (PDT)
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
Subject: [PATCH v9 20/41] builtin/apply: make remove_file() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:48 +0200
Message-Id: <20160730172509.22939-21-chriscool@tuxfamily.org>
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
in "builtin/apply.c", remove_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6087195..6ffd4c0 100644
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
2.9.2.558.gf53e569

