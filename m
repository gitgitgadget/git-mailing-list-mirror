Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CE81F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeASRPB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:15:01 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:45581 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755993AbeASRO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:14:57 -0500
Received: by mail-io0-f172.google.com with SMTP id p188so2855928ioe.12
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=08G59x393aiRjpN2Q5F6d7d9Oa5KVX853FUEweCJu4U=;
        b=K7tKY5FERUBZ4KfhPpiTmnnBFtfnUzqy5AQVsFyKbZYWUtDpY9Xj4bBk6/q/rrTRPM
         RhnKssZMawwZ06vHvrBBfZkeu0+PzioOWeN4OirZFzg24q6C3mfVwlFbbS8TFQTVJ066
         GYxTsmAUeWIop9m+ja1638/dHGdx/Hh/wxchV2iXxmvkmGugf1VsM0x2YZDcvvxAxzJX
         qGJd0Z0Eanxv84ln6u7eYTmiy+rpyvaiRTnkxI01dX/2hEo/THK1aBKEVo/N0wcmYpY8
         CCMpcBGZbI0F0vQQqULyuuUAK1y59vtEIDXY31LkhlvBOSFlo8N4bRGCV3o7TODP9cOY
         f37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=08G59x393aiRjpN2Q5F6d7d9Oa5KVX853FUEweCJu4U=;
        b=q6BCrN6iaBKoHqUvzTr0tOc6jMI2Y7IPVKCMP2q3yK+cDsIL9lor/1Pvmb1Febxw18
         wZiB03UH5bJMcvUoynTtGVNSmsOvMYVWNRt26NDhp+ux16vocmVh4gGL+CgXNiDsGwgf
         HLPvXyeqoNNTw9mCghpT/G6sA2MQ4hpcedjdcWrfQ0LCDds1vrzIR6siWH8eTFp8kJ5x
         v7301EEKR5InenJ1Gr+nTLEoFJMsqvzOXnvXyal684fsJe6foHo1EO1+Y3EgoSr94hVr
         3+mmV70RJfqMTXOpFzBVFVgVMkkQgfal8Ks2BeQeQOcDNwZZqHla9hjgXWMdxQkAPbjA
         BPPw==
X-Gm-Message-State: AKwxyteadAag5oIfBSXjEb/CU+mDejJR9aBFCJkm9OwZ6IrIwm2cYDEW
        h0AJ0sWS9VgxqdOto0fuhV6MKDxVMuFMGH75hmcgfYMv
X-Google-Smtp-Source: ACJfBovzY4Mln0JabHLy4Alt0Ps0oMRE7HLOvGS7e4Yz9PF6mwBONVjvtYCkprJJ05bUUY18PLTLUCVIt+RPj6vBhcA=
X-Received: by 10.107.3.209 with SMTP id e78mr31908408ioi.96.1516382096696;
 Fri, 19 Jan 2018 09:14:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.201.204 with HTTP; Fri, 19 Jan 2018 09:14:56 -0800 (PST)
In-Reply-To: <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Jan 2018 18:14:56 +0100
Message-ID: <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:20 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> 2018-01-18 1:39 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>> On Wed, Jan 17, 2018 at 10:43 PM, Jeff King <peff@peff.net> wrote:
>>> On Tue, Jan 16, 2018 at 09:55:22AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=
=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>>>
>>>> > IOW, the progression I'd expect in a series like this is:
>>>> >
>>>> >   1. Teach ref-filter.c to support everything that cat-file can do.
>>>> >
>>>> >   2. Convert cat-file to use ref-filter.c.
>>>>
>>>> I agree, I even made this and it's working fine:
>>>> https://github.com/git/git/pull/450/commits/1b74f1047f07434dccb207534d=
1ad45a143e3f2b
>>
>> (Nit: it looks like the above link does not work any more, but it
>> seems that you are talking about the last patch on the catfile
>> branch.)
>>
>>>> But I decided not to add that to patch because I expand the
>>>> functionality of several commands (not only cat-file and
>>>> for-each-ref), and I need to support all new functionality in a proper
>>>> way, make these error messages, test everything and - the hardest one
>>>> - support many new commands for cat-file. As I understand, it is not
>>>> possible unless we finally move to ref-filter and print results also
>>>> there. Oh, and I also need to rewrite docs in that case. And I decided
>>>> to apply this in another patch. But, please, say your opinion, maybe
>>>> we could do that here in some way.
>>>
>>> Yeah, I agree that it will cause changes to other users of ref-filter,
>>> and you'd need to deal with documentation and tests there. But I think
>>> we're going to have to do those things eventually (since supporting
>>> those extra fields everywhere is part of the point of the project). And
>>> by doing them now, I think it can make the transition for cat-file a lo=
t
>>> simpler, because we never have to puzzle over this intermediate state
>>> where only some of the atoms are valid for cat-file.
>>
>> I agree that you will have to deal with documentation and tests at one
>> point and that it could be a good idea to do that now.
>>
>> I wonder if it is possible to add atoms one by one into ref-filter and
>> to add tests and documentation at the same time, instead of merging
>> cat-file atoms with ref-filter atoms in one big step.
>>
>> When all the cat-file atoms have been added to ref-filter's
>> valid_atom, maybe you could add ref-filter's atoms to cat-file's
>> valid_cat_file_atom one by one and add tests and documentation at the
>> same time.
>>
>> And then when ref-filter's valid_atom and cat-file's
>> valid_cat_file_atom are identical you can remove cat-file's
>> valid_cat_file_atom and maybe after that rename "ref-filter" to
>> "format".
>
> I think it's important to finish migrating process at first. I mean,
> now we are preparing and collecting everything in ref-filter, but we
> make resulting string and print still in cat-file. And I am not sure,
> but maybe it will not be possible to start using new atoms in cat-file
> while some part of logic still differs.

Ok, you can finish the migration process then.

> And another thoughts here - we were thinking about creating format.h
> but decided not to move forward with it, and now we are suffering
> because of it. Can I create it right now or the history of commits
> would be too dirty because of it?

It would also make it difficult to refactor your patch series if there
is a big move or renaming in the middle.

> Also, do you mean just renaming of
> ref-filter? I was thinking that I need to put formatting-related logic
> to another file and leave all other stuff in ref-filter.

Yeah, you can do both a move and a renaming.

> Anyway, your suggested steps looks good, and I am planning to
> implement them later.

Ok.

> Let's discuss, what behavior we are waiting for
> when atom seems useless for the command. Die or ignore?

We could alternatively just emit a warning, but it looks like there
are a lot of die() calls already in ref-filter.c, so I would suggest
die().

> And, which
> atoms are useless (as I understand, "rest" and "deltabase" from
> cat-file are useless for all ref-filter users, so the question is
> about - am I right in it, and about ref-filter atoms for cat-file).

For now and I think until the migration process is finished, you could
just die() in case of any atom not already supported by the command.

> I have never written any tests and docs for Git, I will try to explore
> by myself how to do that, but if you have any special links/materials
> about it - please send them to me :)

I think that looking at the existing documentation and tests is
probably the best way to learn about it.
