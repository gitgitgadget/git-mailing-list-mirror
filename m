Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9B1C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiDFMYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiDFMXf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:23:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B2ED925
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:09:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso5092415pju.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAusmuVVNgcV3FVh2WTTulp3N9xZvfLCmIDY4UTn4IA=;
        b=pzvc6Uu5e7yX23uT9DbEqxLbcmm/JikoByf1fXD+EtY/GnvOtu5jUk3e1PC8zmN/NM
         Nf1qdzVTWn2wCDjTMWHxluzmW1GrSszmL+eVxA6lNwhXvC5CSSgXnh268QTrb28h+G+/
         s9Wv92S5U8RZfi6wJl1yzX5MVxRoYHwCk90YM5x4TyROkSOrpm5VXPiBgUMjOhZ5/QFF
         TJArh2TwNwULcE6Wt4Ow0/FQpYqHUV95kWBXzsJf1m9Z2pHRYxnSPOHJ5AqAHds3pUl3
         jRt+8PPK7mWgbnaNNcl1ZzJGV/Patr9GfjqtsdV87XwUDKhkZq9FCuaDggfMJI6qi5Su
         5mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAusmuVVNgcV3FVh2WTTulp3N9xZvfLCmIDY4UTn4IA=;
        b=N8LQnIVvAsnuGRjjSScGf6zSbexiLtKEvpcrEvQlYdP4kHSjPalvQIzcS0b5/HEZze
         kl++4lOTqR9VKSXNaH7KQp0034bt3RdJU/gblX3ogjqQI+uMNnxk5y0PrOFeodV69BZF
         6PwIve1uidxT20CLTAAocarlgZ9Rtej0Z5fTmCJPGdmqHxZ45B10b6I14qDzbKUekm2Z
         3AKgPmBQttgIhpGzaPxcMverJaHny0HPzO+fpePvM3F3136XMeKVYimV0BA0QNd6hoxU
         mxzWddeE2n6zZwanQWyHx82BjXiX61t4AvFVahqLi5noOMCHo/QfxDdgtnMLxQYk7/nS
         EAag==
X-Gm-Message-State: AOAM531P8G2fWD0Gtklo6voXwcDhdOPvvpktEQ61PT10Rsg0e08iw1Gj
        rMkerUO8maWeTS4BIcj6YjdQg5IkiZrPwkLJ
X-Google-Smtp-Source: ABdhPJxStH4vs+DGgtr1BgGbaJDG0q8l5+NiwnExlJoe7QCwNO6MiSaH/M21EVle0adxGyJGokztQw==
X-Received: by 2002:a17:90b:4b0e:b0:1c6:f499:1cc9 with SMTP id lx14-20020a17090b4b0e00b001c6f4991cc9mr8735957pjb.133.1649232573160;
        Wed, 06 Apr 2022 01:09:33 -0700 (PDT)
Received: from ffyuanda.localdomain ([45.138.210.25])
        by smtp.gmail.com with ESMTPSA id o27-20020a63731b000000b0038232af858esm15145554pgc.65.2022.04.06.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:09:32 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [GSoC v1 1/1] draft
Date:   Wed,  6 Apr 2022 16:09:20 +0800
Message-Id: <20220406080920.1220183-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406080920.1220183-1-shaoxuan.yuan02@gmail.com>
References: <20220406080920.1220183-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 proposal.txt | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/proposal.txt b/proposal.txt
index e69de29..eaa3cdf 100644
--- a/proposal.txt
+++ b/proposal.txt
@@ -0,0 +1,133 @@
+GSoC 2022 Proposal @ Git: More Sparse Index Integrations
+
+# Name and Contact Information
+
+Full name: Shaoxuan Yuan
+E-mail: shaoxuan.yuan02@gmail.com
+GitHub: https://github.com/ffyuanda
+Tel: (+86)189-9835-1089
+Alternative Tel: (+1)646-512-1886
+
+# Synopsis
+
+I'm picking the project idea "More Sparse Index Integrations" from the SoC 2022
+Ideas page [1]. This idea aims to integrate the experimental sparse-index
+feature and sparse-checkout command with existing Git commands. Its difficulty
+should be medium, and the expected project size takes somewhere between
+175 hours to 350 hours.
+
+[1] https://git.github.io/SoC-2022-Ideas/#more-sparse-index-integrations
+
+# Benefits to Community
+
+By joining the community and working on this idea, I can work together with my
+mentors and community fellows to bring a better user experience to people who
+are working on large monorepo with "sparse-index" and "sparse-checkout".
+Moreover, I have a strong intention to stick around after GSoC, not only keep
+contributing to the community, but also share my experience with or even mentor
+future potential newcomers.
+
+# Deliverables
+
+With this idea's clear spirit to cover as many command integrations as possible,
+and also with the clear steps to take to accomplish each integration, I have
+arranged a general deliverable structure as below:
+
+1. Investigation around a Git command and see if it behaves correctly with
+sparse-checkout. [Approx. 3 - 7 days]
+
+2. Modify the Git command's logic so that it works better with sparse-checkout.
+[Approx. 7 days - 15 days]
+
+3. Add tests to t1092-sparse-checkout-compatibility.sh for the builtin, with a
+focus on what happens for paths outside of the sparse-checkout cone.
+
+4. Disable the command_requires_full_index setting in the builtin and ensure
+the tests pass.
+
+5. If the tests do not pass, then alter the logic to work with the sparse index.
+
+6. Add tests to check that a sparse index stays sparse.
+
+7. Add performance tests to demonstrate speedup.
+
+(points 3-7 are from SoC 2022 Ideas, proposed by the community and mentors)
+
+[points 3-7 added together should take Approx. 7 days - 15 days]
+
+In summary, each integration will take a similar schedule stated above. So,
+without extending the timeline, it is expected to finish 3 - 4 integrations
+during the GSoC program.
+
+# Related Work
+
+Since the Git community requires a "microproject" to be done in order to
+familiarize oneself with the collaborating/contributing process, here is my
+selected "microproject", this patch is already merged into master:
+
+Modernize a test script [2]
+
+[2] https://lore.kernel.org/git/20220123060318.471414-1-shaoxuan.yuan02@gmail.com/
+
+Other than this "microproject", I've submitted a few other patches when I
+stumbled upon bugs/potential modifications, these patches are already
+merged into master:
+
+t0001: replace "test [-d|-f]" with test_path_is_* functions [3]
+builtin/diff.c: fix "git-diff" usage string typo [4]
+
+[3] https://lore.kernel.org/git/20220121102109.433457-1-shaoxuan.yuan02@gmail.com/
+[4] https://lore.kernel.org/git/20220202072844.35545-1-shaoxuan.yuan02@gmail.com/
+
+Prior works about the idea have been done by my mentors and other community
+members, and these works form a good approximation of the approach I'm going
+to take. Some previous example commits:
+
+Integration with "clean" [5]
+Integration with "blame" [6]
+
+[5] https://github.com/git/git/commit/1e9e10e04891a13e5ccd52b36cfadc55dfaa5066
+[6] https://github.com/git/git/commit/add4c864b60766174ad4f74ba7be17e66d61ef16
+
+Other than the proposed steps by my mentors (points 3 - 7 in the Deliverables
+section), I also added some steps (points 1 - 2 in the Deliverables section) as
+prerequisites, which I found very necessary during my tentative patches
+discussed earlier with the community:
+
+An RFC patch about "sparse-index" integration with "mv" [7]
+A WIP patch to optimize user experience when using "mv" with "sparse-checkout" [8]
+
+[7] https://lore.kernel.org/git/20220315100145.214054-1-shaoxuan.yuan02@gmail.com/
+[8] https://lore.kernel.org/git/20220331091755.385961-1-shaoxuan.yuan02@gmail.com/
+
+When I was exploring "sparse-index" and "sparse-checkout", I also proposed a
+change to the documentation of "sparse-checkout", this patch is still WIP
+though:
+
+Documentation/git-sparse-checkout.txt: add an OPTIONS section [9]
+
+[9] https://lore.kernel.org/git/20220311132141.1817-1-shaoxuan.yuan02@gmail.com/
+
+# Biographical Information
+
+## Education:
+
+I'm currently a Computer Science and Engineering sophomore at the University of
+California, Irvine. Before this, I also had a summer school at the Carnegie
+Mellon University, in which I also learned things about Computer Science.
+
+## Some credits to myself (prior open-source experience, work, etc.):
+
+1. I've been contributing to other open-source projects before, though still a
+beginner, I'm generally familiar with the process of contribution. The related
+experiences are all in the contribution graph on my GitHub profile page (see the
+Name and Contact Information section).
+
+2. I came to participate in the Git community fairly early this year. I got
+myself rather comfortable with the contribution process by writing, replying,
+and reviewing different sorts of patches in the community.
+
+3. During the patches done throughout these three months, I'm getting more
+familiar with the Git internals, project structures, commonly used APIs, test
+suites, required tech stacks, coding guidelines, and most importantly, prior
+knowledge and experience with my proposed project idea.
-- 
2.35.1

