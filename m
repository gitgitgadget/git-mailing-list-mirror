Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104961F453
	for <e@80x24.org>; Mon,  5 Nov 2018 00:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeKEJ6s (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:58:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeKEJ6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 04:58:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so2453824wrq.11
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 16:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dLRc2Z2+So/4D3FGPH4xqxG+K6vBikSXZ5zbrlrApBA=;
        b=raQmMx2bRgDgA68EnbjQ+M6ze/GLavOFMzTWHx+baeHU48srJ3iYjDJovWFRhoWPH5
         6xlzwT860dkN24xDp0SpZyNVd8d0scwull9JN4AdGyGknOJ850xWlGEXhs5xMCu8MJA8
         WINXkDn8N9kOzxuQEL7WyNLJwfVyDcCUyuc7DAHm9Jqd60X/7SkRPmqTmLVk/i1JDN2K
         1cIsSV5Sn46QmglvOKkCZY5XVRJpQICoLnHmGfq6hofMzOgzAOOVVvtCon/bwY1yPyKy
         gA+5gamHzYj1gfM2NrcI1NyfT1dWa0Qaym0tlu8u2K3WAYR9aQRazNneFWJnrsVGEeGd
         voUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dLRc2Z2+So/4D3FGPH4xqxG+K6vBikSXZ5zbrlrApBA=;
        b=RX/m9PjRNU3s3m5+bIjbCzcnFbBscrLb6g6uajCc/LunvC+yPUQTMomajX+VRy5wUQ
         elkP9QFcuPi9Bq9O+Uc3xnp6pr1q0qf3YbW4JACpLWmi9gHgEHIFrCp5qWujt10gJtKt
         LmiPYRlYbCSr+irzQ00b3Z1Wtt9oSJlED6apAE52t8Ts/n6antnKd8h8WviU6Pr6jIHe
         BULZzT8PXjWEZ52aEU0tI63Hq9oQRBPp62vcp7dyuq9GZyqNDnNrTb7ErPMnkY1QbMYg
         h87MSpEpOXLfvZZEBFZb4drFxiDj6X4SmDVo9AWCP5Dq6xeio0OLrsKIzx6BfyyxAS79
         yK2Q==
X-Gm-Message-State: AGRZ1gKHY7ZJudixRe4lXyw/Qp8KpVrtHITPAzbxdEx4MdRGIEAiylx3
        RcI1Eszotb/A3QT/Q7srauk=
X-Google-Smtp-Source: AJdET5dhTbD7zj1K2kVfKn2I7/rgc+nFSzReN/J0iE/STl2sxHgmz+P5Yq1odTM4DFuWRt9IIrqjxQ==
X-Received: by 2002:adf:94e2:: with SMTP id 89-v6mr17233284wrr.25.1541378511578;
        Sun, 04 Nov 2018 16:41:51 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p17-v6sm7247641wmc.16.2018.11.04.16.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 16:41:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mikkel Kjeldsen <commonquail@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "Simon A. Eugster" <simon.eugster@eps.ch>
Subject: Re: [RFC PATCH] checkout: add synonym of -b
References: <20181103191825.15674-1-commonquail@gmail.com>
Date:   Mon, 05 Nov 2018 09:41:49 +0900
In-Reply-To: <20181103191825.15674-1-commonquail@gmail.com> (Mikkel Kjeldsen's
        message of "Sat, 3 Nov 2018 20:18:24 +0100")
Message-ID: <xmqq1s80mk36.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mikkel Kjeldsen <commonquail@gmail.com> writes:

> Add --new-branch as a long-form synonym of -b. I occasionally encounter
> some confusion in new users having interpreted "checkout -b" to mean
> "checkout branch", or internalized it as "the way to create a new
> branch" rather than merely a convenience for "branch && checkout". I
> think an explicit long-form can help alleviate that.
>
> Signed-off-by: Mikkel Kjeldsen <commonquail@gmail.com>
> ---
>
> Notes:
>     This makes the synopsis and description lines look a little clumsy (and
>     I think incorrect...?) so if this proposal is accepted perhaps those
>     parts are better left out. It is meant more for training and
>     documentation than regular usage, anyway.

Sounds like even you (who wrote this patch) expect the long form
option to be impractical for regular usage and everybody would end
up using the -b form?

I am borderline "Meh" on this change, slightly on the negative side,
primarily because we'd need to worry about what to do with "-B" if
we did this to "-b", and I do not think it is worth even spending
brain cycles to worry about it (e.g. should it be
--force-new-branch?  should --new-branch used together with --force
a better-looking alternative?  if we were to add --force, how should
it interact with other existing options the command support? etc.)

But let's hear what others think.

Thanks.
