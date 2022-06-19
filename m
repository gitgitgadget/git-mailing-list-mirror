Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FB6C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiFSQKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiFSQKf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 12:10:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C44644A
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 09:10:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g27so4942813wrb.10
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKCNsnSCIhezy1b739K/7TfpZEK8BIHI2EOZyRN4u/w=;
        b=D9Z002uncxDuKo0iZSFV+MrgsAB8LjkmI4C6WLU8/PD5uPaR4rlQqu5JwcP8oQ1umS
         DBjXnQsPwsdePUMXkmYRwnGzoiq8oqxyxa/q4uIBYcuRCrTrwSMdWGPYjqGK63VWO0K0
         Es9Hak8CiYnZupH8Hcvf95s0lazRBACW3ihPWdZ2kGyr12Fv2Ml45dCCDTfO6tjePDQP
         dFUcz/nXNnmxLLsKvtCHY1PEofwKav3/mcLMcUIQ5qa3cH7c16Fgd0FDwe1gnzAhubNa
         gGKW0GPGYUHHAFlrawMR0iezooQbjs8eanIlFHvgpNHZSIUA6nPSAc6c/13nU05wmnmS
         OW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IKCNsnSCIhezy1b739K/7TfpZEK8BIHI2EOZyRN4u/w=;
        b=4K0C9l3zMcS6avHVfOvD/DPWwA1PfvaB3SSUC9MkI/zsST2vicxEq+krwgNNMxlwrJ
         dIHBDKCbyOsyElOa9a+BMaT9PugdJyh8SvEh1yjh9lOjEKUNIfVSI/uT0Yr1+hZOwRT3
         vR1eiL98fI3tKXTldkuEBPtrLWixbsuseEkLGyTh8wli8jkHejAKFybFlmuI7fKVov/U
         n+5HxMftQ2ADupr4UBhXImiRucLcN0zWZvt9862JMmYRgh1WErobqjhXCzRrpCUNhQzk
         qSnnPBN6tulBZ6xQ/gEmCbtfAMIFnB+9+CQwGuCerWaNsEnpO4JQQRpseljMIi1faZWM
         VOrQ==
X-Gm-Message-State: AJIora/VpkpBFtzi8ILX9Xel601gumOutnL4MzxfT/VubQ1349V/nlNd
        5k1EaZxUGRbwc7bspwfG/6Oq+tRt7Witfw==
X-Google-Smtp-Source: AGRyM1vUMcd9OR52Ke2TvdEpv1edSS3PN1x5IEOkrsCxz7BD9yIhYg1eV9BbHAuGKI3/yDzMVwcFzA==
X-Received: by 2002:a5d:5342:0:b0:210:c508:956d with SMTP id t2-20020a5d5342000000b00210c508956dmr19292168wrv.205.1655655032256;
        Sun, 19 Jun 2022 09:10:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b00397342bcfb7sm13095955wmq.46.2022.06.19.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:10:31 -0700 (PDT)
Message-Id: <1226fbd3cafbe5202b576a2ca74f3cbf1f603f02.1655655027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
        <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 16:10:25 +0000
Subject: [PATCH v2 2/3] reset: new failing test for reset of case-insensitive
 duplicate in index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

On case-insensitive filesystems, where core.ignorecase is normally set,
the index is still case-sensitive, and surprising outcomes are possible
when the index contains states that cannot be represented on the file
system.

Add an "expect_failure" test to illustrate one such situation, where two
files differing only in case are in the index, and a "reset --hard" ends
up creating an unexpected worktree change.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7104-reset-hard.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index cf9697eba9a..55050ac831e 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -44,4 +44,15 @@ test_expect_success 'reset --hard did not corrupt index or cache-tree' '
 
 '
 
+test_expect_failure CASE_INSENSITIVE_FS 'reset --hard handles index-only case-insensitive duplicate' '
+	test_commit "initial" file1 "initial commit with file1" initial &&
+	file1blob=$(git rev-parse :file1) &&
+	git update-index --add --cacheinfo 100644,$file1blob,File1 &&
+
+	# reset --hard accidentally leaves the working tree with a deleted file.
+	git reset --hard &&
+	git status --porcelain -uno >wt_changes_remaining &&
+	test_must_be_empty wt_changes_remaining
+'
+
 test_done
-- 
gitgitgadget

