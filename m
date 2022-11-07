Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B8C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiKGSiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiKGShI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0026577
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id cl5so17545225wrb.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM/FSCskvx0L2g6LFTw/tGiLchecE6CJVhufvrnkFkI=;
        b=ozlZ3LjgdXnyeeW6x8LQ3HZjfNV+IdFkYBoJ9gqO3jNyX5qRK6ZVc6HvjxHDjktPt1
         vHFfgjKTK1VdOa7YtjlltBx4pwSKJ7PqYnpMwkWPZs/0zdHzZni5Q9dRc0RdLorkySB8
         mvdZN379xjg7iiLukZBgnVEtlMGjmzH/0VCJ17nU6lTRacEVnPH4C9V4vFkeNpG05aNe
         nREQ7M075fNuyZaabhP47VvDe8yoVbmYPRkUDYT65b1iZOmUhfzLNwqN/X/ssQkjdugd
         eY3Mb6EQ4uoPtcfmjSC2tyGU20xq6m2GL8B6gzhpu6qGwg/C/1Hll5EsJIlYLWLuZzGv
         zUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM/FSCskvx0L2g6LFTw/tGiLchecE6CJVhufvrnkFkI=;
        b=Pxku481XJU5EWEIgVBKpKnqDyFoqGZhrxjqfnu7U/arCfjHW229s1k4KX1yvs+MQ23
         H9KKSfOSDyjh/YlJcjQjwLtTtXBJsN6XRwvtyDpud8/kzzFMwJZnTATdgVXd6xFsGEcI
         3SHtGBdqYpAN/jKKYRhUM8Mqj/F5Abqzczw0mtDfdPxKD2ceGyD028oubyrDP5EYoZjT
         ztHcnuA12ZCSZayegaJzJ4FMS0aTd3CHnEGm7nSjyjb2GL0aJZ8HyWrgwtLFwLLkcdzI
         PSdl4BwOfw+0pIYpn6u7nU88pyVZ4i1Q0X5wTvT24V4BVF0WVr3HF2ZE3lsfFUMuJ4uM
         MFew==
X-Gm-Message-State: ACrzQf1eGVxxz3e/LWqvg83pt2y9jHia1HQMdrejc4QvAThGwiCZbBfM
        6x4NkG1l312zHjCoR+sAFWRA0H2xIEU=
X-Google-Smtp-Source: AMsMyM7Z5KyUhkvpOVHOk5z/gbo5///cpNbMyRYMaj08zh2LVYscN1djZMfdXtCU4LgAbHgzmwbejQ==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr32864743wrn.251.1667846193999;
        Mon, 07 Nov 2022 10:36:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003b4fdbb6319sm13248796wmq.21.2022.11.07.10.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:33 -0800 (PST)
Message-Id: <9d261a55403f8c9d207cfb363689ba9964a57c57.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:36:02 +0000
Subject: [PATCH 28/30] ci: run GIT_TEST_PACKED_REFS_VERSION=2 in some builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The linux-TEST-vars CI build helps us check that certain opt-in features
are still exercised in at least one environment. The new
GIT_TEST_PACKED_REFS_VERSION environment variable now passes the test
suite when set to "2", so add this to that list of variables.

This provides nearly the same coverage of the v2 format as we had in the
v1 format.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8ebff425967..e93574ca262 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -30,6 +30,7 @@ linux-TEST-vars)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_PACKED_REFS_VERSION=2
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
-- 
gitgitgadget

