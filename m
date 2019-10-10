Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A2B1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 11:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbfJJLwu (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 07:52:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37840 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733091AbfJJLwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 07:52:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so3513608pgi.4
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Do0uWJ8fVLJjOhGWXLsVICWqohEVIscZxF0WUUQ+LU=;
        b=dzLpSyLEKHFF+fe1tXPA9vCpz+4H34ByOPhaygHCMNqY3b3u/2r/mWYOK5+wsqtqDi
         rApg4So6cUp8yKxgqaGo25Lz21Oaz+7YrtpWx8b37ISM0BhZYJNUr9L5XgBx24BwGBt1
         q738rjKRS+SlX8BIHop4FU2pJP73zg/VxUzTsjr5UZp01pe3oprltlX29LlWDjIQ5JWD
         RV0sBARmHii/szVnDXK0Tvb3SMFVcvS1LljDtVx9fvqcR1dFmhgRm9fG/Xy6xBN6o14B
         rS7oEAN1TdlKbHWJuRUmCKo0MnhzfFRg0FAlh1jyV0ZKXbXM+KmelhBFDeeZCjrrtf4u
         wgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Do0uWJ8fVLJjOhGWXLsVICWqohEVIscZxF0WUUQ+LU=;
        b=nNp49NHQL2MxBmHP/91WSHlgAvJYpdgBDStF38IYqjI148pM0xdcsBB9Gu50y1kXAF
         OkTewtaH8PV5vzNcPjCPwX854z6I6OUcqVufh8ZRNuaEBli1WoycKHKns/kOao3Ygxgk
         R1jT91CubV+ZD7QbVS7z97YoXJAanYWwRxhc84hKsPHg5yNaN4Rj0t+R+KxPPBPXr8KP
         wVAmdZ0qnYhQHHO/bUackeL42LTDO9spuLACCynHa6Bt3dxnGTBthasr2/9zck7YoGbn
         2kvcGwtnFbdZDYqNvHEbh6mOslXnqpgXircWJ4GnUUER4C5/+0ekyn/LkB2F6GNfCdn5
         KOeA==
X-Gm-Message-State: APjAAAW2WxWmFODve4ChZ1pOYDMt6MCcJQq+pXLNFf4tsbE//K+tYG27
        Rim7IagNw8lHQEclZRthL1R4FUHkpMCYdg==
X-Google-Smtp-Source: APXvYqyqG8VqZx32QBFIiZ3zS9REBubo9FWqTw7h0PaQF94FRFxWReLydBamxxDUKnKi/2hgZN3gUg==
X-Received: by 2002:a65:6205:: with SMTP id d5mr10969320pgv.424.1570708368456;
        Thu, 10 Oct 2019 04:52:48 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id y2sm5431178pfe.126.2019.10.10.04.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:52:47 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Wambui Karuga <wambui.karugax@gmail.com>
Subject: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined constants to enums
Date:   Thu, 10 Oct 2019 14:52:30 +0300
Message-Id: <20191010115230.10623-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert pickaxe_blame preprocessor constants in blame.h to an enum.
Also replace previous instances of the constants with the new enum values.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 blame.c         |  8 ++++----
 blame.h         | 12 +++++++-----
 builtin/blame.c | 17 ++++++++---------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/blame.c b/blame.c
index 36a2e7ef11..4ad86d1217 100644
--- a/blame.c
+++ b/blame.c
@@ -2183,8 +2183,8 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	 * and this code needs to be after diff_setup_done(), which
 	 * usually makes find-copies-harder imply copy detection.
 	 */
-	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
-	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
+	if ((opt & BLAME_COPY_HARDEST)
+	    || ((opt & BLAME_COPY_HARDER)
 		&& (!porigin || strcmp(target->path, porigin->path))))
 		diff_opts.flags.find_copies_harder = 1;
 
@@ -2429,7 +2429,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	/*
 	 * Optionally find moves in parents' files.
 	 */
-	if (opt & PICKAXE_BLAME_MOVE) {
+	if (opt & BLAME_MOVE) {
 		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
 		if (origin->suspects) {
 			for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
@@ -2448,7 +2448,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	/*
 	 * Optionally find copies from parents' files.
 	 */
-	if (opt & PICKAXE_BLAME_COPY) {
+	if (opt & BLAME_COPY) {
 		if (sb->copy_score > sb->move_score)
 			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
 		else if (sb->copy_score < sb->move_score) {
diff --git a/blame.h b/blame.h
index 4a9e1270b0..a4bbf3a8c5 100644
--- a/blame.h
+++ b/blame.h
@@ -8,14 +8,16 @@
 #include "prio-queue.h"
 #include "diff.h"
 
-#define PICKAXE_BLAME_MOVE		01
-#define PICKAXE_BLAME_COPY		02
-#define PICKAXE_BLAME_COPY_HARDER	04
-#define PICKAXE_BLAME_COPY_HARDEST	010
-
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40
 
+enum pickaxe_blame_action {
+	BLAME_MOVE = 01,
+	BLAME_COPY,
+	BLAME_COPY_HARDER = 04,
+	BLAME_COPY_HARDEST = 010,
+};
+
 /*
  * One blob in a commit that is being suspected
  */
diff --git a/builtin/blame.c b/builtin/blame.c
index b6534d4dea..fb71517b5c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -771,11 +771,11 @@ static int blame_copy_callback(const struct option *option, const char *arg, int
 	 * -C -C -C enables copy from existing files for
 	 *          everybody
 	 */
-	if (*opt & PICKAXE_BLAME_COPY_HARDER)
-		*opt |= PICKAXE_BLAME_COPY_HARDEST;
-	if (*opt & PICKAXE_BLAME_COPY)
-		*opt |= PICKAXE_BLAME_COPY_HARDER;
-	*opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
+	if (*opt & BLAME_COPY_HARDER)
+		*opt |= BLAME_COPY_HARDEST;
+	if (*opt & BLAME_COPY)
+		*opt |= BLAME_COPY_HARDER;
+	*opt |= BLAME_COPY | BLAME_MOVE;
 
 	if (arg)
 		blame_copy_score = parse_score(arg);
@@ -788,8 +788,7 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 
 	BUG_ON_OPT_NEG(unset);
 
-	*opt |= PICKAXE_BLAME_MOVE;
-
+	*opt |= BLAME_MOVE;
 	if (arg)
 		blame_move_score = parse_score(arg);
 	return 0;
@@ -993,8 +992,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	blame_date_width -= 1; /* strip the null */
 
 	if (revs.diffopt.flags.find_copies_harder)
-		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
-			PICKAXE_BLAME_COPY_HARDER);
+		opt |= (BLAME_COPY | BLAME_MOVE |
+			BLAME_COPY_HARDER);
 
 	/*
 	 * We have collected options unknown to us in argv[1..unk]
-- 
2.23.0

