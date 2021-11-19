Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1495CC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E882661A58
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhKSQGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbhKSQGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:06:00 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD9C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 08:02:58 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d2so10590249qki.12
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 08:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yUaygnjkFWCKRMma6AVyoUOQP9NXOeOWzEsStjeVo9g=;
        b=Cc0GhhIvryLNeUtSmBhf1y5LxqmNOrHQXD5En6Sq2r2GSQxMva6P64aRMgvQT9YtR3
         rkyYJj45Qt7NZu9jiUcqf9RhaF0BU+obOxd2LYu56U7DZMyoWKUw1E8rkjMKy99caCOz
         UJmz9s9GbOlhIrGQav1Dz+wps0+p9SDpt4aO20EcGAiPqdSAgP8WxKcCuvDzlTjPpzHL
         tBCKZ7dXx+UvBdw9HsxhFP6eCxMiYlw64fdmcELikrKiiBfKq9Lm/ySY4qDpgDdUbQsq
         eHa+umcedvqAiSRwX7g6wnnz6VhAeZWE47AK+GqItpphQnxusB7CfeyOb/S9ekhExKP0
         AUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yUaygnjkFWCKRMma6AVyoUOQP9NXOeOWzEsStjeVo9g=;
        b=42fawYMVITk/KQVrzklGarx38RGE2OBS0g9YMLaWTA42qhapvQ0bZn93CvohCwgKF5
         VfnqoYvrez3TcP73VKV8FWt/IkkoVckoXSyAIfLpbXDDDZZHm4rPBP05fMHzL3LHXVCf
         iM5vOW4Rac0lXgDAKOJ8jf/yWfTZykYMxGqWHE+ky/auSS7lsO54awym5crbIS8skRb1
         WQ21ZNXpMd3DeQLLT28y6dCXNBGSv95czMNzYIY6fSI4w12AMplgQKjnAWD/IHnGgTYj
         djI79GgQbQTgnuKiTyLcpipVdpsFv3LNk+A9zYYYSyJIctls6+J+vy4zPlCpGi98no4E
         Bkrg==
X-Gm-Message-State: AOAM532NOzuFCnCt3VAekFx/a6gUnhQTIlmbxPaUU5yL6zVXOddPYDfr
        ZxBMlna4oAwrR5Zwi95by+GU
X-Google-Smtp-Source: ABdhPJxSTYzlDV26zNvJR4yWgtYeZEAZRyZfzolAe9pQAUBHOSrXGSpIrDftDG/XjK5LfNgW06HseQ==
X-Received: by 2002:a37:e15:: with SMTP id 21mr29993266qko.413.1637337774344;
        Fri, 19 Nov 2021 08:02:54 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id h11sm59732qkp.46.2021.11.19.08.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:02:54 -0800 (PST)
Message-ID: <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com>
Date:   Fri, 19 Nov 2021 11:02:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
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
> That description is truncated to 24 characters, with the 3 at the end
> being placed by "...".
> 
> E.g. the full job name (visible at [1]):
> 
>     "regular (linux-gcc-default, gcc, ubuntu-latest)"
> 
> Will, when shown in the tool-tip be truncated to:
> 
>     "CI/PR / regular (linu..."
> 
> There's then a further limit in the expanded view where the job names
> are observably truncated to 44 characters (including "..."). I.e.:
> 
>     "regular (linux-gcc-default, gcc, ubuntu-l..."
> 

Tooltips like the ones you've pointed out here appear intended to be an "at
a glance" view of the jobs (mostly for showing pass/fail/skip status) - each
job in the tooltip has a "Details" link that takes you to the job summary
and logs. In the current state, although the names of the are truncated in
the tooltip, the information is still easily accessible in the full workflow
details (one click away). For example, the details for the "linux-leaks" job
[1] tell me the image, compiler, and job name right at the top of the page.

[1] https://github.com/git/git/runs/4214606314?check_suite_focus=true

> With this change we shorten both the job names, and change the
> top-level "name" from "CI/PR" to "CI", since it will be used as a
> prefix in the tooltips. We also remove redundant or superfluous
> information from the name, e.g. "ubuntu-latest" isn't really needed
> for "linux-leaks", it'll suffice to say linux. For discovering what
> image runs that specifically we can consult main.yml itself.
> 

By optimizing for the tooltip, this patch shortens names to the point that
they're more difficult to interpret (w32 vs. w32/VS) and/or removes valuable
context about platform/image/etc. When a user *does* want more information
on the job, they now have to: 

1) know that the "CI/PR" job definition is in ".github/workflows/main.yml"
2) parse through the file to find the job they want
3) correlate that back to the job in the workflow details they're
   investigating. 

That's a strictly worse experience for an extremely common use-case. What
use-case is this patch attempting to improve?

> The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
> then becomes a 1=1 match to the "$jobname" used in
> "ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
> added implicitly as before (from the top-level "on" parameter in
> "main.yml"). In the tooltip we'll now show:
> 
>     "CI / linux-leaks (pu..."
> 
> We then have no truncation in the expanded view. See [2] for a
> currently visible CI run using this commit, and [3] for the GitHub
> workflow syntax involved being changed here.
> 

If the only problem this patch really "solves" is making some job names fit
a bit better into the tooltip and, I think the costs (namely the loss of
accessible contextual info) outweigh any potential benefits you gain. 

> We could avoid even more truncation with more compact names,
> e.g. changing "linux" to "lin" or "lnx", but I didn't do that since
> any additional shortening seemed counterproductive, i.e. "w32" is a
> well-known way of referring to "Windows", but "lin" isn't). We could
> also shorten e.g. "::build" and "::test" to "+bld" and "+tst", but
> those seem similarly to be overly obtuse.
> 
> 1. https://github.com/git/git/tree/master/
> 2. https://github.com/avar/git/tree/avar/ci-shorter-names
> 3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>> ---
>  .github/workflows/main.yml | 13 ++++++++++++-
>  README.md                  |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e8076..8f4caa8f040 100644
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
> +    name: w32::build
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      runs-on: windows-latest
> @@ -97,6 +99,7 @@ jobs:
>          name: windows-artifacts
>          path: artifacts
>    windows-test:
> +    name: w32::test
>      runs-on: windows-latest
>      needs: [windows-build]
>      strategy:
> @@ -127,6 +130,7 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    vs-build:
> +    name: w32/VS::build
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      env:
> @@ -178,6 +182,7 @@ jobs:
>          name: vs-artifacts
>          path: artifacts
>    vs-test:
> +    name: w32/VS::test
>      runs-on: windows-latest
>      needs: vs-build
>      strategy:
> @@ -210,6 +215,7 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    regular:
> +    name: ${{matrix.vector.jobname}}
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
> @@ -251,6 +257,7 @@ jobs:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    dockerized:
> +    name: ${{matrix.vector.jobname}} (docker)
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
> @@ -258,10 +265,13 @@ jobs:
>        matrix:
>          vector:
>          - jobname: linux-musl
> +          os: alpine
>            image: alpine
>          - jobname: Linux32
> +          os: ubuntu32
>            image: daald/ubuntu32:xenial
>          - jobname: pedantic
> +          os: fedora
>            image: fedora
>      env:
>        jobname: ${{matrix.vector.jobname}}
> @@ -310,6 +320,7 @@ jobs:
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

