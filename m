Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB0C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiGSSdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiGSSdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:33:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DF5A2DD
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c22so1301035wmr.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2uRRWueLbS1MmS8wlJxUl94o4kalllPCtK153o7kM6c=;
        b=g6QIVwVwCk4chWdA3x9RAuUgpOld2qUUTKHxodxzA+ISjGoRy8ulq5xtyc9bSIwc7N
         VW5JTdCLr8yI0WTem2VFdvBpEUIPnR3H1W2+YRozlJAuG2QW2ruUDJWCgNI793FX+Eg0
         it+dvQ4/yyzUtNXqLyo4mC8feI4ilR7TYoKS251lPW+cnzjBYTKmSrDmEDe9cQCbDwcr
         9ui50/UqhZrBDl32uKq1hy9vFgrilTqveTm/OTd1Pzb6E8Xf55SfSM/IhIezm8ybXAyv
         HkblIO7lHUtr+OsR3WVRgvMt/ZfAMXLdzXvrcM2Lc5hiI8fYv2TrKhKc6D715X0yQzmH
         P6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2uRRWueLbS1MmS8wlJxUl94o4kalllPCtK153o7kM6c=;
        b=XmKFGJplNiefCe6tUZBhYLyPYHsMHNdCwZd1lpqVZL02cRw24StUqXm2q3rQL4PftH
         J89eeefOQXuQCNYazbQz91hJwTD0JGDpOIsXyEJ3S5kItSqrI9/zKfw49lVoJzDsrqKw
         CpyC0x0w7NswOVwxNhVRuAOZt5KdHCya2Hphu5IqnkdOE3cz/ap3liH/MIfwj5XivZ1A
         ++EJA0XVRw1Wm5pdjiQ0s7KxJz4cEyuow3TqUjedQcI5V+tAQAKGA9/wWNOKu58M9/HI
         CwKPrEZhyWe1ybr4wocw8XXFDs7bgMS9PxvhBUmk8CRR3V2VkFnEC2z1kYOjuGmKq9gi
         U4lQ==
X-Gm-Message-State: AJIora9ZGRvlePgSlnuXGWJCLs+tI/TwMgeCihsPNrP3e5zYZREaeoLY
        +LwLuSwARQslr4dZbi2y7aZW2YYjKeI=
X-Google-Smtp-Source: AGRyM1uzhZ7i1tlGJwF4dwC3K9KM0Jpyhf0OxI4SZ5Q/Ryp4N+HYzzATAiVRLZ4CbhPRWXdbeqywfA==
X-Received: by 2002:a1c:730c:0:b0:3a2:fd70:ee3 with SMTP id d12-20020a1c730c000000b003a2fd700ee3mr542762wmb.168.1658255629226;
        Tue, 19 Jul 2022 11:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdb92000000b0021e43b4edf0sm1257267wri.20.2022.07.19.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:48 -0700 (PDT)
Message-Id: <540a3be256f8a0ca57ae0ed90cc04190a28e91e1.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:34 +0000
Subject: [PATCH v5 02/12] t2407: test branches currently using apply backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The tests in t2407 that verify the branch_checked_out() helper in the
case of bisects and rebases were added by 9347303db89 (branch: check for
bisects and rebases, 2022-06-08). However, that commit failed to check
for rebases that are using the 'apply' backend.

Add a test that checks the apply backend. The implementation was already
correct here, but it is good to have regression tests before modifying
the implementation further.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t2407-worktree-heads.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 100ab286d5c..a67ce5fb003 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -61,7 +61,17 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
 	grep "cannot force update the branch '\''wt-4'\'' checked out at.*wt-4" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase' '
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (apply)' '
+	test_when_finished git -C wt-2 rebase --abort &&
+
+	# This will fail part-way through due to a conflict.
+	test_must_fail git -C wt-2 rebase --apply conflict-2 &&
+
+	test_must_fail git branch -f wt-2 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
+'
+
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (merge)' '
 	test_when_finished git -C wt-2 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
-- 
gitgitgadget

