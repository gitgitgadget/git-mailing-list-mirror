Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637CECAAA1
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 17:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiJXRCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiJXRBx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 13:01:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C18193EFF
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:38:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bu30so16885458wrb.8
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z6+ES+2r7/g2CFpEvk+QI66BIymB0gjrO2GhHAWh+yk=;
        b=bsHQy7W2XGDxnqxMbAxW0omzxluvewbUv23OfEq5uMOMJWcIRIDWqkkKN4LXUBawCM
         0e9NJxUP4VxvqqOOkEJ/r/ySgwaxkv0Kv4+g2ObPvWkQgisieRgpYAt+VI2UyRDj46Mo
         1tr8cHYf1kFnrirpP6ODcGOwwOYlYkCcPQp1tl/8t9NUma6ErwEwy7ZpWnAs9SFt1x51
         BUwdZfXeT80bO69HDvTgPerzPCIKsojG7nDcirq459Z2Sm4IXQm4W1FSSn90TcnKpTyF
         8k9PlXuXUNM8zP/WTFRPkPvB1uHf4OPAxq9zRrWMOkplX6sdSXSpxNdfQtwykyUEcvFg
         0+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6+ES+2r7/g2CFpEvk+QI66BIymB0gjrO2GhHAWh+yk=;
        b=jYzujpjCdUmD2Uv7CdxT63/pjJ2ipP2dj0GOyRhpPsQ7TZGIwTJfY4iIeDYaVmTxLN
         ylSxMVcT4uFb1LnrO5Ylw/VbOdulVHFO6YwCihNPaVWejvDrwlf3kG3nfBx0B41xGFw0
         3CeXFTm1n/LfxvDc5oIqkzyodS4gNQe2fogxi3FeVWKvjWHPQajyuazrMj7TiatRoNnH
         1tT6sXLaK9M9lOkphjyqoE2BpusQB+M/Gp9oYZpQDL8DVvgPZDeUzhN2h+5fgraavGv5
         c/iyJKbIgA3+miXzoSdgDyHAyllk1olPR0tJFLKts0IMESNa6Mdc6d+hML1gOwOfIIWY
         sIvw==
X-Gm-Message-State: ACrzQf0ZYWBuHE4QALK5Ys6/sVYHBpM3XhTuD+NuYG7bgi5L3dnVPMC8
        g7LxykdvwPUCJ9mCJec/5tNOBlGWF6s=
X-Google-Smtp-Source: AMsMyM4s9dyXToqlsJxjU6XVbXUO+2DNKA77MnoRvA9Vm/ZfcKr7QcwkY0RDe0qcekyDPl+CM9DHLw==
X-Received: by 2002:a5d:4b04:0:b0:235:f22b:6621 with SMTP id v4-20020a5d4b04000000b00235f22b6621mr14953838wrq.462.1666623640128;
        Mon, 24 Oct 2022 08:00:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay24-20020a5d6f18000000b002366e8eee11sm4183260wrb.101.2022.10.24.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:00:39 -0700 (PDT)
Message-Id: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 15:00:36 +0000
Subject: [PATCH 0/2] Document fsck msg ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsck does a number of checks, and prints warning or error messages based on
the type of check. The only place the config values that control whether to
ignore these checks are documented is through git-help(1). However, often
times peoples' first instinct to look for a list of valid config values is
in the documentation page for git-config(1). These fsck. configuration
values can be hard to find.

Document these so that both git-config and git-fsck documentation has a list
of valid s.

Patch [1/2] removes an unused msg-id BAD_TAG_OBJECT Patch [2/2] adds a
fsck-msgids.txt that lists msg-ids that fsck checks for

John Cai (2):
  fsck: remove the unused BAD_TAG_OBJECT
  fsck: document msg-id

 Documentation/config/fsck.txt |   5 ++
 Documentation/fsck-msgids.txt | 133 ++++++++++++++++++++++++++++++++++
 fsck.h                        |   1 -
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/fsck-msgids.txt


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1369%2Fjohn-cai%2Fjc%2Fdocument-fsck-msg-id-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1369/john-cai/jc/document-fsck-msg-id-v1
Pull-Request: https://github.com/git/git/pull/1369
-- 
gitgitgadget
