Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD46E20970
	for <e@80x24.org>; Mon, 10 Apr 2017 11:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbdDJLTS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 07:19:18 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36645 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdDJLTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 07:19:17 -0400
Received: by mail-ua0-f173.google.com with SMTP id a1so29010507uaf.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yiu2/Megz4/NlJvSnjqvOfp4TdltGsI2KNIeo5z6IZI=;
        b=XbkQYce9pfltRgPyUxDVKrVfcCwUBsQD8dTZ9rr1nySkEkAaW6oB5Jg1l1oQyCC070
         nP1ljbg4sMY6Z7hw6JnaOTqwcc3xvcmjyTIjNOh3KW19w72tzpJ7tgVIJsOs1CCuzp+t
         Kxui1MQH8vHcYycajDmD+E70vNP7mKWKqC6WVkgw1t0HnNnvUnb8VMiCWNa7iD8ywcS9
         V8yjsEn8KqO0VMHHVZSqfA2bL2klCXtDoaQlYvOk6LonLgFluuMQsf1m9pfFHgy4/Aev
         8/t6hIQMz2xsC+2gPZHyIKJ/0BiS4cQyfunNxRXfDHvcarJ/LGmZ25wYN8xwTGPwHok7
         ckWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yiu2/Megz4/NlJvSnjqvOfp4TdltGsI2KNIeo5z6IZI=;
        b=WGMjNnsB0gjEJxwtPBEQr+gaxK69z06fDKUbsynprAybOi5akjL2OsuLysscwctk9M
         KbRKiZAURnqUwyd9nmiSPKjy+8sycwH4E1Pfm0cHqyJU6s53lB+HboiLpjBOI94c82kh
         q7yGKLrLLCoHt0t4YzYIl3rUWW0YxRPORclOux2ODGlU4qUwGjqRZGe6M3BxtdKmHce/
         oKsTxPkiMxIF5YphEON82gvMYOna3eqQlMrVpG7tJag1D71WzRNSPIXv/1MZorBHSnJe
         TWb2i8x3+F8JAk3TqXGeGO6cV2fH47uiq29NsweBtcZ74O6j2He4ZREuy0ItqXY2dTqu
         XNsg==
X-Gm-Message-State: AN3rC/62v8MFqGYER/hOJ/rGfaXuzqvMY0yop65qk2sC4TbBTHGvjn7uqktWO787xXyI1kKJpM9E0jiZt4wxvg==
X-Received: by 10.31.109.67 with SMTP id i64mr2389516vkc.24.1491823156673;
 Mon, 10 Apr 2017 04:19:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.16.94 with HTTP; Mon, 10 Apr 2017 04:19:16 -0700 (PDT)
In-Reply-To: <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
References: <20170409191117.25175-3-avarab@gmail.com> <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 10 Apr 2017 13:19:16 +0200
Message-ID: <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 10:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 3:47 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:
>>> Change the test library to insert non-alphanumeric ASCII characters
>>> into the TRASH_DIRECTORY name, that's the directory the test library
>>> creates, chdirs to and runs each individual test from.
>>>
>>> Unless test_fails_on_unusual_directory_names=3D1 is declared before
>>> importing test-lib.sh (and if perl isn't available on the system), the
>>> trash directory will contain every non-alphanumeric character in
>>> ASCII, in order.
>>
>> At the very least there must be an easier way to disable this, e.g. a
>> command line option.
>>
>> This change is sure effective in smoking out bugs, but it's a major
>> annoyance during development when it comes to debugging a test.  At
>> first I could not even cd into the trash directory, because TAB
>> completing the directory name with all those non-printable characters
>> didn't work (this may be a bug in the bash-completion package).  And
>> simply copy-pasting the dirname didn't work either, because 'ls'
>>
>>   trash directory.t9902-completion.??????????????????????????????? !"#$%=
&'()*+,-:;<=3D>?@[\]^_`{|}~?

Btw, it seems most of the failures in t9902-completion are triggered
by remote URL parsing.  The trash directory's new name contains '[',
']' and even "@[", all of which are treated special by
connect.c:host_end(), a helper function of parse_connect_url(),
basically breaking anything trying to e.g.:

  git fetch "$(pwd)/other"

What puzzles me most is that parse_connect_url() recognizes right at
its beginning that a remote URL like this is not actually an URL, so
why does it continue parsing it as if it were one?

A few other failures are triggered by the ':' in the trash directory's
name, breaking the following commonly used pattern:

  export GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
  cd subdir &&
  test-git-pretending-it's-run-outside-of-a-repository

I think ':' should therefore be excluded from the trash directory, too.

>> After some headscratching, Sunday night may be my excuse, I figured
>> out that 'cd tr*' works...  only to be greeted with the ugliest-ever
>> three-line(!) shell prompt.
>>
>> Therefore I would say that this should not even be enabled by default
>> in test-lib.sh, so at least running a test directly from the command
>> line as ./t1234-foo.sh would considerately give us an easily
>> accessible trash directory even without any command line options.  We
>> could enable it for 'make test' by default via GIT_TEST_OPTS in
>> t/Makefile, though.
>
> This definitely needs some tweaking as you and Joachim point out. E.g.
> some capabilities check in the test suite to check if we can even
> create these sorts of paths on the local filesystem.
>
> A couple of comments on the above though:
>
> a) If we have something that's a more strict mode that makes tests
> fail due to buggy code in various scenarios, we gain the most from
> having it on by default

I know, and I basically agree...

> and having some optional mode to have devs
> e.g. disable it for manual inspection of the test directories.

... but this is just too gross to live as default outside of a CI
environment.

> Most of the running of the test suite that really matters, i.e. just
> before the software is delivered to end users, is going to be running
> in some non-interactive build system preparing a package.
>
> b) I think any sort of magic like using it with 'make test', but not
> when the *.sh is manually run, will just lead to frustrating seemingly
> heisenbugs from people trying to debug the test suite when things do
> fail, i.e. you run 'make test' on some obscure platform we haven't
> fixed path bugs on, 10 fail, you manually inspect them and every one
> of them succeeds, because some --use-garbage-dirs option wasn't
> passed.

That's not really an issue.  When a test fails during 'make test' with
garbage in trash dir names, the dev comes and attempts to cd into the
trash dir, and will be instantly reminded that non-printable
characters might play a role in the failure when he can't do so with
ordinary means.

>>> This includes all the control characters, !, [], {} etc. the "."
>>> character isn't included because it's already in the directory name,
>>> and nor is "/" for obvious reasons, although that would actually work,
>>> we'd just create a subdirectory, which would make the tests harder to
>>> inspect when they fail.i
>>
>> 1. Heh.  How an additional subdirectory would make the tests harder to
>>    inspect is nothing compared to the effect of all the other
>>    characters.
>>
>> 2. s/i$//
>>
>>> This change is inspired by the "submodule: prevent backslash expantion
>>> in submodule names" patch[1]. If we'd had backslashes in the
>>> TRASH_DIRECTORY all along that bug would have been fixed a long time
>>> ago. This will flag such issues by marking tests that currently fail
>>> with "test_fails_on_unusual_directory_names=3D1", ensure that new tests
>>> aren't added unless a discussion is had about why the code can't
>>> handle unusual pathnames, and prevent future regressions.
>>>
>>> 1. <20170407172306.172673-1-bmwill@google.com>
>>> ---
>>>  t/README      | 12 ++++++++++++
>>>  t/test-lib.sh |  4 ++++
>>>  2 files changed, 16 insertions(+)
>>>
>>> diff --git a/t/README b/t/README
>>> index ab386c3681..314dd40221 100644
>>> --- a/t/README
>>> +++ b/t/README
>>> @@ -345,6 +345,18 @@ assignment to variable 'test_description', like th=
is:
>>>       This test registers the following structure in the cache
>>>       and tries to run git-ls-files with option --frotz.'
>>>
>>> +By default the tests will be run from a directory with a highly
>>> +unusual filename that includes control characters, a newline, various
>>> +punctuation etc., this is done to smoke out any bugs related to path
>>> +handling. If for whatever reason the tests can't deal with such
>>> +unusual path names, set:
>>> +
>>> +    test_fails_on_unusual_directory_names=3D1
>>> +
>>> +Before sourcing 'test-lib.sh' as described below. This option is
>>> +mainly intended to grandfather in existing broken tests & code, and
>>> +should usually not be used in new code, instead your tests or code
>>> +probably need fixing.
>>>
>>>  Source 'test-lib.sh'
>>>  --------------------
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index 13b5696822..089ff5ac7d 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -914,6 +914,10 @@ fi
>>>
>>>  # Test repository
>>>  TRASH_DIRECTORY=3D"trash directory.$(basename "$0" .sh)"
>>> +if test -z "$test_fails_on_unusual_directory_names" -a "$(perl -e 'pri=
nt 1+1' 2>/dev/null)" =3D "2"
>>> +then
>>> +   TRASH_DIRECTORY=3D"$TRASH_DIRECTORY.$(perl -e 'print join q[], grep=
 { /[^[:alnum:]]/ and !m<[./]> } map chr, 0x01..0x7f')"
>>> +fi
>>>  test -n "$root" && TRASH_DIRECTORY=3D"$root/$TRASH_DIRECTORY"
>>>  case "$TRASH_DIRECTORY" in
>>>  /*) ;; # absolute path is good
>>> --
>>> 2.11.0
>>
>>
