Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8586A1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 13:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeACNbS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 08:31:18 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38288 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeACNbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 08:31:16 -0500
Received: by mail-wm0-f43.google.com with SMTP id 64so2707428wme.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 05:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SIaEhM+3eALTtJhFp2kjJWffpZbzjcOVL/frh4QF+Os=;
        b=bToxDTTer8h8tYb0mouCWwgfe/egiIha+GTlesxV/3o3jsLAhWVqvF0iDAIHZoP19c
         O1BtHZ2bmKwA1fSTwKVmi+BwhCGxgfN74mZCvvXgTL5aeJHUXMR1ZPBbRjPwIEhVJmB0
         N8YBz8F66cZLiZCgXZLqnPvfrqleZTw7iDvqII7BgZDiSXnsCoLruwrjWzuX2wYiZkti
         fY85TE7WBWGz7GMQzavKxo+0e8b7z1DNYZgg0YiVPX0sBZd1gW33lkXwLC312aBtlsZv
         q3gpm3ajE67xDzmlYRYbdD+7WdVlSqroqBleS5pYEK4QG2kXK3B5mTm5jnhfxOLvrG52
         8Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SIaEhM+3eALTtJhFp2kjJWffpZbzjcOVL/frh4QF+Os=;
        b=Gve6yByamWfdbrLFTx65eeOHRIIjmEBoXwEoLYqnw9zZaP6QDw6rIFjvECQfc6kWPb
         sskYlK72jZqVdbAQNyyM/9tOZq9LFuLhGPscaTXb8Idi73wADhLNkdyGG7Rk2oX4lXx7
         4RjFfprJYKaZWpiN1r1TttWFGbsTNcIYwnusqzJOfA+PAnBm1nnsEJzK66jcsqD5YCP/
         qfuNP3ntzIDLAis0Dg3XLOKOXKbRF3IHkyIzczso1u9swL5t4JKikZwuRnl6p0zS1G/d
         wvpNpCIzbOZ8+QFQ/N3871fY2ZVWL6/HvzSyqFJxl3SwIDGE5pNXmTtB2P9WjuKa0Ylf
         B1Bw==
X-Gm-Message-State: AKGB3mJXz+kXNAaw4nvgu/PQZt7OtX6oxWMgwBvAMkTf3w/GpEnOlwAU
        gZaQQCNmKtwyteYQmvgd+nI=
X-Google-Smtp-Source: ACJfBotYjy55Dg1mAAkWFxodzsljS5Ha7d7AtnmTHSaa/zv+qzndCB+TyPGSV2pV1OJatsb1DqVp3w==
X-Received: by 10.80.219.69 with SMTP id b5mr2696349edl.218.1514986275158;
        Wed, 03 Jan 2018 05:31:15 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id n3sm771290edb.46.2018.01.03.05.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 05:31:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in addition to in-memory
References: <20171223213012.1962-1-avarab@gmail.com> <20171225002835.29005-8-avarab@gmail.com> <20180103130232.GD29210@dinwoodie.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180103130232.GD29210@dinwoodie.org>
Date:   Wed, 03 Jan 2018 14:31:12 +0100
Message-ID: <87h8s3cbmn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 03 2018, Adam Dinwoodie jotted:

> On Monday 25 December 2017 at 12:28 am +0000, Ævar Arnfjörð Bjarmason wrote:
>> There has never been any full roundtrip testing of what git-ls-files
>> and other functions that use wildmatch() actually do, rather we've
>> been satisfied with just testing the underlying C function.
>>
>> Due to git-ls-files and friends having their own codepaths before they
>> call wildmatch() there's sometimes differences in the behavior between
>> the two, and even when we test for those (as with
>> 9e4e8a64c2 ("pathspec: die on empty strings as pathspec", 2017-06-06))
>> there was no one place where you can review how these two modes
>> differ.
>>
>> Now there is. We now attempt to create a file called $haystack and
>> match $needle against it for each pair of $needle and $haystack that
>> we were passing to test-wildmatch.
>>
>> If we can't create the file we skip the test. This ensures that we can
>> run this on all platforms and not maintain some infinitely growing
>> whitelist of e.g. platforms that don't support certain characters in
>> filenames.
>>
>> As a result of doing this we can now see the cases where these two
>> ways of testing wildmatch differ:
>>
>>  * Creating a file called 'a[]b' and running ls-files 'a[]b' will show
>>    that file, but wildmatch("a[]b", "a[]b") will not match
>>
>>  * wildmatch() won't match a file called \ against \, but ls-files
>>    will.
>>
>>  * `git --glob-pathspecs ls-files 'foo**'` will match a file
>>    'foo/bba/arr', but wildmatch won't, however pathmatch will.
>>
>>    This seems like a bug to me, the two are otherwise equivalent as
>>    these tests show.
>>
>> This also reveals the case discussed in 9e4e8a64c2 above, where '' is
>> now an error as far as ls-files is concerned, but wildmatch() itself
>> happily accepts it.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> I'm seeing this test script failing on the pu branch as a result of this
> commit when building on Cygwin.  Specifically, the test fails at
> 9d45e1ca4 ("Merge branch 'bw/oidmap-autoinit' into pu", 2017-12-28), and
> bisecting points the blame at 2ee0c785a ("wildmatch test: create & test
> files on disk in addition to in-memory", 2017-12-25).
>
> I've copied the verbose error output for the first error below, and
> uploaded the full output, including verbose and trace output for the
> unexpectedly failing tests, at [0].  (With 42 failures among 1512 tests,
> there's a lot of it, so I didn't want to include it in an email.)

Does the fixup above in <878tdm8k2d.fsf@evledraar.gmail.com> work for
you, i.e. changing $10 in the script to ${10}?

I was waiting on Junio to see if he'd like to just squash that or if I
should re-send.

>     expecting success:
>                                     wildtest_file_setup &&
>                                     printf '%s' '\' >expect &&
>                                     git --glob-pathspecs ls-files -z -- '00' >actual.raw 2>actual.err &&
>                                     wildtest_stdout_stderr_cmp
>
>     ++ wildtest_file_setup
>     ++ test_when_finished '
>                     rm -rf -- * &&
>                     git reset
>             '
>     ++ test 0 = 0
>     ++ test_cleanup='{
>                     rm -rf -- * &&
>                     git reset
>
>                     } && (exit "$eval_ret"); eval_ret=$?; :'
>     ++ git add -A
>     ++ printf %s '\'
>     ++ git --glob-pathspecs ls-files -z -- 00
>     ++ wildtest_stdout_stderr_cmp
>     ++ tr -d '\0'
>     ++ test_cmp expect.err actual.err
>     ++ diff -u expect.err actual.err
>     ++ test_cmp expect actual
>     ++ diff -u expect actual
>     --- expect      2018-01-03 12:43:11.116611200 +0000
>     +++ actual      2018-01-03 12:43:11.216180400 +0000
>     @@ -1 +0,0 @@
>     -\
>     \ No newline at end of file
>     + test_eval_ret_=1
>     + want_trace
>     + test t = t
>     + test t = t
>     + set +x
>     error: last command exited with $?=1
>     ++ rm -rf -- actual actual.err actual.raw expect expect.err
>     ++ git reset
>     ++ exit 1
>     ++ eval_ret=1
>     ++ :
>     + test_eval_ret_=0
>     + want_trace
>     + test t = t
>     + test t = t
>     + set +x
>     not ok 490 - wildmatch(ls): match '00' '\'
>     #
>     #                                       wildtest_file_setup &&
>     #                                       printf '%s' '\' >expect &&
>     #                                       git --glob-pathspecs ls-files -z -- '00' >actual.raw 2>actual.err &&
>     #                                       wildtest_stdout_stderr_cmp
>     #
>
> I'm digging into the failures myself now, but wanted to report the
> problem in the name of getting more eyes on it.
>
> Adam
>
> [0]: https://gist.github.com/me-and/04443bcb00e12436f0eacce079b56d02
