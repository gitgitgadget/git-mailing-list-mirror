Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C1C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhKTTJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 14:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhKTTJK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 14:09:10 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B83C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 11:06:07 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j9so9435399qvm.10
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4A7WvtgqjHN1k2JpH2Zg1mVC3c4F/DMlJNUJ4ojvrHQ=;
        b=Vug1dctsy0TaE3nVOmYsjxQWQ0p+LOaTS45g6ynyvs2Hus0rOCqJkvAz3kxg9wgnYn
         5YgpQPpckwJu78UnK98JeGtbqscZ+vXkTPkFaHVfsPmPcJg8M+ctKAk821TTTW1y1szF
         rXqUWs4zH8nq4lZyKXDdEmbdNbtWR8eZAnpNgas2zDzveiVC0c6mpuOxyZ1mgGryhGvy
         peDRKXb6xdiLIEQ9soMxpUNKwb/mwLaxczVV12WBrzNu9mqaDnVgoO3AvtwatYdOzuJ5
         wEs+6pUUE7fs2G01o1IaOg4zazsQwpSvoVUaWsHP4T6aPD9UDeD07VsfVcboxwsbWtzq
         xHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4A7WvtgqjHN1k2JpH2Zg1mVC3c4F/DMlJNUJ4ojvrHQ=;
        b=V1s1ETEeEBv1qeLw/pjST9buWFXKFq9RxMYG1C2kcRcZMGbhrbq8eDB6S2ts0RrK8A
         V6VD3SOgJBNnyC7t52D/uHhYL7zs3FVOYAo9X5QN7a0AOCW7g93CTBtl3wS6TMqk0Bqh
         WbWNWYfPM+EcA8LMG8Gvv/11OgqssZz0krEor6t+K4R5H0iFp8k8dekyXNNu4QKaEZCT
         vYHacaDv7xfllMvYdL6BUFZL21C59ylAxvbUt5p0cLeeOoDaLxnGWu/1ZCIkOo4/ftoH
         y+4M8GbE2Lu25DG3VDGR/4M/Uaf2Djfcykc+ESuIysyba5iU+vvMQAISIHuBMgkeUvom
         kmBw==
X-Gm-Message-State: AOAM531tqsIu6y5hj9P8S33TcVWNnchdTRYQpliM4E7iydK5qhCv29lM
        85Hm3aTwms/3uXvu9qCyOvRt
X-Google-Smtp-Source: ABdhPJxcCurpDQsbuGUjmlYQe/Ggf6dWJbxZCc+//2Ygx/xH8iR/4O1mDr1b7pEP/OXE4AcV5LSiNg==
X-Received: by 2002:a0c:bed0:: with SMTP id f16mr47613719qvj.57.1637435165529;
        Sat, 20 Nov 2021 11:06:05 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id d5sm1895301qte.27.2021.11.20.11.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 11:06:04 -0800 (PST)
Message-ID: <c821d1ed-fc1b-4d75-ad3f-b86d9899b306@github.com>
Date:   Sat, 20 Nov 2021 14:06:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 2/5] CI: use shorter names that fit in UX tooltips
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
 <patch-v3-2.5-b09cd076aeb-20211120T115414Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <patch-v3-2.5-b09cd076aeb-20211120T115414Z-avarab@gmail.com>
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
> Let's also use the existing "pool" field as before. It's occasionally
> useful to know we're running on say ubuntu v.s. fedora. The "-latest"
> suffix is useful to some[4], and since it's now at the end it doesn't
> hurt readability in the short view compared to saying "ubuntu" or
> "macos".
> 
> 1. https://github.com/git/git/tree/master/
> 2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-3
> 3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions
> 3. https://lore.kernel.org/git/d9b07ca5-b58d-a535-d25b-85d7f12e6295@github.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .github/workflows/main.yml | 10 +++++++++-
>  README.md                  |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e8076..c7c10456572 100644
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
> +    name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
> @@ -251,6 +257,7 @@ jobs:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    dockerized:
> +    name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
> @@ -310,6 +317,7 @@ jobs:
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

This addresses all of my earlier comments - looks good to me!
