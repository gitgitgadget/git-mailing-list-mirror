Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4BA1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbeIUU3o (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 16:29:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36547 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbeIUU3o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 16:29:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so10943018edq.3
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OOySZYr1Hz2L0r98jPxU032qtwEcWTS5PmtvMYbBXx0=;
        b=WVFRDwdX/kJRotc7wMD9HoTMeNnjttTSHJamRXccCLTdWM39hz9PtOZul8pjQ2SPic
         ltDFoET4m+YXLpLIzPvd1InpNCzOgZGQI9Atl35DZyZr9Lt1WcuYZCBcRN7VhaO1bF9L
         EaU7v97u/OoOHi6uTuHYj8MlzfYL1JjeQGkD9wFxJzBGOnQXNjkVStkvmIm48bysuUUy
         2Xj/S5Kj6/A9hcBPMXFLLGKZtcpor2t3t030OS/KW7InCwDGUgBsblY3GQoNOol84NlO
         IJY3LfPoCsUntXzewLn3aTS/j1ZJReS8I32OUr+008W6pYR4FakO+oe8wtonME+TmJB5
         8cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OOySZYr1Hz2L0r98jPxU032qtwEcWTS5PmtvMYbBXx0=;
        b=pydTuDzEqVvd9SGwv0XPUzLySpnC3ChmW5M503nbxSeKU/ehtKv/hG9w9jgLcI6Mvo
         uvUIQ+Dp1tOxbgyMo036Ouyw56q0fUeU1VNQBQgqJMbay7KDpBbC8HSof0dOfzEYC869
         fA9kl/1fIGUrWo34Jn6Lceon7uIQiLfbeGOnTNcZgDTCOL6HfiF+dhxiqZVR47MiFH71
         FQwmm77IGWU5KTsAi8AML9WOWMPFPEtFPDQWyxQOjZ7N426z4xvhmtIn46JgVKKWEKbP
         TSbWklnhzx1vtxRtlh674IBXBP58R6vC1RHWEclR36OOeWx+n4GmlVIduxKc7QFFxMKt
         ZWhQ==
X-Gm-Message-State: APzg51DhDRmTsEc5R5yXzA8X4MqRTqxojBaZizuNS8WrhZ2TXIhJIrTD
        4hUTANxIdeDoVXpf97QmpZU=
X-Google-Smtp-Source: ANB0VdZGeEpizZ7N85VVxhDBEi5/Rmmc8xc2xWv1Lv/EHfMwBlwlWty+ylihDKltVR572QxCNufLsA==
X-Received: by 2002:a50:c40e:: with SMTP id v14-v6mr6134856edf.232.1537540832253;
        Fri, 21 Sep 2018 07:40:32 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id w38-v6sm779071edm.9.2018.09.21.07.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 07:40:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Segfault in master due to 4fbcca4eff
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com> <87pnx6kjn8.fsf@evledraar.gmail.com> <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com>
Date:   Fri, 21 Sep 2018 16:40:30 +0200
Message-ID: <87o9cqkj6p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 21 2018, Derrick Stolee wrote:

> On 9/21/2018 10:30 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Sep 21 2018, Junio C Hamano wrote:
>>
>>> * ds/reachable (2018-08-28) 19 commits
>>>    (merged to 'next' on 2018-08-28 at b1634b371d)
>>>   + commit-reach: correct accidental #include of C file
>>>    (merged to 'next' on 2018-08-22 at 17f3275afb)
>>>   + commit-reach: use can_all_from_reach
>>>   + commit-reach: make can_all_from_reach... linear
>>>   + commit-reach: replace ref_newer logic
>>>   + test-reach: test commit_contains
>>>   + test-reach: test can_all_from_reach_with_flags
>>>   + test-reach: test reduce_heads
>>>   + test-reach: test get_merge_bases_many
>>>   + test-reach: test is_descendant_of
>>>   + test-reach: test in_merge_bases
>>>   + test-reach: create new test tool for ref_newer
>>>   + commit-reach: move can_all_from_reach_with_flags
>>>   + upload-pack: generalize commit date cutoff
>>>   + upload-pack: refactor ok_to_give_up()
>>>   + upload-pack: make reachable() more generic
>>>   + commit-reach: move commit_contains from ref-filter
>>>   + commit-reach: move ref_newer from remote.c
>>>   + commit.h: remove method declarations
>>>   + commit-reach: move walk methods from commit.c
>>>
>>>   The code for computing history reachability has been shuffled,
>>>   obtained a bunch of new tests to cover them, and then being
>>>   improved.
>> There's a segfault now in master when fetching because of 4fbcca4eff
>> ("commit-reach: make can_all_from_reach... linear", 2018-07-20). I have
>> not had time to debug this, or found an easy isolated test case, but
>> this script will reliably make it segfault for me:
>>
>>      #!/bin/sh
>>
>>      git_dot_git=/home/avar/g/git
>>
>>      old=v0.99
>>      new=v0.99.1
>>
>>      rm -rf /tmp/srv
>>      rm -rf /tmp/cln
>>      git init --bare /tmp/srv
>>      git init --bare /tmp/cln
>>      $git_dot_git/git --exec-path=$git_dot_git push file:///tmp/srv $old:refs/whatever/ref
>>      $git_dot_git/git --exec-path=$git_dot_git -C /tmp/cln fetch file:///tmp/srv 'refs/*:refs/*'
>>      $git_dot_git/git --exec-path=$git_dot_git push file:///tmp/srv $new:refs/whatever/ref
>>      if GIT_TRACE=1 $git_dot_git/git --exec-path=$git_dot_git -C /tmp/cln fetch file:///tmp/srv 'refs/*:refs/*'
>>      then
>>          exit 0
>>      else
>>          exit 1
>>      fi
>>
>> I.e. you need to push the v0.99 tag to its own repo, fetch that from
>> another one, then push v0.99.1, fetch everything, and you'll get a
>> segfault:
>>
>>      remote: Resolving deltas: 100% (187/187), completed with 48 local objects.
>>      To file:///tmp/srv
>>         d6602ec519..f25a265a34  v0.99.1 -> refs/whatever/ref
>>      14:26:44.505787 git.c:415               trace: built-in: git fetch file:///tmp/srv 'refs/*:refs/*'
>>      14:26:44.506708 run-command.c:637       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; 'git-upload-pack '\''/tmp/srv'\'''
>>      14:26:44.508831 git.c:415               trace: built-in: git upload-pack /tmp/srv
>>      14:26:44.509953 run-command.c:637       trace: run_command: git rev-list --objects --stdin --not --all --quiet
>>      Segmentation fault
>>      fatal: The remote end hung up unexpectedly
>>
>> Same with refs/tags/ref b.t.w., not just refs/whatever/ref, I just was
>> initially testing this for some follow-up work on my series for checking
>> how fetching to various non-heads/tags namespaces works.
>
> This error was reported by Peff [1] and fixed in [2], but as stated
> [3] I was waiting for more review before sending a v3. I'll send that
> v3 shortly, responding to the feedback so far.
>
> -Stolee
>
> [1]
> https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u
>
> [2] https://public-inbox.org/git/pull.39.git.gitgitgadget@gmail.com/
>
> [3]
> https://public-inbox.org/git/8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com/

Thanks and sorry for the duplicate report. I can confirm that applying
the v2 of that fixes the segfault for the test case I posted.
