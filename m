Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E272047F
	for <e@80x24.org>; Mon, 18 Sep 2017 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdIRUDf (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 16:03:35 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:49284 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdIRUDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 16:03:34 -0400
Received: by mail-wr0-f177.google.com with SMTP id u96so1424870wrb.6
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9CFdCXjpVghqWrsDUGKHKOLEiEeVDGxhQFrZI3cwkZg=;
        b=HHeFHTB0FJO/a6hmE6+h4v5ZRcG5zLKa+QzLeYMl/tZ6Q1aahncCz7yUzah73RXTmu
         EdGZ5MZ2OaEiWnVxNpeHFwt+tOlFWN56pXouRyCftvQYc6ZtEKWXtrXtMSv3ORH0yf44
         LQajX94yfHoZE2NU9q7QDpP1o8KDzKAP04nHeuQ2tLpyt/o8rkJs9gcUt6mag8lOvvGC
         CgkMKZXHfcgewfnEa9bQu8o0TpRFlFSPBqCjXcys9db+PpvjMVsv+a8TyY5jXC5zJN5U
         TZgr0I3amiiMxHPmM87xUORGpUc8CZFTjpPeyQ2/Bcj6JorSnZeNS/hDQvO03G+a7ZhP
         R4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9CFdCXjpVghqWrsDUGKHKOLEiEeVDGxhQFrZI3cwkZg=;
        b=lez93rjtZKfO8ZoPHJPt05U8dFL3FcDcuDXMxJiTh/A5FoVE+82j0Hi9IF63ytXfCM
         JWJhLtdx++RZkkZlcINppwPGoaJC6i0Ro46UPILX1CkhTlsjer3iIw72P95boQvEN7Rt
         LhoqalkytjhNpHhsVGYhrlC4EPl2XZ8OzhzgHUhSL2RMSjwmMMn2JVcSMAQQRkHL/gv1
         i9i89Cke3zhxvJB8fKvZVI3T0AMnqdh6hpAAUfdDL3uMgrjjDYtMgHjvhnFpKeLLv42t
         NtCaiTogOCEFwtAGy8ef6/EQIiWHLgxO6vq2ofE87EQd5gw0eSmTktHLvmulUPiW28I5
         gRoQ==
X-Gm-Message-State: AHPjjUhzaq8eXO/LsTTIUQ9KtKTTKGILqfsmEDVjOVwTDd1/qqbDcTtz
        vwhV7ayd02DlqS+kl37Eqp1WTjd9tf23AcLe5E8Mvu1KFn8=
X-Google-Smtp-Source: ADKCNb7JrPBeTCNIZ5KVGUIkGQqSsCyIh9BpfWCgLdDBvNncO+iY7AI8+4xbtVy8rwRirULMd9mll3zJT3Uu71/9JFg=
X-Received: by 10.223.138.238 with SMTP id z43mr28221358wrz.83.1505765012865;
 Mon, 18 Sep 2017 13:03:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 18 Sep 2017 13:03:32 -0700 (PDT)
In-Reply-To: <xmqqlgleup78.fsf@gitster.mtv.corp.google.com>
References: <20170817103413.GA52233@book.hvoigt.net> <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
 <20170818160603.GA69414@book.hvoigt.net> <CAGZ79kYNLo_3PfLTOE5wusTs6wgFXZLVH+qNZ-ovxGguhinHLg@mail.gmail.com>
 <20170915115021.GB76244@book.hvoigt.net> <xmqqlgleup78.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Sep 2017 13:03:32 -0700
Message-ID: <CAGZ79kaycuiFuB1m0SiyKoZ6UyEBCMiipYXkavN+NNyCZaY1=Q@mail.gmail.com>
Subject: Re: [PATCH v2] add test for bug in git-mv for recursive submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Took a little while but here is a more clean patch creating individual
>> submodules for the nesting.
>>
>> Cheers Heiko

Thanks for writing this test!

>
> Thanks.  Stefan, does this look good to you now?

Yes, though there are nits below.

> It is not quite clear which step is expected to fail with the
> current code by reading the test or the proposed log message.  Does
> "mv" refuse to work and we do not get to run "status", or does
> "status" report a failure, or do we fail well before that?

git-mv failing seems like a new possibility without incurring
another process spawn with the new repository object.
(Though then we could also just fix the recursed submodule)

> The log message that only says "This does not work when ..." is not
> helpful in figuring it out, either.  Something like "This does not
> work and fails to update the paths for its configurations" or
> whatever that describes "what actually happens" (in contrast to
> "what ought to happen", which you described clearly) should be
> there.
>
> Description on how you happened to have discovered the issue feels a
> lot less relevant compared to that, and it is totally useless if it
> is unclear what the issue is in the first place.
>
>>  t/t7001-mv.sh | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
>> index e365d1ff77..cbc5fb37fe 100755
>> --- a/t/t7001-mv.sh
>> +++ b/t/t7001-mv.sh
>> @@ -491,4 +491,29 @@ test_expect_success 'moving a submodule in nested directories' '
>>       test_cmp actual expect
>>  '
>>
>> +test_expect_failure 'moving nested submodules' '
>> +     git commit -am "cleanup commit" &&
>> +     mkdir sub_nested_nested &&
>> +     (cd sub_nested_nested &&

We seem to have different styles for nested shell. I prefer

  outside command &&
  (
      first nested command here &&
      ...

as that aligns indentation to the nesting level. I have seen
the style you use a lot in the  test suite, and we do not have
a guideline in Documentation/CodingGuidelines, so I do not
complain too loudly. ;)


>> +             touch nested_level2 &&
>> +             git init &&
>> +             git add . &&
>> +             git commit -m "nested level 2"
>> +     ) &&
>> +     mkdir sub_nested &&
>> +     (cd sub_nested &&
>> +             touch nested_level1 &&
>> +             git init &&
>> +             git add . &&
>> +             git commit -m "nested level 1"
>> +             git submodule add ../sub_nested_nested &&
>> +             git commit -m "add nested level 2"
>> +     ) &&
>> +     git submodule add ./sub_nested nested_move &&
>> +     git commit -m "add nested_move" &&
>> +     git submodule update --init --recursive &&

So far a nice setup!

>> +     git mv nested_move sub_nested_moved &&

This is the offending command that produces the bug,
as it will break most subsequent commands, such as

>> +     git status

git-status is one of the basic commands. Without
status to function, I think it is hard to recover your repo without
a lot of in-depth knowledge of Git (submodules).

I wonder if git-status should complain more gracefully
and fallback to one of --ignore-submodules={dirty, all},
that actually still works.

Maybe we could introduce a new default mode for this
flag, that is "none-except-on-error", though this sounds
as if we're fixing symptoms instead of the root cause.
