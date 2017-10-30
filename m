Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DED2055E
	for <e@80x24.org>; Mon, 30 Oct 2017 06:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbdJ3G1S (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 02:27:18 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50201 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdJ3G1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 02:27:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id s66so13395858wmf.5
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 23:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RIw0W7vtUk+e52bg5zC9m8kCb+s2KlQumhRz2APy440=;
        b=atLS1N8QbNSdIORcFZ3baHHb2ea7/Njiy6UKen4rrSVUppWN4/jLtFc7F5U/uINZrv
         1fhE/DyfmpyNhOqDZ8OWfToeQRql3qDgvPWc/TdgIw624QqnH1QmrgMnupsetsvtr3EE
         r0FzMzTNgTyiAdZPt4++zr5LMZ7kQVwj9gnbDr2gkZVNWj5fcW4EdDachHX7/ckALPjp
         xc3nf6p3IU85Fo84cYgxDA3ChISvjwtErWoJ8KbFLU5jlr2i0VDyBZ56xv1lIFeObNln
         8uxfbPX3SYrm1kvWGwhKPMTNdNTMQSJQiimoalygck0lTHHtKoBMnphsXEe2CXMoIFAa
         we4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RIw0W7vtUk+e52bg5zC9m8kCb+s2KlQumhRz2APy440=;
        b=RxGlwpBevHT1RZkkAoAdMOWptZErGtQPP/e2yRDG/xH4fNwKUYqYPQknsUpvXn/Y+I
         Zg5SZu+E50nJjFKH6G0JlfRYpXghHUw4Ks+hfaaNCcwC7eSffYGirE3nBr11kRrDh9y/
         xY02rrNS4CsQ7yE2g9NZWdkIEpuTFOLME9ff6rZmK0JBcn+vR0G2bNG9HvW2lpejmM6x
         nKnoUTW0Wn8wYA59K1P20h/am0VKVAz4PYzfpZDnx7/WO1yIRDTd/hasPl+7UnpRBn14
         RvBhWYPSKNu0ZVn6OBpsNQmUGY8CAWDlxYgSsHnPzfxqklhLPYWpPwbYxtSILoowZU8d
         7blw==
X-Gm-Message-State: AMCzsaUFLShykvvKtBbh/X1MFD7Mo8wGPr2Uil8APeutFOsq/OgwC4Yc
        5rTx09tfbMdgey8YNVTFaFqLcLUS7pSNexcOURo=
X-Google-Smtp-Source: ABhQp+TBcfYR2LuR7gF0X01+Lj3pThEASYo74M/+ta+qYvzkyK0Cn6UCKQOkd6Tsfe2IwAJJzulgVIMjIPWwqNcb55c=
X-Received: by 10.80.217.15 with SMTP id t15mr10706697edj.217.1509344836042;
 Sun, 29 Oct 2017 23:27:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Sun, 29 Oct 2017 23:26:55 -0700 (PDT)
In-Reply-To: <xmqqo9op71d8.fsf@gitster.mtv.corp.google.com>
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
 <alpine.DEB.2.21.1.1710281740070.6482@virtualbox> <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
 <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com> <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com>
 <xmqqo9op71d8.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 29 Oct 2017 23:26:55 -0700
Message-ID: <CA+P7+xo5UgUPQCYU-LaXn+HZZ1qe++KOevTMh2C1sgnzK0SAQA@mail.gmail.com>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I am pretty confident we can fix it....
>
> I am sure we can eventually, but 3 hours is not enough soak time.
>
> I am inclined to leave the fix for 2.15.1/2.16.0 instead of delaying
> the release by 10 more days.

That's fair. I'm not even sure it was introduced since the last
release (I tried 2.12, but not 2.13 or 2.14 manually). Thus, it likely
wasn't noticed for at least a release, meaning it's less important (to
me at least) that we provide a fix immediately, since it went
unnoticed this long, likely that means few people will be impacted.

As far as I can tell, you'd only be impacted if you attempt to run a
git command from within a sub directory inside of an exec statement.
Is there some place we can list it as a known bug in case someone else
runs into it?

Regards,
Jake
