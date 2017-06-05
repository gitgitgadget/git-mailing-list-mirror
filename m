Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97A11F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 20:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdFEUhm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:37:42 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37951 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 16:37:40 -0400
Received: by mail-it0-f45.google.com with SMTP id r63so90008224itc.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iVz1G4Fd204CNveCRDcnXeHI8A48XTnI3MSO0OXxN68=;
        b=p8cGQTbH5119aB7zqFSOIl4c5O064sqVPG/zBRlBbXp8wMoWQuyDmRg51aY/sZ51TT
         lUQ1REUkb2i/oCI48/yYSfZBXQhR9eTQqacxbXQlTGXob7/F4kpI4PxecA+nHn5itc2w
         Pq5henDpeV/fg8OYR1xwT6CHoXRL4tdSQvfskOmZ4AKaGcXfWm77CCABtOXxyJkU9MuB
         CWdNr8yOkULY89lQ36vimc3vqHRsjNarbOcpd6Rhe+WgbQfXyUG97cj3E0M3Io0nVnfc
         +Z423B/dVqK6eGawL1m+NB58Ii7gtNYXycnZmQbCuC3J/uNZd9rDNfM0ykPHOwXszY8T
         dSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iVz1G4Fd204CNveCRDcnXeHI8A48XTnI3MSO0OXxN68=;
        b=QIQQpDa2aW8FnEEzALcSTIcEqDW97N2aylPzBoEl3ieR7v7az64GMxOxwMUYWUSP6g
         nYGycHrMH9Qaa9mhbM7uy37veAPJGE42hTtW1Nh9ogfg4cB+UKJ20Sr9IkszoVtIf8td
         QpS+dMTz/r3l6N9+SJZ1l0qnt7gCNa9etUyQPFReCa9p6vq+bjvluRfxcds3Y8s3+8GX
         jXMb3ApvxkZK3ZhO8BuOe0Gs6fQprA65qSPvg8C8faZwsQQx2uuHy80czEqI3Amk43ZO
         6fSesWV55kkDI4KSYHkkYHt7VzmY1nYfhadZxrgUdf9GKULJANoBhEqikUXqYBnPm1BQ
         H1nQ==
X-Gm-Message-State: AODbwcDuhFnsYYeQyzhDUlKZW2bWgEwblkb9p2+Q0NiKmbq14jRWtZva
        ZYwCMVsMXebEyOcnqmiF/XA1A23gUg==
X-Received: by 10.107.178.130 with SMTP id b124mr8467024iof.50.1496695059621;
 Mon, 05 Jun 2017 13:37:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 5 Jun 2017 13:37:18 -0700 (PDT)
In-Reply-To: <CAGZ79kZn+bjtqBYTWuYqfsKdA=eWreNHQPCLVDGiS_8977VcTA@mail.gmail.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
 <1D06FFF7-C36D-4072-8B37-4C9DC45E4442@gmail.com> <CACBZZX5FP_jxXaT+NW8g2JqH89iYajHPjHhxCj=_vWnkxZ=rYQ@mail.gmail.com>
 <CAGZ79kZn+bjtqBYTWuYqfsKdA=eWreNHQPCLVDGiS_8977VcTA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 5 Jun 2017 22:37:18 +0200
Message-ID: <CACBZZX6CQsJwJDXA_RtQ5YRzcGJnGrO2NoCu7Ys5FWO4dzdhVQ@mail.gmail.com>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 9:03 PM, Stefan Beller <sbeller@google.com> wrote:
>> That's never going to be a problem on a less beefy machine with
>> --state=slow,save, since the 30s test is going to be long over by the
>> time the rest of the tests run.
>>
>> Cutting down on these long tail tests allows me to e.g. replace this:
>>
>>     git rebase -i --exec '(make -j56 all && cd t && prove -j56 <some
>> limited glob>)'
>>
>> With a glob that runs the entire test suite, with the rebase only
>> taking marginally longer in most cases while getting much better test
>> coverage than I'd otherwise bother with.
>
> I wonder if this functionality is rather best put into prove?

It would be nice to have a general facility to abort & kill tests
based on some criteria as they're run by Test::Harness, but making
that work reliably with all the edge cases prove needs to deal with
(tens/hundreds of thousands of test suites) is a much bigger project
than this.

> Also prove doesn't know which tests are "interesting",
> e.g. if you were working on interactive rebase, then you really
> want the longest test to be run in full?

If I were hacking rebase or another feature which has such a long
running test then the long running test without the timeout would be
part of my "regular" testing.

The point of this feature is that most tests aren't like that, then
you can use this and do the full test suite every time.

> And this "judge by time, not by interest" doesn't bode well with
> me.

They're not mutually exclusive.

> I have a non-beefy machine such that this particular problem
> doesn't apply to me, but instead the whole test suite takes just
> long to run.
>
> For that I reduce testing intelligently, i.e. I know where I am
> working on, so I run only some given tests (in case of
> submodules I'd go with "prove t74*") which would also fix
> your issue IIUC?

No, because even when you're working on e.g. "grep" something you're
doing occasionally breaks in some completely unrelated test because it
happens to cover an aspect of grep which is not part of the main
tests.

I ran into this recently while hacking the wildmatch() implementation.
There's dozens of tests all over the test suite that'll break in
subtle ways if wildmatch() breaks, often in cases where the main
wildmatch test is still passing.

Running the whole thing, even in a limited timeout fashion, has a much
higher chance of catching whatever I've screwed up earlier, before I
do an occasional full test suite run. Running the tests in 10 or 15s
is a much shorter time to wait for during a edit/compile/test cycle.
