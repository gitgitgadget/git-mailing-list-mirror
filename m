Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECB81F516
	for <e@80x24.org>; Wed, 27 Jun 2018 06:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeF0Gun (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 02:50:43 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46559 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeF0Gum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 02:50:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id b134-v6so526336vke.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBzKa5lZGJMW9yEa/uke23C4rsjEWzzF9BOfKIy4pfs=;
        b=vT4WTjs1L/PkCEqoX48hQxea2zEQsDY4DsAdMXZBP/Q+kGihLVzZDfjLqdIApytS+t
         2UaxGChuWazyDO+xb2JPjidZ1A9ANMN8U0S2xDyrp7AIYRAMuZNzHA0JTFy1TVchzppq
         HE/5ojfuS8xAuMWkPvFiJeyw4xHtXHqpXn+Ziua2VE0LJCy2iCz6Pz/DdlU9tr3l+Zxu
         0a80R7akG90MY1oJ2rhkkk5/4qp2uK+A1mdSMR7B5NypsbQyMZoGmJAR8+L2Hdk6DEK0
         3qFmAGr9SZAZfwshmDdXP16/B0YdmTwgyLFkTlcJs8bVdBn4Ty74gzfq8wHUf+HLnCL/
         DChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBzKa5lZGJMW9yEa/uke23C4rsjEWzzF9BOfKIy4pfs=;
        b=mVhzTiH4nR4aptMz+30yXl0hpjVRtlpQm+LHjfSJSvqDXlzqzmcYpy2JVvQk/cNKvd
         q/BHEDzN5AUKA3kcJn031oB7dFHcche8otGT5CCI9lhHB+GgJpHG5U5AveGBUu9VGSJa
         Koh4quVIyCqsCAn268qxP5zAQgTqrsRua3aOVgASfdHTda0iothHBugcWO4fffLPTmyY
         LncDmdAxGntNgaLfy4fg29S90DgVg0v/qjapgS5nlEj0POAaocNP4xC0t4NmEiDnXilv
         SRV93eRuBzyvw0+Q9U6TSSV6Xe+gWZOERuJI/ECsWY+E7mAoSI1w79djLN6n/L7KcCuJ
         wi6g==
X-Gm-Message-State: APt69E1sLNH+HmlKAwIkwFsSdLPR7DwrclnbKf6fQPmjMzty5FEM+Z+q
        GQs9LT4M7Aee1OqXh4DKL3vY1Voano0OxFBwKJE=
X-Google-Smtp-Source: AAOMgpcaZtQfUf46Yjuol8Di9VhHan9EKP3pkdLcU/Td4Jek8fPMcRwf5zXueXlcgJcFIWVJWYrczW0MmpFX0mfaz10=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr2801909vks.106.1530082241315;
 Tue, 26 Jun 2018 23:50:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 23:50:40
 -0700 (PDT)
In-Reply-To: <xmqqk1qll8f7.fsf@gitster-ct.c.googlers.com>
References: <20180621150023.23533-1-newren@gmail.com> <20180625161300.26060-1-newren@gmail.com>
 <20180625161300.26060-4-newren@gmail.com> <xmqqk1qll8f7.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 23:50:40 -0700
Message-ID: <CABPp-BGOqC1YbeYunL_hb=oyDufHKJsC9JvSRapoa7C-Y9Bqyg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] t3422: new testcases for checking when
 incompatible options passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> +# Rebase has lots of useful options like --whitepsace=fix, which are
>> +# actually all built in terms of flags to git-am.  Since neither
>> +# --merge nor --interactive (nor any options that imply those two) use
>> +# git-am, using them together will result in flags like --whitespace=fix
>> +# being ignored.  Make sure rebase warns the user and aborts instead.
>> +#
>> +
>> +test_rebase_am_only () {
>> +     opt=$1
>> +     shift
>> +     test_expect_failure "$opt incompatible with --merge" "
>> +             git checkout B^0 &&
>> +             test_must_fail git rebase $opt --merge A
>> +     "
>> +
>> +     test_expect_failure "$opt incompatible with --strategy=ours" "
>> +             git checkout B^0 &&
>> +             test_must_fail git rebase $opt --strategy=ours A
>> +     "
>> +
>> +     test_expect_failure "$opt incompatible with --strategy-option=ours" "
>> +             git checkout B^0 &&
>> +             test_must_fail git rebase $opt --strategy=ours A
>
> This line is broken and it is carried over to later patches.  It
> needs to be -Xours (or --strategy-option=ours, if we really want ot
> be verbose).

Indeed; I'll fix that up and resubmit.  Thanks for catching it.

>> +     "
>> +
>> +     test_expect_failure "$opt incompatible with --interactive" "
>> +             git checkout B^0 &&
>> +             test_must_fail git rebase $opt --interactive A
>> +     "
>> +
>> +     test_expect_failure "$opt incompatible with --exec" "
>> +             git checkout B^0 &&
>> +             test_must_fail git rebase $opt --exec 'true' A
>> +     "
>> +
>> +}
>
>> +
>> +test_rebase_am_only --whitespace=fix
>> +test_rebase_am_only --ignore-whitespace
>> +test_rebase_am_only --committer-date-is-author-date
>> +test_rebase_am_only -C4
>
> I was hesitant to hardcode what I perceive as limitations of non-am
> rebase implementations with a test like this, but once somebody
> fixes "rebase -i" for example to be capable of --whitespace=fix for
> example, then we can just drop one line from the above four (and
> write other tests for "rebase -i --whitespace=fix").  The
> test_rebase_am_only is to help us make sure what is (still) not
> supported by non-am rebases gets diagnosed as an error.

Yes, and I was thinking in particular that we could start by teaching
rebase -i to understand --ignore-space-change/--ignore-whitespace by
just transliterating it into -Xignore-space-change.  That is, after
https://public-inbox.org/git/20180607050845.19779-2-newren@gmail.com/
is picked up and eventually merged down.  Speaking of which, I need to
resubmit that.

> So my worry is totally unfounded, which is good.
