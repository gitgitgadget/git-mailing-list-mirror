Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF03F1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeASRWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:22:18 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:44536 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756189AbeASRWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:22:13 -0500
Received: by mail-qt0-f178.google.com with SMTP id l20so4223778qtj.11
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8qlm8IONMUhMpMX5psf+ENmkifBDfrgTEm0AqIH9ihs=;
        b=XcvUuwOyhtt4/PV6eaNE6qOXjAkXg87OPVwqFGaQDMOHM1OVpln06t2aEodFUdqtXq
         MMbBIHhnde6YMGDTf2JKud/OBdkmlEYabFe9G712QMXFGJmNNGoaDtSfrCFMpqqNie3F
         TLGiPZ8D5WUqi8d2MOJngIM072PPEyxm7QicAAXT94e9LTPLFJ0JdqZFEsyntpyF5P0p
         tGIZGXUcp8jmyAQ3cMX95xpirqXsHVw8OWnrJRu53VVqWSlATRXYtdvFzGRuYubXKlvU
         52wnb4/O6e0I9MrYlmjyKSEyKDmcDgahQ0YxYJbD7HP6wimlD0OsN2rW1Qf05abE8d5j
         LwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qlm8IONMUhMpMX5psf+ENmkifBDfrgTEm0AqIH9ihs=;
        b=qA4CI7kMyoyJsf/EXAbZFHAjaBPoSHylorIoN6B8d7Kq9aWUFDfM190EK56STCCq7L
         ViehDLB54TW/r4rqV7gpcZL+Wy5yAwXFg3mGh/qBqFDQnq6cjedVxAaBG9/1ODMRsZFf
         /6QWHYHWhgPmz2IK6sQOJj6KkaGFEerGqYB+VlpJXJ3/TREG25sRECnNojwEe3rHi/99
         zMOhUpi2fjwuEUlHaloALNydgV3r/yOHFslDV6bMnJDXg+z8jY/8ovGRGcqkuweRcSMq
         lo6zENWJNQvup4xrQ4HHJJaQKQry22p2lQ68TgDwhIKJYR38eSJ60kZlxWH7BEvoqyOF
         PSeg==
X-Gm-Message-State: AKwxytfJvbj1HTyn+bDz4HmypdqrTfGORYNdF50hnyL/4ouZc4715LmH
        oj06dGAT1WifDokgZOnP5DoQxIlrdubu4dV+PUo=
X-Google-Smtp-Source: ACJfBosTy8tp2v2A9HVdF7CkBSY6uWblnhhu0a7VMFDjsobNNCUzpmI8M/jn4nLM3f2eVrHlW2ZuqXczuL6CYDGTIvY=
X-Received: by 10.200.64.90 with SMTP id j26mr53548113qtl.29.1516382532656;
 Fri, 19 Jan 2018 09:22:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Fri, 19 Jan 2018 09:22:11 -0800 (PST)
In-Reply-To: <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com> <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 19 Jan 2018 20:22:11 +0300
Message-ID: <CAL21Bmn1yk_Cw11umpYf7X96JfmguZO48d8QHnx8tXwqT09aiw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-19 20:14 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> On Thu, Jan 18, 2018 at 7:20 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> 2018-01-18 1:39 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>>> On Wed, Jan 17, 2018 at 10:43 PM, Jeff King <peff@peff.net> wrote:
>>>> On Tue, Jan 16, 2018 at 09:55:22AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=
=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>>>>
>>>>> > IOW, the progression I'd expect in a series like this is:
>>>>> >
>>>>> >   1. Teach ref-filter.c to support everything that cat-file can do.
>>>>> >
>>>>> >   2. Convert cat-file to use ref-filter.c.
>>>>>
>>>>> I agree, I even made this and it's working fine:
>>>>> https://github.com/git/git/pull/450/commits/1b74f1047f07434dccb207534=
d1ad45a143e3f2b
>>>
>>> (Nit: it looks like the above link does not work any more, but it
>>> seems that you are talking about the last patch on the catfile
>>> branch.)
>>>
>>>>> But I decided not to add that to patch because I expand the
>>>>> functionality of several commands (not only cat-file and
>>>>> for-each-ref), and I need to support all new functionality in a prope=
r
>>>>> way, make these error messages, test everything and - the hardest one
>>>>> - support many new commands for cat-file. As I understand, it is not
>>>>> possible unless we finally move to ref-filter and print results also
>>>>> there. Oh, and I also need to rewrite docs in that case. And I decide=
d
>>>>> to apply this in another patch. But, please, say your opinion, maybe
>>>>> we could do that here in some way.
>>>>
>>>> Yeah, I agree that it will cause changes to other users of ref-filter,
>>>> and you'd need to deal with documentation and tests there. But I think
>>>> we're going to have to do those things eventually (since supporting
>>>> those extra fields everywhere is part of the point of the project). An=
d
>>>> by doing them now, I think it can make the transition for cat-file a l=
ot
>>>> simpler, because we never have to puzzle over this intermediate state
>>>> where only some of the atoms are valid for cat-file.
>>>
>>> I agree that you will have to deal with documentation and tests at one
>>> point and that it could be a good idea to do that now.
>>>
>>> I wonder if it is possible to add atoms one by one into ref-filter and
>>> to add tests and documentation at the same time, instead of merging
>>> cat-file atoms with ref-filter atoms in one big step.
>>>
>>> When all the cat-file atoms have been added to ref-filter's
>>> valid_atom, maybe you could add ref-filter's atoms to cat-file's
>>> valid_cat_file_atom one by one and add tests and documentation at the
>>> same time.
>>>
>>> And then when ref-filter's valid_atom and cat-file's
>>> valid_cat_file_atom are identical you can remove cat-file's
>>> valid_cat_file_atom and maybe after that rename "ref-filter" to
>>> "format".
>>
>> I think it's important to finish migrating process at first. I mean,
>> now we are preparing and collecting everything in ref-filter, but we
>> make resulting string and print still in cat-file. And I am not sure,
>> but maybe it will not be possible to start using new atoms in cat-file
>> while some part of logic still differs.
>
> Ok, you can finish the migration process then.
>
>> And another thoughts here - we were thinking about creating format.h
>> but decided not to move forward with it, and now we are suffering
>> because of it. Can I create it right now or the history of commits
>> would be too dirty because of it?
>
> It would also make it difficult to refactor your patch series if there
> is a big move or renaming in the middle.
>
>> Also, do you mean just renaming of
>> ref-filter? I was thinking that I need to put formatting-related logic
>> to another file and leave all other stuff in ref-filter.
>
> Yeah, you can do both a move and a renaming.

Thanks for a response! That thought is not clear enough for me. Do you
want me to split ref-filter into 2 files (one is for formatting only
called format and other one is for anything else still called
ref-filter) - here is a second question by the way, do I need to
create only format.h (and leave all realizations in ref-filter.c), or
I also need to create format.c. Or, just to rename ref-filter into
format and that's all.

>
>> Anyway, your suggested steps looks good, and I am planning to
>> implement them later.
>
> Ok.
>
>> Let's discuss, what behavior we are waiting for
>> when atom seems useless for the command. Die or ignore?
>
> We could alternatively just emit a warning, but it looks like there
> are a lot of die() calls already in ref-filter.c, so I would suggest
> die().
>
>> And, which
>> atoms are useless (as I understand, "rest" and "deltabase" from
>> cat-file are useless for all ref-filter users, so the question is
>> about - am I right in it, and about ref-filter atoms for cat-file).
>
> For now and I think until the migration process is finished, you could
> just die() in case of any atom not already supported by the command.
>
>> I have never written any tests and docs for Git, I will try to explore
>> by myself how to do that, but if you have any special links/materials
>> about it - please send them to me :)
>
> I think that looking at the existing documentation and tests is
> probably the best way to learn about it.
