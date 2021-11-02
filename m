Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF983C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CAF61073
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhKBVIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:08:00 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34420 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKBVIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 17:08:00 -0400
Received: by mail-ed1-f42.google.com with SMTP id g10so2094101edj.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 14:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW8sI/sV0c9lgCYzRFX2wWQotGopUwGebtktyzH7AV0=;
        b=WUnmLs04WNU7n2eEwRWkh4j47bG5ytZg2pkGLZxvvFJvycVThTPS3h+YGpoYscXFDA
         EvquNNdSOIc/Sj7ST/JzIXoQRF/f36LtKuQuc6pfOk7j6Jhz8TSjlSNFzhk5FhhZlPLo
         UlAOJrpFj21M1bwm/iNVs0ZIVz+jBBJHb+LfvalPLLbYLK/K7Wo+tseEzX7VfpZnsCQ7
         /n4DaKthGbjkDB3rgZZmJgVfea3zEs501WYT8aGmk4ZLeoaXUKMhxOdTzLGVdfH3t1TL
         xp89dIBSNP7VVzLjE33yHEZDzMMnHMNB5nz/rPvBIQ6LYABQR5KxJTrudGPULNDPn5EW
         SlJw==
X-Gm-Message-State: AOAM532uaehcBFigNfEutiItEo9QeLpXhodtFofoCHfryLYyli2AOqt8
        YACT+nM/Iff6TjNhMtB10Xr1qEFoL9gaR4sDPgo=
X-Google-Smtp-Source: ABdhPJyBmQGEs+Iz8t84WBZtJ/OkTCXY5Moj9pjcq7tXBLGPA0vlO4eGL1JBoW6MbJUEZKkFbWxKlDmBsip91WcekKo=
X-Received: by 2002:a17:906:1451:: with SMTP id q17mr47615589ejc.36.1635887124117;
 Tue, 02 Nov 2021 14:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Nov 2021 17:05:13 -0400
Message-ID: <CAPig+cSWDJ-zMv4zgU4oWcqXmaaCiH+03wSzQg2O=YRHthf55A@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: fix rewording with --committer-date-is-author-date
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 2, 2021 at 4:10 PM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
> fast-forwarding, 2021-08-20) stopped reading the author script in
> run_git_commit() when rewording a commit. This is normally safe
> because "git commit --amend" preserves the authorship. However if the
> user passes "--committer-date-is-author-date" then we need to read the
> author date from the author script when rewording. Fix this regression
> by tightening the check for when it is safe to skip reading the author
> script.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Should this have a:

    Reported-by: Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>

?
