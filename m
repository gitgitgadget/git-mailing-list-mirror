Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FF51F453
	for <e@80x24.org>; Tue,  5 Feb 2019 17:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBERlQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 12:41:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37253 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBERlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 12:41:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so4605885wrt.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gBQqJCvtigAs7b5SHb2KQlWqhWk1wLgHWWaDJlQXQC4=;
        b=fLjfei9BtBSABfxsKJyHItSp8aNQOcVM/Q3IN606PCvSWuYtsValpERSwFXN97jr3q
         7r24FJiUTz1UY+alT//wRqg1oRRuuz+ceGXEPYI9fi+VS8bLbFCrYtH2p5lTMyXtdq8X
         HkG+XLD9toMaFPbVI0ar/EUl9MWa6LCOwZsFqGduwkrEA+sQzbVXh/w39Klxjrjmj+Mi
         vdTltnowIKTFAga7iexrW/LHE6XLbMSqF2tjNJdXapkxfT1wvBNnnn345IuALcXs5MnB
         wPJj+E0dgXIZVpiqtjEMjaDDECIbTVZIHMClTrOhzAvsC8HCS6StLkWv93dNBOStY20v
         jjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gBQqJCvtigAs7b5SHb2KQlWqhWk1wLgHWWaDJlQXQC4=;
        b=g2c/1Uk2KsvSbFHCUAn3FF0xaWQ9fI4Rm63kDW9MNn0I4y9USeqphAowfOq5eq+m3U
         8AkBfl1DuHTAFecRiOVy4UB6HS3CwRKvjLsHAEBgmKkJ4ZNeo3rDIgyKLU4GAGiJf2za
         Ef9k5EPk32klMMqvSzoBs4tfHIHPo/nslyD+k5pk06FIj1rYTwzI2g0aKEngT+t7XMIQ
         FZJNyZKqLBha4czd3TbYAHBmCMK8sFksTg/bHgfyNY4SInuzmwRMDIN3fBjRya64+WhQ
         PRIW3nz4zsV2l3krXcMRBdUaGORY/U98E5JtrUZ6xJVWAT8KD3evSBFQuOFGNSbjzVNG
         m6AA==
X-Gm-Message-State: AHQUAuZAp8AmBx/F/3lDkC/VFdgxYwwZpjPB41+wBPr1Jg5iW9dKprqw
        5gYFa7ywCvATMsLwRhl4BFg=
X-Google-Smtp-Source: AHgI3IbbFa0lw2a73K6fSz69TGBwy0If3eDj7ZN/E5oyxHvWOwQBsbBCnHxmztCb75Vn1EmCvZyNRw==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr4434509wrv.314.1549388473788;
        Tue, 05 Feb 2019 09:41:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c65sm18825518wma.24.2019.02.05.09.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:41:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Revert "rebase: introduce a shortcut for --reschedule-failed-exec"
References: <pull.118.git.gitgitgadget@gmail.com>
        <e61ebc30605e21ce71623903bc9c850fd964e826.1549367342.git.gitgitgadget@gmail.com>
Date:   Tue, 05 Feb 2019 09:41:10 -0800
In-Reply-To: <e61ebc30605e21ce71623903bc9c850fd964e826.1549367342.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 05 Feb 2019
        03:49:04 -0800 (PST)")
Message-ID: <xmqq8syut9op.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When contributing the patch series, the cover letter tried to convey
> clearly that the patch introducing the shortcut -y was included only to
> show that it is possible, with a slight bias against it.
>
> During the review, there were a couple reviewers who agreed with this
> sentiment, and the author was happy that this patch was not needed and
> concurred that it should be dropped. See e.g. Stefan Beller's reply:
> <CAGZ79kZL5CRqCDRb6B-EedUm8Z_i4JuSF2=UtwwdRXMitrrOBw@mail.gmail.com>
>
> However, it slipped by the original patch author (yours truly) that the
> patch *was* included when the branch made it to `next` and then when it
> made it to `master`.
>
> So let's back out that patch before it even slips into an official
> release (in which case we would even have to support this unwanted
> flag).
>
> This reverts commit 81ef8ee75d5f348d3c71ff633d13d302124e1a5e.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks for catching before feature freeze, but read the above again
with cooler head.  The revert message is less useful than if you
said 

    The patch was sent for completeness just in case it turns out to
    be too cumbersome not to have a short-hand option, but during
    the discussion, reviewers agreed that [FOR SUCH AND SUCH REASONS
    --- fill in the blank here] we are better off without.  The
    maintainer missed that conclusion and forgot to drop it while
    merging the topic down, and contributors did not notice the
    mistake, either.

As the reason is missing, the only thing a reader can get from it is
"the patch was not intended to be included, but we screwed up".  I
do not see why a more useful "why it wasn't intended to be included"
needs to be hidden behind an external reference.

