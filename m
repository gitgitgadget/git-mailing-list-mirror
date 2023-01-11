Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008A5C54EBC
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjAKXcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 18:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAKXct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 18:32:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A736331
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bn26so16567565wrb.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnsmLQS+P4MnCtSg32sdfoYiAIs2bztkcm9LmhmbITQ=;
        b=AdThVn6lYSdlwplpH6naJNizl9CGUmBcJMUfXj2MEo8LVm++snZqhkQcoasTUy0LIO
         tkCQugr7WxhcfqY6HfR8VI3Q6aCmDx4snSOofPWRU7quiceGi8jeTh5s/gbc8hxALDxZ
         VsOy5iFi+K/X6YGCHpbvXahx0TcTQ/dCMPlaE8D/QXKaYRaoGJRTRj8srTUNU4sWuUn3
         3UyA1Ys84ptNkkm3VnaJB5vN2N+ju9MCA9//2IpLvLfFnvxqGWkUImgj8rmrzn7o1Go9
         dJ6QKnpV72gd0hDo2eFs7Lz0fkx+cLMvBmohVdYiE2B2W1b5TtV28SseSHwM5szrIoEK
         FUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnsmLQS+P4MnCtSg32sdfoYiAIs2bztkcm9LmhmbITQ=;
        b=3pKvS+zCfz34tfhC8dZLGjk5fRhFkAF6+kYpCnU6L6bUOt0Ejtmp2eP/hr3+52egPQ
         ZoBerv5qSHslBxggGk0gRwDlt8K2IOlBxEagSPKKSGEuG8s54DBpx9IPZls2TyHOlXgF
         TpTqzhdHJu7flv0x1A8kF1WLm99XC7M7X8CXLSOUKCXRwPMVR80Mp/wo8jYaQGboJ+cW
         rUzrUJX1eSHfliE1k9cT3YYu/YmS/ZjHUuZevN4GtSIBgLB15BUh9SATmnjccHPFZW/8
         +W8gn8PPEiZcaLs9KJz9lMfW8FM2lKibnyHN1ra8NE0iGo4e6YrxQY4n8yaU/FNCvlOq
         TutQ==
X-Gm-Message-State: AFqh2kq0PrWnJ7OeieltrY8AV9zYr/nYaIyfsCqarO46fl/mKAdohKh3
        buI95Nk+LqsbH/lddwu2xKXS+fhn7hCGwvr2QN4=
X-Google-Smtp-Source: AMrXdXtNNgrUddxsSoCNrSCRHLUNfAth3MSSKA8rpdScWS3u26yNnSVparBHCxqvZNYEiUjoAMH1DQ==
X-Received: by 2002:adf:f9cb:0:b0:285:d0ba:92e2 with SMTP id w11-20020adff9cb000000b00285d0ba92e2mr36539298wrr.47.1673479966668;
        Wed, 11 Jan 2023 15:32:46 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.19])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm7679308wrw.29.2023.01.11.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 15:32:46 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v1 2/3] t6422: drop commented out code
Date:   Thu, 12 Jan 2023 00:32:41 +0100
Message-Id: <20230111233242.16870-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111233242.16870-1-rybak.a.v@gmail.com>
References: <20230111233242.16870-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit [1] tests in t6422-merge-rename-corner-cases.sh were
refactored to not run setup steps separately.  This included replacing
all tests like

	test_expect_success "setup ..." '
		<code of setup>
	'

with corresponding Shell functions

	test_setup_... () {
		<code of setup>
	}

During this replacement first and last lines of one of such tests got
left commented out in code.  Drop these lines to avoid confusion.

[1] da1e295e00 (t604[236]: do not run setup in separate tests, 2019-10-22)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 346253c7c8..076b6a74d5 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1159,7 +1159,6 @@ test_conflicts_with_adds_and_renames() {
 	#   4) There should not be any three~* files in the working
 	#      tree
 	test_setup_collision_conflict () {
-	#test_expect_success "setup simple $sideL/$sideR conflict" '
 		git init simple_${sideL}_${sideR} &&
 		(
 			cd simple_${sideL}_${sideR} &&
@@ -1236,7 +1235,6 @@ test_conflicts_with_adds_and_renames() {
 			fi &&
 			test_tick && git commit -m R
 		)
-	#'
 	}
 
 	test_expect_success "check simple $sideL/$sideR conflict" '
-- 
2.39.0

