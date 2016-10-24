Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7C420193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757434AbcJXTgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:36:53 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33488 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757423AbcJXTgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:36:52 -0400
Received: by mail-qk0-f178.google.com with SMTP id n189so246665402qke.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eoB0fPBUvLUcI75jx/WBiecfGr5dUu1Nvd3NiwyGLKM=;
        b=dIy0wGwhrNiO+4+Xv3B17lcc4JNqTZ6u8Z+tTUGvqH/vKlM4HthYEqdKZCEGoF9Fuw
         BDc9EeQOBEu0RupFFzlaEJrziQgc1zqwKsd4xYz5OHKmKkXmm36lLLTdexL5gWJnfDIz
         caQOKwefN/Rtut0fp1OBD6Pq3DpC6+h73dCxGPYMVGSGWCACZp104Fwfh1QFSzIT3h1b
         3t7q1JQYmpCUGjRW1UoLs/E7ID9IrmRQIWuSxYJOnz7ectsYfhFqACIbjNoM821SHvGI
         qZOTayq3O1h7f5LylNftlckeavD0ochpgx8AllHBGZCROpPq9d9kyj8PZnV1f/AsIgZH
         UVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eoB0fPBUvLUcI75jx/WBiecfGr5dUu1Nvd3NiwyGLKM=;
        b=ZC9U4KpJFxPesVCk8KxhuVozxrFZ0gTOF2hXI9jsoFM6q7C2I4FicSZC5JH9W30kIb
         tOBMZN77CPCsJ2N6e6hPeGnNPwqPUohr7IlG4LTbqldkIDiJAHIxSxgRHtpLUnVXJ2Lf
         09TBuF7cXlF0l9voHeJZzSRPJfUk97TPgu0LP9Sof0xm9J2D53bcQYdXJuXQpqKVko4X
         88dodOSbDeLiBnH3bHTtBsbWaHn7yA1igPXfpwjXFnFy9YqWDnVtPgWg5/3WC8j8Kzke
         wqt8tukqdNG5yVFsuCB7ES8NM1M8vt2Icxv/F00CYEeD3PwH4IOBLJnHkdYorb7EF+xH
         pM/w==
X-Gm-Message-State: ABUngveuh9mrutND38fcG5aZioZ6ZejcZUv0f2r66s0bHl3KDmKlYb5zoMeHHF+q5MUoyB0d9Blhb7HwEoq+MWfn
X-Received: by 10.55.20.164 with SMTP id 36mr14542920qku.86.1477337811159;
 Mon, 24 Oct 2016 12:36:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 12:36:50 -0700 (PDT)
In-Reply-To: <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
 <cover.1477052405.git.johannes.schindelin@gmx.de> <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 12:36:50 -0700
Message-ID: <CAGZ79kaq85c1Gk1aRSrdQGp1Nm9p6tN0jXbFvTN0v+9ehooxYg@mail.gmail.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2016 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> There isn't enough time to include this topic in the upcoming
> release within the current https://tinyurl.com/gitCal calendar,
> however, which places the final on Nov 11th.
>
> I am wondering if it makes sense to delay 2.11 by moving the final
> by 4 weeks to Dec 9th.
>
> Thoughts?
>
> Speaking of what to and not to include in the upcoming release, we
> do want to include Stefan's off-by-one fix to the submodule-helper,
> but that is blocked on Windows end due to the test.

I'd be happy either way, i.e. we could revert that fix and make a release?
AFAICT, Windows only has broken tests, not broken functionality with that
submodule bug fix.

> I think
> everybody agreed that a longer time "right thing to do" fix is to
> address the "when base is /path/to/dir/., where is ../sub relative
> to it?" issue, but if we are to do so, it would need a longer
> gestation period once it hits 'next', as it can affect the current
> users and we may even need B/C notes in the release notes for the
> change.  Giving ourselves a few more weeks of breathing room would
> help us to make sure the fix to relative URL issue is sound, too.

If we want a longer gestation period, we'd ideally merge it to master
just after a release, such that we "cook" it in master without having
it in any release (we had a similar discussion for the diff heuristics IIRC).

So please don't let the release schedule depend on my ability to deliver a
proper patch for the submodule path issue.

Thanks,
Stefan
