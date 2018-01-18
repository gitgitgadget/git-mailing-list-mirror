Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B191F404
	for <e@80x24.org>; Thu, 18 Jan 2018 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbeARLta (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 06:49:30 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:39135 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbeARLt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 06:49:29 -0500
Received: by mail-qt0-f178.google.com with SMTP id f4so8524794qtj.6
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ivzNImcO7FV6OPfILATXWj5AnXWDVS98RSDlZY/HvV4=;
        b=RfX87h4zgCIKxEqSPPkWS4dIGvdxu4eZDJKf4eIYGp1t8RR9UFNrIeZVdZJ94KfFjV
         t2+2H26SSAypU5OfF77u6DRVoHeUxXkjG6Q5cnAyi1bnxP4xqovYqa8IaZrxaziUcbI5
         74zpxDkOjx9BeN4A1bSEGX+zY80SpmEgEIPmveNVe5PPZhYMa2tE8/+3/CchjZpUwz3H
         2ptfmt2k2RkXr6scB4tdrUyMfKV7nfz2DGxZ2OPAPqxeoJGvjn1TklJZWCEkCQB5JhwV
         kxUPLciJg82ZW4oAlQNuPhrO9gQd1g1hbA8CeoK/fX8DqTUPTu62LR3stWJOiCbs+fPU
         ImmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivzNImcO7FV6OPfILATXWj5AnXWDVS98RSDlZY/HvV4=;
        b=sJ16TBt7whI0U+MZOlqw3cnEKl/6/ICTBdQrJ0d6w0eIqlhN0VierGYCSoQg+o16Gs
         EoxBiib175XLELqqFa/+e0PEAFsO0+0/Nmu4zaLp4SObg4JM11RfsyyBwvVYX8oh+P7v
         LUUaZQ4v+58F+pl6frbbdo+Kmql4TgQqo7RCL0g+EYZRJTGgaKnNSfqRfoQvnJGrdzGC
         /EOKsrawK8hEWjExIXiZR2hXWimqIXeUpPtvrWh/npR5/1YqEYquz/OFuOXLILjxLlGq
         MWelvI7RTsNqLqKv486ZgWWTjjx1sp+Tx1rD1sbNPTRx+B4XGnfcfll2HC+tzxWNatEb
         kmXA==
X-Gm-Message-State: AKwxyteopbcnNmNxnpB8suJ7BDaYiM9haAQKUq99Kss2oxr1vkrBZMoY
        94Gl+8h3kjaQcMqmaxsylcmpft32zmFjgkDhPkE=
X-Google-Smtp-Source: ACJfBovjWejF4yFhhMkDvKkmn+CpGr/Dxbz8qs+cU/9YcIh4bXI64ssy+kXUzUyqupasMICay1DmvSIABxfpselagVY=
X-Received: by 10.200.22.187 with SMTP id r56mr7090358qtj.190.1516276168776;
 Thu, 18 Jan 2018 03:49:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.146 with HTTP; Thu, 18 Jan 2018 03:49:28 -0800 (PST)
In-Reply-To: <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 18 Jan 2018 14:49:28 +0300
Message-ID: <CAL21BmneJ4rgCtf8t8LOK=gVv0MR+xam9jFBp7kp33rqEG7f6Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-18 9:20 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=
=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
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

I tried to make that part here:
https://github.com/telezhnaya/git/commit/19a148614f1d4db1f8e628eb4e6d7c819d=
2da875
I know that the code is disgusting and there is a memory leak :) I
just try to reuse ref-filter logic, I will cleanup everything later.
At first, I try to make it work.
The problem is that I have segfault, and if I use gdb, I get:

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()

I tried to google it, it's my first time when I get that strange
message, and unfortunately find nothing. So please explain me the
reason, why I can't find a place of segfault that way.
Thanks!

> And another thoughts here - we were thinking about creating format.h
> but decided not to move forward with it, and now we are suffering
> because of it. Can I create it right now or the history of commits
> would be too dirty because of it? Also, do you mean just renaming of
> ref-filter? I was thinking that I need to put formatting-related logic
> to another file and leave all other stuff in ref-filter.

By the way, I can create format.h in absolutely another branch, we
could merge it, and I will deal with all merge conflicts with my
current work. It sounds tediously, but actually it's not such a big
problem, I can do that.
But I still need to fully understand, what do you find more proper -
just rename ref-filter, or create new file and move formatting-related
logic.

>
> Anyway, your suggested steps looks good, and I am planning to
> implement them later. Let's discuss, what behavior we are waiting for
> when atom seems useless for the command. Die or ignore? And, which
> atoms are useless (as I understand, "rest" and "deltabase" from
> cat-file are useless for all ref-filter users, so the question is
> about - am I right in it, and about ref-filter atoms for cat-file).
>
> I have never written any tests and docs for Git, I will try to explore
> by myself how to do that, but if you have any special links/materials
> about it - please send them to me :)
>
> Olga
