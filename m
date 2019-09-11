Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0857E1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfIKPhT (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 11:37:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44901 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfIKPhT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 11:37:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id k6so12957356wrn.11
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0DMlX7HbuIsK4+BX9LUnst6kK5nYSrQ6//PHH/PFOoI=;
        b=dDdHBZxs3Jt/6oCjSdc48PPeJ7WS1beKhh100qG3Gl2e3wmgPftUmfVzpTAKrux53Y
         u2uSJAcQZmOlli7Nuea/B/HGKvg15DMUBFmXbShf0yPnv/QzPwg8f+dzHTkqsWNIV3BD
         qcdsRCY0C5eIpwLE8mO+cl0dbMVknp0F6vH6E7W1B1bp4C7GLMaH69xmxbrEsAbx/lPC
         v0J0ZigSUgLEJ/6VLSCzxqstT2oD4e8KAtBL9mbMLay1G3ZTDrQ0YOdrGW8sBrlYV7qL
         ZZoxZxuwPWm75IcIkJZpV8yuCC5tvQfm8sq4kL70/fQXcDsdFS2O1GxTtpi32KA0+E7w
         QOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0DMlX7HbuIsK4+BX9LUnst6kK5nYSrQ6//PHH/PFOoI=;
        b=tbsDJH9kTWOIr2j9skHVL2H8dYK6lEtYA167IUq6xAr53MMdyqHfSnyzDPUZ03H7n8
         0qFSEBUEd0zqApHDCuwkmRr38+JPT0nIwAQOUOKTmr/a0kALqksgFluo5huFDKdeVQpm
         6WNoTYSNVyCoXwKeJY7RNMYPw1cUuPg21ule16LzKx5ULJHQQ7MjTvqCttb88lt25AEe
         moDL9KoCa3iXedGhEuotFOv5hPj6vMA7Yv82Tna0uEoMXTo6O5xzMqfLGHqmxjdvJP7A
         0iBqGSUojDnXoYrfpIyAxxCs3boRt83EVXKwh3lyrpAoQUk16QIH6CMq7XGAxF/mHq8/
         H3VA==
X-Gm-Message-State: APjAAAU1c20K80tgpIIfBoz51qKh42mNLoUfX74KWAnEt78iiK6lhool
        V5sBntcZRhe2qhHR9QHtRiN32ngI
X-Google-Smtp-Source: APXvYqzolHayAEA+loMtvFv1ESGx7oonhI+6dw5/xWzsaI3eFTHc8HaDsc1GZgWMvtyFV0zBekIPng==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr10995855wrv.55.1568216235255;
        Wed, 11 Sep 2019 08:37:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm36936188wrc.44.2019.09.11.08.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:37:14 -0700 (PDT)
Date:   Wed, 11 Sep 2019 08:37:14 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 15:37:12 GMT
Message-Id: <pull.337.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] multi-pack-index: add --no-progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git contributors!

My name is William Baker and I work at Microsoft. Over the past few years
I've worked closely with the Microsoft team contributing to the git
ecosystem and I'm excited to start working with the community.

Derrick Stolee helped me pick out my first task, and it's to add support for
opting out of the multi-pack-index progress output. The progress feature was
introduced in 144d7033 ("multi-pack-index: report progress during 'verify'",
2018-09-13) but it did not include the ability to opt-out. This patch adds
the --[no-]progress option to allow callers control whether progress is
reported.

This path is very similar to Garima Singh's series for progress reporting in
the commit-graph [1].

[1] https://public-inbox.org/git/pull.315.git.gitgitgadget@gmail.com/

I'm looking forward to your review. Thanks! William Baker

William Baker (1):
  multi-pack-index: add --no-progress Add --no-progress option to git
    multi-pack-index. The progress feature was added in 144d703
    ("multi-pack-index: report progress during 'verify'", 2018-09-13)
    but the ability to opt-out was overlooked.

 Documentation/git-multi-pack-index.txt |  6 +++++-
 builtin/multi-pack-index.c             | 14 +++++++++---
 midx.c                                 | 30 +++++++++++++++++---------
 midx.h                                 |  6 ++++--
 t/t5319-multi-pack-index.sh            | 30 ++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 16 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-337%2Fwilbaker%2Fmulti-pack-index-progress-toggle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-337/wilbaker/multi-pack-index-progress-toggle-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/337
-- 
gitgitgadget
