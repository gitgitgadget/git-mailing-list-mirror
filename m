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
	by dcvr.yhbt.net (Postfix) with ESMTP id 902A6201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbdEORih (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:38:37 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36205 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdEORig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:38:36 -0400
Received: by mail-io0-f171.google.com with SMTP id o12so78418254iod.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rk/d3s+elox93+vt5Wki1n1qDaW8+9jDfQkBOli2jMQ=;
        b=MdMd9Eff3YFXjLdVYnfobwwJgUtIGzVWJMddXELHwHItceLnWnt6rlCxTM/W1a4DKl
         CLWn2rhkG3pqjm4XGT0FCgjliwNKzxADF4Iqs65kwXNZkSQqN3PYl/EgpqGVfyiUxNXd
         M9XfDJS5ZfcO7pfJDTH19Sn8wILzR3bX4T9am99b4/uUQvY1L+zdKcgR9uXFp44X7e2h
         fUrH9EeLDl9YHkNCmV66TwT8s5cE/8jG7k3PShWs3f/rsDwwjnYDYr/O658WtDyI+9dL
         BMkk26nDbmq1JuVD5XgpkCCSM0J1YX0jhBDgMoF3AIXm+Z2/SkdQa6ulkX1VrH4t9Fo4
         XQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rk/d3s+elox93+vt5Wki1n1qDaW8+9jDfQkBOli2jMQ=;
        b=EU8dshg2rI+hEDi9sQdLMt0lfDV2uhIjXVfK5FtkxcBDnntnTSI5DbRDjEr4RiqyOi
         zpyYNfqzDwF7nbbum3tgTC1d5377aJ5bIB5TSzbiflaKuYFaXLmwmysxKb5NB2MYexVU
         eNOg3zHp2pREXmsNCIP/BNsaGTa6IBvKPcp/UOzn4DPqUplfLQoQUqy/NvQzg3KxsqtI
         09AJsctfL45ILM1MN5M8/PhFxP+qCud6JBBjHXPQJyErpBTRQC+V1Gz+maZzTNIUZNEQ
         /TmpPx357IORZYf+HWQ0RQZudxgnNZwyJN4IQq6MBNpgIh1FnSIZ6tKQTMcojGuJ05W5
         JteA==
X-Gm-Message-State: AODbwcAC6WV/3jHI3cI0YI5e8ULLhM/Atl52X8QgnhgQHbMOvhzhk1AL
        E4FTWZItFebfA0pXptmVJ7gMCXmOOw==
X-Received: by 10.107.178.12 with SMTP id b12mr6357440iof.50.1494869915687;
 Mon, 15 May 2017 10:38:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 10:38:14 -0700 (PDT)
In-Reply-To: <xmqq1srqwwbu.fsf@gitster.mtv.corp.google.com>
References: <20170513231509.7834-1-avarab@gmail.com> <20170513231509.7834-5-avarab@gmail.com>
 <xmqq1srqwwbu.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 19:38:14 +0200
Message-ID: <CACBZZX4EfWCD3rwQbRJ1TokDkH=7EfoepMd_ipHr5NSv9kWOJg@mail.gmail.com>
Subject: Re: [PATCH v2 04/29] log: add exhaustive tests for pattern style
 options & config
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

On Mon, May 15, 2017 at 6:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +     echo 2e >expect &&
>> +     # In PCRE \d in [\d] is like saying "0-9", and matches the 2
>> +     # in 2e...
>> +     git -C num_commits log -1 --pretty=3D"tformat:%s" -F -E --perl-reg=
exp --grep=3D"[\d]" >actual &&
>> +     test_cmp expect actual &&
>> +     echo 1d >expect &&
>> +     # ...in POSIX basic & extended it is the same as [d],
>> +     # i.e. "d", which matches 1d, but not and does not match 2e.
>
> s/not and//; I think.

Will fix.

>> +     git -C num_commits log -1 --pretty=3D"tformat:%s" -F -E --grep=3D"=
[\d]" >actual &&
>>       test_cmp expect actual
>>  '
>>
>> @@ -280,6 +301,77 @@ test_expect_success 'log with grep.patternType conf=
iguration and command line' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'log with various grep.patternType configurations &=
 command-lines' '
>> +     git init pattern-type &&
>> +     (
>> +             cd pattern-type &&
>> +             test_commit 1 file A &&
>> +
>> +             # The tagname is overridden here because creating a
>> +             # tag called "(1|2)" as test_commit would otherwise
>> +             # implicitly do would fail on e.g. MINGW.
>
> Thanks.
>
>> +             # POSIX extended needs to have | escaped to match it
>> +             # literally, whereas under basic this is the same as
>> +             # (|2), i.e. it would also match "1". This test checks
>> +             # for extended by asserting that it is not matching
>> +             # what basic would match.
>> +             git -c grep.patternType=3Dextended log --pretty=3Dtformat:=
%s \
>> +                     --grep=3D"\|2" >actual.extended &&
>
> Makes sense.
>
>> +             if test_have_prereq PCRE
>> +             then
>> +                     # Only PCRE would match [\d]\| with only
>> +                     # "(1|2)" due to [\d]. POSIX basic would match
>> +                     # both it and "1", and POSIX extended would
>> +                     # match neither.
>
> OK.  BRE would match because the other side of "\|" is empty to
> match anything?

Yes. I'll clarify this. It's not just a POSIX basic feature. The same
is true of extended and perl. E.g.:

    git grep [-E|-P] 'foo|bar'

Both match the same as:

    git grep [-E|-P] '(foo|bar)'

>> +                     git -c grep.patternType=3Dperl log --pretty=3Dtfor=
mat:%s \
>> +                             --grep=3D"[\d]\|" >actual.perl &&
>> +                     test_cmp expect.perl actual.perl
>> +             fi &&
>
