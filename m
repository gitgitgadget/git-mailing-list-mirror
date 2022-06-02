Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC1C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiFBJFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiFBJFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:05:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A112A80E7
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:05:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u8so1260709wrm.13
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=onpJG5WJdt6yyY5S7KFY6puYCw2HAgTbSYrtdL8/h9s=;
        b=RhTYUkvH2xVczuj713wfiEFUPLKX21eX444IpypC2hu3uzyx88mO917Em4Q/dbfMul
         RRNOy2c/75/wsWEz2+0c+oIYrNdJJFakqE0E/81KEnNmsCQhD6pr1F4TmbZ27q/JJpVC
         4nuiB6+7ZBQ58bK5k7x1G7q9INQ/WxUVbmwXbf7lGL3WUH9bOwzWYOTkp7rrt3eGBswx
         ZKXAfMSPQ53KE1imWrc2wYBndjGjcxUwPIvkkip3dYmqWG3LjcZaWVblEM4AwlrmiUjF
         i/A9JmRtOqCAypzCi4qneY6wJTcCGnUpJJ/Ol9NyuGe08RoT7Qm8LQb9fcywhj0QIhfG
         XS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=onpJG5WJdt6yyY5S7KFY6puYCw2HAgTbSYrtdL8/h9s=;
        b=hfsmPQ3Cq7LAf6n2TZBFh9Xal8mbsEB7CC3A+aAIO8B3ujzUOTXSy2d//PZO3/ib/S
         r1sA163CBaN4oQVa5/6j+N0WRF+s+kyE8jTqMuVMEgrLhBk4PJGu/L0SqdfZaJ10auYZ
         998upJ0nncLodbdaQX3+sWiJgDdIO8UUxFWzcrYbrhWcHzFNb4ooYN1Z1z98jsql9sfw
         ZvB+H+WRLvFkt9PF/vcTdMTRUBzgsRdYcsLR9XgKMYsjeQJEAMKSz/Y85MjvW0TUM+H2
         e014sUpRopQ57Sx7+A2pfzgMVSGYu+MFHSzGFr5o4E0USbxLyjQL97V0nBlrY2PQBVl6
         OzgA==
X-Gm-Message-State: AOAM531RtZF1W7NkuocFcq5muVuB3wISTFoQl6nPYKq0LtwtJZMDEL6i
        24Qt56t+SJOZAsz5kNB5SubttiVrHjg=
X-Google-Smtp-Source: ABdhPJyK+xIlN1sDkva/H3uvwAg3w4keqeGluM+GLOjL0hAGtG37h4M18/N5V6q0IyIIiM22BjyhhA==
X-Received: by 2002:a5d:6091:0:b0:210:3e16:c600 with SMTP id w17-20020a5d6091000000b002103e16c600mr2714037wrt.456.1654160737121;
        Thu, 02 Jun 2022 02:05:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c3b0f00b003974ca9fa6dsm10555114wms.2.2022.06.02.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:05:36 -0700 (PDT)
Message-Id: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 09:05:33 +0000
Subject: [PATCH 0/2] Integrate Scalar into the CI builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the review of the initial Scalar patch series, it was suggested to
include Scalar in Git's CI builds. Due to some conflicts, this was postponed
to a later patch series: This patch series.

Note that the changes to the GitHub workflow are somewhat transient in
nature: Based on the feedback I received on the Git mailing list, I see some
appetite for turning Scalar into a full-fledged top-level command in Git,
similar to gitk. Therefore my current plan is to do exactly that in the end
(and I already have patches lined up to that end). This will essentially
revert the ci/run-build-and-tests.sh change in this patch series.

This patch series is based on js/scalar-diagnose.

Johannes Schindelin (2):
  cmake: optionally build `scalar`, too
  ci: also run the `scalar` tests

 .github/workflows/main.yml          | 15 +++++++++++++++
 ci/run-build-and-tests.sh           |  2 ++
 ci/run-test-slice.sh                |  5 +++++
 contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
 4 files changed, 36 insertions(+)


base-commit: 15d8adccab9a3146b760b089df59ce3e7ca2b451
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1129%2Fdscho%2Fscalar-and-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1129/dscho/scalar-and-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1129
-- 
gitgitgadget
