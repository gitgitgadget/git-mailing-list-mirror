Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E77C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 07:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhKTHEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 02:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhKTHEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 02:04:43 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE110C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 23:01:39 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t34so11621029qtc.7
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eUwhNEk6VS0x+uikYHqOInvc8vTqg/9EdvSOLX920Fg=;
        b=HIS4pvZAd7v1wREdGt6RLUrrCvWsvaWp6+xJ2x62lF86Xc6fe8q3nVjcv72lmNbQmm
         gNalzesf2LdHtSplFjOCjP/waLktl2M9fdajm9qGwNGExxeedc1Pon2DsIqwJ0m3JZGZ
         zrYdCcxroSYSoziMQiYEToB8oKkv33lgyVV8grQD+9hQ7v0DOZEeWSGuXYvfM1D0129V
         aiHHa8YhVY22UVqeXtLZ95ni+bA7es9Lzgs1lZuCW+ZMmlyZx9mJLrV1IS4ja1xzT43C
         h5Y4MqKd0/4ixBQfN2Rrytsh+P8QcvBYKzMOxWRxYs3DhbFMKhLGC/bMJoMoEoweyJv1
         AEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUwhNEk6VS0x+uikYHqOInvc8vTqg/9EdvSOLX920Fg=;
        b=YzQrW3cl9tgPs1MPXPtjncHjgR0dc17PaIGhdfuZupK3YFha+15a7M2h/n0DOLhSnU
         /fdJwKEGkCtZ3eoHZSoRGEy8EU28WS5P7JvoEMSAWXsOczJiXUR3ashYKMtnS5npUGVU
         D38H1hpZ9wa14tDZ8IU6VxqP8c6H4KW/9XfOLTf3/bSR/to7IoHwHKkF0/Tpq50Gbsou
         0Y0W9s7rvwSOF6+BJKWEtc6B9XIGaB4DtO6+h/tS1rAb/XcjdAGPQ0ApXOKkg2u2je8a
         /ZOYr2r1fWmQMBO69EnCtLguk0axfM5inbT5XSJ5UtK9v4YGvSDSTspmteGtXJVQ15LJ
         rgHg==
X-Gm-Message-State: AOAM5338GgyLyW4ge+A7bH5uNCmDTg4T5GQ5Gtj9ocuuO1IX7NDMvwdl
        TnXCRckPiDVqAG3M97vdlE7y
X-Google-Smtp-Source: ABdhPJzgdX8i1CPgkTj38aKPTOwdkloDLYJyEbB6P+93/501f6YydIxmZABZMNGWJQxrmtRdNheiaA==
X-Received: by 2002:ac8:5c53:: with SMTP id j19mr13142339qtj.40.1637391698244;
        Fri, 19 Nov 2021 23:01:38 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id o17sm1152741qkp.89.2021.11.19.23.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 23:01:37 -0800 (PST)
Message-ID: <d9b07ca5-b58d-a535-d25b-85d7f12e6295@github.com>
Date:   Sat, 20 Nov 2021 02:01:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/6] CI: use shorter names that fit in UX tooltips
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
 <patch-v2-2.6-73981cedee8-20211120T030848Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <patch-v2-2.6-73981cedee8-20211120T030848Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> Change the names used for the GitHub CI workflows to be short enough
> to (mostly) fit in the pop-up tool-tips that GitHub shows in the
> commit view. I.e. when mouse-clicking on the passing or failing
> check-mark next to the commit subject.
> 
> These names are seemingly truncated to 17-20 characters followed by
> three dots ("..."). Since a "CI/PR / " prefix is added to them the job
> names looked like this before (windows-test and vs-test jobs omitted):
> 
>     CI/PR / ci-config (p...
>     CI/PR / windows-buil...
>     CI/PR / vs-build (pu...
>     CI/PR / regular (lin...
>     CI/PR / regular (lin...
>     CI/PR / regular (os...
>     CI/PR / regular (os...
>     CI/PR / regular (lin...
>     CI/PR / regular (lin...
>     CI/PR / dockerized (...
>     CI/PR / dockerized (...
>     CI/PR / dockerized (...
>     CI/PR / static-anal...
>     CI/PR / sparse (pu...
>     CI/PR / documenta...
> 
> By omitting the "/PR" from the top-level name, and pushing the
> $jobname to the front we'll now instead get:
> 
>     CI / config (push)
>     CI / win build (push...
>     CI / win+VS build (...
>     CI / linux-clang (ub...
>     CI / linux-gcc (ubun...
>     CI / osx-clang (osx)...
>     CI / osx-gcc (osx) (...
>     CI / linux-gcc-defau...
>     CI / linux-leaks (ub...
>     CI / linux-musl (alp...
>     CI / Linux32 (daald/...
>     CI / pedantic (fedor...
>     CI / static-analysis...
>     CI / sparse (push)...
>     CI / documentation
> 
> We then have no truncation in the expanded view. See [1] for how it
> looked before, [2] for a currently visible CI run using this commit,
> and [3] for the GitHub workflow syntax involved being changed here.
> 
> Let's also add a field for the "os" and use it where appropriate, it's
> occasionally useful to know we're running on say ubuntu
> v.s. fedora (but the "-latest" suffix isn't very useful, that applies
> to almost all the jobs.
> 
> 1. https://github.com/git/git/tree/master/
> 2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-2
> 3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .github/workflows/main.yml | 16 +++++++++++++++-
>  README.md                  |  2 +-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e8076..612b475fd0b 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -1,4 +1,4 @@
> -name: CI/PR
> +name: CI
>  
>  on: [push, pull_request]
>  
> @@ -7,6 +7,7 @@ env:
>  
>  jobs:
>    ci-config:
> +    name: config
>      runs-on: ubuntu-latest
>      outputs:
>        enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
> @@ -77,6 +78,7 @@ jobs:
>              }
>  
>    windows-build:
> +    name: win build
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      runs-on: windows-latest
> @@ -97,6 +99,7 @@ jobs:
>          name: windows-artifacts
>          path: artifacts
>    windows-test:
> +    name: win test
>      runs-on: windows-latest
>      needs: [windows-build]
>      strategy:
> @@ -127,6 +130,7 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    vs-build:
> +    name: win+VS build
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      env:
> @@ -178,6 +182,7 @@ jobs:
>          name: vs-artifacts
>          path: artifacts
>    vs-test:
> +    name: win+VS test
>      runs-on: windows-latest
>      needs: vs-build
>      strategy:
> @@ -210,6 +215,7 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    regular:
> +    name: ${{matrix.vector.jobname}} (${{matrix.vector.os}})

The consequence of explicitly removing `-latest` (as you mentioned in the
commit message) is the addition of the new `os` field just to remove that
suffix (+renaming 'macos' to 'osx' to - I assume - save a bit more space).

Keeping the `-latest` doesn't really seem to hurt your goal of improving the
tooltips, though; worst case, the `-latest` would be what's cut off in the
tooltip. The main reason I bring this up is because I'd generally prefer
reusing existing fields wherever possible - e.g. something like this: 

    name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})

...which has the added benefits of 1) fully reflecting the agents used
(potentially beneficial e.g., if we switched from `macos-latest` to
`macos-10.15`) and 2) better matching the way you've set up the docker
image-based jobs later on. 

>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
> @@ -218,21 +224,27 @@ jobs:
>          vector:
>            - jobname: linux-clang
>              cc: clang
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-gcc
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: osx-clang
>              cc: clang
> +            os: osx
>              pool: macos-latest
>            - jobname: osx-gcc
>              cc: gcc
> +            os: osx
>              pool: macos-latest
>            - jobname: linux-gcc-default
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-leaks
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
> @@ -251,6 +263,7 @@ jobs:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    dockerized:
> +    name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
> @@ -310,6 +323,7 @@ jobs:
>        run: ci/install-dependencies.sh
>      - run: make sparse
>    documentation:
> +    name: documentation
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      env:
> diff --git a/README.md b/README.md
> index eb8115e6b04..f6f43e78deb 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,4 +1,4 @@
> -[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
> +[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
>  
>  Git - fast, scalable, distributed revision control system
>  =========================================================
> 

Overall, I like the fact that platform info is retained in this version
(while also managing to shorten names and/or make the non-truncated parts
more helpful). Thank you for the update! 
