Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B797C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiHPO1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiHPO1g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 10:27:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B849BB6B2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:27:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n7so1635919wrv.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=sd5lNC/gXuDJgSK2ix41E6HhjTvwotV87T9WL3xiW8s=;
        b=Xx5Dsx0DtVZq2m3MRzaeySuxsC7roR087H3TYJ152yVXJL3+JJqYvyZdATKzMvoAVS
         dEQypO5eOyW9QYIQaevJSGPv2vXXKh5Ju89lou+Qxvmro5Cfl/RvoJ6WzqyyKB9aglx2
         iwrEfNei/s0Gu12l/pE6Lt+aNx2aRERdatl2QVYe+5GtBWJ27ruBlTM304DOqpI5UtFm
         d3qi8RsUDQm7Xf7EAoYldjzRcJad+nMKHDTNZIF1x5kCfOmWOq3pvKiQ8qbHhEypWZT+
         vza0hgedVre63BvVsocsMdjR5lzfFGMT6tUGPQMLcnsCG1tQoyXJFuT/4vZ7XTEu2731
         J7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=sd5lNC/gXuDJgSK2ix41E6HhjTvwotV87T9WL3xiW8s=;
        b=mg9zIE3mXmgshkeic4OzxLq70jcaW3vHWHpEos4nWGcycupvn16hopVVr7/dJ0hcvK
         QTVg8jHhpiDBCe3ix1r3o/zGxLmnGUQXOTL8Mxuz/WXOT2pO0rsNsDCz/c+AiN+nUzX5
         nhgxohknkss8d9EqYwtGDD4niMJmIRND4RL58cMl9mmLP/21JUG5Qe9zI6kLxXq5aj07
         lTmmhx3WZGJ2vNdKhgMRb+KZCOBcCxPRIcXavdvhdhy3CD0KwaYnG3UbmKir1kjuAbxd
         qm8kp87bsvd1p2D50HNy1DRAGnPR65Xz52zJsgGKlFtS4dQsYt4CYv7BlRJ5YI05E95D
         jObQ==
X-Gm-Message-State: ACgBeo3h+pwkULk7VQ2bpcLjBgeUlCIefZJyAq9gzmwFvd5HgKGn8ph9
        j5Ifa9u1vNenv4AEGONuC5/dunpMMSg=
X-Google-Smtp-Source: AA6agR6zOblfDivOexK899Rw/ee4XhKTYl4XujFl9ywlhLpd6i+1nENH4kvHFAHW1ugmHfjKYW3xsA==
X-Received: by 2002:a05:6000:15c7:b0:222:ce5a:4b01 with SMTP id y7-20020a05600015c700b00222ce5a4b01mr11529839wry.206.1660660053608;
        Tue, 16 Aug 2022 07:27:33 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003a550be861bsm13401085wmb.27.2022.08.16.07.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 07:27:33 -0700 (PDT)
Message-ID: <24bf3261-5012-d899-60c9-2c070d44c7fb@gmail.com>
Date:   Tue, 16 Aug 2022 15:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] cmake: avoid editing t/test-lib.sh
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com>
 <23d86b94-3e2e-bdeb-3385-a996c07b699d@gmail.com>
 <8o4q98s3-sr2r-34qq-p7pr-8o44061o0n76@tzk.qr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8o4q98s3-sr2r-34qq-p7pr-8o44061o0n76@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 16/08/2022 11:09, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 11 Aug 2022, Phillip Wood wrote:
> 
>> On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> In 7f5397a07c6c (cmake: support for testing git when building out of the
>>> source tree, 2020-06-26), we implemented support for running Git's test
>>> scripts even after building Git in a different directory than the source
>>> directory.
>>>
>>> The way we did this was to edit the file `t/test-lib.sh` to override
>>> `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
>>> directory.
>>>
>>> This is unideal because it always leaves a tracked file marked as
>>> modified, and it is all too easy to commit that change by mistake.
>>>
>>> Let's change the strategy by teaching `t/test-lib.sh` to detect the
>>> presence of a file called `GIT-BUILD-DIR` in the source directory. If it
>>> exists, the contents are interpreted as the location to the _actual_
>>> build directory. We then write this file as part of the CTest
>>> definition.
>>
>> I think it is really good to get away from editing the test files, but one of
>> the nice things about CMake's out of tree builds is that you can have several
>> build directories with different build configurations and this change does not
>> support that. Could we pass the build directory to the test scripts as a
>> commandline option or environment variable instead? e.g.
>>
>>    foreach(tsh ${test_scipts})
>>     	add_test(NAME ${tsh}
>> -		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint
>> --build-dir=${CMAKE_BINARY_DIR} -vx
>>
>>    		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>>    endforeach()
>>
>> Doing that would avoid changing the main Makefile to remove a file which
>> almost certainly does not exist every time make is invoked as well.
> 
> This is indeed tempting, but one of the things I recommend to Visual
> Studio users for ages already is to run the tests in a Git Bash, i.e.
> outside of Visual Studio, to allow for passing `--run=...` options and the
> likes. This recommendation predates support for CTest, naturally, but it
> is still valid.
> 
> And that recommended way of running tests would be broken by the suggested
> change because the tests would no longer run except when using CTest.

Yes the recommendation would have to include adding --build-dir which 
would be a pain

> Besides, while the semantics look tempting, the implementation details do
> not. The reason is that we use `GIT_BUILD_DIR` to source the
> `GIT-BUILD-OPTIONS` and to validate that Git was built, long before we
> parse the command-line in `t/test-lib.sh`. I want to refrain from the
> prerequisite extensive refactoring required to support this, at least in
> the context of this here patch series.

That sounds awkward.

> Can we maybe agree that the proposed patch is a net improvement over the
> status quo, and think about a better solution independently (without
> blocking this here patch)?

It is definitely an improvement for the CMake side, I'm not sure it is 
an improvement for the Makefile but it sounds like the best option overall.

Best Wishes

Phillip

> Ciao,
> Dscho
