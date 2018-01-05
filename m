Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A7B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeAEUyh (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:54:37 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:47097 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbeAEUyg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:54:36 -0500
Received: by mail-ua0-f180.google.com with SMTP id j4so1049501ual.13
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+CUmGZJd7szpR8hpPueUZ+EbwIw1vdRG4+YEoFzDjdU=;
        b=zCcxA6WXH6vcqf1cHL2WH2xHOshWI8TvEBh42s2Vpk7/wZnDSBve4dgtEvVi4DV3EF
         3RVq2OxNWSOugWRy4S2Gii5ZsA2fB2PTCimeFtLzYI/8TGjZERhnj7VYZpmLqPsWAzkx
         JCKK7Xaj/M2+B7gFtFTF9DULB+rjsbAJzsdmSoPyF0H93bw9yRtKSG/66AzfzYorYd4x
         XbnvI8fP3QYeRE5CCLZGjCJS2AtD1t0qw5WclFKlygCHya+C+X21nAqhvMM42DB1BM4R
         XQ3nvQ4/9lvuin7SAtwCxYCyDRN7F3WTlBjMLHstO4eDjweYedoTlhXunAMkXIw9tIVi
         mkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+CUmGZJd7szpR8hpPueUZ+EbwIw1vdRG4+YEoFzDjdU=;
        b=TfH8pZVlEBWcBmheSRC4/f6O9lK+RovbnHE4qh4LgPRr2yUQdpGVxLj80oXF5cwU9H
         tpO9jAZ2bNDfs3iJXOoYWElwIaOo5nWbc2b3utLle9XNRYdRWxpWr2KpE3fbF3vzDdZL
         nyP0B7TvnYATM8H/CpVcKvgTBaVnUnxeP3JwzRCciLEAHVlY/sQI+d/39YdacTYQ74bi
         u8uauWbQhK7ERj7tTqFOZ0ukkaizVfPKRW8msIxOLLjipt+IPQxAa3ZxdzHGXiZCQCno
         FsiMbMVh0PYSnPqbISvgXL11wmpJlwyR2FLZQ+XReSOgtd9d8LmcVnbvHXkEjYd5mU6d
         1Ktw==
X-Gm-Message-State: AKwxyted/1wW7xTMY7U0nD14oRXkxN3hrL3RLHdLzfGACwb35eqQ188p
        Xy4reI0ga9dNIkw8mP/e//e1BjDv/S04tZma7GR3CQ==
X-Google-Smtp-Source: ACJfBovV1GGpkJsho/tKYEKnIWftYcrKA9jRp42003Ejpaouwk7mMKm/Y2LuxmS9Ckas21HGxHvGenr5B6jMbK+yIBs=
X-Received: by 10.159.61.106 with SMTP id m42mr4190675uai.38.1515185674986;
 Fri, 05 Jan 2018 12:54:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.77.157 with HTTP; Fri, 5 Jan 2018 12:54:34 -0800 (PST)
In-Reply-To: <CAHd499A_ANzFA8HSQLJWakzzWanbmVGnur=um=kquYHu0aCBcQ@mail.gmail.com>
References: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
 <CAGyf7-FHyO9pkEFFguea+B+VMTodF=mg8wJNedvjYdL7e7ORqQ@mail.gmail.com>
 <1515183976.21764.114.camel@mad-scientist.net> <CAHd499A_ANzFA8HSQLJWakzzWanbmVGnur=um=kquYHu0aCBcQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 5 Jan 2018 12:54:34 -0800
Message-ID: <CAGyf7-E-7KUCAM8SeG-2powp2XN+H=16VG-6XBmj1wUT9tjVcw@mail.gmail.com>
Subject: Re: Can't squash merge with merge.ff set to false
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     paul@mad-scientist.net, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 12:35 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Fri, Jan 5, 2018 at 2:26 PM, Paul Smith <paul@mad-scientist.net> wrote:
>> On Fri, 2018-01-05 at 12:12 -0800, Bryan Turner wrote:
>>> On Fri, Jan 5, 2018 at 11:59 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>>
>>> As for why the two aren't allowed together, my assumption would be
>>> because if you're only squashing a single commit "--squash" and that
>>> commit is fast-forward from the target, a new commit is not created
>>> and instead the target branch is fast-forwarded. With "--no-ff", it's
>>> questionable what "--squash" should do in that case. Fast-forward
>>> anyway? Rewrite the commit simply to get new committer details and
>>> SHA-1?
>>
>> If it only failed when you were squash-merging a single commit that was
>> also fast-forwardable, I guess that would be one thing.  But even if I
>> have multiple commits and I want to squash-merge them, which clearly is
>> a separate operation giving different results, I get this error.

I think there's a reasonable argument that having the failure be
consistent is easier to reason about, and therefore provides a
"better" user experience (to some definition of "better" which all
people may not share in common).

If the failure was delayed until "git merge --squash" decided it
wanted to fast-forward, the failure might seem more arbitrary.

>>
>> I don't think Git should try to be clever here (if that's what it's
>> doing--I always assumed it was just a missing configuration case in the
>> error check).  If I asked for a squash-merge then Git should give me a
>> squash merge.
>>
>> So in answer to your question, --squash should give me a squash merge
>> and the setting of --ff / --no-ff should be completely ignored, as it's
>> irrelevant.
>>
>> My $0.02.
>
> Seems like --ff works, but is also misleading since in my case (more
> than one commit) I'm not doing a ff merge and there's no possibility
> of it.

"--ff" doesn't say "git merge" _must_ fast-forward ("--ff-only"); it
says that it _can_. At a general level with "--squash", that seems to
be exactly correct. A "--squash" merge can create a new commit, or it
can fast-forward an existing commit if the situation allows. Based on
that, passing "--ff" doesn't seem misleading to me.

> I think your idea of the 2 being distinctly separate makes
> sense. Basically, --squash takes precedence and if the mechanism to
> implement squash in certain scenarios (such as single commit) is
> fast-forward merge, then that decision is made for the user and is no
> longer something they can control.

The two _aren't_ distinctly separate, though. "git merge --squash
--ff-only" has very different semantics to "git merge --squash --ff",
in that it will only create a new squashed commit (or fast-forward a
single commit) if the incoming commit(s) are fast-forward from the
target. So there _is_ a setting for the fast-forward mode (given
"--ff", "--ff-only", and "--no-ff" are a tri-state switch, and
therefore comprise a single setting) that does impact squashing.
