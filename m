Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A281F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfFMPeB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:34:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55673 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733051AbfFMPeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 11:34:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so10667727wmj.5
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BiDAQZjlaiRyOA7p70n0Ehzh65YFu1+MVwGyRT9/OSk=;
        b=gNXDUmK/+/DOwWQVOx2P2Lu9gJtdvRIYYIAae0pte4yochF3E3odacC4iKxvzIzLlS
         QEed7RzaTO9yUnjIoG2U+nA8h9/NP+uyO5v9QuSbOmrGfufSryDrQM5mBteaz2FmS5HI
         WIMdDxAzlGDNR5W4NzmeGt46YxK+BK2i2Z92XD9JqMduG/VBZP/F1dhCYutogO/a5SJu
         nMtLEj+CKFdZdp7688T09M7WkjwuxYhqV3k1ddrbFMV1WhQ2KKm+ELepPZL925iC30VO
         q5hSP+7e8S/qYUJeItdkNNkuBI4lWLPY2P4biuO83ATL65qMNq0IdkOnOTaJBB8jDWqz
         MSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BiDAQZjlaiRyOA7p70n0Ehzh65YFu1+MVwGyRT9/OSk=;
        b=Jg2gaHOT7OoUFQAQrtPMr3svmS/1eElmwtFNheUSoGvpnaEYeZQcqqEbrRpBGH1ZWS
         XfzxKjk4g9axRQejrU8UL3CZRvU8RWzycO9sMgEx3jylBTqlFs+caw6ZNhFGGPy+hUn4
         3Qwr/zd1B8nNTbLiHGtaHqfNXavVfd21QUCzuzGIx/poEmMF9KHC0DQBw3EoIBut7X49
         Tb1XXWlVwU7jL01u3PdsctsxTvExnWu+na9z+K34pLWrFaoKsZfB52FFTmiCX8Gt592g
         CnOS2KSAApdnmPaSOoTFw0U8ACMdxNNI10+COuKzrW1cKFFYfY3dFMLVLwDq+MTf8Ae1
         nJ3A==
X-Gm-Message-State: APjAAAVyxv4abTPd174vdwqLOu1OsJtg4YmI2KSh35CtYTfrHOH751gC
        LJ1YZsPCKf1+rR4U6ALwb28=
X-Google-Smtp-Source: APXvYqx84mQgXCcYb3j5/SGNmhxzamEMI2ixU8dIVihxzRUpKQpQeLJS/FcU7xQzjRpBBl/ukhxerw==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr4407148wml.45.1560440037678;
        Thu, 13 Jun 2019 08:33:57 -0700 (PDT)
Received: from szeder.dev (x4dbd2f68.dyn.telefonica.de. [77.189.47.104])
        by smtp.gmail.com with ESMTPSA id u11sm20295wrn.1.2019.06.13.08.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:33:56 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:33:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
Message-ID: <20190613153354.GC31952@szeder.dev>
References: <pull.266.git.gitgitgadget@gmail.com>
 <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 05:53:51AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This job was abused to not only run the test suite in a regular way but
> also with all kinds of `GIT_TEST_*` options set to non-default values.
> 
> Let's split this into two

Why...?

> with the `linux-gcc` job running the default
> test suite, and the newly-introduced `linux-gcc-extra` job running the
> test suite in the "special" ways.
> 
> Technically, we would have to build Git only once, but it would not be
> obvious how to teach Travis to transport build artifacts, so we keep it
> simple and just build Git in both jobs.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .travis.yml                |  4 ++++
>  azure-pipelines.yml        | 39 ++++++++++++++++++++++++++++++++++++++
>  ci/install-dependencies.sh |  4 ++--
>  ci/lib.sh                  |  4 ++--
>  ci/run-build-and-tests.sh  |  5 ++---
>  5 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index ffb1bc46f2..a6444ee3ab 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -16,6 +16,10 @@ compiler:
>  
>  matrix:
>    include:
> +    - env: jobname=linux-gcc-extra
> +      os: linux
> +      compiler: gcc
> +      addons:
>      - env: jobname=GIT_TEST_GETTEXT_POISON
>        os: linux
>        compiler:
> diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> index c329b7218b..4080aa3c45 100644
> --- a/azure-pipelines.yml
> +++ b/azure-pipelines.yml
> @@ -206,6 +206,45 @@ jobs:
>        PathtoPublish: t/failed-test-artifacts
>        ArtifactName: failed-test-artifacts
>  
> +- job: linux_gcc_extra
> +  displayName: linux-gcc-extra
> +  condition: succeeded()
> +  pool: Hosted Ubuntu 1604
> +  steps:
> +  - bash: |
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> +
> +       sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
> +       sudo apt-get update &&
> +       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 || exit 1

This installs packages that will be installed by
'ci/install-dependencies.sh' anyway.

> +
> +       export jobname=linux-gcc-extra &&
> +
> +       ci/install-dependencies.sh || exit 1
> +       ci/run-build-and-tests.sh || {
> +           ci/print-test-failures.sh
> +           exit 1
> +       }
> +
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
> +    displayName: 'ci/run-build-and-tests.sh'
> +    env:
> +      GITFILESHAREPWD: $(gitfileshare.pwd)
> +  - task: PublishTestResults@2
> +    displayName: 'Publish Test Results **/TEST-*.xml'
> +    inputs:
> +      mergeTestResults: true
> +      testRunTitle: 'linux-gcc-extra'
> +      platform: Linux
> +      publishRunAttachments: false
> +    condition: succeededOrFailed()
> +  - task: PublishBuildArtifacts@1
> +    displayName: 'Publish trash directories of failed tests'
> +    condition: failed()
> +    inputs:
> +      PathtoPublish: t/failed-test-artifacts
> +      ArtifactName: failed-test-artifacts
> +
>  - job: osx_clang
>    displayName: osx-clang
>    condition: succeeded()
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 7f6acdd803..c25bdcdf66 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -9,12 +9,12 @@ P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
>  LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
>  
>  case "$jobname" in
> -linux-clang|linux-gcc)
> +linux-clang|linux-gcc|linux-gcc-extra)
>  	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
>  	case "$jobname" in
> -	linux-gcc)
> +	linux-gcc|linux-gcc-extra)
>  		sudo apt-get -q -y install gcc-8
>  		;;
>  	esac
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 288a5b3884..b16a1454f1 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -154,8 +154,8 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_TEST_CLONE_2GB=YesPlease
>  
>  case "$jobname" in
> -linux-clang|linux-gcc)
> -	if [ "$jobname" = linux-gcc ]
> +linux-clang|linux-gcc|linux-gcc-extra)
> +	if [ "$jobname" = linux-gcc -o "$jobname" = linux-gcc-extra ]
>  	then
>  		export CC=gcc-8
>  	fi
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index cdd2913440..b252ff859d 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -11,8 +11,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  esac
>  
>  make
> -make test
> -if test "$jobname" = "linux-gcc"
> +if test "$jobname" = "linux-gcc-extra"
>  then
>  	export GIT_TEST_SPLIT_INDEX=yes
>  	export GIT_TEST_FULL_IN_PACK_ARRAY=true
> @@ -20,8 +19,8 @@ then
>  	export GIT_TEST_OE_DELTA_SIZE=5
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
> -	make test
>  fi
> +make test
>  
>  check_unignored_build_artifacts
>  
> -- 
> gitgitgadget
