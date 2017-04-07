Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9199820966
	for <e@80x24.org>; Fri,  7 Apr 2017 16:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756250AbdDGQSZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 12:18:25 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35908 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbdDGQSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 12:18:23 -0400
Received: by mail-lf0-f54.google.com with SMTP id s141so9124735lfe.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mI3x3X40Ys0JBdcx3W8raV5Hx2/bpam0xwD/3X9reW0=;
        b=rqiBedWJQ0d/Dqj5IlJspdFzPzQSlvAEM4s2TirjGY/Qfob//Wg9JjpK+dzTlD2e4+
         AC+OUwXryFB+rQuTFbsMM/db5rNJYQzqGj0TVgAtgCSOo9TdJkfIMG15u3E6bLmAKa30
         mlyN5m7bVar1MwvGXCqnlmraU6kMSi/icLsrwJp2y4z2udJS5QXtxDlAncZGlYvDaxAt
         0Em2ukZGXW/jhO/tZ5G0PWzPs2RzP3qeKivUJ5LCEaZXovKH0mQc366I/2lhvqIUlrH7
         h9QWuP8owlftHM3d6wPM9JAo6mLHve1n9UIBc7tBB1Haf1kScHlpQ7A4i86achP1YZvs
         vWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mI3x3X40Ys0JBdcx3W8raV5Hx2/bpam0xwD/3X9reW0=;
        b=Cd5pxULH7bnADa0TRPu+adUIqg7csolvV5I3PL2pJWGPDAPJag5OYbGygJJwjRQzAE
         lDdYtriH0Vfy4Aw66m6gTqTdnI16wiWjilt7WdsCE3qD0poaZyssNOkQcMUOAdQneGSg
         S0V7ktF0IMdrojes1nrK8/CADYDwJovFdvnlGUilrlfnYQoaIwhMfMHclhyMwYktGQAn
         0lxpvejpk3NFgh1UbP5U4bze+5k6yZIAdOegfL49/M8povXCmrw4yhw1rwp67B3Of7Nz
         XjRuVPeY6V+gG5DdP1VFwblU96QQ5uGuVQQucl1jtPkuzT/iyFO85x4/pLZJwKbTWyOC
         0ukw==
X-Gm-Message-State: AFeK/H2R203WysPAaCua1Q0syX2WuoKKTb+3ITtZtzrzDDEccmgvnHjlxHlZpSGMmanu8mi0LHRWTrtY6hCAuA==
X-Received: by 10.46.81.25 with SMTP id f25mr10759604ljb.119.1491581901816;
 Fri, 07 Apr 2017 09:18:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Fri, 7 Apr 2017 09:18:01 -0700 (PDT)
In-Reply-To: <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
 <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 7 Apr 2017 09:18:01 -0700
Message-ID: <CA+P7+xr37owZbCnwVKh0y_vUny9_pP380Y8sFA+7A-hv0Oc6AA@mail.gmail.com>
Subject: Re: [PATCH] status: show in-progress info for short status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 11:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@grubix.eu> writes:
>
>> Ordinary (long) status shows information about bisect, revert, am,
>> rebase, cherry-pick in progress, and so does git-prompt.sh. status
>> --short currently shows none of this information.
>>
>> Introduce an `--inprogress` argument to git status so that, when used with
>> `--short --branch`, in-progress information is shown next to the branch
>> information. Just like `--branch`, this comes with a config option.
>>
>> The wording for the in-progress information is taken over from
>> git-prompt.sh.
>>
>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>
> I haven't formed an opinion on the feature itself, or the way it is
> triggered, so I won't comment on them.  I just say --porcelain (any
> version) may (or may not) want to be extended in backward compatible
> way (but again I haven't formed an opinion on the issue--I just know
> and say there is an issue there that needs to be considered at this
> point).
>

Personally, I would want this to become the default and not have a new
option to trigger it. I think we could also extend the porcelain
format to include this information as well, but I'm not too familiar
with how the v2 format extends or not.

Thanks,
Jake

>> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
>> index 458608cc1e..103e006249 100755
>> --- a/t/t7512-status-help.sh
>> +++ b/t/t7512-status-help.sh
>> @@ -74,7 +74,6 @@ test_expect_success 'prepare for rebase conflicts' '
>>
>>
>>  test_expect_success 'status when rebase in progress before resolving conflicts' '
>> -     test_when_finished "git rebase --abort" &&
>>       ONTO=$(git rev-parse --short HEAD^^) &&
>>       test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>>       cat >expected <<EOF &&
>> @@ -96,6 +95,15 @@ EOF
>>       test_i18ncmp expected actual
>>  '
>>
>> +test_expect_success 'short status when rebase in progress' '
>> +     test_when_finished "git rebase --abort" &&
>> +     cat >expected <<EOF &&
>> +## HEAD (no branch); REBASE-m
>> +UU main.txt
>> +EOF
>> +     git status --untracked-files=no --short --branch --inprogress >actual &&
>> +     test_i18ncmp expected actual
>> +'
>
> This is not a good way to structure the test.  If the one in the
> previous hunk is what creates a conflicted state by running
> "rebase", check the status output from within that test, after the
> conflicting "rebase" fails and other things the existing test checks
> are tested.  That way, you do not have to worry about this new check
> getting confused if the previous one fails in the middle.
>
> Likewise for the most (if not all---I didn't check very carefully)
> of the remaining hunks in this test script.
