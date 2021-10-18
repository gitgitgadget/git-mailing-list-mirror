Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ACC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 05:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0639960FF2
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 05:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhJRF0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 01:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRF0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 01:26:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92BC06161C
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 22:24:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa4so11410797pjb.2
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 22:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3SyDRfY3IiKo7dvMrIZYzM3sR84UgHRMgkr7S/exR84=;
        b=elNvg+7UStUaIQUrkcYD6eX/LPTOp+VDx+sZuFMZmdAlMPASuRZtOZvkgdVobpWy8S
         1LNCvR0W329jCEs4IvSZZB2Rff79JIGkvop/zj+rYYfh/snman9NnwbNNrjneyTk6ELb
         lSQZN7vxMcm8WPZkpEGxlJaH/D4O8tRA8OLu3c3hozat7+LHd8Ma+xhn3iZcJK3mtpLl
         pE+BqjKn2DwzkGGb3MsqmU3p+nf6GgysHdIu+OYN6quEbPq29FWblwsgWoDgKc3WC/6l
         891+hCMUh/ylfNaFsZNgwFI/KPe3BPDTq9fA7wbKm6ftS3fuINsSKTUw4T95Hps1BHzc
         tHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3SyDRfY3IiKo7dvMrIZYzM3sR84UgHRMgkr7S/exR84=;
        b=3lqnEsyPskTERNtcWmUcK814LyBFbl0PlyOuywGtvoyTtonIJqJS5KA4bX9oPbALUY
         pWllu7haG4ytehczcl6gIpVCf3H1x28pDTUerdY7q/56t3TkezAPor/SX43VsWArj/7i
         dljNCYJOyU5Ltf0NfVkoU+h+zp+QdsKFw5rXqvUN5zki3+0jyoAbYyv3ZQx6vMo0dzpu
         QgPrhldUkai/qw7pNb8oCBSkOCQc4UWapr3/bC0QAt5xmcMyafR/u3n7kHPPb+tvG/wd
         eZWJM/RpCnoTaDvcBQC3i0sV1gfNkgUhuOz/7ScrqUjlFrbThr0zJMSvq71xTv0efCsi
         g0VQ==
X-Gm-Message-State: AOAM533vlPERI6FHvsvycdoAAoCZv0u/LP0cRMbZAgFMjzJGIA+kSXmm
        tPSdBfdYaFdp7PiK8qUTNsA=
X-Google-Smtp-Source: ABdhPJwOlLoMD5LieNA4PqvUJOK1EokEn0V2AaLJoXuVz07gxO7GzhBbJOjzhHCg+ktsWaBbWnD39w==
X-Received: by 2002:a17:90b:398:: with SMTP id ga24mr31600353pjb.87.1634534670114;
        Sun, 17 Oct 2021 22:24:30 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id pj12sm12443716pjb.19.2021.10.17.22.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 22:24:29 -0700 (PDT)
Message-ID: <cc1b7611-8ec1-db29-1678-f45ba08d9b68@gmail.com>
Date:   Mon, 18 Oct 2021 12:24:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: git tag -h fatal error with global tag.sort config
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jakub Wilk <jwilk@jwilk.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <0daf6907-b472-a756-1240-4c78f8f4d37e@gmail.com>
 <20210912132757.GC76263@szeder.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20210912132757.GC76263@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/21 20.27, SZEDER Gábor wrote:
> Interesting.  It bisects to 47bd3d0c14 (ref-filter: don't look for
> objects when outside of a repository, 2018-11-14), which, based on the
> error message, kind of makes sense, because 'git tag' uses the general
> ref-filter sorting facility.  Now, even if 'git tag -h' is executed in
> a repository, since 99caeed05d (Let 'git <command> -h' show usage
> without a git dir, 2009-11-09) run_builtin() special-cases the '-h'
> option and does not call setup_git_directory(), so cmd_tag() and
> everything invoked from within will mistakenly think that there is no
> repository.  And cmd_tag() parses the config before parsing the
> options (of course, otherwise command line options couldn't override
> the config), so it hits this die() before parse_options would get a
> change to act on the '-h' option.
> 
> Now, 'git branch' uses the same ref-filter sorting, but the equivalent
> 'git -c branch.sort=creatordate branch -h' command does show the usage
> as expected.  The relevant difference between cmd_branch() and
> cmd_tag() is that the former special-cases the '-h' option as well
> just before it would call git_config().  Doing the same in cmd_tag()
> like in the patch below seems to fix this issue, but I'm not sure that
> this is the right fix.
> 
> 
>    ---  >8  ---
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 065b6bf093..31b8cc4600 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -485,6 +485,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>   
>   	setup_ref_filter_porcelain_msg();
>   
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(git_tag_usage, options);
> +
>   	git_config(git_tag_config, sorting_tail);
>   
>   	memset(&opt, 0, sizeof(opt));
> 

Sorry for long reply.

Patch applied and usage help appears.

But when I do `./bin-wrappers/git tag -h`, I don't see `usage:` header, 
and instead show the help starting from `-F`.

-- 
An old man doll... just what I always wanted! - Clara
