Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8132C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 05:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbiF1Ft6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiF1Ft5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 01:49:57 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B431F2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 22:49:57 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id t127so11012220vsb.8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SQ6ZSRMHS42VEPAu6XXseHgdmhxUs0Z/5FRVVLmqyRE=;
        b=il1xiPrx2p1KmSIZH//a4e8D+alRUhvM1VwlqZGxXMI6y383JtI4kE4KFf8l2K+4wy
         06alNGsy6sIVl5Uibrvi10BsUOHn5roXeeii3D9q65/q2NmvmYp7hYu3BSrIQHaQ2x/m
         Gus94fdtRFLQQ/P/YHd740LRxQ4t6Er0/LVFrGT3U0jjtTwb2Y91GLcArihyIK6ViVxu
         2Js/DIgFx16pICO7r9Mfz3ZqixDlKYwnlTLvwzRHhDqYLTyLbKzpHYmMQi2tjXZafdG4
         RETM22VReuaFNCy/8MXkeu+dD1PNFqkQPhzQRHbJqLFI41iGQkHojOH07EQyZcn0jB5V
         aKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SQ6ZSRMHS42VEPAu6XXseHgdmhxUs0Z/5FRVVLmqyRE=;
        b=eHosML4XIkPKbxsUOpdwa7MSlfKODcgXeLVsE/jrxFC9YlmUvMsfb3qZIfo9AeR5Gt
         5G1qVcSmH93ZwJQFQs2524mey78+46ttG9F2tHuGkaWujGkzrtyTGAb571+1ndgLK2L6
         4jb0p2muTpDfK7YmV0xq9aodsseX730Iaq4SnhI1e1PZwOfjysWmqiNiA+FaorY1bPmt
         lZ1icH6VNgEM0L1HIa94KAVC/t83EQw2nY9sbKuk9nCv2Uhb4K/9RD8rq6FmwzVp7tML
         c2hFZm+r+dmKfxcb6f0YpkbOdFS5BAsQO7/BzF/bDbNoNthXjv0n9n1dA66pa4HW3pQj
         iXyg==
X-Gm-Message-State: AJIora9471rx9v8+yHchIscdu7Hr8c2H+iroZjL8IymaVDt7lP5XXmyV
        xKN7S06K8Jr6GpkejKKypJ4eqYKwWCKdqsyAN/+ipKEqO3DvNnNb
X-Google-Smtp-Source: AGRyM1sp1PoCrIiiKkPfDgYHqStt9H/8H9uc9trG5ZH+FudMuTQJ8THGTI1a1SHGtrqnoZow0chl68CI2qIXUfq6j1E=
X-Received: by 2002:a05:6102:101:b0:354:355b:711b with SMTP id
 z1-20020a056102010100b00354355b711bmr603666vsq.61.1656395396145; Mon, 27 Jun
 2022 22:49:56 -0700 (PDT)
MIME-Version: 1.0
From:   Manuel Boni <ziosombrero@gmail.com>
Date:   Tue, 28 Jun 2022 07:49:20 +0200
Message-ID: <CAKP36g5G6KBEn8C+H8rxj5atfm2RKTfLAPtVveqg-8r4nqbxRg@mail.gmail.com>
Subject: Missing completions for the 'config' subcommand
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
1) Start Git Bash, and optionally use 'set -x';
2) type 'git config incl';
3) attempt to tab-complete the last word.

What did you expect to happen? (Expected behavior)
The list of available completions should include the 'include' and
'includeIf' expressions.

What happened instead? (Actual behavior)
The expressions mentioned previously are not present.

What's different between what you expected and what actually happened?
The list of completions for the 'config' subcommand does not contain
all the available sections.

[System Info]
git version:
git version 2.36.1.windows.1
cpu: x86_64
built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 11.3
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show

Thank you for your attention.
