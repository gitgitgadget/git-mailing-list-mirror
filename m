Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529971F453
	for <e@80x24.org>; Fri, 21 Sep 2018 14:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbeIUUYD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 16:24:03 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44595 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeIUUYC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 16:24:02 -0400
Received: by mail-qt1-f175.google.com with SMTP id k38-v6so1891324qtk.11
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PITqEt+b9Uo6X8soxWF1K4FwQPVM4UTojbuXs91XiNw=;
        b=cpSALV9wPv7n2KwwB31dhH6d5X7WWGsc+fGArtkmFa6rDq5rCVh3Wt870Zhs1gnhK8
         9LEZVTVwbHmYAAZaO39SUqD/+ItDqqvCB0FE/U+zYbxgoeGetxX+HCgA0rbiAoQ9xpQc
         DVOxABHdqH+Y4AE9BSh/42lvQlGvmIu5qH+jY/yCVZj/3PDXBT0T5Z3lglUxdxdMMvPW
         p9iCc8fdN5+QvNw1IjPW+9Yr4jZltOs9gZDlJsjGugGV1Og/BwlShy3A2OSqe5AW6Q2H
         zD2oDXgjo/rcLD99MWNCNn3E/GzDb/Zgu8h5xOqctK/PJPnM+UjOCM8XqwDwJGBPL5pM
         tARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PITqEt+b9Uo6X8soxWF1K4FwQPVM4UTojbuXs91XiNw=;
        b=mEnMC+qmZwk20fR+PwK+hd0BCXaUeqb/p0gAEsMSKsP3p9WA2v2CQ3Kf1Zmv0iNggX
         hCRlS0DikJks61jIZAumcNArV6lC6wPvxznVT1JtYz0TKDxEXWJwJwNdptiV37V48SR7
         ql+UOy08VWoJs78WelXZ3rmligfW2Y3HyXDajitoJugik2TXLIIJmfoR6AZ9FMEkWcKh
         Caj1ZjbDYwloNyOJZfkvJlg8IgVemNztxv2f+MQZiDJxlpPZyWx6NOYqepBWpWd6Pkmp
         OTwUfTJgTvsMqjRcxv0vSKpA1v/RfoVZBFxFIjciY/sVNrJAEGh2I+Az+5OQUlY5G+ct
         Bd9g==
X-Gm-Message-State: APzg51DVwMRPvQihlweWrmJJRdLV9uyejU8/zPly562/BahZWJxrTLLd
        D6KYK5SEpAnpNmwjk9+hf6L0oPsx
X-Google-Smtp-Source: ANB0VdYxhOC2KNH6Sdi1TbEjjFKkmRM8Ls7PAcgWCt1WrieQSUiwsObwMct68VDmwieT+vaAVRYing==
X-Received: by 2002:a0c:ca8e:: with SMTP id a14-v6mr31656743qvk.44.1537540492366;
        Fri, 21 Sep 2018 07:34:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id d83-v6sm2924069qkj.24.2018.09.21.07.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 07:34:51 -0700 (PDT)
Subject: Re: Segfault in master due to 4fbcca4eff
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
 <87pnx6kjn8.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com>
Date:   Fri, 21 Sep 2018 10:34:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87pnx6kjn8.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 10:30 AM, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Sep 21 2018, Junio C Hamano wrote:
>
>> * ds/reachable (2018-08-28) 19 commits
>>    (merged to 'next' on 2018-08-28 at b1634b371d)
>>   + commit-reach: correct accidental #include of C file
>>    (merged to 'next' on 2018-08-22 at 17f3275afb)
>>   + commit-reach: use can_all_from_reach
>>   + commit-reach: make can_all_from_reach... linear
>>   + commit-reach: replace ref_newer logic
>>   + test-reach: test commit_contains
>>   + test-reach: test can_all_from_reach_with_flags
>>   + test-reach: test reduce_heads
>>   + test-reach: test get_merge_bases_many
>>   + test-reach: test is_descendant_of
>>   + test-reach: test in_merge_bases
>>   + test-reach: create new test tool for ref_newer
>>   + commit-reach: move can_all_from_reach_with_flags
>>   + upload-pack: generalize commit date cutoff
>>   + upload-pack: refactor ok_to_give_up()
>>   + upload-pack: make reachable() more generic
>>   + commit-reach: move commit_contains from ref-filter
>>   + commit-reach: move ref_newer from remote.c
>>   + commit.h: remove method declarations
>>   + commit-reach: move walk methods from commit.c
>>
>>   The code for computing history reachability has been shuffled,
>>   obtained a bunch of new tests to cover them, and then being
>>   improved.
> There's a segfault now in master when fetching because of 4fbcca4eff
> ("commit-reach: make can_all_from_reach... linear", 2018-07-20). I have
> not had time to debug this, or found an easy isolated test case, but
> this script will reliably make it segfault for me:
>
>      #!/bin/sh
>
>      git_dot_git=/home/avar/g/git
>
>      old=v0.99
>      new=v0.99.1
>
>      rm -rf /tmp/srv
>      rm -rf /tmp/cln
>      git init --bare /tmp/srv
>      git init --bare /tmp/cln
>      $git_dot_git/git --exec-path=$git_dot_git push file:///tmp/srv $old:refs/whatever/ref
>      $git_dot_git/git --exec-path=$git_dot_git -C /tmp/cln fetch file:///tmp/srv 'refs/*:refs/*'
>      $git_dot_git/git --exec-path=$git_dot_git push file:///tmp/srv $new:refs/whatever/ref
>      if GIT_TRACE=1 $git_dot_git/git --exec-path=$git_dot_git -C /tmp/cln fetch file:///tmp/srv 'refs/*:refs/*'
>      then
>          exit 0
>      else
>          exit 1
>      fi
>
> I.e. you need to push the v0.99 tag to its own repo, fetch that from
> another one, then push v0.99.1, fetch everything, and you'll get a
> segfault:
>
>      remote: Resolving deltas: 100% (187/187), completed with 48 local objects.
>      To file:///tmp/srv
>         d6602ec519..f25a265a34  v0.99.1 -> refs/whatever/ref
>      14:26:44.505787 git.c:415               trace: built-in: git fetch file:///tmp/srv 'refs/*:refs/*'
>      14:26:44.506708 run-command.c:637       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; 'git-upload-pack '\''/tmp/srv'\'''
>      14:26:44.508831 git.c:415               trace: built-in: git upload-pack /tmp/srv
>      14:26:44.509953 run-command.c:637       trace: run_command: git rev-list --objects --stdin --not --all --quiet
>      Segmentation fault
>      fatal: The remote end hung up unexpectedly
>
> Same with refs/tags/ref b.t.w., not just refs/whatever/ref, I just was
> initially testing this for some follow-up work on my series for checking
> how fetching to various non-heads/tags namespaces works.

This error was reported by Peff [1] and fixed in [2], but as stated [3] 
I was waiting for more review before sending a v3. I'll send that v3 
shortly, responding to the feedback so far.

-Stolee

[1] 
https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u

[2] https://public-inbox.org/git/pull.39.git.gitgitgadget@gmail.com/

[3] 
https://public-inbox.org/git/8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com/

