Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E25C25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiHKQMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiHKQMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 12:12:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC73798D0C
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:57:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so21907857wrp.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=xjS2hUDkcuR0nwbRPhB9E2GQriNP3t1dzxBdOgY78eA=;
        b=cGm3vShXvn29wenRttZCEQivLQgRFxSfm5Z561V0kj2OaIX2AJ0DAgmHdyY1zOt9lx
         JOHyLjMQ+rPozO2MRIaydHYm5eQ1Mm1Xj+l5ayoC2MPMnkhR7JhwjZw6QdwwQ7YW/lAQ
         AOInbb4NSgMC5sMgsyKmPst8JmZZHr8yvVK/MUcBOr7kuBaSmN2tHMDa5RZmia5iTAxh
         y2JdqeVIqjwY6r6AFVgD8mQfBbHhcgfKpE+INOwhpD+iaDTRCTwDHdfBvN+LoUEHrMYk
         q80fOsQ7qQwg2uuwMSd8pJygAq+6DqvTWfDdGkYI1zTmEgmTr8R5KjqKkkSvIlDr/6AJ
         sfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=xjS2hUDkcuR0nwbRPhB9E2GQriNP3t1dzxBdOgY78eA=;
        b=2qw9fHJm1SPOqghCr0fAZkSXVoABP+LK9gh3Rg65ubWPUqoiqQchSCHSpsaztcrZ3a
         LFz91TWJ5kPcKteXlJQVKP2eq2m2g9WlmmFMyZu1N8KI5y+8K6xbOejNGG0YrBgQ4zRt
         032dXpQMeHcgTMr5Dfv3zZYwKXrkaqSUGQ1NmvS3eSCNkICOUp/kNyHNlsD7rjIgWmZQ
         j/BZB1zpCeEGoO3jDnFL26AzkvSgTudRBzl5uGIqqmC60EbM1IKkzUHXIu3R4zgMDyOE
         9jygoXgJF/Wreyq7LQYBBxhFOKvMJFoPv0DHMQIZZkhlKfxsV54LUtknH5/abZvTWcMy
         o/BA==
X-Gm-Message-State: ACgBeo22+vtuze6AhdkPerSO+qlqOhU8h9Om/cYU+PmYq+h7/YunOyke
        QwP5VGlCL2ExHLtP4Jf+iPGwkBUhgDI=
X-Google-Smtp-Source: AA6agR4vtXjqfJ/dnuD2VyJIIqphwCYDWYD5tKvfkgCBkv8GEAlmgRJxxAKyudiTubDzQU4CfkGMyQ==
X-Received: by 2002:a5d:4d41:0:b0:21e:a5e3:cb9b with SMTP id a1-20020a5d4d41000000b0021ea5e3cb9bmr19163818wru.523.1660233433915;
        Thu, 11 Aug 2022 08:57:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d660b000000b0021f13097d6csm19837313wru.16.2022.08.11.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:57:13 -0700 (PDT)
Message-Id: <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
In-Reply-To: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 15:57:10 +0000
Subject: [PATCH v2 0/2] Option to allow fsmonitor to run against repos on network file systems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc: Eric D eric.decosta@gmail.com

Eric DeCosta (2):
  fsmonitor: option to allow fsmonitor to run against network-mounted
    repos
  fsmonitor.allowRemote now overrides default behavior

 compat/fsmonitor/fsm-settings-win32.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)


base-commit: c50926e1f48891e2671e1830dbcd2912a4563450
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1317%2Fedecosta-mw%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1317/edecosta-mw/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1317

Range-diff vs v1:

 1:  7e67ce8c944 = 1:  7e67ce8c944 fsmonitor: option to allow fsmonitor to run against network-mounted repos
 -:  ----------- > 2:  7a071c9e6be fsmonitor.allowRemote now overrides default behavior

-- 
gitgitgadget
