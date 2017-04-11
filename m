Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AC520970
	for <e@80x24.org>; Tue, 11 Apr 2017 18:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbdDKSbb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 14:31:31 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35039 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbdDKSb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 14:31:29 -0400
Received: by mail-io0-f182.google.com with SMTP id r16so11729214ioi.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oYLV7bfw4v/0wTFM0uZ4aDUaimuhsCU3dT/QiO/fV/g=;
        b=YgAZ7vNds9rw02H6eMUJI3G8r/4kUEDIewUwOT2qOsXwqJsYPMJu4wbyB26UbcJRaK
         UiY779EhT7jJZqXYp8FeLU2bEkNzG8J5imYQqlOwDzh30rTdIMdqt28tdQU8jQwkf8dz
         J6hnM1ZhvayyvHh+7IUKKkCu/o3apbg6ORd1zZGVCJ1n1XowFfdhrlCbat/vuLfyM7Yo
         ChzlOPlCc7Ph/X21wbr81IVDLFZoLOu9kPB6rwtHHRQNPORiGk88eHm/E4pqXiJFrgBb
         4h+0+O0EHUqM2HxCZeMUJpfywJbBLhk88+SN24M3IYxO6Nzi/IG6EqLc9el9YqKNZ3e5
         uVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oYLV7bfw4v/0wTFM0uZ4aDUaimuhsCU3dT/QiO/fV/g=;
        b=prOurb00ZPQR01KZkJ5fJ6WMBXzFGHa4puQJ8PEjOMQ50fT5dNG22VtxyyskEhMcjJ
         wzsEeUOv0zTgtsF8b1BhhIfWXIv8SKpw6LkPEhv7lt3r6jL6W66dXgeT5cBLP/uLKREt
         ObguUNOB13l9wM/ih9kFZDu7WBfJNfycsARzfQOpNemiIQYpiob4P+UIIRRjL09cNOpl
         xeK0byh2cwuY98h6rm+6TokM5s6zetg20fwFWbQ+v19rAYbPqsqu3joYYd1LNKogBdjE
         AQ1DrgqiCZ5dUCUx0DqZow81CjOMsq2xgm5x0epjoy/zcR/9mgvLsU77KFGguZag+pgP
         bzLA==
X-Gm-Message-State: AN3rC/67e25vqLfgDV/zZJq/NZEyCd8p28K+7TQ3Bk6cXvqP0vry1IpclsI8co2EiO6T/iXbdDfRj1bxA3sTzQ==
X-Received: by 10.36.115.12 with SMTP id y12mr18664084itb.24.1491935488468;
 Tue, 11 Apr 2017 11:31:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 11:31:07 -0700 (PDT)
In-Reply-To: <20170411165127.GC36152@google.com>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-12-avarab@gmail.com>
 <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net> <CACBZZX5V96Vv5NAYpkQSBWpn-4rgHOatAnL51o4-4DADAF+pEg@mail.gmail.com>
 <20170411104828.skkujde3qrvn4jrt@sigill.intra.peff.net> <CACBZZX6A8tcXy-hCcQqqDsGNDtXWmZMdTY=RxeAOn8QFYDypyg@mail.gmail.com>
 <20170411125741.7b7hlmuucid37b3r@sigill.intra.peff.net> <20170411165127.GC36152@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 20:31:07 +0200
Message-ID: <CACBZZX6HLDmWSGiQ+cJ-p0Ak6SQHcmECaGqsfVz-Js4q7aSEwg@mail.gmail.com>
Subject: Re: [PATCH 11/12] grep: change the internal PCRE code & header names
 to be PCRE1
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 6:51 PM, Brandon Williams <bmwill@google.com> wrote=
:
> On 04/11, Jeff King wrote:
>> On Tue, Apr 11, 2017 at 01:02:56PM +0200, =C4=98var Arnfj=C3=B6r=C5=A1 B=
jarmason wrote:
>>
>> > >> Yes, this is a bug. I'll need to add a git_options along with
>> > >> submodule_options and pass -c grep.patternType=3D....
>> > >
>> > > Maybe that's an indication we should have --pcre1-regexp and
>> > > --pcre2-regexp, so we don't have to resort to config tweaking.
>> >
>> > I'd rather not. To reply to both your
>> > <20170411103018.dkq5gangx3vcxhp4@sigill.intra.peff.net> & this, one
>> > thing I was trying to do in this series (and I don't think I went far
>> > enough in "grep & rev-list doc: stop promising libpcre for
>> > --perl-regexp") was to stop promising some specific version of PCRE.
>>
>> We don't necessarily have to document them. This is just in the general
>> rule of "if there's config, there should be command-line to override
>> it". Because without that, you get this exact situation where you have
>> to bolt on "-c" options to another part of the command line, which gets
>> awkward.
>>
>> I'm also not sure it would be strictly correct, if the sub-program runs
>> other sub-programs. Providing "-c" affects all child processes, whereas
>> command-line options are propagated manually. So imagine you have a
>> process tree like:
>>
>>   grep
>>    \-grep
>>       \-textconv
>>
>> I.e., grep recurses to a submodule which then has to kick off a textconv
>> filter for one of the files. If you use "-c" to pass options to the
>> second grep, then those options will continue to have an effect inside
>> the textconv filter. Which _probably_ doesn't run git commands that
>> would care, but technically it could do anything.
>>
>> > I.e. as far as the user is concerned they just want perl-y regexes,
>> > but they most likely don't care about the 1% featureset of those
>> > regexes where the various implementations of "perl-y regex" actually
>> > differ, because those cases tend to be really obscure syntax.
>>
>> Yeah, that's what led me to the "why are we even worrying about run-time
>> switching" direction. I'd think a build-time switch would be enough for
>> people to test, and it makes all of this type of complexity go away.
>
> Yeah I agree with Jeff that we should probably avoid needing to pass a
> config option down in addition to a command line switch to do perl
> regex's.  I didn't take too hard of a look at how that would be done in
> the grep code, but it might be slightly more involved than just changing
> the enum name.
>
> From [12/12] it looks like the main purpose of this series is to use a
> more preferment version of PCRE, if all else is equal it doesn't really
> make much sense to have both versions to be select-able at runtime.  Is
> there any benefit of being able to do that, that I'm missing?

Not really no. I don't think any git user is ever going to be using
both pcre1 & pcre2 at runtime.

This grew more organically out of how I started to hack the code. Due
to how different the two APIs are it's much less messier to have a new
set of wrapper functions than to ifdef around v1 & v2. Once I had all
the code & config flags it was easy to shimmy it up so I could switch
between the two, and it was handy for performance testing.

But the guy developing it is hardly the main target audience for a
feature like this, but on the other hand it's easy to support...

I'm hacking up a v2 of this series. It includes some extra goodies
like bugfixes, v1 JIT support, and I'll try to tack a patch at the end
that removes this facility to switch between the two at runtime, and
we can see if that looks better than not having it.
