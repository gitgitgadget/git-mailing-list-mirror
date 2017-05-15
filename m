Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC80201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757876AbdEORjp (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:39:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32951 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757666AbdEORjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:39:43 -0400
Received: by mail-it0-f65.google.com with SMTP id l145so11809574ita.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3q1XtnDaVmYaeX7LK4y/sypNsmeS3NKK3vqS3HOGmI0=;
        b=Y2y+EN0LkszJboFBOXcOwyV3Vzsq1UoVvVOwGaV9NVr9r19YqQQ8hrvwp4zgXQ+GRy
         k6wp3eUUSQVN2GCeMcQlur1cMzX9tqQoVnAlDhRLHQXkjhOrn1UlT5/s4sCYS+JZHtpM
         OWmnEjrXvPwrIOtVHEYoXMTqCXsb/UkYm7O01XB9ZbsgzAIKC+MlWTRXbV3o3yL9qg2H
         zntkmvV86uQ3+PzcxTj83MMUv6eltQ3oiBDo+/3oTH6GOgaHg+EPVnoqt2JxBZTar0t8
         cS8/yCdoWGbHhVIGdeQ2UwRuNL+HtQSdrrlGVj47vrlG4NWcPYeDCy+3Ic6A1nvp5WFb
         cRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3q1XtnDaVmYaeX7LK4y/sypNsmeS3NKK3vqS3HOGmI0=;
        b=nR9XCIsJiPEQxdrcyTJI9gvhHxKch2XUiIpcsfVoeVSW983rZGnbt7Ci5PcWgJuwnu
         q3n0alwT6Xj1nFaPd0Xkl8PGVq50f4MMmMgzGiCz7C/huMKIV67JftMm33DUFNpQBdi3
         5WV2X0aPTOeQRBppWi7BBYoZKZszE9uVlr8NLhZWUb+NRyF/94RshBMi65XVbzrw0ANh
         FoMQ2PGEx4YCIML/OPD/2qmPHuP5rgnGK+RgUShy3u4UZMg1gJhQ56m6wVAJ0bDEUSrg
         e4O3O47X6si2q+HUZt0YA4ZS5/NSW/q2W0UFkxND9tUzVdzyW5XXPcIWWMXBCy7a55G3
         +eng==
X-Gm-Message-State: AODbwcALTQbSXCnuKc7HrEI2ig5sX0SGxDvzbMD/j0t7+sOnvZTDYzCe
        QQW+GL1ifS5JaeuR3nsIJlTOX/HBf+VJ
X-Received: by 10.36.138.131 with SMTP id v125mr6643438itd.66.1494869983038;
 Mon, 15 May 2017 10:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 10:39:22 -0700 (PDT)
In-Reply-To: <xmqqwp9ivfbu.fsf@gitster.mtv.corp.google.com>
References: <20170513231509.7834-1-avarab@gmail.com> <20170513231509.7834-19-avarab@gmail.com>
 <xmqqwp9ivfbu.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 19:39:22 +0200
Message-ID: <CACBZZX5upAY2MB7vk9wNaXUjnEZmw1vEkp3eKk+UyFvPm567Gw@mail.gmail.com>
Subject: Re: [PATCH v2 18/29] grep: catch a missing enum in switch statement
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 7:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a die(...) to a default case for the switch statement selecting
>> between grep pattern types under --recurse-submodules.
>>
>> Normally this would be caught by -Wswitch, but the grep_pattern_type
>> type is converted to int by going through parse_options(). Changing
>> the argument type passed to compile_submodule_options() won't work,
>> the value will just get coerced. The -Wswitch-default warning will
>> warn about it, but that produces a lot of noise across the codebase,
>> this potential issue would be drowned in that noise.
>>
>> Thus catching this at runtime is the least worst option. This won't
>
> least bad, I guess?

Will fix.

>> ever trigger in practice, but if a new pattern type were to be added
>> this catches an otherwise silent bug during development.
>
> Good future-proofing.  When this and Peff's "BUG" thing both
> graduates, we can turn this into a BUG, I think.

Yup, this and a bunch of other stuff presumably. The BUG feature is nice.

> Thanks.
>
>>
>> See commit 0281e487fd ("grep: optionally recurse into submodules",
>> 2016-12-16) for the initial addition of this code.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/grep.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 3ffb5b4e81..a191e2976b 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -495,6 +495,8 @@ static void compile_submodule_options(const struct g=
rep_opt *opt,
>>               break;
>>       case GREP_PATTERN_TYPE_UNSPECIFIED:
>>               break;
>> +     default:
>> +             die("BUG: Added a new grep pattern type without updating s=
witch statement");
>>       }
>>
>>       for (pattern =3D opt->pattern_list; pattern !=3D NULL;
