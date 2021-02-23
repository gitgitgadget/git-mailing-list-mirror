Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_05,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F5C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E2A64EC3
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhBWVvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:51:07 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34959 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhBWVvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:51:01 -0500
Received: by mail-wm1-f51.google.com with SMTP id o16so128249wmh.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 13:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E17oPxGPJgRChMbSmlIXmZm9EDZdd1WYVmwc1KqGKLE=;
        b=tPVuAkqdGgmfwSOhM990cKZ+R0ug7MDFiOp5qVhRXRIhF7NNX9MEnH5zePyp2gYUve
         Ob7d1pDHr41Zt8nZ/JLMKbdo+ypeeWmGHM5dn0+flfB07yG36ewVbfM7Y6lMlok4oB1C
         GSm5paLFqsQoidrW+vHoacRPc79+vlsxYms+7xKVbiullKzeLnJe+eqME7wyJBLhXuCx
         EGM7nTtBX3mJTB1kIdlcPbgd3UAE5DD7ajT7tzWqd8RLBKrCJu9XjFG6U2M6cFChFrjz
         QsNHdylUsvRSZ+e0bvnqZZneM6r9X0iH1xx/RFpVE7PAP0KmrNlR5x1kwEo/O5t2sc4B
         lSLQ==
X-Gm-Message-State: AOAM531d5+BA+3ig+jT4V2JCF8B1DkVAGXphpf8Q00swpb0ghltTGkeR
        CGJp8bHPOA+5mSqjgK+MAHlwJNYi0sff36oYNy6TEisi3I8gtw==
X-Google-Smtp-Source: ABdhPJwpyDnlHEkFAjq7kp4RW4BRiSu2HyeMLCci4C1GocjZdFbYtjmhyYTGK1/ZGcnHfJP6QB92sBPTueN9xk/V5NI=
X-Received: by 2002:a1c:e905:: with SMTP id q5mr726764wmc.84.1614117020284;
 Tue, 23 Feb 2021 13:50:20 -0800 (PST)
MIME-Version: 1.0
From:   Tilman Vogel <tilman.vogel@web.de>
Date:   Tue, 23 Feb 2021 22:50:09 +0100
Message-ID: <CAAbQbbCAqbJhU05WSWD6HmHpAxLqs0LbFzQmKHNaDUg2kHkZBQ@mail.gmail.com>
Subject: What does `git push origin --delete ""` do?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Because of an empty line in the input file, my script

cat remove.txt | sed 's/origin\///' | xargs -d '\n' git push origin --delete

executed (among other deletions) an implicit `git push origin --delete
""`. I wonder, what that one is supposed to do. I think, it should
produce an error just as `git push origin --delete` without a further
argument does but it doesn't. It seemed like instead, it tried to push
all my local branches to origin!? Is this something that should get
fixed?

Best regards,

Tilman
