Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D0ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 23:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIAXt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAXt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 19:49:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867B65A7
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 16:49:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so310227pfl.8
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 16:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=O1LIB5v/vOGPyMRznLnBw9flmoCThN6XQtv8VzWaQr4=;
        b=jPc1mY8p05twylDOcMObTkh1L1cCLYc5HIeJM2eZ1OGYbjfDOHTYwg+PKjzCDyL8KH
         D/O9Oy35V9lELbH3WsQ/9/JDhQhN9E29DOopb9Uu/bnAZywL59LuKXDZuIae8okL1ezp
         4PyrMskKyDHYRTQTta2bsXbWc9rXYsgQ1yV33Lg4071JgcA78dlo/womPqi9BXUhT3Q0
         b1HkW0vg5fPGeh5MuQ1ah7C1PNdTJrvNhMEpLP0CvTlI02a6UHTkBvt42Hi7OeD/vIb2
         S9BECpUWNt99UKCltNXoeIr7OmfVV554V3/npdNiB+bBZYxiaogBC+t1FoP3klGLjDNy
         f1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=O1LIB5v/vOGPyMRznLnBw9flmoCThN6XQtv8VzWaQr4=;
        b=cCVfoWtsVr/RE75G8hgZIjubivRlybSF2UQaA7Zz1XCq7Y+8e0ndXZ/KQo1CmiKA0h
         bv92OZl2hq9bzCkMod9rp+btSpSBrR5zMETsCWfiF9sAyr7REdNewJ0i3Zh3VcxMdlFp
         00M90R7kQEEC0kbvU2tbm+ro6Du9VI1UcDvW5jc1pBGoZnvuEDxj1o7sbngX9IZKzsSg
         vf6NmG5Qxw0TDIX5vSCVrsizhys82YkSgS1MwHSMZnB2+GhRkRgGf/y5/1Ctc1K3abNk
         5kq3ffZoNH/ni903W41qiOE6VlnhvnZLTVEX6Y4jFR5gesuA59NOE8bQOnmNhQOfgtQF
         gMXQ==
X-Gm-Message-State: ACgBeo3joPwUOnaoGH6SnPGsCv2eFM3aw1W1Ra7vO7H9d2KSJhiYh+oR
        q6aiWS1+7Bj+PL6oI0ns+PIT
X-Google-Smtp-Source: AA6agR5O9N7nuw9Rwjc96dMM7P/AfyioK/FooMdchGS070ApPuk8L6X1AeZGXEKYW4vrAgGvrOoa+g==
X-Received: by 2002:a63:5c59:0:b0:42b:cf82:ec47 with SMTP id n25-20020a635c59000000b0042bcf82ec47mr22238705pgm.471.1662076195039;
        Thu, 01 Sep 2022 16:49:55 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm169564pfm.159.2022.09.01.16.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 16:49:54 -0700 (PDT)
Message-ID: <23e8901f-b543-dbb5-c7e1-fa653fdf3d57@github.com>
Date:   Thu, 1 Sep 2022 16:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 5/8] scalar-clone: add test coverage
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <a3b7cb0a3bd1f56172db8420b9e80a26be1fda5d.1661961746.git.gitgitgadget@gmail.com>
 <o429p430-sp18-rr20-p2ro-4r60qs2n83o5@tzk.qr>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <o429p430-sp18-rr20-p2ro-4r60qs2n83o5@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> Hi Victoria,
> 
> On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Create a new test file ('t9211-scalar-clone.sh') to exercise the options and
>> behavior of the 'scalar clone' command.
> 
> Great catch!
> 
> I have one suggestion, given my experience with debugging test failures:
> 
>> +test_expect_success 'creates content in enlistment root' '
>> +	test_when_finished cleanup_clone cloned &&
>> +
>> +	scalar clone "file://$(pwd)/to-clone" cloned &&
> 
> This pattern of cloning into `cloned` and removing the directory when the
> test case is done is repeated throughout this test script.
> 
> In instances where all test cases succeed, that poses no problem.
> 
> When running the test script with `-i`, also no problem.
> 
> But when we run into test failures in CI, those directories will be
> removed before the workflow run can tar them up and upload them for later
> inspection.
> 
> May I suggest an alternative strategy?
> 
> If we drop all those `test_when_finished cleanup_clone cloned` calls and
> instead `scalar clone` into different directories (whose names reflect the
> test cases' intended purpose), I could imagine having a much easier time
> not only diagnosing but also reproducing and fixing test failures in the
> future.

While I like the simplicity of using 'test_when_finished', I hadn't
considered the value of having the failed tests' artifacts in the CI
results. If you think that would be helpful to developers, I'll update
accordingly (although I'd still clean up the clones whose tests pass to
avoid archiving more data than we need).

That being said, even if I update 't9211', my experience with Git's test
suite is that very few tests preserve test repos this way. Do you expect
these artifacts to be especially helpful for 'scalar clone' in particular,
or is this more of a "gently nudge contributors to make this standard
practice" sort of recommendation? 

> 
> When discussing code review practices [*1*], we did not come up with any
> standard terminology to describe what I am offering here, and I am unsure
> how to label this in a catchy way. I want to present this suggestion for
> you to consider, and I would be delighted if you take it, at the same time
> I will happily let it go should you decide against it.
> 
> Ciao,
> Dscho
> 
> Footnote *1*:
> https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-08-29#l48

