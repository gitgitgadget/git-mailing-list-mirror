Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7DC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbiF1KAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbiF1KAL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:00:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD12EA3D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:59:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so3246002wmb.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cLnNbMUrZ1nv8bomexN//Ey0vivquKcsMKdE902U18E=;
        b=IOMSAhNqa4J2g/CuGnlp6AgBO0Y+IlbF9IQcT3XplkPCwQlYBgw8vYsSygk5JqWEgu
         mSp+lp2ywwxICRHMzYYj+QkE38iKo3afBnkC0awvIjYQAwaT0UyyA7osibd8winh7SgW
         Lsgo9Ncbcv0bzfg1NnM9c8MsJYV47vS1bGUe6gRpeA9Hc0M+nDs/Umx7E5UWEMXY2vro
         oax3sh1N/w0Z1N65aSLxf/WVp1Hih5XB+18niPXHSjnbWqG9+RBi6moy8pq6teGTRCOd
         tkYSU6t09wOix4CHaCSoMsluLbzp5QFr+VSoHkC/XkrrSvrnOMsFEEU4gPqFFkpUApvr
         bn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cLnNbMUrZ1nv8bomexN//Ey0vivquKcsMKdE902U18E=;
        b=QzIS8AeeWJDHKeodImN15U1dd1YdmCLfNdNAfIE71+6ywjGErVYK+u+do5/oTTjyAX
         vebqL1lBevIBe3OWonlvvqWPTeBBnZy1WwKaGYapwLXVqgY9u5GzMJYOUYnGqxN8CL0q
         tfhkYXdnPwf1mCZKzvJwoQXyiTkPgq2YDW7d+/Og8K16oK4MLE9/KzR9O9XdA8h1WYPz
         R99Hf23FfsFR7IVNSzmZ5WK+WMN9f4+zLuzM2zduXNMUFcJBLiCyCuzunffBVxOZW50e
         xLc4y5/TZkAytVKqqN46OeBKFsNC1qaOQ1b+mDt6JsH97bOjkqauxiPTHgMUY9mJX+Z/
         0vHw==
X-Gm-Message-State: AJIora+YCKmrlQfexJuwoghzDTrW5NpRvih8k9udPkixgiyK0akOqP71
        ya0xsCiVKwYpJWh3fvXFHhJ2qsyc8Sk=
X-Google-Smtp-Source: AGRyM1sgF4ebfWoQ9FeZKvyO2WiDYmjbTFQReHxC2eXWqLC7KNBuhtuTlA1GGp5YBurhYg5+cIzcIg==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr19547900wmq.14.1656410382761;
        Tue, 28 Jun 2022 02:59:42 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b003a032c88877sm22411305wmq.15.2022.06.28.02.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:59:42 -0700 (PDT)
Message-ID: <a821c10b-3b55-f20a-dc4c-c5b0452d7819@gmail.com>
Date:   Tue, 28 Jun 2022 10:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-rebase.txt: use back-ticks consistently
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 27/06/2022 22:21, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> While inspecting the 'git rebase' documentation, I noticed that it is
> inconsistent with how it uses back-ticks (or other punctuation) for
> identifying Git commands, command-line arguments, or values for those
> arguments.
> 
> Sometimes, an argument (like '--interactive') would appear without any
> punctuation, causing the argument to not have any special formatting.
> Other times, arguments or 'git rebase' itself would have single-quotes
> giving a bold look (in the HTML documentation at least).
> 
> By consistently using back-ticks, these types of strings appear in a
> monospace font with special highlighting to appear more clearly as text
> that exists in a command-line invocation of a Git command.
> 
> This rather-large diff is the result of scanning git-rebase.txt and
> adding back-ticks as appropriate. Some are adding back-ticks where there
> was no punctuation. Others are replacing single quotes.
> 
> There are also a few minor cleanups in the process, such as one place
> that did not use tabs for the first paragraph in a bulletted list.
> Another case still referred to the dashed form, but it was the only use
> in the file except for the heading and NAME section.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>

Thanks for doing this, I think it's fine as a single patch as all the 
changes are focussed making the quoting more consistent in a single file 
- splitting it up would be more work for you and would not really make 
it any easier for reviewers. I've left a few comments but it is a vast 
improvement as is.

> -The current branch is reset to <upstream>, or <newbase> if the
> ---onto option was supplied.  This has the exact same effect as
> -`git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
> +The current branch is reset to `<upstream>`, or `<newbase>` if the
> +`--onto` option was supplied.  This has the exact same effect as
> +`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set

Unrelated to your change but I think we could lose the comma on this 
line if you do re-roll.

>   Note that a rebase merge works by replaying each commit from the working
> -branch on top of the <upstream> branch.  Because of this, when a merge
> +branch on top of the `<upstream>` branch.  Because of this, when a merge
>   conflict happens, the side reported as 'ours' is the so-far rebased
> -series, starting with <upstream>, and 'theirs' is the working branch.  In
> -other words, the sides are swapped.
> +series, starting with `<upstream>`, and 'theirs' is the working branch.
> +In other words, the sides are swapped.

Here when talking about "ours" and "theirs" as the parents of a merge we 
use single quotes ...

> -Because 'git rebase' replays each commit from the working branch
> -on top of the <upstream> branch using the given strategy, using
> -the 'ours' strategy simply empties all patches from the <branch>,
> +Because `git rebase` replays each commit from the working branch
> +on top of the `<upstream>` branch using the given strategy, using
> +the `ours` strategy simply empties all patches from the `<branch>`,

Here "ours" is an option argument so I think the backquotes make sense

> @@ -371,8 +371,8 @@ See also INCOMPATIBLE OPTIONS below.
>   --strategy-option=<strategy-option>::
>   	Pass the <strategy-option> through to the merge strategy.
>   	This implies `--merge` and, if no strategy has been
> -	specified, `-s ort`.  Note the reversal of 'ours' and
> -	'theirs' as noted above for the `-m` option.
> +	specified, `-s ort`.  Note the reversal of `ours` and
> +	`theirs` as noted above for the `-m` option.

Here "ours" and "theirs" are options so using backquotes is probably the 
right thing to do, but the text is referring to the section where they 
are not backquoted which confused me initially.

>   --verify::
>   	Allows the pre-rebase hook to run, which is the default.  This option can

Lower down some hook names are in double quotes which is probably a good 
idea but not strictly related to your patch.

> -apply backend: When applying a patch, ignore changes in whitespace in
> +'apply backend:' When applying a patch, ignore changes in whitespace in

I'm not sure if we want to say
     'apply backend:'
or
     'apply' backend:
>   
>   -x <cmd>::
>   --exec <cmd>::
> -	Append "exec <cmd>" after each line creating a commit in the
> -	final history. <cmd> will be interpreted as one or more shell
> +	Append `exec <cmd>` after each line creating a commit in the

Lower down when talking about other todo list commands we refer to them 
as "pick" (with double quotes) so I wonder if we should use "exec 
`<cmd>`" here as it is only <cmd> that comes from the command line argument

> -git rebase has two primary backends: apply and merge.  (The apply
> -backend used to be known as the 'am' backend, but the name led to
> -confusion as it looks like a verb instead of a noun.  Also, the merge
> +`git rebase` has two primary backends: `apply` and `merge`.  (The `apply`
> +backend used to be known as the `am` backend, but the name led to
> +confusion as it looks like a verb instead of a noun.  Also, the `merge`

I think using single quotes for the backend names might make more sense 
as they are just names.

> -When the git-rebase command is run, it will first execute a "pre-rebase"
> +When the `git rebase` command is run, it will first execute a "pre-rebase"

This is the section I was referring to earlier when talking about 
quoting hook names.

Thanks for working on this, it is great to have more consistent markup 
in the documentation

Best Wishes

Phillip
