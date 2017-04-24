Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7582B1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 08:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166636AbdDXIUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 04:20:36 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36975 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166563AbdDXIUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 04:20:33 -0400
Received: by mail-it0-f54.google.com with SMTP id x188so43547610itb.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=//+g4Ne41hWSiRknFPrWDWNT+eoHH310R/7HqYQRi/A=;
        b=IcMlFCu8oisdYl43VKKevyH9ARvuaKW1xPJy8KHqLoZ4aCHpPNpfdmF5+vM5SngZLT
         s9s4H26CtAOgNfTalYLMcwnR7osb5IhltZsa5gLndJbz6JBEnIlrl0F6by2dspcQ8zT8
         8ugK7cK81jzV9Dem53z6mJ5UAwcC7O6EoSAPd6wOMDZD06Oji8rSLgN9qGwiGkZpo0zs
         /YLFcrA8JUi9Sg3nP42PQvcdxGu/fcIyuVIMvrUA2CNIpylYSDwwaFPk8oiJgSFyD0E/
         cdM/ZTqa0X+hSMt2Nm9yIXEQtkDjvIVhMP9f8rWIfaaYSnOwy/On6uB8QO+EIXYggXya
         /gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=//+g4Ne41hWSiRknFPrWDWNT+eoHH310R/7HqYQRi/A=;
        b=FV31ms2OVKywk1vkagP6NPuyuywu+x5+/0eHH+X01fAFsNyUOVG3sNGpz6/oXZR+qX
         0r4D6Zocd9+x+AEmH7lfOqUkI4aF+tgg8/2GASIoy7w9wuTXXVnOZ0yZNu97aRQWyusC
         ZDXAbUHg+YBpFiTxrLUFgR0QUc2SzxEJVLe35Hh7sb2UWG8UrY2Py7e3VGl7bUWEE1Iq
         1A5C9DypFgOylcOjLIuuxLL8s3wrmxBS0Vj7+dQY+n+XeCCY0NECIM1+QQQIlApJUttD
         5LsaEBhmii0JybviO7HQIRMrK7JWQ9Fgr47kYhWO45cuXMPhI4PVv8wYxFqHA36hlFmV
         gonw==
X-Gm-Message-State: AN3rC/4cCutxDssuUWEhHVFYRdJPxNgTr3dzR1Nr3KH8f+KD5Eqdlbvi
        /QM7XMYW6YUgPCK6k4ep68Y9ljLlGQ==
X-Received: by 10.36.43.77 with SMTP id h74mr12676301ita.60.1493021916464;
 Mon, 24 Apr 2017 01:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 24 Apr 2017 01:18:15 -0700 (PDT)
In-Reply-To: <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
References: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
 <20170421185757.28978-1-avarab@gmail.com> <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 24 Apr 2017 10:18:15 +0200
Message-ID: <CACBZZX63VQK4fLSB2T8onXJ_hQE8dkOCAyFFM-C_yOfoMwxLMA@mail.gmail.com>
Subject: Re: [PATCH] tests: fix tests broken under GETTEXT_POISON=YesPlease
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 3:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The GETTEXT_POISON=3DYesPlease compile-time testing option added in my
>> bb946bba76 ("i18n: add GETTEXT_POISON to simulate unfriendly
>> translator", 2011-02-22) has been slowly bitrotting as strings have
>> been marked for translation, and new tests have been added without
>> running it.
>>
>> I brought this up on the list ("[BUG] test suite broken with
>> GETTEXT_POISON=3DYesPlease", [1]) asking whether this mode was useful at
>> all anymore. At least one person occasionally uses it, and Lars
>> Schneider offered to change one of the the Travis builds to run in
>> this mode, so fix up the failing ones.
>>
>> My test setup runs most of the tests, with the notable exception of
>> skipping all the p4 tests, so it's possible that there's still some
>> lurking regressions I haven't fixed.
>>
>> 1. <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=3D6+UnyeMpg8+Q@mail.gmail.com=
>
>
> To be honest, I feel quite uneasy about this patch.  It is no
> brainer to take fixes like the one to 1309 where we used grep on a
> localizable string to use test_i18ngrep instead---they are obviously
> good changes.
>
> But changes that skip tests with !GETTEXT_POISON look suspicious.
>
>> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
>> index 8937e25e49..2003ec7907 100755
>> --- a/t/t1430-bad-ref-name.sh
>> +++ b/t/t1430-bad-ref-name.sh
>> @@ -122,7 +122,7 @@ test_expect_success 'push cannot create a badly name=
d ref' '
>>       ! grep -e "broken\.\.\.ref" output
>>  '
>>
>> -test_expect_failure 'push --mirror can delete badly named ref' '
>> +test_expect_failure !GETTEXT_POISON 'push --mirror can delete badly nam=
ed ref' '
>>       top=3D$(pwd) &&
>>       git init src &&
>>       git init dest &&
>
> This test affects only src and dest repositories that does not seem
> to be looked at by later tests, so skipping it is presumably safe.
>
> I am guessing that the reason why this is skipped is because the
> error message is looked at with "! grep ", not "grep", but by
> skipping the entire test, we are not checking that "push" succeeds
> (which should happen regardless of the locale).
>
> It also is VERY curious that the test before this one (whose tail is
> visible in the pre-context) does not need to be skipped.  Is that
> because we can expect "broken...ref", which is litrally a part of a
> refname, would be emitted intact in any locale (including the
> poisoned one)?  If that is the case it is curous why this one needs
> to be skipped.

This turns out to just be a mistake of mine that didn't need
!GETTEXT_POISON at all. Are you OK with fixing that up, or do you want
a v2 due to comments below...?

>> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
>> index 5778c0afe1..a428ae6703 100755
>> --- a/t/t3203-branch-output.sh
>> +++ b/t/t3203-branch-output.sh
>> @@ -236,7 +236,7 @@ test_expect_success 'git branch --format option' '
>>       Refname is refs/heads/ref-to-remote
>>       EOF
>>       git branch --format=3D"Refname is %(refname)" >actual &&
>> -     test_cmp expect actual
>> +     test_i18ncmp expect actual
>>  '
>
> This is a strange change.  Filling the placeholder in a format
> string "Refname is %(refname)" should be affeced by i18n???

It's because %(refname) itself will get i18n'd:

    -Refname is (HEAD detached from fromtag)
    +Refname is # GETTEXT POISON #

See c8183cd285 ("branch: show more information when HEAD is detached",
2013-03-13).

>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
>> index 33d392ba11..e07d6d8cd2 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -366,7 +366,7 @@ test_expect_success 'verbose flag is heeded, even af=
ter --
>> ...
>> -test_expect_success 'multi-squash only fires up editor once' '
>> +test_expect_success !GETTEXT_POISON 'multi-squash only fires up editor =
once' '
>>       base=3D$(git rev-parse HEAD~4) &&
>>       set_fake_editor &&
>>       FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"1 squash 2 squash 3 squas=
h 4" \
>
> This is also curious.  Is this because the poison locale does not substit=
ute
> anything passed to format template and literal strings like ONCE and
> the instructions do not reach the edited file?

I don't know the root cause for why that fails, I spent some time
re-digging into that for ~10m and didn't come up with anything.

We've marked many of these rebase messages in the past, it's usually
some stray newline being needed which the poison machinery didn't emit
or something like that.

My general approach when writing & maintaining this poison has been
that it's fine if we skip some tests, even though we could be bending
over backwards to run them, or even if we don't know the root cause
beyond "the rebase machinery is always broken with poison".

This is because once I'm satisfied that the breaking test isn't
because of some new plumbing message that got i18n'd I don't see the
point of keeping digging, it's fine to just skip the test, because we
run it when we're not under poison, and we're satisfied that it's not
breaking because of a new plumbing message being i18n'd we've
fulfilled the entire reason for why this poison facility exists in the
first place.

>  (skipping many changes, not because I find nothing to comment on them)
>
>> diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
>> index 37143ea0ac..2ed479b712 100755
>> --- a/t/t5316-pack-delta-depth.sh
>> +++ b/t/t5316-pack-delta-depth.sh
>> @@ -82,12 +82,16 @@ test_expect_success 'packing produces a long delta' =
'
>>       # Use --window=3D0 to make sure we are seeing reused deltas,
>>       # not computing a new long chain.
>>       pack=3D$(git pack-objects --all --window=3D0 </dev/null pack) &&
>> -     test 9 =3D "$(max_chain pack-$pack.pack)"
>> +     echo 9 >expect &&
>> +     max_chain pack-$pack.pack >actual &&
>> +     test_i18ncmp expect actual
>>  '
>
> This is also curious.  Why do we needto protect comparision with a
> line whose contents is '9' from poison locale?  If the last one were
> test_cmp I think this is a good change, by the way.
>
>>  test_expect_success '--depth limits depth' '
>>       pack=3D$(git pack-objects --all --depth=3D5 </dev/null pack) &&
>> -     test 5 =3D "$(max_chain pack-$pack.pack)"
>> +     echo 5 >expect &&
>> +     max_chain pack-$pack.pack >actual &&
>> +     test_i18ncmp expect actual
>>  '

The 9/5 value here is the number of lines that match /chain length/ as
determined my max_chain, that message is i18n'd.
