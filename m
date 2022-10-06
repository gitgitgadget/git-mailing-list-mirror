Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3FFC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 11:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJFLpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFLpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 07:45:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E6895CE
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 04:45:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so2266669wrb.13
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=PbVsZhLoroLG4cHAyYnSDLkTpruKHHjaQeuOSe89Gxw=;
        b=pxPfH51AfZlvnbTXll47JRizyLvufnqYwOxpJSyLGes+f/UYbBruQBdsshzouQ18ln
         3yrtC1S5k8oJwe6wpDx+5a1qlFksvGxlTseRj1fSnWF8OlUcFdLnYy2zcCPpqlE1k5so
         ZrStAa1rQFzGRmbwnkCA+Fpqm5eDJmdY1TTdV3QMo9jeHvfiY25GR2CMV/3vkBf0LBbk
         U3t68AizJ4r5tk3cxEZMQKcul4If8kPcOnN3QS4pHgKbmSVTq3k9AKdiU5ob5cpcBWfv
         +bTBSm1rOjAh1n5bJhrUXS6GGsgPREC2f+qJpWfOWmO0FfGi2OCMKU4F/7ubKfUBxsEi
         nvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=PbVsZhLoroLG4cHAyYnSDLkTpruKHHjaQeuOSe89Gxw=;
        b=C+cORoDi5o4mYqXQaC/ebRtTUWPk9Keq879XafeOgPEJx0Z9R3g6d3ZVjc6N9NrpRo
         1Wx2oGlJXB9ywZdWfQ5IU3cKyryCckmkM4Q7xmJLu8+fjdluPRT/hjRta39jjhDLg6bu
         tSOcZrQ4N5vtzyIZepv1iqyh9IaYEQFk6jlTAxqeOKpYnRY9sKQ5+lwrMtmWezoy9/u9
         brRj1JAKZ8aVTnGmKZHyM56jqYqvWtAoXc0FjmwmtlAV+knCOb8rDjbhcQQJ5pYi8y/4
         QeWxIgFesLHy5Yj0Ac4kg9m+qBIRpIego8HfgB+djCewk3DW2CNzpv25I8E7+sglnD0o
         1S/w==
X-Gm-Message-State: ACrzQf3lBf0Npo770X+n+GWJ7LPwOv9EKSuqBTY1NU0A8LkGxHn7RXlP
        r1Jk7s6BVlq+eOp+gc0l273Hkt0yu2Q=
X-Google-Smtp-Source: AMsMyM7QAZqZ74gDpYA2zV0FKrSIaTbmw3qrdy3PqamOuNE0AiiCgJXipWowm7oZulSBxMlYs7EqPA==
X-Received: by 2002:adf:e10f:0:b0:22a:43e8:969f with SMTP id t15-20020adfe10f000000b0022a43e8969fmr3058319wrz.292.1665056748648;
        Thu, 06 Oct 2022 04:45:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c415200b003a541d893desm4688953wmm.38.2022.10.06.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 04:45:48 -0700 (PDT)
Message-Id: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
From:   "dsal3389 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 11:45:45 +0000
Subject: [PATCH 0/2] Minor Refactors: remove useless else
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dsal3389 <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git.c removed redundant else statement - it is redundant because all we
actually need is to check if there are no arguments, the program print
helpful information to the screen and exit, we don't need the else for that

git-p4.py L371 - remove redundant else statement - same as git.c (made sure
not to repeat what was already done on #1349
[https://github.com/git/git/pull/1349]) git-p4.py L404 - minor, there is no
need to decode the output and iterate over the variable if we may exit

dsal3389 (2):
  python file more pytonic, adjust "if" and "for"
  removed else statement

 git-p4.py |  9 ++++-----
 git.c     | 14 ++++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)


base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1355%2Fdsal3389%2Frm-useless-else-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1355/dsal3389/rm-useless-else-v1
Pull-Request: https://github.com/git/git/pull/1355
-- 
gitgitgadget
