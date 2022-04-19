Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E94C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 12:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbiDSMlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDSMlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 08:41:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3C35DCD
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 05:38:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv16so5114129wrb.9
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=cQ0d2ghHv6qo2ydME5KtFUSoKFP3+jVqpRNU11RncJ8=;
        b=SWP0yfgUyaC7KVbNoe03kaKI5ITGm5vJ+fQ3xMtWMKnexnUx/mfGH1vvcFGwhtoS3U
         NLjdlKhotJEAAGB/HKSE0h224ovBlfFIgwoNx83BHSCjaS/SVYosW+iddsZPIAM8vP7B
         xmfPgN4Pom8adY/LLjMZLNqgrjyTA3g1u7nubXJdrsFC9sm1vIAOF5+FGqbgDw3goaf7
         Hx2hwWGgvZaDeIaaV5FHm+b312BxupfaihNP+TGOewUVL19xb6CYIxFcelbAFB2mxAwn
         LiIVgSmmmYDtDRmnW+2AAEmYoS/g2Y2YPGY8V17YGHLyh2ECkcS/6JD3j8Hdq9Vyo5FV
         k4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=cQ0d2ghHv6qo2ydME5KtFUSoKFP3+jVqpRNU11RncJ8=;
        b=jokuY4xLDNmADhS6d5PapP/9C4+w5jOKCJusxeLaU91cP3A3OnwwiAKMEdIJvm3ey5
         hXPCBX8J+aRzmZP2pHKAVXb6/jlXtaS9ZbVRbBKBS1AnxtAqjGs6wMAPVSKi3UVO+Jf1
         quJHwJ5iNdmDcypLf3N9lLaYpKTn0wlKKginJRngqHXuZkOyDSX9bnEpc+ENrRfxNbdL
         w5ZEPmksMcMLUMM8JjcFavAHK0W3kfO/pnHY3HyqfoKR8Sc45t5LIVtggsuhP2a98inH
         otmB8biNZYwNkg9UgdKVSaHrA+KBHjQBDGTVBvPnCXLkqg+KkL55G5Agltc5cr3S0VI6
         ZcgA==
X-Gm-Message-State: AOAM533RbgmDk8rw1WaOSgbIRj0kRcLYf0kCwYzycg0QCAHWASbGuif6
        Srl9lpvra1gRL0p7qEUlMjU=
X-Google-Smtp-Source: ABdhPJxo/gYsl9kUmV+2evCfVGH7j7XlIxG4I3SZQqdwuD6Epo5AlYyJMXJPnyapen5j8VGVD/cYNQ==
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id u5-20020a5d6da5000000b0020a88056988mr10512684wrs.317.1650371896940;
        Tue, 19 Apr 2022 05:38:16 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id u16-20020a05600c441000b0038ebcbadcedsm27740511wmn.2.2022.04.19.05.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:38:16 -0700 (PDT)
Message-ID: <1157a463-f6c6-1df5-59cd-419d73eed1df@gmail.com>
Date:   Tue, 19 Apr 2022 13:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: ab/ci-setup-simplify (was Re: What's cooking in git.git (Apr 2022,
 #05; Mon, 18))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbkwyz78z.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <xmqqbkwyz78z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * ab/ci-setup-simplify (2022-04-14) 29 commits
>   - CI: make it easy to use ci/*.sh outside of CI
>   - CI: don't use "set -x" in "ci/lib.sh" output
>   - CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>   - CI: set SANITIZE=leak in MAKEFLAGS directly
>   - CI: set CC in MAKEFLAGS directly, don't add it to the environment
>   - CI: add more variables to MAKEFLAGS, except under vs-build
>   - CI: narrow down variable definitions in --build and --test
>   - CI: only invoke ci/lib.sh as "steps" in main.yml
>   - CI: pre-select test slice in Windows & VS tests
>   - ci/run-test-slice.sh: replace shelling out with "echo"
>   - CI: move "env" definitions into ci/lib.sh
>   - CI: combine ci/install{,-docker}-dependencies.sh
>   - CI: split up and reduce "ci/test-documentation.sh"
>   - CI: invoke "make artifacts-tar" directly in windows-build
>   - CI: check ignored unignored build artifacts in "win[+VS] build" too
>   - ci/lib.sh: use "test" instead of "["
>   - CI: remove "run-build-and-tests.sh", run "make [test]" directly
>   - CI: export variables via a wrapper
>   - CI: consistently use "export" in ci/lib.sh
>   - CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>   - CI: have "static-analysis" run "check-builtins", not "documentation"
>   - CI: have "static-analysis" run a "make ci-static-analysis" target
>   - CI: don't have "git grep" invoke a pager in tree content check
>   - CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
>   - CI: remove unused Azure ci/* code
>   - CI: remove dead "tree skipping" code
>   - CI: remove more dead Travis CI support
>   - CI: make "$jobname" explicit, remove fallback
>   - CI: run "set -ex" early in ci/lib.sh
>   (this branch is used by ab/ci-github-workflow-markup.)
> 
>   Drive more actions done in CI via the Makefile instead of shell
>   commands sprinkled in .github/workflows/main.yml
> 
>   Will merge to 'next'?
>   source: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>

I haven't had time to read all 31 patches from v4 in detail but I have 
looked at the results in seen.

Looking at seen:ci/install-dependencies.sh the shebang has been changed 
to "#!/bin/sh" but it contains "BREW_PACKAGE=${CC_PACKAGE/-/@}" which is 
a bashism.

Looking at seen:.github/workflows/main.yaml to skip running the tests 
one has to set "skip-tests: no" which is utterly confusing.

 From what I saw scanning the patches there seemed to be a lot of churn, 
both of existing code and code that gets added and then moved/refactored 
within the series.

Looking at the output of a recent ci run of seen the steps to prepare 
the environment before building and testing print all the environment 
variables rather than just the ones being set for that step which seems 
to go against the aim of "CI: narrow down variable definitions in 
--build and --test". (Also the "SKIP" prefix in the output lacks a ":")

Dscho raised concerns that this removes any support for azure pipelines 
which he uses when preparing security patches.

I think splitting out the build and test steps is a good idea but I'm 
less convinced by some of the other changes.

Best Wishes

Phillip
