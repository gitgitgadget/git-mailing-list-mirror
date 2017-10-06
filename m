Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750A520372
	for <e@80x24.org>; Fri,  6 Oct 2017 19:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdJFTl0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:41:26 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:56626 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdJFTlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:41:25 -0400
Received: by mail-qt0-f175.google.com with SMTP id 34so16335252qtb.13
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q9640pBNtE0L7o2vE40GYHfnjfbs8fH/WQKVPAx3WHQ=;
        b=Sqq5/dMTIFzYFNspF+d7WijZvAAGTRk63aYA37B+/KR9MAmhkBRkq7bpxqKi+I1uxC
         IWQwLis+OhlyLbI7cbq/aK3W/dwEcgL6OqZfBBlWPh9Un0gMwFyDzjI8reTockBfxtKR
         vCQ+o2QRT4Gdncd9HjR0OD2pOKoGGUnHn3gMw9VzsjJ5WIdcxpwQDQLoGygebvAfMhdG
         Hoem/2naT+iV1C2p4SOoAoMWgKNpzgf1A4c4PCcdoO3Jj339lM5ZwHPMTia66gSE/3/R
         lbHr1cNB2T6K5F/D/8PsWdmHr6TkIAZ7rDKXiZrDVu/XeOrAdgCZ+lp67cZfTjjrvqQJ
         ZBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q9640pBNtE0L7o2vE40GYHfnjfbs8fH/WQKVPAx3WHQ=;
        b=oGg+R+5RD2YDYKyanbCfJ9lwaTHuAAs/kw6vFR2al1t/8RCvtN6LcnmcVDHzDEOiAa
         qb9suG9dA2w1jTgjnp6sFiP4erBMUq9ddYRbcauenOD7hRpDWRCi3xq+xe29hN/xMvpA
         cARmrNFO13L50kZJMIKZpkkf/H6u3riEnnwOvQWkXVkzY5luqRE1poqHJBG5FUI8gU/7
         chhdbtBzyuop31Fj32Ug8mMHqh1bbFS457dwKbN34957tIuOCXiltRkxXmwJLXzUioAz
         pJI+/RVC7bpVpdNgmMEmeT1Yo4D6FYgJkieXll2l+1ImX/tL+x4PGV2slx3TFU3Q6Odl
         TWzg==
X-Gm-Message-State: AMCzsaVZxPeu1LDK/b1xgA9dOsFiCHakNUO2SBUX3HQJ2F/GXmWoPC12
        nWF+cECSQyal766ZIwaXnJbDpy+3QE0K5GrgnTnsKnd/
X-Google-Smtp-Source: AOwi7QBcnhbkRiKebwDw7Tn11ZaguwQde9IVqqhNgpDhCVkZm3DeSBPheGjtFz1kJqpNfXvyKRh1RjgOAVjqBwoc7w0=
X-Received: by 10.200.36.175 with SMTP id s44mr4706486qts.298.1507318883234;
 Fri, 06 Oct 2017 12:41:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Fri, 6 Oct 2017 12:41:22 -0700 (PDT)
In-Reply-To: <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net>
References: <20171006190006.19623-1-sbeller@google.com> <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Oct 2017 12:41:22 -0700
Message-ID: <CAGZ79kb4N2442HNWJuviATpOwiQ-qoGOgK+6Ys2JQMuS_kvjzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests: use shell negation instead of test_must_fail
 for test_cmp
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 12:22 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 06, 2017 at 12:00:05PM -0700, Stefan Beller wrote:
>
>> The `test_must_fail` should only be used to indicate a git command is
>> failing. `test_cmp` is not a git command, such that it doesn't need the
>> special treatment of `test_must_fail` (which e.g. includes checking for
>> segfault)
>
> Hmph. "test_must_fail test_cmp" is a weird thing for somebody to write.
> And your patch is obviously an improvement, but I have to wonder if some
> of these make any sense.

Thanks for actually thinking about the problem. I just searched and replaced
the combination of test_must_fail and test_cmp mechanically after I noticed
one such occurrence whilst preparing the next patch (order of test_cmp args).

>
> If we're expecting some outcome, then it's reasonable to say:
>
>   1. The output should look exactly like this. (test_cmp)
>
>   2. The output should look something like this. (grep)
>
>   3. The output should _not_ mention this (! grep)
>
> But "the output should not look exactly like this" doesn't seem very
> robust. It's likely to give a false success due to small changes (or
> translations), or even bugs in the script.

I agree that the case "should not look like exactly this" is most likely
indicating a weak test.


> Running ./t3504 with "-v" (with or without your patch) shows:
>
>   --- expect    2017-10-06 19:14:43.677840120 +0000
>   +++ foo       2017-10-06 19:14:43.705840120 +0000
>   @@ -1 +1 @@
>   -fatal: cherry-pick: --no-rerere-autoupdate cannot be used with --continue
>   +foo-dev
>
> Which just seems like a bug.  Did the original author mean foo-expect?

This was originally written by a non regular in 2008. I don't think
they remember even if we'd ask.

I think we'd want to not resolve it to foo-dev here,
(so ideally we'd test for

<<<<
foo
====
foo-dev
>>>>

but just testing that we do not blindly resolve to foo seems ok-ish)

Thanks for spotting this!

> It's hard to tell, as we are just reusing expectations from previous
> tests.
>
>> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
>> index 02106c9226..7178b917ce 100755
>> --- a/t/t5512-ls-remote.sh
>> +++ b/t/t5512-ls-remote.sh
>> @@ -56,7 +56,7 @@ test_expect_success 'use "origin" when no remote specified' '
>>
>>  test_expect_success 'suppress "From <url>" with -q' '
>>       git ls-remote -q 2>actual_err &&
>> -     test_must_fail test_cmp exp_err actual_err
>> +     ! test_cmp exp_err actual_err
>>  '
>
> This one seems like "test_18ngrep ! ^From" would be more appropriate. Or
> even "test_must_be_empty".

Going by the test title, I agree.

>> diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
>> index fac5a73851..5f9ad51929 100755
>> --- a/t/t5612-clone-refspec.sh
>> +++ b/t/t5612-clone-refspec.sh
>> @@ -87,7 +87,7 @@ test_expect_success 'by default no tags will be kept updated' '
>>               git for-each-ref refs/tags >../actual
>>       ) &&
>>       git for-each-ref refs/tags >expect &&
>> -     test_must_fail test_cmp expect actual &&
>> +     ! test_cmp expect actual &&
>>       test_line_count = 2 actual
>
> Here we check that no updates happened due to a fetch because we see
> that the tags in the fetched repo do not match the tags in the parent
> repo. That actually seems pretty legitimate. But I think:
>
>   git for-each-ref refs/tags >before
>   git fetch
>   git for-each-ref refs/tags >after
>   test_cmp before after
>
> would be more straightforward.
>
>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>> index 93f162a4f7..1644866571 100755
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>> @@ -1532,7 +1532,7 @@ test_expect_success '"status.branch=true" same as "-b"' '
>>  test_expect_success '"status.branch=true" different from "--no-branch"' '
>>       git status -s --no-branch  >expected_nobranch &&
>>       git -c status.branch=true status -s >actual &&
>> -     test_must_fail test_cmp expected_nobranch actual
>> +     ! test_cmp expected_nobranch actual
>>  '
>
> Shouldn't this be comparing it positively to the output with "--branch"?
>
>>  test_expect_success '"status.branch=true" weaker than "--no-branch"' '
>> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
>> index d8464d4218..5cd6b40432 100755
>> --- a/t/t9164-git-svn-dcommit-concurrent.sh
>> +++ b/t/t9164-git-svn-dcommit-concurrent.sh
>> @@ -92,7 +92,7 @@ test_expect_success 'check if post-commit hook creates a concurrent commit' '
>>               echo 1 >> file &&
>>               svn_cmd commit -m "changing file" &&
>>               svn_cmd up &&
>> -             test_must_fail test_cmp auto_updated_file au_file_saved
>> +             ! test_cmp auto_updated_file au_file_saved
>>       )
>>  '
>
> This one looked complicated, so I leave it as an exercise for the
> reader. :)

eh, I was hoping to not stirr up a controversy, but treating this as a
drive-by patch "making the tests a better place, one tiny step at a time".

Thanks,
Stefan

>
> -Peff
