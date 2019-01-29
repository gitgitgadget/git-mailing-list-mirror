Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359961F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfA2V6c (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:58:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38460 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2V6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 16:58:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so23800523wrw.5
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 13:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DzltcHCJUsFG0rea0HNjt3o3lCKgQChn4Xp5dylWdSg=;
        b=iY6DUIlAgoRMW6/2jxkqP2hJW/TFS66ccORkPnZgPqE09HWbeAdSCQkKKOp2tTpTw3
         VY37K5UU1Zy7Q++exd0BnvIkHJJUQ5BKp8hANY/7xgc7AStSV58lBkFgUL50r1+zp7Px
         ZzQMqqWMHUWftMTw+66152GH7Z1bWNnmwD5E9Ph/gTgMGXehJcK3FsBv8tf5Xn3xjw4r
         tVZn9c1Bhx+SwymHvLZmYO43a/leOZ7K2AACO/aMGuYARTBsh+CgO0vP7KnRVrl9S12N
         jojO1lFGg6Eix0K9rD0awVpTsC9FhYfOH+3WwpB9p9YhZHoH5fPN7ltTnLkLejM5oiup
         0MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DzltcHCJUsFG0rea0HNjt3o3lCKgQChn4Xp5dylWdSg=;
        b=i255dQhgFtXGP/UZQMNKjNmV3MGVIisxxmp9rIMlkFSCC6gxrJaXwqQdSem7f2Po+0
         v4FqyXpI9HwjCG4Cs5rtSCSVfWnEhKZ+tBjuR8IfuOp7m1TTbzzGvJb11ROolUPXKi+8
         YykiPgRQqMvcb7kjFfxzVThx1LhG0I/rUi2yRGWYvMhfX0ymFcRtOrJEXuX1JGYMq67X
         rTFqrkmjm4nlt03tXZelntCKTF96VM1PSjMtzV5XUw6opWWk7kmHQ8izGyqFPcYuDlYi
         M3xzzy2ASjy/5tuHwMeSBJU5CAlfbiMfQRL0PIH549AdpLrK3gMkCQ2eajssdc5hm04s
         l2pg==
X-Gm-Message-State: AJcUuketJR7Njpbv842IIIYhEGTBUf/eCtMgHBVDrk5O2eoHrWVLaFaj
        Q1wH+6JBe1ARIRoXfZeBqUQ=
X-Google-Smtp-Source: ALg8bN7d0TqSFpbDMwxsvdh8pLz003fgNAHMC7DSw9TUGEJFgUTUX8UOvK8VrmZSU3N9zy6vXZKxfA==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr26437965wru.33.1548799110285;
        Tue, 29 Jan 2019 13:58:30 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id y8sm83362wmg.13.2019.01.29.13.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 13:58:29 -0800 (PST)
Date:   Tue, 29 Jan 2019 22:58:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129215827.GF13764@szeder.dev>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129155827.GC13764@szeder.dev>
 <20190129173409.GD13764@szeder.dev>
 <95d30af1-1940-b4db-99e8-2ccca5210bbd@gmail.com>
 <795f816d-d870-068a-5595-2fe617339a79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <795f816d-d870-068a-5595-2fe617339a79@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 03:49:58PM -0500, Derrick Stolee wrote:
> On 1/29/2019 1:10 PM, Derrick Stolee wrote:
> > On 1/29/2019 12:34 PM, SZEDER Gábor wrote:
> >> On Tue, Jan 29, 2019 at 04:58:27PM +0100, SZEDER Gábor wrote:
> >> And in the related email discussion [1]:
> >>
> >>   But even though the docs claim it [-j<N>] should be possible,
> >>   I've been getting "random" test failures when compiled with coverage
> >>   support, that went away with -j1.  So the tests still run with -j1, as
> >>   with the first version of the series.
> >>
> >> So it doesn't seem to be that bad after all, because it's not
> >> "completely breaks" but "random test failures".  Still far from ideal,
> >> but the original coverage patch is just about 3 weeks short of a
> >> decade old, so maybe things have improved since then, and it'd be
> >> worth a try to leave GIT_PROVE_OPTS as is and see what happens.
> > 
> > It would certainly be nice if the build time could be reduced through
> > parallel test runs. I've kicked off a build using GIT_PROVE_OPTS="-j12"
> > to see what happens.
> 
> I did get a failed test with this run:
> 
> t0025-crlf-renormalize.sh                 (Wstat: 256 Tests: 3 Failed: 1)
>   Failed test:  2
>   Non-zero exit status: 1
> 
> This was on the 'jch' branch, and an equivalent build with sequential
> execution did not have this failure. That's flaky enough for me to stick
> to sequential runs.

That failure is not coverage-related, but as it turned out 9e5da3d055
(add: use separate ADD_CACHE_RENORMALIZE flag, 2019-01-17) made t0025
rather flaky:

  https://public-inbox.org/git/20190129213533.GE13764@szeder.dev/

When reading those old commit messages and discussions in the
afternoon, I was wondering what "random test failures" actually meant,
since it was not stated explicitly that it was coverage-related.  For
all we know it could have been "general" test flakiness that happened
to manifest under the higher load of a parallel test run.

