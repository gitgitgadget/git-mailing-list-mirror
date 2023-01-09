Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A386C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjAITRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjAITRX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:17:23 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3E4829E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:16:57 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so11959536pjb.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 11:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsfg4UgA2WHhB9gw1+yOniipFbE5RFgZQCxyRhrsh4A=;
        b=ktAVZWKC735vnO8qaWiw1qKpdMAO84Sskp/CQkZlGu3RLeHN/nT1oI6NerDBZerNEQ
         o1cJHP118DVpmUmLhKLC5CVEGSyMStkxClc3xRA24cvYnvQFjmRG2qdG3HZLrObccLja
         sIGn23ljKtUb9A7lW1KQ49d3Jl4fUv5pEDvyDUEs1d7irctbSJaCH2BPRHhx5zqWCXAi
         Lglbpim5zFgETz01bvMoTYzCI8rpjLfBc5NZfiG9i04+oEo8/WTfBNxXK/FnzDzvQP6g
         jHf0IiP/cQwa31mkXOpqRWoRJJqXz8dwGCvjIBD8qBYxheBBpJxM31nbMkJ5kHt723Xn
         lSjg==
X-Gm-Message-State: AFqh2kp5w1m8RER3PnZhbsMCUGy46YWp0JX9IhhUSDkrocQIedqKtREK
        tyYGW6nTmjfsE+m2DD0XkEExkZ/eGEx2pvM2vrU=
X-Google-Smtp-Source: AMrXdXuX/iKpTqzEP/zVjLCCIMETXQH40L8U9yAR6rqq7Nrr/ediYv7Ero7/UDTtehgvENACUvEuoG15LkN7c08Epkw=
X-Received: by 2002:a17:902:cf08:b0:191:34ee:a3fc with SMTP id
 i8-20020a170902cf0800b0019134eea3fcmr4537381plg.12.1673291817254; Mon, 09 Jan
 2023 11:16:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
 <xmqqbkn8wcqo.fsf@gitster.g> <018501d9241b$fe4b1270$fae13750$@nexbridge.com>
In-Reply-To: <018501d9241b$fe4b1270$fae13750$@nexbridge.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 14:16:46 -0500
Message-ID: <CAPig+cQ1PMYhWiwRiq2eOWzHYmqcCC6QfkHCuVTxaeA7fz0ddw@mail.gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 6:20 AM <rsbecker@nexbridge.com> wrote:
> On January 8, 2023 11:31 PM, Junio C Hamano wrote:
> >"Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> Subject: Re: [PATCH] doc: use "git switch -c" rather than "git
> >> checkout -b" consistently
> >
> >Hmph.  When two things work equally well, is it a good idea to describe
> only one
> >"consistently", or mention both that can be used pretty much
> interchangeably in
> >different places?  I am not 100% sure "consistently" is a good thing here.
> >
> >Thoughts from others?
>
> git switch is still marked as EXPERIMENTAL in the online help. I don't think
> moving broadly to switch from checkout in the documentation should happen
> until the EXPERIMENTAL designation is dropped. After that, then "switch -c"
> should be used everywhere instead of checkout (except for in the checkout
> documentation).

Such a point probably should have been raised when 328c6cb853 (doc:
promote "git switch", 2019-03-29) was submitted, but since 328c6cb853
was merged nearly four years ago and has been pointing people at
git-switch all this time, it's probably too late to use it as an
argument now.
