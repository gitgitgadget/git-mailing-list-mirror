Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAE0201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754764AbdEKUux (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:50:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35004 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbdEKUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:50:51 -0400
Received: by mail-it0-f65.google.com with SMTP id 67so4256235itx.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaoXDptYWK0F3dUnzxZU+mW+f9yhtLw/7ulRDdKgwss=;
        b=MHb9jlwHEMi6dtbgbDI+gQAH9JTW5F4jr1xnyDJ2c68ow5DT6ZMOzVRgBgABjdhXaX
         rlIp1zNWyOv7CdPWIpMFnCgU0EBllAWXeKrQ2rx1EvQp6EIWW8bTVIDa3Q6xJSJEHOov
         i2XsjHspnEB1Z12nlc7w79PUX52rJ+Sj7TBuWS3pha+DVO2zVYZqY5dAzQcyXu4ZRW03
         C+iczvzGpIZQ/WTR5lqJ6+dF2Gfv5mPfKvbtT+jb6gYKDnnehm6QeFsbGhZNmvAcc3qF
         uKt6EIHn55T9QXzbgBJAqZOlUSdC6jKY2LpYP6r8H79X6S2YbnLEMDl3B7MUsYtCzo09
         EB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaoXDptYWK0F3dUnzxZU+mW+f9yhtLw/7ulRDdKgwss=;
        b=Bi+Ge1S1E7f/wFguRbHQDQ54Ly3VlduCQvpYfgXoSCGXaj8kwd4ibrDSGnW5k+G5/r
         wT/eGfTa1yjVtjZtSx0m4Pgx0nmjUYegW3nGVLhQzrwqOqu0x89TPbggtITmwuNZvHA2
         qjjEM6JM2JHBtBce5Nyt+giBmqsvm4eL475vcMVTLtAVukxfyNSsPN8qDiTPexbjtL7K
         pN1G1i18/1kj7cx+eabjdq8Dyl8RWRn8yM8QApC0FiCVv5p72ty0znbuC26ZDE7uApQ5
         iQKNbDmn+fS/iyKRVdJ983ui+rbCe5T7OId/bfA2j4WzuDBEIIpfVmp8bkUca/wLHroS
         v2Dg==
X-Gm-Message-State: AODbwcCVqTMcguUo8zMQb0jmkrzhMeVzDk6OKx671oELOG+D7m2QrHyg
        uPxbGqKH2+vdad5unaRL8hbwajcquQ==
X-Received: by 10.36.89.207 with SMTP id p198mr15073itb.71.1494535851114; Thu,
 11 May 2017 13:50:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 13:50:30 -0700 (PDT)
In-Reply-To: <CAGZ79kb_ueU8hArtA3yvYywvawnuD0RGQBtm1=OEuQi2L0rjmA@mail.gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-19-avarab@gmail.com>
 <20170511200804.GF83655@google.com> <CAGZ79kb_ueU8hArtA3yvYywvawnuD0RGQBtm1=OEuQi2L0rjmA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 22:50:30 +0200
Message-ID: <CACBZZX6-jQA3Dn1rzVcXq6=wF-VkXELQqLwEsJYH=ede1_3syw@mail.gmail.com>
Subject: Re: [PATCH 18/29] grep: catch a missing enum in switch statement
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:40 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 11, 2017 at 1:08 PM, Brandon Williams <bmwill@google.com> wro=
te:
>> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> Add a die(...) to a default case for the switch statement selecting
>>> between grep pattern types under --recurse-submodules.
>>>
>>> Normally this would be caught by -Wswitch, but the grep_pattern_type
>>> type is converted to int by going through parse_options(). Changing
>>> the argument type passed to compile_submodule_options() won't work,
>>> the value will just get coerced.
>>>
>>> Thus catching this at runtime is the least worst option. This won't
>>> ever trigger in practice, but if a new pattern type were to be added
>>> this catches an otherwise silent bug during development.
>>>
>>> See commit 0281e487fd ("grep: optionally recurse into submodules",
>>> 2016-12-16) for the initial addition of this code.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>>> ---
>>>  builtin/grep.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/builtin/grep.c b/builtin/grep.c
>>> index 3ffb5b4e81..1c0adb30f3 100644
>>> --- a/builtin/grep.c
>>> +++ b/builtin/grep.c
>>> @@ -495,6 +495,12 @@ static void compile_submodule_options(const struct=
 grep_opt *opt,
>>>               break;
>>>       case GREP_PATTERN_TYPE_UNSPECIFIED:
>>>               break;
>>> +     default:
>>> +             /*
>>> +              * -Wswitch doesn't catch this due to casting &
>>> +              * -Wswitch-default is too noisy.
>>> +              */
>>> +             die("BUG: Added a new grep pattern type without updating =
switch statement");
>
> I am not sure if the comment is of enough value for the used screen
> real estate value.
> People interested in the existence of the default would just use
> blame/log to find out.

Thanks, I was on the fence about it, will remove it (and add the
mention of -Wswitch-default to the commit message).
