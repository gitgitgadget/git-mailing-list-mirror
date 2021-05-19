Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9600FC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B7F610CB
	for <git@archiver.kernel.org>; Wed, 19 May 2021 17:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhESRst (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhESRss (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 13:48:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC59C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 10:47:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f12so16622932ljp.2
        for <git@vger.kernel.org>; Wed, 19 May 2021 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=k6Kayqrg7wlLeIpTvR8Gxx3d6VUcRNdvuYyJcm3n2jQ=;
        b=gssAS690EkdKggaVa0Cs5D0kNdbhjU7dSbHofNoPbs6E5pWUPlm4vjPPiIV3Ingeg7
         68AQ1JKRx66Zp2vqMBXaxaY63qyTqn8jjN/cIn8ZWclMX8VO09wfZsC1BAyoO8KPYc/Y
         Lss+DhLOtnE5ispBAuUIQrJWrHPH4s7KcxZihOQV+a+HBn/JPrISo1sW668FqcXMODib
         GbRVw3IyKEV9PfObeoaTysQDBvsfJvyqp6yOkhn5GRGRMNvlYgWykBfCK2SBziCJ0e8Y
         JvUeMaxOKWNm6Ixrdy2KcYr41S9W5v8pLbKZPZSMUFB9YdCQD8evGHz9VpFCFXFvaaWD
         y0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k6Kayqrg7wlLeIpTvR8Gxx3d6VUcRNdvuYyJcm3n2jQ=;
        b=fz/Mozp6zzPI3+nYdsOYtwnozDI3/MnAnbi4xwHxFmJqBFDXkp+iwoF/fm55x5Lj2A
         1r3SAKh615+A+MhkVCdoKNAbnMTXT2OtU4yFBDEyWn0oHLWlobyq+gFHJDoLmmn3ZQwr
         u5HtngaQETvQlUiCvhVyJkTDgufkbsNFNVpSn1Vj+sCIU/0ZkIYjvRF39Qee3pTsc0Cz
         buUiEtXQ6jzb5qLtbuXIEOxyWtiAq4PokRBJbWiVQm+8q7TCale7SKy1At9bfNKsMOsD
         I+voRaqBEmuFCGwxFpiMSeSr47F7P1qzrzpfb8b72n31FvsxcmhiS3aZVzzTGy5eSY9M
         y/YA==
X-Gm-Message-State: AOAM531YawkhibvT5tsTansCWbnQcfjJOD4f7VWK8M+XTbqhX50r6cy7
        mDynY5w+1IcDxXHgCF6j5BEFq/0ZrhcHyYF1xla4Y1pK7BLstQ==
X-Google-Smtp-Source: ABdhPJyo1D1U+AcJFd0+VkS5aVInuBXFJaQ4UX0pEB+kV/pw9TcmbTsFGY/Z2qNzhJw69c7r2wTUgijK943XcOBmLMA=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr244012lji.273.1621446446530;
 Wed, 19 May 2021 10:47:26 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 19 May 2021 10:47:15 -0700
Message-ID: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
Subject: Should we do something with #git-devel on Freenode?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seems like there's been some kerfuffle with Freenode staff and new
ownership[1][2][3]. What does this mean for Git project? I think #git
on Freenode isn't maintained by Git developers directly, right? (And
anyways, the MOTD on #git says the moderators of that channel are
monitoring the "Freenode situation" with a pointer to [2].) We do
theoretically keep up #git-devel on Freenode, though it's largely
silent. Should we be worrying? Migrating? Deciding the low traffic on
#git-devel means it's not worth moving? I'm not sure how to balance
being alarmist and being practical here, but I thought it was worth
bringing up on-list.

 - Emily

[1] https://boingboing.net/2021/05/19/freenode-irc-staff-quit-after-new-owner-seizes-control.html
[2] https://gist.github.com/joepie91/df80d8d36cd9d1bde46ba018af497409
[3] https://fuchsnet.ch/freenode-resign-letter.txt
