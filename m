Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55805C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbiFONVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiFONVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:21:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94173A5EE
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:21:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t21so8098483qtw.11
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7SBrMX1LuTLcmishjzeMwxiz07zmAI5QwvEcGyRhfz4=;
        b=KpMt4X68rzsZvBjyZiK+e2dJuJhqi8xZ9ngTQDgJxdirWRwkFg9C90esSO8lwbLupB
         pBLeIiI2r7VxWA4LuEwAi7wQxOBnjOCmI3fY9dGR2X+H7z2+o+856mkCE6YXmRd4NL8b
         OX0LRxaqLDCG6J/9jxQIH+5haYzxHurZ5sTDKQuI85Mh3cfUs1ZmYLv4e0zcyuwR1XOk
         vB156Bc+fFcutzrmet45qcxRhVRI5vot3bkfGvPQOj7hfDCKoa6dPjfKUJP/M0qQNfhJ
         xbODa16CLMhwNSR7gTwFF7QcUZShTEvWnDJJPdZ4jKWUNsUDiwVlBt9BjprR5KHD4unr
         MOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7SBrMX1LuTLcmishjzeMwxiz07zmAI5QwvEcGyRhfz4=;
        b=h7O7A2vQUaqk+c1f10PR6yywUYUdG4vka9y6jUjJur/vJI9vG/MPvffVK9UfcvkOMG
         6NClgYqNmHIaPmpeJ3R/6QVjHidjrOdIiK9MTsakcu2PBu83pYMNIjQzsF+b2ebHTTFc
         zNdKmM4EI2cxxw9bNPtScO1r5+sdQ1TjnRy0XUFPkCgbUt/p91ip4VWFLBcJ6+OnJQcI
         p8Z0WEN/UfEJxwEM/yhEgZ6FoNdu0mcN3c1wSD5Og5v0on8LM/nSwC+C8g7bGNjAVqDJ
         RX2JKprjneu+YrOIc5fGky3joGbW3ayWpGrQlDvwWOkFdopcxrW+SLy6QfcF70xlG/Qi
         Ikqw==
X-Gm-Message-State: AOAM532qVRHYCNNkptOZYCl8dsse9jx8w3uXVlOa0Ud+BbMYhrZWkAkz
        1cioGPjlIYpqOv/o6TbPsosz
X-Google-Smtp-Source: ABdhPJzFeVT0j8nBooWgn7cXzQH6icdtYNotTOFbNo0iG9LeTTuPb2cC5tkO1wmuL0GWt/8YsXJmIQ==
X-Received: by 2002:a05:622a:14c7:b0:305:2464:85a2 with SMTP id u7-20020a05622a14c700b00305246485a2mr8759919qtx.401.1655299310039;
        Wed, 15 Jun 2022 06:21:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006a79f9d6521sm6798734qkp.74.2022.06.15.06.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:21:49 -0700 (PDT)
Message-ID: <604c694e-7b8f-40bd-c8da-93b00dfe3541@github.com>
Date:   Wed, 15 Jun 2022 09:21:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: Git Test Coverage Report for v2.37.0-rc0
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Neeraj Singh <nksingh85@gmail.com>
References: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
 <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
 <220615.86mteexls9.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220615.86mteexls9.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/22 6:16 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jun 14 2022, Derrick Stolee wrote:
> 
> Neat, thanks! Re git-test-coverage: Maybe it's covered somewhere, but is
> there tooling to reproduce this somewhere? I.e. we have "make coverage"
> in tree, but not this "do the diff and blame on lines" step, unless I've
> missed it somewhere...

There is a script at contrib/coverage-diff.sh, but I then created a
separate project [1] that I could iterate on more quickly for new
formats (like the commit-grouped output you see here).

I was running builds on Azure Pipelines [2], but they started failing
a couple years ago (I think because of timeouts, but maybe also because
of failures in 'seen'). I tried resurrecting them recently, but failed.
So, I just ran this locally on my own machine.

[1] https://github.com/derrickstolee/git-test-coverage
[2] https://dev.azure.com/git/git/_build?definitionId=12

>>> Ævar Arnfjörð Bjarmason	fd3aaf53 run-command: add an "ungroup" option to run_process_parallel()
>>> run-command.c
>>> fd3aaf53 1645) code = pp->start_failure(pp->ungroup ? NULL :
>>> fd3aaf53 1646)  &pp->children[i].err,
>>> fd3aaf53 1649) if (!pp->ungroup) {
>>> fd3aaf53 1650) strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>>> fd3aaf53 1651) strbuf_reset(&pp->children[i].err);
>>
>> This change seems sufficiently complicated that it would be good to look
>> into the test coverage here. It's possible that it is covered by the
>> GIT_TEST_* variables that I didn't use when generating my test coverage.
> 
> We should definitely have test coverage for these, but FWIW it's all
> pre-existing-not-tested code.

Yes, I agree that we should not hold up new changes just because old
code isn't tested properly. It is worth considering whether we can
add tests easily _or_ if we should just give the new code another look.

> I.e. this has presumably been untested as far back as c553c72eed6
> (run-command: add an asynchronous parallel child processor,
> 2015-12-15). It's just:
> 
> 	if (start_command(&pp->children[i].process))
>         	/* this whole thing is untested, as no "start command" fails */
> 
> There's probably no easy way to automate this, but for significant bonus
> points I think a script like this would be much more useful if once it
> identifies given commit:line pairs it would check out $that_commit^, run
> "make coverage" again, see how pre-image faired (presumably --word-diff
> would associate them), and post that diff on top. 

I think it's worth pointing out which lines are changing untested
code.

Two core principles in "Working Effectively with Legacy Code" by
Michael Feathers [3] are:

1. Untested code is legacy code.
2. Add tests before changing legacy code.

[3] https://www.oreilly.com/library/view/working-effectively-with/0131177052/

The point of this report is to see how well we are fitting with those
principles, but also to take a pragmatic approach to deciding whether
new tests are worth the effort.

> I see in this case it's as easy as tweaking t0061-run-command.sh to do:
> 
>     test-tool run-command run-command-parallel 5 this-command-does-not-exist
> 
> I.e. we just don't stress that failure path, but should.
> 
> I'm planning to submit a cleanup series for the "ungroup" feature,
> i.e. the API is weird because we were trying to come up with a minimal
> regression fix. I'll make sure to include tests for this scenario in
> that series. Thanks!

Thank you!

It might also be worth pointing out that the 'coverage-test' build
disables threading due to colliding in the *.gcov output. That leads
to untested code that is actually tested by the "real" test suite.

-Stolee
