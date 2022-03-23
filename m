Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90961C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbiCWQDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiCWQDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:03:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8737B12D
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:02:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so5643431wms.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iP4YNJ8baGhFn5pan+tPSpa9hJ7aLqcNdCh32OrHT6o=;
        b=AfasFuIIvSSQLSZAmIxKKyQYK7iZtRHKSjwVkQbxL/XqHP3K016JV/Gs9cg/+3+P5K
         9Wt55w1DJsEPCx2WbF2Yse4BOv6zGhvV6e4QOo2FFakrjwDJk6cPF9Kl4gBqRbyx/bsN
         lUhD7WmpIva/VSCYD9Co1ETJn+O428expcQH5/kEERz6ktVKGJig/If49WeyWPsVwFNT
         szlpdbl9Mjn8l8NiorBD6+VztrhK6sbPop1N/pxS3Tgyw1LZNeQYha3MrQosMlaGSFPk
         7/om5zY8s/DGNG0lHR1HrxwtUWQJZmy4l6HmvaBEWZcUKHhLwccSFMAbqFH7M+SS47yB
         gOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iP4YNJ8baGhFn5pan+tPSpa9hJ7aLqcNdCh32OrHT6o=;
        b=q52m9X21otubPM1KX4SWKireCN1nP53OFcnhDQalLf1CYIwgl6s3PcQ9fmigvkFndm
         +LZWIj1Vndxaz5EhgYI0R8DYYN024lAioRfmi1rlATKz4hnktpaeQPGZMhNmu4vDSrMW
         zDW8yiclLLR/wiJwjgZCtLzaEGrwBWxrsgRvx1PeruG5WNSRrkHKvxTeCEru5rlrEq+W
         zWMjC5zh2QGc0AMELvBw/y6mX71b42YCr+WJIfbfhrNUOlmdVh6UpVmtIWsDrmp0X+RU
         rjCbnlLD+luhUmh1spGftt/8YPsrdXdp9c3wrt753dTvASTR2k3B1YwkMaf0w0QFt+CM
         2H6Q==
X-Gm-Message-State: AOAM532zHo7G67sXfCCxFYlGA+DxCjos55MIYEWeECXjxBdbIC7/RCIu
        ThjugXZU3iXfOazMBZwPGeY=
X-Google-Smtp-Source: ABdhPJwZybZIMUZXO0D64ymOMC7ks63PuhirSbDxmxelZUcN6Z0XYfxtLT645e1DuXuxanBMRAusWw==
X-Received: by 2002:a05:600c:4ece:b0:38c:7938:d73c with SMTP id g14-20020a05600c4ece00b0038c7938d73cmr10131262wmq.165.1648051329161;
        Wed, 23 Mar 2022 09:02:09 -0700 (PDT)
Received: from [192.168.1.201] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c404800b0038cc9c7670bsm983455wmm.3.2022.03.23.09.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:02:08 -0700 (PDT)
Message-ID: <4f3cbfd5-65df-f44f-4867-45b1ab69c400@gmail.com>
Date:   Wed, 23 Mar 2022 16:02:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] reset: deprecate 'reset.refresh' config option
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <ecd3296fd25cc936aeb2f8ae160352a2326441c5.1647894889.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ecd3296fd25cc936aeb2f8ae160352a2326441c5.1647894889.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 21/03/2022 20:34, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>

Same concern about the title as the last patch

> Remove the 'reset.refresh' option, requiring that users explicitly specify
> '--no-refresh' if they want to skip refreshing the index.
> 
> The 'reset.refresh' option was introduced in 101cee42dd (reset: introduce
> --[no-]refresh option to --mixed, 2022-03-11) as a replacement for the
> refresh-skipping behavior originally controlled by 'reset.quiet'.
> 
> Although 'reset.refresh=false' functionally served the same purpose as
> 'reset.quiet=true', it exposed [1] the fact that the existence of a global
> "skip refresh" option could potentially cause problems for users. Allowing a
> global config option to avoid refreshing the index forces scripts using 'git
> reset --mixed' to defensively use '--refresh' if index refresh is expected;
> if that option is missing, behavior of a script could vary from user-to-user
> without explanation.
> 
> Furthermore, globally disabling index refresh in 'reset --mixed' was
> initially devised as a passive performance improvement; since the
> introduction of the option, other changes have been made to Git (e.g., the
> sparse index) with a greater potential performance impact without
> sacrificing index correctness. Therefore, we can more aggressively err on
> the side of correctness and limit the cases of skipping index refresh to
> only when a user specifies the '--no-refresh' option.

Thanks for the well explained commit message
> [1] https://lore.kernel.org/git/xmqqy2179o3c.fsf@gitster.g/
> 
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>   Documentation/git-reset.txt |  4 +---
>   builtin/reset.c             |  4 +---
>   t/t7102-reset.sh            | 14 ++------------
>   3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index f4aca9dd35c..df167eaa766 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -109,9 +109,7 @@ OPTIONS
>   
>   --refresh::
>   --no-refresh::
> -	Proactively refresh the index after a mixed reset. If unspecified, the
> -	behavior falls back on the `reset.refresh` config option. If neither
> -	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
> +	Proactively refresh the index after a mixed reset. Enabled by default.

"Proactively" seems a but superfluous if I'm being picky. There was no 
entry in the config man page for reset.refresh so we don't need to do 
anything there. The code changes below look good

Best Wishes

Phillip


>   --pathspec-from-file=<file>::
>   	Pathspec is passed in `<file>` instead of commandline args. If
> diff --git a/builtin/reset.c b/builtin/reset.c
> index e824aad3604..54324217f93 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   	};
>   
>   	git_config(git_reset_config, NULL);
> -	git_config_get_bool("reset.refresh", &refresh);
>   
>   	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
>   						PARSE_OPT_KEEP_DASHDASH);
> @@ -529,8 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
>   				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
>   					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
> -						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
> -						 "to make this the default."), t_delta_in_ms / 1000.0);
> +						 "'--no-refresh' to avoid this."), t_delta_in_ms / 1000.0);
>   				}
>   			}
>   		} else {
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 9e4c4deee35..22477f3a312 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -493,19 +493,9 @@ test_expect_success '--mixed refreshes the index' '
>   '
>   
>   test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
> -	# Verify that --[no-]refresh and `reset.refresh` control index refresh
> -
> -	# Config setting
> -	test_reset_refreshes_index "-c reset.refresh=true" &&
> -	! test_reset_refreshes_index "-c reset.refresh=false" &&
> -
> -	# Command line option
> +	# Verify that --[no-]refresh controls index refresh
>   	test_reset_refreshes_index "" --refresh &&
> -	! test_reset_refreshes_index "" --no-refresh &&
> -
> -	# Command line option overrides config setting
> -	test_reset_refreshes_index "-c reset.refresh=false" --refresh &&
> -	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
> +	! test_reset_refreshes_index "" --no-refresh
>   '
>   
>   test_expect_success '--mixed preserves skip-worktree' '

