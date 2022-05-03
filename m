Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40FC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 14:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbiECOHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 10:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiECOHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 10:07:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923E32EFB
        for <git@vger.kernel.org>; Tue,  3 May 2022 07:04:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q20so9961188wmq.1
        for <git@vger.kernel.org>; Tue, 03 May 2022 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4gCplnR9vG0ig4feQ9P+3Sfom8l4Q+wLF4R3NxuHUw8=;
        b=PJzwuR3awG0Jg+teALLpLpYBsPa/eqb/iqoz0Wbi46ziUA+Gz2qiofJInPmURoZK8n
         QT8HStBSZsSSxgLWGgyaaF3fqmzbM+hIv8RHVILyvXkVAbQbatkSwlsDklOi2J4nJU8/
         vErt5IywUP7Cb/BlSMd/a6pHSoum9hRnIbEneK48T2xKQ9grDStmjypSDRj65SF1k9hb
         022Sde7tj3n5Iee68q0U8O9Ug8jKDkx7kVyOqcAeqv5ZCx5zr0/g0kmh9318eYh8YxOc
         zNTz1UQHF2T8yFTTTX+odWVx24h/ZvhUdYqAfnojeYLjyqnvQDfpW+8RU2No6v8VNSPN
         FMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4gCplnR9vG0ig4feQ9P+3Sfom8l4Q+wLF4R3NxuHUw8=;
        b=IWnti+tcCoL+CZZrc1BXawRvTwwVr0HN8qsuqeOHMnPZoaNU+H4YoT+CWz6I9whxrK
         muTd4MvVbtsae9LCXncFWQufmNEN5fJm1qjpkGODIQQEn3ZKZL3haDSPeK4deRVAEiXF
         24i1anljfTcYVcdHKrQJeuFya4LL2o6Fzd6UVgWrNVGWpkuMzNZFwNTk4pX0bxHC3AF/
         Eo422/g8sc1dsADAx+QEAzR8j7H998XHjFaP4L2ZobqIS3I5iYW11vXewqLRiFm4db8/
         x+Apd8MiQFUGa8AQxBI7Qs87MFFdWe/ZP4qQ9Xl7aWQaod+W3ZYJsT8AfOto/MRJY8kS
         bWAA==
X-Gm-Message-State: AOAM531uSPDXPMrP2Dx0znTIb0IfRPnlNKxzWn4uJyZ/jKqd/+KrI/53
        +EQMcLHqMuxYQRFCrgNnXUb52UdSwF4=
X-Google-Smtp-Source: ABdhPJywM4883G/qJRFAAznRkXJY/owq9lS6itFgNbPDm0N+4Y5rRoYHdWZrdSInDxY2bccjWHtlXA==
X-Received: by 2002:a05:600c:a47:b0:37c:965:2b6f with SMTP id c7-20020a05600c0a4700b0037c09652b6fmr3513561wmq.31.1651586644510;
        Tue, 03 May 2022 07:04:04 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003945237fea1sm1047355wms.0.2022.05.03.07.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 07:04:03 -0700 (PDT)
Message-ID: <9b92b380-1da1-b76d-1eb4-469aba289694@gmail.com>
Date:   Tue, 3 May 2022 15:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Content-Language: en-GB-large
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220503065442.95699-2-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 03/05/2022 07:54, Carlo Marcelo Arenas Belón wrote:
> Originally reported after release of v2.35.2 (and other maint branches)
> for CVE-2022-24765 and blocking otherwise harmless commands that were
> done using sudo in a repository that was owned by the user.
> 
> Add a new test script with very basic support to allow running git
> commands through sudo, so a reproduction could be implemented and that
> uses only `git status` as a proxy of the issue reported.
> 
> Note that because of the way sudo interacts with the system, a much
> more complete integration with the test framework will require a lot
> more work and that was therefore intentionally punted for now.
> 
> The current implementation requires the execution of a special cleanup
> function which should always be kept as the last "test" or otherwise
> the standard cleanup functions will fail because they can't remove
> the root owned directories that are used.  This also means that if
> failures are found while running the specifics of the failure might
> not be kept for further debugging and if the test was interrupted, it
> will be necessary to clean the working directory manually before
> restarting by running:
> 
>    $ sudo rm -rf trash\ directory.t0034-root-safe-directory/
> 
> The test file also uses at least one initial "setup" test that creates
> a parallel execution directory, while ignoring the repository created
> by the test framework, and special care should be taken when invoking
> commands through sudo, since the environment is otherwise independent
> from what the test framework expects.  Indeed `git status` was used
> as a proxy because it doesn't even require commits in the repository
> to work.
> 
> A new SUDO prerequisite is provided that does some sanity checking
> to make sure the sudo command that will be used allows for passwordless
> execution as root and doesn't mess with git execution paths, but
> otherwise additional work will be required to ensure additional
> commands behave as expected and that will be addressed in a later patch.
> 
> Most of those characteristics make this test mostly suitable only for
> CI, but it could be executed locally if special care is taken to provide
> for some of them in the local configuration and maybe making use of the
> sudo credential cache by first invoking sudo, entering your password if
> needed, and then invoking the test by doing:
> 
>    $ IKNOWWHATIAMDOING=YES ./t0034-root-safe-directory.sh
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   t/t0034-root-safe-directory.sh | 49 ++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100755 t/t0034-root-safe-directory.sh
> 
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
> new file mode 100755
> index 00000000000..6dac7a05cfd
> --- /dev/null
> +++ b/t/t0034-root-safe-directory.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='verify safe.directory checks while running as root'
> +
> +. ./test-lib.sh
> +
> +if [ "$IKNOWWHATIAMDOING" != "YES" ]
> +then
> +	skip_all="You must set env var IKNOWWHATIAMDOING=YES in order to run this test"
> +	test_done
> +fi
> +
> +# this prerequisite should be added to all the tests, it not only prevents
> +# the test from failing but also warms up any authentication cache sudo
> +# might need to avoid asking for a password

If this is required for all the tests then it would be simpler just to 
skip all the tests if it is not satisfied as you do above.

Running "sudo env" shows that it sets $HOME to /root which means that 
these tests will pick up /root/.gitconfig if it exists. Normally when 
running the tests we set $HOME to $TEST_DIRECTORY so they are run in a 
predictable environment. At least anything pointed to by core.hooksPath 
or core.fsmontior in that file is expecting to be run as root. I think 
it is worth spelling this out explicitly in the commit message 
(currently it is a bit vague about what the implications of not having 
better integration with the test framework are) and the top of the test 
file. Note that t1509 sources test-lib.sh as the root user so does not 
have this issue.

> +test_lazy_prereq SUDO '
> +	sudo -n id -u >u &&
> +	id -u root >r &&
> +	test_cmp u r &&
> +	command -v git >u &&
> +	sudo command -v git >r &&
> +	test_cmp u r
> +'
> +
> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	sudo chown root root &&
> +	(
> +		cd root/r &&
> +		git init

Using git -C <directory> would eliminate a lot of the sub shells in this 
file

Best Wishes

Phillip

> +	)
> +'
> +
> +test_expect_failure SUDO 'sudo git status as original owner' '
> +	(
> +		cd root/r &&
> +		git status &&
> +		sudo git status
> +	)
> +'
> +
> +# this MUST be always the last test, if used more than once, the next
> +# test should do a full setup again.
> +test_expect_success SUDO 'cleanup' '
> +	sudo rm -rf root
> +'
> +
> +test_done
