Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B2C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbiCWQCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCWQCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:02:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014077B119
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:00:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r13so2763559wrr.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M9/YvhZ73EmEQEFNZFfyJTeMo1+/LBohALvl/i/C8TQ=;
        b=VXAXzzMoY0cYIDXB5P1LN6hINh9vhrbgPpwIR/NQikh5IZnmaMpE7oIH4FJ/TJzP8o
         4hXy9rlrEQdTFfUjjyhzZWDfi48n8iwOmI7bg7fybov5iw39x88MRHzSYTr0jRck+tTe
         up3a0djfAADpltbh5YdOsnuGfAH2Ffxh+1wm0BpgCi1Dno7eDOrfMh2qsow9WbBDf7yK
         +AYXYVZd+6nWjCacx880GmXoemxDKV4NQ7NvEWKwKbleSJElpfM+FKjDLywstT2rI+LS
         NL4BD6RG4mrAg3+8TzYu5GwGeOhQzsFqCPHCAG6OKUrmxjTsejbcq+pvyKZUkrI81BSw
         sdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M9/YvhZ73EmEQEFNZFfyJTeMo1+/LBohALvl/i/C8TQ=;
        b=KUpRFe3SRrUrZyOo/ixs2EKmAIxoQOE55iVx00h7TfZpQc2fZwvtYy64Q4CykZ9TNm
         7weOoWv1iLvg3h/yVgvQeLrMOu6MCk76C9dsQvc578vD+YIijlH+CNE88jD6iFosbnBY
         3b4TdedMVMnI8KamXAKbaPJ+azSB2cnpP76aGG6qNvJSYChvja50bmXv+/E9CLJ/6vKU
         DlAfCKR8ZR5OM0JFxLJJdPedH6+JU8dRRFjaklQnY4cWj64gsNj5imYYvm8Q94thv70T
         rvAYv8CYOamnNxczCx5YnOvOBJI0Pi70u0TdgUE/0rr3+Yxg4hIX+uTJMucelb6ZxR92
         0eGg==
X-Gm-Message-State: AOAM532o2xj6rPXot+r3W1uVEmEm5RhyuqDaObuxvw9aMj5GZ66mfXy3
        16mv8QQDaKUVctCfPiUjH/Y=
X-Google-Smtp-Source: ABdhPJw4OTHWYNW9tz3/UX1VKvPqr72KCee9H+lg9EgL74fhef//O4WepMCi6rMXqrUY6JKD1gh8sA==
X-Received: by 2002:a05:6000:b:b0:205:911a:3dfa with SMTP id h11-20020a056000000b00b00205911a3dfamr445107wrx.373.1648051248471;
        Wed, 23 Mar 2022 09:00:48 -0700 (PDT)
Received: from [192.168.1.201] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.googlemail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm4110609wmb.1.2022.03.23.09.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:00:48 -0700 (PDT)
Message-ID: <9462c3f0-db92-e1de-cef5-df811ddf9eb2@gmail.com>
Date:   Wed, 23 Mar 2022 16:00:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] reset: deprecate 'reset.quiet' config option
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <d9bebd4b4e0000850e076ee642b20b09f71db700.1647894889.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d9bebd4b4e0000850e076ee642b20b09f71db700.1647894889.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 21/03/2022 20:34, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>

Small nit-pick about the title, I think "deprecate" is a bit misleading 
as we're actually removing the config option.

> Remove the 'reset.quiet' config option, remove '--no-quiet' documentation in
> 'Documentation/git-reset.txt'. In 4c3abd0551 (reset: add new reset.quiet
> config setting, 2018-10-23), 'reset.quiet' was introduced as a way to
> globally change the default behavior of 'git reset --mixed' to skip index
> refresh.
> 
> However, now that '--quiet' does not affect index refresh, 'reset.quiet'
> would only serve to globally silence logging. This was not the original
> intention of the config setting, and there's no precedent for such a setting
> in other commands with a '--quiet' option, so it appears to be obsolete.
> 
> In addition to the options & its documentation, remove 'reset.quiet' from
> the recommended config for 'scalar'.

Nice attention to detail


The code changes look good

Best Wishes

Phillip

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>   Documentation/config.txt       | 2 --
>   Documentation/config/reset.txt | 2 --
>   Documentation/git-reset.txt    | 5 +----
>   builtin/reset.c                | 1 -
>   contrib/scalar/scalar.c        | 1 -
>   t/t7102-reset.sh               | 3 +--
>   6 files changed, 2 insertions(+), 12 deletions(-)
>   delete mode 100644 Documentation/config/reset.txt
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f0fb25a371c..43f5e6fd6d3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -495,8 +495,6 @@ include::config/repack.txt[]
>   
>   include::config/rerere.txt[]
>   
> -include::config/reset.txt[]
> -
>   include::config/sendemail.txt[]
>   
>   include::config/sequencer.txt[]
> diff --git a/Documentation/config/reset.txt b/Documentation/config/reset.txt
> deleted file mode 100644
> index 63b7c45aac2..00000000000
> --- a/Documentation/config/reset.txt
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -reset.quiet::
> -	When set to true, 'git reset' will default to the '--quiet' option.
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index bc1646c3016..f4aca9dd35c 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -105,10 +105,7 @@ OPTIONS
>   
>   -q::
>   --quiet::
> ---no-quiet::
> -	Be quiet, only report errors. The default behavior is set by the
> -	`reset.quiet` config option. `--quiet` and `--no-quiet` will
> -	override the default behavior.
> +	Be quiet, only report errors.
>   
>   --refresh::
>   --no-refresh::
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 7c3828f6fc5..e824aad3604 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   	};
>   
>   	git_config(git_reset_config, NULL);
> -	git_config_get_bool("reset.quiet", &quiet);
>   	git_config_get_bool("reset.refresh", &refresh);
>   
>   	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 7db2a97416e..58ca0e56f14 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -152,7 +152,6 @@ static int set_recommended_config(int reconfigure)
>   		{ "pack.useBitmaps", "false", 1 },
>   		{ "pack.useSparse", "true", 1 },
>   		{ "receive.autoGC", "false", 1 },
> -		{ "reset.quiet", "true", 1 },
>   		{ "feature.manyFiles", "false", 1 },
>   		{ "feature.experimental", "false", 1 },
>   		{ "fetch.unpackLimit", "1", 1 },
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 8b62bb39b3d..9e4c4deee35 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -488,8 +488,7 @@ test_expect_success '--mixed refreshes the index' '
>   	# Verify default behavior (without --[no-]refresh or reset.refresh)
>   	test_reset_refreshes_index &&
>   
> -	# With --quiet & reset.quiet
> -	test_reset_refreshes_index "-c reset.quiet=true" &&
> +	# With --quiet
>   	test_reset_refreshes_index "" --quiet
>   '
>   

