Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B992018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbcF0SZp (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35589 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbcF0SZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id a66so26930483wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HN1mFx92tsvSuTB/BogXx6voz0aL+XLSxFgv0qAPzBs=;
        b=cFT9kwxVNjr5jGQXoh8Gnoow5BSl2y+JtmAaK9QxZG1T2KTmz3F0AnmU8+ot/p5Qwz
         3Q2CWz7XyMreUhpL4xDhDkKg+d+xqyW0PWPSpf1Qs2uKTqwopcJTTBeLegRZbsORsBWs
         E81PLTH+S5t+XUE6y2IBVYckX0apb71+KJ70ICTpoP5IPTyzLT2olEPynf5TPbyWw0vg
         v6PwA924Ja+jI3gAirBd+fcNj6xllRj/1D/g+bvtID2LtDtV7XJH1IYg34E/5ENqzfye
         NJyG+dh+AwxROAdMFSAtYSo1F8TaySwsNgctdqdj1XceuDRh8p5QuXkIRAU/JGqVIK2g
         mcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HN1mFx92tsvSuTB/BogXx6voz0aL+XLSxFgv0qAPzBs=;
        b=VO1N1nCCEUXMrcepS2FO4oPjTzo76qRr19YfB7YF/1AlXFKg4VVBozFalFE4OFW8jY
         thMh0d2OTOFdED8c40cDlfgY0Tm09HmzxWTe7rheIYlY9vP/dmfAUNHamQv3mEf51gnf
         u2hPeswgRs26gb5zh5A9fvvX96Sj74DdTBqeoB9RJ551hI3fCZzslCct9DxWu0Rx06XJ
         islQGcI+KTCPgMxIS8AsEFUR9JJfRqHAdou+n3e2WfXgn7cFO8BzVKGSZPirn2kl2M/o
         tId10/cDgby8ljyAndptwrUDfyKCc3Kx3TEauijGYyG30cFDJUMpphxI3ZijvYO/emhP
         OdYg==
X-Gm-Message-State: ALyK8tKwZW0gLsN0kKkBlK8z8iJmP4SyXW5muOfXiSj+dyBUFlLjTBsKX5DS8NBR0Dk66Q==
X-Received: by 10.28.107.23 with SMTP id g23mr12673057wmc.101.1467051918007;
        Mon, 27 Jun 2016 11:25:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:17 -0700 (PDT)
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
Subject: [PATCH v8 20/41] builtin/apply: make remove_file() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:08 +0200
Message-Id: <20160627182429.31550-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index bb1dffa..cb3ef1c 100644
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
2.9.0.172.gfb57a78

