Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DFF201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 18:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754931AbdBVSot (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 13:44:49 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:35713 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754651AbdBVSoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 13:44:34 -0500
Received: by mail-it0-f50.google.com with SMTP id 203so146249987ith.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OsCX09Lgcc5t4JqNbjFqCZXIiwRKWLjw2O/tyLG96dU=;
        b=B9aZPAhwTAV9tcelGQXQ1zwRyjMdPSLYbErqGRFj9q0BY2fMILioFqSO5dDBgFj8w+
         w36wPR19jpYKWVKCGOoDB9AKyGkvxEMmqxp7fwP6IGfr24eMvofuEb3XjeTKXyiSnhKB
         SgPu0kkNACwg2JZO9GGoYKvKzwsJHj7ERNL8EQ5+VgrNWeQ/WM08HbGOGnJJCq2IEdwm
         kXnVDTwU+MtHbV1dwg6UhovXFBMmAI6vse7LQEf7b/vpxyJABYUsUhHs2TTV85VaNiff
         MltgN0sR3YECgGdeV8gSo2b6dOwWcXsp25A42BGhx/GztBiaYWXGUwquxWlMcQJ8eUQX
         V2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OsCX09Lgcc5t4JqNbjFqCZXIiwRKWLjw2O/tyLG96dU=;
        b=ppd/5ytV9iVcM0h51u4ZnKV49iwYU1hpauVoZAIrxovDKNoTn/Tv1xfQx0ZW0E8/fB
         KHaxbmqeXKyDpp/PXjXHCIWthazCqWH44OYacx5YkhogkHkSqd9p0LLmE4T11e6wbzpS
         9ZTtAeYWdfyWWGbG54Y93wtpez6H6cvEJb8xkbeWRMzFvfmOTpYXys8+qiEYH8Axpesx
         Chyp8fTWsWu67YaNU/Qub4+iWTrghbpJspE/vzQUO8zNlXqJEBsiQQ7MdougBRrtU3Gh
         OI1Sq6UWXW7714ao0S9W59oECW/sJ3UTmZIm5YJAW/x4g2JVx1lgFakX94QqeW8fsQE3
         z0sw==
X-Gm-Message-State: AMke39kOzOIJ7unW8/EICMmFDfV7X3d0jdtF30kTA3CIqZbcU+ecbi0vfE35kvwHNVhpTxMfJZf+PQJKve6NZyuZ
X-Received: by 10.107.16.14 with SMTP id y14mr24226960ioi.164.1487789037393;
 Wed, 22 Feb 2017 10:43:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 22 Feb 2017 10:43:56 -0800 (PST)
In-Reply-To: <xmqqlgt5x430.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-4-sbeller@google.com> <xmqqlgt5x430.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Feb 2017 10:43:56 -0800
Message-ID: <CAGZ79kYhT4ikj2pfDJM_PQsh5XzGTVT2kByiE1moK8RUcusLcA@mail.gmail.com>
Subject: Re: [PATCH 03/15] lib-submodule-update.sh: define tests for recursing
 into submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Currently lib-submodule-update.sh provides 2 functions
>> test_submodule_switch and test_submodule_forced_switch that are used by a
>> variety of tests to ensure that submodules behave as expected. The current
>> expected behavior is that submodules are not touched at all (see
>> 42639d2317a for the exact setup).
>>
>> In the future we want to teach all these commands to properly recurse
>> into submodules. To do that, we'll add two testing functions to
>> submodule-update-lib.sh test_submodule_switch_recursing and
>> test_submodule_forced_switch_recursing.
>
> I'd remove "properly" and insert a colon after "add two ... to
> submodule-update-lib.sh" before the names of two functions.

ok

>
>> +reset_work_tree_to_interested () {
>> +     reset_work_tree_to $1 &&
>> +     # indicate we are interested in the submodule:
>> +     git -C submodule_update config submodule.sub1.url "bogus" &&
>> +     # also have it available:
>> +     if ! test -d submodule_update/.git/modules/sub1
>> +     then
>> +             mkdir submodule_update/.git/modules &&
>
> Would we want "mkdir -p" here to be safe?

Yes I cannot think of a downside of being overly cautious here.

>
>> +             cp -r submodule_update_repo/.git/modules/sub1 submodule_update/.git/modules/sub1
>
> ... ahh, wouldn't matter that much, we checked that modules/sub1
> does not exist, and as long as nobody creates modules/ or modules/somethingelse
> we are OK.

Well, I'll add the -p

>> +# Test that submodule contents are correctly updated when switching
>> +# between commits that change a submodule.
>> +# Test that the following transitions are correctly handled:
>> +# (These tests are also above in the case where we expect no change
>> +#  in the submodule)
>> +# - Updated submodule
>> +# - New submodule
>> +# - Removed submodule
>> +# - Directory containing tracked files replaced by submodule
>> +# - Submodule replaced by tracked files in directory
>> +# - Submodule replaced by tracked file with the same name
>> +# - tracked file replaced by submodule
>
> These should work without trouble only when the paths involved in
> the operation in the working tree are clean, right?  Just double
> checking.  If they are dirty we should expect a failure, instead of
> silent loss of information.

yes, I'll go over the tests again and add those cases if missing.


>> +     command="$1"
>
> The dq-pair is not strictly needed on the RHS of the assignment, but
> it is a good way to signal that we considered that we might receive
> an argument with $IFS in it...
>
>> +                     $command add_sub1 &&
>
> ... and after doing so, not quoting $command here signals that we
> expect command line splitting to happen.  Am I reading it correctly?
> Without an actual caller appearing in this step, it is rather hard
> to judge.
>

I followed the existing code without thinking about these points, but they are
valid and exactly how we'd expect the code to behave.
$1 / $command will be e.g. "git checkout --recurse-submodules" in
this patch series; but later on we could also have functions.
C.f.  t4137 which defines a function

    apply_3way () {
        git diff --ignore-submodules=dirty "..$1" | git apply --3way -
    }
    test_submodule_switch "apply_3way"

We'd want to have a similar thing for the recursing part, e.g.

    apply_3way_recursing () {
        git diff --submodule=diff "..$1" | git apply
--recurse-submodules --3way -
    }
    test_submodule_switch_recursing "apply_3way_recursing"

>> +                     echo sub1 > .git/info/exclude
>
>     ">.git/info/exclude"

ok
