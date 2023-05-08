Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBA4C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjEHR14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjEHR1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D15BBA
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f4000ec6ecso48736955e9.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566871; x=1686158871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D7H2kg0UU/KC12hNHznMJnDwSXp8WdFM1GYN/CXxFXg=;
        b=EyzkkfBM4hqoxPxSaJ586oEj/c0pB6FbCdb3b32lWA/i0rTl9YNrTQP9sFKQ5qb3iL
         0solsY/t459dgtoSpv/M/V1BFHdpkXCKFU4oCRYPxUP+chy1x5Gt4tkgKTcrMGeZdhTQ
         GK+UjnzqRCUqX4E2C3+Q+78ngQo4adXa3l3eM7coLFoj5QJ74qIlnpE/z7t5J5vOZiW8
         7+rnq4Sm1992DHDtNICmDgMEH6WwX2HSVjakGCf5lminjLQbR3UOVsqgvK+rbzJIralg
         dgzGz/D5Mi7jZnwyUapiFkspbMHIs/gArcTSgelwXHlKv7L11F5p2S4fLeDvq8yM9GQK
         tZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566871; x=1686158871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7H2kg0UU/KC12hNHznMJnDwSXp8WdFM1GYN/CXxFXg=;
        b=CUtJ4iU5TjTNGWWXbtSJhf03Gp7uzj/9KXQum33AANqinwScs4q3Ya35ckUfvgosJI
         Ed2z9fd2+Kpip6C7ch0MTYGoIvp3YUg9BjWPpZMHU23ezm+zAN68y5fL97DzMd95gvKR
         5XXcpgN8vEMKwrIQTk1l905cs1Hui88tQLend2TEHOif7BPVR2c1nm9j+5oFtopcyD1Z
         KVDOUQG4Pprb1WF8EtAS5oPppW+o/zQkkRBHPcB1UHSFpTjF1VC4X1YqoWvCoaqjUOiQ
         GtS1kqKyeWcqKNDyNQFalouam3w34DV6fYuFSUf8cphSlrZyN3tZ1p201iM/VtwTOa4j
         GbTA==
X-Gm-Message-State: AC+VfDyKl5avvQ4DIuDctbPG621bx7/yWzaQ8qv6BQupC9OCpO22666M
        FNl4tX87QxGZAadQ8WPOWLX1wPaHe3Y=
X-Google-Smtp-Source: ACHHUZ6XU43IjhHR+BzdRNsGg5DEKJR/MJKubssUve9rn1dHgD8IaMi9OQbegEujysvzlwSJ2zqeGA==
X-Received: by 2002:a7b:cb92:0:b0:3f4:2148:e8d7 with SMTP id m18-20020a7bcb92000000b003f42148e8d7mr4803730wmi.35.1683566871416;
        Mon, 08 May 2023 10:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bc5c3000000b003f0b1b8cd9bsm17559482wmk.4.2023.05.08.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:51 -0700 (PDT)
Message-Id: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:39 +0000
Subject: [PATCH 00/11] docs: interpret-trailers: reword and add examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes some small improvements to the docs for
git-interpret-trailers. The intent is to make it easier to read for
beginners who have never used this command before.

Linus Arver (11):
  doc: trailer: fix grammar
  doc: trailer: swap verb order
  doc: trailer: --no-divider: more precise language
  doc: trailer: explain "commit mesage part" on first usage
  doc: trailer: remove redundant phrasing
  doc: trailer: trailer.<token>.cmd: add missing verb phrase
  doc: trailer: use angle brackets for <token> and <value>
  doc: trailer.<token>.command: refer to existing example
  doc: trailer.<token>.command: emphasize deprecation
  doc: trailer: mention 'key' in DESCRIPTION
  doc: trailer: add more examples in DESCRIPTION

 Documentation/git-interpret-trailers.txt | 62 +++++++++++++++---------
 1 file changed, 40 insertions(+), 22 deletions(-)


base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1506%2Flistx%2Fdoc-trailer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1506/listx/doc-trailer-v1
Pull-Request: https://github.com/git/git/pull/1506
-- 
gitgitgadget
