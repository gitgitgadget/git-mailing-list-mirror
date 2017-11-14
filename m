Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F58201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdKNBlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:41:00 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:52283 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdKNBk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:40:59 -0500
Received: by mail-ua0-f171.google.com with SMTP id p33so9183062uag.9
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9OrXYU/RzTh1dFjMOJs/2pyeQBEfGm+pv8axg3rreHY=;
        b=BAGF+niJzYb4N/DUWDj61K0dXSsWB6EhNx9xv9Ib6qNdR5+gwfegp26Vbm8Zvif6OT
         W9BGAHiDekGQgQW3QQBNpm6wj7iNac16a0ZH9/8pcidCF3mtrme/em6xMCFqPuUX/B/6
         87fzO1QrueW5bkMecql1kSiRKWm+X6XCrjUWVxXUzALzkggVZUaHN9gcXhgFO3ySHSAM
         mgy8LeX+uwGXyKGLnVdE+O2C4qhuFpTIiVQVQClfQBq5NSyEav9lvmv6EryyW6fIXKOC
         q4c8FTT7Ltl9c/shLSXXUr/7OfdKpcYAEdpTjVQ8MF6aFobIlqjK7as2pwbbIMakTqoS
         Y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9OrXYU/RzTh1dFjMOJs/2pyeQBEfGm+pv8axg3rreHY=;
        b=Fbj+rnorTng0QwT4tQXgvMG5Wf4w49Oo6Kzi/BBNtnTPLh1aoQXuYLnJvWxYIMkCVv
         LXROTjQCM7ekQn1yxDu936hlnxJTeIFewMWcDfjan7ye6UwTRW7EmDe2PcVP/ibeOpbP
         QJmENlKy0ZE+76bqb31XiO76U6QEa2rmldTrHJq3oaAqF0CCEhEqh/Ddxioe+7nQg23S
         m7/0wsASy++vsEV6CYONiruXcZrm8EEqj5G6K1W4NYzLaBa6837ISOU9koMF+y27065O
         jryL7rMKT+JHQZYGOIKpgevEq50zagnEhHHcYF9SCIHYJxw6kgIH5gE0MvfoWPEVFwTk
         Gf5Q==
X-Gm-Message-State: AJaThX7n+Em+2PwqfQ6h/fwgFgVOgc3wO0JyvtgE5Xtx2GuBWljSqs7C
        KonvGUmzL3tgn4eHY/SIgZtVDZTf53L6omvZgZU=
X-Google-Smtp-Source: AGs4zMalXJIRjYWS0x5PgAy6CxHCE0fhE2AnIs1s0dtgiYYYgVAfJUy4DGmNeEoA+u+3YXXtP4CTrgYJaFMHqtFM+pE=
X-Received: by 10.159.62.1 with SMTP id o1mr9743935uai.123.1510623658808; Mon,
 13 Nov 2017 17:40:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 17:40:58 -0800 (PST)
In-Reply-To: <CAGZ79kbK-deKq4KR-G5nq8MoCNK77hbr_B32W6Uo4i5Kq4_ojg@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-5-newren@gmail.com>
 <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com>
 <CABPp-BFKiam6AK-Gg_RzaLuLur-jz0kvv3TqsHNHg5+HTv_uzA@mail.gmail.com> <CAGZ79kbK-deKq4KR-G5nq8MoCNK77hbr_B32W6Uo4i5Kq4_ojg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 17:40:58 -0800
Message-ID: <CABPp-BGhxK4r_jhniOTT=UsFtu4C9yYPMF3azASQTiY=fVVDrA@mail.gmail.com>
Subject: Re: [PATCH 04/30] directory rename detection: basic testcases
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 5:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Nov 13, 2017 at 4:57 PM, Elijah Newren <newren@gmail.com> wrote:

> (slightly dreaming:)
> I wonder if we could teach our test suite to accept multiple test_done
> or restart_tests or such to resurrect the clean slate.

I'm dreaming now too; I would like that a lot more, although the
separate test_create_repo for each case isn't too bad and should be a
pretty mechanical switch.

>>>> +       test 3 -eq $(git ls-files -s | wc -l) &&
>>>
>>>     git ls-files >out &&
>>>     test_line_count = 3 out &&
>>>

> I am not saying it was a cargo-culting reaction, but rather relaying
> a well discussed style issue to you. ;)

Ah, gotcha.

>> If you feel the return code of ls-files is important, perhaps I could
>> just have a separate
>>    git ls-files -s >/dev/null &&
>> call before the others?
>
> I would prefer to not add any further calls; also (speaking generically)
> this would bring in potential racing issues (what if the second ls-files
> behaves differently than the first?)

Makes sense.

>> I'm not following.  The "old" and "new" in the filenames were just
>> there so a human reading the testcase could easily tell which
>> filenames were related and involved in renames.  There is no rename
>> associated with d, so why would I have called it "old" or "new"?
>
> because a user may be impressed by gits pattern matching in the
> rename detection:
>
>  A: z/{oldb,oldc}
>  B: z/{newb,newc}
>  C: z/{oldb, oldc, oldd}
>
> Obviously A->B is z/{old->new}-* (not a directory rename,
> but just patterns), so one might be tempted to expect newd
> as the expectation. But that is nonsense(!?)

Ah, now I see where you were going.  Thanks for explaining.

>> I think 2 is insanity.
>
> or the place where hooks/custom code shines. :)

:)
