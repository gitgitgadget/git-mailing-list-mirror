Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B627203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbcLMTkP (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:40:15 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36760 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbcLMTkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:40:09 -0500
Received: by mail-qk0-f181.google.com with SMTP id n21so127568887qka.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bc1PUHoNolSHBS0/Uc3a/vI5tjMk6ZKNttvYlJOEh1w=;
        b=CNamO8S2Bi4nma9sEuhgIxeZW84Inu5l8dUubVh6ZhAWPdFkepjlu1VDQAFYTh7pGc
         s2TRxaWNdjw3MdIPHia5zsOIBw5NYEYXuLa7g1OU06d4qxK2izMz4X/c4/Mr+o1z6RsA
         NtJLHVZSPTT09u8PRiyrt6IpgF9h9QCzpbX8MayRMH+I9MpPkcAneug+gnCPxQLjGTUw
         +ppwQd7jI9E2mHM4DucFqYMrU9HQWNfZtJznFn7+UIyi4j39Dz6gifMIMnF0dpggDdTN
         2LYHJrasjRjIklrgGp/Qpq1Y8EoFJT9nE/xHheFETlFO2+4QlVeibcLj9cjCSYIfemZ8
         RkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bc1PUHoNolSHBS0/Uc3a/vI5tjMk6ZKNttvYlJOEh1w=;
        b=S5lsOgV5mFI+kI+3eohjtN3yeZ5lM1zuQSa7bkPXG4XP52AZOHH6mLFUlhjBBHEYK4
         jJHFTp5BA9meb3M9jsrTdxjs0m9sfAvv1x+tsKr1ICt9XZMByvcbcHNocpLWKWvTKLT7
         E+rSca1n882bAxJajUnF6JzcFA094ACPHdi3Hr0TUL+/iE7k/RG6luK/Xdk/rjMvWEk9
         37mN0Zfjc3a1F9MeEAE/lFdlCEYFcK6g9PzJJ+LY4gdNq341+jxYAZdltLVTUzxXp5lo
         awdCgzwoIXbarXK/8MXzadOyPXs4kAUeEAepqgO2aYnR9piUKmg68qovIy0pOskqbk4W
         5jYA==
X-Gm-Message-State: AKaTC018bBEUrXyXWDWvwlHQpCS2QdBBAm+EQGMmFOTpyYMGXWDgy3Dj01P7u9jpbj9VOTgqdaYMWvzbv2i/f9+6
X-Received: by 10.55.20.164 with SMTP id 36mr33353462qku.86.1481657938167;
 Tue, 13 Dec 2016 11:38:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 11:38:57 -0800 (PST)
In-Reply-To: <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
References: <20161213014055.14268-1-sbeller@google.com> <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
 <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
 <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com> <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 11:38:57 -0800
Message-ID: <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 11:13 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Dec 13, 2016 at 11:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> I do not think there is no dispute about what embedding means.
>>>
>>> double negative: You think we have a slight dispute here.
>>
>> Sorry, I do not think there is any dispute on that.
>>
>>>>  A
>>>> submodule whose .git is inside its working tree has its repository
>>>> embedded.
>>>>
>>>> What we had trouble settling on was what to call the operation to
>>>> undo the embedding, unentangling its repository out of the working
>>>> tree.  I'd still vote for unembed if you want a name to be nominated.
>>>
>>> So I can redo the series with two commands "git submodule [un]embed".
>>>
>>> For me "unembed" == "absorb", such that we could also go with
>>> absorb into superproject <-> embed into worktree
>>
>> With us agreeing that "embed" is about something is _IN_ submodule
>> working tree, unembed would naturally be something becomes OUTSIDE
>> the same thing (i.e. "submodule working tree").

I do not agree, yet.
So I thought about this for a while.

The standard in Git is to have the .git directory inside the working tree,
which is why you are convinced that embedded means the .git is in the
working tree, because you approach this discussion as the Git maintainer,
spending only little time on submodule related stuff.

The desired standard for submodules is to have the git dir inside the
superprojects git dir (since  501770e, Aug 2011, Move git-dir for
submodules), which is why I think an "embedded submodule git dir"
is inside the superproject already.

I think both views are legit, and we would want to choose the one that
users find most intuitive (and I think there will be users that find either
viewpoint intuitive).

So when you have typed "git submodule ", I wonder if a user would
assume a submodule-centric mindset of how submodules ought to
work or if they still look at a submodule as its own git repo
that just happens to be embedded into the superproject.

I guess the latter is the case, so embedding is actually inside the working
tree and un-embedding is the relocation to the superproject.
