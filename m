Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32468C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 12:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiHKM7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHKM7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 08:59:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32312792C7
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 05:59:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay12so6616938wmb.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=Ezzgn26UITYMxJ2EBbIGjqMQh5yKF5gU5NBuldKIvJ4=;
        b=mNfHIXtriroJSzao6jb5TINO08bt8/cGm92PV4WP18/jiW154hJY59tmHPthCikIzV
         Q0XantT+N+3D9Z3kyA59Hh9AW5e3kF7d2E7LRCz4aZskNImkZB/tg01PZ6URgaHaFPQA
         DwD8l7NYmWb5hRieWW6fBtkWc5Bca/7v7UW7STJLPtUHOTKMqelzekTlCiMT1UKOpW6G
         G+ynhTP/RFW0Yv4Lcdzh1OsuJ4A8xNySGk0gCUJduMjmFtSwweHfuNvee3v98eDLhCuk
         yYf0LJfZxR6omjXEsgoENKWeU1TJq7GE8BNRXK3wpktR633DUMGXXViyNTPaM/7KkvL5
         7MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Ezzgn26UITYMxJ2EBbIGjqMQh5yKF5gU5NBuldKIvJ4=;
        b=fgqCuAE/jgSGhDQpmD1Q0Ye1bz7MIAK8BkjQ8nnb9USPGallo7Nwb/7zOdpyi3gnrt
         dI1tNM0aTGsNDWgGAAbYERexrq5ROYuZuptizYv/tv0Dk5iFwZEOz3jJn8CFoU9QJ13x
         +F7Z2IXfN1dvj1qBzI2OCut9NA9xCJRjKrBFmE4511CM60nQS0AyvoxAcwt6Aca00MSf
         HnTYXYclb3x3LKeUwRmr2V79qbpEwpDN4YOVfly/VkLveKdYuDv4jh0cMD85sL1ZlmxI
         bOoH5ZP7jbL6JjW3/FF0NoMdWYWq1OtC6rS238DCxp0EgLGiMfMOTU4tpiDR2AVbgh9n
         ozfQ==
X-Gm-Message-State: ACgBeo165I4rDlv0cDzoUQ9pUhlpPrjDsfAgT6V/wGMRmIHK8qae8ljl
        qJ6M47hnIET+Bk+piFq7X2Y=
X-Google-Smtp-Source: AA6agR4TvGrRenvtKfDqrw0Xex0BG7NwUf1W0vhCMZRP4qZimG0EipOW6gMftKS+mTQeZjqYMtC6lQ==
X-Received: by 2002:a7b:ce02:0:b0:3a5:47a:3897 with SMTP id m2-20020a7bce02000000b003a5047a3897mr5610555wmc.102.1660222747548;
        Thu, 11 Aug 2022 05:59:07 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id ba5-20020a0560001c0500b0021efc75914esm20009981wrb.79.2022.08.11.05.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:59:07 -0700 (PDT)
Message-ID: <23d86b94-3e2e-bdeb-3385-a996c07b699d@gmail.com>
Date:   Thu, 11 Aug 2022 13:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] cmake: avoid editing t/test-lib.sh
Content-Language: en-GB-large
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 7f5397a07c6c (cmake: support for testing git when building out of the
> source tree, 2020-06-26), we implemented support for running Git's test
> scripts even after building Git in a different directory than the source
> directory.
> 
> The way we did this was to edit the file `t/test-lib.sh` to override
> `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> directory.
> 
> This is unideal because it always leaves a tracked file marked as
> modified, and it is all too easy to commit that change by mistake.
> 
> Let's change the strategy by teaching `t/test-lib.sh` to detect the
> presence of a file called `GIT-BUILD-DIR` in the source directory. If it
> exists, the contents are interpreted as the location to the _actual_
> build directory. We then write this file as part of the CTest
> definition.

I think it is really good to get away from editing the test files, but 
one of the nice things about CMake's out of tree builds is that you can 
have several build directories with different build configurations and 
this change does not support that. Could we pass the build directory to 
the test scripts as a commandline option or environment variable 
instead? e.g.

   foreach(tsh ${test_scipts})
    	add_test(NAME ${tsh}
-		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
+		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint 
--build-dir=${CMAKE_BINARY_DIR} -vx

   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
   endforeach()

Doing that would avoid changing the main Makefile to remove a file which 
almost certainly does not exist every time make is invoked as well.

Best Wishes

Phillip

> To support building Git via a regular `make` invocation after building
> it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
> convenience, this is done as part of the Makefile rule that is already
> run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> up to date).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   .gitignore                          |  1 +
>   Makefile                            |  1 +
>   contrib/buildsystems/CMakeLists.txt |  7 +------
>   t/test-lib.sh                       | 11 ++++++++++-
>   4 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index a4522157641..b72ddf09346 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,6 +2,7 @@
>   /fuzz_corpora
>   /fuzz-pack-headers
>   /fuzz-pack-idx
> +/GIT-BUILD-DIR
>   /GIT-BUILD-OPTIONS
>   /GIT-CFLAGS
>   /GIT-LDFLAGS
> diff --git a/Makefile b/Makefile
> index 04d0fd1fe60..9347ed90da7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3028,6 +3028,7 @@ else
>   	@echo RUNTIME_PREFIX=\'false\' >>$@+
>   endif
>   	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
>   
>   ### Detect Python interpreter path changes
>   ifndef NO_PYTHON
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index fe606c179f7..29d7e236ae1 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1067,14 +1067,9 @@ endif()
>   #Make the tests work when building out of the source tree
>   get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
>   if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
>   	#Setting the build directory in test-lib.sh before running tests
>   	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
>   	#misc copies
>   	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
>   	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 55857af601b..4468ac51f25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -42,7 +42,16 @@ then
>   	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>   fi
>   GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
> -if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> +then
> +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> +	# On Windows, we must convert Windows paths lest they contain a colon
> +	case "$(uname -s)" in
> +	*MINGW*)
> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> +		;;
> +	esac
> +elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>   then
>   	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>   	exit 1
