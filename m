Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E018F1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHCTjY (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:39:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39652 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeHCTjY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 15:39:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so2862008plt.6
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mZjYmKv6CXjHAVgLz7YhaxakhHyNR/X/vXuePF4VJLo=;
        b=OE1LUCiISK/xipRmWIb3zEWO62sutt1kQwOwZsq0E8ifh9L4/S23u+ORG/r+JcSp1G
         18uut/nTAhUYJvvfjtP3Ts2m2aYH19lQNMGV4dycq3JDDg4JOzuoHo97BpW0jMjwj2jW
         jcnjJgdLWU8qZPW3fF3mo92NP0CdcEwPvIEtsJQ/XrmcGe12+h2Uhf8Re4pLIGLMNytq
         J3heolFr0P02wcawm1anB5pM5CmsYhZ8v/KbQhGgA/K8TmVa8GpnZ/jvtypXMNXNaDSb
         dOWyAiGJf5DLPtPHzo08UT5vy/gO0xejvhaMU1SbQ1cnyUvnEPbLnJykT2EVyd4I4uYV
         51yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mZjYmKv6CXjHAVgLz7YhaxakhHyNR/X/vXuePF4VJLo=;
        b=IRTZvZIamF6MmUMP2rt0kBJK3jFveJkhxbX5J1rVqJY5zU9q96krg1BXulP4eS/Vvy
         aIwivUtWRBk18Q2pw6xm6YT1vflgjzrgdNlJfHCGE8ydllR10DNBMKeTW36MvlPsI30I
         299am3+2Ikx2+Uz6utHmBhNwRQFUodeb2fUYpXeBkkCd1vxQ5RqSDxXR5pA2xfYdZwYL
         VYmj1zxTkMS+8svzsvC3SpHv1ETTTa82shZZv6L2qZu3LcR0Fn19PcbzhhGm15XReBhh
         Ov1IUFi1fEw3RL1fItWjaTpmjxW8IueNEo1CgxK0XUiSHdTP1rCdK2akN5vrc+f2zFq3
         pRGg==
X-Gm-Message-State: AOUpUlGaD6AERjhhiNCAHSSOetTln4vTDM1+SceaWJoQE1vJNcYVIg7T
        g1NIaT5+fHTUsFtRr8KZIcQxTCPC
X-Google-Smtp-Source: AAOMgpem0KWY/iSitu/OZwtg2zCClN7SrofafRzuiKRem49TKx6hjZOO9D6tyJb/AvP4Vis24jAsYw==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr4561934pls.84.1533318126555;
        Fri, 03 Aug 2018 10:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id q25-v6sm12387109pfk.96.2018.08.03.10.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 10:42:05 -0700 (PDT)
Date:   Fri, 03 Aug 2018 10:42:05 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Aug 2018 17:42:01 GMT
Message-Id: <pull.13.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Make git rebase work with --rebase-merges and --exec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported via IRC that the exec lines are inserted in the wrong spots
when using --rebase-merges.

The reason is that we used a simple, incorrect implementation that happened
to work as long as the generated todo list only contains pick, fixup and 
squash commands. Which is not the case with--rebase-merges.

Fix this issue by using a correct, if longer and slightly more complex
implementation instead.

Johannes Schindelin (2):
  t3430: demonstrate what -r, --autosquash & --exec should do
  rebase --exec: make it work with --rebase-merges

 sequencer.c              | 59 ++++++++++++++++++++++++++++++++--------
 t/t3430-rebase-merges.sh | 17 ++++++++++++
 2 files changed, 65 insertions(+), 11 deletions(-)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-13%2Fdscho%2Frebase-merges-and-exec-commands-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-13/dscho/rebase-merges-and-exec-commands-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/13
-- 
gitgitgadget
