Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BE31F406
	for <e@80x24.org>; Wed,  3 Jan 2018 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeACTPD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 14:15:03 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37374 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeACTPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 14:15:01 -0500
Received: by mail-wm0-f51.google.com with SMTP id f140so4400855wmd.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CevuWF0Kl0fO9rVR3ZL+qnUyFUOy9fBqxOP3igMW0dU=;
        b=fp/e6t40rXhjCPXKHWDxKtQ9pdfjyHJ7q0UgyxEgGrJONKladvkpgb6PMuyvgze3WG
         9DZsJqhoFb6vlRWaNvFiF3B3cOZzLplwFpeKgXlFLx3UO6XZehb5Bk2rzgS/esJ2DzCo
         3JR8Y4jTs6qxjajrwflPS+yU6RgZdFLUud6gkLYONzZpf1SD+E/nsRnG7iBfkQUgqGPu
         WlUG9Me32jUJn3ahjFVFFIyVXVl7FTwvgi73Jflhx2PXnE1X/K0LxdDYNP0uhV5+0O6A
         6uIzeLp000SuTCP47LchrvyZJrfMu+PHbpqcrJaMhD7zu3mV5wVEj0upy6l2uqfPe20N
         031g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CevuWF0Kl0fO9rVR3ZL+qnUyFUOy9fBqxOP3igMW0dU=;
        b=L39b9kUKo0byFu2zk1NEmpoTHD2ysTYCbE3OEmkFqLdnJfKhPoL6h0stukxff/NR1x
         5VfGFqWtD1WP3ZQXyNXVzAkhzGNws1fEQz9NNlLWoXwQ4gT1RgBZJby0gUqBo5Xaf83v
         txauODPajhO6vCKQeNf4NobNLYPrPABbehnJx0HVBAkxm2pO44zlSLKk2ed104P7z8Uj
         p+R74zDQ8G/8lv89rWVPbLI4hIK5/c8PHAinHFjW7DF9EJ1I2rQGQ0pd+Grul6MoPXRx
         cj9a8/s8W0h3Qb051lZUGfEdvD7Aj7FV6RI/2NWRDRhlNHolc03+ulc+3yVmgaDO/oxy
         mk0g==
X-Gm-Message-State: AKGB3mJiJieXdaNcr3Hq56MkK+BNcrjNp68anb2QGRioZoygFi1938fy
        R5bJYn74eYu1fNkSRa/7w2U=
X-Google-Smtp-Source: ACJfBotA/yeh7e7bCtbYXtzeMxObda2CWMm2VDPkCwFZ1TUOHUJelcPIOymBTeJH+OmhYg2L/Mf02w==
X-Received: by 10.80.151.215 with SMTP id f23mr3892066edb.141.1515006899995;
        Wed, 03 Jan 2018 11:14:59 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id v15sm961451edb.41.2018.01.03.11.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 11:14:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in addition to in-memory
References: <20171223213012.1962-1-avarab@gmail.com> <20171225002835.29005-8-avarab@gmail.com> <20180103130232.GD29210@dinwoodie.org> <87h8s3cbmn.fsf@evledraar.gmail.com> <20180103144149.GE29210@dinwoodie.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180103144149.GE29210@dinwoodie.org>
Date:   Wed, 03 Jan 2018 20:14:58 +0100
Message-ID: <87d12qdaa5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 03 2018, Adam Dinwoodie jotted:

> On Wednesday 03 January 2018 at 02:31 pm +0100, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Wed, Jan 03 2018, Adam Dinwoodie jotted:
>>
>> > On Monday 25 December 2017 at 12:28 am +0000, Ævar Arnfjörð Bjarmason wrote:
>> >> There has never been any full roundtrip testing of what git-ls-files
>> >> and other functions that use wildmatch() actually do, rather we've
>> >> been satisfied with just testing the underlying C function.
>> >>
>> >> Due to git-ls-files and friends having their own codepaths before they
>> >> call wildmatch() there's sometimes differences in the behavior between
>> >> the two, and even when we test for those (as with
>> >> 9e4e8a64c2 ("pathspec: die on empty strings as pathspec", 2017-06-06))
>> >> there was no one place where you can review how these two modes
>> >> differ.
>> >>
>> >> Now there is. We now attempt to create a file called $haystack and
>> >> match $needle against it for each pair of $needle and $haystack that
>> >> we were passing to test-wildmatch.
>> >>
>> >> If we can't create the file we skip the test. This ensures that we can
>> >> run this on all platforms and not maintain some infinitely growing
>> >> whitelist of e.g. platforms that don't support certain characters in
>> >> filenames.
>> >>
>> >> As a result of doing this we can now see the cases where these two
>> >> ways of testing wildmatch differ:
>> >>
>> >>  * Creating a file called 'a[]b' and running ls-files 'a[]b' will show
>> >>    that file, but wildmatch("a[]b", "a[]b") will not match
>> >>
>> >>  * wildmatch() won't match a file called \ against \, but ls-files
>> >>    will.
>> >>
>> >>  * `git --glob-pathspecs ls-files 'foo**'` will match a file
>> >>    'foo/bba/arr', but wildmatch won't, however pathmatch will.
>> >>
>> >>    This seems like a bug to me, the two are otherwise equivalent as
>> >>    these tests show.
>> >>
>> >> This also reveals the case discussed in 9e4e8a64c2 above, where '' is
>> >> now an error as far as ls-files is concerned, but wildmatch() itself
>> >> happily accepts it.
>> >>
>> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> >
>> > I'm seeing this test script failing on the pu branch as a result of this
>> > commit when building on Cygwin.  Specifically, the test fails at
>> > 9d45e1ca4 ("Merge branch 'bw/oidmap-autoinit' into pu", 2017-12-28), and
>> > bisecting points the blame at 2ee0c785a ("wildmatch test: create & test
>> > files on disk in addition to in-memory", 2017-12-25).
>> >
>> > I've copied the verbose error output for the first error below, and
>> > uploaded the full output, including verbose and trace output for the
>> > unexpectedly failing tests, at [0].  (With 42 failures among 1512 tests,
>> > there's a lot of it, so I didn't want to include it in an email.)
>>
>> Does the fixup above in <878tdm8k2d.fsf@evledraar.gmail.com> work for
>> you, i.e. changing $10 in the script to ${10}?
>
> This fixes some but not all of the failures: I'm now down from 42 to 24
> failures.
>
> Updated verbose test output is at
> https://gist.github.com/me-and/04443bcb00e12436f0eacce079b56d02

Thanks lot, looking through our own commit logs I believe the rest
should be fixed by this (prior art in 6fd1106aa4), it would be great if
you could test it, I don't have access to a Windows machine:

    diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
    index f985139b6f..5838fcb77d 100755
    --- a/t/t3070-wildmatch.sh
    +++ b/t/t3070-wildmatch.sh
    @@ -23,6 +23,15 @@ create_test_file() {
            *//*)
                    return 1
                    ;;
    +       # On Windows, \ in paths is silently converted to /, which
    +       # would result in the "touch" below working, but the test
    +       # itself failing.
    +       *\\*)
    +               if ! test_have_prereq BSLASHPSPEC
    +               then
    +                       return 1
    +               fi
    +               ;;
            # When testing the difference between foo/bar and foo/bar/ we
            # can't test the latter.
            */)
