Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70806C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 23:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIHXmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIHXmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 19:42:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A1FA1A73
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 16:42:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c198so9728pfc.13
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=s9YcfHSQtr9XkFAswOOSFi0UNZcMT1ebX1E+yDHF6Sg=;
        b=YqmWM6hJ457hcTab45ZlV+8kKJZeKiaOIdgI8lPRthTKbYz1RhhCHfjlEZ1JvqOD0+
         dWOD8o8vJryn9thVAoXNcYxPnAZGrdNv9c8nFqE6ouzE8w65GGOq7laXt007dAC6PPbP
         B6x52NeFrasoTqkitNiAW5Hvmg3LE21GNz1WlNMqKVqwRX+ES543cRGoWs1G5dqk82IO
         qxdjvbkoaRQy4RYV3vTjqaIHSd0hz1G06sisdLTSavkHpHkhz/Prb5TrW825JycKkpEA
         wnXN7x4lZ/ainjqifwH1O2M/PJe7n86qcdkKMcwrZgs7Oo6AXNtZOefLe2/qIaptPug1
         SD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s9YcfHSQtr9XkFAswOOSFi0UNZcMT1ebX1E+yDHF6Sg=;
        b=wPX2mOTb/ZuhRDax6GgcjohfO48uXWqKZtW4qgoL5Q+Y7sGTWTlgctf7XVq3i11sAL
         U/SLWsKMxO5L8bfWZyRSrpVC3My8objjDGSgLQtLtjyxpKR7IJ2cLTRguzUgI2Gloh2k
         rvIx1M0KQuus8U/9tItkWtI1hsRzcproXrvUX/Hte6SKa0afKMspa7JRi/jGvsujBZHJ
         UZ5lk5c90BLM/33TFKb9SMy91ZlwA5MzA0GXw9dj+YRGWC5Ghegr/p6xAUUlEwZ0Ev4l
         LIQKVdHiRNgh44wCwuBU0I2/b5YSRh4//jpXagwcgrNGE/4NDx6suww1bpKLAFdt970D
         j1EQ==
X-Gm-Message-State: ACgBeo2kQf46A42p4a4r/SU6tKUZAUbmFVdQ3+1kK+rGqo+PGXSBQYT9
        4alPxXDKN5GnNhvjdqf/4SSNsl5c8MsL
X-Google-Smtp-Source: AA6agR7XuIxbldRnx2YntL5JDbw1gm1k+wHYcWMn/uh6ZP9vOmfIRlY8AJ+OgSaXvEHagEBhiK/30g==
X-Received: by 2002:a63:5f0f:0:b0:434:fe5a:91c6 with SMTP id t15-20020a635f0f000000b00434fe5a91c6mr7562585pgb.188.1662680555109;
        Thu, 08 Sep 2022 16:42:35 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b00177e5d83d3esm88034plg.88.2022.09.08.16.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:42:34 -0700 (PDT)
Message-ID: <dfd01ce9-bde6-9217-c2c4-556ddb69d7d7@github.com>
Date:   Thu, 8 Sep 2022 16:42:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
 <531620e1-de4c-74aa-c840-c12ce81f8740@github.com>
In-Reply-To: <531620e1-de4c-74aa-c840-c12ce81f8740@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye wrote:
> Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> In 7f5397a07c6c (cmake: support for testing git when building out of the
>> source tree, 2020-06-26), we implemented support for running Git's test
>> scripts even after building Git in a different directory than the source
>> directory.
>>
>> The way we did this was to edit the file `t/test-lib.sh` to override
>> `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
>> directory.
>>
>> This is unideal because it always leaves a tracked file marked as
>> modified, and it is all too easy to commit that change by mistake.
>>
>> Let's change the strategy by teaching `t/test-lib.sh` to detect the
>> presence of a file called `GIT-BUILD-DIR` in the source directory. If it
>> exists, the contents are interpreted as the location to the _actual_
>> build directory. We then write this file as part of the CTest
>> definition.
>>
>> To support building Git via a regular `make` invocation after building
>> it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
>> convenience, this is done as part of the Makefile rule that is already
>> run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
>> up to date).
> 
> While I like that this removes a user error case, it sacrifices some of the
> separation between contrib/ and the main Git tree by adding logic to
> 'test-lib.sh' that only really benefits the CMake build.
> 
> To your point in [1]:

Forgot this link: https://lore.kernel.org/git/8o4q98s3-sr2r-34qq-p7pr-8o44061o0n76@tzk.qr/

> 
>> Can we maybe agree that the proposed patch is a net improvement over the
>> status quo, and think about a better solution independently (without
>> blocking this here patch)?
> 
> I don't think it does more harm than good, but I wouldn't go so far as to
> call it a definitive "net improvement." I'd personally very much prefer a
> solution that didn't involve adding 'GIT-BUILD-DIR' just for the sake of
> CMake. Unfortunately, after spending a pretty substantial amount of time
> looking for an alternative, I couldn't think of anything that didn't either
> 1) change how users ran tests or 2) change where CMake builds wrote Git's
> binary files. 
> 
> So, I could go either way on this patch - if others feel strongly that it
> should be dropped, I'll defer to that. Otherwise, I'm fine keeping it unless
> someone can think of a better alternative.
> 
...

>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 55857af601b..4468ac51f25 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -42,7 +42,16 @@ then
>>  	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>>  fi
>>  GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
>> -if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
>> +then
>> +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
>> +	# On Windows, we must convert Windows paths lest they contain a colon
>> +	case "$(uname -s)" in
>> +	*MINGW*)
>> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
>> +		;;
>> +	esac
>> +elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>>  then
>>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>>  	exit 1
> Referring to Ævar's review in [1] - while I'm not overly concerned about the

AND this one (which should be [2]): https://lore.kernel.org/git/220811.86sfm3ov5z.gmgdl@evledraar.gmail.com/

Sorry about that!

> "switching between make & CMake" file staleness (if I'm not mistaken, the
> same thing can happen now with the modified 'test-lib.sh', so this patch
> doesn't really make anything worse), I do think the changes to 'test-lib.sh'
> should be rearranged to preserve the "PANIC" check:
> 
> ----------------->8----------------->8----------------->8-----------------
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4468ac51f2..7b57f55c37 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -42,6 +42,11 @@ then
>  	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>  fi
>  GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
> +if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> +then
> +	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
> +	exit 1
> +fi
>  if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
>  then
>  	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> @@ -51,10 +56,6 @@ then
>  		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
>  		;;
>  	esac
> -elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> -then
> -	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
> -	exit 1
>  fi
>  
>  # Prepend a string to a VAR using an arbitrary ":" delimiter, not
> -----------------8<-----------------8<-----------------8<-----------------
> 
> Otherwise, a user could run the tests from outside a 't/' directory if they
> built Git with CMake, which doesn't appear to be part of the intended
> behavior of this patch.

