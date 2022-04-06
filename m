Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A4AC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiDFMYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiDFMXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:23:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB89ECDAD
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:09:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so1830976pjb.4
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3R0lrJ8hvQ2iC5CMa7ff978oZXc6160XsOne2rS4yOE=;
        b=pFJA9hYl19G4m09NGxJEOq/i/OtKCw2MMV0tyfuc7wCl4whYY+ddtprVK8LEeRHAF+
         efW2XXoiGVhKYwgV4gfITQWU5XzwarIpfcl0xhleLL1DlBovwDtpt8wrwyYudDHVsqf6
         CAE0yr6+r0SXuES1F5LqF9Lev1F7TWqTt/DUHDaA8zcPkNiiV5pENGbDY9McX7NxbQx5
         JldbC1dY1iBYhOuVIrGYg7efRrhRXM3XsyQCKtc2dcICOFoeLDEKsTaNpjGTZNN4SYA5
         rwd6fZSFC3E+v3WC7nU63Z7NYFpM2ZnwkD0qTF6aWwpFOIdbG/32CmCSq4kprFaiQHau
         25VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3R0lrJ8hvQ2iC5CMa7ff978oZXc6160XsOne2rS4yOE=;
        b=BfPqnvGirQnVuyYOL+5An+lNEngrkyoe45ftOkgZxa+2RIb3T9C0m0XGhg9ztBw+rr
         RPLZuDSAAnidWXDcBGAhE7r8RgndXWRE2xtL5UD/YG5gZfalGi0PXdRziHHRnAjZK9cm
         TB+Fj0akbFzWf49+54JrqZ24v0q8WHZfhGibuvDHMvl/XBVovZ6KtMsGB/qkU+Z8apxp
         T5QJ+t5veoCIgBW6UELlxPJLtxGjlht3WoaxvPZAvL/5szxlW0b7svUqhdmTDsPQH31l
         t/nuQMU/Vz4bgj7imvVD8wm/5OZZ+jZM866J1vTZc79Y6hwCRjqJp7yIg38JzYwQ49sk
         QCng==
X-Gm-Message-State: AOAM532ujk3Hgqfrr/hV756/8cCqWoGPXX5cUd7ONMwPkd4GxZJpRpLl
        YsdDsPlY69DuzBhymBu9sW/+aE+61Z56h1vO
X-Google-Smtp-Source: ABdhPJx5ArWGane0T5IpX4S76HmM2Fjv1Z7YeJCmg9ApKhK1V7o7jrOy3+7ceqYzVjQCYJ+pmveLxA==
X-Received: by 2002:a17:902:aa84:b0:156:6b35:9681 with SMTP id d4-20020a170902aa8400b001566b359681mr7723928plr.48.1649232570570;
        Wed, 06 Apr 2022 01:09:30 -0700 (PDT)
Received: from ffyuanda.localdomain ([45.138.210.25])
        by smtp.gmail.com with ESMTPSA id o27-20020a63731b000000b0038232af858esm15145554pgc.65.2022.04.06.01.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:09:30 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [GSoC v1 0/1] GSoC 2022 proposal rough draft
Date:   Wed,  6 Apr 2022 16:09:19 +0800
Message-Id: <20220406080920.1220183-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi community, I wrote a rough draft of my GSoC 2022 proposal.

According to the General-Application-Information [1], I should
be sending this draft early to get reviews and comments. And I also
submitted one draft to official GSoC 2022 website.

This rough draft is not yet polished in terms of grammar and vocabulary,
and its content/detail is quite, well, rough. So, please give it more suggestions,
thanks a lot :-)

In addition to this patch-like draft, I also composed one on docs.google.com,
feel free to also comment on that one [2], in fact, it is preferable since it
has stylings, formats, and the final proposal should be in PDF.

A quick question: the idea page says this idea's "difficulty" is medium [3], are
we on the same page with Google's wording of "project size"? [4] Since the idea
page says: "Expected Project Size: 175 hours or 350 hours", I'm a bit confused
if this is a medium or large sized project.

[1] https://git.github.io/General-Application-Information/
[2] https://docs.google.com/document/d/1VZq0XGl-wCxECxJamKN9PGVPXaBhszQWV1jaIIvlFjE/edit?usp=sharing
[3] https://git.github.io/SoC-2022-Ideas/#more-sparse-index-integrations
[4] https://developers.google.com/open-source/gsoc/faq#how_much_time_does_gsoc_participation_take

Thanks,
Shaoxuan

Shaoxuan Yuan (1):
  draft

 proposal.txt | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

-- 
2.35.1

