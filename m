Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D8AC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiHRQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345120AbiHRQyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:54:02 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BF8C017
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:54:01 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3375488624aso28083527b3.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T4JfC78SiQ/rOMviz+gRREj6YdCQjexet1GEAj9NUos=;
        b=WYrcdA8UI3KyvD3tQGMp3hJ6ezpjwX+LUARdj5gAo93sM2oZDt2NVvU5LEwMBpa1vd
         rgAE+IgCU9BDmerJN8dz9HTySjL0CVgd0MLj+d93hffcZ6th4l25ABDOHiMi8tdNNhzx
         NOsIfw1LdV4x+Np0pS0Q8q8GYFr/6sE6xEjOOJi+pCoAeMIIHSfB14Lf2YFpo864z37E
         oJglZKldjGbpEamNhytDwHuSoET5DonsiNko974IKEeIerNxIeD+Wccj8UxMt2mIIWJM
         HKqtyoIlw3dQRn3Nzv/WxFoewqV1uPhFLT9vPSkEmipHeFTUm9J21fgzHwVw2xuy4hTz
         /FtQ==
X-Gm-Message-State: ACgBeo3ewStqEm5cDFFCkkFMiwMX7zOENe82XoU/I0pO2tYbhOTnfdDp
        UBvm9b/NYQRUKiXQ0A50J2NBSxzeLQolFy3QRL2iLBaXwr3jig==
X-Google-Smtp-Source: AA6agR75xe43RucKq2Wmy7BYfJbAUQbfTgVEGsREw4wabW2fMZFsIjHJxKvMF76Bwmd+dDSwKQpB9Z6j0bocxwDCueE=
X-Received: by 2002:a81:1ecc:0:b0:334:45e1:6fa9 with SMTP id
 e195-20020a811ecc000000b0033445e16fa9mr3689729ywe.482.1660841640330; Thu, 18
 Aug 2022 09:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com> <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
In-Reply-To: <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Aug 2022 12:53:49 -0400
Message-ID: <CAPig+cS4gROePP=acuHwRZ62QfZkwfyD8Owo-C8NAkQ7tUcujA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 11:50 AM Derrick Stolee
<derrickstolee@github.com> wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> Subject: [PATCH] t6019: modernize tests with helper
>
> The tests in t6019 are repetive, so create a helper that greatly
> simplifies the test script.

s/repetive/repetitive/

> In addition, update the common pattern that places 'git rev-list' on the
> left side of a pipe, which can hide some exit codes. Send the output to
> a 'raw' file that is then consumed by other tools so the Git exit code
> is verified as zero.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
