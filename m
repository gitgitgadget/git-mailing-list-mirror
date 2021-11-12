Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA36C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E060F6E
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhKLG4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhKLG4x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:56:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B21C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u18so13816820wrg.5
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R8bU8NUYINOJrXYGc4xYLSd5LRBYRM7iu224OveQv5E=;
        b=jDQV1Fy9JUkbgXNQOfPz7So4f8YokGtTGtGbRSZCuER0Me5p7WssiJWTgeSvhmhzJ+
         aeoMnYl+hbWAYelRRRrCGGDNNt2b4QkBvGUkTw1hkfo14cmMdpj+LarRRtxyW8zK5nog
         jdc6Aj+e3IRQn1vab83nodxwu8XUQ9OdebZuFYesHnkAsIayVrKEzi9PDelpXrmAT+98
         X41TWbctzMXVDpuf0zT1l1t8dETBBBK8OR9y1yfBgjR4fk+m75YgkSuT2OUB08RJiWv+
         6vNyYnaNXSenugOsW7qU8e7sqyfDv1A2RR2bY8jP6wJcXp9tUN/zojLFGB3HvNVQzIiI
         W5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R8bU8NUYINOJrXYGc4xYLSd5LRBYRM7iu224OveQv5E=;
        b=ogZ5t78fgIqkh78SAfBBPDEiO8G6e2TZU8dcdoLS71Fn3oK93ge52ALW49tDPk844V
         Bee1Pj5KJ5O4ltrsEEsTlU6xBZnATdiuiNXwi8pk333GLPHC8eLd+pn1OlxTk9pMJqU5
         JTfJHH00QpGPcH45HiUydYw4TrBRuN2b1ApnaI22bOeTiNsGEJXLoBE4oAYJbwGIWTVW
         BsLsoDiRwcf5HEmldhKMUefiXVZINUZzfpE74n5ritXTSO9FnYB25+5TqFoe0Za7ZJkN
         amFmQT5pZkD+Zsskda3wHwNyODR+u0mZx+5q/i3iQ/YNv8Fxq15MipZRnBVdCQi75Tzw
         z4LQ==
X-Gm-Message-State: AOAM531/tAQa0CEhJuSb+2JpzxDjSr+z8uhbBeLC1s9qLaSj7SLe34br
        +bfdgC244RochRaUfo1o53uANmc/TKY=
X-Google-Smtp-Source: ABdhPJyvj7gWCMQRsJM1DJsLjmo/xKpN0ZVktXAvYK/E1wRJcbUnxDgQF2w6htNCor+wkjpUZfBTLA==
X-Received: by 2002:adf:df89:: with SMTP id z9mr15787324wrl.336.1636700041139;
        Thu, 11 Nov 2021 22:54:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm4715329wmk.37.2021.11.11.22.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 22:54:00 -0800 (PST)
Message-Id: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 06:53:56 +0000
Subject: [PATCH v2 0/4] am: support --allow-empty option to am empty commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with empty commit message, git-am should support
applying and committing with empty patches.

Changes since v1:

 * test: am: add the case when not passing the --always option
 * chore: am: rename the --always option to --allow-empty

Aleen (4):
  doc: git-format-patch: specify the option --always
  am: support --always option to am empty commits
  test: am: add the case when not passing the --always option
  chore: am: rename the --always option to --allow-empty

 Documentation/git-am.txt           |  5 +++++
 Documentation/git-format-patch.txt |  5 +++++
 builtin/am.c                       | 18 +++++++++++++--
 t/t4150-am.sh                      | 35 ++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)


base-commit: b550198c73edd4cc058832dcf74b41aeec2adba2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v1:

 1:  71e6989375c = 1:  71e6989375c doc: git-format-patch: specify the option --always
 2:  59b1417da37 = 2:  59b1417da37 am: support --always option to am empty commits
 -:  ----------- > 3:  da024ced668 test: am: add the case when not passing the --always option
 -:  ----------- > 4:  45e9720f40b chore: am: rename the --always option to --allow-empty

-- 
gitgitgadget
