Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC35C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiCBK7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiCBK7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 05:59:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508A58E56
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 02:58:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b5so2127399wrr.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 02:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=7TOIGIB2frkpjWv/BNtrXIdO1mfIIfh4cfwtnTkTuTI=;
        b=RvIzuMCRL7Z0+kkrqe5/FYelppjZHkxqOGG0UBRf9J8cTMDXyzCWtS7euFlsHxknp7
         9gRyk70sUAQzzGhQXt1GM2Z6zjIE3Emi9y+DsVlA7ny9WmDwNSWghsIXlTk/WPhsUqgp
         y0AMH6FQ3lA3yRaRZoT+C5snY/5AzRLuifN6aQyvk/Hl5Mhz4j6wCq5OnpjYSrPMFP1u
         ZR+B+GkLLbpoBaT9JWE+5ftH9+t3JPf+oJgy//vxojc21j/QVxVDfuGDggB7iesw9ntH
         nbWLjebODfHXRv+fzL7HibN+o0WH/R3/XaENWu+RmV8ZliEdQn/VfrguXBFV3TzDerQ1
         c1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=7TOIGIB2frkpjWv/BNtrXIdO1mfIIfh4cfwtnTkTuTI=;
        b=0WMRrm4UZ8swpAPz8wN6oQ+g3BIAkuLTvd8g3q7E9Y6UhBzM7gzaMfBFIYTPK374y7
         jsi+jTotLqiFbxK6svTNtm4hvbWheFcgE6grbncubXkeCN18/ttvmAGkxlphkaJfhSFp
         06qYHYPh5qfV4kljqCFJD2o8RY/LmfrdIndBqpwAukGypgTj/FMLK6BzpkBIT1RXfBzv
         9rg1T+EuHY4rc2aDXxLsEkP8tARoRlKyADnhudhIgaIKKYD2gBipHSX+zBolZzdopu1X
         CO1bj9kaP1PRbEmywvav3jS43TjxRcT+gIRhUqUNqfCiFRF17gUgGp+N9CXbONx+4ZSR
         KtLA==
X-Gm-Message-State: AOAM533L99aH/JS1RVvzF03h2uxd6N3zXNMdg2VhN36O8tyqfmqXh2jc
        mE+gTcWbiZPZl+apzC2ch0U=
X-Google-Smtp-Source: ABdhPJyF2reHFFETXP8s7Lt5gUwrB+ycHiAG+QXFUDkQzAePzo82JONEF76MG3a/1ndF9Opz8wIT3A==
X-Received: by 2002:adf:f804:0:b0:1f0:326e:5e78 with SMTP id s4-20020adff804000000b001f0326e5e78mr1830230wrp.251.1646218729475;
        Wed, 02 Mar 2022 02:58:49 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm5172932wms.10.2022.03.02.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 02:58:48 -0800 (PST)
Message-ID: <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
Date:   Wed, 2 Mar 2022 10:58:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Reply-To: phillip.wood@dunelm.org.uk
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
 <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
Content-Language: en-US
In-Reply-To: <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 25/02/2022 14:10, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 23 Feb 2022, Phillip Wood wrote:
> 
>> On 22/02/2022 13:31, Ævar Arnfjörð Bjarmason wrote:
>>> [...]
>>> So just to make the point about one of those mentioned in my [1] with
>>> some further details (I won't go into the whole thing to avoid repeating
>>> myself):
>>>
>>> I opened both of:
>>>
>>> https://github.com/git-for-windows/git/runs/4822802185?check_suite_focus=true
>>> https://github.com/dscho/git/runs/4840190622?check_suite_focus=true
>>>
>>> Just now in Firefox 91.5.0esr-1. Both having been opened before, so
>>> they're in cache, and I've got a current 40MB/s real downlink speed etc.
>>>
>>> The former fully loads in around 5100ms, with your series here that's
>>> just short of 18000ms.
>>>
>>> So your CI changes are making the common case of just looking at a CI
>>> failure more than **3x as slow as before**.
>>
>> I don't think that is the most useful comparison between the two. When I
>> am investigating a test failure the time that matters to me is the time
>> it takes to display the output of the failing test case.
> 
> Thank you for expressing this so clearly. I will adopt a variation of this
> phrasing in my commit message, if you don't mind?

That's fine

>> With the first link above the initial page load is faster but to get to
>> the output of the failing test case I have click on "Run
>> ci/print_test_failures.sh" then wait for that to load and then search
>> for "not ok" to actually get to the information I'm after.
> 
> And that's only because you are familiar with what you have to do.
> 
> Any new contributor would be stuck with the information presented on the
> initial load, without any indication that more information _is_ available,
> just hidden away in the next step's log (which is marked as "succeeding",
> therefore misleading the inclined reader into thinking that this cannot
> potentially contain any information pertinent to the _failure_ that needs
> to be investigated).

Yes it took we a while to realize how to get to the test output when I 
first started looking at the CI results.

One thing I forgot to mention was that when you expand a failing test it 
shows the test script twice before the output e.g.

Error: failed: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
failure: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
   				git config core.fsmonitor true &&
   				git fsmonitor--daemon start &&
   				git update-index --fsmonitor
   			
   expecting success of 7527.35 'Matrix[uc:false][fsm:true] enable 
fsmonitor':
   				git config core.fsmonitor true &&
   				git fsmonitor--daemon start &&
   				git update-index --fsmonitor

  ++ git config core.fsmonitor true
  ++ git fsmonitor--daemon start 			
  ...

I don't know how easy it would be to fix that so that we only show 
"expecting success of ..." without the test being printed first

Best Wishes

Phillip


>> With the second link the initial page load does feel slower but then I'm
>> presented with the test failures nicely highlighted in red, all I have
>> to do is click on one and I've got the information I'm after.
>>
>> Overall that is much faster and easier to use.
> 
> Thank you for your comment. I really started to doubt myself, getting the
> idea that it's just a case of me holding this thing wrong.
> 
> For what it's worth, I did make a grave mistake by using that particular
> `seen` CI failure with all of those failing p4 tests, which obviously
> resulted in an incredibly large amount of logs. Obviously that _must_ be
> slow to load. I just did not have the time to fabricate a CI failure.
> 
> However, I do agree with you that the large amount of logs would have to
> be looked at _anyway_, whether it is shown upon loading the job's logs or
> only when expanding the `print-test-failures` step's logs. The amount of
> the logs is a constant, after all, I did not change anything there (nor
> would I).
> 
> So a better example might be my concrete use case yesterday: the CI build
> of `seen` failed. Here is the link to the regular output:
> 
> 	https://github.com/git/git/actions/runs/1890665968
> 
> On that page, you see the following:
> 
> 
> 	Annotations
> 	8 errors and 1 warning
> 
> 	ⓧ win test (3)
> 	  Process completed with exit code 2.
> 
> 	ⓧ win test (6)
> 	  Process completed with exit code 2.
> 
> 	ⓧ win test (2)
> 	  Process completed with exit code 2.
> 
> 	ⓧ win+VS test (3)
> 	  Process completed with exit code 2.
> 
> 	ⓧ win+VS test (6)
> 	  Process completed with exit code 2.
> 
> 	ⓧ win+VS test (2)
> 	  Process completed with exit code 2.
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  Process completed with exit code 2.
> 
> 	ⓧ osx-clang (macos-latest)
> 	  Process completed with exit code 2.
> 
> 	⚠ CI: .github#L1
> 	  windows-latest workflows now use windows-2022. For more details, see https://github.com/actions/virtual-environments/issues/4856
> 
> So I merged my branch into `seen` and pushed it. The corresponding run can
> be seen here:
> 
> 	https://github.com/dscho/git/actions/runs/1892982393
> 
> On that page, you see the following:
> 
> 	Annotations
> 	50 errors and 1 warning
> 
> 	ⓧ win test (3)
> 	  failed: t7527.1 explicit daemon start and stop
> 
> 	ⓧ win test (3)
> 	  failed: t7527.2 implicit daemon start
> 
> 	ⓧ win test (3)
> 	  failed: t7527.3 implicit daemon stop (delete .git)
> 
> 	ⓧ win test (3)
> 	  failed: t7527.4 implicit daemon stop (rename .git)
> 
> 	ⓧ win test (3)
> 	  failed: t7527.5 implicit daemon stop (rename GIT~1)
> 
> 	ⓧ win test (3)
> 	  failed: t7527.6 implicit daemon stop (rename GIT~2)
> 
> 	ⓧ win test (3)
> 	  failed: t7527.8 cannot start multiple daemons
> 
> 	ⓧ win test (3)
> 	  failed: t7527.10 update-index implicitly starts daemon
> 
> 	ⓧ win test (3)
> 	  failed: t7527.11 status implicitly starts daemon
> 
> 	ⓧ win test (3)
> 	  failed: t7527.12 edit some files
> 
> 	ⓧ win test (2)
> 	  failed: t0012.81 fsmonitor--daemon can handle -h
> 
> 	ⓧ win test (2)
> 	  Process completed with exit code 1.
> 
> 	ⓧ win test (6)
> 	  failed: t7519.2 run fsmonitor-daemon in bare repo
> 
> 	ⓧ win test (6)
> 	  failed: t7519.3 run fsmonitor-daemon in virtual repo
> 
> 	ⓧ win test (6)
> 	  Process completed with exit code 1.
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.1 explicit daemon start and stop
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.2 implicit daemon start
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.3 implicit daemon stop (delete .git)
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.4 implicit daemon stop (rename .git)
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.5 implicit daemon stop (rename GIT~1)
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.6 implicit daemon stop (rename GIT~2)
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.8 cannot start multiple daemons
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.10 update-index implicitly starts daemon
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.11 status implicitly starts daemon
> 
> 	ⓧ win+VS test (3)
> 	  failed: t7527.12 edit some files
> 
> 	ⓧ win+VS test (2)
> 	  failed: t0012.81 fsmonitor--daemon can handle -h
> 
> 	ⓧ win+VS test (2)
> 	  Process completed with exit code 1.
> 
> 	ⓧ win+VS test (6)
> 	  failed: t7519.2 run fsmonitor-daemon in bare repo
> 
> 	ⓧ win+VS test (6)
> 	  failed: t7519.3 run fsmonitor-daemon in virtual repo
> 
> 	ⓧ win+VS test (6)
> 	  Process completed with exit code 1.
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t0012.81 fsmonitor--daemon can handle -h
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7519.2 run fsmonitor-daemon in bare repo
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.1 explicit daemon start and stop
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.2 implicit daemon start
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.3 implicit daemon stop (delete .git)
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.4 implicit daemon stop (rename .git)
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.7 MacOS event spelling (rename .GIT)
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.8 cannot start multiple daemons
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.10 update-index implicitly starts daemon
> 
> 	ⓧ osx-clang (macos-latest)
> 	  failed: t7527.11 status implicitly starts daemon
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t0012.81 fsmonitor--daemon can handle -h
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7519.2 run fsmonitor-daemon in bare repo
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.1 explicit daemon start and stop
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.2 implicit daemon start
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.3 implicit daemon stop (delete .git)
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.4 implicit daemon stop (rename .git)
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.7 MacOS event spelling (rename .GIT)
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.8 cannot start multiple daemons
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.10 update-index implicitly starts daemon
> 
> 	ⓧ osx-gcc (macos-latest)
> 	  failed: t7527.11 status implicitly starts daemon
> 
> 	⚠ CI: .github#L1
> 	  windows-latest workflows now use windows-2022. For more details, see https://github.com/actions/virtual-environments/issues/4856
> 
> In my mind, this is already an improvement. (Even if this is a _lot_ of
> output, and a lot of individual errors, given that all of them are fixed
> with a single, small patch to adjust an option usage string, but that's
> not the fault of my patch series, but of the suggestion to put the check
> for the option usage string linting into the `parse_options()` machinery
> instead of into the static analysis job.)
> 
> Since there are still plenty of failures, the page admittedly does load
> relatively slowly. But that's not the time I was trying to optimize for.
> My time comes at quite a premium these days, so if the computer has to
> work a little harder while I can do something else, as long as it saves
> _me_ time, I'll take that time. Every time.
> 
> Ciao,
> Dscho
