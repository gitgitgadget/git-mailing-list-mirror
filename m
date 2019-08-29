Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC1D1F4B7
	for <e@80x24.org>; Thu, 29 Aug 2019 18:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfH2SyM (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:54:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55007 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfH2SyM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:54:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id k2so3351385wmj.4
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A9nlXFxe/5X02VBgh5cSVxhiDG4XgH+23hi7N8W4cnY=;
        b=TWdPlKJndMaECpcPAAXNd2OlrCLCG//piaxjvQpUPfwxP57n44wD0/JF8UOoWAiXsl
         oIx6sHJ1bOxK89m5EpRp1tl97mchkni89YHvXToe+13BsXjzYVdybB3XuOXD5cdbVkjE
         Z7CqSertjuVrzYAsO6jUcyPM2JtFvTnb7IFbum/6TMP+L/drbcdF2XJocoDaCO6WyaxY
         zYZ8L8W7o7eW9AgiadT7w+ig6sT4VvI0gMWZqJUIlDbTW1r4or4ZlE7z46m/k6JOgOkT
         FETzCHnJgc1Z5tRRGVlnYmw7QnZ6aVSrQ4zX1S7RLuavxdUOQcECXtcXN0XaV25t8xpZ
         IZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A9nlXFxe/5X02VBgh5cSVxhiDG4XgH+23hi7N8W4cnY=;
        b=Reovs7x9Z+DTb0qLEXt68+pCFnupNoDl6ynPDjaic4wlRsbE400TU7/hvBsRlegFzC
         8l814iZooL2sOsn++tkGNiI5B7mKkvq/1mUC7lYFnjvWC9oQDtrFXgEEob7j9+X5VqwX
         PsM8pwnW43d//PiVqroR8Aktkj1sOTqGStwZovoWcaif79nxEaS/byXTMTgpqqaR50xt
         JU7M3fhq2CjAfBLLqxmDCUbmieKfi6hrpcfX6UgfbkDWhrUMgSEdEVjOXmtd1nU/0o4u
         8jIkqg8jK+LGtZvZL1nTLAI/9aDXz7NLZzn8Giv9/pOD7Vb2f70Ys/R9+TeABisE3CKx
         0qOg==
X-Gm-Message-State: APjAAAUs6cu7M5TSpEYWmboXrB0rELSLuC2m/IeP3lwU8ZLAibqXhhOb
        0dEalkYnSh7MNpr9kRQF2qM=
X-Google-Smtp-Source: APXvYqxaqmNtkkeHXvaXjtJnDgxHXmt6KrTDhWzOAbW+BPqKb9k0FA4L+q3GyRSepsnA0AnKdktinA==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr12847115wmh.173.1567104849961;
        Thu, 29 Aug 2019 11:54:09 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id s64sm6963798wmf.16.2019.08.29.11.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:54:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.325.git.gitgitgadget@gmail.com>
 <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
Date:   Thu, 29 Aug 2019 19:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 29/08/2019 18:01, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git switch' command was created to separate half of the
> behavior of 'git checkout'. It specifically has the mode to
> do nothing with the index and working directory if the user
> only specifies to create a new branch and change HEAD to that
> branch. This is also the behavior most users expect from
> 'git checkout -b', but for historical reasons it also performs
> an index update by scanning the working directory. This can be
> slow for even moderately-sized repos.
> 
> A performance fix for 'git checkout -b' was introduced by
> fa655d8411 (checkout: optimize "git checkout -b <new_branch>"
> 2018-08-16). That change includes details about the config
> setting checkout.optimizeNewBranch when the sparse-checkout
> feature is required. The way this change detected if this
> behavior change is safe was through the skip_merge_working_tree()
> method. This method was complex and needed to be updated
> as new options were introduced.
> 
> This behavior was essentially reverted by 65f099b ("switch:
> no worktree status unless real branch switch happens"
> 2019-03-29). Instead, two members of the checkout_opts struct
> were used to distinguish between 'git checkout' and 'git switch':
> 
>      * switch_branch_doing_nothing_is_ok
>      * only_merge_on_switching_branches
> 
> These settings have opposite values depending on if we start
> in cmd_checkout or cmd_switch.
> 
> The message for 64f099b includes "Users of big repos are
> encouraged to move to switch." Making this change while
> 'git switch' is still experimental is too aggressive.
> 
> Create a happy medium between these two options by making
> 'git checkout -b <branch>' behave just like 'git switch',
> but only if we read exactly those arguments. This must
> be done in cmd_checkout to avoid the arguments being
> consumed by the option parsing logic.
> 
> This differs from the previous change by fa644d8 in that
> the config option checkout.optimizeNewBranch remains
> deleted. This means that 'git checkout -b' will ignore
> the index merge even if we have a sparse-checkout file.
> While this is a behavior change for 'git checkout -b',
> it matches the behavior of 'git switch -c'.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   builtin/checkout.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6123f732a2..116200cf90 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1713,6 +1713,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>   	opts.overlay_mode = -1;
>   	opts.checkout_index = -2;    /* default on */
>   	opts.checkout_worktree = -2; /* default on */
> +	
> +	if (argc == 3 && !strcmp(argv[1], "-b")) {
> +		/*
> +		 * User ran 'git checkout -b <branch>' and expects

What if the user ran 'git checkout -b<branch>'? Then argc == 2.

Best Wishes

Phillip

> +		 * the same behavior as 'git switch -c <branch>'.
> +		 */
> +		opts.switch_branch_doing_nothing_is_ok = 0;
> +		opts.only_merge_on_switching_branches = 1;
> +	}
>   
>   	options = parse_options_dup(checkout_options);
>   	options = add_common_options(&opts, options);
> 
