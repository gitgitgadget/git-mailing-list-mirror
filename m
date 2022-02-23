Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3EAC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiBWMOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiBWMOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:14:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D39BBB5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:13:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j17so12573971wrc.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=abL4m1uDcbx78+YX+i9BrX1EVbxoDN6rBBy3YsKVXMk=;
        b=FtH2yATmI92S9DI4qqrJxfcgVoXSOQytE/1ByeYClSrmASAIpD6yZlGT1O3pghXCut
         4+bwUstTxujf+jsNxR93bcdwZM59S47Ss4sum5iXPpuFC6pL6nNOOZOQoss/FQVOFa3j
         ILzFpfM9+mZJYM7L6NOONL/JxQtTc9W4hSMDX6w6cY0QZ4SaKGHthGFwqW9VYXvaUs1u
         8bxUbEGK2TOHWPKfI2UJOPUa2RgVJfcZWSYTnE9zJgGYjrFZd6H7FMr243d/tZW/ge8B
         QqOll+JpfmpwbAg5FtceSv2wu09e8/jIhEkIjQjAYSpdtcoKjVpMMb6oG2mNG6ve6M8R
         WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=abL4m1uDcbx78+YX+i9BrX1EVbxoDN6rBBy3YsKVXMk=;
        b=Tu4WF7JXJCpKHvHJG1Fn8FSPkeG2ftYFmFmZ4ZN7yJg/R6TeKowAxgPNQFoM5o6Y29
         CdvKnuGRcL+KOIXryIek4D3yikOnVKhpj1VbzU9AtryntJs5Hl5IK66IV+Y0f5JdMxjl
         PDGxHbNzpUJCK4EYg2cmG3oH4uWvce82PYM4pxu/IMt9zqgpdmvlSDKg0krFN4PS0Inx
         a5f5p4LQCxOXbP1/OM3ebA3HZgHIGQWn79ndIPR5gRI89JofWYipZaVCrNJ0TITs5OOi
         77suvf7snfURqS54Hnkc+MldyMD72a1KtAKWSp2stcW27nx4EVhi0CSpydyCeX6g5LJZ
         WB7A==
X-Gm-Message-State: AOAM533NvZWXqLUviHhIuObF9E/moA+MXcT0YUaF1f+O24tL6s76+U7/
        Qr4S9Ciaqn2mM/ZcBPhiflU=
X-Google-Smtp-Source: ABdhPJze4Rkgv91uzoxCXMSkkqa3sgGSqDGJ+zvcB/lAx4PAmU0XNICiCWwOOSTSoty5RVYeQP4Zww==
X-Received: by 2002:a5d:6885:0:b0:1ed:c0bc:c205 with SMTP id h5-20020a5d6885000000b001edc0bcc205mr212495wru.683.1645618432875;
        Wed, 23 Feb 2022 04:13:52 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id x11sm5220250wmi.37.2022.02.23.04.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:13:52 -0800 (PST)
Message-ID: <f73586a9-e9f1-aa1d-ac22-8102e6583e2b@gmail.com>
Date:   Wed, 23 Feb 2022 12:13:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/9] ci/run-build-and-tests: add some structure to the
 GitHub workflow output
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 24/01/2022 18:56, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The current output of Git's GitHub workflow can be quite confusing,
> especially for contributors new to the project.
> 
> To make it more helpful, let's introduce some collapsible grouping.
> Initially, readers will see the high-level view of what actually
> happened (did the build fail, or the test suite?). To drill down, the
> respective group can be expanded.
> 
> Note: sadly, workflow output currently cannot contain any nested groups
> (see https://github.com/actions/runner/issues/802 for details),
> therefore we take pains to ensure to end any previous group before
> starting a new one.

Thanks for working on this, I find it makes it much easier to get to the 
information I need when a test fails. I'm not familiar with github's 
grouping but I noticed something below I didn't understand.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   ci/lib.sh                 | 55 ++++++++++++++++++++++++++++++++++-----
>   ci/run-build-and-tests.sh |  4 +--
>   ci/run-test-slice.sh      |  2 +-
>   3 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 2b2c0932320..4ed8f40ab02 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -1,5 +1,49 @@
>   # Library of functions shared by all CI scripts
>   
> +if test true != "$GITHUB_ACTIONS"
> +then
> +	begin_group () { :; }
> +	end_group () { :; }
> +
> +	group () {
> +		shift
> +		"$@"
> +	}
> +	set -x
> +else
> +	begin_group () {
> +		need_to_end_group=t
> +		echo "::group::$1" >&2
> +		set -x
> +	}
> +
> +	end_group () {
> +		test -n "$need_to_end_group" || return 0
> +		set +x
> +		need_to_end_group=
> +		echo '::endgroup::' >&2
> +	}
> +	trap end_group EXIT
> +
> +	group () {
> +		set +x
> +		begin_group "$1"
> +		shift
> +		"$@"
> +		res=$?
> +		end_group
> +		return $res
> +	}
> +
> +	begin_group "CI setup"
> +fi
> +
> +# Set 'exit on error' for all CI scripts to let the caller know that
> +# something went wrong.
> +# Set tracing executed commands, primarily setting environment variables
> +# and installing dependencies.
> +set -e

The comment is moved unchanged but the set command has lost the "-x". We 
now have several "set -x" commands in the functions above and one below 
"end_group" lower down. Does the comment need updating as we are not 
enabling the tracing of executed commands here anymore?

Best Wishes

Phillip

>   skip_branch_tip_with_tag () {
>   	# Sometimes, a branch is pushed at the same time the tag that points
>   	# at the same commit as the tip of the branch is pushed, and building
> @@ -88,12 +132,6 @@ export TERM=${TERM:-dumb}
>   # Clear MAKEFLAGS that may come from the outside world.
>   export MAKEFLAGS=
>   
> -# Set 'exit on error' for all CI scripts to let the caller know that
> -# something went wrong.
> -# Set tracing executed commands, primarily setting environment variables
> -# and installing dependencies.
> -set -ex
> -
>   if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
>   then
>   	CI_TYPE=azure-pipelines
> @@ -138,7 +176,7 @@ then
>   			test_name="${test_exit%.exit}"
>   			test_name="${test_name##*/}"
>   			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
> -			cat "t/test-results/$test_name.out"
> +			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
>   
>   			trash_dir="t/trash directory.$test_name"
>   			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
> @@ -234,3 +272,6 @@ linux-leaks)
>   esac
>   
>   MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> +
> +end_group
> +set -x
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index e49f9eaa8c0..5516f45f7fe 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -48,10 +48,10 @@ esac
>   # Any new "test" targets should not go after this "make", but should
>   # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
>   # start running tests.
> -make
> +group Build make
>   if test -n "$run_tests"
>   then
> -	make test ||
> +	group "Run tests" make test ||
>   	handle_failed_tests
>   fi
>   check_unignored_build_artifacts
> diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
> index 63358c23e11..a3c67956a8d 100755
> --- a/ci/run-test-slice.sh
> +++ b/ci/run-test-slice.sh
> @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>   *) ln -s "$cache_dir/.prove" t/.prove;;
>   esac
>   
> -make --quiet -C t T="$(cd t &&
> +group "Run tests" make --quiet -C t T="$(cd t &&
>   	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
>   	tr '\n' ' ')" ||
>   handle_failed_tests

