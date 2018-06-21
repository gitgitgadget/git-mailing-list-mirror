Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FE01F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeFUUiB (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:38:01 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39588 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeFUUh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:37:59 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so2903211uad.6
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Si034u37Zh3fIV6SiU/UjWmNZ4Y41KDtG7UPXvuVq+U=;
        b=aRTj4Mri7H/DtQrFbTnnWXfDEIPhR/D3aIiebsSNanXPPBw4eSUe25EJIefV7jRAKV
         sSnGmH3Bn1e2at6t1dqEui1eRhAmFrCVaf+LO5t7zMgLHpVvHcopQw8OuNovs3CCYnJu
         7pUwAEM3bhvSJKpam2+OXIinyUj+UGDMKd4lE21OOjJVSYLGfRBXu4cxD+ajJ8sSvT7e
         AslW5HDSIE52nLnTwkBPZVvR086yyfNbvIVjK04NYchqcjCneZ7vxxnDq7NFu/y8WEou
         ctizSVxl9i+eTJtiXfSXbX5RepIMrklWVsIKbwkFHnBIcTL4yETKtVFfTfsQT8IPUTxY
         txVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Si034u37Zh3fIV6SiU/UjWmNZ4Y41KDtG7UPXvuVq+U=;
        b=UXsNnBFdgOsIS/j4O0H03Ay/kN+e6xhMpnUD1EO7NKZfOLOWHxGXGdgDRkg0MjS9IL
         U+RYMpijYogW5sYpuoqXRpWipHDmhDeCFm80M+5T5wl3bpq7DqFNmaO7623ZJ6yOiiZl
         4BtloONoVNd5e5YRofvmqp3X7GPTRHIT7c8BIAHzeaL/QaSi43YMYVc+8QFHZEKg7Ndd
         V0lse+b/PbxvaFGOpcw7BjBeodc9DhKMfgwXHSrsdBqxseYZ5AJJ8F5kL1xS2uPuTCBL
         LRgvwVTTR/dBGcgtG5Yr0aF6CkXG/8YYHhitf3HCBsxdn/WFBa5ow6ln3bv2jobgffYs
         Nr7g==
X-Gm-Message-State: APt69E3Mgwp4dHbjxJ/3ONXtq/e3+6IKRi+UBMnt2A3NwrS/4KHfu80E
        2sulELcdb4KolHmgF1FUWX91N84k5MQ8dXh8jwU=
X-Google-Smtp-Source: ADUXVKINlq0Y7AM2pOaQYo4IfyR/nNwmBnZqDN+GNhj0Pr300m6LO8asOibp8yK4Ea0wAryI6jurFv9H6rbUeU4xhnc=
X-Received: by 2002:ab0:57c9:: with SMTP id u9-v6mr18255803uac.94.1529613479114;
 Thu, 21 Jun 2018 13:37:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:37:58
 -0700 (PDT)
In-Reply-To: <xmqqvaabsy6y.fsf@gitster-ct.c.googlers.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-4-newren@gmail.com> <xmqqvaabsy6y.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:37:58 -0700
Message-ID: <CABPp-BFtuv0REjFQZ9g9sOWKMumg1KDQk8nG+TD4JGdwF-VedQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] t3422: new testcases for checking when
 incompatible options passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> +     git checkout B &&
>> +     # This is indented with HT SP HT.
>> +     echo "          foo();" >>foo &&
>
> I often wonder, whenever I see a need for a comment like this, if
> saying the same thing in code to make it visible is cleaner and less
> error prone way to do so, i.e. e.g.
>
>         echo "_ _foo();" | tr "_" "\011" >>foo &&

I can make that change.  Should I make the same change to
t4015-diff-whitespace.sh, where I copied that comment and line of code
from?  (In a different topic submission, of course.)

>> +# Rebase has lots of useful options like --whitepsace=fix, which are
>> +# actually all built in terms of flags to git-am.  Since neither
>> +# --merge nor --interactive (nor any options that imply those two) use
>> +# git-am, using them together will result in flags like --whitespace=fix
>> +# being ignored.  Make sure rebase warns the user and aborts instead.
>> +#
>> +
>> +test_run_rebase () {
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
>> +
>> +test_run_rebase --whitespace=fix
>> +test_run_rebase --ignore-whitespace
>> +test_run_rebase --committer-date-is-author-date
>> +test_run_rebase -C4
>
> I happen to be from old school and "rebase" primarily means
> "format-patch piped to am" in my mind, so from that point of view,
> "test_run_rebase --OPT" that says "--OPT which is a valid option for
> the primary operating mode of rebase does not work with the other
> exotic modes of the command" is not all that bad, but I do not think
> that worldview holds for many people in general.  Perhaps calling it
> something like "test_rebase_am_only" makes the intent clearer?

Well, if that's what rebase means in your mind, then I'm sure you'll
have fun commenting on my follow-on series.  :-)

Anyway, sure, I'm happy to change the function name.
