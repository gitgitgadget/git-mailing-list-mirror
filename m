Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C215F20188
	for <e@80x24.org>; Sat, 13 May 2017 17:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbdEMRdb (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 13:33:31 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37509 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbdEMRda (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 13:33:30 -0400
Received: by mail-it0-f51.google.com with SMTP id g126so51426396ith.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KIeFp7fI+fpzZXThqc5fY+UtDZkssCeGXCj5LUGdgCo=;
        b=WiCs2CyhN1tCsCWyRaS5KaeytCtqQ5IxzkBzWC7cRxG7MHtMh+7MRN2cWH0woPQWFR
         YkiKX9MzjhTISxOBtMuz88M8z94Xb7F3dBcEfTcs3IzK20HvqqJxy0r2PjYiE+Ugh9qY
         2qIA2GLVSRGjbuYpcBhkLHkerlr+zbgzMPq+AbU7SkzPjmrObztC999jr9YY2n3Giuur
         aeGDOfNWZA0v7FsV8A9qVFeRyhOGqH6pB1K9Fpf9SODYay4aMbKqtG0IziXCQyzb4tIq
         DqzdxaqNqMc3VbhLx5H3Jj7zplg8Gdc2o0y42shAk4iLqah1m5oJQgXLlo/ufMhYcRcu
         uPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KIeFp7fI+fpzZXThqc5fY+UtDZkssCeGXCj5LUGdgCo=;
        b=cJcKlkiVzrPtlY94MDgTtdRXGHM7DMjFAg2F12AqB6p918zDsk+7buK/1u2FYBor7t
         6TN2AlSM7wTRHVoXd9vUdTWtgDDRMSS7Ru4KdVy1j+DOlgOMFAOzCbRYD64rIgN2Vv8y
         hz9tR5o97xqWEWeqaGA+LJAy4kTJjmZPQ+4t0Ls3aONumXY+8DtRh9M9fnx/ySAMq+8X
         d9oBDT80x9b7BR0maVDC/uAy1TtVyYgP8tX86G6kh/8Az9knbgzlzXzpOudgu5gfyEA7
         mEQ6Gb2ubgn+kA1zxn+QV4O6G6NLD/Y/0xk7Ej3EkyvqP9BZbxxPxDKthnPJLY8nVw1+
         3Nug==
X-Gm-Message-State: AODbwcA3M0jUxA6pAve1DIybgDRFE3XOKXUTTrvWcP/FmYLnhYIwwHQX
        t+cHnoJTK/Zmqi6+uzMCIYy4ZfH2yA==
X-Received: by 10.36.89.207 with SMTP id p198mr2350332itb.71.1494696809363;
 Sat, 13 May 2017 10:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 10:33:08 -0700 (PDT)
In-Reply-To: <xmqqpofe7jrq.fsf@gitster.mtv.corp.google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-10-avarab@gmail.com>
 <xmqqpofe7jrq.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 19:33:08 +0200
Message-ID: <CACBZZX6P=q=nAx4LinGG1877HitkrzC_dRL+9b4u7D38r3u_8g@mail.gmail.com>
Subject: Re: [PATCH 09/29] grep: amend submodule recursion test for regex
 engine testing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 6:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Amend the submodule recursion test to prepare it for subsequent tests
>> of whether it passes along the grep.patternType to the submodule
>> greps.
>>
>> This is the result of searching & replacing:
>>
>>     foobar -> (1|2)d(3|4)
>>     foo    -> (1|2)
>>     bar    -> (3|4)
>> ...
>>  test_expect_success 'grep and multiple patterns' '
>>       cat >expect <<-\EOF &&
>> -     b/b:bar
>> +     b/b:(3|4)
>>       EOF
>>
>> -     git grep -e "bar" --and --not -e "foo" --recurse-submodules >actua=
l &&
>> +     git grep -e "(3|4)" --and --not -e "(1|2)d" --recurse-submodules >=
actual &&
>
>
> This breaks the promise "foo maps to (1|2)"; I do not think you need
> to add 'd' in order to make the test to succeed, so I am not sure
> what is going on here.

Thanks, fixing it. That was just a stupid mistake on my part, don't
know how that snuck in there, must have just fat-fingered (1|2) as
(1|2)d during interactive replace.
