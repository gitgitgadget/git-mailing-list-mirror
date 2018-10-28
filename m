Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D798F1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 15:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJ2ARK (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 20:17:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33536 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeJ2ARJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 20:17:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so5424204ljz.0
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HliBdmhb4lQ8/7AHNyArX7dYYLgIHQwDO60/hA/x2Y=;
        b=CLBsKy3qb12saEY62d8i3SaIZAxyNXwnfTlONBZ3YQ/vr639+7diaxlpImbKQVPg44
         ETwHes2jzGFERNUdGGexGSjEttnsz0fBWonM+cu7aiFFv6WEwbeBu/h2Mf2FljXfJrNa
         iRXEkN6Z0CQeRXTSnzXISS3oUgqXkL7TMqXx/Nz4ct54dzks0FPOfuKkwHiiiIsSFN2j
         qeFINylTMFq2KX24siDh9X0AW6mnfUGqD5nlt+jz63r5X91MhKWWsWrsPiwN5IHXxDd5
         ZPVZ1Piux6T7DKHoAvfSqw3rznokKsQH7EZndmMazc1dUs5kXuipgDF9obbX0f5OyD0C
         1f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HliBdmhb4lQ8/7AHNyArX7dYYLgIHQwDO60/hA/x2Y=;
        b=sVjHu0VfRwlBGqeBPxbgkqgWI5/UCPSzo5NeGy5OkoVR+EO3pE+MBoUGREXYcAjkkz
         LDWPkTVuybOCf9Wvl0qn+BtTyL1BauIWWgLmfsxxT8KeqXQJul1kvu7Ax5gYiMhZVX9Y
         sA3UA7bTtFT1MHVM12h5GSQBijlT6e4z6U4UZed5Uue29s0bicC9YNWXFf72XlfgRG+T
         oS/4hlM4g9CBvCZuM+Dmh9cFuMzXSrUJotjKXUFvRv+Kkqdishl/jIulGJKKZPBQnYlN
         Y7L00XXLkW/F8I5kYE4gKoovGEwoXRNQejH54XRJaKMZJCYRXStLon9SqRNDjQoLY/Rw
         a6wg==
X-Gm-Message-State: AGRZ1gLImYuiSz7OL4AGMdPyMuloTrdwtjoA5Qwds6sPso2Yyk/QF0Y/
        XhqDTvn97VJ1I+/p2Al711cWIjVl
X-Google-Smtp-Source: AJdET5c+bSz72O0RWYuqu5+7JZEbvIdu3APuTpr7k2K2PqeTDno4apHVNm+/FzVU1c0koLSWzsX2Aw==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr5958798ljb.153.1540740733110;
        Sun, 28 Oct 2018 08:32:13 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c19sm32835lfg.86.2018.10.28.08.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 08:32:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] sequencer: clarify intention to break out of loop
Date:   Sun, 28 Oct 2018 16:31:45 +0100
Message-Id: <20181028153145.25734-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.1.593.gc670b1f876.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we find a space, we set `len = i`, which gives us the answer we are
looking for, but which also breaks out of the loop through these steps:

  1. `len = i`

  2. `i = i + 1`

  3. Is `i < len`? No, so break out.

Since `i` is signed, step 2 is undefined if `i` has the value `INT_MAX`.
It can't actually have that value, but that doesn't stop my copy of gcc
7.3.0 from throwing the following:

> sequencer.c:2853:3: error: assuming signed overflow does not occur when
> assuming that (X + c) < X is always false [-Werror=strict-overflow]
>    for (i = 0; i < len; i++)
>    ^~~

That is, the compiler has realized that the code is essentially
evaluating "(len + 1) < len" and that for `len = INT_MAX`, this is
undefined behavior. What it hasn't figured out is that if `i` and `len`
are both `INT_MAX` after step 1, then `len` must have had a value larger
than `INT_MAX` before that step, which it can't have had.

Let's be explicit about breaking out of the loop. This helps the
compiler grok our intention. As a bonus, it might make it (even) more
obvious to human readers that the loop stops at the first space.

While at it, reduce the scope of `i`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0c164d5f98..a351638ad9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2829,7 +2829,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	struct tree_desc desc;
 	struct tree *tree;
 	struct unpack_trees_options unpack_tree_opts;
-	int ret = 0, i;
+	int ret = 0;
 
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
@@ -2849,10 +2849,14 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 		}
 		oidcpy(&oid, &opts->squash_onto);
 	} else {
+		int i;
 		/* Determine the length of the label */
-		for (i = 0; i < len; i++)
-			if (isspace(name[i]))
+		for (i = 0; i < len; i++) {
+			if (isspace(name[i])) {
 				len = i;
+				break;
+			}
+		}
 
 		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 		if (get_oid(ref_name.buf, &oid) &&
-- 
2.19.1.593.gc670b1f876.dirty

