Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096E21F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeFDRVH (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:21:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:47004 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeFDRVG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:21:06 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so9459509ywc.13
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=L4TbvYxOtydW2vz3wxTYPSGn3NAILYAO3nqfG75oS/Y=;
        b=bYz6FZhiRdg5uy91PkNpCTNelY/iDS145FEdSRoFM+dxPQneylHS4P+XQB1oKXng1n
         f58XNzy02v49Qs9d5Rm9tsu8/7WPJf4bDvFBYPpsSVoE9FHJ1M9GzxgtUZvumhdFrYhs
         ryo2/46H4nM8xjgO11t7fDIPjxSuQNLTD001Vl5XCVdJwEK2ULug6Fr0mt/reyt8AA4Q
         24Vcb5+H+h3Q7jAza+Uhc8goo3ymWz9uwVd+ZyOK33h8y+xnG9LTbkB72uRkaAU3msJK
         MIEVU0aaYwZ6KRm1GUzQ8pbrKDnIlkNiEMI5FCzCg/H5I6Htz6ICvnc3D1LGXMdviYw2
         Vtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=L4TbvYxOtydW2vz3wxTYPSGn3NAILYAO3nqfG75oS/Y=;
        b=FJ9PGI1cb3zhHSMjR2N7klAuNAW+bvl4SHSoZMiwoO5q3oTKxAYkC88Lo3dUUIcFQS
         0o4mcxaeG7hxsVXZxXdulHc/oYnBzuWrhNrzlyeg2rXHhMkeF7jZtH03BbZdO4Kvb7IC
         DwrVkHDngJeO47f1vuYH6yl4qFOk77ocA8Nbh38NWL7oZ6HjSAjgEKsdNvvhxkUCwSev
         IODX4Lr0v3W5VT5Cul61gZ7JLObuVJt5CMPu+1S1is1/cjHp4Yvd9gY+4cGfrmB0meYN
         jxdYEKNPSVUBi5/ttOvg+3vF3fnpHqdftlrnOFnSWc6RrMOHeUki9hDb8tO4tGJqSLBb
         kMxQ==
X-Gm-Message-State: ALKqPwfu4DU+Ul6DSJcu5tjvkY6Cu4vPdcsp4SQMsibEGiCWAM6bqWy4
        CYYY1UmbqGUtwqWNW688r4MnK7CExGJ0Ods6FlM=
X-Google-Smtp-Source: ADUXVKIXEUNgeqgAbC28kDMb/LHPlEcMgfJisxgnXOvcrzX0Tls036p3Lc6k61OhX4FPJMOH2ETyVVp5tOBCS9/Y5XM=
X-Received: by 2002:a81:8203:: with SMTP id s3-v6mr11483694ywf.131.1528132865660;
 Mon, 04 Jun 2018 10:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 10:21:04 -0700 (PDT)
In-Reply-To: <36f2d9e0-ba79-64d3-ffb5-d0772cafa153@talktalk.net>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <20180601174644.13055-1-phillip.wood@talktalk.net> <CAPig+cSSj2ETXfk8FYUc+=tE6bfoRuqF5Ld4kOgE4+DDpfL+BA@mail.gmail.com>
 <36f2d9e0-ba79-64d3-ffb5-d0772cafa153@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Jun 2018 13:21:04 -0400
X-Google-Sender-Auth: EvI8oQO4fmjxq2XmCbV255dz-QM
Message-ID: <CAPig+cSc49B4Mn7m9XOp+QF3qcT06ncGGXJpssFJMNjCQ8e7Mw@mail.gmail.com>
Subject: Re: [PATCH] add -p: fix counting empty context lines in edited patches
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Jeff Felchner <jfelchner1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 6:08 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 01/06/18 21:03, Eric Sunshine wrote:
>> On Fri, Jun 1, 2018 at 1:46 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>>> +               } elsif ($mode eq ' ' or $_ eq "\n") {
>>
>> Based upon a very cursory read of parts of git-add-interactive.perl,
>> do I understand correctly that we don't have to worry about $_ ever
>> being "\r\n" on Windows?
>
> Good question, I think the short answer no. If my understanding of the
> newline section of perlport [1] is correct then on Windows "\n" eq
> "\012" and the io layer replaces "\015\012" with "\n" when reading in
> 'text' mode (which I think is the default if you don't specify one when
> opening the file/process or with binmode()).

That was my interpretation, as well (though I didn't audit the code closely).

> As "\n" is only one
> character it would perhaps be better to test '$mode' rather than '$_'
> above - what do you think.

That could be clearer. As a reviewer, I had to spend extra brain
cycles wondering why $mode was used everywhere else but $_ in just
this one place. (Not that it was difficult to figure out.)

>>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>>> @@ -175,6 +175,49 @@ test_expect_success 'real edit works' '
>>> +test_expect_success 'setup file' '
>>> +       [...]
>>> +'
>>> +test_expect_success 'setup patch' '
>>> +       [...]
>>> +'
>>> +test_expect_success 'setup expected' '
>>> +       [...]
>>> +'
>>> +test_expect_success 'edit can strip spaces from empty context lines' '
>>> +       test_write_lines e n q | git add -p 2>error &&
>>> +       test_must_be_empty error &&
>>> +       git diff >output &&
>>> +       diff_cmp expected output
>>> +'
>>
>> I would have expected all the setup work to be contained directly in
>> the sole test which needs it rather than spread over three tests (two
>> of which are composed of a single command). Not a big deal, and not
>> worth a re-roll.
>
> Good point I was torn between that and matching the existing style in
> that file seems to be to create a million ancillary tests to do the set-up.

I see what you mean. Following existing practice in the file makes
sense, though breaking from that practice by bundling all the setup
into the single test which uses it wouldn't hurt either. It's a
judgment call (and not worrying about too much).
