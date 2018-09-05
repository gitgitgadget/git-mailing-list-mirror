Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774C01F404
	for <e@80x24.org>; Wed,  5 Sep 2018 05:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIEKB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 06:01:26 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41521 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeIEKB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 06:01:26 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so11331130oiw.8
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VcJWD/9v4aT1Ce8ATEe701pzvdVZsIFyqzL2VCJB0pw=;
        b=QIHiPgDASbb0iIGmoWDXNbLWM5iz80BFBaFXt5QJnS2PXhs6XbsbVnRSEBBgOjtEEj
         Mx/x2w7sC5yQNcnld7h94DpZf8QFBul4SkfIkoP3ft+zPsUXPpzwYB74rGVM/vrrrQ+A
         EaFZ2O2lclrzM+vG6/RN3BHAsWBpFvPY760kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VcJWD/9v4aT1Ce8ATEe701pzvdVZsIFyqzL2VCJB0pw=;
        b=TZTEPPFhg+VfwTr4kPBRcMQk4tF3HGv47tL22DiaIhL2FAELHjV4LAcrgtt1+qvB/u
         OPT2SFvQEjY5qoLhaeBcl9eAZvhIjXcYbCUKzG4B1NvjpRBi0+6uT2kr7S3+5HUFzslx
         RWPEZG1wn3gAlsOp3ie3n+l+/WRW9sfjnQD/CCgqhQQBWw1p3lw1xFIWF8GA6cahL2E1
         0fsvUrKANZwIGkPb53VRJpMEylTx8fmIKWgD3bRzI0Yr0a9a6adCY4ueLzUeyxSZjX9D
         7uBxbfwaN7a9orKtCWUMbryNIlWyg9qAwfUKl08+nBuhdMY4g3Hj4oUpFLjs+obCTOCX
         cDVg==
X-Gm-Message-State: APzg51CMdBcpQWjbTcBf0ITPEwI7DyCtqz6mrCcWeHTDSLKYmDbWdE5m
        SQwVuuAOhgiM1j7pXdO7n8DYlw4i0WmA7T9OfC+rog==
X-Google-Smtp-Source: ANB0VdaaekD6CkVaTH2anWCUBrucdViYz8Q/uxsqoqZgOZiUa0/wIDhoFS+TO50Nke023lj8Q5v8nnvmnblCNTdzt0Y=
X-Received: by 2002:aca:c602:: with SMTP id w2-v6mr26518369oif.122.1536125578234;
 Tue, 04 Sep 2018 22:32:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1ec:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 22:32:57 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
 <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com> <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 5 Sep 2018 06:32:57 +0100
Message-ID: <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with
 --write-junit-xml upon failure
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 September 2018 at 12:09, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
>
> On Tue, 4 Sep 2018, Eric Sunshine wrote:
>
>> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> > So let's do something different in VSTS: let's run all the tests with
>> > `--quiet` first, and only if a failure is encountered, try to trace the
>> > commands as they are executed. [...]

Is this re-running just an individual test on its own or all the tests
within a single file?

The latter shouldn't need this at all. And the former, I'm not sure
will actually work - most of the tests assume some particular p4
state. But perhaps I'm missing something?

I also think it does look kind of ugly. And if there's one thing I've
learned, it's that the ugly hack you write today with the words "we'll
tidy this up later" goes on to live with you forever!

>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > @@ -445,10 +452,37 @@ test_ok_ () {
>> >  test_failure_ () {
>> >         if test -n "$write_junit_xml"
>> >         then
>> > +               if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
>> > +               then
>> > +                       case "$(type kill_p4d 2>/dev/null | head -n 1)" in
>> > +                       *function*) kill_p4d;;
>> > +                       esac
>> > +
>> > +                       case "$(type stop_git_daemon 2>/dev/null |
>> > +                               head -n 1)" in
>> > +                       *function*) stop_git_daemon;;
>> > +                       esac
>>
>> In the long run, it might make more sense, and be more scalable, to
>> have those scripts define a "prepare_for_rerun" variable or function
>> which this code then runs generically rather than having special
>> knowledge of those facilities.
>>
>> I could imagine, for instance, test-lib.sh defining a no-op:
>>
>>     test_failure_prepare_rerun () {}
>>
>> and then each of those scripts overriding the function:
>>
>>     # in lib-git-p4.sh
>>     test_failure_prepare_rerun () {
>>         kill_p4d
>>     }
>>
>>     # in lib-git-daemon.sh
>>     test_failure_prepare_rerun () {
>>         stop_git_daemon
>>     }
>
> Or we could implement `test_atexit` (similar to `test_when_finished`, but
> to be executed at `test_done` time). I guess that's what the p4 and daemon
> tests really needed to begin with (and probably also the apache2-using
> tests).
>
>>
>> > +                       # re-run with --verbose-log
>> > +                       echo "# Re-running: $junit_rerun_options_sq" >&2
>> > +
>> > +                       cd "$TEST_DIRECTORY" &&
>> > +                       eval "${TEST_SHELL_PATH}" "$junit_rerun_options_sq" \
>> > +                               >/dev/null 2>&1
>> > +                       status=$?
>> > +
>> > +                       say_color "" "$(test 0 = $status ||
>> > +                               echo "not ")ok $test_count - (re-ran with trace)"
>> > +                       say "1..$test_count"
>> > +                       GIT_EXIT_OK=t
>> > +                       exit $status
>> > +               fi
>> > +
>> >                 junit_insert="<failure message=\"not ok $test_count -"
>> >                 junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
>> >                 junit_insert="$junit_insert $(xml_attr_encode \
>> > -                       "$(printf '%s\n' "$@" | sed 1d)")"
>> > +                       "$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
>> > +               >"$GIT_TEST_TEE_OUTPUT_FILE"
>> >                 junit_insert="$junit_insert</failure>"
>> >                 write_junit_xml_testcase "$1" "      $junit_insert"
>> >         fi
>>
>> This junit-related stuff is getting pretty lengthy. I wonder if it
>> would make sense to pull it out to its own function at some point
>> (again, in the long run).
>
> Now that you mention it... I agree. This is getting long.
>
> In the short run, I have two things to consider, though: I want to make
> this work first, then think about introducing a layer of abstraction, and
> I want to go on vacation tomorrow.
>
> So I agree that this is something to be considered in the long run, i.e.
> not right now ;-)
>
> Thanks,
> Dscho
