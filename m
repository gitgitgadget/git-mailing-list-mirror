Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E37EC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E3460E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhJ0MHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbhJ0MHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7896DC061232
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o14so3703017wra.12
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PvZWtTB+saRNvbTicS6KSTgR/AzyDN0INgP6F8z97h4=;
        b=FVyy1oielz0DttBRrAUnUcMmGZMxVwUaEtv84y69Yi0UHfHDKB97ooxGv75c7fqSR8
         Zuk/F30c+IJKl1gOgxarWLNG6KHtJWjO2RB/ZRAu4LqD3ZQBF1WCUHvkcr+8AOz6gwWX
         t3o2VKcE0h1G1ftQ4WfSvqonvwEptOoTF8tBxxDbJ4ynNnlN+7JKKMy58SOblkr00jw9
         wJeNFZB5/3faHgtvFIsAQ8WMV4BwnUrVlxICyxLyT649drXuVGoLCSsVCa6SkdTlPewU
         M5xwm2lPWj57LN/9mrWGNI3KXY251aCOKHx7wzg1UzDYIwZB6WoRqIwD1kD4loetWLi6
         7Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PvZWtTB+saRNvbTicS6KSTgR/AzyDN0INgP6F8z97h4=;
        b=Z7/adLXmrCo5RkJ29889UyDBPSybNo4tCB72goE+2r02aI9/coYOekAPx3VROKykpO
         kZwP/fVeeyaqTe/0PRbV+KUtpYWdb8D3ocPudUf1HUijb/jW5ETWeBdVgSLK0fgVBRe9
         aL4rSFXY7rbGeVh9cXLN8AjU4SimnS2kwVHR60Q7VZOqxo8uDyrxg2KkeX+460Mz3ItQ
         KrGUWACVKlrieD35XOQ6N1vtwdGNEstZ98Rd2EvCrmU/DrwS+eOdPwPQj0rs9dVpPT0o
         HnHELbAmxqYjsIGPxJw1NePazeErOGuYHbxhBNbHNzgj6B0at80xI4ry7blsko6ejSow
         ct3g==
X-Gm-Message-State: AOAM530nEZG9Z8ACsAeIyznShUC9Vy6N6tYPAXDwI3S/j1EJ05QkqJE9
        x5qOtgvBnzv6/eMZ03bCszTnpVsqF0c=
X-Google-Smtp-Source: ABdhPJxklGNAyAM241GyThpAB1nGo509M+yprdz0/4METYWQbWSZIomNqKMEvICzRpAkxiag7ngIWA==
X-Received: by 2002:a5d:6103:: with SMTP id v3mr37470182wrt.335.1635336275068;
        Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm3375925wmc.47.2021.10.27.05.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:34 -0700 (PDT)
Message-Id: <078c04d4a66c51acdb3477b49813a9dc1c144f15.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:18 +0000
Subject: [PATCH v3 11/15] diff --color-moved: shrink potential moved blocks as
 we go
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than setting `match` to NULL and then looping over the list of
potential matched blocks for a second time to remove blocks with no
matches just filter out the blocks with no matches as we go.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 44 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index 51f092e724e..626fd47aa0e 100644
--- a/diff.c
+++ b/diff.c
@@ -996,12 +996,12 @@ static void add_lines_to_move_detection(struct diff_options *o,
 static void pmb_advance_or_null(struct diff_options *o,
 				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
-				int pmb_nr)
+				int *pmb_nr)
 {
-	int i;
+	int i, j;
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	for (i = 0; i < pmb_nr; i++) {
+	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1015,38 +1015,12 @@ static void pmb_advance_or_null(struct diff_options *o,
 			match = cur &&
 				xdiff_compare_lines(cur->es->line, cur->es->len,
 						    l->line, l->len, flags);
-		if (match)
-			pmb[i].match = cur;
-		else
-			moved_block_clear(&pmb[i]);
-	}
-}
-
-static int shrink_potential_moved_blocks(struct moved_block *pmb,
-					 int pmb_nr)
-{
-	int lp, rp;
-
-	/* Shrink the set of potential block to the remaining running */
-	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
-		while (lp < pmb_nr && pmb[lp].match)
-			lp++;
-		/* lp points at the first NULL now */
-
-		while (rp > -1 && !pmb[rp].match)
-			rp--;
-		/* rp points at the last non-NULL */
-
-		if (lp < pmb_nr && rp > -1 && lp < rp) {
-			pmb[lp] = pmb[rp];
-			memset(&pmb[rp], 0, sizeof(pmb[rp]));
-			rp--;
-			lp++;
+		if (match) {
+			pmb[j] = pmb[i];
+			pmb[j++].match = cur;
 		}
 	}
-
-	/* Remember the number of running sets */
-	return rp + 1;
+	*pmb_nr = j;
 }
 
 static void fill_potential_moved_blocks(struct diff_options *o,
@@ -1181,9 +1155,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		pmb_advance_or_null(o, l, pmb, pmb_nr);
-
-		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, &pmb_nr);
 
 		if (pmb_nr == 0) {
 			int contiguous = adjust_last_block(o, n, block_length);
-- 
gitgitgadget

