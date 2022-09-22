Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E1C6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 17:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiIVQ77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiIVQ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 12:59:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E6624BE2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n15so9616828wrq.5
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+f6YTqMKgo/XauQ5HVwJ9Cjt9MJOXkiqZPvZQkkmKdM=;
        b=Z4kUYd9YXS24xg5hBNy70sx1ISgHDmZIjcNSMfRfmJJsZU5Mrg1ifWtes4eKeQdOU9
         fo9suPLHj6ERqi1sm3rOVMS/a20TpGK63Y+zA5Gs7AC9dQXyIKx/tUP8UHIczw0YlRfF
         xY0qDIjsCSX6tUnej4CfDz8WWVA2hugPta7/M1D3B3SLguUXL2aKbcX1g+Wm182S6guh
         oR/n/stWBkzbLI5uztTQdHkidclMoSsU/omslCO/XIXcpM4yt7N5HZy11axh4UxTzj6x
         nYFX5CamrzOEHlJjXG20VyDNrJ9S2c2x2LeE7ySJy0b8EaIs3kus8Ggv2zqfb2Nn7+GN
         IFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+f6YTqMKgo/XauQ5HVwJ9Cjt9MJOXkiqZPvZQkkmKdM=;
        b=brN50M+pjZ1VXSQx97rU8WIP7AM8PL+FRNuAhNi8QZObMQcmdx6dL/stgcpNudRFYz
         6BjxjbTBn4ehPE/QKFbi4eZednyfEW9LndBUexMpSJieKasmQMegis2hVvWO2bjm9zMl
         b2Z3LbvhH5tx+k4Uv/aWRVWD63LwZxRBhORuAapRYD53n3eAcGpCmceobN0Lp1p1MGni
         elAYLnMdDTrcfpBtp96uDKnQN/PXMNJuCzUafev6kJ6V6OC65lRF5Wa+df39ZPYra8d2
         aNYWfjoyh9hlbx6VnQSmEomF9935bXw0Hi+FxDqzQAew+mkgsnE47GJnwsaV6QNnIiaq
         D2Kg==
X-Gm-Message-State: ACrzQf0E0plrdnsXhwLXFUD+Dnxnbyd1CX3ZhN0EMuK9B9OREOBcXaS2
        u9b6y0NtacDCU5RKi27GJ9V8WKXaNgI=
X-Google-Smtp-Source: AMsMyM4w1LQfGJxQC25721Afl6HRd8XkLdL5MJ/UfoRl2cwk2NIu/ca0FJTrGxB4nahSBNtbpEREwg==
X-Received: by 2002:a5d:5850:0:b0:22b:1ada:a0d1 with SMTP id i16-20020a5d5850000000b0022b1adaa0d1mr2680958wrf.313.1663865981890;
        Thu, 22 Sep 2022 09:59:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c0a1500b003b47a99d928sm63082wmp.18.2022.09.22.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:59:41 -0700 (PDT)
Message-Id: <2ece562a5952b5752de5040b17ec36076164c72f.1663865974.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 16:59:34 +0000
Subject: [PATCH 3/3] osxkeychain: clarify that we ignore unknown lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Like in all the other credential helpers, the osxkeychain helper
ignores unknown credential lines.

Add a comment (a la the other helpers) to make it clear and explicit
that this is the desired behaviour.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index bf77748d602..e29cc28779d 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -159,6 +159,11 @@ static void read_credential(void)
 			username = xstrdup(v);
 		else if (!strcmp(buf, "password"))
 			password = xstrdup(v);
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
 	}
 }
 
-- 
gitgitgadget
