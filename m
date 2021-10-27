Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40152C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2900A60F70
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhJ0MG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbhJ0MGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DDC061767
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z14so3749392wrg.6
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tfO/DLvWqdwM405jxdcc6/bUU0BJV/ij1aINtW2Mnxk=;
        b=onwXlTJOTrOdNIFYoasGJD7phiEC97SpCePhIoaQ9mrJmA+41wu/IoKHPhQiugrkvN
         VX3kq46inYZeZGtUM9F8m5XOOvhhUl2MwPR67TY2dwu1Eo2lrb7h4lyIJF+XLkLyZ+Ka
         4UVmnxMZ2C8ew8skce3ZMdhUkoy62VPWcvmtYQS2LcrAGpevtaVzaYIIAur4SUwkRqB6
         8gfqkbbi1J0VLuaRvBa0lgbiqB59sQ6+LO2SdiZwK0CxyDsf4FS+BE94sdCSIg4MZMWz
         yc+0wiE+SUKvdUsODJ3Md8aOq+UR1NR9dxdb2QFYOKHHgAtbGMW0rLWkajH72KL4tjGi
         yj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tfO/DLvWqdwM405jxdcc6/bUU0BJV/ij1aINtW2Mnxk=;
        b=7LWt5mBl9XfbDlwkUQYXW9SLUwFIeYxdkjRBX34/I/LUDhIctD3/f2OoY3EPj8hso/
         G6ddlQ64Rq/kUxp7lglarISyda8RAK0rSgokxrp9/pLXCUDlYpbJT7yiYCnKY4yeUShB
         BrwiWVhM7r0db51wxogOxGrmmBnw1i8G3AwhdMDe0ON6w38hFtUDRuhEwH8NZuRnPJaJ
         8O01NWQ4aEA0Mn9d7z1svd4W5xis9r1LuYRWvEqbbi/ZnEow+DOSayMIdm/PTtAVYgZm
         ScKMbxw3iA7HW1m5aDx+B9qv3zpVuz5xwYENac/mXGiQUdJMrvlvsbFG+Oi0TnaYAILO
         4Hng==
X-Gm-Message-State: AOAM531hi2iejpnDHA/ZjhL0pSK/SbRTRPybMf/lsjNL6OyUJ6SjXMLs
        PNPlEWvgdINq4FW8ZsSUdvqTchE9HAc=
X-Google-Smtp-Source: ABdhPJyRLFYrhDJMruuQLuqRqLvtAMVywT2WqXG1CsSWuD/qHCSnVC/pevQwaC09E4/UusBrQZQNIg==
X-Received: by 2002:a05:6000:151:: with SMTP id r17mr12122331wrx.19.1635336267643;
        Wed, 27 Oct 2021 05:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm12151846wrv.55.2021.10.27.05.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:27 -0700 (PDT)
Message-Id: <a30f52d7f15e387836eb943ba081826b12a475a2.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:11 +0000
Subject: [PATCH v3 04/15] diff --color-moved: rewind when discarding pmb
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

diff --color-moved colors the two sides of the diff separately. It
walks through the diff and tries to find matches on the other side of
the diff for the current line. When it finds one or more matches it
starts a "potential moved block" (pmb) and marks the current line as
moved. Then as it walks through the diff it only looks for matches for
the current line in the lines following those in the pmb. When none of
the lines in the pmb match it checks how long the match is and if it
is too short it unmarks the lines as matched and goes back to finding
all the lines that match the current line. As the process of finding
matching lines restarts from the end of the block that was too short
it is possible to miss the start of a matching block on on side but
not the other. In the test added here "-two" would not be colored as
moved but "+two" would be.

Fix this by rewinding the current line when we reach the end of a
block that is too short. This is quadratic in the length of the
discarded block. While the discarded blocks are quite short on a large
diff this still has a significant impact on the performance of
--color-moved-ws=allow-indentation-change. The following commits
optimize the performance of the --color-moved machinery which
mitigates the performance impact of this commit. After the
optimization this commit has a negligible impact on performance.

Test                                                                 HEAD^               HEAD
------------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)    0.39 (0.34+0.04)  +2.6%
4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.76+0.03)    0.86 (0.82+0.04)  +7.5%
4002.3: diff --color-moved-ws=allow-indentation-change large change  14.22(14.17+0.04)   19.01(18.93+0.05) +33.7%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16 (1.06+0.09)    1.16 (1.07+0.07)  +0.0%
4002.5: log --color-moved --no-color-moved-ws                         1.31 (1.22+0.09)    1.32 (1.22+0.09)  +0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.61+0.09)    1.72 (1.63+0.08)  +0.6%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 28 ++++++++++++++++++-----
 t/t4015-diff-whitespace.sh | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 09af94e018c..1e1b5127d15 100644
--- a/diff.c
+++ b/diff.c
@@ -1205,7 +1205,15 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (!match) {
 			int i;
 
-			adjust_last_block(o, n, block_length);
+			if (!adjust_last_block(o, n, block_length) &&
+			    block_length > 1) {
+				/*
+				 * Rewind in case there is another match
+				 * starting at the second line of the block
+				 */
+				match = NULL;
+				n -= block_length;
+			}
 			for(i = 0; i < pmb_nr; i++)
 				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
@@ -1230,10 +1238,20 @@ static void mark_color_as_moved(struct diff_options *o,
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
 		if (pmb_nr == 0) {
-			fill_potential_moved_blocks(
-				o, hm, match, l, &pmb, &pmb_alloc, &pmb_nr);
-			if (adjust_last_block(o, n, block_length) &&
-			    pmb_nr && last_symbol != l->s)
+			int contiguous = adjust_last_block(o, n, block_length);
+
+			if (!contiguous && block_length > 1)
+				/*
+				 * Rewind in case there is another match
+				 * starting at the second line of the block
+				 */
+				n -= block_length;
+			else
+				fill_potential_moved_blocks(o, hm, match, l,
+							    &pmb, &pmb_alloc,
+							    &pmb_nr);
+
+			if (contiguous && pmb_nr && last_symbol != l->s)
 				flipped_block = (flipped_block + 1) % 2;
 			else
 				flipped_block = 0;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2c13b62d3c6..308dc136596 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1833,6 +1833,52 @@ test_expect_success '--color-moved treats adjacent blocks as separate for MIN_AL
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved rewinds for MIN_ALNUM_COUNT' '
+	git reset --hard &&
+	test_write_lines >file \
+		A B C one two three four five six seven D E F G H I J &&
+	git add file &&
+	test_write_lines >file \
+		one two A B C D E F G H I J two three four five six seven &&
+	git diff --color-moved=zebra -- file &&
+
+	git diff --color-moved=zebra --color -- file >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/file b/file<RESET>
+	<BOLD>--- a/file<RESET>
+	<BOLD>+++ b/file<RESET>
+	<CYAN>@@ -1,13 +1,8 @@<RESET>
+	<GREEN>+<RESET><GREEN>one<RESET>
+	<GREEN>+<RESET><GREEN>two<RESET>
+	 A<RESET>
+	 B<RESET>
+	 C<RESET>
+	<RED>-one<RESET>
+	<BOLD;MAGENTA>-two<RESET>
+	<BOLD;MAGENTA>-three<RESET>
+	<BOLD;MAGENTA>-four<RESET>
+	<BOLD;MAGENTA>-five<RESET>
+	<BOLD;MAGENTA>-six<RESET>
+	<BOLD;MAGENTA>-seven<RESET>
+	 D<RESET>
+	 E<RESET>
+	 F<RESET>
+	<CYAN>@@ -15,3 +10,9 @@<RESET> <RESET>G<RESET>
+	 H<RESET>
+	 I<RESET>
+	 J<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>two<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>three<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>four<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>five<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>six<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>seven<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
-- 
gitgitgadget

