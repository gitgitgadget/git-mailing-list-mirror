Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E08F20958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755721AbdCWUdD (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:33:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33659 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdCWUdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:33:02 -0400
Received: by mail-it0-f65.google.com with SMTP id 76so805078itj.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 13:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9zrUIGdJ+s7apFU4/o9Uvd36tOjxPsM70z2a2rTd/k=;
        b=Vu65FR8dPM7pDb1tA2Q2kRqx4L2sHdBth4va7U++TDWOxE7gYZdWc2u2b1GGjIHt/U
         vcOoTXUbAL5rAqiHpmKJqcPDhwTzz/3j/d8Ao3xR2+tUpBuvO0hCF6cwLI7sGAgvBLOW
         dBBBX7nVDLHOUokj7aV1MK4pZ6fqzH3bZxow02pfUDWvuE9MhLXUQyR2LJsTnhA4FNn1
         BR4Tgnc9b7p8ihxS84RKYzvzlh0sbdh4iQvOSJ/K9xYyu7qaFhCu+sJubs8tNLj/gfQy
         FAhk8d2W9UMjCF7KelcwVgtY5gEmMoPukhlpkT5X2IDeMVAGvmC/qCAwlQlMv+3LFcJT
         /1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9zrUIGdJ+s7apFU4/o9Uvd36tOjxPsM70z2a2rTd/k=;
        b=YLLORRods+jb15j6qfLHq22W8JGioCz92GVlGzjKiEOu6LUlsrQTNQhIFg5PxprTg1
         d0ZuCGB7J84KJdVnDShz09uLgTn/6zzt6OIg0+shubBISQBIl827fRCKDpFqHtUac04F
         PNbcwrZnZwm+fMCjPGj23ig5a33hjiVQ+tIK1tMQGeKXftQ6/Vp5KpXjsjvTs2HRI7Tk
         TMmwgdASPOZvdgWVdTRBw0khUCkwEKtFp2kb7Mpv/eGqnn//X57PNLuiB7cI7CvXXRIA
         4h6X9v86a369LPHr4Tsfi8fU/UMm8+FpapUMET0XVvnqwG7atP+XfDJVh/nfhYL+9L/v
         zXpw==
X-Gm-Message-State: AFeK/H1fXI+tV9MOSO0jyk0feo+6uG/KV8wVoBL9UQQVdw73pqoPsbCobTe/wCU8OH9WVYlnNbbCzZo0EBSIRg==
X-Received: by 10.36.29.66 with SMTP id 63mr14469725itj.91.1490301180802; Thu,
 23 Mar 2017 13:33:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 23 Mar 2017 13:32:40 -0700 (PDT)
In-Reply-To: <xmqqlgrvewak.fsf@gitster.mtv.corp.google.com>
References: <20170323130529.11361-1-avarab@gmail.com> <20170323130529.11361-13-avarab@gmail.com>
 <xmqqlgrvewak.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 21:32:40 +0100
Message-ID: <CACBZZX6HnUZSV49c2uRqW3u-+Tc-5LtaaEG=Yype1155qR0ifw@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] tag: implicitly supply --list given another
 list-like option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 2640c6955c..491dba065c 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -82,10 +82,11 @@ OPTIONS
>>
>>  -n<num>::
>>       <num> specifies how many lines from the annotation, if any,
>> -     are printed when using -l.
>> -     The default is not to print any annotation lines.
>> -     If no number is given to `-n`, only the first line is printed.
>> -     If the tag is not annotated, the commit message is displayed inste=
ad.
>> +     are printed when using -l. Implies `--list`.
>> ++
>> +The default is not to print any annotation lines.
>> +If no number is given to `-n`, only the first line is printed.
>> +If the tag is not annotated, the commit message is displayed instead.
>
> I thought we would want to have -n thing separate as we are much
> less sure than the others, but let's forget about that and commit
> to default to -l with -n.
>
> Given the confusion I had during the review of the previous round, I
> would think this should clarify what it means "If no number is given
> to -n" a bit more strongly.  Namely, the behaviour we see in this
> test:
>
>> +test_expect_success 'The -n 100 invocation means -n --list 100, not -n1=
00' '
>
> can be a common mistake and needs to be warned about.
>
> I'd drop "The default is not to print any annotation lines".  It is
> not just unnecessary (we make a specific mention about the default
> when we act as if an option were given even if the user doesn't
> explicitly give it, and not triggering a special feature when it is
> not asked for _is_ the default everywhere else), but is confusing,
> because it is unclear if it is talking about the default case of not
> giving any -n<num> option, or the default case of not giving <num>
> but still the -n option.
>
> Perhaps something along the lines of ...
>
> -n<num>::
>         Show the message of the annotated tag when using the
>         `--list` mode.  A number <num> can be directly attached to
>         the `-n` option (e.g. `-n100`; not `-n 100` as separate
>         arguments) to specify how many lines of the message to show.
>         Without <num>, only the first line of the message is shown.
>         For an unannotated tag that points at a commit, the commit
>         message is used instead.
>
> ... may be less confusing?

Sounds good, but a topic for another series I think. I'd rather stop
adding new things to this already big series, and it's not introducing
any new confusion with -n, just making the now confusing "tag -l -n
100" be equivalently written as "tag -n 100".

>> @@ -1496,7 +1517,6 @@ test_expect_success 'mixing incompatibles modes an=
d options is forbidden' '
>>       test_must_fail git tag -l -v &&
>>       test_must_fail git tag -l -d &&
>>       test_must_fail git tag -l -v -d &&
>> -     test_must_fail git tag -n 100 &&
>
> Hmph, wouldn't we want to instead replace it with
>
>         ... something to set expectation ... >expect &&
>         git tag -n 100 >actual &&
>         test_cmp expect actual &&
>
> here?

Nope, we already have detailed tests for "tag -n 100" and the like and
what that output should actually return earlier in the patch, this bit
is just removing it from the test for failing invocations.

>>       test_must_fail git tag -n 100 -v &&
>>       test_must_fail git tag -l -m msg &&
>>       test_must_fail git tag -l -F some file &&
>
> Thanks.
