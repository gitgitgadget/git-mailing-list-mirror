Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A43717D
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705848610; cv=none; b=E+gZNJnUoH4xGvlnEnThAkMT2a+B4vmbYZ5olpeGCZYJo8zo114yuM/Xejk3SqYTrikNtqTNKhVwXXnckApdIuCtn1wYY0+5yC9i8umPc4J7v7wgW9a38yD/b4K/2a0kF7knsetaEmkA4P+sL9miajIQF+en5ixQZVfzLys8kX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705848610; c=relaxed/simple;
	bh=6Hzkm4dKat/QavaIMenNLHDeh5eU6GJnFSEHG93E/1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLIYrzD7zG7yMV+f4Zy5KwtrdrMGnJm/rDQNmVvy1Ct2ghIH6S/Mu7SwdBWuVN8jcG95ACDGjlgFVC7inRmmXMTIUnvSTRhRixMuascTo4G+16WcyieTy3ScMAPSJkGcBJruZsLCeH0w8N5ixR2+9673P/5MTD7xihh35HOrChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6l2J1DT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6l2J1DT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so28699075e9.1
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705848607; x=1706453407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mihwvrwagR0879y9QZYEFKoebQptrI11T3EAv89YX8s=;
        b=a6l2J1DTCFP79PtnI9l62ID6eT8Uv73es4DOm+qfjwOssNfKmzX8nN6U0rdk562EkT
         zB+YZFJEo0GBlM+RrorHRq/sTlmW+MR/Cz9IfL5ZrdxlFmicI11e3Xo6YAVN44/IRAC8
         EoC9LTG0INdNOEbNS2JU966N4550QpOfiORvHACdfNEmmfJ1rUxkKXdg30u7xVEMspcL
         HZmlzVl4S+05TNRBhtSaD+3oBoaXiOFyT8VU70PAaGsxqBOyq7q5TIvgAwMxqusxzB2G
         47gLxwX4oTinFdlXvv+19rqm9WLYHCyWlIFwoQro2Md5T5GpPp49ozk31FIGujvtppHy
         wGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705848607; x=1706453407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mihwvrwagR0879y9QZYEFKoebQptrI11T3EAv89YX8s=;
        b=PUQ4uydS7JFGzRVY2/URFa7yEpuI2/ytQegQCFb5W0FOJG44AEzm7OGAn/DfBAXke/
         ZhFWyuXjKMj7WuB7Tbr01hToiCjM/hFwIE/KVzgWVGQLEKMc9XE03x29Rc5BVmo1/6Mr
         +hMb9YD7Sl/dxCQgm3iuQgHOlTSUq8aqBZPe35E5IiGsO6FmpBFTCTdc5C8f7BWRSEZf
         idhhsRZbHqzMUlz/fM2arSjswgpBhBZL/qMDztJLnvOGICyIVtAOtdmCUDYaEEoon1/y
         +aFz/3QvAQKSKld2Nu6CemBv1KWuOBjGNfor3fnL9VI8rP9TVqqhJBDbWVgYIIN2i3Wl
         g4eA==
X-Gm-Message-State: AOJu0Yz8lOFuJCrDOv73NRTA1fB/9C/cKadkqTC8M/Tvk82lBZwtv1t4
	kL/GWdThbXvsNH1lfN00uV/eAuabeWUoMX6D4gML1ENY3uZ3rENiDFG2ngdr
X-Google-Smtp-Source: AGHT+IHtsCNci3XkHLmn+mSO0bj3rqmYepyPfx6BnD9aR1W3jZhQvo9D8JENkywsko2HtFfdz7RSqA==
X-Received: by 2002:a05:600c:2219:b0:40e:43a0:2a0e with SMTP id z25-20020a05600c221900b0040e43a02a0emr1143382wml.223.1705848606735;
        Sun, 21 Jan 2024 06:50:06 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e45799541sm39630598wmo.15.2024.01.21.06.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 06:50:06 -0800 (PST)
Message-ID: <6e190a32-ee45-451b-b841-25cc6eb2c5ab@gmail.com>
Date: Sun, 21 Jan 2024 14:50:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] ci: add support for macOS to GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
References: <cover.1705318985.git.ps@pks.im> <cover.1705573336.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover.1705573336.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 18/01/2024 10:22, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that adds a macOS job to
> GitLab CI. Changes compared to v1:
> 
>    - Added a fix for a flaky test in t7527 that caused the pipeline to
>      fail in ~50% of all runs.
> 
>    - Improved some commit messages.
> 
>    - Tests now write test data into a RAMDisk. This speeds up tests and
>      fixes some hung pipelines I was seeing.
> 
> Thanks for your reviews so far!

I've read though all the patches and they seem sensible to me though I'm 
hardly a macOS expert. I did wonder about the use of pushd/popd in the 
fourth patch as they are bashisms but that matches what we're doing on 
Ubuntu already. It's nice to see the GitLab CI running on macOS as well 
as Linux now.

Best Wishes

Phillip

> Patrick
> 
> Patrick Steinhardt (5):
>    t7527: decrease likelihood of racing with fsmonitor daemon
>    Makefile: detect new Homebrew location for ARM-based Macs
>    ci: handle TEST_OUTPUT_DIRECTORY when printing test failures
>    ci: make p4 setup on macOS more robust
>    ci: add macOS jobs to GitLab CI
> 
>   .gitlab-ci.yml               | 34 +++++++++++++++++++++++++++++++++-
>   ci/install-dependencies.sh   | 10 ++++------
>   ci/lib.sh                    | 12 +++++++++++-
>   ci/print-test-failures.sh    |  2 +-
>   config.mak.uname             | 13 +++++++++++++
>   t/t7527-builtin-fsmonitor.sh |  2 +-
>   6 files changed, 63 insertions(+), 10 deletions(-)
> 
> Range-diff against v1:
> -:  ---------- > 1:  554b1c8546 t7527: decrease likelihood of racing with fsmonitor daemon
> 2:  3adb0b7ae8 = 2:  32d8bd1d78 Makefile: detect new Homebrew location for ARM-based Macs
> -:  ---------- > 3:  d55da77747 ci: handle TEST_OUTPUT_DIRECTORY when printing test failures
> 1:  a5d725bea7 ! 4:  1ed6e68650 ci: make p4 setup on macOS more robust
>      @@ Commit message
>           into a separate directory which we then manually append to our PATH.
>           This matches what we do on Linux-based jobs.
>       
>      +    Note that it may seem like we already did append "$HOME/bin" to PATH
>      +    because we're actually removing the lines that adapt PATH. But we only
>      +    ever adapted the PATH variable in "ci/install-dependencies.sh", and
>      +    didn't adapt it when running "ci/run-build-and-test.sh". Consequently,
>      +    the required binaries wouldn't be found during the test run unless the
>      +    CI platform already had the "$HOME/bin" in PATH right from the start.
>      +
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>        ## ci/install-dependencies.sh ##
> 3:  d196cfd9d0 ! 5:  c5ed38f0a6 ci: add macOS jobs to GitLab CI
>      @@ Metadata
>        ## Commit message ##
>           ci: add macOS jobs to GitLab CI
>       
>      -    Add two macOS-based jobs to GitLab CI, one for Clang and one for GCC.
>      -    This matches equivalent jobs we have for GitHub Workflows, except that
>      -    we use macOS 14 instead of macOS 13.
>      +    Add a job to GitLab CI which runs tests on macOS, which matches the
>      +    equivalent "osx-clang" job that we have for GitHub Workflows. One
>      +    significant difference though is that this new job runs on Apple M1
>      +    machines and thus uses the "arm64" architecture. As GCC does not yet
>      +    support this comparatively new architecture we cannot easily include an
>      +    equivalent for the "osx-gcc" job that exists in GitHub Workflows.
>       
>           Note that one test marked as `test_must_fail` is surprisingly passing:
>       
>             t7815-grep-binary.sh                             (Wstat: 0 Tests: 22 Failed: 0)
>               TODO passed:   12
>       
>      -    This seems to boil down to an unexpected difference in how regcomp(1)
>      +    This seems to boil down to an unexpected difference in how regcomp(3P)
>           works when matching NUL bytes. Cross-checking with the respective GitHub
>      -    job shows though that this is not an issue unique to the GitLab CI job
>      -    as it passes in the same way there.
>      -
>      -    Further note that we do not include the equivalent for the "osx-gcc" job
>      -    that we use with GitHub Workflows. This is because the runner for macOS
>      -    on GitLab is running on Apple M1 machines and thus uses the "arm64"
>      -    architecture. GCC does not support this platform yet.
>      +    job shows that this is not an issue unique to the GitLab CI job as it
>      +    passes in the same way there.
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>      @@ .gitlab-ci.yml: test:
>       +  image: $image
>       +  tags:
>       +    - saas-macos-medium-m1
>      ++  variables:
>      ++    TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"
>       +  before_script:
>      ++    # Create a 4GB RAM disk that we use to store test output on. This small hack
>      ++    # significantly speeds up tests by more than a factor of 2 because the
>      ++    # macOS runners use network-attached storage as disks, which is _really_
>      ++    # slow with the many small writes that our tests do.
>      ++    - sudo diskutil apfs create $(hdiutil attach -nomount ram://8192000) RAMDisk
>       +    - ./ci/install-dependencies.sh
>       +  script:
>       +    - ./ci/run-build-and-tests.sh
>      @@ .gitlab-ci.yml: test:
>       +      if test "$CI_JOB_STATUS" != 'success'
>       +      then
>       +        ./ci/print-test-failures.sh
>      ++        mv "$TEST_OUTPUT_DIRECTORY"/failed-test-artifacts t/
>       +      fi
>       +  parallel:
>       +    matrix:
> 
> base-commit: cd69c635a1a62b0c8bfdbf221778be8a512ad048
