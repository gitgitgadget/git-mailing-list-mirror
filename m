Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58045ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiITFRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITFRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:17:44 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D10549B6F
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:17:36 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id z14so613359uam.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=7rUmK01uBzka0sw8ceYFGT1piVSeDenvQn6ebcZNCCA=;
        b=ko7BmTV/SOqpDc0jcImvEcDrWz96zxqVll3nUVJcUdNqIsxlA3WGmSeq1QX1sg414e
         OCLJ9vd2+KLc/FzKv8P15m5ql8kukeuV7dP4jJjgZJz6E9/E4XNdKuF66/K5lkF/HuOP
         TTlMUpfejMH3EIarjdxEpuGIBypSO8lbxIz9PYBZS71PZZLxZuiKWdQryKJB9/THyhjy
         +FCml257/LFOk3ZLJ/T6GlUw7snIUVqT3aw4xkGR1JqXotRPM6jlvKNEN3N0dNu8vp23
         kaxfofijaz9oR0Rq4uto8ikXJH9G+3ucMICuyg/97qiU2YmLpr/p2AVDw/g82kup121a
         EigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7rUmK01uBzka0sw8ceYFGT1piVSeDenvQn6ebcZNCCA=;
        b=DXpnm7IJZHJdyIIYVSxaoe2PYORWnYo8s+un2pDcqdhRe1e2jzOBNApfZb+KW07kf0
         oEdHXxktyxRJv+oM+UQ3C1wyqPQKJsqWCq6CLwhZ44JKwm/syvosAFCydXqnmnMSwHox
         KNrDwOARGuv3Nt6oA/xZF3IAkVl6tSZwFsZih8FNn5RXYn0djzsxEnaPyudAs+ydNup9
         g9zJA3IBsl0CuiQua9p2cmqd1XuUe7T6PIKq6vJQrk2qfqOdbNbxnqUtK9y0WHIh0iG1
         Uf1LMaF8O6LZnOk9K/msKzmTske6zB3NYYRSnwApMWry1WhjyJVZgBHg/WbqBe3nZ8bF
         zyPw==
X-Gm-Message-State: ACrzQf3SDZfK8AOmVU2C//qu4DAOhJeqkyvFmaBQEZjfQBr0kUtOHL4/
        hpoyxdOu8nn0K0DG00kHjQxMrOMQln//jSqRbmIEr/H3/+TTNQ==
X-Google-Smtp-Source: AMsMyM4pvcQape2G+X/0r5rmHZFT6loGHVRqzyAKkK3QIDewWDrUXF3xDtAg9UNsxT3tjlZEIRxkhXF6S6qnlbHH2YM=
X-Received: by 2002:ab0:563:0:b0:3bd:5f18:f12d with SMTP id
 90-20020ab00563000000b003bd5f18f12dmr7103172uax.8.1663651055479; Mon, 19 Sep
 2022 22:17:35 -0700 (PDT)
MIME-Version: 1.0
From:   Cuckoo Aidan <aidancuckoo@gmail.com>
Date:   Tue, 20 Sep 2022 17:17:24 +1200
Message-ID: <CACNTUeYfOXwF+WWAi=EVLw3snkAFtAoDkBK_YZG6AxVvPAHDQg@mail.gmail.com>
Subject: SSH key errors
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I added an SSH key to Git using a guide from GitHub
(https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-ssh-key)

What did you expect to happen? (Expected behavior)

It would sign my commits.

What happened instead? (Actual behavior)

It throws an error:

error: Load key "blah blah blah" invalid format?

fatal: failed to write commit object

What's different between what you expected and what actually happened?

Commits should work, not fail.


[System Info]
git version:
git version 2.37.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Wed Aug 10 14:25:27
PDT 2022; root:xnu-8020.141.5~2/RELEASE_X86_64 x86_64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
