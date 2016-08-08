Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBACC20193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbcHHVE0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36195 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbcHHVEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so317534wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9PRjCsQb29hr8sbR0eNxJpp1BFh5TxRZigKjS9c2jg=;
        b=fZ2RDrHci1Wulf1wawDaWWVQJ7Y94dAyd+W9Q7dPGeW8yWUJLUXasp+7/KdL9kFhgp
         0AKIyN1NwxNWkU+kr7wtbNO54G9H4C1efC6B+oMOdqpsIrIwc2LBKobZnugd/4Lkh6B0
         nICTPhl/dHr5B0Bc1DT3LEywYWK+eSjGDfTZMgYnE04+exfuvlNU7Ja4G1uFllIcVepo
         fBZjSHY0wyfITZqjgf3Xo3Oj2UrcVV/QEjBVhEIIHY43GDqV05R3KPM1s/NFjKi1FAcs
         3zlzx2un1NIDu5IJzaeGR6isULYsce7J6q6V+/y682z0PZ3uuwtRjoV3AfVCSNTQ8fup
         zCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9PRjCsQb29hr8sbR0eNxJpp1BFh5TxRZigKjS9c2jg=;
        b=d0Llibi1HftWBSHwZgRlfv6FgKAgEneUEnIZPSmjmcX2tG+n26UpMVHRpbGyl1IQ4u
         chXo8TS/PvpwFIB3roN8ZZkeUXhKwVlfr2kcgc0f6xQJlb22DnXHaXt17LS99W1YGisQ
         xFcQ7O5iTPZN15nafDSL4uzQTsfxFvs9kJMvfuGDeB6WZCXQ375j7p3sSI2f5UYg0O9y
         7r14l9uo4vCL50Gr+iDtEQUG3OrejJ72YpHMS+TfbmmM9NQ1Ix52G2azpw4gzCVGbDMY
         KLa9CNhi1nc9us88FIPZLj7eRVjePKoaJSJ20GtRFhb5rXdP83G0319mAW8ohNUWAhP5
         TDRA==
X-Gm-Message-State: AEkoouuIVH0rEncZxM6+PGtmahVNrddxt/9D2KbcIlsIUN9EaEHaeYXifUBsp+mZ0YU1/Q==
X-Received: by 10.194.38.166 with SMTP id h6mr86950751wjk.101.1470690258845;
        Mon, 08 Aug 2016 14:04:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:18 -0700 (PDT)
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
Subject: [PATCH v10 20/40] builtin/apply: make remove_file() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:17 +0200
Message-Id: <20160808210337.5038-21-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

