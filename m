Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2522C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A521161BA1
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbhKRKyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbhKRKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:53:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C8C061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18so4854881wmq.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8eD96oJOOP4Q5VCqjqrH5fZW0PJ8E7bpHKQ5zL6bZuw=;
        b=UEtblk/HEbMpMp8atjET+TJBV+S6qlVFrPmeWvXiOg53H+DAeoXtW4G81rbqgG/gex
         AvbIHGV3Rd3sh9uC1r63IWNO97OOpqQXpYIHBXLTgsaaJIYhlBLdEDsJpxDOoAs84nyQ
         QgDXcq9JdH6cD4w4v3G8YBvahOPtCWRnhco17/rFXkquSqPMIqf+TH+muZh2uvWW/SZA
         xp9kc1Pmfi4/jN/aaNNK4KP2rrlW0Rv3JbiiJQhiiRw15bGisnu1uGy9wawqbSnPGQBM
         90oX5yg6lJsv9xv4FIOO4M3p+trup6succMKd2YbSHCQH+skm+PQkrDRLYXlyllSiVqT
         IB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8eD96oJOOP4Q5VCqjqrH5fZW0PJ8E7bpHKQ5zL6bZuw=;
        b=UALuswgT2v+Svt13CQ5PReI3M82zrXjs8gBJiQZtQ4fTYqE/SkKwMxHFRU1P7zuRIH
         8+crEbjt5HUvoa0eK98OubpV47f4Ft7cDil2rZPvU7NatVxSR40uvJi8StgRp2UdlH5p
         U1c5C4JmucmvCdFMIJZSnaZD7vEe62vXTrtaViPay6vw2mSeTAZHjo7uFv2cBcWvIV5j
         1hK1kPs0/EJA1Nu0rhu2rwzsalE93b+Z0OMu2lcnEml/pM8CjFmYGx1vLOg9Jp0O20I5
         Rlld26oNyE9NcLWXTLXZ+8Y9q4k+VWQZ50rD5jm+Z/ki9xn9LlUf43zCqrotcR7T4PUH
         dSbA==
X-Gm-Message-State: AOAM532nKLEQnNqMRj61sO2xv6Q+oss+s54iJEn/MOTvDysEofUBhVJW
        pg73mDhtti93GCcESompzWOuqrw2514=
X-Google-Smtp-Source: ABdhPJwjRBnUil3FV0vTmXkd/tjcs2UiaVtr6TbN9xofKjnbR3wsRAnMbh0UKslvlQIwAwx6gyr2yw==
X-Received: by 2002:a1c:183:: with SMTP id 125mr9207327wmb.0.1637232637489;
        Thu, 18 Nov 2021 02:50:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm2647929wrw.87.2021.11.18.02.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:50:36 -0800 (PST)
Message-Id: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 10:50:33 +0000
Subject: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to handle empty patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Aleen (3):
  doc: git-format-patch: describe the option --always
  am: support --empty option to handle empty patches
  am: throw an error when passing --empty option without value

 Documentation/git-am.txt           |  9 ++++
 Documentation/git-format-patch.txt |  6 ++-
 builtin/am.c                       | 49 ++++++++++++++++--
 t/t4150-am.sh                      | 79 ++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 6 deletions(-)


base-commit: b550198c73edd4cc058832dcf74b41aeec2adba2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v5:

 1:  9f1b3dd6d0b = 1:  9f1b3dd6d0b doc: git-format-patch: describe the option --always
 2:  96d8573dc80 = 2:  96d8573dc80 am: support --empty option to handle empty patches
 -:  ----------- > 3:  e907a2b2faa am: throw an error when passing --empty option without value

-- 
gitgitgadget
