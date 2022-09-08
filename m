Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F9C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 23:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIHXiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIHXh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 19:37:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB8620F51
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 16:37:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e5so40286pfl.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/AD7Pyw3eIIdFn/avbtPpydl5kX8qY1aSRrTxXULs+0=;
        b=aClOJFxyzFz4TIKuiq5I+JHPgPLBMhAkSTaMYqLXkHqRLIDrJNpbqrrShK1W6E2AZc
         jzIlWLrvCCeQdfrGQC9Kk5ts6WlhdsGvnmBMi1dHXY2k/gMbhnGwDAShsJTn/n/xZyMJ
         fJLbYKPKE8902+bhfCEdl1zC+LFvQRjseXo7/BbuBSeo+8sqG+S9uWYeEpyXrqYzKjLh
         LDuWl0LM3xnAinLIqs8RQ4/fYK4Q+EmZc6zwcM2VFgWf8Nq6Vgm4lsrrvqFpnUkXiQPD
         8wgGCHA5WrBn7Ifkg0Ri9hGNcXny5YGMsYT9otw/Mc2ZoQrPoGxFhaGFo+yHgcviTfSX
         j4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/AD7Pyw3eIIdFn/avbtPpydl5kX8qY1aSRrTxXULs+0=;
        b=U0D5YOMrMNDwgXU7ryfsAdtL7eMY+d076G3OJ+DPJAkeIQJ5IX+RsghqS6HBTPP571
         xSDK3MP/nGDjyoR+HpRP+Hk9o/t88uH6dGVrI2TSht8NHJCd1PbaSMbMVMKyT7Yj7O1n
         ksjROQVs5kwhCtHdokXCRlCVT/Tq1b30PS269/b8ZwQ4mA4KDPi2eLrJLMJVwccZ43KH
         OiQGhqp60v8I5mOE5LqhIgloXaeDe8jsLvjro1cFnRRNl80A6Hy0Rra3fPMp+NrnoE9c
         J46cRe4+xQI2O62lmSLG4cRQ9HpixcfsH6cwFxLdb6LK7Xn3++zf5xkOiPRZ0YUPd0um
         ChOw==
X-Gm-Message-State: ACgBeo1b/El5M8143K5fwTM2oGE4gzTzp8kEiBVh/XJkzhuuyn0URI1h
        Rkg3NJXdDkPLgXM8s2EKHiU7
X-Google-Smtp-Source: AA6agR70dEF8fKSNNWEjar0a7xYHcnmsvC/aY2e71r2ISvKjSRwRvMGjapRp3PEP1j4FHzn9sY4whA==
X-Received: by 2002:a05:6a00:10c7:b0:4fe:5d:75c8 with SMTP id d7-20020a056a0010c700b004fe005d75c8mr11605314pfu.6.1662680267919;
        Thu, 08 Sep 2022 16:37:47 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w76-20020a627b4f000000b0052d46b43006sm168591pfc.156.2022.09.08.16.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:37:47 -0700 (PDT)
Message-ID: <531620e1-de4c-74aa-c840-c12ce81f8740@github.com>
Date:   Thu, 8 Sep 2022 16:37:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget wrote:
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
> 
> To support building Git via a regular `make` invocation after building
> it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
> convenience, this is done as part of the Makefile rule that is already
> run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> up to date).

While I like that this removes a user error case, it sacrifices some of the
separation between contrib/ and the main Git tree by adding logic to
'test-lib.sh' that only really benefits the CMake build.

To your point in [1]:

> Can we maybe agree that the proposed patch is a net improvement over the
> status quo, and think about a better solution independently (without
> blocking this here patch)?

I don't think it does more harm than good, but I wouldn't go so far as to
call it a definitive "net improvement." I'd personally very much prefer a
solution that didn't involve adding 'GIT-BUILD-DIR' just for the sake of
CMake. Unfortunately, after spending a pretty substantial amount of time
looking for an alternative, I couldn't think of anything that didn't either
1) change how users ran tests or 2) change where CMake builds wrote Git's
binary files. 

So, I could go either way on this patch - if others feel strongly that it
should be dropped, I'll defer to that. Otherwise, I'm fine keeping it unless
someone can think of a better alternative.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore                          |  1 +
>  Makefile                            |  1 +
>  contrib/buildsystems/CMakeLists.txt |  7 +------
>  t/test-lib.sh                       | 11 ++++++++++-
>  4 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index a4522157641..b72ddf09346 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,6 +2,7 @@
>  /fuzz_corpora
>  /fuzz-pack-headers
>  /fuzz-pack-idx
> +/GIT-BUILD-DIR
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
>  /GIT-LDFLAGS
> diff --git a/Makefile b/Makefile
> index 04d0fd1fe60..9347ed90da7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3028,6 +3028,7 @@ else
>  	@echo RUNTIME_PREFIX=\'false\' >>$@+
>  endif
>  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
>  
>  ### Detect Python interpreter path changes
>  ifndef NO_PYTHON
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index fe606c179f7..29d7e236ae1 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1067,14 +1067,9 @@ endif()
>  #Make the tests work when building out of the source tree
>  get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
>  if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
>  	#Setting the build directory in test-lib.sh before running tests
>  	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
>  	#misc copies
>  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
>  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 55857af601b..4468ac51f25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -42,7 +42,16 @@ then
>  	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>  fi
>  GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
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
>  then
>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>  	exit 1
Referring to Ævar's review in [1] - while I'm not overly concerned about the
"switching between make & CMake" file staleness (if I'm not mistaken, the
same thing can happen now with the modified 'test-lib.sh', so this patch
doesn't really make anything worse), I do think the changes to 'test-lib.sh'
should be rearranged to preserve the "PANIC" check:

----------------->8----------------->8----------------->8-----------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4468ac51f2..7b57f55c37 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -42,6 +42,11 @@ then
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
 GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
+then
+	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
+	exit 1
+fi
 if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
 then
 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
@@ -51,10 +56,6 @@ then
 		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
 		;;
 	esac
-elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
-then
-	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
-	exit 1
 fi
 
 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
-----------------8<-----------------8<-----------------8<-----------------

Otherwise, a user could run the tests from outside a 't/' directory if they
built Git with CMake, which doesn't appear to be part of the intended
behavior of this patch.
