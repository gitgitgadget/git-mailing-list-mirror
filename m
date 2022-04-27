Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C89C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 19:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiD0TQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiD0TOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 15:14:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7AA8FFA4
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u9-20020a05600c00c900b00393e729e655so1802109wmm.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uNuRHtJSQus1+6Fh1noMDel6zMOZVB1tWfGtU/0QLbg=;
        b=CQM1UPp2IWAd5oMOlKkNsh3vELfdq/u8bvpKvQi9OLfAWWiA0yR/fSsmyD+FHFwWDt
         bq7lwhy/y/w3rj1/QNTaKUw2LhzKmb2f2vdioqSXxzk0ihwt25Epgsl8WFsTLSMrXmLo
         vXMFlzLVl2qfgpHfRGco9P5MmpdfVuaquWpmCzuOtNQGn0PTEmj1lfsDH3h62u6dqbW2
         KbsUf7vpYObdyltZXkbqi7bjc+/S+KTaCctjgLlg5pumIze5SMKHg8/RH6lZKRxRmwbv
         S0dwEIxG/QNwXWgQ4iC7c4L4ibjTkIUO+t7h7hv7O8mqeB9nZDsQW5pxt+aOdqmyZ9G7
         AwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uNuRHtJSQus1+6Fh1noMDel6zMOZVB1tWfGtU/0QLbg=;
        b=XoN3Ey5dj7NrGtaINohYSFvBsRGmttIVWM9r7cVR2hY/r1CHLMBTOTeQq5w3K/zEn0
         BJm4XBnvGeDdavkwp2kE0xmCvvE45P1jIqbMfJ6Ce3CmwSKqiSEIM2Ji8pVEsc43pIxh
         JaFifJur5VgL6Cg9b6qMbsP38zQKcdU74Zs7eOuHOAaQNORnQu5nGrOhH6svkgzC9372
         lNXyXAqyrtGY6kJXGwGQVFjuDXros+3piMVlOOHCu0NcP/VkjiVZYANyrlOpVyhPZgCe
         rhOY6mmK0RSwcS7e3qlOxVYEQrraiIUjP3bQv/qOmwzfynOpk1AHSEaE9GYnGj8Mt3M4
         OsGQ==
X-Gm-Message-State: AOAM530Pc0THkCOoy7dQvpNoijQii/ifjFfC5/XlEGnXoLjcSjr1yUJu
        KDBUNooXQOYm5Enw3bnU/07J2sTKsqg=
X-Google-Smtp-Source: ABdhPJwQq6F8WqPgssDkK316xH+EOL9K5I7Zk+JRICWMfnAuzhQ1SBCt+TZ0QVinRCUbkoAPUNMZBg==
X-Received: by 2002:a1c:2b41:0:b0:392:9543:9782 with SMTP id r62-20020a1c2b41000000b0039295439782mr27173517wmr.124.1651086294025;
        Wed, 27 Apr 2022 12:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020adf8b89000000b0020adeb916d8sm7155281wra.30.2022.04.27.12.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:04:53 -0700 (PDT)
Message-Id: <afb80b8e9ee022cba9373f2191ee1619e5897b09.1651086288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 19:04:47 +0000
Subject: [PATCH 2/3] MyFirstContribution: also explain cover letter in
 GitGitGadget section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The "Sending Patches via GitGitGadget" section mentions that the PR
title and description will be used as the cover letter, but does not
explain what is a cover letter or what should be included in it.

Mention the purpose of the cover letter in that section, and give
examples for the title and description, leveraging the excerpt extracted
from the "Sending Patches with git send-email" section in the previous
commit.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 681bbefe9cd..96da32f7cef 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -808,8 +808,20 @@ https://github.com/gitgitgadget/git and open a PR either with the "New pull
 request" button or the convenient "Compare & pull request" button that may
 appear with the name of your newly pushed branch.
 
-Review the PR's title and description, as it's used by GitGitGadget as the cover
-letter for your change. When you're happy, submit your pull request.
+Review the PR's title and description, as they're used by GitGitGadget as the
+cover letter for your change. The cover letter describes your proposed
+contribution as a whole and is ideal to mention any context that might be
+useful for reviewers. The title of your PR should be something which
+succinctly covers the purpose of your entire topic branch, for example:
+
+----
+Adding the 'psuh' command
+----
+
+Your PR's description will used as the body of the cover letter.
+include::MyFirstContribution-coverletter.txt[]
+
+When you're happy, submit your pull request.
 
 [[run-ci-ggg]]
 === Running CI and Getting Ready to Send
-- 
gitgitgadget

