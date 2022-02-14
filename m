Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD722C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 15:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiBNP4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:56:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiBNP4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 10:56:45 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE75488A4
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 07:56:37 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id k25so15810972qtp.4
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j7lDWN5UDvg99MxtTizebnDUe98qK4DtmR0e6OZhaqk=;
        b=c+ZggpbPyw/AZ4rcgiJnuxXWIt3yNUd1ZQ7ks0mmVgeDkGxLyRpw5AzuLpUxVCLo1U
         jWvt63nP2Q/cfy2C6dYBCQdQ7J9kzoTfkRwuBz7Gt2AY0dboM6rVO9Gkal0KOKRU3yhf
         SNfDiR3L/0Ynmz9CBn2jDa+rMRTDVvWsqEcZVV7EIQ2BPBYWlSNts10OFARTG61BaTH8
         0NNm82e9959sSPILNamS8juhw+vPQgBmH9xORqFUFSeK3iGH0aIU4PLFpSC0Y3v7IWjA
         DEDLD8a0eqesu9qilyZ3/kOVHb50nQ47GSnCPrnz4EMFnhh6fhof1wU1PQrgatUEj0F5
         4ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j7lDWN5UDvg99MxtTizebnDUe98qK4DtmR0e6OZhaqk=;
        b=OwiW/DCKhDRtAK5FKWVSpWJsnc2a5BwBLY/ZQKEOnoNpL7w3tytqayk4VKPxwjTeYT
         8yxzEiIa585V6ekBm8K9vHpvg5HlUnGN6/oKDPjjkvfGSprDlGhtwvgBlT5lvBe8Br+w
         dg57TFVr674YJK7lISK5FWOWb+ki0kmtLG8d6qaw/F+pdJ4Sjr4QssqbDhn80BR5f1EY
         zGVAqOxOSnw9GjQlT8CY/eYrpcQub/5wL7NyW7C0eNwmzjjOE+K9zPUOkRb/h89K5LJs
         6VKBI6hQDJ8MpcMkNbJHjmB+EGwr9MqEqBTHDgcaSCgf1nvdh8kUOSB9SIoXhNCbn5pb
         HoVw==
X-Gm-Message-State: AOAM5302g6c+EQ5F3r/DhffBXSfG30s1z9TY+w0iFHLlCD5N0INmt0N0
        L/lan3wdHiC/0+KbrOrVC8Po
X-Google-Smtp-Source: ABdhPJxwr5FxifjWXRmYraeokuno9LSrTCh+de2RxbCEJyC1c4K+cTTmAugq2ouj95Z6xizHnI8NtA==
X-Received: by 2002:ac8:7459:: with SMTP id h25mr340493qtr.452.1644854196752;
        Mon, 14 Feb 2022 07:56:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id r129sm15441879qkf.99.2022.02.14.07.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 07:56:36 -0800 (PST)
Message-ID: <72d39c4a-fd16-846c-2a5e-8b9ba0c1ab07@github.com>
Date:   Mon, 14 Feb 2022 10:56:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/7] sparse-checkout: error or warn when given individual
 files
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <5e27cad17a7080170f476684610391bd56024f36.1644712798.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5e27cad17a7080170f476684610391bd56024f36.1644712798.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The set and add subcommands accept multiple positional arguments.
> The meaning of these arguments differs slightly in the two modes:
> 
> Cone mode only accepts directories.  If given a file, it would
> previously treat it as a directory, causing not just the file itself to
> be included but all sibling files as well -- likely against users'
> expectations.  Throw an error if the specified path is a file in the
> index.  Provide a --skip-checks argument to allow users to override
> (e.g. for the case when the given path IS a directory on another
> branch).

I agree that this is likely to be an improvement for users. The
sparse-checkout builtin isn't integrated with the sparse index
yet. At least not integrated upstream: we have commits in microsoft/git
that we plan to send when other things in flight are merged. This
change likely introduces a new opportunity for the index to expand,
so I will keep that in mind when upstreaming.
 
> Non-cone mode accepts general gitignore patterns.  However, it has an
> O(N*M) performance baked into its design, where all N index files must
> be matched against all M sparse-checkout patterns with EVERY call to
> unpack_trees() that updates the working tree.  As such, it is important
> to keep the number of patterns small, and thus we should warn users to
> prefer passing directories and more generic glob patterns to get the
> paths they want instead of listing each individual file.  (The
> --skip-checks argument can also be used to bypass this warning.)  Also,
> even when users do want to specify individual files, they will often
> want to do so by providing a leading '/' (to avoid selecting the same
> filename in all subdirectories), in which case this error message would
> never trigger anyway.

I think the case of "I want only one file from this directory" and "I
want files with the given name pattern" are the main reason to still
use non-cone-mode. Users with this need usually have a directory full
of large files, and they choose which of those large files they need
using sparse-checkout. The repository reorganization required to use
cone mode for this use is perhaps too great (or they haven't thought
about doing it). For this reason, I would prefer that we do not do
these checks when not in cone mode.

> +test_expect_success 'by default, cone mode will error out when passed files' '
> +	git -C repo sparse-checkout reapply --cone &&
> +	test_must_fail git -C repo sparse-checkout add .gitignore 2>error &&
> +
> +	grep ".gitignore.*is not a directory" error
> +'
> +
> +test_expect_success 'by default, non-cone mode will warn on individual files' '
> +	git -C repo sparse-checkout reapply --no-cone &&
> +	git -C repo sparse-checkout add .gitignore 2>warning &&
> +
> +	grep "passing directories or less specific patterns is recommended" warning
> +'

So I would expect this second test to have

	test_must_be_empty warning

to show that no warning occurs when specifying a file in non-cone-mode.

Thanks,
-Stolee
