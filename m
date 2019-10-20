Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA041F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 20:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfJTUje (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 16:39:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45343 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfJTUje (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 16:39:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so6549126wrs.12
        for <git@vger.kernel.org>; Sun, 20 Oct 2019 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lXamC4cw7Pp9RDTrkBkcwPvmCsK184oNBg6fArHezck=;
        b=anISdxXxebOo8ZsRy8yGGT4a/u0fkGq8nv5FdtREcR4ndwrVnrcATbbpTC4LvcRBay
         /AFbjrY9bVoLHI05Y+/gkr2O1HoBw2CH7ZFfw8ul+qbvE7z/Gloqw2gj06/18xkMTmhr
         9D0B6nY8+r8qkXxilX2TCVE75lvlKo6R7/QMjstrHRjK+QJtX8Xo/XSYBxOFXBwU5Qi8
         vWxZqy7muqqq0hvl74QOJEAU7Gj/H/CBa2ppm2w4MmDvYiqDms4w+1sz785m5t3MmDpw
         FXKecy0xsfTlUuQY8Y86H+hCvVFFBa+uc9iwLzED5gZXGdkg6rdkW4T0AUwTrzQxZfj9
         GzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lXamC4cw7Pp9RDTrkBkcwPvmCsK184oNBg6fArHezck=;
        b=LcwPnYG+pEreuR1UbwKImvdCBgvzBtvjrptZVUsq7TgcPNPQE9XZ2fYpD0ypFBtVLU
         mAzZC5QUwFUAxurSkIrhsvpShVFI8AqweXTkg0RASyxNHfA8gqADJe9sXC5k+qP8qYWF
         byGkKVzZ/39NTYURocAQC9ThCCddPqdgORcG6/nwSjrGOpUKz0F6/bKkW+TAvDdt1EnQ
         fzUs6EM87nUqi3xx3IVweReEif1GqAN7ayCDsTKJ1vXcy82kv48FVqhpGX2MAHJ4JDI8
         zcsWj0sKUz2ORIyxKsHauGFqakIioeYm0DeUPa6dvWV+3evBK/O3U0L+wrwZD55q6+jO
         88sg==
X-Gm-Message-State: APjAAAW8UR1yLWhpUR2D3ZzLzfP+drJRtFd/t1mnrYOxKNs62CKhOkIE
        C2muxLygA3ykfulTIxQ2RXsiQmi+
X-Google-Smtp-Source: APXvYqyTRYu3RaMvrNyfBzr0PSvyYOccAIy/Uo2W9QR++zBqquxYBA8J4WxqWSr3+sWUhONYz6AOtQ==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr15391271wrj.379.1571603971848;
        Sun, 20 Oct 2019 13:39:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm3980682wrx.89.2019.10.20.13.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 13:39:31 -0700 (PDT)
Message-Id: <pull.410.git.1571603970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Oct 2019 20:39:28 +0000
Subject: [PATCH 0/2] Fix the speed of the CI (Visual Studio) tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made a mistake when converting the make/prove-based test job to a 
test-tool run-command testsuite one: I lost the parallelization, resulting
in way slower CI runs.

Also, I forgot to build with DEVELOPER=1, i.e. with stricter compile flags.

This pair of patches fixes both issues.

Johannes Schindelin (2):
  ci(visual-studio): use strict compile flags, and optimization
  ci(visual-studio): actually run the tests in parallel

 azure-pipelines.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-410%2Fdscho%2Faccelerate-ci-vs-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-410/dscho/accelerate-ci-vs-test-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/410
-- 
gitgitgadget
