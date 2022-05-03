Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57BC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 14:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiECOQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiECOQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 10:16:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A312AA5
        for <git@vger.kernel.org>; Tue,  3 May 2022 07:12:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg25so9967672wmb.4
        for <git@vger.kernel.org>; Tue, 03 May 2022 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v5C81/1dDGGgDZ9f9ZZJlIEsudgj5cxCY2dn7qrC0Rs=;
        b=TwDPKVKJcB69xix35IxzjYSrBJ0nA15ZTZFRIAWjF31mYnlCuWaWN8rRQMV4tPN94V
         VMpoOjuFmmF3tJsey3Hnsfa3p/8SL/BDFXCc5mpvpbESkSh7I8dm5zL+vQ6tIxLoXDjG
         aqJjLrFLpxZCmOJV+C6Q56W4MfmSC+K+WjfilPDqT8lRXHX+avhc9gV2ljN25o5Pqx/M
         aRRPBIuJLb/ygtD1aimCb3Ozuzc/RXM87PrD0d63w1QTFe8bRqKhnhlidwzVH7JOjA+u
         2gX/nOJJKoGoB+c3hEX6u353IRkK1EOnbypIOoWX9bDwHLeJLC3531a6HhVrekv1+2qC
         TbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v5C81/1dDGGgDZ9f9ZZJlIEsudgj5cxCY2dn7qrC0Rs=;
        b=c6sLAZegrnDIt9TcggEdrP9KST6dnYWyfr7XfLCv9vI4QFw5eBjUrbnSBnr8fWAZ/m
         eF6yNL461mCZSSfB7MmPsXM1pfp4KrmoKHAS8HYUhHv0/IzkbAMBTzPauuL4x6IftDrW
         VpXRTZlAMRidmaUmBeXBvx0/LVbgcY4KH0eQEJh6c1xEeOA3N6hyCv0qZE09/7Kyy78u
         qlR4xr9mw7F+/Z1WspJD0JDqANPT14UkHGFGiU27hnAWcR7gHVYByFKFidhzsufJAxGk
         LfAUcfeC71CTJeuVlGJ6A9P99A2Gn39KPwY5u4nWX2lvrMpCm5oAZ3L0KCSnO+qo6UdY
         FYIw==
X-Gm-Message-State: AOAM531ZsqBhzS1mU8RPkqyuuTvG2cjLuUZch8ziiC3dXmvlihO44mNv
        RvDilX3fMokpakL5nvBEA1w=
X-Google-Smtp-Source: ABdhPJxUC0zb7qYSICFd2GnxVyDlmPhSdUxLsVGbyTT1Q3SfUZcUh1CKtiJX9lG3qc7WHQOD1EBy7Q==
X-Received: by 2002:a05:600c:4349:b0:394:1702:6d65 with SMTP id r9-20020a05600c434900b0039417026d65mr3606696wme.4.1651587155065;
        Tue, 03 May 2022 07:12:35 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id k5-20020adfb345000000b0020c5253d8cfsm11340844wrd.27.2022.05.03.07.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 07:12:34 -0700 (PDT)
Message-ID: <af4dd56d-f301-9c3d-2fc3-929a24596e82@gmail.com>
Date:   Tue, 3 May 2022 15:12:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/3] t0034: enhance framework to allow testing more
 commands under sudo
Content-Language: en-GB-large
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-4-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220503065442.95699-4-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 03/05/2022 07:54, Carlo Marcelo Arenas Belón wrote:
> Add a support library that provides one function that can be used
> to run a "scriplet" of commands through sudo and that has an
> optional parameter (currently unused) to indicate which shell to
> use to do so.
> 
> Add additional negative tests as suggested by Junio and that use
> new workspace that is owned by root.
> 
> Note that in order to be able to call `test_must_fail sudo git status`
> or an equivalent, test_must_fail will need to be enhanced or be able
> to run under sudo, so fixing that has been punted, since the only
> protection it affords is for `git status` not crashing, and that is
> covered already by other tests.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   t/lib-sudo.sh                  | 13 +++++++
>   t/t0034-root-safe-directory.sh | 70 +++++++++++++++++++++++++++++++++-
>   2 files changed, 81 insertions(+), 2 deletions(-)
>   create mode 100644 t/lib-sudo.sh
> 
> diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
> new file mode 100644
> index 00000000000..9ebb30fc82b
> --- /dev/null
> +++ b/t/lib-sudo.sh
> @@ -0,0 +1,13 @@
> +# Helpers for running git commands under sudo.
> +
> +# Runs a scriplet passed through stdin under sudo.
> +run_with_sudo () {
> +	local ret
> +	local SH=${1-"$TEST_SHELL_PATH"}

What use do you envisage for this? It would be simpler just to use 
$TEST_SHELL_PATH directly below

> +	local RUN="$HOME/$$.sh"

Can we used a fixed name for the script? That would make things simpler 
especially debugging as one would know what file to look for. Also using 
$TEST_DIRECTORY rather than $HOME would make it clear where the file 
ends up.

> +	write_script "$RUN" "$SH"
> +	sudo "$SH" -c "\"$RUN\""

I think using write_script means we can just do 'sudo "$RUN"'

> +	ret=$?
> +	rm -f "$RUN" > +	return $ret
> +}
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
> index dd659aed4e1..a68e1d7602b 100755
> --- a/t/t0034-root-safe-directory.sh
> +++ b/t/t0034-root-safe-directory.sh
> @@ -3,6 +3,7 @@
>   test_description='verify safe.directory checks while running as root'
>   
>   . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-sudo.sh
>   
>   if [ "$IKNOWWHATIAMDOING" != "YES" ]
>   then
> @@ -10,6 +11,12 @@ then
>   	test_done
>   fi
>   
> +if ! test_have_prereq NOT_ROOT
> +then
> +	skip_all="No, you don't; these tests can't run as root"

I think the message would be friendlier without the "No, you don't" and 
just said that the tests cannot be run as root.

> +	test_done
> +fi
> +
>   # this prerequisite should be added to all the tests, it not only prevents
>   # the test from failing but also warms up any authentication cache sudo
>   # might need to avoid asking for a password
> @@ -40,8 +47,67 @@ test_expect_success SUDO 'sudo git status as original owner' '
>   	)
>   '
>   
> -# this MUST be always the last test, if used more than once, the next
> -# test should do a full setup again.

Why is the comment being changed? If you want the shorter version at the 
end of this patch can't we just use that wording in patch 1?


> +# this destroys the test environment used above
> +test_expect_success SUDO 'cleanup regression' '
> +	sudo rm -rf root
> +'
> +
> +if ! test_have_prereq SUDO
> +then
> +	skip_all="You need sudo to root for all remaining tests"
> +	test_done
> +fi
> +
> +test_expect_success SUDO 'setup root owned repository' '
> +	sudo mkdir -p root/p &&
> +	sudo git init root/p
> +'
> +
> +test_expect_success 'cannot access if owned by root' '
> +	(
> +		cd root/p &&
> +		test_must_fail git status
> +	)
> +'
> +
> +test_expect_success SUDO 'cannot access with sudo' '
> +	(
> +		# TODO: test_must_fail needs additional functionality
> +		# 6a67c759489 blocks its use with sudo
> +		cd root/p &&
> +		! sudo git status
> +	)
> +'

I think Junio suggested that this should work and showed it was simple 
to make it work. It seems funny that if sudo is started as root it does 
not work.

> +test_expect_success SUDO 'can access using a workaround' '
> +	# run sudo twice
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			sudo git status
> +		END
> +	) &&
> +	# provide explicit GIT_DIR
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			GIT_DIR=.git &&
> +			GIT_WORK_TREE=. &&
> +			export GIT_DIR GIT_WORK_TREE &&
> +			git status

I'm confused by this. Does this mean we don't do the ownership checks if 
GIT_DIR and or GIT_WORK_TREE are set in the environment?


Thanks for working on this

Best Wishes

Phillip


> +		END
> +	) &&
> +	# discard SUDO_UID
> +	(
> +		cd root/p &&
> +		run_with_sudo <<-END
> +			unset SUDO_UID &&
> +			git status
> +		END
> +	)
> +'
> +
> +# this MUST be always the last test
>   test_expect_success SUDO 'cleanup' '
>   	sudo rm -rf root
>   '
